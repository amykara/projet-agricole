"""
Complète les données de démonstration manquantes en production : producteurs,
livreurs (avec véhicules et zones de couverture), et les deux annonces de
type "Service"/"Demande" qui restaient absentes (la commande seed_demo_annonces
ne couvrait que les annonces de vente de produits pour le catalogue).

Toutes les photos référencées existent déjà dans media/ (déployées avec le code).
Idempotent : les comptes sont dédoublonnés par username, les annonces par titre.
Les comptes créés reçoivent un mot de passe inutilisable (pas de connexion possible),
ce sont des profils de démonstration affichés sur le site, pas des comptes réels.
"""
from django.core.management.base import BaseCommand
from django.db import transaction

from Agri_Connect_CI.models import (
    Utilisateur, Zone, Producteur, Livreur, TypeLivreur, EtatLivreur, Tarif,
    Devise, Vehicule, CapaciteVehicule, UniteMesure, LivreurZone,
    Annonce, AnnonceImage, TypeAnnonce,
)

ZONES = {
    1: ('Abidjan', 'Cocody', '22501'),
    2: ('Abidjan', 'Yopougon', '22502'),
    4: ('Abidjan', 'Plateau', '00225'),
    9: ('San Pedro', 'Quartier des pêcheurs', '01532'),
    11: ('Man', 'Centre-ville', '03456'),
    12: ('Bondoukou', 'Marché central', '02100'),
}

# username -> (full_name, role, photo_profil ou None, zone_id ou None)
UTILISATEURS = {
    'kouadioa': ('Kouadio Alain', 'producteur', None, 1),
    'agneg_b': ('Agnegbé Brice', 'producteur', None, 2),
    'kone_farm': ('Kone Mamadou', 'producteur', 'profils/images-removebg-preview_UEb0TXY.png', 1),
    'rubin123': ('Bobo Rubin', 'producteur', None, None),
    'epices_afrik': ('Amina Traoré', 'producteur', None, None),
    'miel_douceur': ('Bakary Coulibaly', 'producteur', None, None),
    'fruits_tropicaux': ('Jean Akissi', 'producteur', None, None),
    'coop_riz': ('Coopérative Rizicole du Nord', 'producteur', None, None),
    'ali_delivery': ('Ali Coulibaly', 'livreur', 'profils/depositphotos_446174836-stock-photo-black-delivery-man-holding-cardboard.jpg', None),
    'yamahb128': ('Yamahiou Bernard', 'livreur', 'profils/WhatsApp_Image_2025-02-25_à_22.42.20_3bd66eef-removebg-preview.png', 2),
    'lilib12': ('Lili Berry', 'livreur', 'profils/Muslim_character.jpg', 2),
    'livreur_eko': ('Ekoué Johnson', 'livreur', 'profils/portrait-jeune-livreur-montrant-pouce-vers-haut_58466-16783.jpg', None),
    'livreur_frigo': ('Koffi Nguessan', 'livreur', None, None),
    'lilijay': ('Jay Lil', 'acheteur', None, None),
}

# username -> (date_debut_activite, methode_production, description_longue, specialites, annee_debut)
PRODUCTEURS = {
    'kouadioa': ('2015-01-15', 'bio', "Producteur de mangues bio en Côte d'Ivoire.", 'Mangues, Ananas', 2015),
    'agneg_b': ('2018-05-20', 'permaculture', 'Agriculteur spécialisé en permaculture.', 'Tomates, Piments', 2018),
    'kone_farm': ('2017-06-15', 'bio', 'Producteur spécialisé dans les cultures maraîchères biologiques', 'Laitue, choux, carottes', 2012),
    'rubin123': ('2025-06-13', 'bio', '', None, 2025),
    'epices_afrik': ('2020-06-10', 'bio', "Productrice spécialisée dans les épices bio d'Afrique de l'Ouest.", 'Piment, Gingembre, Curcuma', 2020),
    'miel_douceur': ('2018-11-05', 'bio', 'Apiculteur passionné produisant du miel 100% naturel.', 'Miel de forêt, Miel de fleurs sauvages', 2018),
    'fruits_tropicaux': ('2019-08-12', 'conventionnel', 'Producteur spécialisé dans les fruits tropicaux de saison.', 'Ananas, Papaye, Fruit de la passion', 2019),
    'coop_riz': ('2010-05-03', 'bio', 'Coopérative de 50 producteurs de riz bio dans le nord de la Côte d\'Ivoire.', 'Riz parfumé, Riz complet', 2010),
}

# username -> (description, type_livreur, etat, tarif) ; tarif = (type_tarif, valeur) ou None
LIVREURS = {
    'ali_delivery': ('Livreur sérieux avec véhicule réfrigéré pour produits frais', 'Individuel', 'Disponible', None),
    'yamahb128': ('Je suis un livreur expérimenté, je livre partout à Abidjan', 'Entreprise', 'Disponible', ('partout à Abidjan', 1000)),
    'lilib12': ('livreur', 'Individuel', 'Disponible', ('partout à Abidjan', 1000)),
    'livreur_eko': ('Livraison écologique à vélo pour petits colis', 'Individuel', 'Disponible', None),
    'livreur_frigo': ('Livraison en camion frigorifique pour produits sensibles', 'Entreprise', 'Disponible', None),
}

# username -> [(type, immatriculation, photo_url ou None, capacite_valeur, capacite_desc)]
VEHICULES = {
    'yamahb128': [
        ('Camionnette', 'AMV12', 'vehicules/téléchargement_2_vhNoDX5.jpeg', 1000, ''),
        ('Tricycle', 'AMV11', 'vehicules/Tricycle-Bagage-scaled.jpg', 1000, 'Tricycle pour livraison'),
        ('Moto', 'AMV14', 'vehicules/images_4.jpeg', 50, 'moto de livraison'),
    ],
    'livreur_eko': [
        ('Vélo cargo', 'VELO123', None, 10, 'Vélo de livraison'),
    ],
    'livreur_frigo': [
        ('Camion frigorifique', 'FRIGO123', None, 2000, 'Camion frigorifique'),
    ],
}

# username -> [zone_id, ...]
LIVREUR_ZONES = {
    'ali_delivery': [1, 4],
    'livreur_eko': [9],
    'livreur_frigo': [11, 12],
}

# (titre, description, zone_id, auteur_username, type_annonce_nom, image)
ANNONCES_SERVICE = [
    (
        'Livraison de produits agricoles à bas coût',
        'Je livre vos fruits/légumes pour 500 FCFA dans Abidjan.',
        1, 'ali_delivery', 'Service', 'images_4_twN7yCh.jpeg',
    ),
    (
        "Besoin d'un livreur",
        "Besoin d'un livreur pour une semaine, salaire 100000fcfa, plus d'infos en inbox",
        1, 'lilijay', 'Demande', 'images_4_dQhEIP8.jpeg',
    ),
]


class Command(BaseCommand):
    help = "Charge les producteurs, livreurs et annonces de service/demande manquants en production."

    def handle(self, *args, **options):
        zones = {
            zid: Zone.objects.get_or_create(ville=v, quartier=q, code_postal=cp)[0]
            for zid, (v, q, cp) in ZONES.items()
        }
        devise_xof, _ = Devise.objects.get_or_create(code='XOF', nom='Franc CFA')
        unite_kg, _ = UniteMesure.objects.get_or_create(nom='kilogramme', defaults={'abbr': 'kg'})

        with transaction.atomic():
            users = {}
            for username, (full_name, role, photo, zone_id) in UTILISATEURS.items():
                user, created = Utilisateur.objects.get_or_create(
                    username=username,
                    defaults={
                        'full_name': full_name,
                        'role': role,
                        'photo_profil': photo or '',
                        'zone': zones[zone_id] if zone_id else None,
                        'statut_verification': 'vérifié',
                    },
                )
                if created:
                    user.set_unusable_password()
                    user.save()
                    self.stdout.write(f"  utilisateur créé : {username}")
                users[username] = user

            nb_producteurs = 0
            for username, (date_debut, methode, desc, specialites, annee) in PRODUCTEURS.items():
                _, created = Producteur.objects.get_or_create(
                    utilisateur=users[username],
                    defaults={
                        'date_debut_activite': date_debut,
                        'methode_production': methode,
                        'description_longue': desc,
                        'specialites': specialites,
                        'annee_debut': annee,
                    },
                )
                if created:
                    nb_producteurs += 1

            type_livreurs = {
                nom: TypeLivreur.objects.get_or_create(nom=nom)[0]
                for nom in ('Individuel', 'Entreprise')
            }
            etats = {
                nom: EtatLivreur.objects.get_or_create(nom=nom)[0]
                for nom in ('Disponible', 'Indisponible')
            }

            nb_livreurs = 0
            livreur_objs = {}
            for username, (desc, type_nom, etat_nom, tarif_info) in LIVREURS.items():
                tarif = None
                if tarif_info:
                    tarif_type, tarif_valeur = tarif_info
                    tarif, _ = Tarif.objects.get_or_create(
                        type_tarif=tarif_type, valeur=tarif_valeur, devise=devise_xof,
                    )
                livreur, created = Livreur.objects.get_or_create(
                    utilisateur=users[username],
                    defaults={
                        'description': desc,
                        'type_livreur': type_livreurs[type_nom],
                        'etat': etats[etat_nom],
                        'tarif': tarif,
                    },
                )
                if created:
                    nb_livreurs += 1
                livreur_objs[username] = livreur

            nb_vehicules = 0
            for username, vehicules in VEHICULES.items():
                for type_v, immat, photo, cap_valeur, cap_desc in vehicules:
                    capacite = CapaciteVehicule.objects.filter(
                        valeur=cap_valeur, unite=unite_kg, description=cap_desc,
                    ).first()
                    if capacite is None:
                        capacite = CapaciteVehicule.objects.create(
                            valeur=cap_valeur, unite=unite_kg, description=cap_desc,
                        )
                    _, created = Vehicule.objects.get_or_create(
                        livreur=livreur_objs[username],
                        immatriculation=immat,
                        defaults={
                            'type': type_v,
                            'capacite': capacite,
                            'photo_url': photo or '',
                        },
                    )
                    if created:
                        nb_vehicules += 1

            for username, zone_ids in LIVREUR_ZONES.items():
                for zid in zone_ids:
                    LivreurZone.objects.get_or_create(
                        livreur=livreur_objs[username], zone=zones[zid],
                    )

            nb_annonces = 0
            for titre, description, zone_id, auteur_username, type_nom, image in ANNONCES_SERVICE:
                type_annonce, _ = TypeAnnonce.objects.get_or_create(nom=type_nom)
                annonce, created = Annonce.objects.get_or_create(
                    titre=titre,
                    defaults={
                        'description': description,
                        'statut': 'active',
                        'auteur': users[auteur_username],
                        'type_annonce': type_annonce,
                        'zone': zones[zone_id],
                    },
                )
                if created:
                    nb_annonces += 1
                    AnnonceImage.objects.get_or_create(
                        annonce=annonce, url_image=f'annonces/images/{image}',
                    )

        self.stdout.write(self.style.SUCCESS(
            f"Terminé. {nb_producteurs} producteur(s), {nb_livreurs} livreur(s), "
            f"{nb_vehicules} véhicule(s), {nb_annonces} annonce(s) créé(s)."
        ))
