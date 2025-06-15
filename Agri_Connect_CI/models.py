from django.db import models
from django.contrib.auth.models import AbstractUser
# Create your models here.
from django.db.models import Avg
from django.core.validators import RegexValidator
from django.contrib.auth.models import AbstractUser, UserManager, PermissionsMixin
from django.core.validators import RegexValidator
from django.utils import timezone
from django.core.validators import FileExtensionValidator
# ====================
# UTILS
# ====================
class UniteMesure(models.Model):
    nom = models.CharField(max_length=50)
    abbr = models.CharField(max_length=10)
    def __str__(self):
        return f"{self.nom} ({self.abbr})"

class CapaciteVehicule(models.Model):
    valeur = models.DecimalField(max_digits=10, decimal_places=2)
    unite = models.ForeignKey(UniteMesure, on_delete=models.PROTECT)
    description = models.CharField(max_length=100, blank=True)

    class Meta:
        ordering = ['valeur']
        verbose_name = "Capacité de véhicule"
        verbose_name_plural = "Capacités de véhicules"

    def __str__(self):
        return f"{self.valeur} {self.unite.abbr}"
    
class Devise(models.Model):
    code = models.CharField(max_length=10)
    nom = models.CharField(max_length=50)

    def __str__(self):
        return f"{self.nom} ({self.code})"


class Zone(models.Model):
    ville = models.CharField(max_length=100)
    quartier = models.CharField(max_length=100)
    code_postal = models.CharField(max_length=20)

    def __str__(self):
        return f"{self.quartier}, {self.ville}"

# ====================
# UTILISATEUR
# ====================

class CustomUserManager(UserManager):
    def create_user(self, username, email=None, password=None, **extra_fields):
        extra_fields.setdefault('role', 'acheteur')  # Valeur par défaut
        return super().create_user(username, email, password, **extra_fields)
 
class Utilisateur(AbstractUser, PermissionsMixin):
    ROLES = [
        ('producteur', 'Producteur'), 
        ('acheteur', 'Acheteur'), 
        ('livreur', 'Livreur')
    ]
    STATUTS = [
        ('vérifié', 'Vérifié'), 
        ('non vérifié', 'Non vérifié')
    ]

    username_validator = RegexValidator(
        regex=r'^[\w.@+-]+\Z',
        message="Le nom d'utilisateur ne peut contenir que des lettres, chiffres et @/./+/-/_"
    )
    
    username = models.CharField(
        max_length=30,
        unique=True,
        validators=[username_validator],
        error_messages={
            'unique': "Ce nom d'utilisateur est déjà pris.",
        },
    )
    full_name = models.CharField(max_length=100, verbose_name="Nom complet")
    role = models.CharField(max_length=20, choices=ROLES, default='acheteur')
    photo_profil = models.ImageField(upload_to='profils/', blank=True, null=True)
    date_inscription = models.DateTimeField(auto_now_add=True)
    derniere_connexion = models.DateTimeField(null=True, blank=True)
    statut_verification = models.CharField(max_length=20, choices=STATUTS, default='non vérifié')
    zone = models.ForeignKey(Zone, on_delete=models.SET_NULL, null=True, blank=True, verbose_name="Zone de résidence")

    USERNAME_FIELD = 'username'  # On utilise username comme identifiant principal
    REQUIRED_FIELDS = ['full_name']

    objects = CustomUserManager()

    def get_email(self):
        """Récupère l'email depuis les contacts"""
        email_type = TypeContact.objects.filter(nom='Email').first()
        if email_type:
            contact = Contact.objects.filter(utilisateur=self, type_contact=email_type).first()
            return contact.valeur if contact else None
        return None

    def __str__(self):
        return self.username
# ====================
# CONTACTS
# ====================
class TypeContact(models.Model):
    nom = models.CharField(max_length=50)
    def __str__(self):
        return self.nom

class Contact(models.Model):
    utilisateur = models.ForeignKey(Utilisateur, on_delete=models.CASCADE)
    type_contact = models.ForeignKey(TypeContact, on_delete=models.CASCADE)
    valeur = models.CharField(max_length=255)
    def __str__(self):
        return f"{self.type_contact.nom}: {self.valeur}"

# ====================
# PRODUCTEURS
# ====================
class Producteur(models.Model):
    METHODES = [('bio', 'Bio'), ('conventionnel', 'Conventionnel'), ('permaculture', 'Permaculture'), ('autre', 'Autre')]

    utilisateur = models.OneToOneField(
        Utilisateur,
        on_delete=models.CASCADE,
        related_name='producteur', 
        verbose_name="Utilisateur"
    )
    date_debut_activite = models.DateField()
    methode_production = models.CharField(max_length=20, choices=METHODES)
    description_longue = models.TextField()
    specialites = models.CharField(max_length=255, blank=True, null=True)
    annee_debut = models.IntegerField(default=timezone.now().year)
    def moyenne_notes(self):
        return self.notations.aggregate(moyenne=Avg('note'))['moyenne'] or 0

    def __str__(self):
        return f"Producteur: {self.utilisateur.full_name}"
    
    def moyenne_notes(self):
        """Retourne la moyenne des notes arrondie à 1 décimale"""
        avg = self.notations.aggregate(avg=Avg('note'))['avg']
        return round(avg, 1) if avg else None
    
class CategorieProduit(models.Model):
    nom = models.CharField(max_length=100)
    def __str__(self):
        return self.nom

class ProducteurProduit(models.Model):
    producteur = models.ForeignKey(Producteur, on_delete=models.CASCADE)
    categorie = models.ForeignKey(CategorieProduit, on_delete=models.CASCADE)
    def __str__(self):
        return f"{self.producteur} - {self.categorie}"
    
class DocumentProducteur(models.Model):
    TYPES_DOCUMENT = [
        ('cni', "Carte Nationale d'Identité"),
        ('photo_ferme', "Photo de la ferme"),
        ('autre', "Autre document"),
    ]

    producteur = models.ForeignKey(
        Producteur, 
        on_delete=models.CASCADE,
        related_name='documents'
    )
    type_document = models.CharField(
        max_length=20,
        choices=TYPES_DOCUMENT
    )
    fichier = models.FileField(
        upload_to='producteurs/documents/',
        validators=[FileExtensionValidator(allowed_extensions=['jpg', 'jpeg', 'png', 'pdf'])]
    )
    date_upload = models.DateTimeField(auto_now_add=True)
    description = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        verbose_name = "Document producteur"
        verbose_name_plural = "Documents producteurs"

    def __str__(self):
        return f"{self.get_type_document_display()} - {self.producteur.utilisateur.username}"

# ====================
# ANNONCES
# ====================
class TypeAnnonce(models.Model):
    nom = models.CharField(max_length=100)
    def __str__(self):
        return self.nom

class Annonce(models.Model):
    STATUTS = [('active', 'Active'), ('réservée', 'Réservée'), ('archivée', 'Archivée')]

    auteur = models.ForeignKey(Utilisateur, on_delete=models.CASCADE)
    type_annonce = models.ForeignKey(TypeAnnonce, on_delete=models.CASCADE)
    titre = models.CharField(max_length=255)
    description = models.TextField()
    zone = models.ForeignKey(Zone, on_delete=models.SET_NULL, null=True)
    date_annonce = models.DateTimeField(auto_now_add=True)
    statut = models.CharField(max_length=20, choices=STATUTS, default='active')

    def __str__(self):
        return self.titre
    
    def republier(self):
        """Réactualise la date de l'annonce pour la faire remonter"""
        self.date_annonce = timezone.now()
        self.save()
        return self

class AnnonceImage(models.Model):
    annonce = models.ForeignKey(Annonce, on_delete=models.CASCADE)
    url_image = models.ImageField(upload_to='annonces/images')
    legende = models.CharField(max_length=255, null=True, blank=True)
    def __str__(self):
        return self.legende if self.legende else f"Image de {self.annonce.titre}"

class Conditionnement(models.Model):
    nom = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)
    
    def __str__(self):
        return self.nom

class Certification(models.Model):
    nom = models.CharField(max_length=100)
    organisme_emetteur = models.CharField(max_length=100, blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    
    def __str__(self):
        return self.nom
    
class AnnonceProduit(models.Model):
    annonce = models.ForeignKey(Annonce, on_delete=models.CASCADE)
    nom_produit = models.CharField(max_length=100)
    categorie = models.ForeignKey(CategorieProduit, on_delete=models.CASCADE)
    unite = models.ForeignKey(UniteMesure, on_delete=models.SET_NULL, null=True)
    quantite = models.DecimalField(max_digits=10, decimal_places=2)
    prix_unitaire = models.DecimalField(max_digits=10, decimal_places=2)
    devise = models.ForeignKey(Devise, on_delete=models.SET_NULL, null=True)
    conditionnement = models.ForeignKey(Conditionnement, on_delete=models.SET_NULL, null=True, blank=True)
    certification = models.ForeignKey(Certification, on_delete=models.SET_NULL, null=True, blank=True)
    livraison_disponible = models.BooleanField(default=False)    

    def __str__(self):
        return self.nom_produit  

    def get_icon(self):
        """Retourne l'icône Font Awesome appropriée selon la catégorie"""
        categories_icons = {
            'fruit': 'apple-alt',
            'légume': 'carrot',
            'céréale': 'wheat',
            'viande': 'drumstick-bite',
            'poisson': 'fish',
            'laitier': 'cheese',
        }     

        for keyword, icon in categories_icons.items():
            if keyword in self.categorie.nom.lower():
                return icon
        return 'shopping-basket'     
# ====================
# LIVREUR
# ====================
class TypeLivreur(models.Model):
    nom = models.CharField(max_length=50)
    def __str__(self):
        return self.nom

class MoyenTransport(models.Model):
    nom = models.CharField(max_length=100)
    description = models.TextField(null=True, blank=True)
    def __str__(self):
        return self.nom

class EtatLivreur(models.Model):
    nom = models.CharField(max_length=50)
    def __str__(self):
        return self.nom

class Tarif(models.Model):
    type_tarif = models.CharField(max_length=50)
    valeur = models.DecimalField(max_digits=10, decimal_places=2)
    devise = models.ForeignKey(Devise, on_delete=models.SET_NULL, null=True)
    def __str__(self):
        return f"{self.type_tarif} - {self.valeur} {self.devise.code if self.devise else ''}"
    
class Livreur(models.Model):
    utilisateur = models.OneToOneField(  # Remplacement final
        'Utilisateur',
        on_delete=models.CASCADE,
        related_name='livreur'  # Nommage plus clair
    )
    type_livreur = models.ForeignKey(TypeLivreur, on_delete=models.SET_NULL, null=True)
    tarif = models.ForeignKey(Tarif, on_delete=models.SET_NULL, null=True)
    etat = models.ForeignKey(EtatLivreur, on_delete=models.SET_NULL, null=True)
    description = models.TextField(null=True, blank=True)
    def moyenne_notes(self):
        return self.notations.aggregate(moyenne=Avg('note'))['moyenne'] or 0

    def zones_couvertes(self):
        return ", ".join([str(z.zone) for z in self.livreurzone_set.all()])

    def __str__(self):
        return f"Livreur: {self.utilisateur.full_name}"
    
class Vehicule(models.Model):
    livreur = models.ForeignKey(Livreur, on_delete=models.CASCADE)
    type = models.CharField(max_length=100)
    capacite = models.ForeignKey(CapaciteVehicule, on_delete=models.CASCADE, null=True, blank=True)
    immatriculation = models.CharField(max_length=50)
    photo_url = models.ImageField(upload_to='vehicules/')

    def __str__(self):
        return f"{self.type} - {self.immatriculation}"


class LivreurZone(models.Model):
    livreur = models.ForeignKey(Livreur, on_delete=models.CASCADE)
    zone = models.ForeignKey(Zone, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.livreur} - {self.zone}"


class LivreurMoyenTransport(models.Model):
    livreur = models.ForeignKey(Livreur, on_delete=models.CASCADE)
    moyen_transport = models.ForeignKey(MoyenTransport, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.livreur} - {self.moyen_transport}"

class DisponibiliteLivreur(models.Model):
    JOURS = [('lundi','Lundi'), ('mardi','Mardi'), ('mercredi','Mercredi'),
             ('jeudi','Jeudi'), ('vendredi','Vendredi'),
             ('samedi','Samedi'), ('dimanche','Dimanche')]
    STATUTS = [('disponible','Disponible'), ('indisponible','Indisponible'), ('en_congé','En congé')]

    livreur = models.ForeignKey(Livreur, on_delete=models.CASCADE)
    jour_semaine = models.CharField(max_length=20, choices=JOURS)
    date_debut = models.DateTimeField()
    date_fin = models.DateTimeField()
    statut = models.CharField(max_length=20, choices=STATUTS)

    def __str__(self):
        return f"{self.livreur} - {self.jour_semaine} ({self.statut})"

# ====================
# RELATION CLIENT-LIVREUR
# ====================
class MiseEnRelation(models.Model):
    client = models.ForeignKey(Utilisateur, on_delete=models.CASCADE)
    livreur = models.ForeignKey(Livreur, on_delete=models.CASCADE, null=True, blank=True)
    producteur = models.ForeignKey(Producteur, on_delete=models.CASCADE, null=True, blank=True)
    date_contact = models.DateTimeField(auto_now_add=True)
    moyen_contact = models.ForeignKey(TypeContact, on_delete=models.SET_NULL, null=True)

    def __str__(self):
        return f"Relation client {self.client} - livreur {self.livreur or 'N/A'} - producteur {self.producteur or 'N/A'}"


class Notation(models.Model):
    CONTEXTES = [('livraison', 'Livraison'), ('produit', 'Produit')]
    evaluateur = models.ForeignKey(Utilisateur, on_delete=models.CASCADE)
    livreur = models.ForeignKey(Livreur, null=True, blank=True, on_delete=models.CASCADE, related_name='notations')
    producteur = models.ForeignKey(Producteur, null=True, blank=True, on_delete=models.CASCADE, related_name='notations')
    mise_en_relation = models.ForeignKey(MiseEnRelation, on_delete=models.CASCADE)
    note = models.IntegerField(choices=[(i, i) for i in range(1, 6)])
    commentaire = models.TextField(null=True, blank=True)
    date_creation = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        cible = self.livreur or self.producteur or "Inconnu"
        return f"Notation {self.note} par {self.evaluateur} sur {cible}"



# ====================
# DIVERS
# ====================
class Notification(models.Model):
    utilisateur = models.ForeignKey(Utilisateur, on_delete=models.CASCADE)
    message = models.TextField()
    date_envoi = models.DateTimeField(auto_now_add=True)
    lu = models.BooleanField(default=False)

    def __str__(self):
        return f"Notification pour {self.utilisateur} - {self.message[:30]}..."


class PositionActuelle(models.Model):
    livreur = models.ForeignKey(Livreur, on_delete=models.CASCADE)
    latitude = models.DecimalField(max_digits=10, decimal_places=8)
    longitude = models.DecimalField(max_digits=11, decimal_places=8)
    date_maj = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Position de {self.livreur} au {self.date_maj.strftime('%Y-%m-%d %H:%M')}"


class FAQ(models.Model):
    CATEGORIES = [('general','Général'), ('acheteur','Acheteur'), ('producteur','Producteur'), ('livreur','Livreur')]

    question = models.TextField()
    reponse = models.TextField()
    categorie = models.CharField(max_length=20, choices=CATEGORIES)
    ordre_affichage = models.IntegerField()

    def __str__(self):
        return f"FAQ {self.categorie} - {self.question[:50]}..."


class Favoris(models.Model):
    utilisateur = models.ForeignKey(Utilisateur, on_delete=models.CASCADE)
    annonce = models.ForeignKey(Annonce, on_delete=models.CASCADE)
    date_ajout = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('utilisateur', 'annonce')

    def __str__(self):
        return f"Favori: {self.utilisateur} - {self.annonce}"