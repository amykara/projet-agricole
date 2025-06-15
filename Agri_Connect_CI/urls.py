from django.urls import path
from . import views 
from .views import*

urlpatterns = [
    # Page d'accueil
    path('', views.home, name='home'),
    
    # Accueil connecté
    path('accueil-connecte/', views.home, name='home_connected'),
    
   
    
    # Inscription/Connexion
    path('inscription/', views.inscription, name='inscription'),

    path('connexion/', views.connexion, name='connexion'),
    
    path('deconnexion/', views.deconnexion, name='deconnexion'),

    path('annonce/<int:annonce_id>/', views.annonce_detail, name='annonce_detail'),

    path('annonce/<int:annonce_id>/whatsapp/', contacter_via_whatsapp, name='contacter_whatsapp'),
    
    path('favoris/toggle/<int:annonce_id>/', toggle_favori, name='toggle_favori'),

    path('producteur/<int:producteur_id>/noter/', noter_producteur, name='noter_producteur'),

    path('notation/<int:notation_id>/supprimer/', views.supprimer_notation, name='supprimer_notation'),

    path('producteur/<int:producteur_id>/', producteur_detail, name='producteur_detail'),
    
    path('livreur/<int:livreur_id>/', livreur_detail, name='livreur_detail'),


    path('livreur/<int:livreur_id>/noter/', views.noter_livreur, name='noter_livreur'),
    path('livreur/<int:livreur_id>/supprimer-notation/', views.supprimer_notation_livreur, name='supprimer_notation_livreur'),
    path('livreur/<int:livreur_id>/contacter-whatsapp/', views.contacter_livreur_whatsapp, name='contacter_livreur_whatsapp'),

  
    path('favoris/ajouter/<int:annonce_id>/', views.ajouter_favori, name='ajouter_favori'),
    path('favoris/supprimer/<int:annonce_id>/', views.supprimer_favori, name='supprimer_favori'),
    path('mes-annonces/supprimer/<int:annonce_id>/', views.supprimer_annonce, name='supprimer_annonce'),

    path('mes-annonces/republier/<int:annonce_id>/', views.republier_annonce, name='republier_annonce'),

    path('tableau-de-bord-acheteur/', views.tableau_de_bord_acheteur, name='tableau_de_bord_acheteur'),
   
      # Tableaux de bord

   
    
    path('livreur/statut/', update_livreur_statut, name='update_livreur_statut'),
    path('livreur/annonces/creer/', creer_annonce_livreur, name='creer_annonce_livreur'),
    path('livreur/annonces/<int:annonce_id>/modifier/', modifier_annonce_livreur, name='modifier_annonce_livreur'),
    path('livreur/annonces/<int:annonce_id>/supprimer/', supprimer_annonce_livreur, name='supprimer_annonce_livreur'),
    path('livreur/annonces/<int:annonce_id>/republier/', republier_annonce_livreur, name='republier_annonce_livreur'),
    path('livreur/relations/', historique_relations_livreur, name='historique_relations_livreur'),
    path('livreur/relations/<int:relation_id>/', detail_relation_livreur, name='detail_relation_livreur'),
    path('livreur/notifications/<int:notification_id>/marquer-lue/', marquer_notification_lue, name='marquer_notification_lue'),
    path('livreur/notifications/marquer-toutes-lues/', marquer_notifications_lues, name='marquer_notifications_lues'),

   path('dashboard/producteur/', views.tableau_bord_producteur, name='tableau_bord_producteur'),
   path('dashboard/livreur/', views.tableau_bord_livreur, name='tableau_bord_livreur'),

    path('dashboard/producteur/creer-annonce/', views.creer_annonce, name='create_annonce'),

   

    path('api/produits-par-categorie/', views.produits_par_categorie, name='produits_par_categorie'),
   
    path('produits/autocomplete/', views.autocomplete_produits, name='autocomplete_produits'),

    path('devenir-producteur/', inscription_producteur, name='inscription_producteur'), 
    path('livreur/editer-profil/', editer_profil_livreur, name='editer_profil_livreur'),

    path('<str:page_name>/', views.page_view, name='page'),
   
   
]
