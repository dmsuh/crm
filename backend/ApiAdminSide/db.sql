/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS `esma` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `esma`;

CREATE TABLE IF NOT EXISTS `attributes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attribute_group_id` int NOT NULL,
  `sort_order` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_attributes_attribute_groups` (`attribute_group_id`),
  CONSTRAINT `FK_attributes_attribute_groups` FOREIGN KEY (`attribute_group_id`) REFERENCES `attribute_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `attributes` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `attribute_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sort_order` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `attribute_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `attribute_groups` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `attribute_group_languages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attribute_group_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_attribute_group_languages_attribute_groups` (`attribute_group_id`),
  KEY `FK_attribute_group_languages_languages` (`language_id`),
  CONSTRAINT `FK_attribute_group_languages_attribute_groups` FOREIGN KEY (`attribute_group_id`) REFERENCES `attribute_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_attribute_group_languages_languages` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `attribute_group_languages` DISABLE KEYS */;
/*!40000 ALTER TABLE `attribute_group_languages` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `attribute_languages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attribute_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_attribute_languages_attributes` (`attribute_id`),
  KEY `FK_attribute_languages_languages` (`language_id`),
  CONSTRAINT `FK_attribute_languages_attributes` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_attribute_languages_languages` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `attribute_languages` DISABLE KEYS */;
/*!40000 ALTER TABLE `attribute_languages` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `banners` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `banners` DISABLE KEYS */;
/*!40000 ALTER TABLE `banners` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `banner_images` (
  `id` int NOT NULL,
  `banner_id` int NOT NULL,
  `language_id` int NOT NULL,
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_banner_images_banners` (`banner_id`),
  KEY `FK_banner_images_languages` (`language_id`),
  CONSTRAINT `FK_banner_images_banners` FOREIGN KEY (`banner_id`) REFERENCES `banners` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_banner_images_languages` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `banner_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `banner_images` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `carts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `sesstion_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_carts_customers` (`customer_id`),
  KEY `FK_carts_sessions` (`sesstion_id`),
  KEY `FK_carts_products` (`product_id`),
  CONSTRAINT `FK_carts_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_carts_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_carts_sessions` FOREIGN KEY (`sesstion_id`) REFERENCES `sessions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `location` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `parent_id` int DEFAULT NULL,
  `is_top` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `location` (`location`),
  KEY `FK_categories_categories` (`parent_id`),
  CONSTRAINT `FK_categories_categories` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`, `location`, `image`, `parent_id`, `is_top`, `is_active`, `sort_order`, `created_at`, `updated_at`) VALUES
	(1, '1', '', NULL, 0, 0, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(2, '2', '', NULL, 0, 0, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(3, '3', '123', NULL, 0, 0, 0, '2022-09-19 22:41:10', '2022-09-19 22:41:10'),
	(10, '314', '123', NULL, 0, 0, 0, '2022-09-21 23:09:52', '2022-09-21 23:09:52');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `categories_filters` (
  `category_id` int NOT NULL,
  `filter_id` int NOT NULL,
  PRIMARY KEY (`category_id`,`filter_id`),
  KEY `FK_categories_filters_filters` (`filter_id`),
  CONSTRAINT `FK_categories_filters_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_categories_filters_filters` FOREIGN KEY (`filter_id`) REFERENCES `filters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `categories_filters` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories_filters` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `category_languages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `meta_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `meta_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `meta_keyword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_category_languages_categories` (`category_id`),
  KEY `FK_category_languages_languages` (`language_id`),
  CONSTRAINT `FK_category_languages_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_category_languages_languages` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `category_languages` DISABLE KEYS */;
INSERT INTO `category_languages` (`id`, `category_id`, `language_id`, `name`, `description`, `meta_title`, `meta_description`, `meta_keyword`) VALUES
	(1, 1, 1, 'Чипсы', 'Это чипсы', 'Чипсы', 'Это чипсы', 'чипсы'),
	(2, 2, 1, 'Лейс', 'Это лейс', 'Чипсы Лейс', 'Это чипсы лейс', 'чипсы'),
	(3, 10, 1, 'Чипсы', 'Это чипсы', 'Чипсы', 'Это чипсы', 'чипсы');
/*!40000 ALTER TABLE `category_languages` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_group_id` int NOT NULL,
  `store_id` int NOT NULL,
  `language_id` int NOT NULL,
  `first_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(96) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `telephone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_newsletter` tinyint(1) NOT NULL DEFAULT '0',
  `ip` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_safe` tinyint(1) NOT NULL,
  `token` json NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `FK_customers_customer_groups` (`customer_group_id`),
  KEY `FK_customers_stores` (`store_id`),
  KEY `FK_customers_languages` (`language_id`),
  CONSTRAINT `FK_customers_customer_groups` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_customers_languages` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_customers_stores` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `customer_addresses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `first_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `company` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `address_1` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `address_2` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `city` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `postcode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_customer_addresses_customers` (`customer_id`),
  CONSTRAINT `FK_customer_addresses_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `customer_addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_addresses` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `customer_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sort_order` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `customer_groups` DISABLE KEYS */;
INSERT INTO `customer_groups` (`id`, `sort_order`) VALUES
	(1, 1);
/*!40000 ALTER TABLE `customer_groups` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `customer_group_languages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_group_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_customer_group_languages_customer_groups` (`customer_group_id`),
  KEY `FK_customer_group_languages_languages` (`language_id`),
  CONSTRAINT `FK_customer_group_languages_customer_groups` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_customer_group_languages_languages` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `customer_group_languages` DISABLE KEYS */;
INSERT INTO `customer_group_languages` (`id`, `customer_group_id`, `language_id`, `name`, `description`) VALUES
	(1, 1, 1, 'Группа по умолчанию', 'Базовая группа клиентов');
/*!40000 ALTER TABLE `customer_group_languages` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `customer_wishlists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `product_id` int NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_customer_wishlists_customers` (`customer_id`),
  KEY `FK_customer_wishlists_products` (`product_id`),
  CONSTRAINT `FK_customer_wishlists_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_customer_wishlists_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `customer_wishlists` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_wishlists` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `filters` (
  `id` int NOT NULL AUTO_INCREMENT,
  `filter_group_id` int NOT NULL,
  `sort_order` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_filters_filter_groups` (`filter_group_id`),
  CONSTRAINT `FK_filters_filter_groups` FOREIGN KEY (`filter_group_id`) REFERENCES `filter_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `filters` DISABLE KEYS */;
/*!40000 ALTER TABLE `filters` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `filter_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `location` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sort_order` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `location` (`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `filter_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `filter_groups` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `filter_group_languages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `filter_group_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_filter_group_languages_filter_groups` (`filter_group_id`),
  KEY `FK_filter_group_languages_languages` (`language_id`),
  CONSTRAINT `FK_filter_group_languages_filter_groups` FOREIGN KEY (`filter_group_id`) REFERENCES `filter_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_filter_group_languages_languages` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `filter_group_languages` DISABLE KEYS */;
/*!40000 ALTER TABLE `filter_group_languages` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `filter_languages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `filter_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_filter_languages_filters` (`filter_id`) USING BTREE,
  KEY `FK_filter_languages_languages` (`language_id`) USING BTREE,
  CONSTRAINT `FK_filter_languages_filters` FOREIGN KEY (`filter_id`) REFERENCES `filters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_filter_languages_languages` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `filter_languages` DISABLE KEYS */;
/*!40000 ALTER TABLE `filter_languages` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `languages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` (`id`, `name`, `code`, `locale`, `sort_order`, `is_active`) VALUES
	(1, 'Русский', 'ru-RU', 'ru-ru,ru', 1, 1);
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `manufacturers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sort_order` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `manufacturers` DISABLE KEYS */;
/*!40000 ALTER TABLE `manufacturers` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `manufacturers_stores` (
  `manufacturer_id` int NOT NULL,
  `store_id` int NOT NULL,
  PRIMARY KEY (`manufacturer_id`,`store_id`),
  KEY `FK_manufacturers_stores_stores` (`store_id`),
  CONSTRAINT `FK_manufacturers_stores_manufacturers` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_manufacturers_stores_stores` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `manufacturers_stores` DISABLE KEYS */;
/*!40000 ALTER TABLE `manufacturers_stores` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `manufacturer_id` int DEFAULT NULL,
  `product_status_id` int DEFAULT NULL,
  `sku` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `location` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `subtract` int NOT NULL DEFAULT '1',
  `sort_order` int NOT NULL DEFAULT '0',
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sku` (`sku`),
  UNIQUE KEY `location` (`location`),
  KEY `FK_products_manufacturers` (`manufacturer_id`),
  KEY `FK_products_product_statuses` (`product_status_id`),
  CONSTRAINT `FK_products_manufacturers` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_products_product_statuses` FOREIGN KEY (`product_status_id`) REFERENCES `product_statuses` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`id`, `manufacturer_id`, `product_status_id`, `sku`, `location`, `price`, `image`, `quantity`, `subtract`, `sort_order`, `status`, `created_at`, `updated_at`) VALUES
	(1, NULL, 1, 'sku-1', 'lays-papric', 0.0000, 'lays-papric.png', 1, 1, 100, 1, '2022-08-28 13:37:59', '2022-08-28 13:38:00');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `products_categories` (
  `product_id` int NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`product_id`,`category_id`),
  KEY `FK_products_categories_categories` (`category_id`),
  CONSTRAINT `FK_products_categories_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_products_categories_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `products_categories` DISABLE KEYS */;
INSERT INTO `products_categories` (`product_id`, `category_id`) VALUES
	(1, 1),
	(1, 2);
/*!40000 ALTER TABLE `products_categories` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `products_filters` (
  `product_id` int NOT NULL,
  `filter_id` int NOT NULL,
  PRIMARY KEY (`product_id`,`filter_id`),
  KEY `FK_products_filters_filters` (`filter_id`),
  CONSTRAINT `FK_products_filters_filters` FOREIGN KEY (`filter_id`) REFERENCES `filters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_products_filters_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `products_filters` DISABLE KEYS */;
/*!40000 ALTER TABLE `products_filters` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `product_attributes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `attribute_id` int NOT NULL,
  `language_id` int NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_product_attributes_products` (`product_id`),
  KEY `FK_product_attributes_languages` (`language_id`),
  KEY `FK_product_attributes_attributes` (`attribute_id`),
  CONSTRAINT `FK_product_attributes_attributes` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_product_attributes_languages` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_product_attributes_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `product_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_attributes` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `product_comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int DEFAULT NULL,
  `product_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_product_comments_products` (`product_id`),
  KEY `FK_product_comments_customers` (`customer_id`),
  KEY `FK_product_comments_product_comments` (`parent_id`),
  CONSTRAINT `FK_product_comments_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_product_comments_product_comments` FOREIGN KEY (`parent_id`) REFERENCES `product_comments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_product_comments_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `product_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_comments` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `product_comment_likes` (
  `product_comment_id` int NOT NULL,
  `customer_id` int NOT NULL,
  PRIMARY KEY (`product_comment_id`,`customer_id`),
  KEY `FK_product_comment_likes_customers` (`customer_id`),
  CONSTRAINT `FK_product_comment_likes_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_product_comment_likes_product_comments` FOREIGN KEY (`product_comment_id`) REFERENCES `product_comments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `product_comment_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_comment_likes` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `product_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_product_images_products` (`product_id`),
  CONSTRAINT `FK_product_images_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `product_languages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tag` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `meta_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `meta_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `meta_keyword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_product_languages_products` (`product_id`),
  KEY `FK_product_languages_language` (`language_id`),
  CONSTRAINT `FK_product_languages_language` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`),
  CONSTRAINT `FK_product_languages_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `product_languages` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_languages` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `product_related` (
  `product_id` int NOT NULL,
  `related_product_id` int NOT NULL,
  PRIMARY KEY (`product_id`,`related_product_id`),
  KEY `FK_product_related_products_2` (`related_product_id`),
  CONSTRAINT `FK_product_related_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_product_related_products_2` FOREIGN KEY (`related_product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `product_related` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_related` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `product_statuses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sort_order` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `product_statuses` DISABLE KEYS */;
INSERT INTO `product_statuses` (`id`, `sort_order`) VALUES
	(1, 100),
	(2, 200);
/*!40000 ALTER TABLE `product_statuses` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `product_status_languages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_status_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `FK_product_status_languages_product_statuses` (`product_status_id`),
  KEY `FK_product_status_languages_languages` (`language_id`),
  CONSTRAINT `FK_product_status_languages_languages` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_product_status_languages_product_statuses` FOREIGN KEY (`product_status_id`) REFERENCES `product_statuses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `product_status_languages` DISABLE KEYS */;
INSERT INTO `product_status_languages` (`id`, `product_status_id`, `language_id`, `name`, `description`) VALUES
	(1, 1, 1, 'В наличии', NULL),
	(2, 2, 1, 'Отсутствует', NULL);
/*!40000 ALTER TABLE `product_status_languages` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `seo_url` (
  `id` int NOT NULL AUTO_INCREMENT,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `language_id` int NOT NULL,
  `type` enum('category','product','information','manufacturer') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `category_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `information_id` int DEFAULT NULL,
  `manufacturer_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `seo_url` (`path`,`language_id`) USING BTREE,
  KEY `FK_seo_url_languages` (`language_id`),
  KEY `FK_seo_url_categories` (`category_id`),
  KEY `FK_seo_url_products` (`product_id`),
  KEY `FK_seo_url_manufacturers` (`manufacturer_id`),
  CONSTRAINT `FK_seo_url_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_seo_url_languages` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_seo_url_manufacturers` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_seo_url_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `seo_url` DISABLE KEYS */;
INSERT INTO `seo_url` (`id`, `path`, `language_id`, `type`, `category_id`, `product_id`, `information_id`, `manufacturer_id`) VALUES
	(1, 'chips', 1, 'category', 1, NULL, NULL, NULL),
	(2, 'chips/lays', 1, 'category', 2, NULL, NULL, NULL),
	(3, 'chips/lays-s-soliy', 1, 'product', NULL, 1, NULL, NULL),
	(4, 'chips/lays/lays-s-soliy', 1, 'product', NULL, 1, NULL, NULL),
	(5, 'lays-s-soliy', 1, 'product', NULL, 1, NULL, NULL);
/*!40000 ALTER TABLE `seo_url` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `data` json NOT NULL,
  `expire` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `stores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `stores` DISABLE KEYS */;
/*!40000 ALTER TABLE `stores` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `uploads` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` enum('file','customerGroup') COLLATE utf8mb4_general_ci NOT NULL,
  `filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `filename` (`filename`),
  KEY `FK_uploads_uploads` (`parent_id`),
  CONSTRAINT `FK_uploads_uploads` FOREIGN KEY (`parent_id`) REFERENCES `uploads` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `uploads` DISABLE KEYS */;
INSERT INTO `uploads` (`id`, `parent_id`, `name`, `type`, `filename`, `code`, `created_at`, `updated_at`) VALUES
	(1, NULL, '123', 'customerGroup', NULL, NULL, '2022-09-22 16:32:30', '2022-09-22 16:32:30'),
	(2, 1, '123', 'customerGroup', NULL, NULL, '2022-09-22 16:32:30', '2022-09-22 16:32:30');
/*!40000 ALTER TABLE `uploads` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_role_id` int DEFAULT NULL,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(96) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ip` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_fe0bb3f6520ee0469504521e71` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `FK_users_user_roles` (`user_role_id`),
  CONSTRAINT `FK_users_user_roles` FOREIGN KEY (`user_role_id`) REFERENCES `user_roles` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `user_role_id`, `username`, `password_hash`, `first_name`, `last_name`, `email`, `avatar`, `code`, `ip`, `is_active`, `created_at`) VALUES
	(1, 0, 'admin', '$2b$10$3gFwlfXT77oZmPTP7ekNd.nNB9ma8hlN08JKJwjWZ0vhCjr5UvH9q', 'Super', 'Admin', 'admin@admin.ad', NULL, NULL, NULL, 0, '0000-00-00 00:00:00');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `user_logins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `token` varchar(96) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `total` int NOT NULL,
  `ip` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `FK_user_logins_users` (`user_id`),
  CONSTRAINT `FK_user_logins_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `user_logins` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_logins` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `user_roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `permission` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` (`id`, `name`, `permission`) VALUES
	(0, 'Система', NULL);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `user_role_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_role_id` int NOT NULL,
  `permission_id` int NOT NULL,
  `is_read` tinyint NOT NULL DEFAULT '1',
  `is_create` tinyint NOT NULL DEFAULT '1',
  `is_update` tinyint NOT NULL DEFAULT '1',
  `is_delete` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK_user_role_permissions_user_roles` (`user_role_id`),
  KEY `FK_user_role_permissions_permissions` (`permission_id`),
  CONSTRAINT `FK_user_role_permissions_permissions` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_user_role_permissions_user_roles` FOREIGN KEY (`user_role_id`) REFERENCES `user_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `user_role_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_role_permissions` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `user_tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `access_token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `expire` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `session` (`user_agent`,`access_token`) USING BTREE,
  KEY `FK_user_tokens_users` (`user_id`),
  CONSTRAINT `FK_user_tokens_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40000 ALTER TABLE `user_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_tokens` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
