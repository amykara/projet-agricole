"""
Ajoute des annonces de démonstration (avec produits et photos) qui existaient
dans l'ancien dump SQL local (agriculture_db (5).sql) mais qui n'ont jamais
été chargées dans la base de production. Les images référencées sont déjà
présentes dans media/annonces/images/ (donc déployées avec le code sur Render),
seules les lignes de base de données manquaient.

Idempotent : peut être relancée sans dupliquer les annonces (dédoublonnage par titre).
"""
from django.core.management.base import BaseCommand, CommandError
from django.db import transaction

from Agri_Connect_CI.models import (
    Annonce, AnnonceProduit, AnnonceImage, TypeAnnonce, Zone,
    CategorieProduit, UniteMesure, Devise, Conditionnement, Certification,
    Producteur,
)


def safe_get_or_create(model, defaults=None, **kwargs):
    """Like get_or_create, but tolerates pre-existing duplicate rows in
    production (no unique constraint backs these lookup fields) instead of
    raising MultipleObjectsReturned."""
    obj = model.objects.filter(**kwargs).first()
    if obj is not None:
        return obj, False
    params = dict(kwargs)
    params.update(defaults or {})
    return model.objects.create(**params), True

ZONES = {
    1: ('Abidjan', 'Cocody', '22501'),
    2: ('Abidjan', 'Yopougon', '22502'),
    3: ('Bouaké', 'Belle Ville', '27001'),
    6: ('Abidjan', 'Treichville', '00225'),
    7: ('Daloa', 'Liberté', '00225'),
    9: ('San Pedro', 'Quartier des pêcheurs', '01532'),
    10: ('Korhogo', 'Commerce', '03210'),
}

CATEGORIES = {
    1: 'Fruits', 2: 'Légumes', 4: 'Produits laitiers', 5: 'Épices', 6: 'Miels',
}

UNITES = {
    1: ('kilogramme', 'kg'),
    3: ('litre', 'l'),
}

DEVISES = {
    1: ('XOF', 'Franc CFA'),
}

CONDITIONNEMENTS = {
    1: ('Sac de jute', 'Sac de jute 50kg'),
    2: ('Bidon', 'Bidon de 20 litres'),
    3: ('Panier', 'Panier en osier de 3kg'),
    4: ('Caisse', 'Caisse en bois de 10kg'),
}

CERTIFICATIONS = {
    1: ('BIO', "Agence Bio Côte d'Ivoire", 'Certification bio reconnue en Côte d\'Ivoire'),
    2: ('Agriculture Durable', "Ministère de l'Agriculture", 'Label agriculture durable'),
}

# (titre, description, zone_id, [images], produit)
# produit = (nom_produit, quantite, prix_unitaire, livraison_disponible,
#            categorie_id, certification_id, conditionnement_id, devise_id, unite_id)
ANNONCES = [
    (
        'Mangue sucrée du nord',
        'Mangues juteuses et sucrées de Tunis, fraîchement cueillies.',
        3,
        ['images_2.jpeg', 'images_3.jpeg'],
        ('Mangue Bio', 200, 100, True, 1, 1, 4, 1, 1),
    ),
    (
        'Lait caillé en bidon',
        'Lait fermenté naturel, sans additifs.',
        1,
        ['laitcaill-scaled_ErNdaVh.jpg', 'deux-bouteilles-plastique_1203-1890-removebg-preview_J4fRDnp.png'],
        ('Lait caillé', 20, 300, True, 4, 1, 2, 1, 3),
    ),
    (
        'Vente de belle banane douce cultivées avec soin.',
        'ndqnkqs',
        2,
        ['banane-1a-1200x838.jpg', 'téléchargement_5.jpeg'],
        ('Banane', 200, 100, True, 1, None, None, 1, 1),
    ),
    (
        'Fromage frais local',
        'Fromage de vache fermier, fait à la main chaque jour.',
        6,
        ['Photoroom-20250223_135156_1-1024x1024.png', 'malte-haz-zebbug-ferme-tal-karmnu-fabrication-gbejna-fromage-local-brebis.jpg'],
        ('Fromage', 100, 900, True, 4, 1, 4, 1, 1),
    ),
    (
        'Papaye mûre prête à consommer',
        'Papayes douces et bien mûres, idéales pour jus ou desserts.',
        7,
        ['7866-PAPAYE-min-1-scaled.jpg', 'téléchargement_4.jpeg', 'comment-bien-choisir-preparer-et-consommer-la-papaye.jpeg'],
        ('Papaye', 150, 120, False, 1, 2, 3, 1, 1),
    ),
    (
        'Laitue bio fraîche du matin',
        'Laitue cultivée sans pesticides, fraîchement récoltée chaque matin.',
        2,
        ['téléchargement_UXkzA82.jpeg', 'téléchargement_1_5ENIB30.jpeg'],
        ('Laitue bio', 50, 500, True, 2, 1, 3, 1, 1),
    ),
    (
        'Patates douces bio en stock',
        "Cultivées sans engrais chimiques, idéales pour une alimentation saine. Disponibles en sac de jute de 50kg.",
        7,
        ['téléchargement_3.jpeg', 'images_5.jpeg', 'images_6.jpeg'],
        ('Patate douce', 300, 250, True, 2, 1, 1, 1, 1),
    ),
    (
        'Épices bio de qualité supérieure',
        'Piment, gingembre et curcuma cultivés sans pesticides, séchés naturellement.',
        10,
        ['D9_Image_en-tête_articles_télécharger_à_90_jpeg_16.jpg', 'melanges-epices.jpg', 'Epices_1200x630.jpg'],
        ('Piment rouge séché', 50, 3500, True, 5, None, 1, 1, 1),
    ),
    (
        'Miel pur 100% naturel',
        "Miel récolté dans les forêts de Côte d'Ivoire, sans additifs ni conservateurs.",
        9,
        ['pure-natural-honey.jpg', '20241111_143624.jpg', 'images_8.jpeg'],
        ('Miel de forêt', 30, 5000, True, 6, None, 2, 1, 3),
    ),
]


class Command(BaseCommand):
    help = "Charge des annonces de démonstration (produits + photos) manquantes en production."

    def handle(self, *args, **options):
        auteur = Producteur.objects.select_related('utilisateur').first()
        if not auteur:
            raise CommandError(
                "Aucun compte Producteur trouvé en base. Créez au moins un compte "
                "producteur (via l'inscription du site) avant de relancer cette commande."
            )

        type_annonce, _ = safe_get_or_create(TypeAnnonce, nom='Vente de produits agricoles')

        zones = {
            zid: safe_get_or_create(Zone, ville=v, quartier=q, code_postal=cp)[0]
            for zid, (v, q, cp) in ZONES.items()
        }
        categories = {
            cid: safe_get_or_create(CategorieProduit, nom=n)[0]
            for cid, n in CATEGORIES.items()
        }
        unites = {
            uid: safe_get_or_create(UniteMesure, nom=n, defaults={'abbr': a})[0]
            for uid, (n, a) in UNITES.items()
        }
        devises = {
            did: safe_get_or_create(Devise, code=c, nom=n)[0]
            for did, (c, n) in DEVISES.items()
        }
        conditionnements = {
            cid: safe_get_or_create(Conditionnement, nom=n, defaults={'description': d})[0]
            for cid, (n, d) in CONDITIONNEMENTS.items()
        }
        certifications = {
            cid: safe_get_or_create(
                Certification, nom=n, defaults={'organisme_emetteur': o, 'description': d}
            )[0]
            for cid, (n, o, d) in CERTIFICATIONS.items()
        }

        created_count = 0
        skipped_count = 0

        with transaction.atomic():
            for titre, description, zone_id, images, produit in ANNONCES:
                annonce, created = safe_get_or_create(
                    Annonce,
                    titre=titre,
                    defaults={
                        'description': description,
                        'statut': 'active',
                        'auteur': auteur.utilisateur,
                        'type_annonce': type_annonce,
                        'zone': zones[zone_id],
                    },
                )
                if not created:
                    skipped_count += 1
                    self.stdout.write(f"  déjà présente, ignorée : {titre}")
                    continue

                created_count += 1
                (nom_produit, quantite, prix_unitaire, livraison, cat_id,
                 cert_id, cond_id, dev_id, unit_id) = produit

                safe_get_or_create(
                    AnnonceProduit,
                    annonce=annonce,
                    nom_produit=nom_produit,
                    defaults={
                        'quantite': quantite,
                        'prix_unitaire': prix_unitaire,
                        'livraison_disponible': livraison,
                        'categorie': categories[cat_id],
                        'certification': certifications[cert_id] if cert_id else None,
                        'conditionnement': conditionnements[cond_id] if cond_id else None,
                        'devise': devises[dev_id],
                        'unite': unites[unit_id],
                    },
                )

                for filename in images:
                    safe_get_or_create(
                        AnnonceImage,
                        annonce=annonce,
                        url_image=f'annonces/images/{filename}',
                    )

                self.stdout.write(self.style.SUCCESS(f"  créée : {titre}"))

        self.stdout.write(self.style.SUCCESS(
            f"Terminé. {created_count} annonce(s) créée(s), {skipped_count} déjà présente(s)."
        ))
