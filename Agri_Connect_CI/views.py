from django.shortcuts import render, redirect
from django.contrib.auth import login
from django.utils import timezone
from .forms import * 
from django.contrib.auth.decorators import login_required
from django.http import Http404,JsonResponse
from django.contrib import messages
from django.template.exceptions import TemplateDoesNotExist
from django.db.models import Avg, Subquery, Prefetch, Count, Min, Sum
from django.shortcuts import render
from .models import*
from django.db.models import Q
from django.shortcuts import get_object_or_404
from django.views.decorators.http import require_POST
from datetime import timedelta
from django.core.exceptions import PermissionDenied
import logging
from django.db import transaction
from django.db.models.functions import Lower
from django.apps import apps  

logger = logging.getLogger(__name__)

def home(request):
    # Récupération du type de vente produits 
    type_vente_produits = TypeAnnonce.objects.only('id').get(id=1)
    
    # Section Produits 
    produits_recents = AnnonceProduit.objects.filter(
        annonce__statut='active',
        annonce__type_annonce=type_vente_produits
    ).select_related(
        'annonce__auteur',
        'annonce__zone',
        'categorie',
        'unite',
        'devise'
    ).prefetch_related(
        'annonce__annonceimage_set'
    ).order_by('-annonce__date_annonce')[:8]
    
    # Section Annonces
    dernieres_annonces = Annonce.objects.filter(
        statut='active'
    ).exclude(
        type_annonce=type_vente_produits
    ).select_related(
        'type_annonce',
        'auteur',
        'zone'
    ).prefetch_related(
        'annonceimage_set',
        'annonceproduit_set'
    ).order_by('-date_annonce')[:6]
    
    # Nombre de producteurs
    nb_producteurs = Producteur.objects.count()

    # Producteurs populaires
    producteurs_populaires = Producteur.objects.annotate(
        note_moyenne=Avg('notations__note')
    ).select_related('utilisateur').order_by('-note_moyenne')[:8]

    # Livreurs - logique unifiée
    livreurs_query = Livreur.objects.annotate(
        note_moyenne=Avg('miseenrelation__notation__note')
    ).select_related('utilisateur')

    livreurs_populaires = []
    if request.user.is_authenticated and hasattr(request.user, 'zone') and request.user.zone:
        # Utilisateur connecté avec zone définie
        livreurs_ville = livreurs_query.filter(
            livreurzone__zone=request.user.zone
        ).order_by('-note_moyenne')[:6]
        
        livreurs_mieux_notes = livreurs_query.order_by('-note_moyenne')[:12]
        
        # Fusion sans doublons
        livreurs_populaires = list(livreurs_mieux_notes)
        ids_presents = {l.id for l in livreurs_populaires}
        
        for livreur in livreurs_ville:
            if livreur.id not in ids_presents:
                livreurs_populaires.append(livreur)
    else:
        # Cas par défaut (non connecté ou sans zone)
        livreurs_populaires = list(livreurs_query.order_by('-note_moyenne')[:8])

    # Construction du contexte de base
    context = {
        'dernieres_annonces': dernieres_annonces,
        'produits_recents': produits_recents,
        'nb_producteurs': nb_producteurs,
        'producteurs_populaires': producteurs_populaires,
        'livreurs_populaires': livreurs_populaires[:8],  # Limite à 8 éléments
        'timezone_now': timezone.now(),
        'user_connected': request.user.is_authenticated,
    }
    
    # Ajout des informations utilisateur si connecté
    if request.user.is_authenticated:
        context.update({
            'user_role': getattr(request.user, 'role', None),
            'user_zone': getattr(request.user, 'zone', None),
            'user_notifications': Notification.objects.filter(
                utilisateur=request.user, 
                lu=False
            ).count(),
        })
    
    # Choix du template en fonction de l'état de connexion
    template_name = 'Agri_Connect_CI/links/index-connection.html' if request.user.is_authenticated else 'Agri_Connect_CI/links/index.html'
    
    return render(request, template_name, context)  
   
def page_view(request, page_name):
    """
    Vue générique pour les pages statiques.
    Format: Agri_Connect_CI/links/[page_name].html
    """
    if page_name == 'faq':
        return faq_view(request)
    
    if page_name == 'annonces':
        return annonces_view(request)
    
    if page_name == 'catalog':
        return produits_agricoles(request)
    if page_name == 'livreur':
        return  liste_livreurs(request)
   
    # Liste des pages qui ont des URLs réservées
    PAGES_RESERVEES = ['accueconnecte', 'tableau-de-bord-producteur', 'tableau-de-bord-livreur']
    
    if page_name in PAGES_RESERVEES:
        raise Http404("Page non trouvée")
    
    try:
        return render(request, f'Agri_Connect_CI/links/{page_name}.html')
    except TemplateDoesNotExist:
        raise Http404("Cette page n'existe pas")

def inscription(request):
    if request.method == 'POST':
        form = InscriptionForm(request.POST)
        if form.is_valid():
            user = form.save()
            
            login(request, user)
            messages.success(request, "Inscription réussie! Bienvenue sur AgriConnect.")
            return redirect('home_connected')
        else:
            # Afficher les erreurs de formulaire
            for field, errors in form.errors.items():
                for error in errors:
                    messages.error(request, f"{field}: {error}")
    else:
        form = InscriptionForm()
    
    return render(request, 'Agri_Connect_CI/register/register.html', {
        'form': form
    })


def connexion(request):
    if request.method == 'POST':
        form = ConnexionForm(request, data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            user.derniere_connexion = timezone.now()
            user.save()
            
            messages.success(request, f"Bienvenue {user.username} !")
            return redirect('home_connected')  # Redirection unique vers home_connected
            
        messages.error(request, "Identifiants incorrects")
    
    return render(request, 'Agri_Connect_CI/register/login.html', {'form': ConnexionForm(request)})



from django.contrib.auth import logout

def deconnexion(request):
    logout(request)
    messages.success(request, "Vous avez été déconnecté avec succès.")
    return redirect('home')

@login_required
def contacter_via_whatsapp(request, annonce_id):
    annonce = get_object_or_404(Annonce, id=annonce_id)
    
    # Récupérer spécifiquement le contact WhatsApp (type_contact_id=3)
    contact_whatsapp = Contact.objects.filter(
        utilisateur=annonce.auteur,
        type_contact_id=3  # ID du type WhatsApp
    ).first()
    
    if contact_whatsapp:
        # Créer la mise en relation
        MiseEnRelation.objects.create(
            client=request.user,
            livreur=annonce.auteur.livreur if hasattr(annonce.auteur, 'livreur') else None,
            producteur=annonce.auteur.producteur if hasattr(annonce.auteur, 'producteur') else None,
            moyen_contact_id=3  # ID du type WhatsApp
        )
        
        return redirect(f'https://wa.me/{contact_whatsapp.valeur}?text=Bonjour, je suis intéressé par votre annonce: {annonce.titre}')
    else:
        messages.error(request, "Le contact WhatsApp n'est pas disponible pour cet utilisateur.")
        return redirect('annonce_detail', annonce_id=annonce.id)

@login_required
def toggle_favori(request, annonce_id):
    annonce = get_object_or_404(Annonce, id=annonce_id)
    favori, created = Favoris.objects.get_or_create(
        utilisateur=request.user,
        annonce=annonce
    )
    
    if not created:
        favori.delete()
        return JsonResponse({'status': 'removed'})
    
    return JsonResponse({'status': 'added'})    

@login_required
@require_POST
def noter_producteur(request, producteur_id):
    producteur = get_object_or_404(Producteur, id=producteur_id)
    annonce_id = request.POST.get('annonce_id')
    
    # Vérification a posteriori de la mise en relation
    if not MiseEnRelation.objects.filter(client=request.user, producteur=producteur).exists():
        messages.error(request, "Vous devez avoir effectué un achat chez ce producteur pour pouvoir le noter.")
        return redirect('annonce_detail', annonce_id=annonce_id)
    
    note = request.POST.get('note')
    commentaire = request.POST.get('commentaire', '').strip()
    
    if not note or not note.isdigit() or int(note) < 1 or int(note) > 5:
        messages.error(request, "Veuillez donner une note valide entre 1 et 5 étoiles.")
        return redirect('annonce_detail', annonce_id=annonce_id)
    
    # Trouver la mise en relation
    mise_en_relation = MiseEnRelation.objects.get(client=request.user, producteur=producteur)
    
    # Créer ou mettre à jour la notation
    notation, created = Notation.objects.update_or_create(
        evaluateur=request.user,
        producteur=producteur,
        mise_en_relation=mise_en_relation,
        defaults={
            'note': note,
            'commentaire': commentaire,
            'contexte': 'produit'
        }
    )
    
    messages.success(request, "Votre évaluation a bien été enregistrée." if created else "Votre évaluation a été mise à jour.")
    return redirect('annonce_detail', annonce_id=annonce_id)
    

def annonce_detail(request, annonce_id):
    # Récupération de l'annonce avec toutes les relations nécessaires
    annonce = get_object_or_404(
        Annonce.objects.select_related(
            'auteur', 
            'zone', 
            'type_annonce'
        ).prefetch_related(
            Prefetch('annonceimage_set', queryset=AnnonceImage.objects.all()),
            Prefetch('annonceproduit_set', queryset=AnnonceProduit.objects.select_related(
                'categorie', 'unite', 'devise'
            )),
            Prefetch('auteur__contact_set', queryset=Contact.objects.select_related('type_contact'))
        ),
        id=annonce_id,
        statut='active'
    )

    # Correction des fautes de frappe dans les noms de variables
    produit = annonce.annonceproduit_set.first()
    
    # Récupération des annonces similaires
    annonces_similaires = Annonce.objects.filter(
        annonceproduit__categorie=produit.categorie,  # Correction: annonceproduit -> annonceproduit
        statut='active'
    ).exclude(
        id=annonce.id
    ).select_related(
        'auteur', 'zone'
    ).prefetch_related(
        Prefetch('annonceimage_set', queryset=AnnonceImage.objects.all()),
        Prefetch('annonceproduit_set', queryset=AnnonceProduit.objects.all())
    ).distinct()[:4]

    # Préparation des données pour le template
    annonces_similaires_prepared = []
    for annonce_sim in annonces_similaires:
        annonce_sim.first_image = annonce_sim.annonceimage_set.first()
        annonce_sim.first_product = annonce_sim.annonceproduit_set.first()
        annonces_similaires_prepared.append(annonce_sim)

    # Notation - calcul de la moyenne et du nombre d'avis
    note_moyenne = 0
    nb_avis = 0
    notations = []

    if hasattr(annonce.auteur, 'producteur'):
        # Calcul de la note moyenne et du nombre d'avis
        stats = Notation.objects.filter(
            producteur=annonce.auteur.producteur
        ).aggregate(
            moyenne=Avg('note'),
            total=Count('id')
        )
        note_moyenne = stats['moyenne'] or 0
        nb_avis = stats['total'] or 0

        # Récupération des 10 dernières notations
        notations = Notation.objects.filter(
            producteur=annonce.auteur.producteur
        ).select_related('evaluateur').order_by('-date_creation')[:10]

    # Vérification si l'annonce est en favoris
    est_favori = False
    if request.user.is_authenticated:
        est_favori = Favoris.objects.filter(
            utilisateur=request.user,
            annonce=annonce
        ).exists()

    # Vérification si l'utilisateur peut noter
    peut_noter = False
    note_existante = None
    
  
    if request.user.is_authenticated and hasattr(annonce.auteur, 'producteur'):
        peut_noter = MiseEnRelation.objects.filter(
            client=request.user,
            producteur=annonce.auteur.producteur
        ).exists()
        
        note_existante = Notation.objects.filter(
            evaluateur=request.user,
            producteur=annonce.auteur.producteur
        ).first()

    # Récupérer le contact WhatsApp
    whatsapp_contact = annonce.auteur.contact_set.filter(type_contact_id=3).first()
    
    # Construction du contexte
    context = {
        'annonce': annonce,
        'produit': produit,
        'images': annonce.annonceimage_set.all(),
        'utilisateur': annonce.auteur,
        'zone': annonce.zone,
        'whatsapp_contact': whatsapp_contact,
        'note_moyenne': note_moyenne,
        'nb_avis': nb_avis,
        'note_etoiles': range(1, 6),
        'annonces_similaires': annonces_similaires_prepared,  # Utilisation de la version préparée
        'notations': notations,
        'est_favori': est_favori,
        'peut_noter': peut_noter,
        'note_existante': note_existante,
        'user_connected': request.user.is_authenticated
    }
    
    return render(request, 'Agri_Connect_CI/page-details/detailsproduit.html', context)

@login_required
@require_POST
def supprimer_notation(request, notation_id):
    notation = get_object_or_404(Notation, id=notation_id, evaluateur=request.user)
    annonce_id = request.POST.get('annonce_id') or request.GET.get('annonce_id')
    notation.delete()
    messages.success(request, "Votre évaluation a été supprimée.")
    return redirect('annonce_detail', annonce_id=annonce_id)


def producteur_detail(request, producteur_id):
    # Récupération du producteur avec toutes les relations nécessaires
    producteur = get_object_or_404(
        Producteur.objects.select_related('utilisateur'),
        id=producteur_id
    )

    # Récupération des annonces actives du producteur via l'utilisateur
    annonces = Annonce.objects.filter(
        auteur=producteur.utilisateur,
        statut='active'
    ).prefetch_related(
        Prefetch('annonceproduit_set', 
            queryset=AnnonceProduit.objects.select_related('categorie', 'unite', 'devise')
        ),
        'annonceimage_set'
    ).order_by('-date_annonce')

    # Récupération des contacts
    contacts = Contact.objects.filter(utilisateur=producteur.utilisateur).select_related('type_contact')

    # Calcul de la note moyenne et du nombre d'avis
    stats = Notation.objects.filter(producteur=producteur).aggregate(
        moyenne=Avg('note'),
        total=Count('id')
    )
    note_moyenne = stats['moyenne'] or 0
    nb_avis = stats['total'] or 0

    # Récupération des 10 dernières notations
    notations = Notation.objects.filter(
        producteur=producteur
    ).select_related('evaluateur').order_by('-date_creation')[:10]

    # Récupération des catégories de produits distinctes
    categories = CategorieProduit.objects.filter(
        annonceproduit__annonce__auteur=producteur.utilisateur
    ).distinct()

    # Calcul des années d'expérience
    years_experience = timezone.now().year - producteur.annee_debut

    # Préparation des données pour le template
    context = {
        'producteur': producteur,
        'note_moyenne': note_moyenne,
        'nb_avis': nb_avis,
        'note_etoiles': range(1, 6),
        'notations': notations,
        'categories': categories,
        'annonces': annonces,
        'contacts': contacts,
        'whatsapp_contact': contacts.filter(type_contact__nom='WhatsApp').first(),
        'years_experience': years_experience,
        'user_connected': request.user.is_authenticated,
    }

    return render(request, 'Agri_Connect_CI/page-details/producteur-details.html', context)


def livreur_detail(request, livreur_id):
    # Récupération du livreur avec toutes les relations nécessaires
    livreur = get_object_or_404(
        Livreur.objects.select_related('utilisateur', 'tarif', 'tarif__devise', 'type_livreur')
        .prefetch_related(
            'livreurzone_set__zone',
            'vehicule_set',
            'livreurmoyentransport_set__moyen_transport',  # Ajouté pour les moyens de transport
            'notations__evaluateur',
            'disponibilitelivreur_set'
        ),
        id=livreur_id
    )

    # Récupération des contacts
    contacts = Contact.objects.filter(utilisateur=livreur.utilisateur).select_related('type_contact')

    # Calcul de la note moyenne et du nombre d'avis
    stats = Notation.objects.filter(livreur=livreur).aggregate(
        moyenne=Avg('note'),
        total=Count('id')
    )
    note_moyenne = stats['moyenne'] or 0
    nb_avis = stats['total'] or 0

    # Récupération des 5 dernières notations
    notations = livreur.notations.all().select_related('evaluateur').order_by('-date_creation')[:5]

    # Récupération des zones desservies
    zones = livreur.livreurzone_set.all().select_related('zone')

    # Récupération des véhicules
    vehicules = livreur.vehicule_set.all()

    # Récupération des moyens de transport associés au livreur
    moyens_transport = livreur.livreurmoyentransport_set.select_related('moyen_transport').all()

    # Récupération des disponibilités
    jours_semaine = ['lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi', 'dimanche']
    disponibilites = {}
    for jour in jours_semaine:
        dispo = livreur.disponibilitelivreur_set.filter(jour_semaine=jour).order_by('-date_debut').first()
        disponibilites[jour] = dispo.statut if dispo else 'indisponible'
 
 # Vérification si l'utilisateur peut noter
    peut_noter = False
    note_existante = None
    
    if request.user.is_authenticated:
        peut_noter = MiseEnRelation.objects.filter(
            client=request.user,
            livreur=livreur
        ).exists()
        
        note_existante = Notation.objects.filter(
            evaluateur=request.user,
            livreur=livreur
        ).first()

    # Préparation des données pour le template
    context = {
        'livreur': livreur,
        'note_moyenne': note_moyenne,
        'nb_avis': nb_avis,
        'note_etoiles': range(1, 6),
        'notations': notations,
        'zones': zones,
        'vehicules': vehicules,
        'moyens_transport': moyens_transport,
        'disponibilites': disponibilites,
        'contacts': contacts,
        'whatsapp_contact': contacts.filter(type_contact__nom='WhatsApp').first(),
        'user_connected': request.user.is_authenticated,
        'is_entreprise': livreur.type_livreur.nom == 'Entreprise',
        'peut_noter': peut_noter,
        'note_existante': note_existante,
    }

    return render(request, 'Agri_Connect_CI/page-details/details-livreurs.html', context)

@login_required
@require_POST
def noter_livreur(request, livreur_id):
    livreur = get_object_or_404(Livreur, id=livreur_id)
    
    try:
        # Récupérer la dernière mise en relation
        mise_en_relation = MiseEnRelation.objects.filter(
            client=request.user,
            livreur=livreur
        ).latest('date_contact')
        
        note = request.POST.get('note')
        if not note or not note.isdigit() or int(note) < 1 or int(note) > 5:
            messages.error(request, "Veuillez donner une note valide entre 1 et 5 étoiles.")
            return redirect('livreur_detail', livreur_id=livreur.id)
        
        commentaire = request.POST.get('commentaire', '').strip()
        
        # Créer ou mettre à jour la notation
        notation, created = Notation.objects.update_or_create(
            evaluateur=request.user,
            livreur=livreur,
            mise_en_relation=mise_en_relation,
            defaults={
                'note': note,
                'commentaire': commentaire,
                
            }
        )
        
        if created:
            messages.success(request, "✅ Votre évaluation a bien été enregistrée.")
        else:
            messages.success(request, "🔄 Votre évaluation a été mise à jour.")
            
    except MiseEnRelation.DoesNotExist:
        messages.error(request, "❌ Vous devez avoir contacté ce livreur pour pouvoir le noter.")
    except Exception as e:
        messages.error(request, f"❌ Une erreur est survenue: {str(e)}")
    
    return redirect('livreur_detail', livreur_id=livreur.id)

@login_required
@require_POST
def supprimer_notation_livreur(request, livreur_id):
    livreur = get_object_or_404(Livreur, id=livreur_id)
    Notation.objects.filter(evaluateur=request.user, livreur=livreur).delete()
    messages.success(request, "Votre évaluation a été supprimée.")
    return redirect('livreur_detail', livreur_id=livreur.id)

@login_required
def contacter_livreur_whatsapp(request, livreur_id):
    livreur = get_object_or_404(Livreur, id=livreur_id)
    whatsapp_contact = Contact.objects.filter(
        utilisateur=livreur.utilisateur,
        type_contact__nom='WhatsApp'
    ).first()
    
    if whatsapp_contact:
        # Créer la mise en relation
        MiseEnRelation.objects.create(
            client=request.user,
            livreur=livreur,
            moyen_contact=whatsapp_contact.type_contact
        )
        
        return redirect(f'https://wa.me/{whatsapp_contact.valeur}')
    else:
        messages.error(request, "Le contact WhatsApp n'est pas disponible pour ce livreur.")
        return redirect('livreur_detail', livreur_id=livreur.id)
    





def produits_agricoles(request):
    # Dictionnaire de mapping pour les options de tri
    ORDER_MAPPING = {
        'recent': '-annonce__date_annonce',
        'ancien': 'annonce__date_annonce',
        'prix-croissant': 'prix_unitaire',
        'prix-dec': '-prix_unitaire',
    }

    # Récupération du paramètre de tri (avec valeur par défaut)
    sort_key = request.GET.get('tri', 'recent')
    order_field = ORDER_MAPPING.get(sort_key, '-annonce__date_annonce')

    # Requête de base avec le tri
    produits = AnnonceProduit.objects.filter(
        annonce__statut='active',
        annonce__type_annonce=1
    ).select_related(
        'annonce__auteur',
        'annonce__zone',
        'categorie',
        'unite',
        'devise',
        'conditionnement',
        'certification'
    ).prefetch_related(
        'annonce__annonceimage_set'
    ).order_by(order_field)  # Application du tri

    # Gestion des filtres (existant)
    categorie_filter = request.GET.get('categorie')
    if categorie_filter:
        produits = produits.filter(categorie_id=categorie_filter)

    localisation_filter = request.GET.get('localisation')
    if localisation_filter:
        produits = produits.filter(annonce__zone__ville=localisation_filter)

    # Gestion de la recherche
    search_term = request.GET.get('search')
    if search_term:
        produits = produits.filter(
            Q(nom_produit__icontains=search_term) |
            Q(annonce__description__icontains=search_term) |
            Q(annonce__titre__icontains=search_term)
        )

    # Contexte
    context = {
        'produits': produits,
        'producteurs': Producteur.objects.annotate(
            note_moyenne=Avg('notations__note')
        ).select_related('utilisateur').order_by('-note_moyenne')[:8],
        'categories': CategorieProduit.objects.all(),
        'zones': Zone.objects.values('ville').distinct(),
        'conditionnements': Conditionnement.objects.all(),
        'current_sort': sort_key,  # Pour garder le tri sélectionné
        'produits_count': produits.count(),
        'user_connected': request.user.is_authenticated
    }

    return render(request, 'Agri_Connect_CI/links/catalog.html', context)



def faq_view(request):
    # Récupérer toutes les questions par catégorie
    faqs = {
        'general': FAQ.objects.filter(categorie='general').order_by('ordre_affichage'),
        'acheteur': FAQ.objects.filter(categorie='acheteur').order_by('ordre_affichage'),
        'producteur': FAQ.objects.filter(categorie='producteur').order_by('ordre_affichage'),
        'livreur': FAQ.objects.filter(categorie='livreur').order_by('ordre_affichage'),
    }
    
    return render(request, 'Agri_Connect_CI/links/faq.html', {
        'faqs': faqs,
        'user_connected': request.user.is_authenticated
    })



def annonces_view(request):
    """Sous-fonction dédiée à la gestion des annonces"""
    # Récupération du type de vente produits à exclure
    type_vente_produits = TypeAnnonce.objects.only('id').get(id=1)
    
    # Récupération des annonces actives (sauf vente de produits)
    annonces_list = Annonce.objects.filter(
        statut='active'
    ).exclude(
        type_annonce=type_vente_produits
    ).select_related(
        'type_annonce',
        'auteur',
        'zone'
    ).prefetch_related(
        Prefetch('annonceimage_set', queryset=AnnonceImage.objects.all()),
        Prefetch('annonceproduit_set', queryset=AnnonceProduit.objects.select_related('unite', 'devise'))
    ).order_by('-date_annonce')


    category_filter = request.GET.get('filter-category', 'all')
    if category_filter != 'all':
        annonces_list = annonces_list.filter(type_annonce__nom__iexact=category_filter)

    location_filter = request.GET.get('filter-location', 'all')
    if location_filter != 'all':
        annonces_list = annonces_list.filter(zone__ville__iexact=location_filter)

    sort_filter = request.GET.get('filter-sort', 'recent')
    if sort_filter == 'ancien':
        annonces_list = annonces_list.order_by('date_annonce')
    elif sort_filter == 'prix-asc':
        annonces_list = annonces_list.annotate(
            min_price=Min('annonceproduit__prix_unitaire')
        ).order_by('min_price')
    elif sort_filter == 'prix-desc':
        annonces_list = annonces_list.annotate(
            min_price=Min('annonceproduit__prix_unitaire')
        ).order_by('-min_price')

    # Types d'annonces pour le filtre
    types_annonce = TypeAnnonce.objects.exclude(id=1).all()
    
    # Villes disponibles pour le filtre
    villes = Zone.objects.values_list('ville', flat=True).distinct()

    context = {
        'annonces': annonces_list,
        'types_annonce': types_annonce,
        'villes': villes,
        'current_category': category_filter,
        'current_location': location_filter,
        'current_sort': sort_filter,
        'user_connected': request.user.is_authenticated
    }
    
    return render(request, 'Agri_Connect_CI/links/annonces.html', context)




def liste_livreurs(request):
    # Récupération des filtres depuis la requête GET
    type_vehicule_filter = request.GET.getlist('type_vehicule')
    zones_filter = request.GET.getlist('zones')
    capacites_filter = request.GET.getlist('capacites')
    disponible_filter = request.GET.get('disponible') == 'on'
    tri = request.GET.get('tri', 'note_desc')
    tab = request.GET.get('tab', 'all')

    # Gestion de la valeur 'all'
    if 'all' in type_vehicule_filter:
        type_vehicule_filter = []
    if 'all' in zones_filter:
        zones_filter = []
    if 'all' in capacites_filter:
        capacites_filter = []

    # Initialisation du queryset
    livreurs = Livreur.objects.select_related(
        'utilisateur', 'type_livreur', 'tarif', 'tarif__devise', 'etat'
    ).prefetch_related(
        'livreurzone_set', 'livreurzone_set__zone', 'vehicule_set'
    ).annotate(
        note_moyenne=Avg('notations__note'),
        nb_avis=Count('notations')
    )

    # Application des filtres
    if type_vehicule_filter:
        livreurs = livreurs.filter(vehicule__type__in=type_vehicule_filter).distinct()
    
    if zones_filter:
        livreurs = livreurs.filter(livreurzone__zone_id__in=zones_filter).distinct()
    
    if capacites_filter:
        livreurs = livreurs.filter(vehicule__capacite__in=capacites_filter).distinct()
    
    if disponible_filter:
         livreurs = livreurs.filter(etat__nom__iexact='disponible')

   

    # Application du tri
    if tri == 'note_desc':
        livreurs = livreurs.order_by('-note_moyenne')
    elif tri == 'tarif_asc':
        livreurs = livreurs.order_by('tarif__valeur')
    elif tri == 'tarif_desc':
        livreurs = livreurs.order_by('-tarif__valeur')
    elif tri == 'activite_desc':
        livreurs = livreurs.order_by('-utilisateur__derniere_connexion')

    # Préparation des données pour les filtres
    types_vehicule = Vehicule.objects.values_list('type', flat=True).distinct()
    zones_couverture = Zone.objects.all()
    capacites = CapaciteVehicule.objects.all().order_by('valeur')

    # Création d'un dictionnaire des zones pour le filtre get_item
    zones_dict = {zone.id: zone for zone in zones_couverture}

    # Récupération des contacts WhatsApp
    for livreur in livreurs:
        contact_whatsapp = livreur.utilisateur.contact_set.filter(type_contact__nom='WhatsApp').first()
        livreur.contact_whatsapp = contact_whatsapp

    context = {
        'livreurs': livreurs,
        'types_vehicule': types_vehicule,
        'zones_couverture': zones_couverture,
        'zones_dict': zones_dict,  # Pour le filtre get_item
        'capacites': capacites,
        'filtres_actifs': {
            'type_vehicule': type_vehicule_filter,
            'zones': zones_filter,
            'capacites': capacites_filter,
            'disponible': disponible_filter,
        },
        'tri_actif': tri,
        'tab_actif': tab,
        'livreurs_count': livreurs.count(),
    }

    return render(request, 'Agri_Connect_CI/links/livreur.html', context)



@login_required
def tableau_de_bord_acheteur(request):

    if request.user.role != 'acheteur':
        return redirect('home')

    if request.method == 'POST':
        form = ProfileForm(request.POST, request.FILES, instance=request.user)
        if form.is_valid():
            form.save()
            messages.success(request, "Profil mis à jour avec succès")
            return redirect('tableau_de_bord_acheteur')
    else:
        form = ProfileForm(instance=request.user)

    # Récupérer les informations de l'utilisateur
    user = request.user
    
    # Récupérer les contacts de l'utilisateur
    contacts = Contact.objects.filter(utilisateur=user).select_related('type_contact')
    
    # Récupérer les mises en relation
    mises_en_relation = MiseEnRelation.objects.filter(client=user).select_related(
        'livreur', 'livreur__utilisateur', 'producteur', 'producteur__utilisateur'
    ).order_by('-date_contact')[:10]
    
    # Récupérer les favoris
    favoris = Favoris.objects.filter(utilisateur=user).select_related(
        'annonce', 'annonce__auteur'
    ).prefetch_related(
        'annonce__annonceproduit_set', 'annonce__annonceimage_set'
    )[:8]
    
    # Récupérer les annonces de l'utilisateur
    mes_annonces = Annonce.objects.filter(auteur=user).select_related(
        'type_annonce', 'zone'
    ).prefetch_related(
        'annonceproduit_set', 'annonceimage_set'
    ).order_by('-date_annonce')
    
    # Statistiques
    stats = {
        'mises_en_relation': MiseEnRelation.objects.filter(client=user).count(),
        'favoris': Favoris.objects.filter(utilisateur=user).count(),
        'notations': Notation.objects.filter(evaluateur=user).count(),
    }
    
    context = {
        'user': user,
        'contacts': contacts,
        'mises_en_relation': mises_en_relation,
        'favoris': favoris,
        'mes_annonces': mes_annonces,
        'stats': stats,
        'form': form,
    }
    
    return render(request, 'Agri_Connect_CI/tableau_de_bord/tableau-de-bord-acheteur.html', context)

@login_required
def tableau_bord_producteur(request):
    # Vérification du rôle
    if not hasattr(request.user, 'role') or request.user.role != 'producteur':
        return redirect('home')

    # Récupérer le type de vente produits (id=1)
    type_vente_produits = TypeAnnonce.objects.only('id').get(id=1)
    
    # Récupérer les annonces (tout sauf type_vente_produits)
    mes_annonces = Annonce.objects.filter(auteur=request.user)\
        .exclude(type_annonce=type_vente_produits)\
        .select_related('type_annonce', 'zone')\
        .prefetch_related('annonceproduit_set', 'annonceimage_set')\
        .order_by('-date_annonce')
    
    # Récupérer les produits (uniquement type_vente_produits)
    mes_produits = AnnonceProduit.objects.filter(annonce__auteur=request.user)\
        .filter(annonce__type_annonce=type_vente_produits)\
        .select_related('annonce', 'categorie', 'unite', 'devise')\
        .prefetch_related('annonce__annonceimage_set')\
        .order_by('-annonce__date_annonce')
    
    # Récupérer le producteur
    producteur = request.user.producteur
    
    context = {
        'user': request.user,
        'producteur': producteur,
        'annonces': mes_annonces,  # Pour la section Mes annonces
        'produits': mes_produits,  # Pour la section Mes produits
        'contacts': Contact.objects.filter(utilisateur=request.user).select_related('type_contact'),
        'mises_en_relation': MiseEnRelation.objects.filter(producteur=producteur)
                            .select_related('client', 'annonce')
                            .order_by('-date_contact')[:10],
        'stats': {
            'annonces_actives': Annonce.objects.filter(auteur=request.user, statut='active').count(),
            'note_moyenne': producteur.moyenne_notes(),
            'mises_en_relation': MiseEnRelation.objects.filter(producteur=producteur).count(),
            'produits': mes_produits.count(),  # Nombre de produits
        }
    }
    
    return render(request, 'Agri_Connect_CI/tableau_de_bord/tableau-de-bord-producteur.html', context)

@login_required
def tableau_bord_livreur(request):
    # Même structure que pour l'acheteur
    if request.user.role != 'livreur':
        return redirect('home')

  

    livreur = request.user.livreur
    
    # Filtre des annonces comme pour l'acheteur
    annonce_filter = request.GET.get('filter', 'all')
    annonces = Annonce.objects.filter(auteur=request.user)
    
    if annonce_filter == 'active':
        annonces = annonces.filter(statut='active', date_annonce__gte=timezone.now() - timedelta(days=30))
    elif annonce_filter == 'expired':
        annonces = annonces.filter(Q(statut='expired') | Q(date_annonce__lt=timezone.now() - timedelta(days=30)))

    context = {
        'user': request.user,
        'livreur': livreur,
        'annonces': annonces,
        'annonces_actives': Annonce.objects.filter(
            auteur=request.user, statut='active',
            date_annonce__gte=timezone.now() - timedelta(days=30)).count(),
        'livraisons_completees': MiseEnRelation.objects.filter(
            livreur=livreur, notation__isnull=False).count(),
        'mises_en_relation': MiseEnRelation.objects.filter(livreur=livreur)
                            .select_related('client', 'producteur')
                            .order_by('-date_contact')[:5],
        'notifications': Notification.objects.filter(utilisateur=request.user)
                          .order_by('-date_envoi')[:10],
    }
    
    return render(request, 'Agri_Connect_CI/tableau_de_bord/tableau-de-bord-livreur.html', context)



@login_required
def creer_annonce(request):
    default_tab = request.GET.get('tab', 'produit' if request.user.role == 'producteur' else 'autre')

    # Données nécessaires pour les formulaires
    categories = CategorieProduit.objects.all()
    unites = UniteMesure.objects.all()
    devises = Devise.objects.all()
    conditionnements = Conditionnement.objects.all()
    certifications = Certification.objects.all()
    other_types = TypeAnnonce.objects.exclude(nom__icontains='produit')
    
    if request.method == 'POST':
        form_type = request.POST.get('form_type')
        
        # Mode confirmation après prévisualisation
        if request.POST.get('confirm') == '1':
            # Récupérer les données de la session
            session_data = request.session.get('form_data', {})
            form_type = request.session.get('form_type')
            
            # Créer une copie mutable du POST
            mutable_post = request.POST.copy()
            
            # Mettre à jour avec les données de la session
            for key, value in session_data.items():
                if key not in mutable_post:
                    mutable_post[key] = value
            
            request.POST = mutable_post
            
            # Les fichiers doivent être retéléchargés par l'utilisateur
            # On ne peut pas les récupérer depuis la session

        if form_type == 'produit' and request.user.role == 'producteur':
            # Validation des champs produit
            produit_id = request.POST.get('produit_id')
            nom_produit = request.POST.get('nom_produit')
            
            if not nom_produit:
                messages.error(request, "Vous devez sélectionner ou saisir un produit")
                return redirect('create_annonce')
            
            try:
                with transaction.atomic():
                    # Création de l'annonce
                    annonce = Annonce(
                        auteur=request.user,
                        type_annonce=TypeAnnonce.objects.get(nom__icontains='produit'),
                        titre=request.POST.get('titre'),
                        description=request.POST.get('description'),
                        zone=request.user.zone,
                        statut='active'
                    )
                    annonce.save()
                    
                    # Création du produit associé
                    produit = AnnonceProduit(
                        annonce=annonce,
                        nom_produit=nom_produit,
                        categorie_id=request.POST.get('categorie_id'),
                        unite_id=request.POST.get('unite_mesure'),
                        quantite=request.POST.get('quantite'),
                        prix_unitaire=request.POST.get('prix_unitaire'),
                        devise_id=request.POST.get('devise'),
                        conditionnement_id=request.POST.get('conditionnement') or None,
                        certification_id=request.POST.get('certification') or None,
                        livraison_disponible=request.POST.get('livraison_disponible', '0') == '1'
                    )
                    produit.save()
                    
                    # Gestion des images (1 à 3)
                    for i in range(1, 4):
                        image_field = f'image{i}'
                        if image_field in request.FILES:
                            image_instance = AnnonceImage(
                                annonce=annonce, 
                                url_image=request.FILES[image_field]
                            )
                            image_instance.save()
                    
                    # Nettoyer la session après succès
                    if 'form_data' in request.session:
                        del request.session['form_data']
                    if 'form_type' in request.session:
                        del request.session['form_type']
                    if 'files' in request.session:
                        del request.session['files']
                    
                    messages.success(request, "Votre annonce produit a été publiée avec succès!")
                    return redirect('tableau_bord_producteur')
                    
            except Exception as e:
                messages.error(request, f"Une erreur est survenue lors de la création: {str(e)}")
                return redirect('create_annonce')
                
        elif form_type == 'autre':
            try:
                annonce = Annonce(
                    auteur=request.user,
                    type_annonce_id=request.POST.get('type_annonce_id'),
                    titre=request.POST.get('titre'),
                    description=request.POST.get('description'),
                    zone=request.user.zone,
                    statut='active'
                )
                annonce.save()
                
                # Gestion des images (1 à 3)
                for i in range(1, 4):
                    image_field = f'image{i}'
                    if image_field in request.FILES:
                        AnnonceImage.objects.create(
                            annonce=annonce, 
                            url_image=request.FILES[image_field]
                        )
                
                # Nettoyer la session après succès
                if 'form_data' in request.session:
                    del request.session['form_data']
                if 'form_type' in request.session:
                    del request.session['form_type']
                if 'files' in request.session:
                    del request.session['files']
                
                messages.success(request, "Votre annonce a été publiée avec succès!")
                return redirect('tableau_de_bord')
                
            except Exception as e:
                messages.error(request, f"Erreur lors de la création: {str(e)}")
                return redirect('create_annonce')
        else:
            # Mode prévisualisation - sauvegarder les données en session
            request.session['form_data'] = request.POST.dict()
            request.session['form_type'] = form_type
            
            # Sauvegarder seulement les noms des fichiers pour référence
            request.session['files'] = {
                f'image{i}': request.FILES.get(f'image{i}').name 
                for i in range(1, 4) if request.FILES.get(f'image{i}')
            }
            
            # Ne pas stocker les fichiers eux-mêmes dans la session
    
    context = {
        'categories': categories,
        'unites': unites,
        'devises': devises,
        'conditionnements': conditionnements,
        'certifications': certifications,
        'other_types': other_types,
        'is_producteur': request.user.role == 'producteur',
        'default_tab': default_tab
    }
    
    return render(request, 'Agri_Connect_CI/register/editer-produit.html', context)

def produits_par_categorie(request):
    categorie_id = request.GET.get('categorie_id')
    if not categorie_id:
        return JsonResponse([], safe=False)
    
    # Récupère les noms de produits distincts pour cette catégorie
    produits = AnnonceProduit.objects.filter(
        categorie_id=categorie_id
    ).values('nom_produit').annotate(
        count=Count('id')
    ).order_by('nom_produit')
    
    # Formatte les résultats pour avoir id et nom_produit
    results = [{
        'id': idx, 
        'nom_produit': p['nom_produit']
    } for idx, p in enumerate(produits, start=1)]
    
    return JsonResponse(results, safe=False)


def autocomplete_produits(request):
    term = request.GET.get('term', '')
    categorie_id = request.GET.get('categorie_id')
    
    queryset = AnnonceProduit.objects.annotate(
        lower_nom=Lower('nom_produit')
    ).filter(
        lower_nom__icontains=term.lower()
    )
    
    if categorie_id:
        queryset = queryset.filter(categorie_id=categorie_id)
    
    produits = queryset.values_list(
        'nom_produit', flat=True
    ).distinct().order_by('lower_nom')[:10]
    
    return JsonResponse(list(produits), safe=False)



@login_required
def ajouter_favori(request, annonce_id):
    annonce = get_object_or_404(Annonce, id=annonce_id)
    Favoris.objects.get_or_create(utilisateur=request.user, annonce=annonce)
    messages.success(request, "Ajouté aux favoris")
    return redirect(request.META.get('HTTP_REFERER', 'tableau_de_bord_acheteur'))

@login_required
def supprimer_favori(request, annonce_id):
    Favoris.objects.filter(utilisateur=request.user, annonce_id=annonce_id).delete()
    messages.success(request, "Retiré des favoris")
    return redirect(request.META.get('HTTP_REFERER', 'tableau_de_bord_acheteur'))

@login_required
def supprimer_annonce(request, annonce_id):
    annonce = get_object_or_404(Annonce, id=annonce_id, auteur=request.user)
    annonce.delete()
    messages.success(request, "Annonce supprimée avec succès")
    return redirect('tableau_de_bord_acheteur')

@login_required
@require_POST
def republier_annonce(request, annonce_id):
    annonce = get_object_or_404(Annonce, id=annonce_id, auteur=request.user)
    
    if annonce.statut != 'active':
        messages.error(request, "Seules les annonces actives peuvent être republiées")
    else:
        annonce.republier()
        messages.success(request, "Annonce republiée avec succès ! Elle apparaîtra maintenant dans les annonces récentes.")
    
    return redirect('tableau_de_bord_acheteur')



@require_POST
@login_required
def update_livreur_statut(request):
    livreur = get_object_or_404(Livreur, utilisateur=request.user)
    statut = request.POST.get('statut')
    
    try:
        etat = EtatLivreur.objects.get(nom=statut)
        livreur.etat = etat
        livreur.save()
        messages.success(request, f"Statut mis à jour : {statut}")
    except EtatLivreur.DoesNotExist:
        messages.error(request, "Statut invalide")
    except Exception as e:
        messages.error(request, f"Erreur lors de la mise à jour : {str(e)}")
    
    return redirect('tableau_de_bord', role='livreur')

@login_required
def creer_annonce_livreur(request):
    if request.method == 'POST':
        form = AnnonceLivreurForm(request.POST)
        if form.is_valid():
            annonce = form.save(commit=False)
            annonce.auteur = request.user
            annonce.type_annonce_id = 2  # ID pour les annonces de livraison
            annonce.save()
            messages.success(request, "Annonce créée avec succès")
            return redirect('tableau_de_bord', role='livreur')
    else:
        form = AnnonceLivreurForm()
    
    return render(request, 'Agri_Connect_CI/annonces/creer_annonce_livreur.html', {'form': form})

@login_required
def modifier_annonce_livreur(request, annonce_id):
    annonce = get_object_or_404(Annonce, id=annonce_id, auteur=request.user)
    
    if request.method == 'POST':
        form = AnnonceLivreurForm(request.POST, instance=annonce)
        if form.is_valid():
            form.save()
            messages.success(request, "Annonce mise à jour avec succès")
            return redirect('tableau_de_bord', role='livreur')
    else:
        form = AnnonceLivreurForm(instance=annonce)
    
    return render(request, 'Agri_Connect_CI/annonces/modifier_annonce_livreur.html', {'form': form, 'annonce': annonce})

@require_POST
@login_required
def supprimer_annonce_livreur(request, annonce_id):
    annonce = get_object_or_404(Annonce, id=annonce_id, auteur=request.user)
    annonce.delete()
    messages.success(request, "Annonce supprimée avec succès")
    return redirect('tableau_de_bord', role='livreur')

@require_POST
@login_required
def republier_annonce_livreur(request, annonce_id):
    annonce = get_object_or_404(Annonce, id=annonce_id, auteur=request.user)
    
    if annonce.statut != 'active':
        messages.error(request, "Seules les annonces actives peuvent être republiées")
    else:
        annonce.date_annonce = timezone.now()
        annonce.save()
        messages.success(request, "Annonce republiée avec succès")
    
    return redirect('tableau_de_bord', role='livreur')

@login_required
def historique_relations_livreur(request):
    livreur = get_object_or_404(Livreur, utilisateur=request.user)
    relations = MiseEnRelation.objects.filter(livreur=livreur).order_by('-date_contact')
    
    return render(request, 'Agri_Connect_CI/relations/historique_livreur.html', {
        'relations': relations,
        'livreur': livreur
    })

@login_required
def detail_relation_livreur(request, relation_id):
    relation = get_object_or_404(MiseEnRelation, id=relation_id, livreur__utilisateur=request.user)
    
    return render(request, 'Agri_Connect_CI/page-details/details_livreurs.html', {
        'relation': relation
    })

@require_POST
@login_required
def marquer_notification_lue(request, notification_id):
    notification = get_object_or_404(Notification, id=notification_id, utilisateur=request.user)
    notification.lu = True
    notification.save()
    messages.success(request, "Notification marquée comme lue")
    return redirect('tableau_de_bord', role='livreur')




@login_required
def editer_profil_livreur(request):
    try:
        livreur = request.user.livreur
    except Livreur.DoesNotExist:
        return redirect('tableau_bord_livreur')

    # Récupération des données existantes
    email_type = TypeContact.objects.filter(nom='Email').first()
    phone_type = TypeContact.objects.filter(nom='Téléphone').first()
    
    contacts = {
        'email': Contact.objects.filter(utilisateur=request.user, type_contact=email_type).first(),
        'phone': Contact.objects.filter(utilisateur=request.user, type_contact=phone_type).first(),
    }
    
    vehicules = Vehicule.objects.filter(livreur=livreur)
    zones_livraison = LivreurZone.objects.filter(livreur=livreur)
    disponibilites = DisponibiliteLivreur.objects.filter(livreur=livreur)

    if request.method == 'POST':
        form = LivreurForm(request.POST, request.FILES, instance=livreur)
        if form.is_valid():
            form.save()
            return redirect('tableau_bord_livreur')
    else:
        # Préparation des données initiales complètes
        initial_data = {
            'full_name': request.user.full_name,
            'email': contacts['email'].valeur if contacts['email'] else '',
            'telephone': contacts['phone'].valeur if contacts['phone'] else '',
            'photo_profil': request.user.photo_profil,
            'description': livreur.description,
            'type_livreur': livreur.type_livreur.id if livreur.type_livreur else None,
            'etat': livreur.etat.id if livreur.etat else None,
            'tarif': livreur.tarif.id if livreur.tarif else None,
            'zones': [zl.zone.id for zl in zones_livraison],
            'jours_disponibilite': [d.jour_semaine for d in disponibilites],
            # Ajoutez d'autres champs selon votre formulaire
        }
        form = LivreurForm(instance=livreur, initial=initial_data)

    context = {
        'form': form,
        'livreur': livreur,
        'vehicules': vehicules,
        'all_zones': Zone.objects.all(),
        'types_livreur': TypeLivreur.objects.all(),
        'etats_livreur': EtatLivreur.objects.all(),
        'tarifs': Tarif.objects.all(),
        'capacites_vehicule': CapaciteVehicule.objects.all(),
        'moyens_transport': MoyenTransport.objects.all(),
    }
    return render(request, 'Agri_Connect_CI/register/edit-livreur.html', context)









require_POST
@login_required
def marquer_notifications_lues(request):
    Notification.objects.filter(utilisateur=request.user, lu=False).update(lu=True)
    messages.success(request, "Toutes les notifications marquées comme lues")
    return redirect('tableau_de_bord', role='livreur')

def inscription_producteur(request):
    # Redirection si déjà producteur
    if request.user.is_authenticated and hasattr(request.user, 'producteur'):
        messages.info(request, "Vous êtes déjà enregistré comme producteur.")
        return redirect('tableau_bord_producteur')

    initial_data = {}
    user_exists = False

    # Pré-remplissage pour utilisateur existant
    if request.user.is_authenticated:
        user = request.user
        initial_data = {
            'username': user.username,
            'email': user.email,
            'full_name': user.full_name,
            'zone': user.zone.id if user.zone else None,
            'photo_profil': user.photo_profil,
        }
        
        # Récupération des contacts
        phone = user.contact_set.filter(type_contact__nom='Téléphone').first()
        whatsapp = user.contact_set.filter(type_contact__nom='WhatsApp').first()
        
        if phone:
            initial_data['telephone'] = phone.valeur
        if whatsapp:
            initial_data['whatsapp'] = whatsapp.valeur
        
        user_exists = True

    if request.method == 'POST':
        form = InscriptionProducteurForm(
            request.POST, 
            request.FILES, 
            user_exists=user_exists, 
            initial=initial_data
        )
        
        if form.is_valid():
            try:
                with transaction.atomic():
                    # Gestion de l'utilisateur
                    if user_exists:
                        user = request.user
                        # Mise à jour des informations de base
                        user.full_name = form.cleaned_data['full_name']
                        user.email = form.cleaned_data['email']
                        user.zone = form.cleaned_data['zone']
                        
                        if 'photo_profil' in request.FILES:
                            user.photo_profil = request.FILES['photo_profil']
                        user.save()
                    else:
                        # Création d'un nouvel utilisateur (acheteur par défaut)
                        user = Utilisateur.objects.create_user(
                            username=form.cleaned_data['username'],
                            email=form.cleaned_data['email'],
                            full_name=form.cleaned_data['full_name'],
                            password=form.cleaned_data['password'],
                            role='acheteur',  # Par défaut, sera changé après validation
                            zone=form.cleaned_data['zone']
                        )
                        
                        if 'photo_profil' in request.FILES:
                            user.photo_profil = request.FILES['photo_profil']
                            user.save()

                    # Gestion des contacts
                    phone_type, _ = TypeContact.objects.get_or_create(nom='Téléphone')
                    Contact.objects.update_or_create(
                        utilisateur=user,
                        type_contact=phone_type,
                        defaults={'valeur': form.cleaned_data['telephone']}
                    )
                    
                    if form.cleaned_data.get('whatsapp'):
                        whatsapp_type, _ = TypeContact.objects.get_or_create(nom='WhatsApp')
                        Contact.objects.update_or_create(
                            utilisateur=user,
                            type_contact=whatsapp_type,
                            defaults={'valeur': form.cleaned_data['whatsapp']}
                        )

                    # Création du producteur (mais rôle reste 'acheteur' pour l'instant)
                    producteur = Producteur.objects.create(
                        utilisateur=user,
                        date_debut_activite=form.cleaned_data['date_debut_activite'],
                        methode_production=form.cleaned_data['methode_production'],
                        description_longue=form.cleaned_data['description_longue'],
                        specialites=form.cleaned_data.get('specialites', ''),
                        annee_debut=form.cleaned_data['date_debut_activite'].year
                    )

                    DocumentProducteur.objects.create(
                        producteur=producteur,
                        type_document='cni',
                        fichier=form.cleaned_data['cni_recto'],
                        description="CNI Recto"
                    )
                    
                    if form.cleaned_data.get('cni_verso'):
                        DocumentProducteur.objects.create(
                            producteur=producteur,
                            type_document='cni',
                            fichier=form.cleaned_data['cni_verso'],
                            description="CNI Verso"
                        )
                    
                    # Photos de la ferme 
                    photos_ferme = request.FILES.getlist('photos_ferme')
                    for i, photo in enumerate(photos_ferme, start=1):
                        DocumentProducteur.objects.create(
                            producteur=producteur,
                            type_document='photo_ferme',
                            fichier=photo,
                            description=f"Photo de ferme #{i}"
                        )


                    messages.success(
                        request,
                        "Votre demande a été soumise avec succès. "
                        "Vous serez notifié par email une fois votre compte producteur activé."
                    )
                    
                    
                    
                    return redirect('home')

            except Exception as e:
                logger.error(f"Erreur lors de l'inscription producteur: {str(e)}")
                messages.error(
                    request,
                    "Une erreur est survenue lors de l'enregistrement. "
                    "Veuillez réessayer ou contacter le support."
                )
    else:
        form = InscriptionProducteurForm(user_exists=user_exists, initial=initial_data)

    return render(request, 'Agri_Connect_CI/register/register-producer.html', {
        'form': form,
        'user_exists': user_exists
    })