SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


DROP DATABASE IF EXISTS planeat;

CREATE DATABASE planeat;

USE planeat;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(64) NOT NULL AUTO_INCREMENT,
  `user_login` varchar(32) NOT NULL,
  `user_password` blob NOT NULL,
  `user_mail` varchar(24) DEFAULT NULL,
  `user_prenom` varchar(16) DEFAULT NULL,
  `user_nom` varchar(16) DEFAULT NULL,
  `user_ispremium` boolean DEFAULT FALSE,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_login` (`user_login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Structure de la table `ingredients`
--
DROP TABLE IF EXISTS `ingredients`;
CREATE TABLE IF NOT EXISTS `ingredients` (
  `ingredient_id` int(64) NOT NULL AUTO_INCREMENT,
  `ingredient_nom` varchar(16) DEFAULT NULL,
  `ingredient_type` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`ingredient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Structure de la table `recettes`
--
DROP TABLE IF EXISTS `recettes`;
CREATE TABLE IF NOT EXISTS `recettes` (
  `recette_id` int(64) NOT NULL AUTO_INCREMENT,
  `recette_nom` varchar(16) DEFAULT NULL,
  `recette_description` varchar(128) DEFAULT NULL,
  `recette_nb_personnes` int(64) DEFAULT NULL,
  `recette_temps_prep` int(64) DEFAULT NULL,
  PRIMARY KEY (`recette_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Structure de la table `users_recettes`
--
DROP TABLE IF EXISTS `users_recettes`;
CREATE TABLE IF NOT EXISTS `users_recettes` (
  `recette_id` int(64) NOT NULL,
  `users_id` int(64) NOT NULL,
  PRIMARY KEY (`recette_id`, `users_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Structure de la table `ingredients_recette`
--
DROP TABLE IF EXISTS `ingredients_recette`;
CREATE TABLE IF NOT EXISTS `ingredients_recette` (
  `recette_id` int(64) NOT NULL,
  `ingredient_id` int(64) NOT NULL,
  `quantity` int(64) NOT NULL,
  PRIMARY KEY (`recette_id`, `ingredient_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Structure de la table `planning`
--
DROP TABLE IF EXISTS `planning`;
CREATE TABLE IF NOT EXISTS `planning` (
  `planning_recette_id` int(64) NOT NULL,
  `planning_date_recette` date NOT NULL,
  `planning_user_id` int(64) NOT NULL,
  PRIMARY KEY (`planning_recette_id`, `planning_date_recette`, `planning_user_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Structure de la table `produits`
--
DROP TABLE IF EXISTS `produits`;
CREATE TABLE IF NOT EXISTS `produits` (
  `produit_id` int(64) NOT NULL,
  `produit_nom` int(64) NOT NULL,
  `produit_quantité` int(64) NOT NULL,
  `produit_ingredient_id` int(64) NOT NULL,
  PRIMARY KEY (`produit_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Structure de la table `liste_courses`
--
DROP TABLE IF EXISTS `liste_courses`;
CREATE TABLE IF NOT EXISTS `liste_courses` (
  `liste_courses_id` int(64) NOT NULL,
  `date_liste_courses` date NOT NULL,
  `amount` int(64) DEFAULT 0,
  `liste_courses_user_id` int(64) NOT NULL,
  PRIMARY KEY (`liste_courses_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Structure de la table `produit_liste_courses`
--
DROP TABLE IF EXISTS `produit_liste_courses`;
CREATE TABLE IF NOT EXISTS `produit_liste_courses` (
  `produit_id` int(64) NOT NULL,
  `liste_courses_id` int(64) NOT NULL,
  PRIMARY KEY (`produit_id`, `liste_courses_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Structure de la table `magasins`
--
DROP TABLE IF EXISTS `magasins`;
CREATE TABLE IF NOT EXISTS `magasins` (
  `magasin_id` int(64) NOT NULL AUTO_INCREMENT,
  `magasin_nom` varchar(64) NOT NULL,
  PRIMARY KEY (`magasin_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Structure de la table `articles`
--
DROP TABLE IF EXISTS `articles`;
CREATE TABLE IF NOT EXISTS `articles` (
  `magasin_id` int(64) NOT NULL,
  `produit_id` int(64) NOT NULL,
  PRIMARY KEY (`produit_id`, `magasin_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Structure de la table `panier`
--
DROP TABLE IF EXISTS `panier`;
CREATE TABLE IF NOT EXISTS `panier` (
  `liste_courses_id` int(64) NOT NULL,
  `recette_id` int(64) NOT NULL,
  PRIMARY KEY (`liste_courses_id`, `recette_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

