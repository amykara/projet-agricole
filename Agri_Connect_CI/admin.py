from django.contrib import admin
from .models import *
from django.utils.html import format_html

# ========== INLINES ==========
class AnnonceProduitInline(admin.TabularInline):
    model = AnnonceProduit
    extra = 1

class AnnonceImageInline(admin.TabularInline):
    model = AnnonceImage
    extra = 1

class LivreurZoneInline(admin.TabularInline):
    model = LivreurZone
    extra = 1

class LivreurMoyenTransportInline(admin.TabularInline):
    model = LivreurMoyenTransport
    extra = 1

# ========== UTILISATEUR ==========
@admin.register(Utilisateur)
class UtilisateurAdmin(admin.ModelAdmin):
    list_display = ("full_name", "email", "role", "statut_verification", "get_telephone", "get_email_contact")
    list_filter = ("role", "statut_verification")
    search_fields = ("username", "email", "contact__valeur")
    
    def get_telephone(self, obj):
        telephone = obj.contact_set.filter(type_contact__nom='Téléphone').first()
        return telephone.valeur if telephone else "-"
    get_telephone.short_description = 'Téléphone'
    
    def get_email_contact(self, obj):
        email = obj.contact_set.filter(type_contact__nom='Email').first()
        return email.valeur if email else "-"
    get_email_contact.short_description = 'Email (Contact)'

# ========== CONTACT ==========
@admin.register(TypeContact)
class TypeContactAdmin(admin.ModelAdmin):
    list_display = ("nom",)

@admin.register(Contact)
class ContactAdmin(admin.ModelAdmin):
    list_display = ("utilisateur", "type_contact", "valeur")
    search_fields = ("utilisateur__username", "valeur")

# ========== ZONE ==========
@admin.register(Zone)
class ZoneAdmin(admin.ModelAdmin):
    list_display = ("ville", "quartier", "code_postal")
    search_fields = ("ville", "quartier")

# ========== UNITE / DEVISE ==========
@admin.register(UniteMesure)
class UniteAdmin(admin.ModelAdmin):
    list_display = ("nom", "abbr")

@admin.register(Devise)
class DeviseAdmin(admin.ModelAdmin):
    list_display = ("code", "nom")

# ========== PRODUITS ==========
@admin.register(CategorieProduit)
class CategorieProduitAdmin(admin.ModelAdmin):
    list_display = ("nom",)

@admin.register(TypeAnnonce)
class TypeAnnonceAdmin(admin.ModelAdmin):
    list_display = ("nom",)

@admin.register(Annonce)
class AnnonceAdmin(admin.ModelAdmin):
    list_display = ("titre", "auteur", "type_annonce", "zone", "statut", "date_annonce")
    list_filter = ("type_annonce", "zone", "statut")
    search_fields = ("titre", "auteur__username")
    inlines = [AnnonceProduitInline, AnnonceImageInline]

@admin.register(AnnonceProduit)
class AnnonceProduitAdmin(admin.ModelAdmin):
    list_display = ("nom_produit", "categorie", "quantite", "prix_unitaire", "devise")
    list_filter = ("categorie",)

@admin.register(AnnonceImage)
class AnnonceImageAdmin(admin.ModelAdmin):
    list_display = ("annonce", "url_image", "legende")
    def image_preview(self, obj):
        if obj.image:
            return format_html('<img src="{}" style="height: 100px;"/>', obj.image.url)
        return "-"
    image_preview.short_description = "Aperçu"
# ========== PRODUCTEUR ==========

@admin.register(ProducteurProduit)
class ProducteurProduitAdmin(admin.ModelAdmin):
    list_display = ("producteur", "categorie")

from django.core.mail import send_mail

class DocumentProducteurInline(admin.TabularInline):
    model = DocumentProducteur
    extra = 0
    readonly_fields = ('date_upload',)
    fields = ('type_document', 'fichier', 'description', 'date_upload')

@admin.action(description="Valider les producteurs sélectionnés")
def valider_producteurs(modeladmin, request, queryset):
    for producteur in queryset:
        user = producteur.utilisateur
        user.role = 'producteur'
        user.save()

        # envoi email
        send_mail(
            'Votre compte producteur a été validé',
            f'Félicitations {user.full_name} !\n\n'
            'Votre compte producteur sur AgriConnect a été validé.\n'
            'Vous pouvez maintenant accéder à votre tableau de bord producteur.\n\n'
            'Cordialement,\nL’équipe AgriConnect',
            'no-reply@agriconnect.ci',
            [user.email],
            fail_silently=False,
        )

@admin.register(Producteur)
class ProducteurAdmin(admin.ModelAdmin):
    list_display = ('utilisateur', 'methode_production', 'date_debut_activite', 'est_valide')
    list_filter   = ('methode_production',)
    search_fields = ('utilisateur__username', 'utilisateur__full_name')
    actions       = [valider_producteurs]
    inlines       = [DocumentProducteurInline]

    @admin.display(boolean=True, description='Validé')
    def est_valide(self, obj):
        return obj.utilisateur.role == 'producteur'


# ========== LIVREUR ==========
@admin.register(TypeLivreur)
class TypeLivreurAdmin(admin.ModelAdmin):
    list_display = ("nom",)

@admin.register(MoyenTransport)
class MoyenTransportAdmin(admin.ModelAdmin):
    list_display = ("nom",)

@admin.register(EtatLivreur)
class EtatLivreurAdmin(admin.ModelAdmin):
    list_display = ("nom",)

@admin.register(Tarif)
class TarifAdmin(admin.ModelAdmin):
    list_display = ("type_tarif", "valeur", "devise")

@admin.register(Livreur)
class LivreurAdmin(admin.ModelAdmin):
    list_display = ("utilisateur", "type_livreur", "etat")
    search_fields = ("utilisateur__username",)
    inlines = [LivreurZoneInline, LivreurMoyenTransportInline]

@admin.register(CapaciteVehicule)
class CapaciteVehiculeAdmin(admin.ModelAdmin):
    list_display = ("valeur", "unite", "description")
    list_filter = ("unite",)
    search_fields = ("description",)


@admin.register(Vehicule)
class VehiculeAdmin(admin.ModelAdmin):
    list_display = ("livreur", "type", "capacite", "immatriculation")
    

@admin.register(DisponibiliteLivreur)
class DisponibiliteLivreurAdmin(admin.ModelAdmin):
    list_display = ("livreur", "jour_semaine", "date_debut", "date_fin", "statut")

@admin.register(LivreurZone)
class LivreurZoneAdmin(admin.ModelAdmin):
    list_display = ("livreur", "zone")

@admin.register(LivreurMoyenTransport)
class LivreurMoyenTransportAdmin(admin.ModelAdmin):
    list_display = ("livreur", "moyen_transport")

# ========== INTERACTIONS ==========
@admin.register(MiseEnRelation)
class MiseEnRelationAdmin(admin.ModelAdmin):
    list_display = ("client", "livreur", "date_contact", "moyen_contact")

@admin.register(Notation)
class NotationAdmin(admin.ModelAdmin):
    list_display = ("mise_en_relation", "note")
    search_fields = ("commentaire",)

@admin.register(Notification)
class NotificationAdmin(admin.ModelAdmin):
    list_display = ("utilisateur", "message", "date_envoi", "lu")

@admin.register(PositionActuelle)
class PositionActuelleAdmin(admin.ModelAdmin):
    list_display = ("livreur", "latitude", "longitude", "date_maj")

@admin.register(FAQ)
class FAQAdmin(admin.ModelAdmin):
    list_display = ("categorie", "question", "ordre_affichage")
    ordering = ("ordre_affichage",)

@admin.register(Favoris)
class FavorisAdmin(admin.ModelAdmin):
    list_display = ("utilisateur", "annonce", "date_ajout")


