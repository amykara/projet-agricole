# AgriConnect CI

Plateforme web mettant en relation agriculteurs, producteurs, livreurs et clients en Côte d'Ivoire : dépôt d'annonces de produits agricoles, mise en relation directe, gestion de livraisons et système de notation.

## Fonctionnalités principales

- Inscription et gestion de profils (producteur, livreur, client)
- Dépôt et consultation d'annonces de produits agricoles (avec photos, zones, prix)
- Mise en relation directe entre producteurs et clients (contact WhatsApp intégré)
- Gestion des livreurs : zones de couverture, véhicules, disponibilité
- Système de notation (producteurs et livreurs)
- Favoris, notifications, historique de contacts

## Stack technique

- **Backend** : Django, Django REST Framework
- **Base de données** : PostgreSQL (production) / SQLite (développement local)
- **Frontend** : HTML, CSS, Bootstrap
- **Admin** : Jazzmin (interface d'administration personnalisée)

## Installation en local

```bash
git clone https://github.com/amykara/projet-agricole.git
cd projet-agricole
python -m venv venv
source venv/bin/activate  # Windows : venv\Scripts\activate
pip install -r requirements.txt
python manage.py migrate
python manage.py loaddata datadump.json   # charge des données de démonstration
python manage.py runserver
```

Copier `.env.example` en `.env` et renseigner une valeur pour `SECRET_KEY` avant de lancer le serveur.

## Déploiement

Projet configuré pour un déploiement sur [Render](https://render.com) (PostgreSQL, Gunicorn, WhiteNoise pour les fichiers statiques).

## Contexte

Projet réalisé en Licence 3 Génie Informatique, Université Nangui Abrogoua.
