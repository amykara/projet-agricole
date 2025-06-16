-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mar. 17 juin 2025 à 01:44
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `agriculture_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_annonce`
--

CREATE TABLE `agri_connect_ci_annonce` (
  `id` bigint(20) NOT NULL,
  `titre` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `date_annonce` datetime(6) NOT NULL,
  `statut` varchar(20) NOT NULL,
  `auteur_id` bigint(20) NOT NULL,
  `type_annonce_id` bigint(20) NOT NULL,
  `zone_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_annonce`
--

INSERT INTO `agri_connect_ci_annonce` (`id`, `titre`, `description`, `date_annonce`, `statut`, `auteur_id`, `type_annonce_id`, `zone_id`) VALUES
(2, 'Mangue sucrée du nord', 'Mangues juteuses et sucrées de Tunis, fraîchement cueillies.', '2025-06-10 22:08:48.772834', 'active', 1, 1, 3),
(3, 'Acte de Charité', 'Je suis un nouveau livreur , et j\'offre mes services de livraison à 500FCFA , partout à Abidjan', '2025-06-12 00:48:30.195584', 'active', 7, 5, 1),
(5, 'Lait caillé en bidon', 'Lait fermenté naturel, sans additifs.', '2025-06-13 23:32:36.038673', 'active', 12, 1, 1),
(8, 'Vente de belle banane douce cultivées avec soin.', 'ndqnkqs', '2025-06-14 10:17:06.857470', 'active', 12, 1, 2),
(9, 'Fromage frais local', 'romage de vache fermier, fait à la main chaque jour.', '2025-06-14 10:17:39.376276', 'active', 6, 1, 6),
(10, 'Papaye mûre prête à consommer', 'Papayes douces et bien mûres, idéales pour jus ou desserts.', '2025-06-14 13:06:30.223399', 'active', 12, 1, 7),
(11, 'Laitue bio fraîche du matin', 'Laitue cultivée sans pesticides, fraîchement récoltée chaque matin.', '2025-06-14 13:10:35.224919', 'active', 5, 1, 2),
(12, 'Patates douces bio en stock', 'Cultivées sans engrais chimiques, idéales pour une alimentation saine. Disponibles en sac de jute de 50kg.', '2025-06-14 13:13:47.664012', 'active', 12, 1, 7),
(13, 'Don de tomates trop mûres', ': Tomates très mûres gratuites pour coulis ou compost.', '2025-06-15 13:57:16.082810', 'active', 5, 5, 5),
(14, 'Troc : Maïs contre engrais bio', 'Échange 100 kg de maïs contre sac d\'engrais organique.', '2025-06-15 14:00:02.957632', 'active', 6, 6, 5),
(15, 'Livraison de produits agricoles à bas coût', 'Je livre vos fruits/légumes pour 500 FCFA dans Abidjan.', '2025-06-15 14:01:58.638664', 'active', 7, 3, 1),
(16, 'Service de livraison agricole express', 'Livraison de vos produits agricoles à domicile à partir de 700 FCFA, zone Abidjan.', '2025-06-15 23:33:37.964857', 'active', 10, 3, 4),
(17, 'Livraison restaurant', 'Disponible pour livrer les petits restaurants qui commande chez des producteur , partout dans le petit Abidjan à 1500 fcfa , pour plus d\'information veuillez me contacter via mon numero de telephone ou whatsapp', '2025-06-16 18:46:16.896878', 'active', 10, 5, 2),
(18, 'Besoin d\'un livreur', 'Besoin d\'un livreur pour une semaine , salaire 100000fcfa , plus d\'infos en inbox', '2025-06-16 19:21:55.566883', 'active', 15, 2, 1),
(21, 'Acte de Charité ', 'kjopn,ojoojoj', '2025-06-16 19:36:26.755609', 'active', 12, 3, NULL),
(22, 'Épices bio de qualité supérieure', 'Piment, gingembre et curcuma cultivés sans pesticides, séchés naturellement.', '2025-06-15 09:30:00.000000', 'active', 16, 1, 10),
(23, 'Miel pur 100% naturel', 'Miel récolté dans les forêts de Côte d\'Ivoire, sans additifs ni conservateurs.', '2025-06-16 10:45:00.000000', 'active', 19, 1, 9),
(24, 'Ananas sucrés de saison', 'Ananas cultivés en plein champ, récoltés à maturité, très sucrés et juteux.', '2025-06-20 08:00:00.000000', 'active', 22, 1, 11),
(25, 'Riz bio de qualité supérieure', 'Riz cultivé sans engrais chimiques ni pesticides, produit par une coopérative de 50 agriculteurs.', '2025-06-21 09:30:00.000000', 'active', 23, 1, 12);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_annonceimage`
--

CREATE TABLE `agri_connect_ci_annonceimage` (
  `id` bigint(20) NOT NULL,
  `url_image` varchar(100) NOT NULL,
  `legende` varchar(255) DEFAULT NULL,
  `annonce_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_annonceimage`
--

INSERT INTO `agri_connect_ci_annonceimage` (`id`, `url_image`, `legende`, `annonce_id`) VALUES
(3, 'annonces/images/images_2.jpeg', NULL, 2),
(4, 'annonces/images/images_3.jpeg', NULL, 2),
(12, 'annonces/images/téléchargement_3.jpeg', NULL, 12),
(13, 'annonces/images/images_5.jpeg', NULL, 12),
(14, 'annonces/images/images_6.jpeg', NULL, 12),
(17, 'annonces/images/7866-PAPAYE-min-1-scaled.jpg', NULL, 10),
(18, 'annonces/images/téléchargement_4.jpeg', NULL, 10),
(19, 'annonces/images/comment-bien-choisir-preparer-et-consommer-la-papaye.jpeg', NULL, 10),
(20, 'annonces/images/Photoroom-20250223_135156_1-1024x1024.png', NULL, 9),
(21, 'annonces/images/malte-haz-zebbug-ferme-tal-karmnu-fabrication-gbejna-fromage-local-brebis.jpg', NULL, 9),
(22, 'annonces/images/banane-1a-1200x838.jpg', NULL, 8),
(23, 'annonces/images/téléchargement_5.jpeg', NULL, 8),
(26, 'annonces/images/téléchargement_UXkzA82.jpeg', NULL, 11),
(27, 'annonces/images/téléchargement_1_5ENIB30.jpeg', NULL, 11),
(28, 'annonces/images/laitcaill-scaled_ErNdaVh.jpg', NULL, 5),
(29, 'annonces/images/deux-bouteilles-plastique_1203-1890-removebg-preview_J4fRDnp.png', NULL, 5),
(30, 'annonces/images/images_4_twN7yCh.jpeg', NULL, 15),
(32, 'annonces/images/images_4_dQhEIP8.jpeg', NULL, 18),
(33, 'annonces/images/images_7.jpeg', NULL, 25),
(34, 'annonces/images/téléchargement_7.jpeg', NULL, 24),
(35, 'annonces/images/ananas-pain-de-sucre-piece.jpg', NULL, 24),
(36, 'annonces/images/téléchargement_6.jpeg', NULL, 24),
(37, 'annonces/images/pure-natural-honey.jpg', NULL, 23),
(38, 'annonces/images/20241111_143624.jpg', NULL, 23),
(39, 'annonces/images/images_8.jpeg', NULL, 23),
(40, 'annonces/images/D9_Image_en-tête_articles_télécharger_à_90_jpeg_16.jpg', NULL, 22),
(41, 'annonces/images/melanges-epices.jpg', NULL, 22),
(42, 'annonces/images/Epices_1200x630.jpg', NULL, 22);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_annonceproduit`
--

CREATE TABLE `agri_connect_ci_annonceproduit` (
  `id` bigint(20) NOT NULL,
  `nom_produit` varchar(100) NOT NULL,
  `quantite` decimal(10,2) NOT NULL,
  `prix_unitaire` decimal(10,2) NOT NULL,
  `livraison_disponible` tinyint(1) NOT NULL,
  `annonce_id` bigint(20) NOT NULL,
  `categorie_id` bigint(20) NOT NULL,
  `certification_id` bigint(20) DEFAULT NULL,
  `conditionnement_id` bigint(20) DEFAULT NULL,
  `devise_id` bigint(20) DEFAULT NULL,
  `unite_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_annonceproduit`
--

INSERT INTO `agri_connect_ci_annonceproduit` (`id`, `nom_produit`, `quantite`, `prix_unitaire`, `livraison_disponible`, `annonce_id`, `categorie_id`, `certification_id`, `conditionnement_id`, `devise_id`, `unite_id`) VALUES
(4, 'Mangue Bio', 200.00, 100.00, 1, 2, 1, 1, 4, 1, 1),
(6, 'Lait caillé', 20.00, 300.00, 1, 5, 4, 1, 2, 1, 3),
(7, 'Banane', 200.00, 100.00, 1, 8, 1, NULL, NULL, 1, 1),
(8, 'Patate douce', 300.00, 250.00, 1, 12, 2, 1, 1, 1, 1),
(9, 'Laitue bio', 50.00, 500.00, 1, 11, 2, 1, 3, 1, 1),
(10, 'Papaye', 150.00, 120.00, 0, 10, 1, 2, 3, 1, 1),
(11, 'Fromage', 100.00, 900.00, 1, 9, 4, 1, 4, 1, 1),
(12, 'Tomates', 25.00, 0.00, 0, 13, 2, NULL, 3, 1, 1),
(13, 'Maïs', 100.00, 300.00, 0, 14, 3, NULL, 1, 1, 1),
(14, 'Aucun', 1000.00, 125.00, 0, 15, 1, NULL, NULL, 1, 1),
(15, 'aucun', 1.00, 1.00, 0, 16, 1, 1, 2, 1, 4),
(17, 'Piment rouge séché', 50.00, 3500.00, 1, 22, 5, NULL, 1, 1, 1),
(18, 'Miel de forêt', 30.00, 5000.00, 1, 23, 6, NULL, 2, 1, 3);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_capacitevehicule`
--

CREATE TABLE `agri_connect_ci_capacitevehicule` (
  `id` bigint(20) NOT NULL,
  `valeur` decimal(10,2) NOT NULL,
  `description` varchar(100) NOT NULL,
  `unite_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_capacitevehicule`
--

INSERT INTO `agri_connect_ci_capacitevehicule` (`id`, `valeur`, `description`, `unite_id`) VALUES
(3, 1000.00, '', 1),
(4, 50.00, 'moto de livraison', 1),
(5, 1000.00, 'Tricycle pour livraison', 1),
(6, 10.00, 'Vélo de livraison', 1),
(7, 2000.00, 'Camion frigorifique', 1);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_categorieproduit`
--

CREATE TABLE `agri_connect_ci_categorieproduit` (
  `id` bigint(20) NOT NULL,
  `nom` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_categorieproduit`
--

INSERT INTO `agri_connect_ci_categorieproduit` (`id`, `nom`) VALUES
(1, 'Fruits'),
(2, 'Légumes'),
(3, 'Céréales'),
(4, 'Produits laitiers'),
(5, 'Épices'),
(6, 'Miels'),
(7, 'Jus naturels'),
(8, 'Riz et céréales'),
(9, 'Fruits tropicaux');

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_certification`
--

CREATE TABLE `agri_connect_ci_certification` (
  `id` bigint(20) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `organisme_emetteur` varchar(100) DEFAULT NULL,
  `description` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_certification`
--

INSERT INTO `agri_connect_ci_certification` (`id`, `nom`, `organisme_emetteur`, `description`) VALUES
(1, 'BIO', 'Agence Bio Côte d\'Ivoire', 'Certification bio reconnue en Côte d\'Ivoire'),
(2, 'Agriculture Durable', 'Ministère de l\'Agriculture', 'Label agriculture durable'),
(3, 'Ecocert', 'Ecocert Afrique', NULL),
(4, 'Fairtrade', 'Fairtrade International', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_conditionnement`
--

CREATE TABLE `agri_connect_ci_conditionnement` (
  `id` bigint(20) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_conditionnement`
--

INSERT INTO `agri_connect_ci_conditionnement` (`id`, `nom`, `description`) VALUES
(1, 'Sac de jute', 'Sac de jute 50kg'),
(2, 'Bidon', 'Bidon de 20 litres'),
(3, 'Panier', 'Panier en osier de 3kg'),
(4, 'Caisse', 'Caisse en bois de 10kg');

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_contact`
--

CREATE TABLE `agri_connect_ci_contact` (
  `id` bigint(20) NOT NULL,
  `valeur` varchar(255) NOT NULL,
  `type_contact_id` bigint(20) NOT NULL,
  `utilisateur_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_contact`
--

INSERT INTO `agri_connect_ci_contact` (`id`, `valeur`, `type_contact_id`, `utilisateur_id`) VALUES
(1, 'kouadio.alain@example.ci', 1, 1),
(2, '+2250701010101', 2, 1),
(3, '+2250701010101', 3, 1),
(4, 'yamahiou.bernard@example.ci', 1, 2),
(5, '+2250702020202', 2, 3),
(6, '+2250702020202', 3, 3),
(7, '+2250701010101', 2, 5),
(8, '+2250502020202', 3, 6),
(9, '+2250103030303', 2, 7),
(10, 'yamahioubernard12@gmail.com', 1, 9),
(11, '+2250701850708', 2, 9),
(12, '+2250546282358', 3, 7),
(13, '+2250505852591', 3, 9),
(14, 'liliberry125@gmail.com', 1, 10),
(15, '+2250777984917', 3, 10),
(16, 'rubin123@gmail.com', 1, 12),
(17, '+2250702850709', 2, 12),
(18, 'jkouassi123@gmail.com', 1, 14),
(19, '+2250702850709', 2, 14),
(20, 'missdiana925@gmail.com', 1, 15),
(21, '+2250701850708', 2, 15),
(22, '+2250701234567', 3, 16),
(23, '+2250707654321', 2, 17);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_devise`
--

CREATE TABLE `agri_connect_ci_devise` (
  `id` bigint(20) NOT NULL,
  `code` varchar(10) NOT NULL,
  `nom` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_devise`
--

INSERT INTO `agri_connect_ci_devise` (`id`, `code`, `nom`) VALUES
(1, 'XOF', 'Franc CFA'),
(2, 'EUR', 'Euro'),
(3, 'USD', 'Dollar US'),
(5, 'USD', 'Dollar Américain');

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_disponibilitelivreur`
--

CREATE TABLE `agri_connect_ci_disponibilitelivreur` (
  `id` bigint(20) NOT NULL,
  `jour_semaine` varchar(20) NOT NULL,
  `date_debut` datetime(6) NOT NULL,
  `date_fin` datetime(6) NOT NULL,
  `statut` varchar(20) NOT NULL,
  `livreur_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_disponibilitelivreur`
--

INSERT INTO `agri_connect_ci_disponibilitelivreur` (`id`, `jour_semaine`, `date_debut`, `date_fin`, `statut`, `livreur_id`) VALUES
(1, 'lundi', '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000', 'disponible', 1),
(2, 'mercredi', '0000-00-00 00:00:00.000000', '0000-00-00 00:00:00.000000', 'disponible', 1);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_documentproducteur`
--

CREATE TABLE `agri_connect_ci_documentproducteur` (
  `id` bigint(20) NOT NULL,
  `type_document` varchar(20) NOT NULL,
  `fichier` varchar(100) NOT NULL,
  `date_upload` datetime(6) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `producteur_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_etatlivreur`
--

CREATE TABLE `agri_connect_ci_etatlivreur` (
  `id` bigint(20) NOT NULL,
  `nom` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_etatlivreur`
--

INSERT INTO `agri_connect_ci_etatlivreur` (`id`, `nom`) VALUES
(1, 'Disponible'),
(2, 'Indisponible');

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_faq`
--

CREATE TABLE `agri_connect_ci_faq` (
  `id` bigint(20) NOT NULL,
  `question` longtext NOT NULL,
  `reponse` longtext NOT NULL,
  `categorie` varchar(20) NOT NULL,
  `ordre_affichage` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_faq`
--

INSERT INTO `agri_connect_ci_faq` (`id`, `question`, `reponse`, `categorie`, `ordre_affichage`) VALUES
(1, 'Qu\'est-ce qu\'AgriMarket ?', 'AgriMarket est une plateforme qui met en relation directe les producteurs agricoles locaux avec les acheteurs, sans intermédiaire. Notre objectif est de favoriser les circuits courts et de permettre aux producteurs de vendre leurs produits à un prix juste, tout en offrant aux consommateurs des produits frais et de qualité.', 'general', 1),
(2, 'Comment fonctionne la plateforme ?', 'Les producteurs créent des annonces pour leurs produits. Les acheteurs peuvent parcourir le catalogue, filtrer selon leurs préférences et contacter directement les producteurs via WhatsApp pour organiser l\'achat. Un service de livraison optionnel est également disponible pour faciliter les échanges.', 'general', 2),
(3, 'L\'inscription est-elle gratuite ?', 'Oui, l\'inscription sur AgriMarket est entièrement gratuite pour tous les utilisateurs, qu\'ils soient acheteurs, producteurs ou livreurs. Nous ne prenons aucune commission sur les ventes réalisées via notre plateforme.', 'general', 3),
(4, 'Comment contacter le service client ?', 'Vous pouvez nous contacter par email à support@agrimarket.fr ou par téléphone au +33 1 23 45 67 89. Notre équipe est disponible du lundi au vendredi, de 9h à 18h.', 'general', 4),
(5, 'Comment acheter des produits sur AgriMarket ?', 'Pour acheter des produits, créez d\'abord un compte acheteur. Ensuite, parcourez le catalogue de produits, utilisez les filtres pour trouver ce qui vous intéresse, et contactez directement le producteur via le bouton WhatsApp présent sur chaque annonce.', 'acheteur', 1),
(6, 'Comment sont fixés les prix des produits ?', 'Les prix sont librement fixés par les producteurs eux-mêmes. Comme il n\'y a pas d\'intermédiaire, les prix sont généralement plus avantageux que dans le commerce traditionnel, tout en étant plus rémunérateurs pour les producteurs.', 'acheteur', 2),
(7, 'Puis-je évaluer un producteur après un achat ?', 'Oui, après chaque transaction, vous pouvez laisser une évaluation (note et commentaire) pour le producteur. Cela aide les autres acheteurs à faire leurs choix et encourage les producteurs à maintenir une qualité de service élevée.', 'acheteur', 3),
(8, 'Comment fonctionne la livraison ?', 'Vous pouvez soit convenir d\'un point de rencontre avec le producteur, soit faire appel à un livreur partenaire d\'AgriMarket. Les frais et modalités de livraison sont à convenir directement avec le producteur ou le livreur.', 'acheteur', 4),
(9, 'Comment devenir producteur sur AgriMarket ?', 'Pour devenir producteur, créez un compte via le lien \"Devenir producteur\" et remplissez le formulaire d\'inscription avec vos informations personnelles et professionnelles. Vous devrez fournir une pièce d\'identité et quelques documents justificatifs. Votre demande sera examinée par notre équipe et vous recevrez une réponse sous 48 heures.', 'producteur', 1),
(10, 'Comment publier une annonce ?', 'Une fois votre compte validé, connectez-vous et accédez à votre tableau de bord. Cliquez sur \"Créer une nouvelle annonce\" et remplissez le formulaire avec le titre, la description, le prix, la quantité disponible et ajoutez des photos de qualité. Votre annonce sera immédiatement publiée après validation.', 'producteur', 2),
(11, 'Y a-t-il des frais pour les producteurs ?', 'Non, l\'utilisation d\'AgriMarket est entièrement gratuite pour les producteurs. Nous ne prenons aucune commission sur vos ventes. Notre modèle économique repose sur des services optionnels que nous développons en parallèle.', 'producteur', 3),
(12, 'Comment gérer mes annonces ?', 'Depuis votre tableau de bord, vous pouvez voir toutes vos annonces actives, réservées ou archivées. Vous pouvez modifier une annonce, changer son statut, ajouter des photos ou la supprimer à tout moment.', 'producteur', 4),
(13, 'Comment devenir livreur partenaire ?', 'Pour devenir livreur, inscrivez-vous via le lien \"Devenir livreur\" et remplissez le formulaire avec vos informations personnelles, votre zone de livraison et le type de véhicule que vous utilisez. Vous devrez fournir une pièce d\'identité et des documents sur votre véhicule. Votre demande sera examinée et vous recevrez une réponse sous 48 heures.', 'livreur', 1),
(14, 'Comment sont rémunérées les livraisons ?', 'Les tarifs de livraison sont fixés librement entre vous, le producteur et l\'acheteur. AgriMarket ne prend aucune commission sur ces transactions. Vous êtes libre d\'accepter ou de refuser une proposition de livraison.', 'livreur', 2),
(15, 'Comment trouver des opportunités de livraison ?', 'Une fois connecté à votre compte livreur, votre tableau de bord affichera les demandes de livraison disponibles dans votre zone. Vous pouvez également être directement contacté par des producteurs ou des acheteurs via WhatsApp pour organiser une livraison.', 'livreur', 3),
(16, 'Quelles sont les conditions pour être livreur ?', 'Pour être livreur, vous devez être majeur, posséder un véhicule approprié (vélo, scooter, voiture, camionnette), avoir une assurance valide et pouvoir justifier de votre identité. Vous devez également respecter les normes d\'hygiène et de sécurité pour le transport de produits alimentaires.', 'livreur', 4);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_favoris`
--

CREATE TABLE `agri_connect_ci_favoris` (
  `id` bigint(20) NOT NULL,
  `date_ajout` datetime(6) NOT NULL,
  `annonce_id` bigint(20) NOT NULL,
  `utilisateur_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_favoris`
--

INSERT INTO `agri_connect_ci_favoris` (`id`, `date_ajout`, `annonce_id`, `utilisateur_id`) VALUES
(2, '2025-06-12 23:55:32.624416', 2, 10),
(3, '2025-06-15 14:06:59.321878', 12, 8);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_livreur`
--

CREATE TABLE `agri_connect_ci_livreur` (
  `id` bigint(20) NOT NULL,
  `description` longtext DEFAULT NULL,
  `etat_id` bigint(20) DEFAULT NULL,
  `tarif_id` bigint(20) DEFAULT NULL,
  `type_livreur_id` bigint(20) DEFAULT NULL,
  `utilisateur_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_livreur`
--

INSERT INTO `agri_connect_ci_livreur` (`id`, `description`, `etat_id`, `tarif_id`, `type_livreur_id`, `utilisateur_id`) VALUES
(1, 'Livreur sérieux avec véhicule réfrigéré pour produits frais', 1, NULL, 1, 7),
(2, 'Je suis un livreur expérimenté, je livre partout à Abidjan', 1, 5, 2, 9),
(3, 'livreur ', 1, 5, 1, 10),
(4, 'Livraison écologique à vélo pour petits colis', 1, NULL, 1, 18),
(5, 'Livraison en camion frigorifique pour produits sensibles', 1, NULL, 2, 25);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_livreurmoyentransport`
--

CREATE TABLE `agri_connect_ci_livreurmoyentransport` (
  `id` bigint(20) NOT NULL,
  `livreur_id` bigint(20) NOT NULL,
  `moyen_transport_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_livreurmoyentransport`
--

INSERT INTO `agri_connect_ci_livreurmoyentransport` (`id`, `livreur_id`, `moyen_transport_id`) VALUES
(1, 1, 2);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_livreurzone`
--

CREATE TABLE `agri_connect_ci_livreurzone` (
  `id` bigint(20) NOT NULL,
  `livreur_id` bigint(20) NOT NULL,
  `zone_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_livreurzone`
--

INSERT INTO `agri_connect_ci_livreurzone` (`id`, `livreur_id`, `zone_id`) VALUES
(1, 1, 1),
(2, 1, 4),
(3, 1, 1),
(4, 1, 4),
(5, 4, 9),
(7, 5, 11),
(8, 5, 12);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_miseenrelation`
--

CREATE TABLE `agri_connect_ci_miseenrelation` (
  `id` bigint(20) NOT NULL,
  `date_contact` datetime(6) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  `livreur_id` bigint(20) DEFAULT NULL,
  `moyen_contact_id` bigint(20) DEFAULT NULL,
  `producteur_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_miseenrelation`
--

INSERT INTO `agri_connect_ci_miseenrelation` (`id`, `date_contact`, `client_id`, `livreur_id`, `moyen_contact_id`, `producteur_id`) VALUES
(1, '0000-00-00 00:00:00.000000', 6, NULL, 3, 3),
(2, '2025-06-11 14:03:48.795401', 9, 1, 3, NULL),
(3, '2025-06-12 00:49:10.258305', 8, NULL, 3, NULL),
(4, '2025-06-12 17:14:23.914583', 8, 2, 3, NULL),
(5, '2025-06-13 00:07:42.870322', 10, NULL, 3, 1),
(6, '2025-06-15 03:29:44.987875', 14, NULL, 3, 1),
(7, '2025-06-15 23:47:29.349579', 14, 3, 3, NULL),
(8, '2025-06-16 12:45:38.160583', 15, 1, 3, NULL),
(9, '2025-06-16 12:45:52.165114', 15, 2, 3, NULL),
(10, '2025-06-16 12:46:00.663673', 15, 3, 3, NULL),
(11, '2025-06-17 11:30:00.000000', 17, NULL, 3, 5),
(12, '2025-06-19 10:20:00.000000', 20, NULL, 2, 6),
(13, '2025-06-21 09:10:00.000000', 21, NULL, 1, 5),
(14, '2025-06-22 11:45:00.000000', 24, NULL, 1, 8),
(15, '2025-06-22 14:30:00.000000', 24, 5, 2, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_moyentransport`
--

CREATE TABLE `agri_connect_ci_moyentransport` (
  `id` bigint(20) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_moyentransport`
--

INSERT INTO `agri_connect_ci_moyentransport` (`id`, `nom`, `description`) VALUES
(1, 'Moto', 'Transport rapide en moto'),
(2, 'Camion', 'Transport de grosses quantités'),
(3, 'Tricycle', 'Véhicule à 3 roues pour petites livraisons'),
(4, 'Pick-up', 'Véhicule utilitaire pour grosses quantités');

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_notation`
--

CREATE TABLE `agri_connect_ci_notation` (
  `id` bigint(20) NOT NULL,
  `note` int(11) NOT NULL,
  `commentaire` longtext DEFAULT NULL,
  `date_creation` datetime(6) NOT NULL,
  `evaluateur_id` bigint(20) NOT NULL,
  `livreur_id` bigint(20) DEFAULT NULL,
  `mise_en_relation_id` bigint(20) NOT NULL,
  `producteur_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_notation`
--

INSERT INTO `agri_connect_ci_notation` (`id`, `note`, `commentaire`, `date_creation`, `evaluateur_id`, `livreur_id`, `mise_en_relation_id`, `producteur_id`) VALUES
(1, 5, 'Produits très frais et livraison rapide', '0000-00-00 00:00:00.000000', 6, NULL, 1, 3),
(2, 4, 'Très serviable et poli, merci beaucoup encore monsieur.', '2025-06-11 16:22:10.802824', 9, 1, 2, NULL),
(3, 4, 'Épices de très bonne qualité, emballage pourrait être amélioré', '2025-06-18 14:30:00.000000', 17, NULL, 11, 5),
(4, 5, 'Livraison très rapide et soignée malgré le transport à vélo!', '2025-06-18 16:45:00.000000', 16, 4, 11, NULL),
(5, 5, 'Miel exceptionnel, goût pur et authentique. Je recommande vivement!', '2025-06-20 11:30:00.000000', 20, NULL, 12, 6),
(6, 4, 'Bon service de livraison, un peu lent mais très précautionneux avec les produits fragiles', '2025-06-20 15:20:00.000000', 19, 4, 12, NULL),
(7, 3, 'Produits corrects mais délais de livraison trop longs', '2025-06-22 17:45:00.000000', 21, NULL, 13, 5),
(8, 4, 'Service ponctuel et professionnel, emballage impeccable', '2025-06-18 18:30:00.000000', 17, 4, 11, NULL),
(9, 5, 'Produit de très haute qualité, respect des délais et quantités', '2025-06-23 16:20:00.000000', 24, NULL, 14, 8),
(10, 4, 'Livraison dans les temps, température bien maîtrisée, un peu cher', '2025-06-23 18:15:00.000000', 24, 5, 15, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_notification`
--

CREATE TABLE `agri_connect_ci_notification` (
  `id` bigint(20) NOT NULL,
  `message` longtext NOT NULL,
  `date_envoi` datetime(6) NOT NULL,
  `lu` tinyint(1) NOT NULL,
  `utilisateur_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_notification`
--

INSERT INTO `agri_connect_ci_notification` (`id`, `message`, `date_envoi`, `lu`, `utilisateur_id`) VALUES
(1, 'Nouvelle commande reçue de Fatou Traoré', '0000-00-00 00:00:00.000000', 0, 5),
(2, 'Votre commande a été préparée et sera livrée demain', '0000-00-00 00:00:00.000000', 0, 6);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_positionactuelle`
--

CREATE TABLE `agri_connect_ci_positionactuelle` (
  `id` bigint(20) NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `date_maj` datetime(6) NOT NULL,
  `livreur_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_positionactuelle`
--

INSERT INTO `agri_connect_ci_positionactuelle` (`id`, `latitude`, `longitude`, `date_maj`, `livreur_id`) VALUES
(1, 5.33631800, -4.02775100, '0000-00-00 00:00:00.000000', 1);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_producteur`
--

CREATE TABLE `agri_connect_ci_producteur` (
  `id` bigint(20) NOT NULL,
  `date_debut_activite` date NOT NULL,
  `methode_production` varchar(20) NOT NULL,
  `description_longue` longtext NOT NULL,
  `specialites` varchar(255) DEFAULT NULL,
  `annee_debut` int(11) NOT NULL,
  `utilisateur_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_producteur`
--

INSERT INTO `agri_connect_ci_producteur` (`id`, `date_debut_activite`, `methode_production`, `description_longue`, `specialites`, `annee_debut`, `utilisateur_id`) VALUES
(1, '2015-01-15', 'bio', 'Producteur de mangues bio en Côte d\'Ivoire.', 'Mangues, Ananas', 2015, 1),
(2, '2018-05-20', 'permaculture', 'Agriculteur spécialisé en permaculture.', 'Tomates, Piments', 2018, 4),
(3, '2017-06-15', 'bio', 'Producteur spécialisé dans les cultures maraîchères biologiques', 'Laitue, choux, carottes', 2012, 5),
(4, '2025-06-13', 'bio', '', NULL, 2025, 12),
(5, '2020-06-10', 'bio', 'Productrice spécialisée dans les épices bio d\'Afrique de l\'Ouest.', 'Piment, Gingembre, Curcuma', 2020, 16),
(6, '2018-11-05', 'bio', 'Apiculteur passionné produisant du miel 100% naturel.', 'Miel de forêt, Miel de fleurs sauvages', 2018, 19),
(7, '2019-08-12', 'conventionnel', 'Producteur spécialisé dans les fruits tropicaux de saison.', 'Ananas, Papaye, Fruit de la passion', 2019, 22),
(8, '2010-05-03', 'bio', 'Coopérative de 50 producteurs de riz bio dans le nord de la Côte d\'Ivoire.', 'Riz parfumé, Riz complet', 2010, 23);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_producteurproduit`
--

CREATE TABLE `agri_connect_ci_producteurproduit` (
  `id` bigint(20) NOT NULL,
  `categorie_id` bigint(20) NOT NULL,
  `producteur_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_producteurproduit`
--

INSERT INTO `agri_connect_ci_producteurproduit` (`id`, `categorie_id`, `producteur_id`) VALUES
(1, 1, 1),
(2, 3, 1),
(3, 2, 2),
(4, 2, 3),
(5, 1, 3),
(6, 5, 5),
(7, 6, 6),
(8, 9, 7),
(9, 8, 8);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_tarif`
--

CREATE TABLE `agri_connect_ci_tarif` (
  `id` bigint(20) NOT NULL,
  `type_tarif` varchar(50) NOT NULL,
  `valeur` decimal(10,2) NOT NULL,
  `devise_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_tarif`
--

INSERT INTO `agri_connect_ci_tarif` (`id`, `type_tarif`, `valeur`, `devise_id`) VALUES
(1, 'Par km', 200.00, 1),
(2, 'Forfait', 5000.00, 1),
(3, 'Livraison express', 3000.00, 1),
(4, 'Abonnement mensuel', 25000.00, 1),
(5, 'partout à Abidjan', 1000.00, 1);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_tariflivreur`
--

CREATE TABLE `agri_connect_ci_tariflivreur` (
  `id` bigint(20) NOT NULL,
  `prix` decimal(10,2) NOT NULL,
  `devise_id` bigint(20) NOT NULL,
  `livreur_id` bigint(20) NOT NULL,
  `type_livraison_id` bigint(20) NOT NULL,
  `vehicule_id` bigint(20) DEFAULT NULL,
  `zone_id` bigint(20) NOT NULL,
  `libelle` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_typeannonce`
--

CREATE TABLE `agri_connect_ci_typeannonce` (
  `id` bigint(20) NOT NULL,
  `nom` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_typeannonce`
--

INSERT INTO `agri_connect_ci_typeannonce` (`id`, `nom`) VALUES
(1, 'Vente de produits agricoles'),
(2, 'Demande'),
(3, 'Service'),
(4, 'Vente'),
(5, 'Autres'),
(6, 'Echange');

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_typecontact`
--

CREATE TABLE `agri_connect_ci_typecontact` (
  `id` bigint(20) NOT NULL,
  `nom` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_typecontact`
--

INSERT INTO `agri_connect_ci_typecontact` (`id`, `nom`) VALUES
(1, 'Email'),
(2, 'Téléphone'),
(3, 'WhatsApp');

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_typelivraison`
--

CREATE TABLE `agri_connect_ci_typelivraison` (
  `id` bigint(20) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `coefficient` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_typelivreur`
--

CREATE TABLE `agri_connect_ci_typelivreur` (
  `id` bigint(20) NOT NULL,
  `nom` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_typelivreur`
--

INSERT INTO `agri_connect_ci_typelivreur` (`id`, `nom`) VALUES
(1, 'Individuel'),
(2, 'Entreprise');

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_unitemesure`
--

CREATE TABLE `agri_connect_ci_unitemesure` (
  `id` bigint(20) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `abbr` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_unitemesure`
--

INSERT INTO `agri_connect_ci_unitemesure` (`id`, `nom`, `abbr`) VALUES
(1, 'kilogramme', 'kg'),
(2, 'gramme', 'g'),
(3, 'litre', 'l'),
(4, 'pièce', 'pce'),
(7, 'Tonne', 't'),
(8, 'Pièce', 'p'),
(9, 'Sac', 'sac'),
(10, 'Botte', 'botte'),
(11, 'Cagette', 'cag'),
(12, 'Barquette', 'barq');

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_utilisateur`
--

CREATE TABLE `agri_connect_ci_utilisateur` (
  `id` bigint(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `username` varchar(30) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `role` varchar(20) NOT NULL,
  `photo_profil` varchar(100) DEFAULT NULL,
  `date_inscription` datetime(6) NOT NULL,
  `derniere_connexion` datetime(6) DEFAULT NULL,
  `statut_verification` varchar(20) NOT NULL,
  `zone_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_utilisateur`
--

INSERT INTO `agri_connect_ci_utilisateur` (`id`, `password`, `last_login`, `is_superuser`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `username`, `full_name`, `role`, `photo_profil`, `date_inscription`, `derniere_connexion`, `statut_verification`, `zone_id`) VALUES
(1, 'azerty123', '2025-06-11 00:00:00.000000', 0, '', '', '', 0, 0, '2025-06-01 06:00:00.000000', 'kouadioa', 'Kouadio Alain', 'producteur', '', '2025-06-24 22:51:00.000000', '2025-06-16 22:04:10.000000', 'vérifié', 1),
(2, 'bernardpass', NULL, 0, '', '', '', 0, 1, '2025-06-09 21:08:01.000000', 'yamahb', 'Yamahiou Bernard', 'acheteur', '', '2025-06-03 22:51:10.000000', NULL, 'vérifié', 2),
(3, 'mireille321', NULL, 0, '', '', '', 0, 0, '0000-00-00 00:00:00.000000', 'koffie_m', 'Koffi Mireille', 'livreur', NULL, '2025-06-23 22:51:15.000000', NULL, '', 3),
(4, 'brice2024', NULL, 0, '', '', '', 0, 0, '0000-00-00 00:00:00.000000', 'agneg_b', 'Agnegbé Brice', 'producteur', NULL, '2025-06-09 22:51:21.000000', NULL, '', 2),
(5, 'motdepasse123', '2025-06-22 20:55:22.000000', 0, '', '', '', 0, 0, '2025-06-01 12:00:00.000000', 'kone_farm', 'Kone Mamadou', 'producteur', 'profils/images-removebg-preview_UEb0TXY.png', '2025-06-09 22:51:26.000000', '2025-06-23 00:00:00.000000', 'vérifié', 1),
(6, 'motdepasse123', NULL, 0, '', '', '', 0, 0, '0000-00-00 00:00:00.000000', 'fatou_market', 'Fatou Traoré', 'acheteur', NULL, '2025-06-11 22:51:31.000000', NULL, 'vérifié', 2),
(7, 'motdepasse123', NULL, 0, '', '', '', 0, 0, '2025-06-02 23:38:26.000000', 'ali_delivery', 'Ali Coulibaly', 'livreur', 'profils/depositphotos_446174836-stock-photo-black-delivery-man-holding-cardboard.jpg', '2025-06-18 22:51:36.000000', '2025-06-24 23:39:47.000000', 'vérifié', NULL),
(8, 'pbkdf2_sha256$600000$rrDqahXxl34zAfv6OoemAb$KiJYBQvLwDI3kT/vIA8SZYUtpCArnfqwJ6HtmWz5fJs=', '2025-06-16 23:30:47.074899', 1, '', '', '', 1, 1, '2025-06-10 20:39:25.449288', 'amykrakra', 'Amy kara', 'acheteur', '', '2025-06-10 20:39:26.636920', '2025-06-15 23:43:46.618839', 'non vérifié', NULL),
(9, 'pbkdf2_sha256$600000$eNTpTKgWvalQjJ0K47XcSC$0T4mG7q3QbX1+bmz7xKHCgtjVvZcHBQwzUkeYCZ0R44=', '2025-06-13 11:42:04.203031', 0, '', '', 'yamahioubernard12@gmail.com', 0, 1, '2025-06-10 21:10:49.000000', 'yamahb128', 'Yamahiou Bernard', 'livreur', 'profils/WhatsApp_Image_2025-02-25_à_22.42.20_3bd66eef-removebg-preview.png', '2025-06-10 21:10:50.917893', '2025-06-13 11:42:04.298695', 'vérifié', 2),
(10, 'pbkdf2_sha256$600000$VdDp8MxTAnjSrMuAGcirIZ$zJ6xX3yiRo+1vcBhtr0PTL9C7b2K2dPxKpMcq13WGac=', '2025-06-16 21:38:51.229651', 0, '', '', 'liliberry125@gmail.com', 0, 1, '2025-06-12 22:34:16.000000', 'lilib12', 'Lili Berry', 'livreur', 'profils/Muslim_character.jpg', '2025-06-12 22:34:17.694196', '2025-06-16 21:38:51.276500', 'vérifié', 2),
(11, 'aimerode', NULL, 0, '', '', '', 0, 1, '2025-06-13 03:19:15.000000', 'Rubin789', 'Rubin Bobo', 'producteur', '', '2025-06-13 03:20:22.656437', '2025-06-13 03:20:17.000000', 'vérifié', NULL),
(12, 'pbkdf2_sha256$600000$2vYtm0eTcJ8RPsKy6tciFk$GXPga3RE8YHykw8/fozQsWq5j5abqqWd+RinGhRmnNg=', '2025-06-16 19:55:13.963428', 0, '', '', 'rubin123@gmail.com', 0, 1, '2025-06-13 03:23:06.000000', 'rubin123', 'Bobo Rubin', 'producteur', '', '2025-06-13 03:23:07.555242', '2025-06-16 19:55:14.102962', 'vérifié', NULL),
(13, 'aimerode', NULL, 0, '', '', '', 0, 1, '2025-06-13 04:15:23.000000', 'user-test', 'Test man', 'producteur', '', '2025-06-13 04:16:43.696603', NULL, 'vérifié', NULL),
(14, 'pbkdf2_sha256$600000$nnXdnyaGEkWVctyA5hXRge$A8Jf7HpwtiyQzNAu0BldBwaBm2JuC5RnISaWXSTVL2E=', '2025-06-15 12:05:56.908034', 0, '', '', 'jkouassi123@gmail.com', 0, 1, '2025-06-15 02:06:15.260120', 'jpkouassi', 'Jean Kouassi', 'acheteur', '', '2025-06-15 02:06:16.844610', '2025-06-15 12:05:56.976685', 'non vérifié', NULL),
(15, 'pbkdf2_sha256$600000$fQNLlSsBemHTgTkaxs7sQd$RVPKn3H6NCJKjWyT6S41wy80afzFIIfOkid+9LI1/8A=', '2025-06-16 21:39:13.258932', 0, '', '', 'missdiana925@gmail.com', 0, 1, '2025-06-16 00:55:23.926691', 'lilijay', 'Jay Lil', 'acheteur', '', '2025-06-16 00:55:25.431568', '2025-06-16 21:39:13.301924', 'non vérifié', NULL),
(16, 'pbkdf2_sha256$600000$xyz789$...', NULL, 0, '', '', 'amina@epices-afrik.ci', 0, 1, '2025-03-01 09:00:00.000000', 'epices_afrik', 'Amina Traoré', 'producteur', NULL, '2025-03-01 09:00:00.000000', NULL, 'vérifié', NULL),
(17, 'pbkdf2_sha256$600000$uvw456$...', NULL, 0, '', '', 'chef@resto-afro.ci', 0, 1, '2025-04-15 10:00:00.000000', 'resto_afro', 'Chef Mamadou', 'acheteur', NULL, '2025-04-15 10:00:00.000000', NULL, 'vérifié', NULL),
(18, 'pbkdf2_sha256$600000$rst321$...', NULL, 0, '', '', 'ekoue@livraison-eko.ci', 0, 1, '2025-05-20 11:00:00.000000', 'livreur_eko', 'Ekoué Johnson', 'livreur', 'profils/portrait-jeune-livreur-montrant-pouce-vers-haut_58466-16783_XgFhtQr.jpg', '2025-05-20 11:00:00.000000', NULL, 'vérifié', NULL),
(19, 'pbkdf2_sha256$600000$mno654$...', NULL, 0, '', '', 'bakary@miel-douceur.ci', 0, 1, '2025-02-15 08:30:00.000000', 'miel_douceur', 'Bakary Coulibaly', 'producteur', NULL, '2025-02-15 08:30:00.000000', NULL, 'vérifié', NULL),
(20, 'pbkdf2_sha256$600000$new123$...', NULL, 0, '', '', 'kadija@bio-shop.ci', 0, 1, '2025-05-10 09:15:00.000000', 'bio_shop', 'Kadija Diallo', 'acheteur', NULL, '2025-05-10 09:15:00.000000', NULL, 'vérifié', NULL),
(21, 'pbkdf2_sha256$600000$new456$...', NULL, 0, '', '', 'sekou@marche-bio.ci', 0, 1, '2025-04-22 08:45:00.000000', 'marche_bio', 'Sékou Bamba', 'acheteur', NULL, '2025-04-22 08:45:00.000000', NULL, 'vérifié', NULL),
(22, 'pbkdf2_sha256$600000$fruits789$...', NULL, 0, '', '', 'jean@fruits-tropicaux.ci', 0, 1, '2025-03-15 07:30:00.000000', 'fruits_tropicaux', 'Jean Akissi', 'producteur', NULL, '2025-03-15 07:30:00.000000', NULL, 'vérifié', NULL),
(23, 'pbkdf2_sha256$600000$coop456$...', NULL, 0, '', '', 'contact@coop-riz.ci', 0, 1, '2025-04-10 08:45:00.000000', 'coop_riz', 'Coopérative Rizicole du Nord', 'producteur', NULL, '2025-04-10 08:45:00.000000', NULL, 'vérifié', NULL),
(24, 'pbkdf2_sha256$600000$gross123$...', NULL, 0, '', '', 'mohamed@grossiste-af.ci', 0, 1, '2025-05-05 09:15:00.000000', 'grossiste_af', 'Mohamed Diarra', 'acheteur', NULL, '2025-05-05 09:15:00.000000', NULL, 'vérifié', NULL),
(25, 'pbkdf2_sha256$600000$frigo789$...', NULL, 0, '', '', 'koffi@livraison-frigo.ci', 0, 1, '2025-06-01 10:20:00.000000', 'livreur_frigo', 'Koffi Nguessan', 'livreur', NULL, '2025-06-01 10:20:00.000000', NULL, 'vérifié', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_utilisateur_groups`
--

CREATE TABLE `agri_connect_ci_utilisateur_groups` (
  `id` bigint(20) NOT NULL,
  `utilisateur_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_utilisateur_user_permissions`
--

CREATE TABLE `agri_connect_ci_utilisateur_user_permissions` (
  `id` bigint(20) NOT NULL,
  `utilisateur_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_vehicule`
--

CREATE TABLE `agri_connect_ci_vehicule` (
  `id` bigint(20) NOT NULL,
  `type` varchar(100) NOT NULL,
  `immatriculation` varchar(50) NOT NULL,
  `photo_url` varchar(100) NOT NULL,
  `livreur_id` bigint(20) NOT NULL,
  `capacite_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_vehicule`
--

INSERT INTO `agri_connect_ci_vehicule` (`id`, `type`, `immatriculation`, `photo_url`, `livreur_id`, `capacite_id`) VALUES
(3, 'Camionnette', 'AMV12', 'vehicules/téléchargement_2_vhNoDX5.jpeg', 2, 3),
(4, 'Tricycle', 'AMV11', 'vehicules/Tricycle-Bagage-scaled.jpg', 2, 5),
(5, 'Moto', 'AMV14', 'vehicules/images_4.jpeg', 2, 4),
(6, 'Vélo cargo', 'VELO123', 'vehicules/velo_cargo.jpg', 4, 6),
(7, 'Camion frigorifique', 'FRIGO123', 'vehicules/camion_frigo.jpg', 5, 7);

-- --------------------------------------------------------

--
-- Structure de la table `agri_connect_ci_zone`
--

CREATE TABLE `agri_connect_ci_zone` (
  `id` bigint(20) NOT NULL,
  `ville` varchar(100) NOT NULL,
  `quartier` varchar(100) NOT NULL,
  `code_postal` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `agri_connect_ci_zone`
--

INSERT INTO `agri_connect_ci_zone` (`id`, `ville`, `quartier`, `code_postal`) VALUES
(1, 'Abidjan', 'Cocody', '22501'),
(2, 'Abidjan', 'Yopougon', '22502'),
(3, 'Bouaké', 'Belle Ville', '27001'),
(4, 'Abidjan', 'Plateau', '00225'),
(5, 'Abidjan', 'Adjamé', '00225'),
(6, 'Abidjan', 'Treichville', '00225'),
(7, 'Daloa', 'Liberté', '00225'),
(8, 'Gagnoa', 'Commerce', '00225'),
(9, 'San Pedro', 'Quartier des pêcheurs', '01532'),
(10, 'Korhogo', 'Commerce', '03210'),
(11, 'Man', 'Centre-ville', '03456'),
(12, 'Bondoukou', 'Marché central', '02100');

-- --------------------------------------------------------

--
-- Structure de la table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add annonce', 6, 'add_annonce'),
(22, 'Can change annonce', 6, 'change_annonce'),
(23, 'Can delete annonce', 6, 'delete_annonce'),
(24, 'Can view annonce', 6, 'view_annonce'),
(25, 'Can add categorie produit', 7, 'add_categorieproduit'),
(26, 'Can change categorie produit', 7, 'change_categorieproduit'),
(27, 'Can delete categorie produit', 7, 'delete_categorieproduit'),
(28, 'Can view categorie produit', 7, 'view_categorieproduit'),
(29, 'Can add certification', 8, 'add_certification'),
(30, 'Can change certification', 8, 'change_certification'),
(31, 'Can delete certification', 8, 'delete_certification'),
(32, 'Can view certification', 8, 'view_certification'),
(33, 'Can add conditionnement', 9, 'add_conditionnement'),
(34, 'Can change conditionnement', 9, 'change_conditionnement'),
(35, 'Can delete conditionnement', 9, 'delete_conditionnement'),
(36, 'Can view conditionnement', 9, 'view_conditionnement'),
(37, 'Can add devise', 10, 'add_devise'),
(38, 'Can change devise', 10, 'change_devise'),
(39, 'Can delete devise', 10, 'delete_devise'),
(40, 'Can view devise', 10, 'view_devise'),
(41, 'Can add etat livreur', 11, 'add_etatlivreur'),
(42, 'Can change etat livreur', 11, 'change_etatlivreur'),
(43, 'Can delete etat livreur', 11, 'delete_etatlivreur'),
(44, 'Can view etat livreur', 11, 'view_etatlivreur'),
(45, 'Can add faq', 12, 'add_faq'),
(46, 'Can change faq', 12, 'change_faq'),
(47, 'Can delete faq', 12, 'delete_faq'),
(48, 'Can view faq', 12, 'view_faq'),
(49, 'Can add livreur', 13, 'add_livreur'),
(50, 'Can change livreur', 13, 'change_livreur'),
(51, 'Can delete livreur', 13, 'delete_livreur'),
(52, 'Can view livreur', 13, 'view_livreur'),
(53, 'Can add mise en relation', 14, 'add_miseenrelation'),
(54, 'Can change mise en relation', 14, 'change_miseenrelation'),
(55, 'Can delete mise en relation', 14, 'delete_miseenrelation'),
(56, 'Can view mise en relation', 14, 'view_miseenrelation'),
(57, 'Can add moyen transport', 15, 'add_moyentransport'),
(58, 'Can change moyen transport', 15, 'change_moyentransport'),
(59, 'Can delete moyen transport', 15, 'delete_moyentransport'),
(60, 'Can view moyen transport', 15, 'view_moyentransport'),
(61, 'Can add producteur', 16, 'add_producteur'),
(62, 'Can change producteur', 16, 'change_producteur'),
(63, 'Can delete producteur', 16, 'delete_producteur'),
(64, 'Can view producteur', 16, 'view_producteur'),
(65, 'Can add type annonce', 17, 'add_typeannonce'),
(66, 'Can change type annonce', 17, 'change_typeannonce'),
(67, 'Can delete type annonce', 17, 'delete_typeannonce'),
(68, 'Can view type annonce', 17, 'view_typeannonce'),
(69, 'Can add type contact', 18, 'add_typecontact'),
(70, 'Can change type contact', 18, 'change_typecontact'),
(71, 'Can delete type contact', 18, 'delete_typecontact'),
(72, 'Can view type contact', 18, 'view_typecontact'),
(73, 'Can add type livreur', 19, 'add_typelivreur'),
(74, 'Can change type livreur', 19, 'change_typelivreur'),
(75, 'Can delete type livreur', 19, 'delete_typelivreur'),
(76, 'Can view type livreur', 19, 'view_typelivreur'),
(77, 'Can add unite mesure', 20, 'add_unitemesure'),
(78, 'Can change unite mesure', 20, 'change_unitemesure'),
(79, 'Can delete unite mesure', 20, 'delete_unitemesure'),
(80, 'Can view unite mesure', 20, 'view_unitemesure'),
(81, 'Can add zone', 21, 'add_zone'),
(82, 'Can change zone', 21, 'change_zone'),
(83, 'Can delete zone', 21, 'delete_zone'),
(84, 'Can view zone', 21, 'view_zone'),
(85, 'Can add user', 22, 'add_utilisateur'),
(86, 'Can change user', 22, 'change_utilisateur'),
(87, 'Can delete user', 22, 'delete_utilisateur'),
(88, 'Can view user', 22, 'view_utilisateur'),
(89, 'Can add vehicule', 23, 'add_vehicule'),
(90, 'Can change vehicule', 23, 'change_vehicule'),
(91, 'Can delete vehicule', 23, 'delete_vehicule'),
(92, 'Can view vehicule', 23, 'view_vehicule'),
(93, 'Can add tarif', 24, 'add_tarif'),
(94, 'Can change tarif', 24, 'change_tarif'),
(95, 'Can delete tarif', 24, 'delete_tarif'),
(96, 'Can view tarif', 24, 'view_tarif'),
(97, 'Can add producteur produit', 25, 'add_producteurproduit'),
(98, 'Can change producteur produit', 25, 'change_producteurproduit'),
(99, 'Can delete producteur produit', 25, 'delete_producteurproduit'),
(100, 'Can view producteur produit', 25, 'view_producteurproduit'),
(101, 'Can add position actuelle', 26, 'add_positionactuelle'),
(102, 'Can change position actuelle', 26, 'change_positionactuelle'),
(103, 'Can delete position actuelle', 26, 'delete_positionactuelle'),
(104, 'Can view position actuelle', 26, 'view_positionactuelle'),
(105, 'Can add notification', 27, 'add_notification'),
(106, 'Can change notification', 27, 'change_notification'),
(107, 'Can delete notification', 27, 'delete_notification'),
(108, 'Can view notification', 27, 'view_notification'),
(109, 'Can add notation', 28, 'add_notation'),
(110, 'Can change notation', 28, 'change_notation'),
(111, 'Can delete notation', 28, 'delete_notation'),
(112, 'Can view notation', 28, 'view_notation'),
(113, 'Can add livreur zone', 29, 'add_livreurzone'),
(114, 'Can change livreur zone', 29, 'change_livreurzone'),
(115, 'Can delete livreur zone', 29, 'delete_livreurzone'),
(116, 'Can view livreur zone', 29, 'view_livreurzone'),
(117, 'Can add livreur moyen transport', 30, 'add_livreurmoyentransport'),
(118, 'Can change livreur moyen transport', 30, 'change_livreurmoyentransport'),
(119, 'Can delete livreur moyen transport', 30, 'delete_livreurmoyentransport'),
(120, 'Can view livreur moyen transport', 30, 'view_livreurmoyentransport'),
(121, 'Can add disponibilite livreur', 31, 'add_disponibilitelivreur'),
(122, 'Can change disponibilite livreur', 31, 'change_disponibilitelivreur'),
(123, 'Can delete disponibilite livreur', 31, 'delete_disponibilitelivreur'),
(124, 'Can view disponibilite livreur', 31, 'view_disponibilitelivreur'),
(125, 'Can add contact', 32, 'add_contact'),
(126, 'Can change contact', 32, 'change_contact'),
(127, 'Can delete contact', 32, 'delete_contact'),
(128, 'Can view contact', 32, 'view_contact'),
(129, 'Can add annonce produit', 33, 'add_annonceproduit'),
(130, 'Can change annonce produit', 33, 'change_annonceproduit'),
(131, 'Can delete annonce produit', 33, 'delete_annonceproduit'),
(132, 'Can view annonce produit', 33, 'view_annonceproduit'),
(133, 'Can add annonce image', 34, 'add_annonceimage'),
(134, 'Can change annonce image', 34, 'change_annonceimage'),
(135, 'Can delete annonce image', 34, 'delete_annonceimage'),
(136, 'Can view annonce image', 34, 'view_annonceimage'),
(137, 'Can add favoris', 35, 'add_favoris'),
(138, 'Can change favoris', 35, 'change_favoris'),
(139, 'Can delete favoris', 35, 'delete_favoris'),
(140, 'Can view favoris', 35, 'view_favoris'),
(141, 'Can add Capacité de véhicule', 36, 'add_capacitevehicule'),
(142, 'Can change Capacité de véhicule', 36, 'change_capacitevehicule'),
(143, 'Can delete Capacité de véhicule', 36, 'delete_capacitevehicule'),
(144, 'Can view Capacité de véhicule', 36, 'view_capacitevehicule'),
(145, 'Can add Document producteur', 37, 'add_documentproducteur'),
(146, 'Can change Document producteur', 37, 'change_documentproducteur'),
(147, 'Can delete Document producteur', 37, 'delete_documentproducteur'),
(148, 'Can view Document producteur', 37, 'view_documentproducteur'),
(149, 'Can add tarif livreur', 38, 'add_tariflivreur'),
(150, 'Can change tarif livreur', 38, 'change_tariflivreur'),
(151, 'Can delete tarif livreur', 38, 'delete_tariflivreur'),
(152, 'Can view tarif livreur', 38, 'view_tariflivreur'),
(153, 'Can add type livraison', 39, 'add_typelivraison'),
(154, 'Can change type livraison', 39, 'change_typelivraison'),
(155, 'Can delete type livraison', 39, 'delete_typelivraison'),
(156, 'Can view type livraison', 39, 'view_typelivraison');

-- --------------------------------------------------------

--
-- Structure de la table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2025-06-10 20:56:27.842337', '5', 'kone_farm', 2, '[{\"changed\": {\"fields\": [\"Last login\", \"Date joined\", \"Photo profil\", \"Derniere connexion\"]}}]', 22, 8),
(2, '2025-06-10 20:59:53.620318', '1', 'AnnonceImage object (1)', 2, '[{\"changed\": {\"fields\": [\"Url image\"]}}]', 34, 8),
(3, '2025-06-10 21:00:09.449239', '2', 'AnnonceImage object (2)', 2, '[{\"changed\": {\"fields\": [\"Url image\"]}}]', 34, 8),
(4, '2025-06-10 21:08:05.664722', '2', 'yamahb', 2, '[{\"changed\": {\"fields\": [\"Active\", \"Date joined\", \"Statut verification\"]}}]', 22, 8),
(5, '2025-06-10 22:04:33.513679', '1', 'kouadioa', 2, '[{\"changed\": {\"fields\": [\"Last login\", \"Date joined\", \"Derniere connexion\", \"Statut verification\"]}}]', 22, 8),
(6, '2025-06-10 22:08:48.902251', '2', 'Annonce object (2)', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"annonce produit\", \"object\": \"AnnonceProduit object (4)\"}}]', 6, 8),
(7, '2025-06-10 22:22:28.020888', '2', 'Annonce object (2)', 2, '[{\"added\": {\"name\": \"annonce image\", \"object\": \"AnnonceImage object (3)\"}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"AnnonceImage object (4)\"}}]', 6, 8),
(8, '2025-06-12 00:48:30.293463', '3', 'Annonce object (3)', 1, '[{\"added\": {}}]', 6, 8),
(9, '2025-06-12 14:50:45.706217', '1', '100 kg', 1, '[{\"added\": {}}]', 36, 8),
(10, '2025-06-12 14:57:34.812895', '2', '500 kg', 1, '[{\"added\": {}}]', 36, 8),
(11, '2025-06-12 15:15:33.295192', '5', 'partout à Abidjan - 1000 XOF', 1, '[{\"added\": {}}]', 24, 8),
(12, '2025-06-12 15:16:09.698999', '2', 'Livreur: Yamahiou Bernard', 1, '[{\"added\": {}}]', 13, 8),
(13, '2025-06-12 15:35:37.434012', '9', 'yamahb128', 2, '[{\"changed\": {\"fields\": [\"Role\", \"Photo profil\", \"Statut verification\", \"Zone de r\\u00e9sidence\"]}}]', 22, 8),
(14, '2025-06-12 15:36:25.275029', '13', 'WhatsApp: +2250505852591', 1, '[{\"added\": {}}]', 32, 8),
(15, '2025-06-12 15:42:30.346196', '4', '50 kg', 1, '[{\"added\": {}}]', 36, 8),
(16, '2025-06-12 17:09:04.079272', '3', 'Camionnette - AMV12', 2, '[{\"changed\": {\"fields\": [\"Type\", \"Capacite\", \"Photo url\"]}}]', 23, 8),
(17, '2025-06-12 17:11:09.951140', '5', '1000 kg', 1, '[{\"added\": {}}]', 36, 8),
(18, '2025-06-12 17:11:11.885295', '4', 'Tricycle - AMV11', 1, '[{\"added\": {}}]', 23, 8),
(19, '2025-06-12 17:14:05.392906', '5', 'Moto - AMV14', 1, '[{\"added\": {}}]', 23, 8),
(20, '2025-06-12 17:20:14.999652', '9', 'yamahb128', 2, '[{\"changed\": {\"fields\": [\"Photo profil\"]}}]', 22, 8),
(21, '2025-06-13 03:20:22.893086', '11', 'Rubin789', 1, '[{\"added\": {}}]', 22, 8),
(22, '2025-06-13 03:24:04.701003', '12', 'rubin123', 2, '[{\"changed\": {\"fields\": [\"Role\", \"Statut verification\"]}}]', 22, 8),
(23, '2025-06-13 04:16:43.956367', '13', 'user-test', 1, '[{\"added\": {}}]', 22, 8),
(24, '2025-06-13 04:17:32.556162', '13', 'user-test', 2, '[]', 22, 8),
(25, '2025-06-13 04:19:39.934467', '13', 'user-test', 2, '[]', 22, 8),
(26, '2025-06-13 04:27:30.001423', '10', 'lilib12', 2, '[{\"changed\": {\"fields\": [\"Role\"]}}]', 22, 8),
(27, '2025-06-13 04:27:56.710611', '10', 'lilib12', 2, '[{\"changed\": {\"fields\": [\"Statut verification\", \"Zone de r\\u00e9sidence\"]}}]', 22, 8),
(28, '2025-06-15 12:32:03.438823', '12', 'Patates douces bio en stock', 2, '[{\"changed\": {\"fields\": [\"Titre\", \"Description\", \"Zone\"]}}, {\"added\": {\"name\": \"annonce produit\", \"object\": \"Patate douce\"}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Patates douces bio en stock\"}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Patates douces bio en stock\"}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Patates douces bio en stock\"}}, {\"deleted\": {\"name\": \"annonce image\", \"object\": \"Image de Patates douces bio en stock\"}}]', 6, 8),
(29, '2025-06-15 12:33:12.204220', '12', 'Patates douces bio en stock', 2, '[{\"changed\": {\"fields\": [\"Type annonce\"]}}]', 6, 8),
(30, '2025-06-15 12:38:51.553166', '11', 'Laitue bio fraîche du matin', 2, '[{\"changed\": {\"fields\": [\"Type annonce\", \"Titre\", \"Description\", \"Zone\"]}}, {\"added\": {\"name\": \"annonce produit\", \"object\": \"Laitue bio\"}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Laitue bio fra\\u00eeche du matin\"}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Laitue bio fra\\u00eeche du matin\"}}, {\"deleted\": {\"name\": \"annonce image\", \"object\": \"Image de Laitue bio fra\\u00eeche du matin\"}}]', 6, 8),
(31, '2025-06-15 12:40:42.056346', '2', 'Mangue sucrée du nord', 2, '[{\"changed\": {\"fields\": [\"Titre\", \"Description\", \"Zone\"]}}, {\"changed\": {\"name\": \"annonce produit\", \"object\": \"Mangue Bio\", \"fields\": [\"Categorie\", \"Quantite\", \"Conditionnement\"]}}]', 6, 8),
(32, '2025-06-15 12:44:49.526057', '10', 'apaye mûre prête à consommer', 2, '[{\"changed\": {\"fields\": [\"Type annonce\", \"Titre\", \"Description\", \"Zone\"]}}, {\"added\": {\"name\": \"annonce produit\", \"object\": \"Papaye\"}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de apaye m\\u00fbre pr\\u00eate \\u00e0 consommer\"}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de apaye m\\u00fbre pr\\u00eate \\u00e0 consommer\"}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de apaye m\\u00fbre pr\\u00eate \\u00e0 consommer\"}}, {\"deleted\": {\"name\": \"annonce image\", \"object\": \"Image de apaye m\\u00fbre pr\\u00eate \\u00e0 consommer\"}}]', 6, 8),
(33, '2025-06-15 12:45:24.953140', '10', 'Papaye mûre prête à consommer', 2, '[{\"changed\": {\"fields\": [\"Titre\"]}}]', 6, 8),
(34, '2025-06-15 12:46:54.581653', '1', 'Légumes bio frais', 3, '', 6, 8),
(35, '2025-06-15 12:47:11.808873', '11', 'Laitue bio fraîche du matin', 2, '[{\"changed\": {\"fields\": [\"Auteur\"]}}]', 6, 8),
(36, '2025-06-15 12:48:28.109634', '4', 'Vente de Mangue d\'Afrique du nord', 3, '', 6, 8),
(37, '2025-06-15 12:57:55.232365', '9', 'Fromage frais local', 2, '[{\"changed\": {\"fields\": [\"Auteur\", \"Type annonce\", \"Titre\", \"Description\", \"Zone\"]}}, {\"added\": {\"name\": \"annonce produit\", \"object\": \"Fromage\"}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Fromage frais local\"}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Fromage frais local\"}}, {\"deleted\": {\"name\": \"annonce image\", \"object\": \"Image de Fromage frais local\"}}]', 6, 8),
(38, '2025-06-15 13:28:43.745223', '8', 'Vente de belle banane douce cultivées avec soin.', 2, '[{\"changed\": {\"fields\": [\"Zone\"]}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Vente de belle banane douce cultiv\\u00e9es avec soin.\"}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Vente de belle banane douce cultiv\\u00e9es avec soin.\"}}, {\"deleted\": {\"name\": \"annonce image\", \"object\": \"Image de Vente de belle banane douce cultiv\\u00e9es avec soin.\"}}]', 6, 8),
(39, '2025-06-15 13:37:57.110203', '5', 'Fromage', 2, '[{\"changed\": {\"fields\": [\"Titre\", \"Description\", \"Zone\"]}}, {\"changed\": {\"name\": \"annonce produit\", \"object\": \"Lait caill\\u00e9\", \"fields\": [\"Nom produit\", \"Categorie\", \"Unite\", \"Quantite\", \"Prix unitaire\", \"Conditionnement\"]}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Fromage\"}}, {\"deleted\": {\"name\": \"annonce image\", \"object\": \"Image de Fromage\"}}]', 6, 8),
(40, '2025-06-15 13:40:02.189800', '11', 'Laitue bio fraîche du matin', 2, '[{\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Laitue bio fra\\u00eeche du matin\"}}, {\"deleted\": {\"name\": \"annonce image\", \"object\": \"Image de Laitue bio fra\\u00eeche du matin\"}}, {\"deleted\": {\"name\": \"annonce image\", \"object\": \"Image de Laitue bio fra\\u00eeche du matin\"}}]', 6, 8),
(41, '2025-06-15 13:40:47.827994', '11', 'Laitue bio fraîche du matin', 2, '[{\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Laitue bio fra\\u00eeche du matin\"}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Laitue bio fra\\u00eeche du matin\"}}, {\"deleted\": {\"name\": \"annonce image\", \"object\": \"Image de Laitue bio fra\\u00eeche du matin\"}}]', 6, 8),
(42, '2025-06-15 13:54:25.903026', '5', 'Lait caillé en bidon', 2, '[{\"changed\": {\"fields\": [\"Titre\"]}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Lait caill\\u00e9 en bidon\"}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Lait caill\\u00e9 en bidon\"}}, {\"deleted\": {\"name\": \"annonce image\", \"object\": \"Image de Lait caill\\u00e9 en bidon\"}}]', 6, 8),
(43, '2025-06-15 13:57:16.300101', '13', 'Don de tomates trop mûres', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"annonce produit\", \"object\": \"Tomates\"}}]', 6, 8),
(44, '2025-06-15 13:58:40.218044', '6', 'Echange', 1, '[{\"added\": {}}]', 17, 8),
(45, '2025-06-15 14:00:03.057713', '14', 'Troc : Maïs contre engrais bio', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"annonce produit\", \"object\": \"Ma\\u00efs\"}}]', 6, 8),
(46, '2025-06-15 14:01:58.644020', '15', 'Livraison de produits agricoles à bas coût', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"annonce produit\", \"object\": \"Aucun\"}}]', 6, 8),
(47, '2025-06-15 14:02:52.315049', '15', 'Livraison de produits agricoles à bas coût', 2, '[{\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Livraison de produits agricoles \\u00e0 bas co\\u00fbt\"}}]', 6, 8),
(48, '2025-06-15 23:33:38.241893', '16', 'Service de livraison agricole express', 1, '[{\"added\": {}}, {\"added\": {\"name\": \"annonce produit\", \"object\": \"aucun\"}}]', 6, 8),
(49, '2025-06-15 23:45:18.776209', '15', 'WhatsApp: +2250777984917', 2, '[{\"changed\": {\"fields\": [\"Type contact\"]}}]', 32, 8),
(50, '2025-06-15 23:47:29.490042', '7', 'Relation client jpkouassi - livreur Livreur: Lili Berry - producteur N/A', 1, '[{\"added\": {}}]', 14, 8),
(51, '2025-06-16 20:32:19.144374', '20', ' xc nbnwdsbd', 3, '', 6, 8),
(52, '2025-06-16 20:32:30.630438', '19', 'Besoin d\'un livreur ', 3, '', 6, 8),
(53, '2025-06-16 20:33:48.034536', '18', 'Besoin d\'un livreur', 2, '[{\"changed\": {\"fields\": [\"Titre\", \"Zone\"]}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Besoin d\'un livreur\"}}]', 6, 8),
(54, '2025-06-16 22:52:02.914165', '25', 'Riz bio de qualité supérieure', 2, '[{\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Riz bio de qualit\\u00e9 sup\\u00e9rieure\"}}]', 6, 8),
(55, '2025-06-16 22:55:44.949325', '24', 'Ananas sucrés de saison', 2, '[{\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Ananas sucr\\u00e9s de saison\"}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Ananas sucr\\u00e9s de saison\"}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Ananas sucr\\u00e9s de saison\"}}]', 6, 8),
(56, '2025-06-16 23:05:01.333566', '23', 'Miel pur 100% naturel', 2, '[{\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Miel pur 100% naturel\"}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Miel pur 100% naturel\"}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de Miel pur 100% naturel\"}}]', 6, 8),
(57, '2025-06-16 23:08:29.546701', '22', 'Épices bio de qualité supérieure', 2, '[{\"added\": {\"name\": \"annonce image\", \"object\": \"Image de \\u00c9pices bio de qualit\\u00e9 sup\\u00e9rieure\"}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de \\u00c9pices bio de qualit\\u00e9 sup\\u00e9rieure\"}}, {\"added\": {\"name\": \"annonce image\", \"object\": \"Image de \\u00c9pices bio de qualit\\u00e9 sup\\u00e9rieure\"}}]', 6, 8),
(58, '2025-06-16 23:37:14.922100', '18', 'livreur_eko', 2, '[{\"changed\": {\"fields\": [\"Photo profil\"]}}]', 22, 8),
(59, '2025-06-16 23:37:15.306067', '18', 'livreur_eko', 2, '[{\"changed\": {\"fields\": [\"Photo profil\"]}}]', 22, 8),
(60, '2025-06-16 23:39:58.023953', '7', 'ali_delivery', 2, '[{\"changed\": {\"fields\": [\"Date joined\", \"Photo profil\", \"Derniere connexion\"]}}]', 22, 8);

-- --------------------------------------------------------

--
-- Structure de la table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(6, 'Agri_Connect_CI', 'annonce'),
(34, 'Agri_Connect_CI', 'annonceimage'),
(33, 'Agri_Connect_CI', 'annonceproduit'),
(36, 'Agri_Connect_CI', 'capacitevehicule'),
(7, 'Agri_Connect_CI', 'categorieproduit'),
(8, 'Agri_Connect_CI', 'certification'),
(9, 'Agri_Connect_CI', 'conditionnement'),
(32, 'Agri_Connect_CI', 'contact'),
(10, 'Agri_Connect_CI', 'devise'),
(31, 'Agri_Connect_CI', 'disponibilitelivreur'),
(37, 'Agri_Connect_CI', 'documentproducteur'),
(11, 'Agri_Connect_CI', 'etatlivreur'),
(12, 'Agri_Connect_CI', 'faq'),
(35, 'Agri_Connect_CI', 'favoris'),
(13, 'Agri_Connect_CI', 'livreur'),
(30, 'Agri_Connect_CI', 'livreurmoyentransport'),
(29, 'Agri_Connect_CI', 'livreurzone'),
(14, 'Agri_Connect_CI', 'miseenrelation'),
(15, 'Agri_Connect_CI', 'moyentransport'),
(28, 'Agri_Connect_CI', 'notation'),
(27, 'Agri_Connect_CI', 'notification'),
(26, 'Agri_Connect_CI', 'positionactuelle'),
(16, 'Agri_Connect_CI', 'producteur'),
(25, 'Agri_Connect_CI', 'producteurproduit'),
(24, 'Agri_Connect_CI', 'tarif'),
(38, 'Agri_Connect_CI', 'tariflivreur'),
(17, 'Agri_Connect_CI', 'typeannonce'),
(18, 'Agri_Connect_CI', 'typecontact'),
(39, 'Agri_Connect_CI', 'typelivraison'),
(19, 'Agri_Connect_CI', 'typelivreur'),
(20, 'Agri_Connect_CI', 'unitemesure'),
(22, 'Agri_Connect_CI', 'utilisateur'),
(23, 'Agri_Connect_CI', 'vehicule'),
(21, 'Agri_Connect_CI', 'zone'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(5, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Structure de la table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-06-10 19:33:38.107193'),
(2, 'contenttypes', '0002_remove_content_type_name', '2025-06-10 19:33:39.317040'),
(3, 'auth', '0001_initial', '2025-06-10 19:33:43.603981'),
(4, 'auth', '0002_alter_permission_name_max_length', '2025-06-10 19:33:44.915573'),
(5, 'auth', '0003_alter_user_email_max_length', '2025-06-10 19:33:44.992934'),
(6, 'auth', '0004_alter_user_username_opts', '2025-06-10 19:33:45.071320'),
(7, 'auth', '0005_alter_user_last_login_null', '2025-06-10 19:33:45.108144'),
(8, 'auth', '0006_require_contenttypes_0002', '2025-06-10 19:33:45.159914'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2025-06-10 19:33:45.211130'),
(10, 'auth', '0008_alter_user_username_max_length', '2025-06-10 19:33:45.276469'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2025-06-10 19:33:45.360474'),
(12, 'auth', '0010_alter_group_name_max_length', '2025-06-10 19:33:45.586713'),
(13, 'auth', '0011_update_proxy_permissions', '2025-06-10 19:33:45.745060'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2025-06-10 19:33:45.801913'),
(19, 'sessions', '0001_initial', '2025-06-10 19:34:48.869837'),
(25, 'Agri_Connect_CI', '0001_initial', '2025-06-12 16:39:06.384680'),
(26, 'admin', '0001_initial', '2025-06-12 16:39:06.574951'),
(27, 'admin', '0002_logentry_remove_auto_add', '2025-06-12 16:39:06.708868'),
(28, 'admin', '0003_logentry_add_action_flag_choices', '2025-06-12 16:39:06.829701'),
(29, 'Agri_Connect_CI', '0002_alter_vehicule_capacite', '2025-06-12 17:01:38.900704'),
(30, 'Agri_Connect_CI', '0003_prepare_livreur_relation', '2025-06-13 12:35:33.075708'),
(31, 'Agri_Connect_CI', '0004_finalize_livreur_relation', '2025-06-13 12:35:35.990566'),
(32, 'Agri_Connect_CI', '0002_migrate_livreur_data', '2025-06-13 12:40:47.983286'),
(33, 'Agri_Connect_CI', '0003_remove_livreur_utilisateur_new_and_more', '2025-06-13 12:45:32.854243'),
(34, 'Agri_Connect_CI', '0004_alter_livreur_utilisateur', '2025-06-13 12:47:36.943352'),
(35, 'Agri_Connect_CI', '0005_alter_producteur_utilisateur', '2025-06-13 13:04:47.322178'),
(36, 'Agri_Connect_CI', '0006_documentproducteur', '2025-06-14 23:48:35.403471'),
(37, 'Agri_Connect_CI', '0007_typelivraison_tariflivreur', '2025-06-15 20:52:08.540850'),
(38, 'Agri_Connect_CI', '0008_tariflivreur_libelle', '2025-06-16 19:54:40.089880');

-- --------------------------------------------------------

--
-- Structure de la table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('021rwxa2pztnowntfvmykjl6qx9lsu9x', '.eJxVUctqwzAQ_BXjczF-W_axkPSSpFBoSUPB6LGylchSIsl5NOTfK9MUmotgZ2Z3dkfXsMWj69vRgmkFC5swScOn_yDBdAdqYtgWq05HVCtnBIkmSXRnbbTUDOTzXfswoMe29915RrOaIYTKsgKSxymuUoaTEiEoCsYJpHVCyixmeYxSSjCDvEqJF5ZFVlJU-6Fcm6Fl2OGwuYbUGj4IxiScsAGnvbF3idMsHyBJdwe-gYovJJ9vsuWZj5-HTccua3eyb3S5qlX1_d6XxastFof5ebbWp9nqpYjRn4u77MGP81cY8NhUtlgprSj8xjSl5MTENuEHKAcBg4CAlP7FCitf65FCQEfpxPFrjGOowQb4CDSwWqjI9zOw1Ii9E3paXert0HTHbXfm_YVxz_ukuTDD9Cnh7WExNUrpASHB-ixutx9lvJkT:1uQUnu:0uOeqIPYTZto0y-we0wcxrIcs2b9er362dOU-cUGBlA', '2025-06-14 18:36:30.206116'),
('0dsnmcgpsbmjahgwgzjcp4e9gr4xl36j', '.eJxVjcEOwiAQRP-FsyFAV6AevfsNZBdYqRqalPZk_Hdp0oNe572ZeYuA21rC1vISpiQuQitx-g0J4zPXnaQH1vss41zXZSK5K_KgTd7mlF_Xw_0bKNhKb5OxzmMcmA058MMIThEYB0iZxjOpqLRDZg2WU2b2oKzRpLoP_SWKzxcL6Di0:1uQo6E:97vkIT54-Dvy6ZiJ2MrqI6d1PB7TAE669b10Aur5YMM', '2025-06-15 15:12:42.655202'),
('3hwos6li9teykb71zt43rpa4mopv72a5', '.eJxVjcEOwiAQRP-FsyFAV6AevfsNZBdYqRqalPZk_Hdp0oNe572ZeYuA21rC1vISpiQuQitx-g0J4zPXnaQH1vss41zXZSK5K_KgTd7mlF_Xw_0bKNhKb5OxzmMcmA058MMIThEYB0iZxjOpqLRDZg2WU2b2oKzRpLoP_SWKzxcL6Di0:1uQx4l:ir4J8YDqnTmDktOOKyosv6of-XLTfH3Gm5Bs6YGWtMI', '2025-06-16 00:47:47.704971'),
('6z80b3ole6cv6fpqtn97f1dbosm570lg', '.eJxVjLEOgzAQQ_8lcxVBDkjSsTvfEN3lLg1tBRKBqeq_N0gMreTB8rP9VgH3LYe9yBomVlfl1OU3I4xPmQ_AD5zvi47LvK0T6aOiT1r0uLC8bmf37yBjyXUNfgDTdIKto9hXS2BsaiwaBCPJgOG29dFXEVrP4F3HItAzCQ0J1OcLydU31A:1uRJHr:EMpSbWlW-m9E9Cvx5d1Bfdtp0pjo7eMKgkfAQb1aWW0', '2025-06-17 00:30:47.346033'),
('90lixwx0c0h0510xqe6kulgffiaqvs1m', '.eJxVjLEOgzAQQ_8lcxVBDkjSsTvfEN3lLg1tBRKBqeq_N0gMreTB8rP9VgH3LYe9yBomVlfl1OU3I4xPmQ_AD5zvi47LvK0T6aOiT1r0uLC8bmf37yBjyXUNfgDTdIKto9hXS2BsaiwaBCPJgOG29dFXEVrP4F3HItAzCQ0J1OcLydU31A:1uQmIH:Vs_NgAnFHN-A1wEmca-eDpjS1gNbfOkzlS09f91829s', '2025-06-15 13:17:01.221878'),
('akx1y96jv8xbopj9hgwh7gs6c4gtn726', '.eJxVjcEOwiAQRP-FsyFAV6AevfsNZBdYqRqalPZk_Hdp0oNe572ZeYuA21rC1vISpiQuQitx-g0J4zPXnaQH1vss41zXZSK5K_KgTd7mlF_Xw_0bKNhKb5OxzmMcmA058MMIThEYB0iZxjOpqLRDZg2WU2b2oKzRpLoP_SWKzxcL6Di0:1uQpzj:eJAZqPdviQZOOv-qFtNeCIHN9Nv3pDLFBuIl3vjwScI', '2025-06-15 17:14:07.163312'),
('j6tsgr04lkcjhltci5s4ivznmauty9ra', '.eJxVjDsOAjEMBe-SGkV22I1iSnrOsLKdhCygRNpPhbg7irQFtG9m3ttMvG9l2te0THM0F4ODOf2OwvpMtZP44HpvVlvdlllsV-xBV3trMb2uh_t3UHgtvUYPwJB8Fs4SBTKQQj6LOnSj04BR0YkSMQ_ESj6gEGEaAZxSMJ8vKkc4eA:1uQkmK:_VscrOiyJxHPS3nS9WmLsWL6mp68Qq3AQhdjA3OVN4Y', '2025-06-15 11:39:56.277431'),
('lfloicc61484jjarv0vtgbb1pir1zhsy', '.eJxVjLEOgzAQQ_8lcxVBDkjSsTvfEN3lLg1tBRKBqeq_N0gMreTB8rP9VgH3LYe9yBomVlfl1OU3I4xPmQ_AD5zvi47LvK0T6aOiT1r0uLC8bmf37yBjyXUNfgDTdIKto9hXS2BsaiwaBCPJgOG29dFXEVrP4F3HItAzCQ0J1OcLydU31A:1uQYpo:QSgUM3tFypvWfJFJbHkNDMOasTlglEn4aQhJaPoe_i8', '2025-06-14 22:54:44.407957'),
('mh8x5rc88f5bwjab0ltfaida2ycrrpqu', '.eJxVjDsOwjAQBe_iGlnxJ_aGkp4zWLvehQSQLcVJhbg7iZQC2jcz760SrsuY1iZzmlidlbHq9DsS5qeUnfADy73qXMsyT6R3RR-06WtleV0O9-9gxDZutXfZDQwAIUQh31mMltEEAOl7vpHYwVBwHfsObCZk8dHSJobehQyD-nwB9s43rA:1uQcUq:rcc6SANWVF4Zjj4Ovf3LLdnj-AC88DTT6vSd1T5qxF4', '2025-06-15 02:49:20.442953'),
('na5ln8gu5cm0xxc8uk4znuvz8n2s3meh', '.eJxVjMsOwiAQRf-FtSEwzEBx6d5vIDylaiAp7cr479qkC93ec859Mee3tbpt5MXNiZ2ZJHb6HYOPj9x2ku6-3TqPva3LHPiu8IMOfu0pPy-H-3dQ_ajfWhNZkEbbUDCiILQFbFJB24moUFJaQEQIUEqKRLKoCQMYiwYESsrs_QHakzbO:1uRHXt:mP6VktY7bd0jVBMvI8j9fcSpBecyy--dUTitsRDsgSs', '2025-06-16 22:39:13.348933'),
('nmhze79rzpbrj25tvzhqodyk15rvoac3', '.eJxVjDsOAjEMBe-SGkV22I1iSnrOsLKdhCygRNpPhbg7irQFtG9m3ttMvG9l2te0THM0F4ODOf2OwvpMtZP44HpvVlvdlllsV-xBV3trMb2uh_t3UHgtvUYPwJB8Fs4SBTKQQj6LOnSj04BR0YkSMQ_ESj6gEGEaAZxSMJ8vKkc4eA:1uQe2P:VOwys1EXQQPes1iDKqoTfz3_9c2dmpS6k2hQjeUEB4U', '2025-06-15 04:28:05.692581'),
('oee665ahlu7f8rvr4jdwttzaptsv4ra1', '.eJxVjLEOgzAQQ_8lcxVBDkjSsTvfEN3lLg1tBRKBqeq_N0gMreTB8rP9VgH3LYe9yBomVlfl1OU3I4xPmQ_AD5zvi47LvK0T6aOiT1r0uLC8bmf37yBjyXUNfgDTdIKto9hXS2BsaiwaBCPJgOG29dFXEVrP4F3HItAzCQ0J1OcLydU31A:1uRIdj:JzhpvZGuT7MXIDYomCu1cOuN0jJ_CqeB3xxJ1Ocm2Ag', '2025-06-16 23:49:19.512233'),
('qdgqvv16fhma5f46xqygk1jedzhbe9v4', '.eJxVkV9v2jAUxb9KlOc1yl_j8DYqVI1SrdooaFKlyLGvyS2JzWwH2Cq--xwIU_uSxL97z7kn1-9hxXrXVL0FU6EIp2GShl8-wprxHaihIt6Y2uqIa-UM1tHQEo1VGz1pAe1s7P1k0DDbeHWe8awUlFJCJlDnccomqWAJoRSKQsga0jKpSRaLPKYpr5mAfJLWvpEUGeG09KZSm64SzLFw-h5ya2SHQrRwZAac9oP9lM3qeX36e7RLu7C_HhfxsY6f9vPHr5sVpw8Pyf1c7ApDXpbd941bFO3q23K3qX_k69P8ebYV9z9vU9yfPXi7vdGiR-cpZw622iCMW_JoLF7BsDWlu-qmmIYe_O6ZcugGp6Qso3L4iV55UHVgewP_jfBUDZzhlcVx7LGAA9pbj9-6QIdaKehAjf4cjEOJPpsvXFGLB8PQalUJtHutsG5vFj7JxX7t9RAICGpoW_9kiil_1j2HgPetw8NrH8dQgg3YAXhgNaroksdyg_tx1uwq66R6c0oqKQMlG_9qpPK92LEtpNdIl-9sTKyVRNNdEp0_7Vr1besBtmCH672IkuEKGu30XULijGYZIQUt6B2QRCQTRkma5hE7oAzP5395seiF:1uQNF5:sEmlQCtuM_mbh0PhrvLF1nh4vsODIUTAu7lRE5tLGCQ', '2025-06-14 10:32:03.681748'),
('qha4bchh0eqmznho6ber79h5siamxwkl', '.eJxVjDsOwjAQBe_iGlnxJ_aGkp4zWLvehQSQLcVJhbg7iZQC2jcz760SrsuY1iZzmlidlbHq9DsS5qeUnfADy73qXMsyT6R3RR-06WtleV0O9-9gxDZutXfZDQwAIUQh31mMltEEAOl7vpHYwVBwHfsObCZk8dHSJobehQyD-nwB9s43rA:1uQQZL:X_CUTQthdV-VmhcZlibK_AV6uftlB3yQo5H7jumPiJM', '2025-06-14 14:05:11.982577'),
('rlidv24lve5ws8wsmurm5lohbbxkksqg', '.eJxVjLEOgzAQQ_8lcxVBDkjSsTvfEN3lLg1tBRKBqeq_N0gMreTB8rP9VgH3LYe9yBomVlfl1OU3I4xPmQ_AD5zvi47LvK0T6aOiT1r0uLC8bmf37yBjyXUNfgDTdIKto9hXS2BsaiwaBCPJgOG29dFXEVrP4F3HItAzCQ0J1OcLydU31A:1uRCgi:BRakjcElS4uM8r3oeNoUoh7QeJPZ0bbkWVyXOGSTRHA', '2025-06-16 17:28:00.250401'),
('s1uy5lzuggn2nc87uzzu4ruvwyr7geut', '.eJxVjMsOwiAQRf-FtSEwzEBx6d5vIDylaiAp7cr479qkC93ec859Mee3tbpt5MXNiZ2ZJHb6HYOPj9x2ku6-3TqPva3LHPiu8IMOfu0pPy-H-3dQ_ajfWhNZkEbbUDCiILQFbFJB24moUFJaQEQIUEqKRLKoCQMYiwYESsrs_QHakzbO:1uQy8E:rpigWEfRhrlsFkDtdXUmEsHk-x_jiNzWSDjs6XxD068', '2025-06-16 01:55:26.245487'),
('ysh87h3gmj3efde95daynu3r90ye2hon', '.eJxVjcEOwiAQRP-FsyFAV6AevfsNZBdYqRqalPZk_Hdp0oNe572ZeYuA21rC1vISpiQuQitx-g0J4zPXnaQH1vss41zXZSK5K_KgTd7mlF_Xw_0bKNhKb5OxzmMcmA058MMIThEYB0iZxjOpqLRDZg2WU2b2oKzRpLoP_SWKzxcL6Di0:1uQuLi:5tJX1KZMGSf8N06m61XqezT4RFDxCFibhQZfXJabSj8', '2025-06-15 21:53:06.346102');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `agri_connect_ci_annonce`
--
ALTER TABLE `agri_connect_ci_annonce`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Agri_Connect_CI_anno_auteur_id_c45c43a4_fk_Agri_Conn` (`auteur_id`),
  ADD KEY `Agri_Connect_CI_anno_type_annonce_id_df6d35b5_fk_Agri_Conn` (`type_annonce_id`),
  ADD KEY `Agri_Connect_CI_anno_zone_id_b31a93ba_fk_Agri_Conn` (`zone_id`);

--
-- Index pour la table `agri_connect_ci_annonceimage`
--
ALTER TABLE `agri_connect_ci_annonceimage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Agri_Connect_CI_anno_annonce_id_0088b884_fk_Agri_Conn` (`annonce_id`);

--
-- Index pour la table `agri_connect_ci_annonceproduit`
--
ALTER TABLE `agri_connect_ci_annonceproduit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Agri_Connect_CI_anno_annonce_id_4edc5c7f_fk_Agri_Conn` (`annonce_id`),
  ADD KEY `Agri_Connect_CI_anno_categorie_id_284d0e06_fk_Agri_Conn` (`categorie_id`),
  ADD KEY `Agri_Connect_CI_anno_certification_id_2b173bed_fk_Agri_Conn` (`certification_id`),
  ADD KEY `Agri_Connect_CI_anno_conditionnement_id_e5984c9b_fk_Agri_Conn` (`conditionnement_id`),
  ADD KEY `Agri_Connect_CI_anno_devise_id_f77940c6_fk_Agri_Conn` (`devise_id`),
  ADD KEY `Agri_Connect_CI_anno_unite_id_6234f80b_fk_Agri_Conn` (`unite_id`);

--
-- Index pour la table `agri_connect_ci_capacitevehicule`
--
ALTER TABLE `agri_connect_ci_capacitevehicule`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `agri_connect_ci_categorieproduit`
--
ALTER TABLE `agri_connect_ci_categorieproduit`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `agri_connect_ci_certification`
--
ALTER TABLE `agri_connect_ci_certification`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `agri_connect_ci_conditionnement`
--
ALTER TABLE `agri_connect_ci_conditionnement`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `agri_connect_ci_contact`
--
ALTER TABLE `agri_connect_ci_contact`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Agri_Connect_CI_cont_type_contact_id_3a5514be_fk_Agri_Conn` (`type_contact_id`),
  ADD KEY `Agri_Connect_CI_cont_utilisateur_id_367cd2a7_fk_Agri_Conn` (`utilisateur_id`);

--
-- Index pour la table `agri_connect_ci_devise`
--
ALTER TABLE `agri_connect_ci_devise`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `agri_connect_ci_disponibilitelivreur`
--
ALTER TABLE `agri_connect_ci_disponibilitelivreur`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Agri_Connect_CI_disp_livreur_id_8dfe1cb5_fk_Agri_Conn` (`livreur_id`);

--
-- Index pour la table `agri_connect_ci_documentproducteur`
--
ALTER TABLE `agri_connect_ci_documentproducteur`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Agri_Connect_CI_docu_producteur_id_744767b4_fk_Agri_Conn` (`producteur_id`);

--
-- Index pour la table `agri_connect_ci_etatlivreur`
--
ALTER TABLE `agri_connect_ci_etatlivreur`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `agri_connect_ci_faq`
--
ALTER TABLE `agri_connect_ci_faq`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `agri_connect_ci_favoris`
--
ALTER TABLE `agri_connect_ci_favoris`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Agri_Connect_CI_favoris_utilisateur_id_annonce_id_99d5ca14_uniq` (`utilisateur_id`,`annonce_id`),
  ADD KEY `Agri_Connect_CI_favo_annonce_id_f25cecff_fk_Agri_Conn` (`annonce_id`);

--
-- Index pour la table `agri_connect_ci_livreur`
--
ALTER TABLE `agri_connect_ci_livreur`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Agri_Connect_CI_livreur_utilisateur_id_3985c1e4_uniq` (`utilisateur_id`),
  ADD KEY `Agri_Connect_CI_livr_tarif_id_e7c64235_fk_Agri_Conn` (`tarif_id`),
  ADD KEY `Agri_Connect_CI_livr_type_livreur_id_772fbbce_fk_Agri_Conn` (`type_livreur_id`),
  ADD KEY `Agri_Connect_CI_livr_etat_id_2235b2ab_fk_Agri_Conn` (`etat_id`);

--
-- Index pour la table `agri_connect_ci_livreurmoyentransport`
--
ALTER TABLE `agri_connect_ci_livreurmoyentransport`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Agri_Connect_CI_livr_livreur_id_0c772cc1_fk_Agri_Conn` (`livreur_id`),
  ADD KEY `Agri_Connect_CI_livr_moyen_transport_id_a97549f1_fk_Agri_Conn` (`moyen_transport_id`);

--
-- Index pour la table `agri_connect_ci_livreurzone`
--
ALTER TABLE `agri_connect_ci_livreurzone`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Agri_Connect_CI_livr_livreur_id_dfaf597b_fk_Agri_Conn` (`livreur_id`),
  ADD KEY `Agri_Connect_CI_livr_zone_id_12b49f04_fk_Agri_Conn` (`zone_id`);

--
-- Index pour la table `agri_connect_ci_miseenrelation`
--
ALTER TABLE `agri_connect_ci_miseenrelation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Agri_Connect_CI_mise_client_id_14bb80c8_fk_Agri_Conn` (`client_id`),
  ADD KEY `Agri_Connect_CI_mise_livreur_id_43b239e6_fk_Agri_Conn` (`livreur_id`),
  ADD KEY `Agri_Connect_CI_mise_moyen_contact_id_2d91312a_fk_Agri_Conn` (`moyen_contact_id`),
  ADD KEY `Agri_Connect_CI_mise_producteur_id_f20ed1e6_fk_Agri_Conn` (`producteur_id`);

--
-- Index pour la table `agri_connect_ci_moyentransport`
--
ALTER TABLE `agri_connect_ci_moyentransport`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `agri_connect_ci_notation`
--
ALTER TABLE `agri_connect_ci_notation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Agri_Connect_CI_nota_evaluateur_id_6e851655_fk_Agri_Conn` (`evaluateur_id`),
  ADD KEY `Agri_Connect_CI_nota_livreur_id_0548bf01_fk_Agri_Conn` (`livreur_id`),
  ADD KEY `Agri_Connect_CI_nota_mise_en_relation_id_cbdf4aac_fk_Agri_Conn` (`mise_en_relation_id`),
  ADD KEY `Agri_Connect_CI_nota_producteur_id_a4778e73_fk_Agri_Conn` (`producteur_id`);

--
-- Index pour la table `agri_connect_ci_notification`
--
ALTER TABLE `agri_connect_ci_notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Agri_Connect_CI_noti_utilisateur_id_ecf296c4_fk_Agri_Conn` (`utilisateur_id`);

--
-- Index pour la table `agri_connect_ci_positionactuelle`
--
ALTER TABLE `agri_connect_ci_positionactuelle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Agri_Connect_CI_posi_livreur_id_c7be97cb_fk_Agri_Conn` (`livreur_id`);

--
-- Index pour la table `agri_connect_ci_producteur`
--
ALTER TABLE `agri_connect_ci_producteur`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `utilisateur_id` (`utilisateur_id`);

--
-- Index pour la table `agri_connect_ci_producteurproduit`
--
ALTER TABLE `agri_connect_ci_producteurproduit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Agri_Connect_CI_prod_categorie_id_3f563634_fk_Agri_Conn` (`categorie_id`),
  ADD KEY `Agri_Connect_CI_prod_producteur_id_18a1575a_fk_Agri_Conn` (`producteur_id`);

--
-- Index pour la table `agri_connect_ci_tarif`
--
ALTER TABLE `agri_connect_ci_tarif`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Agri_Connect_CI_tari_devise_id_4ec73976_fk_Agri_Conn` (`devise_id`);

--
-- Index pour la table `agri_connect_ci_tariflivreur`
--
ALTER TABLE `agri_connect_ci_tariflivreur`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Agri_Connect_CI_tarifliv_livreur_id_type_livraiso_cfd06ff5_uniq` (`livreur_id`,`type_livraison_id`,`zone_id`),
  ADD UNIQUE KEY `Agri_Connect_CI_tarifliv_livreur_id_vehicule_id_t_61cab4fc_uniq` (`livreur_id`,`vehicule_id`,`type_livraison_id`,`zone_id`),
  ADD KEY `Agri_Connect_CI_tari_devise_id_e5d4ec3d_fk_Agri_Conn` (`devise_id`),
  ADD KEY `Agri_Connect_CI_tari_type_livraison_id_b648a1d0_fk_Agri_Conn` (`type_livraison_id`),
  ADD KEY `Agri_Connect_CI_tari_vehicule_id_762f6785_fk_Agri_Conn` (`vehicule_id`),
  ADD KEY `Agri_Connect_CI_tari_zone_id_117a8b0c_fk_Agri_Conn` (`zone_id`);

--
-- Index pour la table `agri_connect_ci_typeannonce`
--
ALTER TABLE `agri_connect_ci_typeannonce`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `agri_connect_ci_typecontact`
--
ALTER TABLE `agri_connect_ci_typecontact`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `agri_connect_ci_typelivraison`
--
ALTER TABLE `agri_connect_ci_typelivraison`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `agri_connect_ci_typelivreur`
--
ALTER TABLE `agri_connect_ci_typelivreur`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `agri_connect_ci_unitemesure`
--
ALTER TABLE `agri_connect_ci_unitemesure`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `agri_connect_ci_utilisateur`
--
ALTER TABLE `agri_connect_ci_utilisateur`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `Agri_Connect_CI_util_zone_id_30bf5c80_fk_Agri_Conn` (`zone_id`);

--
-- Index pour la table `agri_connect_ci_utilisateur_groups`
--
ALTER TABLE `agri_connect_ci_utilisateur_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Agri_Connect_CI_utilisat_utilisateur_id_group_id_cf50c58d_uniq` (`utilisateur_id`,`group_id`),
  ADD KEY `Agri_Connect_CI_util_group_id_50868bbe_fk_auth_grou` (`group_id`);

--
-- Index pour la table `agri_connect_ci_utilisateur_user_permissions`
--
ALTER TABLE `agri_connect_ci_utilisateur_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Agri_Connect_CI_utilisat_utilisateur_id_permissio_0af32f73_uniq` (`utilisateur_id`,`permission_id`),
  ADD KEY `Agri_Connect_CI_util_permission_id_1416f994_fk_auth_perm` (`permission_id`);

--
-- Index pour la table `agri_connect_ci_vehicule`
--
ALTER TABLE `agri_connect_ci_vehicule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Agri_Connect_CI_vehi_livreur_id_2991d32f_fk_Agri_Conn` (`livreur_id`),
  ADD KEY `Agri_Connect_CI_vehi_capacite_id_2796dbf1_fk_Agri_Conn` (`capacite_id`);

--
-- Index pour la table `agri_connect_ci_zone`
--
ALTER TABLE `agri_connect_ci_zone`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Index pour la table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Index pour la table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Index pour la table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_Agri_Conn` (`user_id`);

--
-- Index pour la table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Index pour la table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_annonce`
--
ALTER TABLE `agri_connect_ci_annonce`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_annonceimage`
--
ALTER TABLE `agri_connect_ci_annonceimage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_annonceproduit`
--
ALTER TABLE `agri_connect_ci_annonceproduit`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_capacitevehicule`
--
ALTER TABLE `agri_connect_ci_capacitevehicule`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_categorieproduit`
--
ALTER TABLE `agri_connect_ci_categorieproduit`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_certification`
--
ALTER TABLE `agri_connect_ci_certification`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_conditionnement`
--
ALTER TABLE `agri_connect_ci_conditionnement`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_contact`
--
ALTER TABLE `agri_connect_ci_contact`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_devise`
--
ALTER TABLE `agri_connect_ci_devise`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_disponibilitelivreur`
--
ALTER TABLE `agri_connect_ci_disponibilitelivreur`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_documentproducteur`
--
ALTER TABLE `agri_connect_ci_documentproducteur`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_etatlivreur`
--
ALTER TABLE `agri_connect_ci_etatlivreur`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_faq`
--
ALTER TABLE `agri_connect_ci_faq`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_favoris`
--
ALTER TABLE `agri_connect_ci_favoris`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_livreur`
--
ALTER TABLE `agri_connect_ci_livreur`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_livreurmoyentransport`
--
ALTER TABLE `agri_connect_ci_livreurmoyentransport`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_livreurzone`
--
ALTER TABLE `agri_connect_ci_livreurzone`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_miseenrelation`
--
ALTER TABLE `agri_connect_ci_miseenrelation`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_moyentransport`
--
ALTER TABLE `agri_connect_ci_moyentransport`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_notation`
--
ALTER TABLE `agri_connect_ci_notation`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_notification`
--
ALTER TABLE `agri_connect_ci_notification`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_positionactuelle`
--
ALTER TABLE `agri_connect_ci_positionactuelle`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_producteur`
--
ALTER TABLE `agri_connect_ci_producteur`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_producteurproduit`
--
ALTER TABLE `agri_connect_ci_producteurproduit`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_tarif`
--
ALTER TABLE `agri_connect_ci_tarif`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_tariflivreur`
--
ALTER TABLE `agri_connect_ci_tariflivreur`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_typeannonce`
--
ALTER TABLE `agri_connect_ci_typeannonce`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_typecontact`
--
ALTER TABLE `agri_connect_ci_typecontact`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_typelivraison`
--
ALTER TABLE `agri_connect_ci_typelivraison`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_typelivreur`
--
ALTER TABLE `agri_connect_ci_typelivreur`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_unitemesure`
--
ALTER TABLE `agri_connect_ci_unitemesure`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_utilisateur`
--
ALTER TABLE `agri_connect_ci_utilisateur`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_utilisateur_groups`
--
ALTER TABLE `agri_connect_ci_utilisateur_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_utilisateur_user_permissions`
--
ALTER TABLE `agri_connect_ci_utilisateur_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_vehicule`
--
ALTER TABLE `agri_connect_ci_vehicule`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `agri_connect_ci_zone`
--
ALTER TABLE `agri_connect_ci_zone`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=157;

--
-- AUTO_INCREMENT pour la table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT pour la table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT pour la table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `agri_connect_ci_annonce`
--
ALTER TABLE `agri_connect_ci_annonce`
  ADD CONSTRAINT `Agri_Connect_CI_anno_auteur_id_c45c43a4_fk_Agri_Conn` FOREIGN KEY (`auteur_id`) REFERENCES `agri_connect_ci_utilisateur` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_anno_type_annonce_id_df6d35b5_fk_Agri_Conn` FOREIGN KEY (`type_annonce_id`) REFERENCES `agri_connect_ci_typeannonce` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_anno_zone_id_b31a93ba_fk_Agri_Conn` FOREIGN KEY (`zone_id`) REFERENCES `agri_connect_ci_zone` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_annonceimage`
--
ALTER TABLE `agri_connect_ci_annonceimage`
  ADD CONSTRAINT `Agri_Connect_CI_anno_annonce_id_0088b884_fk_Agri_Conn` FOREIGN KEY (`annonce_id`) REFERENCES `agri_connect_ci_annonce` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_annonceproduit`
--
ALTER TABLE `agri_connect_ci_annonceproduit`
  ADD CONSTRAINT `Agri_Connect_CI_anno_annonce_id_4edc5c7f_fk_Agri_Conn` FOREIGN KEY (`annonce_id`) REFERENCES `agri_connect_ci_annonce` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_anno_categorie_id_284d0e06_fk_Agri_Conn` FOREIGN KEY (`categorie_id`) REFERENCES `agri_connect_ci_categorieproduit` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_anno_certification_id_2b173bed_fk_Agri_Conn` FOREIGN KEY (`certification_id`) REFERENCES `agri_connect_ci_certification` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_anno_conditionnement_id_e5984c9b_fk_Agri_Conn` FOREIGN KEY (`conditionnement_id`) REFERENCES `agri_connect_ci_conditionnement` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_anno_devise_id_f77940c6_fk_Agri_Conn` FOREIGN KEY (`devise_id`) REFERENCES `agri_connect_ci_devise` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_anno_unite_id_6234f80b_fk_Agri_Conn` FOREIGN KEY (`unite_id`) REFERENCES `agri_connect_ci_unitemesure` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_contact`
--
ALTER TABLE `agri_connect_ci_contact`
  ADD CONSTRAINT `Agri_Connect_CI_cont_type_contact_id_3a5514be_fk_Agri_Conn` FOREIGN KEY (`type_contact_id`) REFERENCES `agri_connect_ci_typecontact` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_cont_utilisateur_id_367cd2a7_fk_Agri_Conn` FOREIGN KEY (`utilisateur_id`) REFERENCES `agri_connect_ci_utilisateur` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_disponibilitelivreur`
--
ALTER TABLE `agri_connect_ci_disponibilitelivreur`
  ADD CONSTRAINT `Agri_Connect_CI_disp_livreur_id_8dfe1cb5_fk_Agri_Conn` FOREIGN KEY (`livreur_id`) REFERENCES `agri_connect_ci_livreur` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_documentproducteur`
--
ALTER TABLE `agri_connect_ci_documentproducteur`
  ADD CONSTRAINT `Agri_Connect_CI_docu_producteur_id_744767b4_fk_Agri_Conn` FOREIGN KEY (`producteur_id`) REFERENCES `agri_connect_ci_producteur` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_favoris`
--
ALTER TABLE `agri_connect_ci_favoris`
  ADD CONSTRAINT `Agri_Connect_CI_favo_annonce_id_f25cecff_fk_Agri_Conn` FOREIGN KEY (`annonce_id`) REFERENCES `agri_connect_ci_annonce` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_favo_utilisateur_id_5b276b12_fk_Agri_Conn` FOREIGN KEY (`utilisateur_id`) REFERENCES `agri_connect_ci_utilisateur` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_livreur`
--
ALTER TABLE `agri_connect_ci_livreur`
  ADD CONSTRAINT `Agri_Connect_CI_livr_etat_id_2235b2ab_fk_Agri_Conn` FOREIGN KEY (`etat_id`) REFERENCES `agri_connect_ci_etatlivreur` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_livr_tarif_id_e7c64235_fk_Agri_Conn` FOREIGN KEY (`tarif_id`) REFERENCES `agri_connect_ci_tarif` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_livr_type_livreur_id_772fbbce_fk_Agri_Conn` FOREIGN KEY (`type_livreur_id`) REFERENCES `agri_connect_ci_typelivreur` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_livr_utilisateur_id_3985c1e4_fk_Agri_Conn` FOREIGN KEY (`utilisateur_id`) REFERENCES `agri_connect_ci_utilisateur` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_livreurmoyentransport`
--
ALTER TABLE `agri_connect_ci_livreurmoyentransport`
  ADD CONSTRAINT `Agri_Connect_CI_livr_livreur_id_0c772cc1_fk_Agri_Conn` FOREIGN KEY (`livreur_id`) REFERENCES `agri_connect_ci_livreur` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_livr_moyen_transport_id_a97549f1_fk_Agri_Conn` FOREIGN KEY (`moyen_transport_id`) REFERENCES `agri_connect_ci_moyentransport` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_livreurzone`
--
ALTER TABLE `agri_connect_ci_livreurzone`
  ADD CONSTRAINT `Agri_Connect_CI_livr_livreur_id_dfaf597b_fk_Agri_Conn` FOREIGN KEY (`livreur_id`) REFERENCES `agri_connect_ci_livreur` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_livr_zone_id_12b49f04_fk_Agri_Conn` FOREIGN KEY (`zone_id`) REFERENCES `agri_connect_ci_zone` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_miseenrelation`
--
ALTER TABLE `agri_connect_ci_miseenrelation`
  ADD CONSTRAINT `Agri_Connect_CI_mise_client_id_14bb80c8_fk_Agri_Conn` FOREIGN KEY (`client_id`) REFERENCES `agri_connect_ci_utilisateur` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_mise_livreur_id_43b239e6_fk_Agri_Conn` FOREIGN KEY (`livreur_id`) REFERENCES `agri_connect_ci_livreur` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_mise_moyen_contact_id_2d91312a_fk_Agri_Conn` FOREIGN KEY (`moyen_contact_id`) REFERENCES `agri_connect_ci_typecontact` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_mise_producteur_id_f20ed1e6_fk_Agri_Conn` FOREIGN KEY (`producteur_id`) REFERENCES `agri_connect_ci_producteur` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_notation`
--
ALTER TABLE `agri_connect_ci_notation`
  ADD CONSTRAINT `Agri_Connect_CI_nota_evaluateur_id_6e851655_fk_Agri_Conn` FOREIGN KEY (`evaluateur_id`) REFERENCES `agri_connect_ci_utilisateur` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_nota_livreur_id_0548bf01_fk_Agri_Conn` FOREIGN KEY (`livreur_id`) REFERENCES `agri_connect_ci_livreur` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_nota_mise_en_relation_id_cbdf4aac_fk_Agri_Conn` FOREIGN KEY (`mise_en_relation_id`) REFERENCES `agri_connect_ci_miseenrelation` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_nota_producteur_id_a4778e73_fk_Agri_Conn` FOREIGN KEY (`producteur_id`) REFERENCES `agri_connect_ci_producteur` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_notification`
--
ALTER TABLE `agri_connect_ci_notification`
  ADD CONSTRAINT `Agri_Connect_CI_noti_utilisateur_id_ecf296c4_fk_Agri_Conn` FOREIGN KEY (`utilisateur_id`) REFERENCES `agri_connect_ci_utilisateur` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_positionactuelle`
--
ALTER TABLE `agri_connect_ci_positionactuelle`
  ADD CONSTRAINT `Agri_Connect_CI_posi_livreur_id_c7be97cb_fk_Agri_Conn` FOREIGN KEY (`livreur_id`) REFERENCES `agri_connect_ci_livreur` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_producteur`
--
ALTER TABLE `agri_connect_ci_producteur`
  ADD CONSTRAINT `Agri_Connect_CI_prod_utilisateur_id_a50e1977_fk_Agri_Conn` FOREIGN KEY (`utilisateur_id`) REFERENCES `agri_connect_ci_utilisateur` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_producteurproduit`
--
ALTER TABLE `agri_connect_ci_producteurproduit`
  ADD CONSTRAINT `Agri_Connect_CI_prod_categorie_id_3f563634_fk_Agri_Conn` FOREIGN KEY (`categorie_id`) REFERENCES `agri_connect_ci_categorieproduit` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_prod_producteur_id_18a1575a_fk_Agri_Conn` FOREIGN KEY (`producteur_id`) REFERENCES `agri_connect_ci_producteur` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_tarif`
--
ALTER TABLE `agri_connect_ci_tarif`
  ADD CONSTRAINT `Agri_Connect_CI_tari_devise_id_4ec73976_fk_Agri_Conn` FOREIGN KEY (`devise_id`) REFERENCES `agri_connect_ci_devise` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_tariflivreur`
--
ALTER TABLE `agri_connect_ci_tariflivreur`
  ADD CONSTRAINT `Agri_Connect_CI_tari_devise_id_e5d4ec3d_fk_Agri_Conn` FOREIGN KEY (`devise_id`) REFERENCES `agri_connect_ci_devise` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_tari_livreur_id_391e4eee_fk_Agri_Conn` FOREIGN KEY (`livreur_id`) REFERENCES `agri_connect_ci_livreur` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_tari_type_livraison_id_b648a1d0_fk_Agri_Conn` FOREIGN KEY (`type_livraison_id`) REFERENCES `agri_connect_ci_typelivraison` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_tari_vehicule_id_762f6785_fk_Agri_Conn` FOREIGN KEY (`vehicule_id`) REFERENCES `agri_connect_ci_vehicule` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_tari_zone_id_117a8b0c_fk_Agri_Conn` FOREIGN KEY (`zone_id`) REFERENCES `agri_connect_ci_zone` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_utilisateur`
--
ALTER TABLE `agri_connect_ci_utilisateur`
  ADD CONSTRAINT `Agri_Connect_CI_util_zone_id_30bf5c80_fk_Agri_Conn` FOREIGN KEY (`zone_id`) REFERENCES `agri_connect_ci_zone` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_utilisateur_groups`
--
ALTER TABLE `agri_connect_ci_utilisateur_groups`
  ADD CONSTRAINT `Agri_Connect_CI_util_group_id_50868bbe_fk_auth_grou` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_util_utilisateur_id_9fdb0111_fk_Agri_Conn` FOREIGN KEY (`utilisateur_id`) REFERENCES `agri_connect_ci_utilisateur` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_utilisateur_user_permissions`
--
ALTER TABLE `agri_connect_ci_utilisateur_user_permissions`
  ADD CONSTRAINT `Agri_Connect_CI_util_permission_id_1416f994_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_util_utilisateur_id_d2aca8c9_fk_Agri_Conn` FOREIGN KEY (`utilisateur_id`) REFERENCES `agri_connect_ci_utilisateur` (`id`);

--
-- Contraintes pour la table `agri_connect_ci_vehicule`
--
ALTER TABLE `agri_connect_ci_vehicule`
  ADD CONSTRAINT `Agri_Connect_CI_vehi_capacite_id_2796dbf1_fk_Agri_Conn` FOREIGN KEY (`capacite_id`) REFERENCES `agri_connect_ci_capacitevehicule` (`id`),
  ADD CONSTRAINT `Agri_Connect_CI_vehi_livreur_id_2991d32f_fk_Agri_Conn` FOREIGN KEY (`livreur_id`) REFERENCES `agri_connect_ci_livreur` (`id`);

--
-- Contraintes pour la table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Contraintes pour la table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Contraintes pour la table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_Agri_Conn` FOREIGN KEY (`user_id`) REFERENCES `agri_connect_ci_utilisateur` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
