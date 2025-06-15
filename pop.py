import os
import random
from datetime import datetime, timedelta
from django.core.files import File
from django.utils import timezone
from Agri_Connect_CI.models import *

# Configuration des données typiquement ivoiriennes
NOMS_IVOIRIENS = [
    ("Kouassi", "Amani"), ("Yao", "Koffi"), ("Aïcha", "Koné"),
    ("Eric", "Touré"), ("Fatou", "Diabaté"), ("Jean", "Gnahoré"),
    ("Aminata", "Cissé"), ("Mohamed", "Sylla"), ("Adjoua", "Bamba")
]

PRODUITS_LOCAUX = [
    "Mangue Kent", "Ananas Pain de Sucre", "Igname", 
    "Banane Plantin", "Poulet Bicyclette", "Cacao",
    "Piment", "Aubergine Africaine"
]

VILLES_IVOIRE = ["Abidjan", "Bouaké", "Daloa", "Korhogo", "San-Pédro"]

def generate_ivoirian_phone():
    return f"+22507{random.randint(10, 89)}{random.randint(100, 999)}{random.randint(10, 99)}"

def create_small_dataset():
    print("🔹 Création d'un petit jeu de données réaliste (10-20 entrées)")

    # 1. Créer 5 utilisateurs (2 acheteurs, 2 producteurs, 1 livreur)
    for i, (nom, prenom) in enumerate(random.sample(NOMS_IVOIRIENS, 5)):
        user = Utilisateur.objects.create(
            username=f"{prenom.lower()}{nom.lower()[:2]}{i}",
            full_name=f"{prenom} {nom}",
            role=random.choice(["acheteur", "producteur", "livreur"]),
            statut_verification="vérifié" if i % 2 == 0 else "non vérifié",
            date_inscription=timezone.now() - timedelta(days=random.randint(1, 30)))
        
        # Contact téléphone
        Contact.objects.create(
            utilisateur=user,
            type_contact=TypeContact.objects.get_or_create(nom="Téléphone")[0],
            valeur=generate_ivoirian_phone()
        )

        # Créer profils associés
        if user.role == "producteur":
            Producteur.objects.create(
                utilisateur=user,
                methode_production=random.choice(["bio", "traditionnel"]),
                description_longue=f"Producteur de {random.choice(PRODUITS_LOCAUX)} à {random.choice(VILLES_IVOIRE)}"
            )
        elif user.role == "livreur":
            Livreur.objects.create(
                utilisateur=user,
                description=f"Livreur professionnel à {random.choice(VILLES_IVOIRE)}"
            )

    # 2. Créer 3 annonces avec produits locaux
    producteurs = Producteur.objects.all()
    for i in range(3):
        annonce = Annonce.objects.create(
            auteur=random.choice(Utilisateur.objects.filter(role="producteur")),
            titre=f"Vente de {random.choice(PRODUITS_LOCAUX)}",
            description=f"Production locale de qualité à {random.choice(VILLES_IVOIRE)}",
            statut="active"
        )
        
        # Produit associé
        AnnonceProduit.objects.create(
            annonce=annonce,
            nom_produit=annonce.titre.replace("Vente de ", ""),
            quantite=random.randint(10, 100),
            prix_unitaire=random.choice([500, 1000, 1500, 2000]),
            devise=Devise.objects.get_or_create(code="XOF", defaults={"nom": "Franc CFA"})[0],
            conditionnement=random.choice(["Sac", "Cageot", "Kg"])
        )

        # Image par défaut
        AnnonceImage.objects.create(
            annonce=annonce,
            url_image="annonces/images/default.jpg",
            legende=f"Photo de {annonce.titre}"
        )

    # 3. Créer 2 mises en relation
    for _ in range(2):
        MiseEnRelation.objects.create(
            client=random.choice(Utilisateur.objects.filter(role="acheteur")),
            producteur=random.choice(producteurs),
            moyen_contact=TypeContact.objects.get(nom="Téléphone")
        )

    print("✅ Données créées avec succès !")
    print(f"Utilisateurs: {Utilisateur.objects.count()}")
    print(f"Annonces: {Annonce.objects.count()}")
    print(f"Mises en relation: {MiseEnRelation.objects.count()}")

if __name__ == "__main__":
    create_small_dataset()