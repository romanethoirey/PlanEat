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
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
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
  `ingredient_id` int(11) NOT NULL AUTO_INCREMENT,
  `ingredient_nom` varchar(16) DEFAULT NULL,
  `ingredient_type` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`ingredient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Structure de la table `receipes`
--
DROP TABLE IF EXISTS `receipes`;
CREATE TABLE IF NOT EXISTS `receipes` (
  `receipe_id` int(11) NOT NULL AUTO_INCREMENT,
  `receipe_nom` varchar(16) DEFAULT NULL,
  `receipe_description` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`receipe_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Structure de la table `users_receipes`
--
DROP TABLE IF EXISTS `users_receipes`;
CREATE TABLE IF NOT EXISTS `users_receipes` (
  `receipe_id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  PRIMARY KEY (`receipe_id`, `users_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Structure de la table `ingredients_receipe`
--
DROP TABLE IF EXISTS `ingredients_receipe`;
CREATE TABLE IF NOT EXISTS `ingredients_receipe` (
  `receipe_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`receipe_id`, `ingredient_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Structure de la table `planning`
--
DROP TABLE IF EXISTS `planning`;
CREATE TABLE IF NOT EXISTS `planning` (
  `receipe_id` int(11) NOT NULL,
  `date_receipe` date NOT NULL,
  PRIMARY KEY (`receipe_id`, `date_receipe`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Structure de la table `shop_list`
--
DROP TABLE IF EXISTS `shop_list`;
CREATE TABLE IF NOT EXISTS `shop_list` (
  `shop_list_id` int(11) NOT NULL,
  `date_shop_list` date NOT NULL,
  `amount` int(11) DEFAULT 0,
  `ingredient_id` int(11) NOT NULL,
  PRIMARY KEY (`shop_list_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

