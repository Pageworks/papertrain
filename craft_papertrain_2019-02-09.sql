# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.6.38)
# Database: craft_papertrain
# Generation Time: 2019-02-09 13:14:11 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table pt_assetindexdata
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_assetindexdata`;

CREATE TABLE `pt_assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `pt_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_assets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_assets`;

CREATE TABLE `pt_assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  KEY `pt_assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `pt_assets_volumeId_keptFile_idx` (`volumeId`,`keptFile`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `pt_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `pt_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_assets` WRITE;
/*!40000 ALTER TABLE `pt_assets` DISABLE KEYS */;

INSERT INTO `pt_assets` (`id`, `volumeId`, `folderId`, `filename`, `kind`, `width`, `height`, `size`, `focalPoint`, `deletedWithVolume`, `keptFile`, `dateModified`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(174,1,1,'Checkout.png','image',999,2283,127022,NULL,0,0,'2019-01-30 12:51:36','2019-01-30 12:51:36','2019-01-30 12:51:36','30de667e-c5cf-43ca-888c-d4dabe62877f'),
	(179,1,1,'Checkout.png','image',999,2283,127022,NULL,NULL,NULL,'2019-01-31 21:08:11','2019-01-31 21:08:11','2019-01-31 21:08:11','5bca3645-1906-4ccc-83fd-07d981a00e15'),
	(180,1,1,'Checkout@2x.png','image',1998,4566,351460,NULL,NULL,NULL,'2019-01-31 21:08:17','2019-01-31 21:08:17','2019-01-31 21:08:17','1252034b-022b-443b-8762-cc5c63919e52'),
	(181,1,1,'Shopping.png','image',574,1553,64425,NULL,NULL,NULL,'2019-01-31 21:08:18','2019-01-31 21:08:18','2019-01-31 21:08:18','9c3e394b-04e3-4bee-8fb9-441b33023f37'),
	(182,1,1,'Shopping@2x.png','image',1148,3106,167906,NULL,NULL,NULL,'2019-01-31 21:08:21','2019-01-31 21:08:21','2019-01-31 21:08:21','c93e78dc-f6fa-4f3e-aa65-d08fafb52837');

/*!40000 ALTER TABLE `pt_assets` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_assettransformindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_assettransformindex`;

CREATE TABLE `pt_assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_assettransforms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_assettransforms`;

CREATE TABLE `pt_assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_categories`;

CREATE TABLE `pt_categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `pt_categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `pt_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pt_categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `pt_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_categorygroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_categorygroups`;

CREATE TABLE `pt_categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `pt_categorygroups_dateDeleted_idx` (`dateDeleted`),
  KEY `pt_categorygroups_name_idx` (`name`),
  KEY `pt_categorygroups_handle_idx` (`handle`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `pt_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `pt_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_categorygroups_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_categorygroups_sites`;

CREATE TABLE `pt_categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `pt_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `pt_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_content
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_content`;

CREATE TABLE `pt_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_text1` text,
  `field_text2` text,
  `field_headline1` text,
  `field_headline2` text,
  `field_subheadline1` text,
  `field_subheadline2` text,
  `field_copy1` text,
  `field_copy2` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `pt_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_content` WRITE;
/*!40000 ALTER TABLE `pt_content` DISABLE KEYS */;

INSERT INTO `pt_content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`, `field_text1`, `field_text2`, `field_headline1`, `field_headline2`, `field_subheadline1`, `field_subheadline2`, `field_copy1`, `field_copy2`)
VALUES
	(1,1,1,NULL,'2018-10-17 19:43:46','2018-12-08 13:41:30','4027dc44-49c1-4aaf-b85b-a6bc1a637bac',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(2,174,1,'Checkout','2019-01-30 12:51:34','2019-01-30 12:51:34','703b738f-6d25-4ba1-b695-9734cc849fa4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(3,175,1,'Example Form','2019-01-31 19:31:32','2019-02-05 20:18:11','71e4786c-5030-406d-88e0-b9b031cf9e66',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(4,179,1,'Checkout','2019-01-31 21:08:09','2019-01-31 21:08:09','de772375-3ce2-4bbe-b152-20ecadab5145',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(5,180,1,'Checkout 2x','2019-01-31 21:08:11','2019-01-31 21:08:11','99969059-3f4e-4cb1-adf1-ab66617829cd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(6,181,1,'Shopping','2019-01-31 21:08:18','2019-01-31 21:08:18','2c16f87c-b746-4186-9007-50f83b9efad8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(7,182,1,'Shopping 2x','2019-01-31 21:08:19','2019-01-31 21:08:19','b46604d9-488c-45b7-9f99-dba09c5d3dc9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(8,184,1,'2019-02-04 11:46:29','2019-02-04 16:46:29','2019-02-04 16:46:29','2840faf5-9409-4601-852b-409dc46b5ce7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(9,185,1,'2019-02-04 12:14:21','2019-02-04 17:14:21','2019-02-04 17:14:21','43a9fa27-4506-4793-be8c-896adc0db9c4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(10,186,1,'2019-02-04 13:20:21','2019-02-04 18:20:22','2019-02-04 18:20:22','173d13b8-8089-462f-b60f-0c9a994db1b3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(11,187,1,'2019-02-04 13:32:32','2019-02-04 18:32:32','2019-02-04 18:32:32','2fef836c-528b-4e26-8f31-7fccbc1be62a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(12,188,1,'2019-02-04 13:34:12','2019-02-04 18:34:12','2019-02-04 18:34:12','d9c93310-2af0-486b-9bdf-10acb66c6b36',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(13,189,1,'2019-02-04 14:06:05','2019-02-04 19:06:05','2019-02-04 19:06:05','a7f59a27-28b6-4419-87aa-64f2c7304ee7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(14,190,1,'2019-02-04 14:07:00','2019-02-04 19:07:00','2019-02-04 19:07:00','ae5de932-00f8-43ac-9000-a2ab66b2c860',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(15,191,1,'2019-02-04 14:13:24','2019-02-04 19:13:24','2019-02-04 19:13:24','b3b76c3b-f664-4a7d-b099-39402f1bacbd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(16,192,1,'2019-02-04 14:19:49','2019-02-04 19:19:49','2019-02-04 19:19:49','9fa5dcc7-f89d-4cc8-8596-d3d2c9639c55',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(17,193,1,'2019-02-04 14:21:31','2019-02-04 19:21:32','2019-02-04 19:21:32','45d5e054-a7a6-46b7-8432-57a1a4f88fd5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(18,194,1,'2019-02-04 14:24:49','2019-02-04 19:24:49','2019-02-04 19:24:49','7a568271-c27c-41a9-83e0-016561bb5f9e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(19,195,1,'2019-02-04 15:16:07','2019-02-04 20:16:07','2019-02-04 20:16:07','7aa3aeee-e88a-4101-badb-e7509eb24454',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(20,196,1,'2019-02-04 15:17:14','2019-02-04 20:17:14','2019-02-04 20:17:14','7b5af556-97db-4e68-bf9b-4446e3a0a244',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(21,197,1,'2019-02-04 15:19:33','2019-02-04 20:19:33','2019-02-04 20:19:33','c259d795-91df-432e-8a42-b28ea72e98af',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(22,198,1,'2019-02-04 15:20:22','2019-02-04 20:20:22','2019-02-04 20:20:22','804dcae7-add1-4d7e-a7ed-fe95e2ef320c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(23,199,1,'2019-02-05 12:35:12','2019-02-05 17:35:12','2019-02-05 17:35:12','03c77b42-c237-4584-a304-1c12cfc5fa7d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(24,200,1,'2019-02-05 12:40:20','2019-02-05 17:40:20','2019-02-05 17:40:20','c397659f-522d-4bb6-a4a1-d90f20520623',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(25,201,1,'2019-02-05 12:41:02','2019-02-05 17:41:02','2019-02-05 17:41:02','8900f192-fa59-460f-9ee9-2f145033630d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(26,202,1,'2019-02-05 12:41:31','2019-02-05 17:41:31','2019-02-05 17:41:31','3dcd7bfb-a117-49d1-87e4-e624d7dfeb13',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(27,203,1,'2019-02-05 12:46:05','2019-02-05 17:46:06','2019-02-05 17:46:06','6c30b673-2c72-4082-a485-05ff64c32d8a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(28,204,1,'2019-02-05 12:48:37','2019-02-05 17:48:37','2019-02-05 17:48:37','ff842e74-7f67-48ca-b3b6-0b3577c0a070',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(29,205,1,'2019-02-05 12:51:29','2019-02-05 17:51:29','2019-02-05 17:51:29','db1aab9b-4c10-47e6-a383-bd6547b48743',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(30,206,1,'2019-02-05 13:04:26','2019-02-05 18:04:26','2019-02-05 18:04:26','13af6d03-73ed-4d38-8cd9-0bcd0dbb4cae',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(31,207,1,'2019-02-05 13:11:30','2019-02-05 18:11:30','2019-02-05 18:11:30','e24dbf71-c01b-4625-a52e-802624eee1dd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(32,208,1,'2019-02-05 13:14:05','2019-02-05 18:14:05','2019-02-05 18:14:05','f065c5f5-1915-47e4-9133-7757949ba318',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(33,209,1,'2019-02-05 13:15:41','2019-02-05 18:15:41','2019-02-05 18:15:41','7a3cfbbc-754f-4bab-b640-0a7692c0aab3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(34,210,1,'2019-02-05 13:16:56','2019-02-05 18:16:56','2019-02-05 18:16:56','b86fec2b-508a-4671-941f-c29632266810',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(35,211,1,'2019-02-05 13:18:16','2019-02-05 18:18:16','2019-02-05 18:18:16','f49bf615-ea68-45ca-bad2-c9215edd56dc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(36,212,1,'2019-02-05 13:22:11','2019-02-05 18:22:11','2019-02-05 18:22:11','8fc5830c-602d-42b4-bd3a-a6e3a5e04e5d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(37,213,1,'2019-02-05 13:24:43','2019-02-05 18:24:43','2019-02-05 18:24:43','e6568f61-b6e2-49e6-8fda-a148602fae95',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(38,221,1,'2019-02-05 13:54:05','2019-02-05 18:54:05','2019-02-05 18:54:05','7bce20a5-c172-45a9-bf63-16f1641fb811',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(39,222,1,'2019-02-05 13:57:23','2019-02-05 18:57:23','2019-02-05 18:57:23','73e61ed3-847e-4f48-9a5a-3fc4d65c532b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(40,223,1,'2019-02-05 14:07:18','2019-02-05 19:07:18','2019-02-05 19:07:18','25443ec6-45c2-4306-8d18-3e1dcf765ae3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(41,224,1,'2019-02-05 14:09:16','2019-02-05 19:09:16','2019-02-05 19:09:16','a77c12ec-e06e-4053-bc5c-9865cbc91b02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(42,225,1,'2019-02-05 14:11:02','2019-02-05 19:11:02','2019-02-05 19:11:02','887b018a-35ee-4b92-ad4e-3e57b62e20f1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(43,226,1,'2019-02-05 14:11:16','2019-02-05 19:11:16','2019-02-05 19:11:16','63b8a406-4215-4a35-b949-4be04f9afcfd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(44,227,1,'2019-02-05 14:22:30','2019-02-05 19:22:30','2019-02-05 19:22:30','759d28d3-cbef-400e-8341-c41dacd03a45',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(45,228,1,'2019-02-05 14:24:23','2019-02-05 19:24:23','2019-02-05 19:24:23','c8efc1f8-0276-4d77-a596-8e505cdbae4d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(46,229,1,'2019-02-05 14:25:29','2019-02-05 19:25:29','2019-02-05 19:25:29','37c31052-8531-429b-9366-7ba7f2c44352',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(47,230,1,'2019-02-05 14:36:08','2019-02-05 19:36:08','2019-02-05 19:36:08','498ef5de-344f-4642-83c2-db283ae0de4e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(48,231,1,'2019-02-05 14:40:12','2019-02-05 19:40:12','2019-02-05 19:40:12','e498143c-8a14-4825-ad3b-6ce5aadc6244',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(49,232,1,'2019-02-05 14:43:58','2019-02-05 19:43:59','2019-02-05 19:43:59','e205eefc-c952-4ca4-b028-6c5f17f4abd5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(50,233,1,'2019-02-05 14:49:14','2019-02-05 19:49:14','2019-02-05 19:49:14','7f2d9616-e98d-4a74-9f3b-f06978e677cf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(51,234,1,'2019-02-05 15:12:55','2019-02-05 20:12:55','2019-02-05 20:12:55','d9d7bfc5-e445-4b88-895e-b95deb460fdf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(52,235,1,'2019-02-05 15:18:37','2019-02-05 20:18:37','2019-02-05 20:18:37','2bf96d99-fdc1-43f3-a313-8ebfc33aff24',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(53,236,1,'2019-02-05 15:18:38','2019-02-05 20:18:38','2019-02-05 20:18:38','84f57560-cc4d-4d80-aae2-2d0510249199',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(54,237,1,'2019-02-05 15:19:56','2019-02-05 20:19:56','2019-02-05 20:19:56','e68d9520-294a-48dc-801a-598ded84ec9a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(55,238,1,'2019-02-05 15:42:14','2019-02-05 20:42:14','2019-02-05 20:42:14','5691a757-bbe1-4b2f-b754-93cd0a93476b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(56,239,1,'Test','2019-02-09 13:03:57','2019-02-09 13:08:36','5d8ffc74-fa28-4ed2-b5c6-20299c06ddca',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `pt_content` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_craftidtokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_craftidtokens`;

CREATE TABLE `pt_craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `pt_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_deprecationerrors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_deprecationerrors`;

CREATE TABLE `pt_deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_elementindexsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_elementindexsettings`;

CREATE TABLE `pt_elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_elements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_elements`;

CREATE TABLE `pt_elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `pt_elements_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `pt_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_elements` WRITE;
/*!40000 ALTER TABLE `pt_elements` DISABLE KEYS */;

INSERT INTO `pt_elements` (`id`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,'craft\\elements\\User',1,0,'2018-10-17 19:43:46','2018-12-08 13:41:30',NULL,'f5535ce9-aa32-4c64-8dc5-5d5876014bb3'),
	(169,14,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2018-11-29 18:38:40','2018-11-30 12:48:00',NULL,'6053c3ed-ef28-41b9-978f-c2e546dfb222'),
	(170,14,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2018-11-29 18:38:40','2018-11-30 12:48:00',NULL,'99307da3-0da3-4569-8246-e8b249ad2013'),
	(171,14,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2018-11-29 18:38:40','2018-11-30 12:48:00',NULL,'f5202220-bcde-4ca7-89b4-c9cb29f40811'),
	(172,14,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2018-11-29 18:38:40','2018-11-30 12:48:00',NULL,'adf3a415-f14c-4923-b534-746a23dd7ada'),
	(173,14,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2018-11-29 18:38:40','2018-11-30 12:48:00',NULL,'f53ccea7-3b11-4e1f-a4bf-15e0be9d691b'),
	(174,NULL,'craft\\elements\\Asset',1,0,'2019-01-30 12:51:34','2019-01-30 12:51:34','2019-01-30 12:51:48','271990ef-66b3-4c62-88c0-cb924411a086'),
	(175,2,'craft\\elements\\Entry',1,0,'2019-01-31 19:31:32','2019-02-05 20:18:11','2019-02-05 20:59:01','868add93-0802-452d-8ca0-48c3aebed060'),
	(176,3,'craft\\elements\\MatrixBlock',1,0,'2019-01-31 19:31:32','2019-02-05 20:18:11','2019-02-05 20:59:01','13975770-a9fa-4484-b09c-5089055674ae'),
	(177,7,'craft\\elements\\MatrixBlock',1,0,'2019-01-31 19:31:32','2019-02-05 20:18:11','2019-02-05 20:59:01','da48758f-cc56-4f93-a78a-61a30c358cf3'),
	(178,20,'craft\\elements\\MatrixBlock',1,0,'2019-01-31 19:31:32','2019-02-05 20:18:11','2019-02-05 20:59:01','297636dd-f474-4885-b4c8-7bc650ee69cf'),
	(179,NULL,'craft\\elements\\Asset',1,0,'2019-01-31 21:08:09','2019-01-31 21:08:09',NULL,'bdb5f75a-1790-4a2d-a4ca-021e8d4306e2'),
	(180,NULL,'craft\\elements\\Asset',1,0,'2019-01-31 21:08:11','2019-01-31 21:08:11',NULL,'21f78fe6-b9cb-49bd-bda7-341a21d0da4a'),
	(181,NULL,'craft\\elements\\Asset',1,0,'2019-01-31 21:08:18','2019-01-31 21:08:18',NULL,'875a6ed8-826f-49df-ba72-acae587869a6'),
	(182,NULL,'craft\\elements\\Asset',1,0,'2019-01-31 21:08:19','2019-01-31 21:08:19',NULL,'1f092d25-ae83-404b-8fc3-991ff8b8cd2d'),
	(183,15,'craft\\elements\\MatrixBlock',1,0,'2019-01-31 21:08:35','2019-01-31 21:09:18','2019-01-31 21:17:05','949233c4-a8cf-4545-8188-e595197c92bd'),
	(184,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-04 16:46:29','2019-02-04 16:46:29','2019-02-04 18:20:33','512f6d1e-11b7-4df8-bbbe-60494e5615f5'),
	(185,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-04 17:14:21','2019-02-04 17:14:21','2019-02-04 18:20:33','703c819e-dfb4-4306-bd84-588f575cb911'),
	(186,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-04 18:20:21','2019-02-04 18:20:21','2019-02-04 18:20:33','bfc93f17-7053-4cf8-b8de-21a5be310899'),
	(187,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-04 18:32:32','2019-02-04 18:32:32','2019-02-04 19:06:24','ceb59a55-a7dd-4fba-aadf-35cdd7e1c933'),
	(188,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-04 18:34:12','2019-02-04 18:34:12','2019-02-04 19:06:24','a8fe8611-bd52-4485-a887-c965b47db621'),
	(189,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-04 19:06:05','2019-02-04 19:06:05','2019-02-04 19:06:24','9520a84e-9660-43a7-97f5-91afedc1726d'),
	(190,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-04 19:07:00','2019-02-04 19:07:00','2019-02-04 19:13:37','db1091a7-412f-463a-8117-810605d0a20d'),
	(191,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-04 19:13:24','2019-02-04 19:13:24','2019-02-04 19:13:37','cdc1f32b-4ffe-4bd6-a1df-372d3e7eb58b'),
	(192,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-04 19:19:49','2019-02-04 19:19:49','2019-02-04 20:25:14','21277df9-ee3a-4a4f-9eb2-ce3c8ff7e2f1'),
	(193,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-04 19:21:32','2019-02-04 19:21:32','2019-02-04 20:25:14','6a590d23-b692-427a-8228-2d691a7e5e60'),
	(194,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-04 19:24:49','2019-02-04 19:24:49','2019-02-04 20:25:14','1e87ca02-1206-40f9-8a6c-8e69d1882cf3'),
	(195,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-04 20:16:07','2019-02-04 20:16:07','2019-02-04 20:25:14','d3251dd3-35a0-4fa4-bde4-14071abee4b0'),
	(196,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-04 20:17:14','2019-02-04 20:17:14','2019-02-04 20:25:14','b353a45d-98e8-4cd8-852b-5f16473f2019'),
	(197,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-04 20:19:33','2019-02-04 20:19:33','2019-02-04 20:25:14','3f503301-2983-4e12-82f9-ce585c1d6ee0'),
	(198,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-04 20:20:22','2019-02-04 20:20:22','2019-02-04 20:25:14','22203cf2-a3c6-4dbb-8b9c-602a6cf4ffcf'),
	(199,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 17:35:12','2019-02-05 17:35:12','2019-02-05 17:41:41','d0e7cecc-1dc6-4895-9f14-5912a1d52e9f'),
	(200,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 17:40:20','2019-02-05 17:40:20','2019-02-05 17:41:41','04b88362-3783-4c49-8078-4af863a86f6d'),
	(201,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 17:41:02','2019-02-05 17:41:02','2019-02-05 17:41:41','89cf5463-4a5f-4b10-9f3d-03031ba1e6b5'),
	(202,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 17:41:31','2019-02-05 17:41:31','2019-02-05 17:41:41','5bb6460f-cef1-4377-8612-d35492b3cc76'),
	(203,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 17:46:06','2019-02-05 17:46:06','2019-02-05 17:48:59','65308bef-7698-4340-b8b0-b04c2c7c151c'),
	(204,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 17:48:37','2019-02-05 17:48:37','2019-02-05 17:48:59','ee016452-c7a6-494c-843d-6591ef7795eb'),
	(205,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 17:51:29','2019-02-05 17:51:29','2019-02-05 17:59:30','e9c5aab2-6db7-49ff-bb54-d90f8471830d'),
	(206,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 18:04:26','2019-02-05 18:04:26','2019-02-05 18:18:55','65d7d702-2f97-4c9e-9b21-ec5275b72dbf'),
	(207,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 18:11:30','2019-02-05 18:11:30','2019-02-05 18:18:55','34682c8d-3328-4a5e-a2fb-9fbe30dc1f4f'),
	(208,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 18:14:05','2019-02-05 18:14:05','2019-02-05 18:18:55','006e8ba4-0b2e-4579-a423-f5c322244906'),
	(209,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 18:15:41','2019-02-05 18:15:41','2019-02-05 18:18:55','9903d02d-de6d-4ee0-8a2a-d6a8585d93c1'),
	(210,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 18:16:56','2019-02-05 18:16:56','2019-02-05 18:18:55','3ef46089-0c91-427e-9631-74355cd795ef'),
	(211,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 18:18:16','2019-02-05 18:18:16','2019-02-05 18:18:55','2e871108-1d8b-42f1-9ea6-73f57fb89322'),
	(212,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 18:22:11','2019-02-05 18:22:11','2019-02-05 18:32:26','5da9378a-fa44-4a2d-bc82-0090f43e65a3'),
	(213,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 18:24:43','2019-02-05 18:24:43','2019-02-05 18:32:26','3adefdcf-3ff7-438a-b769-526e8b6d1bd1'),
	(214,6,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 18:33:08','2019-02-05 20:18:11','2019-02-05 20:59:01','ff967f67-8ccc-4b3e-bdd3-9410d775756f'),
	(215,9,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 18:33:08','2019-02-05 20:18:11','2019-02-05 20:59:01','224cb755-01f2-4dad-8b48-d60473d793a7'),
	(216,9,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 18:33:44','2019-02-05 20:18:11','2019-02-05 20:59:01','f581de54-313e-459a-a609-4a9b9fff112d'),
	(217,6,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 18:35:03','2019-02-05 20:18:11','2019-02-05 20:59:01','03823cd1-9322-4bdf-92cb-5b9fc432f2ba'),
	(218,3,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 18:40:25','2019-02-05 18:41:09','2019-02-05 18:41:28','01c31406-9480-4964-9a08-cd8c87215818'),
	(219,7,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 18:40:25','2019-02-05 18:41:09','2019-02-05 18:41:28','ffb99eef-32b0-4f9b-a132-06fe7fbbec9f'),
	(220,6,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 18:40:25','2019-02-05 18:41:09','2019-02-05 18:41:28','2b07be1b-e0de-4552-8d2d-f1b78775125c'),
	(221,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 18:54:05','2019-02-05 18:54:05','2019-02-05 20:58:55','c3c1f394-f5a1-48de-a50d-9a89ab579608'),
	(222,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 18:57:23','2019-02-05 18:57:23','2019-02-05 20:58:55','96b271f1-c2bc-41d7-9fde-66fdee6d956e'),
	(223,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 19:07:18','2019-02-05 19:07:18','2019-02-05 20:58:55','d82d5a61-3865-4ba2-b164-b91a14183da7'),
	(224,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 19:09:16','2019-02-05 19:09:16','2019-02-05 20:58:55','b19940ff-a4b4-4be5-95da-ee783cc7f765'),
	(225,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 19:11:02','2019-02-05 19:11:02','2019-02-05 20:58:55','82498a51-0f8e-44cd-a3c1-f6d85c6f5092'),
	(226,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 19:11:16','2019-02-05 19:11:16','2019-02-05 20:58:55','c1cea853-58ee-406c-a6f3-6b1f8b4d51be'),
	(227,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 19:22:30','2019-02-05 19:22:30','2019-02-05 20:58:55','ee0ad6dd-d40c-476a-a46d-c5c9eadd2514'),
	(228,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 19:24:23','2019-02-05 19:24:23','2019-02-05 20:58:55','5722911c-d0a2-4c65-924e-293e190a494b'),
	(229,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 19:25:29','2019-02-05 19:25:29','2019-02-05 20:58:55','760e4400-d6a4-4541-8bcd-7e9b02551bb8'),
	(230,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 19:36:08','2019-02-05 19:36:08','2019-02-05 20:58:55','c6bdef57-a02c-41a4-9e51-6683926819c1'),
	(231,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 19:40:12','2019-02-05 19:40:12','2019-02-05 20:58:55','e628cc2e-3385-4666-90c5-fbabf5f38351'),
	(232,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 19:43:59','2019-02-05 19:43:59','2019-02-05 20:58:55','b2c94a2f-026c-4312-abfe-154275bfdef3'),
	(233,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 19:49:14','2019-02-05 19:49:14','2019-02-05 20:58:55','09a23060-79be-45d1-b013-6bc713533478'),
	(234,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 20:12:55','2019-02-05 20:12:55','2019-02-05 20:58:55','399efa77-4ab5-4782-89a2-000475776b42'),
	(235,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 20:18:37','2019-02-05 20:18:37','2019-02-05 20:58:55','e69d0af9-bbc8-45c0-ab8f-036335b60267'),
	(236,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 20:18:38','2019-02-05 20:18:38','2019-02-05 20:58:55','d5033599-6e8d-42c2-8ff6-5ed523c2d1eb'),
	(237,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 20:19:56','2019-02-05 20:19:56','2019-02-05 20:58:55','fa584769-4c52-4338-bff7-8cf11d2d1e38'),
	(238,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-02-05 20:42:14','2019-02-05 20:42:14','2019-02-05 20:58:55','2fe325f6-6729-47c7-a127-c239b361fa73'),
	(239,2,'craft\\elements\\Entry',1,0,'2019-02-09 13:03:57','2019-02-09 13:08:36','2019-02-09 13:09:36','17b5de92-bff1-48b1-84e3-3902f9a21b7a'),
	(240,3,'craft\\elements\\MatrixBlock',1,0,'2019-02-09 13:03:57','2019-02-09 13:08:36','2019-02-09 13:09:36','076c11ae-e453-4d50-a87b-efcde2c77ab2'),
	(241,7,'craft\\elements\\MatrixBlock',1,0,'2019-02-09 13:03:57','2019-02-09 13:08:36','2019-02-09 13:09:36','fbedd49c-806a-4250-9b6c-0bf777a42cfa'),
	(242,9,'craft\\elements\\MatrixBlock',1,0,'2019-02-09 13:03:57','2019-02-09 13:08:36','2019-02-09 13:09:36','2e2220b4-94ac-4d93-beaa-4b315ff4d18d');

/*!40000 ALTER TABLE `pt_elements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_elements_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_elements_sites`;

CREATE TABLE `pt_elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `pt_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_elements_sites` WRITE;
/*!40000 ALTER TABLE `pt_elements_sites` DISABLE KEYS */;

INSERT INTO `pt_elements_sites` (`id`, `elementId`, `siteId`, `slug`, `uri`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,NULL,NULL,1,'2018-10-17 19:43:46','2018-12-08 13:41:30','d9de158a-7398-4aae-9bb2-aecd247144ae'),
	(169,169,1,NULL,NULL,1,'2018-11-29 18:38:40','2018-11-30 12:48:00','fcf63708-2fec-49a4-9191-de5e71b7aa10'),
	(170,170,1,NULL,NULL,1,'2018-11-29 18:38:40','2018-11-30 12:48:00','7fe5bb2d-fa5a-44ce-8f7b-5b99604dbe4e'),
	(171,171,1,NULL,NULL,1,'2018-11-29 18:38:40','2018-11-30 12:48:00','48650a37-04ad-4425-b03a-0e7fc7899d41'),
	(172,172,1,NULL,NULL,1,'2018-11-29 18:38:40','2018-11-30 12:48:00','8d4fc304-29ee-4d2f-b100-b102d31e4061'),
	(173,173,1,NULL,NULL,1,'2018-11-29 18:38:40','2018-11-30 12:48:00','e0e781e8-091d-4fc9-b46c-10d62d3907cd'),
	(174,174,1,NULL,NULL,1,'2019-01-30 12:51:34','2019-01-30 12:51:34','c8082f74-6ffc-4b25-8b5e-f4bf10550174'),
	(175,175,1,'example-form','example-form',1,'2019-01-31 19:31:32','2019-02-05 20:18:11','96a6c4cf-37d6-4733-85bf-d9cf99355914'),
	(176,176,1,NULL,NULL,1,'2019-01-31 19:31:32','2019-02-05 20:18:11','8f2ed669-b240-4993-b65e-2e8fa2018873'),
	(177,177,1,NULL,NULL,1,'2019-01-31 19:31:32','2019-02-05 20:18:11','12b8de75-f384-48ff-b73c-ea455922885a'),
	(178,178,1,NULL,NULL,1,'2019-01-31 19:31:32','2019-02-05 20:18:11','386b6f47-abe5-4244-a501-33d4ad3ee415'),
	(179,179,1,NULL,NULL,1,'2019-01-31 21:08:09','2019-01-31 21:08:09','cf87f067-5166-443a-ad41-4700bf6a651e'),
	(180,180,1,NULL,NULL,1,'2019-01-31 21:08:11','2019-01-31 21:08:11','3aa983cd-4e87-4f26-96ff-e02a888d01a4'),
	(181,181,1,NULL,NULL,1,'2019-01-31 21:08:18','2019-01-31 21:08:18','952aefae-48d3-4912-a281-927a958422dc'),
	(182,182,1,NULL,NULL,1,'2019-01-31 21:08:19','2019-01-31 21:08:19','fb3a8ef9-a94a-4aed-9995-d612a63ff380'),
	(183,183,1,NULL,NULL,1,'2019-01-31 21:08:35','2019-01-31 21:09:18','0d730ad7-053d-4503-8d9a-3db72efb7b03'),
	(184,184,1,NULL,NULL,1,'2019-02-04 16:46:29','2019-02-04 16:46:29','09fa6812-099f-48a0-b9f5-54256d6a75cb'),
	(185,185,1,NULL,NULL,1,'2019-02-04 17:14:21','2019-02-04 17:14:21','44bb417c-228b-42e1-a01c-dfd6f0f60479'),
	(186,186,1,NULL,NULL,1,'2019-02-04 18:20:22','2019-02-04 18:20:22','e2dea861-b831-4d84-ae10-df47270b682a'),
	(187,187,1,NULL,NULL,1,'2019-02-04 18:32:32','2019-02-04 18:32:32','ac2c7c6c-de21-433e-9bba-f4a5143b4f12'),
	(188,188,1,NULL,NULL,1,'2019-02-04 18:34:12','2019-02-04 18:34:12','cd2a01be-12dc-4226-877b-6611eb227e55'),
	(189,189,1,NULL,NULL,1,'2019-02-04 19:06:05','2019-02-04 19:06:05','278fd74d-8129-4891-bf63-3f0e93c223eb'),
	(190,190,1,NULL,NULL,1,'2019-02-04 19:07:00','2019-02-04 19:07:00','7aa96d55-13c3-44ac-a427-986548033449'),
	(191,191,1,NULL,NULL,1,'2019-02-04 19:13:24','2019-02-04 19:13:24','0bb55fdb-56d6-4baa-935d-af3c2894e84a'),
	(192,192,1,NULL,NULL,1,'2019-02-04 19:19:49','2019-02-04 19:19:49','cdbf8530-2c1f-4920-aa83-5bdf47977705'),
	(193,193,1,NULL,NULL,1,'2019-02-04 19:21:32','2019-02-04 19:21:32','7324ad7b-d716-4134-98ad-12b87992bac1'),
	(194,194,1,NULL,NULL,1,'2019-02-04 19:24:49','2019-02-04 19:24:49','13d6de63-8a42-4a3a-b68d-f8e534e99f33'),
	(195,195,1,NULL,NULL,1,'2019-02-04 20:16:07','2019-02-04 20:16:07','1de32f0a-7314-4ee3-83b1-15257dbd960c'),
	(196,196,1,NULL,NULL,1,'2019-02-04 20:17:14','2019-02-04 20:17:14','09c7184c-41c7-49f7-a27b-45b176bb7a4d'),
	(197,197,1,NULL,NULL,1,'2019-02-04 20:19:33','2019-02-04 20:19:33','96008a5d-09dd-4124-a429-0e7b0ec7b17a'),
	(198,198,1,NULL,NULL,1,'2019-02-04 20:20:22','2019-02-04 20:20:22','825fe437-9810-4a90-bb85-c369cce22e06'),
	(199,199,1,NULL,NULL,1,'2019-02-05 17:35:12','2019-02-05 17:35:12','06d2b3ae-719e-4654-9e17-e591acb94a31'),
	(200,200,1,NULL,NULL,1,'2019-02-05 17:40:20','2019-02-05 17:40:20','20725eed-d6a5-401a-8010-7bc8e4435e94'),
	(201,201,1,NULL,NULL,1,'2019-02-05 17:41:02','2019-02-05 17:41:02','4edf2f14-0c7b-4c4e-96af-590deac146cb'),
	(202,202,1,NULL,NULL,1,'2019-02-05 17:41:31','2019-02-05 17:41:31','8e51d1d3-b348-4f75-920d-866e60e94904'),
	(203,203,1,NULL,NULL,1,'2019-02-05 17:46:06','2019-02-05 17:46:06','0895aead-a3f4-4fb1-ad9f-c7c341984b3d'),
	(204,204,1,NULL,NULL,1,'2019-02-05 17:48:37','2019-02-05 17:48:37','03469f76-263e-43ad-847b-8cb5794ce5f6'),
	(205,205,1,NULL,NULL,1,'2019-02-05 17:51:29','2019-02-05 17:51:29','358b8346-d7f4-4faa-8613-c866d8271e61'),
	(206,206,1,NULL,NULL,1,'2019-02-05 18:04:26','2019-02-05 18:04:26','21d8f152-6cee-426c-9905-22e49e92eb55'),
	(207,207,1,NULL,NULL,1,'2019-02-05 18:11:30','2019-02-05 18:11:30','acc6eec0-a125-46cc-811e-dae7ff4bd5ef'),
	(208,208,1,NULL,NULL,1,'2019-02-05 18:14:05','2019-02-05 18:14:05','880c8973-b4b3-441c-8e3d-5a99248f9176'),
	(209,209,1,NULL,NULL,1,'2019-02-05 18:15:41','2019-02-05 18:15:41','aa18b1de-04f1-4559-972e-655d361de643'),
	(210,210,1,NULL,NULL,1,'2019-02-05 18:16:56','2019-02-05 18:16:56','10c566b0-1a18-49d3-810b-2ea1e9206ba8'),
	(211,211,1,NULL,NULL,1,'2019-02-05 18:18:16','2019-02-05 18:18:16','d03829fa-7466-45cd-9653-a1d3ae4fdd2b'),
	(212,212,1,NULL,NULL,1,'2019-02-05 18:22:11','2019-02-05 18:22:11','cebb5286-d5c5-414c-ac98-0c42ae806b86'),
	(213,213,1,NULL,NULL,1,'2019-02-05 18:24:43','2019-02-05 18:24:43','265be8c0-57c0-4fd4-9ca5-d0e216181481'),
	(214,214,1,NULL,NULL,1,'2019-02-05 18:33:08','2019-02-05 20:18:11','54cbb4ad-8d37-4ef8-a34f-d7d898c82d50'),
	(215,215,1,NULL,NULL,1,'2019-02-05 18:33:08','2019-02-05 20:18:11','952ccd1d-ffd3-4712-8188-87be145d885e'),
	(216,216,1,NULL,NULL,1,'2019-02-05 18:33:44','2019-02-05 20:18:11','d7472fd6-3546-4e0c-95b1-c400e812147c'),
	(217,217,1,NULL,NULL,1,'2019-02-05 18:35:03','2019-02-05 20:18:11','0765e7cb-219a-4f13-8cf1-ba465117c70b'),
	(218,218,1,NULL,NULL,1,'2019-02-05 18:40:25','2019-02-05 18:41:09','ae8906df-3005-4f31-a157-cfae7552b4a3'),
	(219,219,1,NULL,NULL,1,'2019-02-05 18:40:25','2019-02-05 18:41:09','f9a95705-d23e-4084-86dd-86e81b0feb4a'),
	(220,220,1,NULL,NULL,1,'2019-02-05 18:40:25','2019-02-05 18:41:09','152b3719-4f32-42ae-92bf-de1c3313fd2f'),
	(221,221,1,NULL,NULL,1,'2019-02-05 18:54:05','2019-02-05 18:54:05','f98dea57-75ea-4211-8d25-e5bc5661ccbd'),
	(222,222,1,NULL,NULL,1,'2019-02-05 18:57:23','2019-02-05 18:57:23','045daf26-2fcc-421b-b115-3815c444214d'),
	(223,223,1,NULL,NULL,1,'2019-02-05 19:07:18','2019-02-05 19:07:18','a83e2b87-cc35-4d64-8670-ab4bc76dd458'),
	(224,224,1,NULL,NULL,1,'2019-02-05 19:09:16','2019-02-05 19:09:16','0349dd06-b027-442d-98ab-86d5f62a62c1'),
	(225,225,1,NULL,NULL,1,'2019-02-05 19:11:02','2019-02-05 19:11:02','d6a12459-6c32-4f88-b2d9-3c2c43d3de73'),
	(226,226,1,NULL,NULL,1,'2019-02-05 19:11:16','2019-02-05 19:11:16','86ec44c9-fc4d-4818-a253-2fd5e88cd38a'),
	(227,227,1,NULL,NULL,1,'2019-02-05 19:22:30','2019-02-05 19:22:30','9e820ceb-1afd-4cf9-ab07-8d02f3139316'),
	(228,228,1,NULL,NULL,1,'2019-02-05 19:24:23','2019-02-05 19:24:23','de971672-93b3-48d7-b38a-86f5c923880f'),
	(229,229,1,NULL,NULL,1,'2019-02-05 19:25:29','2019-02-05 19:25:29','901705d1-0c24-477f-a9f4-c2f495b60b49'),
	(230,230,1,NULL,NULL,1,'2019-02-05 19:36:08','2019-02-05 19:36:08','3f34db00-8e00-4dea-bd97-860cfa0733b9'),
	(231,231,1,NULL,NULL,1,'2019-02-05 19:40:12','2019-02-05 19:40:12','fe18bb8e-7e7c-404b-98c4-334e328638a8'),
	(232,232,1,NULL,NULL,1,'2019-02-05 19:43:59','2019-02-05 19:43:59','9bfad6ed-d45b-41ae-bfed-c53efb5a3413'),
	(233,233,1,NULL,NULL,1,'2019-02-05 19:49:14','2019-02-05 19:49:14','33214dff-e655-436e-9385-12be75f1f1ce'),
	(234,234,1,NULL,NULL,1,'2019-02-05 20:12:55','2019-02-05 20:12:55','aceab83f-04f2-4b42-883e-56cea997d82f'),
	(235,235,1,NULL,NULL,1,'2019-02-05 20:18:37','2019-02-05 20:18:37','093b385e-7147-40e4-acdb-a20f1bf840e1'),
	(236,236,1,NULL,NULL,1,'2019-02-05 20:18:38','2019-02-05 20:18:38','4e3b801e-1b72-4af6-b5e2-37f8cb127360'),
	(237,237,1,NULL,NULL,1,'2019-02-05 20:19:56','2019-02-05 20:19:56','e27706e6-d633-4384-a3b5-1d404112714a'),
	(238,238,1,NULL,NULL,1,'2019-02-05 20:42:14','2019-02-05 20:42:14','51430ba9-2c24-44e8-9839-d695171498d5'),
	(239,239,1,'test','test',1,'2019-02-09 13:03:57','2019-02-09 13:08:36','1d2e82d1-ecec-4d85-adb6-727ee3d8bfe4'),
	(240,240,1,NULL,NULL,1,'2019-02-09 13:03:57','2019-02-09 13:08:36','fe329133-5183-4067-97c6-9bad44b3d120'),
	(241,241,1,NULL,NULL,1,'2019-02-09 13:03:57','2019-02-09 13:08:36','56e6d595-27a5-43df-b41a-2544251861c6'),
	(242,242,1,NULL,NULL,1,'2019-02-09 13:03:57','2019-02-09 13:08:36','d7b60462-8f61-4eff-9342-f6a52f8359e1');

/*!40000 ALTER TABLE `pt_elements_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_entries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_entries`;

CREATE TABLE `pt_entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `pt_entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `pt_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `pt_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `pt_entrytypes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pt_entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `pt_entries` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_entries` WRITE;
/*!40000 ALTER TABLE `pt_entries` DISABLE KEYS */;

INSERT INTO `pt_entries` (`id`, `sectionId`, `parentId`, `typeId`, `authorId`, `postDate`, `expiryDate`, `deletedWithEntryType`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(175,2,NULL,2,1,'2019-01-31 19:31:00',NULL,0,'2019-01-31 19:31:32','2019-02-05 20:18:11','3679aa20-38cc-4fa0-b8d1-0ed2080abb0a'),
	(239,2,NULL,2,1,'2019-02-09 13:03:00',NULL,0,'2019-02-09 13:03:57','2019-02-09 13:08:36','3c506445-1d40-4a5d-b3fe-7cf65179002c');

/*!40000 ALTER TABLE `pt_entries` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_entrydrafts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_entrydrafts`;

CREATE TABLE `pt_entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrydrafts_sectionId_idx` (`sectionId`),
  KEY `entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entrydrafts_siteId_idx` (`siteId`),
  KEY `entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `pt_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `pt_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `pt_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `pt_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_entrytypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_entrytypes`;

CREATE TABLE `pt_entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `pt_entrytypes_dateDeleted_idx` (`dateDeleted`),
  KEY `pt_entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `pt_entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `pt_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `pt_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_entrytypes` WRITE;
/*!40000 ALTER TABLE `pt_entrytypes` DISABLE KEYS */;

INSERT INTO `pt_entrytypes` (`id`, `sectionId`, `fieldLayoutId`, `name`, `handle`, `hasTitleField`, `titleLabel`, `titleFormat`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(2,2,2,'Standard Pages','standardPages',1,'Title',NULL,1,'2018-11-06 19:23:08','2018-11-06 19:48:17',NULL,'314ff677-634c-4a48-8499-6c2817266962');

/*!40000 ALTER TABLE `pt_entrytypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_entryversions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_entryversions`;

CREATE TABLE `pt_entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entryversions_sectionId_idx` (`sectionId`),
  KEY `entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entryversions_siteId_idx` (`siteId`),
  KEY `entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `pt_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `pt_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `pt_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `pt_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_entryversions` WRITE;
/*!40000 ALTER TABLE `pt_entryversions` DISABLE KEYS */;

INSERT INTO `pt_entryversions` (`id`, `entryId`, `sectionId`, `creatorId`, `siteId`, `num`, `notes`, `data`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,175,2,1,1,1,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":true,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":true,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\"}}}}}','2019-01-31 19:31:32','2019-01-31 19:31:32','58df0834-6061-45c9-ac14-0381f401d7c4'),
	(2,175,2,1,1,2,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\"}}}}}','2019-01-31 19:35:38','2019-01-31 19:35:38','48313d68-73c4-4a13-bc26-82ff344ffbf0'),
	(3,175,2,1,1,3,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\"}},\"183\":{\"type\":\"gallery\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"slides\":[\"182\",\"181\",\"180\",\"179\"],\"paddingSize\":\"-none\",\"padding\":\"u-padding\",\"slideTransition\":\"-1\",\"style\":\"slide\",\"aspectRatio\":\"u-ratio-1/1\"}}}}}','2019-01-31 21:08:35','2019-01-31 21:08:35','f9e615f5-3e62-4864-bff0-0b607c5d50fd'),
	(4,175,2,1,1,4,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\"}},\"183\":{\"type\":\"gallery\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"slides\":[\"182\",\"181\",\"180\",\"179\"],\"paddingSize\":\"-none\",\"padding\":\"u-padding\",\"slideTransition\":\"-1\",\"style\":\"parallax\",\"aspectRatio\":\"u-ratio-1/1\"}}}}}','2019-01-31 21:09:18','2019-01-31 21:09:18','492ff2d7-3c34-4334-acb6-f8f9f9b71fbc'),
	(5,175,2,1,1,5,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\"}}}}}','2019-01-31 21:17:05','2019-01-31 21:17:05','abe4a21b-ddab-4bc4-9721-6667e96ee7dd'),
	(6,175,2,1,1,6,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-underline\"}}}}}','2019-02-01 15:49:14','2019-02-01 15:49:14','ff096214-95a3-4b90-a0a3-81a7af6b7f4d'),
	(7,175,2,1,1,7,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-solid\"}}}}}','2019-02-01 21:05:38','2019-02-01 21:05:38','3df3a22e-5b7d-4eb2-89a0-eb04b69c7599'),
	(8,175,2,1,1,8,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\"}}}}}','2019-02-01 21:05:46','2019-02-01 21:05:46','1f78fa74-1fc4-432b-a456-c1ca94be1247'),
	(9,175,2,1,1,9,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-secondary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\"}}}}}','2019-02-05 16:47:02','2019-02-05 16:47:02','7ecf31d1-9102-4752-adc8-4f8158d5c400'),
	(10,175,2,1,1,10,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-dark-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\"}}}}}','2019-02-05 16:47:08','2019-02-05 16:47:08','dfccb20a-3d1a-47fe-89d4-562cfa2f25a5'),
	(11,175,2,1,1,11,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-brand-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\"}}}}}','2019-02-05 16:47:15','2019-02-05 16:47:15','c33bc426-d885-4e45-876f-65d1b61ce30f'),
	(12,175,2,1,1,12,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\"}}}}}','2019-02-05 16:47:22','2019-02-05 16:47:22','738faf42-1446-4832-9a7c-09069457552b'),
	(13,175,2,1,1,13,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-solid\"}}}}}','2019-02-05 18:03:34','2019-02-05 18:03:34','89a05c77-c730-4b87-8e17-54a579729c98'),
	(14,175,2,1,1,14,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-underline\"}}}}}','2019-02-05 18:03:44','2019-02-05 18:03:44','e9cb1e35-3146-47ec-8e0b-2b7174d8fb2a'),
	(15,175,2,1,1,15,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-solid\"}}}}}','2019-02-05 18:05:02','2019-02-05 18:05:02','2a931846-5c38-4771-a3ef-ef9be4eb4274'),
	(16,175,2,1,1,16,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\"}}}}}','2019-02-05 18:05:08','2019-02-05 18:05:08','8da66d8d-61a2-4e44-b773-747b57f2e35c'),
	(17,175,2,1,1,17,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"214\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Form\",\"fontSize\":\"o-h2\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"215\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\"}}}}}','2019-02-05 18:33:08','2019-02-05 18:33:08','d5c708db-937c-494b-af89-30007f44552e'),
	(18,175,2,1,1,18,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"214\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Form\",\"fontSize\":\"o-h2\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"215\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":null,\"padding\":\"u-padding-bottom\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\"}}}}}','2019-02-05 18:33:19','2019-02-05 18:33:19','e193fb28-39d1-4c97-9838-df4419dd6c2b'),
	(19,175,2,1,1,19,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"214\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Form\",\"fontSize\":\"o-h2\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"215\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":null,\"padding\":\"u-padding-bottom\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\"}},\"216\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Et ultrices neque ornare aenean euismod. Interdum velit laoreet id donec. Velit euismod in pellentesque massa placerat duis ultricies lacus sed. Dapibus ultrices in iaculis nunc sed. A arcu cursus vitae congue mauris. At erat pellentesque adipiscing commodo elit at imperdiet dui. Malesuada fames ac turpis egestas maecenas pharetra convallis posuere. Consequat interdum varius sit amet mattis vulputate. Faucibus pulvinar elementum integer enim neque volutpat. Vitae aliquet nec ullamcorper sit. Pretium viverra suspendisse potenti nullam ac tortor. Sit amet luctus venenatis lectus magna fringilla urna porttitor. Est pellentesque elit ullamcorper dignissim cras tincidunt. Aliquam nulla facilisi cras fermentum odio eu feugiat pretium.</p>\\n<p>Orci a scelerisque purus semper eget duis at tellus at. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Elit sed vulputate mi sit amet mauris commodo quis. Tortor aliquam nulla facilisi cras fermentum odio eu. Vitae semper quis lectus nulla at volutpat. Posuere morbi leo urna molestie at elementum eu. Magna eget est lorem ipsum dolor sit amet consectetur adipiscing. Tincidunt dui ut ornare lectus. Risus nullam eget felis eget nunc. Congue nisi vitae suscipit tellus. Metus aliquam eleifend mi in nulla posuere sollicitudin. Amet volutpat consequat mauris nunc congue nisi vitae. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa. Donec enim diam vulputate ut.</p>\\n<p>Amet nisl purus in mollis nunc sed. Egestas purus viverra accumsan in. Venenatis tellus in metus vulputate eu. Id cursus metus aliquam eleifend mi in nulla. Pretium nibh ipsum consequat nisl vel pretium lectus. Pharetra sit amet aliquam id diam maecenas. Montes nascetur ridiculus mus mauris vitae ultricies leo integer. A diam maecenas sed enim ut sem viverra aliquet eget. Vestibulum morbi blandit cursus risus at ultrices. Ut venenatis tellus in metus vulputate eu scelerisque. Amet mauris commodo quis imperdiet massa tincidunt. Diam maecenas sed enim ut sem viverra aliquet eget.</p>\\n<p>Vel pharetra vel turpis nunc eget lorem dolor. Lacus suspendisse faucibus interdum posuere lorem. Aenean euismod elementum nisi quis eleifend. Nisi porta lorem mollis aliquam ut porttitor leo a. Lorem donec massa sapien faucibus et. Aliquam sem et tortor consequat id porta nibh venenatis cras. Commodo nulla facilisi nullam vehicula. Viverra nam libero justo laoreet sit amet cursus sit amet. Mauris nunc congue nisi vitae suscipit tellus mauris a diam. Vel orci porta non pulvinar neque laoreet suspendisse. Nulla pellentesque dignissim enim sit. Sed tempus urna et pharetra pharetra massa massa ultricies mi. Vitae justo eget magna fermentum iaculis eu non diam. Tempor orci dapibus ultrices in iaculis. Pretium fusce id velit ut tortor pretium. Senectus et netus et malesuada fames ac turpis egestas maecenas.</p>\\n<p>Massa massa ultricies mi quis. Habitasse platea dictumst quisque sagittis purus. Nullam non nisi est sit amet facilisis magna etiam tempor. Egestas dui id ornare arcu odio ut sem. Scelerisque eu ultrices vitae auctor. Quis ipsum suspendisse ultrices gravida dictum fusce ut. Imperdiet nulla malesuada pellentesque elit eget gravida. Pharetra diam sit amet nisl. Laoreet suspendisse interdum consectetur libero id faucibus nisl tincidunt eget. Sodales ut eu sem integer vitae. Felis donec et odio pellentesque diam volutpat commodo. In eu mi bibendum neque egestas congue quisque egestas diam. Massa massa ultricies mi quis hendrerit. Tristique magna sit amet purus gravida quis blandit turpis.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}}}}}','2019-02-05 18:33:44','2019-02-05 18:33:44','f09f50a7-863f-4b54-9368-0bee3a3a6d4c'),
	(20,175,2,1,1,20,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"214\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Form\",\"fontSize\":\"o-h2\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"215\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":null,\"padding\":\"u-padding-bottom\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\"}},\"217\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"All About Lorem\",\"fontSize\":\"o-h5\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"216\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Et ultrices neque ornare aenean euismod. Interdum velit laoreet id donec. Velit euismod in pellentesque massa placerat duis ultricies lacus sed. Dapibus ultrices in iaculis nunc sed. A arcu cursus vitae congue mauris. At erat pellentesque adipiscing commodo elit at imperdiet dui. Malesuada fames ac turpis egestas maecenas pharetra convallis posuere. Consequat interdum varius sit amet mattis vulputate. Faucibus pulvinar elementum integer enim neque volutpat. Vitae aliquet nec ullamcorper sit. Pretium viverra suspendisse potenti nullam ac tortor. Sit amet luctus venenatis lectus magna fringilla urna porttitor. Est pellentesque elit ullamcorper dignissim cras tincidunt. Aliquam nulla facilisi cras fermentum odio eu feugiat pretium.</p>\\n<p>Orci a scelerisque purus semper eget duis at tellus at. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Elit sed vulputate mi sit amet mauris commodo quis. Tortor aliquam nulla facilisi cras fermentum odio eu. Vitae semper quis lectus nulla at volutpat. Posuere morbi leo urna molestie at elementum eu. Magna eget est lorem ipsum dolor sit amet consectetur adipiscing. Tincidunt dui ut ornare lectus. Risus nullam eget felis eget nunc. Congue nisi vitae suscipit tellus. Metus aliquam eleifend mi in nulla posuere sollicitudin. Amet volutpat consequat mauris nunc congue nisi vitae. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa. Donec enim diam vulputate ut.</p>\\n<p>Amet nisl purus in mollis nunc sed. Egestas purus viverra accumsan in. Venenatis tellus in metus vulputate eu. Id cursus metus aliquam eleifend mi in nulla. Pretium nibh ipsum consequat nisl vel pretium lectus. Pharetra sit amet aliquam id diam maecenas. Montes nascetur ridiculus mus mauris vitae ultricies leo integer. A diam maecenas sed enim ut sem viverra aliquet eget. Vestibulum morbi blandit cursus risus at ultrices. Ut venenatis tellus in metus vulputate eu scelerisque. Amet mauris commodo quis imperdiet massa tincidunt. Diam maecenas sed enim ut sem viverra aliquet eget.</p>\\n<p>Vel pharetra vel turpis nunc eget lorem dolor. Lacus suspendisse faucibus interdum posuere lorem. Aenean euismod elementum nisi quis eleifend. Nisi porta lorem mollis aliquam ut porttitor leo a. Lorem donec massa sapien faucibus et. Aliquam sem et tortor consequat id porta nibh venenatis cras. Commodo nulla facilisi nullam vehicula. Viverra nam libero justo laoreet sit amet cursus sit amet. Mauris nunc congue nisi vitae suscipit tellus mauris a diam. Vel orci porta non pulvinar neque laoreet suspendisse. Nulla pellentesque dignissim enim sit. Sed tempus urna et pharetra pharetra massa massa ultricies mi. Vitae justo eget magna fermentum iaculis eu non diam. Tempor orci dapibus ultrices in iaculis. Pretium fusce id velit ut tortor pretium. Senectus et netus et malesuada fames ac turpis egestas maecenas.</p>\\n<p>Massa massa ultricies mi quis. Habitasse platea dictumst quisque sagittis purus. Nullam non nisi est sit amet facilisis magna etiam tempor. Egestas dui id ornare arcu odio ut sem. Scelerisque eu ultrices vitae auctor. Quis ipsum suspendisse ultrices gravida dictum fusce ut. Imperdiet nulla malesuada pellentesque elit eget gravida. Pharetra diam sit amet nisl. Laoreet suspendisse interdum consectetur libero id faucibus nisl tincidunt eget. Sodales ut eu sem integer vitae. Felis donec et odio pellentesque diam volutpat commodo. In eu mi bibendum neque egestas congue quisque egestas diam. Massa massa ultricies mi quis hendrerit. Tristique magna sit amet purus gravida quis blandit turpis.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}}}}}','2019-02-05 18:35:03','2019-02-05 18:35:03','794421e0-8b92-4843-bcfc-f5f21cbe0b59'),
	(21,175,2,1,1,21,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"214\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Form\",\"fontSize\":\"o-h2\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"215\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":null,\"padding\":\"u-padding-bottom\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\",\"paddingSize\":null,\"padding\":\"u-padding-bottom\"}},\"217\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"All About Lorem\",\"fontSize\":\"o-h5\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"216\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Et ultrices neque ornare aenean euismod. Interdum velit laoreet id donec. Velit euismod in pellentesque massa placerat duis ultricies lacus sed. Dapibus ultrices in iaculis nunc sed. A arcu cursus vitae congue mauris. At erat pellentesque adipiscing commodo elit at imperdiet dui. Malesuada fames ac turpis egestas maecenas pharetra convallis posuere. Consequat interdum varius sit amet mattis vulputate. Faucibus pulvinar elementum integer enim neque volutpat. Vitae aliquet nec ullamcorper sit. Pretium viverra suspendisse potenti nullam ac tortor. Sit amet luctus venenatis lectus magna fringilla urna porttitor. Est pellentesque elit ullamcorper dignissim cras tincidunt. Aliquam nulla facilisi cras fermentum odio eu feugiat pretium.</p>\\n<p>Orci a scelerisque purus semper eget duis at tellus at. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Elit sed vulputate mi sit amet mauris commodo quis. Tortor aliquam nulla facilisi cras fermentum odio eu. Vitae semper quis lectus nulla at volutpat. Posuere morbi leo urna molestie at elementum eu. Magna eget est lorem ipsum dolor sit amet consectetur adipiscing. Tincidunt dui ut ornare lectus. Risus nullam eget felis eget nunc. Congue nisi vitae suscipit tellus. Metus aliquam eleifend mi in nulla posuere sollicitudin. Amet volutpat consequat mauris nunc congue nisi vitae. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa. Donec enim diam vulputate ut.</p>\\n<p>Amet nisl purus in mollis nunc sed. Egestas purus viverra accumsan in. Venenatis tellus in metus vulputate eu. Id cursus metus aliquam eleifend mi in nulla. Pretium nibh ipsum consequat nisl vel pretium lectus. Pharetra sit amet aliquam id diam maecenas. Montes nascetur ridiculus mus mauris vitae ultricies leo integer. A diam maecenas sed enim ut sem viverra aliquet eget. Vestibulum morbi blandit cursus risus at ultrices. Ut venenatis tellus in metus vulputate eu scelerisque. Amet mauris commodo quis imperdiet massa tincidunt. Diam maecenas sed enim ut sem viverra aliquet eget.</p>\\n<p>Vel pharetra vel turpis nunc eget lorem dolor. Lacus suspendisse faucibus interdum posuere lorem. Aenean euismod elementum nisi quis eleifend. Nisi porta lorem mollis aliquam ut porttitor leo a. Lorem donec massa sapien faucibus et. Aliquam sem et tortor consequat id porta nibh venenatis cras. Commodo nulla facilisi nullam vehicula. Viverra nam libero justo laoreet sit amet cursus sit amet. Mauris nunc congue nisi vitae suscipit tellus mauris a diam. Vel orci porta non pulvinar neque laoreet suspendisse. Nulla pellentesque dignissim enim sit. Sed tempus urna et pharetra pharetra massa massa ultricies mi. Vitae justo eget magna fermentum iaculis eu non diam. Tempor orci dapibus ultrices in iaculis. Pretium fusce id velit ut tortor pretium. Senectus et netus et malesuada fames ac turpis egestas maecenas.</p>\\n<p>Massa massa ultricies mi quis. Habitasse platea dictumst quisque sagittis purus. Nullam non nisi est sit amet facilisis magna etiam tempor. Egestas dui id ornare arcu odio ut sem. Scelerisque eu ultrices vitae auctor. Quis ipsum suspendisse ultrices gravida dictum fusce ut. Imperdiet nulla malesuada pellentesque elit eget gravida. Pharetra diam sit amet nisl. Laoreet suspendisse interdum consectetur libero id faucibus nisl tincidunt eget. Sodales ut eu sem integer vitae. Felis donec et odio pellentesque diam volutpat commodo. In eu mi bibendum neque egestas congue quisque egestas diam. Massa massa ultricies mi quis hendrerit. Tristique magna sit amet purus gravida quis blandit turpis.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}}}}}','2019-02-05 18:38:59','2019-02-05 18:38:59','9e7f661d-f4a8-43b0-a5cb-d2fd80f3fe12'),
	(22,175,2,1,1,22,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"214\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Form\",\"fontSize\":\"o-h2\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"215\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-bottom\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\",\"paddingSize\":\"-x2\",\"padding\":\"u-padding-vertical\"}},\"217\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"All About Lorem\",\"fontSize\":\"o-h5\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"216\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Et ultrices neque ornare aenean euismod. Interdum velit laoreet id donec. Velit euismod in pellentesque massa placerat duis ultricies lacus sed. Dapibus ultrices in iaculis nunc sed. A arcu cursus vitae congue mauris. At erat pellentesque adipiscing commodo elit at imperdiet dui. Malesuada fames ac turpis egestas maecenas pharetra convallis posuere. Consequat interdum varius sit amet mattis vulputate. Faucibus pulvinar elementum integer enim neque volutpat. Vitae aliquet nec ullamcorper sit. Pretium viverra suspendisse potenti nullam ac tortor. Sit amet luctus venenatis lectus magna fringilla urna porttitor. Est pellentesque elit ullamcorper dignissim cras tincidunt. Aliquam nulla facilisi cras fermentum odio eu feugiat pretium.</p>\\n<p>Orci a scelerisque purus semper eget duis at tellus at. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Elit sed vulputate mi sit amet mauris commodo quis. Tortor aliquam nulla facilisi cras fermentum odio eu. Vitae semper quis lectus nulla at volutpat. Posuere morbi leo urna molestie at elementum eu. Magna eget est lorem ipsum dolor sit amet consectetur adipiscing. Tincidunt dui ut ornare lectus. Risus nullam eget felis eget nunc. Congue nisi vitae suscipit tellus. Metus aliquam eleifend mi in nulla posuere sollicitudin. Amet volutpat consequat mauris nunc congue nisi vitae. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa. Donec enim diam vulputate ut.</p>\\n<p>Amet nisl purus in mollis nunc sed. Egestas purus viverra accumsan in. Venenatis tellus in metus vulputate eu. Id cursus metus aliquam eleifend mi in nulla. Pretium nibh ipsum consequat nisl vel pretium lectus. Pharetra sit amet aliquam id diam maecenas. Montes nascetur ridiculus mus mauris vitae ultricies leo integer. A diam maecenas sed enim ut sem viverra aliquet eget. Vestibulum morbi blandit cursus risus at ultrices. Ut venenatis tellus in metus vulputate eu scelerisque. Amet mauris commodo quis imperdiet massa tincidunt. Diam maecenas sed enim ut sem viverra aliquet eget.</p>\\n<p>Vel pharetra vel turpis nunc eget lorem dolor. Lacus suspendisse faucibus interdum posuere lorem. Aenean euismod elementum nisi quis eleifend. Nisi porta lorem mollis aliquam ut porttitor leo a. Lorem donec massa sapien faucibus et. Aliquam sem et tortor consequat id porta nibh venenatis cras. Commodo nulla facilisi nullam vehicula. Viverra nam libero justo laoreet sit amet cursus sit amet. Mauris nunc congue nisi vitae suscipit tellus mauris a diam. Vel orci porta non pulvinar neque laoreet suspendisse. Nulla pellentesque dignissim enim sit. Sed tempus urna et pharetra pharetra massa massa ultricies mi. Vitae justo eget magna fermentum iaculis eu non diam. Tempor orci dapibus ultrices in iaculis. Pretium fusce id velit ut tortor pretium. Senectus et netus et malesuada fames ac turpis egestas maecenas.</p>\\n<p>Massa massa ultricies mi quis. Habitasse platea dictumst quisque sagittis purus. Nullam non nisi est sit amet facilisis magna etiam tempor. Egestas dui id ornare arcu odio ut sem. Scelerisque eu ultrices vitae auctor. Quis ipsum suspendisse ultrices gravida dictum fusce ut. Imperdiet nulla malesuada pellentesque elit eget gravida. Pharetra diam sit amet nisl. Laoreet suspendisse interdum consectetur libero id faucibus nisl tincidunt eget. Sodales ut eu sem integer vitae. Felis donec et odio pellentesque diam volutpat commodo. In eu mi bibendum neque egestas congue quisque egestas diam. Massa massa ultricies mi quis hendrerit. Tristique magna sit amet purus gravida quis blandit turpis.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}}}}}','2019-02-05 18:39:18','2019-02-05 18:39:18','8c5319d8-ceff-4bdd-9305-ede84ce41be5'),
	(23,175,2,1,1,23,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"218\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-dark-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"219\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"220\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Freeform Template Example\",\"fontSize\":\"o-h1\",\"alignment\":\"u-text-center\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"214\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Form\",\"fontSize\":\"o-h2\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"215\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-bottom\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\",\"paddingSize\":\"-x2\",\"padding\":\"u-padding-vertical\"}},\"217\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"All About Lorem\",\"fontSize\":\"o-h5\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"216\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Et ultrices neque ornare aenean euismod. Interdum velit laoreet id donec. Velit euismod in pellentesque massa placerat duis ultricies lacus sed. Dapibus ultrices in iaculis nunc sed. A arcu cursus vitae congue mauris. At erat pellentesque adipiscing commodo elit at imperdiet dui. Malesuada fames ac turpis egestas maecenas pharetra convallis posuere. Consequat interdum varius sit amet mattis vulputate. Faucibus pulvinar elementum integer enim neque volutpat. Vitae aliquet nec ullamcorper sit. Pretium viverra suspendisse potenti nullam ac tortor. Sit amet luctus venenatis lectus magna fringilla urna porttitor. Est pellentesque elit ullamcorper dignissim cras tincidunt. Aliquam nulla facilisi cras fermentum odio eu feugiat pretium.</p>\\n<p>Orci a scelerisque purus semper eget duis at tellus at. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Elit sed vulputate mi sit amet mauris commodo quis. Tortor aliquam nulla facilisi cras fermentum odio eu. Vitae semper quis lectus nulla at volutpat. Posuere morbi leo urna molestie at elementum eu. Magna eget est lorem ipsum dolor sit amet consectetur adipiscing. Tincidunt dui ut ornare lectus. Risus nullam eget felis eget nunc. Congue nisi vitae suscipit tellus. Metus aliquam eleifend mi in nulla posuere sollicitudin. Amet volutpat consequat mauris nunc congue nisi vitae. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa. Donec enim diam vulputate ut.</p>\\n<p>Amet nisl purus in mollis nunc sed. Egestas purus viverra accumsan in. Venenatis tellus in metus vulputate eu. Id cursus metus aliquam eleifend mi in nulla. Pretium nibh ipsum consequat nisl vel pretium lectus. Pharetra sit amet aliquam id diam maecenas. Montes nascetur ridiculus mus mauris vitae ultricies leo integer. A diam maecenas sed enim ut sem viverra aliquet eget. Vestibulum morbi blandit cursus risus at ultrices. Ut venenatis tellus in metus vulputate eu scelerisque. Amet mauris commodo quis imperdiet massa tincidunt. Diam maecenas sed enim ut sem viverra aliquet eget.</p>\\n<p>Vel pharetra vel turpis nunc eget lorem dolor. Lacus suspendisse faucibus interdum posuere lorem. Aenean euismod elementum nisi quis eleifend. Nisi porta lorem mollis aliquam ut porttitor leo a. Lorem donec massa sapien faucibus et. Aliquam sem et tortor consequat id porta nibh venenatis cras. Commodo nulla facilisi nullam vehicula. Viverra nam libero justo laoreet sit amet cursus sit amet. Mauris nunc congue nisi vitae suscipit tellus mauris a diam. Vel orci porta non pulvinar neque laoreet suspendisse. Nulla pellentesque dignissim enim sit. Sed tempus urna et pharetra pharetra massa massa ultricies mi. Vitae justo eget magna fermentum iaculis eu non diam. Tempor orci dapibus ultrices in iaculis. Pretium fusce id velit ut tortor pretium. Senectus et netus et malesuada fames ac turpis egestas maecenas.</p>\\n<p>Massa massa ultricies mi quis. Habitasse platea dictumst quisque sagittis purus. Nullam non nisi est sit amet facilisis magna etiam tempor. Egestas dui id ornare arcu odio ut sem. Scelerisque eu ultrices vitae auctor. Quis ipsum suspendisse ultrices gravida dictum fusce ut. Imperdiet nulla malesuada pellentesque elit eget gravida. Pharetra diam sit amet nisl. Laoreet suspendisse interdum consectetur libero id faucibus nisl tincidunt eget. Sodales ut eu sem integer vitae. Felis donec et odio pellentesque diam volutpat commodo. In eu mi bibendum neque egestas congue quisque egestas diam. Massa massa ultricies mi quis hendrerit. Tristique magna sit amet purus gravida quis blandit turpis.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}}}}}','2019-02-05 18:40:25','2019-02-05 18:40:25','c6e30963-5ff1-4051-b06a-b852b55f58bd'),
	(24,175,2,1,1,24,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"218\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-dark-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"219\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":null,\"padding\":\"u-padding-vertical\"}},\"220\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Freeform Template Example\",\"fontSize\":\"o-h1\",\"alignment\":\"u-text-center\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"214\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Form\",\"fontSize\":\"o-h2\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"215\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-bottom\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\",\"paddingSize\":\"-x2\",\"padding\":\"u-padding-vertical\"}},\"217\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"All About Lorem\",\"fontSize\":\"o-h5\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"216\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Et ultrices neque ornare aenean euismod. Interdum velit laoreet id donec. Velit euismod in pellentesque massa placerat duis ultricies lacus sed. Dapibus ultrices in iaculis nunc sed. A arcu cursus vitae congue mauris. At erat pellentesque adipiscing commodo elit at imperdiet dui. Malesuada fames ac turpis egestas maecenas pharetra convallis posuere. Consequat interdum varius sit amet mattis vulputate. Faucibus pulvinar elementum integer enim neque volutpat. Vitae aliquet nec ullamcorper sit. Pretium viverra suspendisse potenti nullam ac tortor. Sit amet luctus venenatis lectus magna fringilla urna porttitor. Est pellentesque elit ullamcorper dignissim cras tincidunt. Aliquam nulla facilisi cras fermentum odio eu feugiat pretium.</p>\\n<p>Orci a scelerisque purus semper eget duis at tellus at. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Elit sed vulputate mi sit amet mauris commodo quis. Tortor aliquam nulla facilisi cras fermentum odio eu. Vitae semper quis lectus nulla at volutpat. Posuere morbi leo urna molestie at elementum eu. Magna eget est lorem ipsum dolor sit amet consectetur adipiscing. Tincidunt dui ut ornare lectus. Risus nullam eget felis eget nunc. Congue nisi vitae suscipit tellus. Metus aliquam eleifend mi in nulla posuere sollicitudin. Amet volutpat consequat mauris nunc congue nisi vitae. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa. Donec enim diam vulputate ut.</p>\\n<p>Amet nisl purus in mollis nunc sed. Egestas purus viverra accumsan in. Venenatis tellus in metus vulputate eu. Id cursus metus aliquam eleifend mi in nulla. Pretium nibh ipsum consequat nisl vel pretium lectus. Pharetra sit amet aliquam id diam maecenas. Montes nascetur ridiculus mus mauris vitae ultricies leo integer. A diam maecenas sed enim ut sem viverra aliquet eget. Vestibulum morbi blandit cursus risus at ultrices. Ut venenatis tellus in metus vulputate eu scelerisque. Amet mauris commodo quis imperdiet massa tincidunt. Diam maecenas sed enim ut sem viverra aliquet eget.</p>\\n<p>Vel pharetra vel turpis nunc eget lorem dolor. Lacus suspendisse faucibus interdum posuere lorem. Aenean euismod elementum nisi quis eleifend. Nisi porta lorem mollis aliquam ut porttitor leo a. Lorem donec massa sapien faucibus et. Aliquam sem et tortor consequat id porta nibh venenatis cras. Commodo nulla facilisi nullam vehicula. Viverra nam libero justo laoreet sit amet cursus sit amet. Mauris nunc congue nisi vitae suscipit tellus mauris a diam. Vel orci porta non pulvinar neque laoreet suspendisse. Nulla pellentesque dignissim enim sit. Sed tempus urna et pharetra pharetra massa massa ultricies mi. Vitae justo eget magna fermentum iaculis eu non diam. Tempor orci dapibus ultrices in iaculis. Pretium fusce id velit ut tortor pretium. Senectus et netus et malesuada fames ac turpis egestas maecenas.</p>\\n<p>Massa massa ultricies mi quis. Habitasse platea dictumst quisque sagittis purus. Nullam non nisi est sit amet facilisis magna etiam tempor. Egestas dui id ornare arcu odio ut sem. Scelerisque eu ultrices vitae auctor. Quis ipsum suspendisse ultrices gravida dictum fusce ut. Imperdiet nulla malesuada pellentesque elit eget gravida. Pharetra diam sit amet nisl. Laoreet suspendisse interdum consectetur libero id faucibus nisl tincidunt eget. Sodales ut eu sem integer vitae. Felis donec et odio pellentesque diam volutpat commodo. In eu mi bibendum neque egestas congue quisque egestas diam. Massa massa ultricies mi quis hendrerit. Tristique magna sit amet purus gravida quis blandit turpis.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}}}}}','2019-02-05 18:40:36','2019-02-05 18:40:36','8f82f173-6207-4f75-b2bd-72277cc290e7'),
	(25,175,2,1,1,25,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"218\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-dark-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"219\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"220\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Freeform Template Example\",\"fontSize\":\"o-h1\",\"alignment\":\"u-text-center\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"214\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Form\",\"fontSize\":\"o-h2\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"215\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-bottom\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\",\"paddingSize\":\"-x2\",\"padding\":\"u-padding-vertical\"}},\"217\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"All About Lorem\",\"fontSize\":\"o-h5\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"216\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Et ultrices neque ornare aenean euismod. Interdum velit laoreet id donec. Velit euismod in pellentesque massa placerat duis ultricies lacus sed. Dapibus ultrices in iaculis nunc sed. A arcu cursus vitae congue mauris. At erat pellentesque adipiscing commodo elit at imperdiet dui. Malesuada fames ac turpis egestas maecenas pharetra convallis posuere. Consequat interdum varius sit amet mattis vulputate. Faucibus pulvinar elementum integer enim neque volutpat. Vitae aliquet nec ullamcorper sit. Pretium viverra suspendisse potenti nullam ac tortor. Sit amet luctus venenatis lectus magna fringilla urna porttitor. Est pellentesque elit ullamcorper dignissim cras tincidunt. Aliquam nulla facilisi cras fermentum odio eu feugiat pretium.</p>\\n<p>Orci a scelerisque purus semper eget duis at tellus at. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Elit sed vulputate mi sit amet mauris commodo quis. Tortor aliquam nulla facilisi cras fermentum odio eu. Vitae semper quis lectus nulla at volutpat. Posuere morbi leo urna molestie at elementum eu. Magna eget est lorem ipsum dolor sit amet consectetur adipiscing. Tincidunt dui ut ornare lectus. Risus nullam eget felis eget nunc. Congue nisi vitae suscipit tellus. Metus aliquam eleifend mi in nulla posuere sollicitudin. Amet volutpat consequat mauris nunc congue nisi vitae. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa. Donec enim diam vulputate ut.</p>\\n<p>Amet nisl purus in mollis nunc sed. Egestas purus viverra accumsan in. Venenatis tellus in metus vulputate eu. Id cursus metus aliquam eleifend mi in nulla. Pretium nibh ipsum consequat nisl vel pretium lectus. Pharetra sit amet aliquam id diam maecenas. Montes nascetur ridiculus mus mauris vitae ultricies leo integer. A diam maecenas sed enim ut sem viverra aliquet eget. Vestibulum morbi blandit cursus risus at ultrices. Ut venenatis tellus in metus vulputate eu scelerisque. Amet mauris commodo quis imperdiet massa tincidunt. Diam maecenas sed enim ut sem viverra aliquet eget.</p>\\n<p>Vel pharetra vel turpis nunc eget lorem dolor. Lacus suspendisse faucibus interdum posuere lorem. Aenean euismod elementum nisi quis eleifend. Nisi porta lorem mollis aliquam ut porttitor leo a. Lorem donec massa sapien faucibus et. Aliquam sem et tortor consequat id porta nibh venenatis cras. Commodo nulla facilisi nullam vehicula. Viverra nam libero justo laoreet sit amet cursus sit amet. Mauris nunc congue nisi vitae suscipit tellus mauris a diam. Vel orci porta non pulvinar neque laoreet suspendisse. Nulla pellentesque dignissim enim sit. Sed tempus urna et pharetra pharetra massa massa ultricies mi. Vitae justo eget magna fermentum iaculis eu non diam. Tempor orci dapibus ultrices in iaculis. Pretium fusce id velit ut tortor pretium. Senectus et netus et malesuada fames ac turpis egestas maecenas.</p>\\n<p>Massa massa ultricies mi quis. Habitasse platea dictumst quisque sagittis purus. Nullam non nisi est sit amet facilisis magna etiam tempor. Egestas dui id ornare arcu odio ut sem. Scelerisque eu ultrices vitae auctor. Quis ipsum suspendisse ultrices gravida dictum fusce ut. Imperdiet nulla malesuada pellentesque elit eget gravida. Pharetra diam sit amet nisl. Laoreet suspendisse interdum consectetur libero id faucibus nisl tincidunt eget. Sodales ut eu sem integer vitae. Felis donec et odio pellentesque diam volutpat commodo. In eu mi bibendum neque egestas congue quisque egestas diam. Massa massa ultricies mi quis hendrerit. Tristique magna sit amet purus gravida quis blandit turpis.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}}}}}','2019-02-05 18:40:43','2019-02-05 18:40:43','20935875-af41-4cbb-bddf-50f4b0ec50c8'),
	(26,175,2,1,1,26,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"218\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-dark-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"219\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"220\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Freeform Template Example\",\"fontSize\":\"o-h1\",\"alignment\":\"u-text-center\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"214\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Form\",\"fontSize\":\"o-h2\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"215\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-bottom\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\",\"paddingSize\":\"-x2\",\"padding\":\"u-padding-vertical\"}},\"217\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"All About Lorem\",\"fontSize\":\"o-h5\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"216\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Et ultrices neque ornare aenean euismod. Interdum velit laoreet id donec. Velit euismod in pellentesque massa placerat duis ultricies lacus sed. Dapibus ultrices in iaculis nunc sed. A arcu cursus vitae congue mauris. At erat pellentesque adipiscing commodo elit at imperdiet dui. Malesuada fames ac turpis egestas maecenas pharetra convallis posuere. Consequat interdum varius sit amet mattis vulputate. Faucibus pulvinar elementum integer enim neque volutpat. Vitae aliquet nec ullamcorper sit. Pretium viverra suspendisse potenti nullam ac tortor. Sit amet luctus venenatis lectus magna fringilla urna porttitor. Est pellentesque elit ullamcorper dignissim cras tincidunt. Aliquam nulla facilisi cras fermentum odio eu feugiat pretium.</p>\\n<p>Orci a scelerisque purus semper eget duis at tellus at. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Elit sed vulputate mi sit amet mauris commodo quis. Tortor aliquam nulla facilisi cras fermentum odio eu. Vitae semper quis lectus nulla at volutpat. Posuere morbi leo urna molestie at elementum eu. Magna eget est lorem ipsum dolor sit amet consectetur adipiscing. Tincidunt dui ut ornare lectus. Risus nullam eget felis eget nunc. Congue nisi vitae suscipit tellus. Metus aliquam eleifend mi in nulla posuere sollicitudin. Amet volutpat consequat mauris nunc congue nisi vitae. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa. Donec enim diam vulputate ut.</p>\\n<p>Amet nisl purus in mollis nunc sed. Egestas purus viverra accumsan in. Venenatis tellus in metus vulputate eu. Id cursus metus aliquam eleifend mi in nulla. Pretium nibh ipsum consequat nisl vel pretium lectus. Pharetra sit amet aliquam id diam maecenas. Montes nascetur ridiculus mus mauris vitae ultricies leo integer. A diam maecenas sed enim ut sem viverra aliquet eget. Vestibulum morbi blandit cursus risus at ultrices. Ut venenatis tellus in metus vulputate eu scelerisque. Amet mauris commodo quis imperdiet massa tincidunt. Diam maecenas sed enim ut sem viverra aliquet eget.</p>\\n<p>Vel pharetra vel turpis nunc eget lorem dolor. Lacus suspendisse faucibus interdum posuere lorem. Aenean euismod elementum nisi quis eleifend. Nisi porta lorem mollis aliquam ut porttitor leo a. Lorem donec massa sapien faucibus et. Aliquam sem et tortor consequat id porta nibh venenatis cras. Commodo nulla facilisi nullam vehicula. Viverra nam libero justo laoreet sit amet cursus sit amet. Mauris nunc congue nisi vitae suscipit tellus mauris a diam. Vel orci porta non pulvinar neque laoreet suspendisse. Nulla pellentesque dignissim enim sit. Sed tempus urna et pharetra pharetra massa massa ultricies mi. Vitae justo eget magna fermentum iaculis eu non diam. Tempor orci dapibus ultrices in iaculis. Pretium fusce id velit ut tortor pretium. Senectus et netus et malesuada fames ac turpis egestas maecenas.</p>\\n<p>Massa massa ultricies mi quis. Habitasse platea dictumst quisque sagittis purus. Nullam non nisi est sit amet facilisis magna etiam tempor. Egestas dui id ornare arcu odio ut sem. Scelerisque eu ultrices vitae auctor. Quis ipsum suspendisse ultrices gravida dictum fusce ut. Imperdiet nulla malesuada pellentesque elit eget gravida. Pharetra diam sit amet nisl. Laoreet suspendisse interdum consectetur libero id faucibus nisl tincidunt eget. Sodales ut eu sem integer vitae. Felis donec et odio pellentesque diam volutpat commodo. In eu mi bibendum neque egestas congue quisque egestas diam. Massa massa ultricies mi quis hendrerit. Tristique magna sit amet purus gravida quis blandit turpis.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}}}}}','2019-02-05 18:41:01','2019-02-05 18:41:01','234e03cf-9e7d-4761-bc62-1d18d3b0cd72'),
	(27,175,2,1,1,27,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"218\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-dark-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x2\",\"padding\":\"u-padding-vertical\"}},\"219\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"220\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Freeform Template Example\",\"fontSize\":\"o-h1\",\"alignment\":\"u-text-center\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"214\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Form\",\"fontSize\":\"o-h2\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"215\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-bottom\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\",\"paddingSize\":\"-x2\",\"padding\":\"u-padding-vertical\"}},\"217\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"All About Lorem\",\"fontSize\":\"o-h5\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"216\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Et ultrices neque ornare aenean euismod. Interdum velit laoreet id donec. Velit euismod in pellentesque massa placerat duis ultricies lacus sed. Dapibus ultrices in iaculis nunc sed. A arcu cursus vitae congue mauris. At erat pellentesque adipiscing commodo elit at imperdiet dui. Malesuada fames ac turpis egestas maecenas pharetra convallis posuere. Consequat interdum varius sit amet mattis vulputate. Faucibus pulvinar elementum integer enim neque volutpat. Vitae aliquet nec ullamcorper sit. Pretium viverra suspendisse potenti nullam ac tortor. Sit amet luctus venenatis lectus magna fringilla urna porttitor. Est pellentesque elit ullamcorper dignissim cras tincidunt. Aliquam nulla facilisi cras fermentum odio eu feugiat pretium.</p>\\n<p>Orci a scelerisque purus semper eget duis at tellus at. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Elit sed vulputate mi sit amet mauris commodo quis. Tortor aliquam nulla facilisi cras fermentum odio eu. Vitae semper quis lectus nulla at volutpat. Posuere morbi leo urna molestie at elementum eu. Magna eget est lorem ipsum dolor sit amet consectetur adipiscing. Tincidunt dui ut ornare lectus. Risus nullam eget felis eget nunc. Congue nisi vitae suscipit tellus. Metus aliquam eleifend mi in nulla posuere sollicitudin. Amet volutpat consequat mauris nunc congue nisi vitae. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa. Donec enim diam vulputate ut.</p>\\n<p>Amet nisl purus in mollis nunc sed. Egestas purus viverra accumsan in. Venenatis tellus in metus vulputate eu. Id cursus metus aliquam eleifend mi in nulla. Pretium nibh ipsum consequat nisl vel pretium lectus. Pharetra sit amet aliquam id diam maecenas. Montes nascetur ridiculus mus mauris vitae ultricies leo integer. A diam maecenas sed enim ut sem viverra aliquet eget. Vestibulum morbi blandit cursus risus at ultrices. Ut venenatis tellus in metus vulputate eu scelerisque. Amet mauris commodo quis imperdiet massa tincidunt. Diam maecenas sed enim ut sem viverra aliquet eget.</p>\\n<p>Vel pharetra vel turpis nunc eget lorem dolor. Lacus suspendisse faucibus interdum posuere lorem. Aenean euismod elementum nisi quis eleifend. Nisi porta lorem mollis aliquam ut porttitor leo a. Lorem donec massa sapien faucibus et. Aliquam sem et tortor consequat id porta nibh venenatis cras. Commodo nulla facilisi nullam vehicula. Viverra nam libero justo laoreet sit amet cursus sit amet. Mauris nunc congue nisi vitae suscipit tellus mauris a diam. Vel orci porta non pulvinar neque laoreet suspendisse. Nulla pellentesque dignissim enim sit. Sed tempus urna et pharetra pharetra massa massa ultricies mi. Vitae justo eget magna fermentum iaculis eu non diam. Tempor orci dapibus ultrices in iaculis. Pretium fusce id velit ut tortor pretium. Senectus et netus et malesuada fames ac turpis egestas maecenas.</p>\\n<p>Massa massa ultricies mi quis. Habitasse platea dictumst quisque sagittis purus. Nullam non nisi est sit amet facilisis magna etiam tempor. Egestas dui id ornare arcu odio ut sem. Scelerisque eu ultrices vitae auctor. Quis ipsum suspendisse ultrices gravida dictum fusce ut. Imperdiet nulla malesuada pellentesque elit eget gravida. Pharetra diam sit amet nisl. Laoreet suspendisse interdum consectetur libero id faucibus nisl tincidunt eget. Sodales ut eu sem integer vitae. Felis donec et odio pellentesque diam volutpat commodo. In eu mi bibendum neque egestas congue quisque egestas diam. Massa massa ultricies mi quis hendrerit. Tristique magna sit amet purus gravida quis blandit turpis.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}}}}}','2019-02-05 18:41:09','2019-02-05 18:41:09','8b95cf7a-2c5c-4c1d-af4a-c7143d2b4076'),
	(28,175,2,1,1,28,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"214\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Form\",\"fontSize\":\"o-h2\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"215\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-bottom\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\",\"paddingSize\":\"-x2\",\"padding\":\"u-padding-vertical\"}},\"217\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"All About Lorem\",\"fontSize\":\"o-h5\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"216\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Et ultrices neque ornare aenean euismod. Interdum velit laoreet id donec. Velit euismod in pellentesque massa placerat duis ultricies lacus sed. Dapibus ultrices in iaculis nunc sed. A arcu cursus vitae congue mauris. At erat pellentesque adipiscing commodo elit at imperdiet dui. Malesuada fames ac turpis egestas maecenas pharetra convallis posuere. Consequat interdum varius sit amet mattis vulputate. Faucibus pulvinar elementum integer enim neque volutpat. Vitae aliquet nec ullamcorper sit. Pretium viverra suspendisse potenti nullam ac tortor. Sit amet luctus venenatis lectus magna fringilla urna porttitor. Est pellentesque elit ullamcorper dignissim cras tincidunt. Aliquam nulla facilisi cras fermentum odio eu feugiat pretium.</p>\\n<p>Orci a scelerisque purus semper eget duis at tellus at. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Elit sed vulputate mi sit amet mauris commodo quis. Tortor aliquam nulla facilisi cras fermentum odio eu. Vitae semper quis lectus nulla at volutpat. Posuere morbi leo urna molestie at elementum eu. Magna eget est lorem ipsum dolor sit amet consectetur adipiscing. Tincidunt dui ut ornare lectus. Risus nullam eget felis eget nunc. Congue nisi vitae suscipit tellus. Metus aliquam eleifend mi in nulla posuere sollicitudin. Amet volutpat consequat mauris nunc congue nisi vitae. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa. Donec enim diam vulputate ut.</p>\\n<p>Amet nisl purus in mollis nunc sed. Egestas purus viverra accumsan in. Venenatis tellus in metus vulputate eu. Id cursus metus aliquam eleifend mi in nulla. Pretium nibh ipsum consequat nisl vel pretium lectus. Pharetra sit amet aliquam id diam maecenas. Montes nascetur ridiculus mus mauris vitae ultricies leo integer. A diam maecenas sed enim ut sem viverra aliquet eget. Vestibulum morbi blandit cursus risus at ultrices. Ut venenatis tellus in metus vulputate eu scelerisque. Amet mauris commodo quis imperdiet massa tincidunt. Diam maecenas sed enim ut sem viverra aliquet eget.</p>\\n<p>Vel pharetra vel turpis nunc eget lorem dolor. Lacus suspendisse faucibus interdum posuere lorem. Aenean euismod elementum nisi quis eleifend. Nisi porta lorem mollis aliquam ut porttitor leo a. Lorem donec massa sapien faucibus et. Aliquam sem et tortor consequat id porta nibh venenatis cras. Commodo nulla facilisi nullam vehicula. Viverra nam libero justo laoreet sit amet cursus sit amet. Mauris nunc congue nisi vitae suscipit tellus mauris a diam. Vel orci porta non pulvinar neque laoreet suspendisse. Nulla pellentesque dignissim enim sit. Sed tempus urna et pharetra pharetra massa massa ultricies mi. Vitae justo eget magna fermentum iaculis eu non diam. Tempor orci dapibus ultrices in iaculis. Pretium fusce id velit ut tortor pretium. Senectus et netus et malesuada fames ac turpis egestas maecenas.</p>\\n<p>Massa massa ultricies mi quis. Habitasse platea dictumst quisque sagittis purus. Nullam non nisi est sit amet facilisis magna etiam tempor. Egestas dui id ornare arcu odio ut sem. Scelerisque eu ultrices vitae auctor. Quis ipsum suspendisse ultrices gravida dictum fusce ut. Imperdiet nulla malesuada pellentesque elit eget gravida. Pharetra diam sit amet nisl. Laoreet suspendisse interdum consectetur libero id faucibus nisl tincidunt eget. Sodales ut eu sem integer vitae. Felis donec et odio pellentesque diam volutpat commodo. In eu mi bibendum neque egestas congue quisque egestas diam. Massa massa ultricies mi quis hendrerit. Tristique magna sit amet purus gravida quis blandit turpis.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}}}}}','2019-02-05 18:41:28','2019-02-05 18:41:28','894a8d2f-ffb9-47d7-8bf7-1288d5d5af54'),
	(29,175,2,1,1,29,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"214\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Form\",\"fontSize\":\"o-h2\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"215\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-bottom\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-solid\",\"paddingSize\":\"-x2\",\"padding\":\"u-padding-vertical\"}},\"217\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"All About Lorem\",\"fontSize\":\"o-h5\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"216\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Et ultrices neque ornare aenean euismod. Interdum velit laoreet id donec. Velit euismod in pellentesque massa placerat duis ultricies lacus sed. Dapibus ultrices in iaculis nunc sed. A arcu cursus vitae congue mauris. At erat pellentesque adipiscing commodo elit at imperdiet dui. Malesuada fames ac turpis egestas maecenas pharetra convallis posuere. Consequat interdum varius sit amet mattis vulputate. Faucibus pulvinar elementum integer enim neque volutpat. Vitae aliquet nec ullamcorper sit. Pretium viverra suspendisse potenti nullam ac tortor. Sit amet luctus venenatis lectus magna fringilla urna porttitor. Est pellentesque elit ullamcorper dignissim cras tincidunt. Aliquam nulla facilisi cras fermentum odio eu feugiat pretium.</p>\\n<p>Orci a scelerisque purus semper eget duis at tellus at. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Elit sed vulputate mi sit amet mauris commodo quis. Tortor aliquam nulla facilisi cras fermentum odio eu. Vitae semper quis lectus nulla at volutpat. Posuere morbi leo urna molestie at elementum eu. Magna eget est lorem ipsum dolor sit amet consectetur adipiscing. Tincidunt dui ut ornare lectus. Risus nullam eget felis eget nunc. Congue nisi vitae suscipit tellus. Metus aliquam eleifend mi in nulla posuere sollicitudin. Amet volutpat consequat mauris nunc congue nisi vitae. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa. Donec enim diam vulputate ut.</p>\\n<p>Amet nisl purus in mollis nunc sed. Egestas purus viverra accumsan in. Venenatis tellus in metus vulputate eu. Id cursus metus aliquam eleifend mi in nulla. Pretium nibh ipsum consequat nisl vel pretium lectus. Pharetra sit amet aliquam id diam maecenas. Montes nascetur ridiculus mus mauris vitae ultricies leo integer. A diam maecenas sed enim ut sem viverra aliquet eget. Vestibulum morbi blandit cursus risus at ultrices. Ut venenatis tellus in metus vulputate eu scelerisque. Amet mauris commodo quis imperdiet massa tincidunt. Diam maecenas sed enim ut sem viverra aliquet eget.</p>\\n<p>Vel pharetra vel turpis nunc eget lorem dolor. Lacus suspendisse faucibus interdum posuere lorem. Aenean euismod elementum nisi quis eleifend. Nisi porta lorem mollis aliquam ut porttitor leo a. Lorem donec massa sapien faucibus et. Aliquam sem et tortor consequat id porta nibh venenatis cras. Commodo nulla facilisi nullam vehicula. Viverra nam libero justo laoreet sit amet cursus sit amet. Mauris nunc congue nisi vitae suscipit tellus mauris a diam. Vel orci porta non pulvinar neque laoreet suspendisse. Nulla pellentesque dignissim enim sit. Sed tempus urna et pharetra pharetra massa massa ultricies mi. Vitae justo eget magna fermentum iaculis eu non diam. Tempor orci dapibus ultrices in iaculis. Pretium fusce id velit ut tortor pretium. Senectus et netus et malesuada fames ac turpis egestas maecenas.</p>\\n<p>Massa massa ultricies mi quis. Habitasse platea dictumst quisque sagittis purus. Nullam non nisi est sit amet facilisis magna etiam tempor. Egestas dui id ornare arcu odio ut sem. Scelerisque eu ultrices vitae auctor. Quis ipsum suspendisse ultrices gravida dictum fusce ut. Imperdiet nulla malesuada pellentesque elit eget gravida. Pharetra diam sit amet nisl. Laoreet suspendisse interdum consectetur libero id faucibus nisl tincidunt eget. Sodales ut eu sem integer vitae. Felis donec et odio pellentesque diam volutpat commodo. In eu mi bibendum neque egestas congue quisque egestas diam. Massa massa ultricies mi quis hendrerit. Tristique magna sit amet purus gravida quis blandit turpis.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}}}}}','2019-02-05 18:45:38','2019-02-05 18:45:38','ee87651f-217b-4095-b3d6-2320025c60a4'),
	(30,175,2,1,1,30,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"214\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Form\",\"fontSize\":\"o-h2\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"215\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-bottom\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\",\"paddingSize\":\"-x2\",\"padding\":\"u-padding-vertical\"}},\"217\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"All About Lorem\",\"fontSize\":\"o-h5\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"216\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Et ultrices neque ornare aenean euismod. Interdum velit laoreet id donec. Velit euismod in pellentesque massa placerat duis ultricies lacus sed. Dapibus ultrices in iaculis nunc sed. A arcu cursus vitae congue mauris. At erat pellentesque adipiscing commodo elit at imperdiet dui. Malesuada fames ac turpis egestas maecenas pharetra convallis posuere. Consequat interdum varius sit amet mattis vulputate. Faucibus pulvinar elementum integer enim neque volutpat. Vitae aliquet nec ullamcorper sit. Pretium viverra suspendisse potenti nullam ac tortor. Sit amet luctus venenatis lectus magna fringilla urna porttitor. Est pellentesque elit ullamcorper dignissim cras tincidunt. Aliquam nulla facilisi cras fermentum odio eu feugiat pretium.</p>\\n<p>Orci a scelerisque purus semper eget duis at tellus at. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Elit sed vulputate mi sit amet mauris commodo quis. Tortor aliquam nulla facilisi cras fermentum odio eu. Vitae semper quis lectus nulla at volutpat. Posuere morbi leo urna molestie at elementum eu. Magna eget est lorem ipsum dolor sit amet consectetur adipiscing. Tincidunt dui ut ornare lectus. Risus nullam eget felis eget nunc. Congue nisi vitae suscipit tellus. Metus aliquam eleifend mi in nulla posuere sollicitudin. Amet volutpat consequat mauris nunc congue nisi vitae. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa. Donec enim diam vulputate ut.</p>\\n<p>Amet nisl purus in mollis nunc sed. Egestas purus viverra accumsan in. Venenatis tellus in metus vulputate eu. Id cursus metus aliquam eleifend mi in nulla. Pretium nibh ipsum consequat nisl vel pretium lectus. Pharetra sit amet aliquam id diam maecenas. Montes nascetur ridiculus mus mauris vitae ultricies leo integer. A diam maecenas sed enim ut sem viverra aliquet eget. Vestibulum morbi blandit cursus risus at ultrices. Ut venenatis tellus in metus vulputate eu scelerisque. Amet mauris commodo quis imperdiet massa tincidunt. Diam maecenas sed enim ut sem viverra aliquet eget.</p>\\n<p>Vel pharetra vel turpis nunc eget lorem dolor. Lacus suspendisse faucibus interdum posuere lorem. Aenean euismod elementum nisi quis eleifend. Nisi porta lorem mollis aliquam ut porttitor leo a. Lorem donec massa sapien faucibus et. Aliquam sem et tortor consequat id porta nibh venenatis cras. Commodo nulla facilisi nullam vehicula. Viverra nam libero justo laoreet sit amet cursus sit amet. Mauris nunc congue nisi vitae suscipit tellus mauris a diam. Vel orci porta non pulvinar neque laoreet suspendisse. Nulla pellentesque dignissim enim sit. Sed tempus urna et pharetra pharetra massa massa ultricies mi. Vitae justo eget magna fermentum iaculis eu non diam. Tempor orci dapibus ultrices in iaculis. Pretium fusce id velit ut tortor pretium. Senectus et netus et malesuada fames ac turpis egestas maecenas.</p>\\n<p>Massa massa ultricies mi quis. Habitasse platea dictumst quisque sagittis purus. Nullam non nisi est sit amet facilisis magna etiam tempor. Egestas dui id ornare arcu odio ut sem. Scelerisque eu ultrices vitae auctor. Quis ipsum suspendisse ultrices gravida dictum fusce ut. Imperdiet nulla malesuada pellentesque elit eget gravida. Pharetra diam sit amet nisl. Laoreet suspendisse interdum consectetur libero id faucibus nisl tincidunt eget. Sodales ut eu sem integer vitae. Felis donec et odio pellentesque diam volutpat commodo. In eu mi bibendum neque egestas congue quisque egestas diam. Massa massa ultricies mi quis hendrerit. Tristique magna sit amet purus gravida quis blandit turpis.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}}}}}','2019-02-05 18:47:06','2019-02-05 18:47:06','02221597-92c2-4397-bce5-31406d3fc71c'),
	(31,175,2,1,1,31,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"214\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Form\",\"fontSize\":\"o-h2\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"215\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-bottom\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\",\"paddingSize\":\"-x2\",\"padding\":\"u-padding-vertical\",\"submissionMessage\":\"Test\"}},\"217\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"All About Lorem\",\"fontSize\":\"o-h5\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"216\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Et ultrices neque ornare aenean euismod. Interdum velit laoreet id donec. Velit euismod in pellentesque massa placerat duis ultricies lacus sed. Dapibus ultrices in iaculis nunc sed. A arcu cursus vitae congue mauris. At erat pellentesque adipiscing commodo elit at imperdiet dui. Malesuada fames ac turpis egestas maecenas pharetra convallis posuere. Consequat interdum varius sit amet mattis vulputate. Faucibus pulvinar elementum integer enim neque volutpat. Vitae aliquet nec ullamcorper sit. Pretium viverra suspendisse potenti nullam ac tortor. Sit amet luctus venenatis lectus magna fringilla urna porttitor. Est pellentesque elit ullamcorper dignissim cras tincidunt. Aliquam nulla facilisi cras fermentum odio eu feugiat pretium.</p>\\n<p>Orci a scelerisque purus semper eget duis at tellus at. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Elit sed vulputate mi sit amet mauris commodo quis. Tortor aliquam nulla facilisi cras fermentum odio eu. Vitae semper quis lectus nulla at volutpat. Posuere morbi leo urna molestie at elementum eu. Magna eget est lorem ipsum dolor sit amet consectetur adipiscing. Tincidunt dui ut ornare lectus. Risus nullam eget felis eget nunc. Congue nisi vitae suscipit tellus. Metus aliquam eleifend mi in nulla posuere sollicitudin. Amet volutpat consequat mauris nunc congue nisi vitae. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa. Donec enim diam vulputate ut.</p>\\n<p>Amet nisl purus in mollis nunc sed. Egestas purus viverra accumsan in. Venenatis tellus in metus vulputate eu. Id cursus metus aliquam eleifend mi in nulla. Pretium nibh ipsum consequat nisl vel pretium lectus. Pharetra sit amet aliquam id diam maecenas. Montes nascetur ridiculus mus mauris vitae ultricies leo integer. A diam maecenas sed enim ut sem viverra aliquet eget. Vestibulum morbi blandit cursus risus at ultrices. Ut venenatis tellus in metus vulputate eu scelerisque. Amet mauris commodo quis imperdiet massa tincidunt. Diam maecenas sed enim ut sem viverra aliquet eget.</p>\\n<p>Vel pharetra vel turpis nunc eget lorem dolor. Lacus suspendisse faucibus interdum posuere lorem. Aenean euismod elementum nisi quis eleifend. Nisi porta lorem mollis aliquam ut porttitor leo a. Lorem donec massa sapien faucibus et. Aliquam sem et tortor consequat id porta nibh venenatis cras. Commodo nulla facilisi nullam vehicula. Viverra nam libero justo laoreet sit amet cursus sit amet. Mauris nunc congue nisi vitae suscipit tellus mauris a diam. Vel orci porta non pulvinar neque laoreet suspendisse. Nulla pellentesque dignissim enim sit. Sed tempus urna et pharetra pharetra massa massa ultricies mi. Vitae justo eget magna fermentum iaculis eu non diam. Tempor orci dapibus ultrices in iaculis. Pretium fusce id velit ut tortor pretium. Senectus et netus et malesuada fames ac turpis egestas maecenas.</p>\\n<p>Massa massa ultricies mi quis. Habitasse platea dictumst quisque sagittis purus. Nullam non nisi est sit amet facilisis magna etiam tempor. Egestas dui id ornare arcu odio ut sem. Scelerisque eu ultrices vitae auctor. Quis ipsum suspendisse ultrices gravida dictum fusce ut. Imperdiet nulla malesuada pellentesque elit eget gravida. Pharetra diam sit amet nisl. Laoreet suspendisse interdum consectetur libero id faucibus nisl tincidunt eget. Sodales ut eu sem integer vitae. Felis donec et odio pellentesque diam volutpat commodo. In eu mi bibendum neque egestas congue quisque egestas diam. Massa massa ultricies mi quis hendrerit. Tristique magna sit amet purus gravida quis blandit turpis.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}}}}}','2019-02-05 20:17:22','2019-02-05 20:17:22','38c26389-dbff-4bce-89a9-ab7a040daebe'),
	(32,175,2,1,1,32,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Form\",\"slug\":\"example-form\",\"postDate\":1548963060,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"176\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"padding\":\"u-padding-vertical\"}},\"177\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-narrow\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-vertical\"}},\"214\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Form\",\"fontSize\":\"o-h2\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"215\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding-bottom\"}},\"178\":{\"type\":\"form\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"selectedForm\":1,\"formStyle\":\"-outline\",\"paddingSize\":\"-x2\",\"padding\":\"u-padding-vertical\",\"submissionMessage\":\"<p>Testing</p>\"}},\"217\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"All About Lorem\",\"fontSize\":\"o-h5\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}},\"216\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Et ultrices neque ornare aenean euismod. Interdum velit laoreet id donec. Velit euismod in pellentesque massa placerat duis ultricies lacus sed. Dapibus ultrices in iaculis nunc sed. A arcu cursus vitae congue mauris. At erat pellentesque adipiscing commodo elit at imperdiet dui. Malesuada fames ac turpis egestas maecenas pharetra convallis posuere. Consequat interdum varius sit amet mattis vulputate. Faucibus pulvinar elementum integer enim neque volutpat. Vitae aliquet nec ullamcorper sit. Pretium viverra suspendisse potenti nullam ac tortor. Sit amet luctus venenatis lectus magna fringilla urna porttitor. Est pellentesque elit ullamcorper dignissim cras tincidunt. Aliquam nulla facilisi cras fermentum odio eu feugiat pretium.</p>\\n<p>Orci a scelerisque purus semper eget duis at tellus at. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Elit sed vulputate mi sit amet mauris commodo quis. Tortor aliquam nulla facilisi cras fermentum odio eu. Vitae semper quis lectus nulla at volutpat. Posuere morbi leo urna molestie at elementum eu. Magna eget est lorem ipsum dolor sit amet consectetur adipiscing. Tincidunt dui ut ornare lectus. Risus nullam eget felis eget nunc. Congue nisi vitae suscipit tellus. Metus aliquam eleifend mi in nulla posuere sollicitudin. Amet volutpat consequat mauris nunc congue nisi vitae. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa. Donec enim diam vulputate ut.</p>\\n<p>Amet nisl purus in mollis nunc sed. Egestas purus viverra accumsan in. Venenatis tellus in metus vulputate eu. Id cursus metus aliquam eleifend mi in nulla. Pretium nibh ipsum consequat nisl vel pretium lectus. Pharetra sit amet aliquam id diam maecenas. Montes nascetur ridiculus mus mauris vitae ultricies leo integer. A diam maecenas sed enim ut sem viverra aliquet eget. Vestibulum morbi blandit cursus risus at ultrices. Ut venenatis tellus in metus vulputate eu scelerisque. Amet mauris commodo quis imperdiet massa tincidunt. Diam maecenas sed enim ut sem viverra aliquet eget.</p>\\n<p>Vel pharetra vel turpis nunc eget lorem dolor. Lacus suspendisse faucibus interdum posuere lorem. Aenean euismod elementum nisi quis eleifend. Nisi porta lorem mollis aliquam ut porttitor leo a. Lorem donec massa sapien faucibus et. Aliquam sem et tortor consequat id porta nibh venenatis cras. Commodo nulla facilisi nullam vehicula. Viverra nam libero justo laoreet sit amet cursus sit amet. Mauris nunc congue nisi vitae suscipit tellus mauris a diam. Vel orci porta non pulvinar neque laoreet suspendisse. Nulla pellentesque dignissim enim sit. Sed tempus urna et pharetra pharetra massa massa ultricies mi. Vitae justo eget magna fermentum iaculis eu non diam. Tempor orci dapibus ultrices in iaculis. Pretium fusce id velit ut tortor pretium. Senectus et netus et malesuada fames ac turpis egestas maecenas.</p>\\n<p>Massa massa ultricies mi quis. Habitasse platea dictumst quisque sagittis purus. Nullam non nisi est sit amet facilisis magna etiam tempor. Egestas dui id ornare arcu odio ut sem. Scelerisque eu ultrices vitae auctor. Quis ipsum suspendisse ultrices gravida dictum fusce ut. Imperdiet nulla malesuada pellentesque elit eget gravida. Pharetra diam sit amet nisl. Laoreet suspendisse interdum consectetur libero id faucibus nisl tincidunt eget. Sodales ut eu sem integer vitae. Felis donec et odio pellentesque diam volutpat commodo. In eu mi bibendum neque egestas congue quisque egestas diam. Massa massa ultricies mi quis hendrerit. Tristique magna sit amet purus gravida quis blandit turpis.</p>\",\"alignment\":\"u-text-left\",\"paddingSize\":\"-none\",\"padding\":\"u-padding\"}}}}}','2019-02-05 20:18:11','2019-02-05 20:18:11','ec54bb45-ebd2-44f2-9958-6032dfa6d99b'),
	(33,239,2,1,1,1,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Test\",\"slug\":\"test\",\"postDate\":1549717380,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"240\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"paddingType\":\"u-padding-vertical\"}},\"241\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"paddingType\":\"u-padding-vertical\"}},\"242\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Leo urna molestie at elementum eu facilisis sed. Ut diam quam nulla porttitor massa id neque. Ullamcorper sit amet risus nullam eget felis. Amet consectetur adipiscing elit ut aliquam purus sit amet. Nullam non nisi est sit amet facilisis magna etiam tempor. Metus vulputate eu scelerisque felis imperdiet proin fermentum leo vel. Amet aliquam id diam maecenas ultricies mi eget mauris pharetra. Nibh nisl condimentum id venenatis a condimentum vitae sapien pellentesque. Eros in cursus turpis massa tincidunt. Pharetra diam sit amet nisl suscipit. Dui nunc mattis enim ut tellus elementum sagittis vitae. Tellus orci ac auctor augue mauris augue neque gravida. Vivamus arcu felis bibendum ut tristique et egestas quis. Nisl nisi scelerisque eu ultrices. Pretium fusce id velit ut tortor pretium viverra suspendisse potenti. Velit dignissim sodales ut eu sem integer.</p>\\n<p>Pharetra vel turpis nunc eget lorem. Sit amet volutpat consequat mauris nunc congue. Mauris cursus mattis molestie a iaculis. Quam adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus. Turpis egestas pretium aenean pharetra. Tellus in hac habitasse platea dictumst vestibulum rhoncus est. Mattis enim ut tellus elementum sagittis. Quis viverra nibh cras pulvinar. Fermentum posuere urna nec tincidunt praesent semper. Vestibulum morbi blandit cursus risus at ultrices mi tempus. Et egestas quis ipsum suspendisse ultrices gravida dictum. Fringilla ut morbi tincidunt augue.</p>\\n<p>Amet consectetur adipiscing elit pellentesque habitant morbi tristique senectus et. Eget mi proin sed libero enim sed faucibus. Augue neque gravida in fermentum. Tempus quam pellentesque nec nam aliquam sem et. Ut consequat semper viverra nam libero justo laoreet sit. Eget magna fermentum iaculis eu non. Consectetur libero id faucibus nisl tincidunt eget nullam. Adipiscing tristique risus nec feugiat. Massa eget egestas purus viverra. Maecenas sed enim ut sem viverra aliquet eget sit amet. Ut porttitor leo a diam sollicitudin tempor id. Vel pharetra vel turpis nunc eget lorem dolor sed.</p>\",\"alignment\":\"u-text-left\",\"columnLayout\":\"-double-cloumn\",\"paddingSize\":\"-none\",\"paddingType\":\"u-padding\"}}}}}','2019-02-09 13:03:57','2019-02-09 13:03:57','fb9ab9c2-4c0c-4b4f-90e1-2e8875b3fd64'),
	(34,239,2,1,1,2,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Test\",\"slug\":\"test\",\"postDate\":1549717380,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"240\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"paddingType\":\"u-padding-vertical\"}},\"241\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"paddingType\":\"u-padding-vertical\"}},\"242\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Leo urna molestie at elementum eu facilisis sed. Ut diam quam nulla porttitor massa id neque. Ullamcorper sit amet risus nullam eget felis. Amet consectetur adipiscing elit ut aliquam purus sit amet. Nullam non nisi est sit amet facilisis magna etiam tempor. Metus vulputate eu scelerisque felis imperdiet proin fermentum leo vel. Amet aliquam id diam maecenas ultricies mi eget mauris pharetra. Nibh nisl condimentum id venenatis a condimentum vitae sapien pellentesque. Eros in cursus turpis massa tincidunt. Pharetra diam sit amet nisl suscipit. Dui nunc mattis enim ut tellus elementum sagittis vitae. Tellus orci ac auctor augue mauris augue neque gravida. Vivamus arcu felis bibendum ut tristique et egestas quis. Nisl nisi scelerisque eu ultrices. Pretium fusce id velit ut tortor pretium viverra suspendisse potenti. Velit dignissim sodales ut eu sem integer.</p>\\n<p>Pharetra vel turpis nunc eget lorem. Sit amet volutpat consequat mauris nunc congue. Mauris cursus mattis molestie a iaculis. Quam adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus. Turpis egestas pretium aenean pharetra. Tellus in hac habitasse platea dictumst vestibulum rhoncus est. Mattis enim ut tellus elementum sagittis. Quis viverra nibh cras pulvinar. Fermentum posuere urna nec tincidunt praesent semper. Vestibulum morbi blandit cursus risus at ultrices mi tempus. Et egestas quis ipsum suspendisse ultrices gravida dictum. Fringilla ut morbi tincidunt augue.</p>\\n<p>Amet consectetur adipiscing elit pellentesque habitant morbi tristique senectus et. Eget mi proin sed libero enim sed faucibus. Augue neque gravida in fermentum. Tempus quam pellentesque nec nam aliquam sem et. Ut consequat semper viverra nam libero justo laoreet sit. Eget magna fermentum iaculis eu non. Consectetur libero id faucibus nisl tincidunt eget nullam. Adipiscing tristique risus nec feugiat. Massa eget egestas purus viverra. Maecenas sed enim ut sem viverra aliquet eget sit amet. Ut porttitor leo a diam sollicitudin tempor id. Vel pharetra vel turpis nunc eget lorem dolor sed.</p>\",\"alignment\":\"u-text-left\",\"columnLayout\":\"-single-column\",\"paddingSize\":\"-none\",\"paddingType\":\"u-padding\"}}}}}','2019-02-09 13:08:27','2019-02-09 13:08:27','d07cf913-7a5f-428b-83c6-11326ac4dafc'),
	(35,239,2,1,1,3,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Test\",\"slug\":\"test\",\"postDate\":1549717380,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"240\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-base-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlay\":\"none\",\"paddingSize\":\"-x4\",\"paddingType\":\"u-padding-vertical\"}},\"241\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-large\",\"verticalAlign\":\"-align-top\",\"paddingSize\":\"-none\",\"paddingType\":\"u-padding-vertical\"}},\"242\":{\"type\":\"copy\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"body\":\"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Leo urna molestie at elementum eu facilisis sed. Ut diam quam nulla porttitor massa id neque. Ullamcorper sit amet risus nullam eget felis. Amet consectetur adipiscing elit ut aliquam purus sit amet. Nullam non nisi est sit amet facilisis magna etiam tempor. Metus vulputate eu scelerisque felis imperdiet proin fermentum leo vel. Amet aliquam id diam maecenas ultricies mi eget mauris pharetra. Nibh nisl condimentum id venenatis a condimentum vitae sapien pellentesque. Eros in cursus turpis massa tincidunt. Pharetra diam sit amet nisl suscipit. Dui nunc mattis enim ut tellus elementum sagittis vitae. Tellus orci ac auctor augue mauris augue neque gravida. Vivamus arcu felis bibendum ut tristique et egestas quis. Nisl nisi scelerisque eu ultrices. Pretium fusce id velit ut tortor pretium viverra suspendisse potenti. Velit dignissim sodales ut eu sem integer.</p>\\n<p>Pharetra vel turpis nunc eget lorem. Sit amet volutpat consequat mauris nunc congue. Mauris cursus mattis molestie a iaculis. Quam adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus. Turpis egestas pretium aenean pharetra. Tellus in hac habitasse platea dictumst vestibulum rhoncus est. Mattis enim ut tellus elementum sagittis. Quis viverra nibh cras pulvinar. Fermentum posuere urna nec tincidunt praesent semper. Vestibulum morbi blandit cursus risus at ultrices mi tempus. Et egestas quis ipsum suspendisse ultrices gravida dictum. Fringilla ut morbi tincidunt augue.</p>\\n<p>Amet consectetur adipiscing elit pellentesque habitant morbi tristique senectus et. Eget mi proin sed libero enim sed faucibus. Augue neque gravida in fermentum. Tempus quam pellentesque nec nam aliquam sem et. Ut consequat semper viverra nam libero justo laoreet sit. Eget magna fermentum iaculis eu non. Consectetur libero id faucibus nisl tincidunt eget nullam. Adipiscing tristique risus nec feugiat. Massa eget egestas purus viverra. Maecenas sed enim ut sem viverra aliquet eget sit amet. Ut porttitor leo a diam sollicitudin tempor id. Vel pharetra vel turpis nunc eget lorem dolor sed.</p>\",\"alignment\":\"u-text-left\",\"columnLayout\":\"-double-column\",\"paddingSize\":\"-none\",\"paddingType\":\"u-padding\"}}}}}','2019-02-09 13:08:36','2019-02-09 13:08:36','a7b8f5ff-707a-4f4b-81b4-6e7eb0c40e19');

/*!40000 ALTER TABLE `pt_entryversions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_fieldgroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_fieldgroups`;

CREATE TABLE `pt_fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_fieldgroups` WRITE;
/*!40000 ALTER TABLE `pt_fieldgroups` DISABLE KEYS */;

INSERT INTO `pt_fieldgroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Common','2018-10-17 19:43:46','2018-10-17 19:43:46','8dcdb4b8-5035-411c-8f7f-5e255dcca924'),
	(2,'Site Settings','2018-12-08 15:05:48','2018-12-08 15:05:48','2e631263-d760-43da-adbd-abb7189fbd52'),
	(3,'Generic','2019-02-09 12:29:36','2019-02-09 12:29:36','f6bc4796-9e3b-4819-b11d-f927a538e259');

/*!40000 ALTER TABLE `pt_fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_fieldlayoutfields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_fieldlayoutfields`;

CREATE TABLE `pt_fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `pt_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `pt_fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `pt_fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `pt_fieldlayoutfields` DISABLE KEYS */;

INSERT INTO `pt_fieldlayoutfields` (`id`, `layoutId`, `tabId`, `fieldId`, `required`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(14,2,5,1,0,1,'2018-11-06 19:48:17','2018-11-06 19:48:17','593cc2cf-e045-4890-afc0-f79e148c290f'),
	(1787,14,401,52,1,1,'2018-11-29 19:01:53','2018-11-29 19:01:53','9956f9f6-5a4f-4556-a4a9-2a3da088df89'),
	(1788,14,401,58,0,2,'2018-11-29 19:01:53','2018-11-29 19:01:53','b8eabab3-d69c-42d7-bc20-e188d194df7b'),
	(1789,14,401,59,0,3,'2018-11-29 19:01:53','2018-11-29 19:01:53','b12db581-5975-4f14-a9ba-62b569df0ecf'),
	(3205,21,726,3,0,1,'2019-02-09 12:51:07','2019-02-09 12:51:07','6211d7cd-6287-4065-98ee-97fe9848f6bc'),
	(3206,21,727,4,0,1,'2019-02-09 12:51:07','2019-02-09 12:51:07','3344e648-f028-4b0c-b42d-6933b03743e6'),
	(3207,21,727,5,0,2,'2019-02-09 12:51:07','2019-02-09 12:51:07','29c4e455-412b-4a7c-b64f-b8fa2574a730'),
	(3208,21,727,11,0,3,'2019-02-09 12:51:07','2019-02-09 12:51:07','4e1cf304-78f0-43d0-b839-67feacc537af'),
	(3209,21,728,38,0,1,'2019-02-09 12:51:07','2019-02-09 12:51:07','08db4779-5a32-4ffc-8e7f-c66650fa489f'),
	(3210,21,728,28,0,2,'2019-02-09 12:51:07','2019-02-09 12:51:07','f5b93013-f2db-4488-917f-bf4aa9d86c4a'),
	(3211,22,729,14,0,1,'2019-02-09 12:52:33','2019-02-09 12:52:33','715dacf5-0654-4088-b33f-337acacd484d'),
	(3212,22,730,15,0,1,'2019-02-09 12:52:33','2019-02-09 12:52:33','f96bbbf2-5dd7-4e46-bfbf-16b90ca373a6'),
	(3213,22,730,16,0,2,'2019-02-09 12:52:33','2019-02-09 12:52:33','8b086ab5-f667-4363-82ba-c93837279cfa'),
	(3214,22,730,17,0,3,'2019-02-09 12:52:33','2019-02-09 12:52:33','fd4bac7b-b162-4852-a81a-2dc54b8c61fe'),
	(3215,22,731,37,0,1,'2019-02-09 12:52:33','2019-02-09 12:52:33','3334f1e7-8a16-40b7-ae04-8d3d02582c51'),
	(3216,22,731,36,0,2,'2019-02-09 12:52:33','2019-02-09 12:52:33','f4fd412e-3a67-4d90-8020-3603acdfa047'),
	(3217,23,732,6,0,1,'2019-02-09 12:53:05','2019-02-09 12:53:05','dfbf276c-fb01-4747-88ab-cfd8f295886e'),
	(3218,23,732,7,0,2,'2019-02-09 12:53:05','2019-02-09 12:53:05','e9aaf8c4-ce90-43dd-8bf4-6b734c32575e'),
	(3219,23,732,8,0,3,'2019-02-09 12:53:05','2019-02-09 12:53:05','7df112ab-8da8-4e65-82e5-db68369cabe4'),
	(3220,23,733,29,0,1,'2019-02-09 12:53:05','2019-02-09 12:53:05','002c607b-fe33-420c-972b-dcc7f19c7588'),
	(3221,23,733,10,0,2,'2019-02-09 12:53:05','2019-02-09 12:53:05','495f4c0f-f1a3-4681-a964-f051d866cd52'),
	(3222,24,734,18,0,1,'2019-02-09 12:53:41','2019-02-09 12:53:41','18d1b827-ff36-46d8-a9fa-0c71f0b85da8'),
	(3223,24,734,19,0,2,'2019-02-09 12:53:41','2019-02-09 12:53:41','e028ffa1-1ea9-4c66-9b5a-9cbd844d78ac'),
	(3224,24,735,30,0,1,'2019-02-09 12:53:41','2019-02-09 12:53:41','9ff5c936-3130-4842-95f5-db91573c4043'),
	(3225,24,735,20,0,2,'2019-02-09 12:53:41','2019-02-09 12:53:41','2522c015-2217-4528-af5a-6967bf35c71b'),
	(3226,25,736,6,0,1,'2019-02-09 12:53:54','2019-02-09 12:53:54','e612f555-8b13-46b4-a715-842aba7ead17'),
	(3227,25,736,7,0,2,'2019-02-09 12:53:54','2019-02-09 12:53:54','a24d215f-40b2-42a0-8ca2-171ee92dc28e'),
	(3228,25,736,8,0,3,'2019-02-09 12:53:54','2019-02-09 12:53:54','52f47420-3d25-43b3-8a5a-8a5d54d42f8e'),
	(3229,25,737,29,0,1,'2019-02-09 12:53:54','2019-02-09 12:53:54','2c708917-44f8-421d-998e-dbbfb254575f'),
	(3230,25,737,10,0,2,'2019-02-09 12:53:54','2019-02-09 12:53:54','008190d7-a536-4088-8d75-f085caf48696'),
	(3231,26,738,46,0,1,'2019-02-09 12:54:18','2019-02-09 12:54:18','2e9a9473-1ed5-4071-85b0-e7e2378887cc'),
	(3232,26,738,47,0,2,'2019-02-09 12:54:18','2019-02-09 12:54:18','ed18d427-6115-4177-888f-41d45168f3fb'),
	(3233,26,738,50,0,3,'2019-02-09 12:54:18','2019-02-09 12:54:18','33c9a9b3-8b0f-42fb-a810-7ed17741b392'),
	(3234,26,739,48,0,1,'2019-02-09 12:54:18','2019-02-09 12:54:18','29c9f177-4a7d-4ec8-af13-7b4b566a5e86'),
	(3235,26,739,49,0,2,'2019-02-09 12:54:18','2019-02-09 12:54:18','ee1e5213-6cc6-434c-b462-a5363e783c12'),
	(3236,27,740,60,0,1,'2019-02-09 12:54:41','2019-02-09 12:54:41','d21e67a2-dd1c-4e12-9b32-1a9224045ab3'),
	(3237,27,740,74,0,2,'2019-02-09 12:54:41','2019-02-09 12:54:41','77238805-09bd-4095-8999-84e4c1e9b788'),
	(3238,27,741,63,0,1,'2019-02-09 12:54:41','2019-02-09 12:54:41','7d2158e8-7d04-487c-bc74-6f5fe9a5e399'),
	(3239,27,741,64,0,2,'2019-02-09 12:54:41','2019-02-09 12:54:41','e10c1a85-c5ee-4544-9c80-ca1d604acda9'),
	(3240,28,742,65,0,1,'2019-02-09 12:55:26','2019-02-09 12:55:26','301563fb-ad31-4f8a-b8d4-3987a7b2b45e'),
	(3241,28,743,70,0,1,'2019-02-09 12:55:26','2019-02-09 12:55:26','f8cc3315-e6d7-4d1b-925d-8a6f6d7aea89'),
	(3242,28,743,69,0,2,'2019-02-09 12:55:26','2019-02-09 12:55:26','120679c6-993d-4aa9-83c9-845e0e592b65'),
	(3243,28,744,67,0,1,'2019-02-09 12:55:26','2019-02-09 12:55:26','31d8548f-c5d5-43a3-bcd2-5f7517f9955c'),
	(3244,28,744,68,0,2,'2019-02-09 12:55:26','2019-02-09 12:55:26','cb406a76-363e-4cec-a6c3-b64ffa267177'),
	(3245,29,745,60,0,1,'2019-02-09 12:55:46','2019-02-09 12:55:46','1c654041-8d91-442c-9aa7-ea9086bc0c31'),
	(3246,29,746,74,0,1,'2019-02-09 12:55:46','2019-02-09 12:55:46','2f7a1d90-4e2c-4647-9629-fc26ee94ace5'),
	(3247,29,747,63,0,1,'2019-02-09 12:55:46','2019-02-09 12:55:46','da152a9c-ca02-4795-9f60-b1c4d2bf98b9'),
	(3248,29,747,64,0,2,'2019-02-09 12:55:46','2019-02-09 12:55:46','b2276786-d22b-470c-9b57-980d91d5073a'),
	(3249,30,748,46,0,1,'2019-02-09 12:55:59','2019-02-09 12:55:59','a3b8bdd8-f31c-48ba-b7fd-9c39087e2556'),
	(3250,30,748,47,0,2,'2019-02-09 12:55:59','2019-02-09 12:55:59','ee17678d-5842-45dd-95a2-d40b8dc0c2a4'),
	(3251,30,749,50,0,1,'2019-02-09 12:55:59','2019-02-09 12:55:59','e10e2062-6c28-4b84-ac98-6ba1f5a4f435'),
	(3252,30,750,48,0,1,'2019-02-09 12:55:59','2019-02-09 12:55:59','83e42d03-9b5b-4f2e-aa6f-dac0bc164abe'),
	(3253,30,750,49,0,2,'2019-02-09 12:55:59','2019-02-09 12:55:59','a8422c50-04a0-4bcc-b40a-86c04f60580d'),
	(3254,31,751,18,0,1,'2019-02-09 12:56:15','2019-02-09 12:56:15','d5b911a5-de77-4ed4-b209-995ed348d194'),
	(3255,31,752,19,0,1,'2019-02-09 12:56:15','2019-02-09 12:56:15','447f3ce3-8963-4ce0-acc5-240116f789d7'),
	(3256,31,753,30,0,1,'2019-02-09 12:56:15','2019-02-09 12:56:15','05537c73-0bcc-4c67-9c5c-5825451acffc'),
	(3257,31,753,20,0,2,'2019-02-09 12:56:15','2019-02-09 12:56:15','0c9c67b2-4a66-43d9-9821-1fad368dad30'),
	(3258,32,754,6,0,1,'2019-02-09 12:56:29','2019-02-09 12:56:29','9df5961d-4eda-4ba9-94de-53887714d7f0'),
	(3259,32,755,7,0,1,'2019-02-09 12:56:29','2019-02-09 12:56:29','66567f00-d5a9-46c0-80c5-58cbbf938ad0'),
	(3260,32,755,8,0,2,'2019-02-09 12:56:29','2019-02-09 12:56:29','f4b58514-3a56-4e20-bf95-2d5e634c575c'),
	(3261,32,756,29,0,1,'2019-02-09 12:56:29','2019-02-09 12:56:29','dd59c439-43b4-4470-b7e9-471817960a57'),
	(3262,32,756,10,0,2,'2019-02-09 12:56:29','2019-02-09 12:56:29','3b446da9-7125-4a55-95ae-f22dfb6b57d7'),
	(3263,33,757,21,0,1,'2019-02-09 12:58:07','2019-02-09 12:58:07','0d55b537-f04d-4a41-a70b-129dd6342b70'),
	(3264,33,758,22,0,1,'2019-02-09 12:58:07','2019-02-09 12:58:07','354ea314-3783-4b88-a6ac-a3fe0bc192f2'),
	(3265,33,758,34,0,2,'2019-02-09 12:58:07','2019-02-09 12:58:07','f74e36c1-1653-4185-8c62-ab2ad3771df6'),
	(3266,33,758,45,0,3,'2019-02-09 12:58:07','2019-02-09 12:58:07','82aebaf7-6e86-4c10-8790-5ad46d9cf194'),
	(3267,33,758,33,0,4,'2019-02-09 12:58:07','2019-02-09 12:58:07','02099bd5-fb74-47b4-b70c-0759b0608711'),
	(3268,33,758,24,0,5,'2019-02-09 12:58:07','2019-02-09 12:58:07','bc01ab88-d985-4011-93b8-79cf01106b82'),
	(3269,33,758,35,0,6,'2019-02-09 12:58:07','2019-02-09 12:58:07','60c139ca-9ab5-4ab7-8706-76602de39565'),
	(3270,33,758,25,0,7,'2019-02-09 12:58:07','2019-02-09 12:58:07','83a6862c-dc4d-415f-b0db-bb4ee34eb604'),
	(3271,33,759,31,0,1,'2019-02-09 12:58:07','2019-02-09 12:58:07','6d70c3c8-2927-4745-bc81-3f0ca46aeaa1'),
	(3272,33,759,23,0,2,'2019-02-09 12:58:07','2019-02-09 12:58:07','e8e09d93-1338-4ec4-a7cc-c6014c287a5f'),
	(3273,34,760,51,0,1,'2019-02-09 12:58:48','2019-02-09 12:58:48','1939422b-2d47-473d-a99c-2ffd39252e88'),
	(3274,34,761,55,0,1,'2019-02-09 12:58:48','2019-02-09 12:58:48','8447b301-73a7-4e04-b842-c2818c2be894'),
	(3275,34,761,56,0,2,'2019-02-09 12:58:48','2019-02-09 12:58:48','abaceba7-02a3-492f-8950-dc0e514b9ec3'),
	(3276,34,761,57,0,3,'2019-02-09 12:58:48','2019-02-09 12:58:48','ff4fb1be-8fd6-4a2e-aabd-08e91f02fe13'),
	(3277,34,762,53,0,1,'2019-02-09 12:58:48','2019-02-09 12:58:48','523c536b-1a8d-45bc-8539-b509ff0a4211'),
	(3278,34,762,54,0,2,'2019-02-09 12:58:48','2019-02-09 12:58:48','ce35d131-2f58-449f-a136-e77e9956622a'),
	(3279,35,763,39,0,1,'2019-02-09 12:59:17','2019-02-09 12:59:17','668625a2-dbef-4010-baeb-ab053ad03153'),
	(3280,35,764,42,0,1,'2019-02-09 12:59:17','2019-02-09 12:59:17','3d51895b-b573-4e56-a34b-522a3de2d1fe'),
	(3281,35,765,43,0,1,'2019-02-09 12:59:17','2019-02-09 12:59:17','ca8e11bd-4e92-4a46-9dba-6f3789234d97'),
	(3282,35,765,44,0,2,'2019-02-09 12:59:17','2019-02-09 12:59:17','a6d5250b-fe1a-4329-a75b-a4cbe999f770'),
	(3283,36,766,75,0,1,'2019-02-09 12:59:56','2019-02-09 12:59:56','a03bceee-9229-4761-a4ce-37f5fc03f488'),
	(3284,36,767,76,0,1,'2019-02-09 12:59:56','2019-02-09 12:59:56','7758d68e-2e8b-4e03-993b-00087c3843c8'),
	(3285,36,767,79,0,2,'2019-02-09 12:59:56','2019-02-09 12:59:56','b6acff37-70ba-449d-b004-7bde0a166146'),
	(3286,36,768,77,0,1,'2019-02-09 12:59:56','2019-02-09 12:59:56','5a312bc0-2b63-4aa8-9edf-f1b7d5d78d5b'),
	(3287,36,768,78,0,2,'2019-02-09 12:59:56','2019-02-09 12:59:56','59447341-a6ef-4587-a69e-99524d3dad30'),
	(3357,37,784,18,0,1,'2019-02-09 13:02:31','2019-02-09 13:02:31','4a2a7177-ff6f-43ba-9d2f-3fb551f947b7'),
	(3358,37,785,19,0,1,'2019-02-09 13:02:31','2019-02-09 13:02:31','e4759dab-9797-4575-bb4a-86704a955a4e'),
	(3359,37,785,91,0,2,'2019-02-09 13:02:31','2019-02-09 13:02:31','8b091b95-5b7b-4b54-b877-dd8a5d004013'),
	(3360,37,786,30,0,1,'2019-02-09 13:02:31','2019-02-09 13:02:31','ad82e55e-ab8d-4640-b456-ea9da1cfe930'),
	(3361,37,786,20,0,2,'2019-02-09 13:02:31','2019-02-09 13:02:31','2b38e2d7-fd32-4eed-85ae-20d09c81c2b5'),
	(3362,3,787,3,0,1,'2019-02-09 13:08:19','2019-02-09 13:08:19','3589a993-c625-4785-b1bc-979cfa855191'),
	(3363,3,787,4,0,2,'2019-02-09 13:08:19','2019-02-09 13:08:19','57a77263-fa18-40b8-961a-5da10280aef0'),
	(3364,3,787,5,0,3,'2019-02-09 13:08:19','2019-02-09 13:08:19','3757c7a2-813c-4df2-9b2c-0e0858d4ae61'),
	(3365,3,787,11,0,4,'2019-02-09 13:08:19','2019-02-09 13:08:19','b6708a4d-d381-42c1-894a-e9a5e4c430b2'),
	(3366,3,787,38,0,5,'2019-02-09 13:08:19','2019-02-09 13:08:19','4cf80f05-b720-41d0-bf3f-43bb7795df5d'),
	(3367,3,787,28,0,6,'2019-02-09 13:08:19','2019-02-09 13:08:19','9984654b-f1db-4e9f-8b42-5e2d8d62ca0c'),
	(3368,7,788,14,0,1,'2019-02-09 13:08:19','2019-02-09 13:08:19','2bde4483-e2c7-46d9-a044-752d481e6591'),
	(3369,7,788,15,0,2,'2019-02-09 13:08:19','2019-02-09 13:08:19','6e7e4baf-2261-42f0-b77f-4699f5f8620e'),
	(3370,7,788,16,0,3,'2019-02-09 13:08:19','2019-02-09 13:08:19','56a04e78-84bf-4fbc-8e3e-2ca872f653e7'),
	(3371,7,788,17,0,4,'2019-02-09 13:08:19','2019-02-09 13:08:19','29b83c41-395c-4924-b8b0-3813c03aa74d'),
	(3372,7,788,37,0,5,'2019-02-09 13:08:19','2019-02-09 13:08:19','48b664c1-a767-4acc-a349-752a6a4d8045'),
	(3373,7,788,36,0,6,'2019-02-09 13:08:19','2019-02-09 13:08:19','4565bf7c-02d6-49bf-8816-e0985fcc1f63'),
	(3374,6,790,6,1,1,'2019-02-09 13:08:20','2019-02-09 13:08:20','a6c08663-a9dd-49a1-b20c-239d5202824c'),
	(3375,6,790,7,0,2,'2019-02-09 13:08:20','2019-02-09 13:08:20','4ea03da9-438b-473e-a07c-16b9b35ae60d'),
	(3376,6,790,8,0,3,'2019-02-09 13:08:20','2019-02-09 13:08:20','e79a6471-e333-4e62-854d-172eea38b57b'),
	(3377,6,790,29,0,4,'2019-02-09 13:08:20','2019-02-09 13:08:20','8dabfd8b-d44f-4797-81ba-11996fd0be27'),
	(3378,6,790,10,0,5,'2019-02-09 13:08:20','2019-02-09 13:08:20','3f3703a5-6677-44de-8d25-ce68c149da6f'),
	(3379,9,791,18,1,1,'2019-02-09 13:08:20','2019-02-09 13:08:20','062081af-a9fd-4e31-b1ea-d3a937df5504'),
	(3380,9,791,19,0,2,'2019-02-09 13:08:20','2019-02-09 13:08:20','218d1db7-774d-4d73-a68a-88f57eef514b'),
	(3381,9,791,91,0,3,'2019-02-09 13:08:20','2019-02-09 13:08:20','cb179fee-2867-42ae-801f-c01e70628bfe'),
	(3382,9,791,30,0,4,'2019-02-09 13:08:20','2019-02-09 13:08:20','a9323b28-c206-4da1-b3b2-391f5372784a'),
	(3383,9,791,20,0,5,'2019-02-09 13:08:20','2019-02-09 13:08:20','64349eaa-fd0d-40ea-94a9-eb899baa9df4'),
	(3384,10,792,21,1,1,'2019-02-09 13:08:20','2019-02-09 13:08:20','12edb1a6-749f-4dc2-8a45-8345b0df8737'),
	(3385,10,792,22,0,2,'2019-02-09 13:08:20','2019-02-09 13:08:20','a5005ce5-6377-4016-86f8-a49b9151f27d'),
	(3386,10,792,34,0,3,'2019-02-09 13:08:20','2019-02-09 13:08:20','740b9e99-8223-4715-935d-99d4b6f3617d'),
	(3387,10,792,45,0,4,'2019-02-09 13:08:20','2019-02-09 13:08:20','6decb9c9-4a03-488d-8aaf-e0ba67280912'),
	(3388,10,792,33,0,5,'2019-02-09 13:08:20','2019-02-09 13:08:20','418e3299-6aa4-40ff-bd25-389e48d4b027'),
	(3389,10,792,24,0,6,'2019-02-09 13:08:20','2019-02-09 13:08:20','181dedd1-7844-4706-9121-00c2e4c6f294'),
	(3390,10,792,35,0,7,'2019-02-09 13:08:20','2019-02-09 13:08:20','3f5cbd41-ddf4-41ac-bae4-23069c792240'),
	(3391,10,792,25,0,8,'2019-02-09 13:08:20','2019-02-09 13:08:20','0487860a-6855-4a56-8f4c-6f6d2edf1248'),
	(3392,10,792,31,0,9,'2019-02-09 13:08:20','2019-02-09 13:08:20','18cfee4d-3f24-45c4-a0a2-7cb243cbacd3'),
	(3393,10,792,23,0,10,'2019-02-09 13:08:20','2019-02-09 13:08:20','5480eeae-a9e7-4c7a-bbfd-95d177cbb363'),
	(3394,11,793,40,1,1,'2019-02-09 13:08:21','2019-02-09 13:08:21','e1a243a3-82a2-4ab2-9845-2dbc48d37da8'),
	(3395,11,793,41,0,2,'2019-02-09 13:08:21','2019-02-09 13:08:21','e3e63b1f-ae83-4d6d-af7b-71f93bf3b0dc'),
	(3396,12,794,39,1,1,'2019-02-09 13:08:21','2019-02-09 13:08:21','51abc42e-78a7-4b5c-89ae-67987a2b866d'),
	(3397,12,794,42,0,2,'2019-02-09 13:08:21','2019-02-09 13:08:21','48110a36-66ef-4b99-8ff3-fed32ae42c11'),
	(3398,12,794,43,0,3,'2019-02-09 13:08:21','2019-02-09 13:08:21','9a30abcc-a903-4cd2-b708-c0e07b758aba'),
	(3399,12,794,44,0,4,'2019-02-09 13:08:21','2019-02-09 13:08:21','a59c766d-f577-4681-a30d-d8566b8a9f6e'),
	(3400,13,795,46,0,1,'2019-02-09 13:08:21','2019-02-09 13:08:21','6bcdf519-aa36-43ef-be81-271582e6042c'),
	(3401,13,795,47,0,2,'2019-02-09 13:08:21','2019-02-09 13:08:21','11de801d-7ddc-46d2-9387-c0591d74ec6f'),
	(3402,13,795,50,0,3,'2019-02-09 13:08:21','2019-02-09 13:08:21','584e8ad8-3a04-4b47-bbbc-38ba61ebf5f2'),
	(3403,13,795,48,0,4,'2019-02-09 13:08:21','2019-02-09 13:08:21','c5f9d08a-34a6-436f-97ce-78b14334ce92'),
	(3404,13,795,49,0,5,'2019-02-09 13:08:21','2019-02-09 13:08:21','693272b4-7b51-4668-9d8c-690ad7621778'),
	(3405,15,796,51,1,1,'2019-02-09 13:08:21','2019-02-09 13:08:21','ed45565e-a677-417b-b17a-93acf8088402'),
	(3406,15,796,55,0,2,'2019-02-09 13:08:21','2019-02-09 13:08:21','c73f60c5-92a6-4b0c-bbcc-a7255befd4ec'),
	(3407,15,796,56,0,3,'2019-02-09 13:08:21','2019-02-09 13:08:21','f663409c-17ec-4ea5-b065-62f8d18bd55a'),
	(3408,15,796,57,0,4,'2019-02-09 13:08:21','2019-02-09 13:08:21','6178d01f-798f-41ee-a759-0ee390f28703'),
	(3409,15,796,53,0,5,'2019-02-09 13:08:21','2019-02-09 13:08:21','3a16867c-1720-4bea-b221-d2853fba27f6'),
	(3410,15,796,54,0,6,'2019-02-09 13:08:21','2019-02-09 13:08:21','567d3450-e435-4fb3-800e-f2f586543eb9'),
	(3411,16,797,61,1,1,'2019-02-09 13:08:22','2019-02-09 13:08:22','71ed6c47-d024-49bc-9411-68b2ccc90e46'),
	(3412,16,797,62,0,2,'2019-02-09 13:08:22','2019-02-09 13:08:22','2dacc24f-dd00-4b68-82c5-90935b2c434b'),
	(3413,16,797,71,0,3,'2019-02-09 13:08:22','2019-02-09 13:08:22','87062add-a206-44d3-8c68-8b60e8edc5c9'),
	(3414,16,797,72,0,4,'2019-02-09 13:08:22','2019-02-09 13:08:22','8e0cd0e9-f0ac-4534-830a-185eb05b3a81'),
	(3415,16,797,73,0,5,'2019-02-09 13:08:22','2019-02-09 13:08:22','6533e7d4-550b-4e20-8e98-0eb117e20590'),
	(3416,17,798,60,1,1,'2019-02-09 13:08:22','2019-02-09 13:08:22','4ed8f528-f8c3-4a68-bfb4-f8f9c80a10aa'),
	(3417,17,798,74,0,2,'2019-02-09 13:08:22','2019-02-09 13:08:22','c88a91f6-0a20-432c-a7f5-9962a4e44999'),
	(3418,17,798,63,0,3,'2019-02-09 13:08:22','2019-02-09 13:08:22','ce78ada5-3f78-4270-b6c0-ace6160339ed'),
	(3419,17,798,64,0,4,'2019-02-09 13:08:22','2019-02-09 13:08:22','b4d4ed49-5db5-4da1-b73d-db2b2a321add'),
	(3420,18,799,66,1,1,'2019-02-09 13:08:22','2019-02-09 13:08:22','cff4da27-53a7-4e96-8947-99ead3c83965'),
	(3421,19,800,65,1,1,'2019-02-09 13:08:22','2019-02-09 13:08:22','d627dec7-f317-4750-8ee8-0e1902c99851'),
	(3422,19,800,70,0,2,'2019-02-09 13:08:22','2019-02-09 13:08:22','d226f1e8-bb6d-4f96-9afd-9b1cf3d26b01'),
	(3423,19,800,69,0,3,'2019-02-09 13:08:22','2019-02-09 13:08:22','97151700-6205-471a-bda6-b3c58c566b02'),
	(3424,19,800,67,0,4,'2019-02-09 13:08:22','2019-02-09 13:08:22','4f985a2f-f0a6-4497-a6cc-054e6edfa4d0'),
	(3425,19,800,68,0,5,'2019-02-09 13:08:22','2019-02-09 13:08:22','54a4dff7-85c2-457a-89cc-dd7aed8323f3'),
	(3426,20,801,75,1,1,'2019-02-09 13:08:23','2019-02-09 13:08:23','3af2c487-c903-4f58-aa8e-fdf4927ab79e'),
	(3427,20,801,76,0,2,'2019-02-09 13:08:23','2019-02-09 13:08:23','e030a28c-66dd-403e-bca7-9a723b6c5b5b'),
	(3428,20,801,79,0,3,'2019-02-09 13:08:23','2019-02-09 13:08:23','bad6311a-4d03-4dc4-a521-d9f1fc92792a'),
	(3429,20,801,77,0,4,'2019-02-09 13:08:23','2019-02-09 13:08:23','996d5717-4fac-4226-bf07-09a2f8a11da8'),
	(3430,20,801,78,0,5,'2019-02-09 13:08:23','2019-02-09 13:08:23','a4d6cebd-53a2-4417-9cc9-ba3ef1f5a47e');

/*!40000 ALTER TABLE `pt_fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_fieldlayouts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_fieldlayouts`;

CREATE TABLE `pt_fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_type_idx` (`type`),
  KEY `pt_fieldlayouts_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_fieldlayouts` WRITE;
/*!40000 ALTER TABLE `pt_fieldlayouts` DISABLE KEYS */;

INSERT INTO `pt_fieldlayouts` (`id`, `type`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(2,'craft\\elements\\Entry','2018-11-06 19:23:08','2018-11-06 19:48:17',NULL,'49f16c08-2073-4897-8f3e-92355d39b819'),
	(3,'craft\\elements\\MatrixBlock','2018-11-06 19:29:37','2019-02-09 13:08:19',NULL,'cccaf184-6482-40a9-bdc8-acaaebe6917f'),
	(4,'craft\\elements\\Asset','2018-11-06 19:33:37','2018-11-06 19:33:37','2019-01-30 12:51:10','47c48e31-d23e-4089-b483-3ecfc95a95b0'),
	(5,'craft\\elements\\Asset','2018-11-06 19:33:56','2018-11-06 19:33:56','2019-01-30 12:51:20','ecfdc16e-4402-41a4-a5af-09785582316a'),
	(6,'craft\\elements\\MatrixBlock','2018-11-06 19:54:26','2019-02-09 13:08:20',NULL,'39856f0c-11eb-4fe4-a60d-07e698ae181c'),
	(7,'craft\\elements\\MatrixBlock','2018-11-07 13:26:27','2019-02-09 13:08:19',NULL,'cb1fed6a-0e67-4c84-8d89-ebba225f2dad'),
	(8,'craft\\elements\\MatrixBlock','2018-11-07 13:26:27','2019-02-09 13:08:19',NULL,'4455065f-9480-4863-8fad-e12f4b0ddf84'),
	(9,'craft\\elements\\MatrixBlock','2018-11-21 13:02:30','2019-02-09 13:08:20',NULL,'4b28f1e5-4fd6-4d61-af99-5adc926b4e45'),
	(10,'craft\\elements\\MatrixBlock','2018-11-21 13:26:58','2019-02-09 13:08:20',NULL,'93482697-e9bb-4748-bd38-cd3eb28b0f93'),
	(11,'verbb\\supertable\\elements\\SuperTableBlockElement','2018-11-28 19:07:47','2019-02-09 13:08:21',NULL,'975abb82-2d2e-45a0-8cef-bb19c73b3d2e'),
	(12,'craft\\elements\\MatrixBlock','2018-11-28 19:07:47','2019-02-09 13:08:21',NULL,'e17d5a6b-1851-4037-9aba-45296cc932dc'),
	(13,'craft\\elements\\MatrixBlock','2018-11-29 13:45:52','2019-02-09 13:08:21',NULL,'cbe6b628-b4ac-4766-88ff-b47c38af7989'),
	(14,'verbb\\supertable\\elements\\SuperTableBlockElement','2018-11-29 16:00:58','2018-11-29 19:01:53',NULL,'4060b2d8-29a2-42b7-b12d-1af66e985375'),
	(15,'craft\\elements\\MatrixBlock','2018-11-29 16:00:58','2019-02-09 13:08:21',NULL,'57b3a20d-8b2a-4bce-a97d-b60a88dc71d9'),
	(16,'verbb\\supertable\\elements\\SuperTableBlockElement','2018-12-07 12:52:41','2019-02-09 13:08:22',NULL,'0ff68a13-d28a-4bab-bfdd-ea638bb9166b'),
	(17,'craft\\elements\\MatrixBlock','2018-12-07 12:52:42','2019-02-09 13:08:22',NULL,'94c10d74-960d-479e-85fd-ece5fa16eaeb'),
	(18,'verbb\\supertable\\elements\\SuperTableBlockElement','2018-12-07 17:24:19','2019-02-09 13:08:22',NULL,'89001764-e066-4ae4-91cb-a4eaf6d519aa'),
	(19,'craft\\elements\\MatrixBlock','2018-12-07 17:24:19','2019-02-09 13:08:22',NULL,'54e4b974-31e5-45f1-80c3-8074ec779330'),
	(20,'craft\\elements\\MatrixBlock','2019-01-31 19:31:00','2019-02-09 13:08:23',NULL,'690cb536-5cb0-499e-9a5e-c39d45484f10'),
	(21,'Spoon_BlockType','2019-02-09 12:51:07','2019-02-09 12:51:07',NULL,'75920ab8-e637-4ad0-abe3-ffd92565b680'),
	(22,'Spoon_BlockType','2019-02-09 12:52:33','2019-02-09 12:52:33',NULL,'6f100bed-10d4-4efe-9ba1-026832c836bc'),
	(23,'Spoon_BlockType','2019-02-09 12:53:05','2019-02-09 12:53:05','2019-02-09 12:53:54','0b36d463-4321-418b-bf6f-6dcdc4ac5c6b'),
	(24,'Spoon_BlockType','2019-02-09 12:53:41','2019-02-09 12:53:41','2019-02-09 12:56:15','36e31252-edc4-4e45-af0d-392b1d4c32fa'),
	(25,'Spoon_BlockType','2019-02-09 12:53:54','2019-02-09 12:53:54','2019-02-09 12:56:29','481535bd-00cd-4b79-b0c1-56fe432e99ae'),
	(26,'Spoon_BlockType','2019-02-09 12:54:18','2019-02-09 12:54:18','2019-02-09 12:55:59','d90dea6c-1185-4943-99ed-e160bd4bc6f0'),
	(27,'Spoon_BlockType','2019-02-09 12:54:41','2019-02-09 12:54:41','2019-02-09 12:55:46','a50575a0-2b30-460c-bb84-15a07f37a2e6'),
	(28,'Spoon_BlockType','2019-02-09 12:55:26','2019-02-09 12:55:26',NULL,'a101b9e9-d048-4b15-b917-10cc9de68893'),
	(29,'Spoon_BlockType','2019-02-09 12:55:46','2019-02-09 12:55:46',NULL,'13056dc4-3591-41dd-bf31-dc29c34690d0'),
	(30,'Spoon_BlockType','2019-02-09 12:55:59','2019-02-09 12:55:59',NULL,'70cd2adf-89fc-4f51-a684-ba50065fe139'),
	(31,'Spoon_BlockType','2019-02-09 12:56:15','2019-02-09 12:56:15','2019-02-09 13:02:31','32a9336a-506e-4d1d-bbdf-3d569c313289'),
	(32,'Spoon_BlockType','2019-02-09 12:56:29','2019-02-09 12:56:29',NULL,'2c07d09d-8951-47ca-9e2c-82b9852f73af'),
	(33,'Spoon_BlockType','2019-02-09 12:58:07','2019-02-09 12:58:07',NULL,'d09dcc20-54fa-4517-99ff-0f5fd3fb6d62'),
	(34,'Spoon_BlockType','2019-02-09 12:58:48','2019-02-09 12:58:48',NULL,'6ff96399-2c4f-4344-965c-71ee5ad34e24'),
	(35,'Spoon_BlockType','2019-02-09 12:59:17','2019-02-09 12:59:17',NULL,'dbddfcfb-d7b9-479c-853b-3c43aeedc2e3'),
	(36,'Spoon_BlockType','2019-02-09 12:59:56','2019-02-09 12:59:56',NULL,'7791c139-c568-48d9-a6bd-5d45d3471f59'),
	(37,'Spoon_BlockType','2019-02-09 13:02:31','2019-02-09 13:02:31',NULL,'8f46b283-6a1b-4dce-83ad-3b2affba54eb');

/*!40000 ALTER TABLE `pt_fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_fieldlayouttabs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_fieldlayouttabs`;

CREATE TABLE `pt_fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `pt_fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `pt_fieldlayouttabs` DISABLE KEYS */;

INSERT INTO `pt_fieldlayouttabs` (`id`, `layoutId`, `name`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(5,2,'Complex Content',1,'2018-11-06 19:48:17','2018-11-06 19:48:17','7fa25098-b49a-47c8-8b0d-11b7273afd5c'),
	(401,14,'Content',1,'2018-11-29 19:01:53','2018-11-29 19:01:53','3217c00a-ea3c-4d37-82c5-f3d6bae413b4'),
	(726,21,'Settings',1,'2019-02-09 12:51:07','2019-02-09 12:51:07','b3fc54ec-6cca-4927-8029-6528ee18f594'),
	(727,21,'Custom Background Options',2,'2019-02-09 12:51:07','2019-02-09 12:51:07','2413b5dc-455b-4b75-95ee-c66017744e80'),
	(728,21,'Spacing',3,'2019-02-09 12:51:07','2019-02-09 12:51:07','d719cc6c-6923-4eb2-bd4d-5ec7e198d418'),
	(729,22,'Settings',1,'2019-02-09 12:52:33','2019-02-09 12:52:33','1d98bc99-3b3a-40c6-8a2d-053f0b29b8f7'),
	(730,22,'Colum Settings',2,'2019-02-09 12:52:33','2019-02-09 12:52:33','3608742b-9277-4f67-ab0c-0a1f5170ee9c'),
	(731,22,'Padding',3,'2019-02-09 12:52:33','2019-02-09 12:52:33','eefaa08c-3b66-4de4-a873-39008200c11e'),
	(732,23,'Settings',1,'2019-02-09 12:53:05','2019-02-09 12:53:05','d0f544ec-b325-4cee-84de-41b8f5db107a'),
	(733,23,'Spacing',2,'2019-02-09 12:53:05','2019-02-09 12:53:05','f0c7535b-0bde-40d7-be32-9f42bdcc6f9c'),
	(734,24,'Content',1,'2019-02-09 12:53:41','2019-02-09 12:53:41','d1a33bbd-5e8a-4eeb-996a-924395994d9d'),
	(735,24,'Spacing',2,'2019-02-09 12:53:41','2019-02-09 12:53:41','76366d20-63bf-46e6-a6d6-96cc97d9d6e3'),
	(736,25,'Content',1,'2019-02-09 12:53:54','2019-02-09 12:53:54','3bf67f2b-dad0-4b45-9718-244c1d0fbb47'),
	(737,25,'Spacing',2,'2019-02-09 12:53:54','2019-02-09 12:53:54','403bf80c-bd66-4e24-bd27-57bcf86caa7c'),
	(738,26,'Content',1,'2019-02-09 12:54:18','2019-02-09 12:54:18','2a9ff5c5-106c-4997-8cf9-dda544a2f10d'),
	(739,26,'Spacing',2,'2019-02-09 12:54:18','2019-02-09 12:54:18','cebfc289-b77b-431e-af43-faba6edb2ea2'),
	(740,27,'Content',1,'2019-02-09 12:54:41','2019-02-09 12:54:41','33812aff-b486-42d6-83b5-687c230d9e06'),
	(741,27,'Spacing',2,'2019-02-09 12:54:41','2019-02-09 12:54:41','d0a1b086-d7c4-4c78-b0e7-1eac82edc175'),
	(742,28,'Content',1,'2019-02-09 12:55:26','2019-02-09 12:55:26','0d4b9d92-eb5b-4f03-85ce-bd238fae253d'),
	(743,28,'Content Settings',2,'2019-02-09 12:55:26','2019-02-09 12:55:26','bba12c6d-83b4-4831-a115-26f3654f4c0e'),
	(744,28,'Spacing',3,'2019-02-09 12:55:26','2019-02-09 12:55:26','c416dffd-3a0a-4009-908b-595908cdc621'),
	(745,29,'Content',1,'2019-02-09 12:55:46','2019-02-09 12:55:46','164929d0-69a8-4b84-8842-878c9718c03c'),
	(746,29,'Content Settings',2,'2019-02-09 12:55:46','2019-02-09 12:55:46','f476d484-e13d-4843-9f8f-1fc696c3b7bf'),
	(747,29,'Spacing',3,'2019-02-09 12:55:46','2019-02-09 12:55:46','c4118586-80f4-4df7-b596-e54652d3ea6a'),
	(748,30,'Content',1,'2019-02-09 12:55:59','2019-02-09 12:55:59','95381a5e-29a8-4f68-98f6-a7280f407e28'),
	(749,30,'Content Settings',2,'2019-02-09 12:55:59','2019-02-09 12:55:59','7e774abf-ecf5-4cae-bef1-4c6365f98cda'),
	(750,30,'Spacing',3,'2019-02-09 12:55:59','2019-02-09 12:55:59','7e6c1288-cefc-49bc-95e1-b92321a2c083'),
	(751,31,'Content',1,'2019-02-09 12:56:15','2019-02-09 12:56:15','52f130eb-bc46-480a-9432-89a78dffe9e9'),
	(752,31,'Content Settings',2,'2019-02-09 12:56:15','2019-02-09 12:56:15','df34d7cb-c280-461f-a9fb-4fccfb68ce22'),
	(753,31,'Spacing',3,'2019-02-09 12:56:15','2019-02-09 12:56:15','35aa0ecd-e3db-455c-ad18-19edb729441f'),
	(754,32,'Content',1,'2019-02-09 12:56:29','2019-02-09 12:56:29','97bf0ffd-961b-4974-8c2c-44fb58da0ca9'),
	(755,32,'Content Settings',2,'2019-02-09 12:56:29','2019-02-09 12:56:29','7575cb7d-85c5-4e9e-9cd9-ef8d1cfae49d'),
	(756,32,'Spacing',3,'2019-02-09 12:56:29','2019-02-09 12:56:29','53774795-b3ca-4458-ae9e-1bbb9a7a208e'),
	(757,33,'Content',1,'2019-02-09 12:58:07','2019-02-09 12:58:07','4df6e564-6b24-4cbc-952a-f9f1c6489a13'),
	(758,33,'Image Settings',2,'2019-02-09 12:58:07','2019-02-09 12:58:07','76f173a1-9864-4add-93dd-8e6bb60d4738'),
	(759,33,'Spacing',3,'2019-02-09 12:58:07','2019-02-09 12:58:07','4dd1d28d-3eeb-424a-8397-f06654d8b733'),
	(760,34,'Content',1,'2019-02-09 12:58:48','2019-02-09 12:58:48','ad685d4c-910d-48d9-81fe-5d4282c2c237'),
	(761,34,'Gallery Settings',2,'2019-02-09 12:58:48','2019-02-09 12:58:48','88953ec0-3b53-47b2-8bc1-32236aaea4fd'),
	(762,34,'Spacing',3,'2019-02-09 12:58:48','2019-02-09 12:58:48','15d50398-456e-4bc4-9e57-13c5285064ee'),
	(763,35,'Content',1,'2019-02-09 12:59:17','2019-02-09 12:59:17','34ad9a25-1dc3-44de-b611-4e057cc719bc'),
	(764,35,'Content Settings',2,'2019-02-09 12:59:17','2019-02-09 12:59:17','901d11cc-7f59-4a6b-bee0-3a219524576f'),
	(765,35,'Spacing',3,'2019-02-09 12:59:17','2019-02-09 12:59:17','27abb1ea-1819-4f71-b103-8c0c0ff9c8e4'),
	(766,36,'Content',1,'2019-02-09 12:59:56','2019-02-09 12:59:56','5f2aba63-164a-46d2-98eb-6c190c8fa041'),
	(767,36,'Form Settings',2,'2019-02-09 12:59:56','2019-02-09 12:59:56','58a4c712-8ff3-4438-8dfe-db5d483e317c'),
	(768,36,'Spacing',3,'2019-02-09 12:59:56','2019-02-09 12:59:56','5b65b855-a605-4242-8e62-3d218011f135'),
	(784,37,'Content',1,'2019-02-09 13:02:31','2019-02-09 13:02:31','d65be4db-a3e1-434f-acb8-f78e21139751'),
	(785,37,'Content Settings',2,'2019-02-09 13:02:31','2019-02-09 13:02:31','4f60e08d-065b-4c07-90d7-f27ea520668b'),
	(786,37,'Spacing',3,'2019-02-09 13:02:31','2019-02-09 13:02:31','86cb14d5-c2a8-42fa-a531-5ee8cec3570e'),
	(787,3,'Content',1,'2019-02-09 13:08:19','2019-02-09 13:08:19','e9f8a338-2e23-412c-9665-42eb77753c31'),
	(788,7,'Content',1,'2019-02-09 13:08:19','2019-02-09 13:08:19','72ce38cd-9494-4416-9b84-b53db8627577'),
	(789,8,'Content',1,'2019-02-09 13:08:19','2019-02-09 13:08:19','e61a3c4f-e94d-42f4-907b-989a799c39dd'),
	(790,6,'Content',1,'2019-02-09 13:08:20','2019-02-09 13:08:20','d8c17e80-3858-49bc-a1d6-e5c326cfbdb7'),
	(791,9,'Content',1,'2019-02-09 13:08:20','2019-02-09 13:08:20','a6b91ba2-652e-44f2-b229-5a6ce072f775'),
	(792,10,'Content',1,'2019-02-09 13:08:20','2019-02-09 13:08:20','6ddefcf0-9e1e-4711-b466-ccb1754c1b78'),
	(793,11,'Content',1,'2019-02-09 13:08:21','2019-02-09 13:08:21','fa0742a5-359c-45e2-954b-6ff4bbf23653'),
	(794,12,'Content',1,'2019-02-09 13:08:21','2019-02-09 13:08:21','25fe014e-3374-4727-8bde-c7fd6ea0dcc2'),
	(795,13,'Content',1,'2019-02-09 13:08:21','2019-02-09 13:08:21','38bc0631-77d2-4ed4-945f-06ecc37333c6'),
	(796,15,'Content',1,'2019-02-09 13:08:21','2019-02-09 13:08:21','a36ca66c-78e2-444d-b154-f5e311e2ba22'),
	(797,16,'Content',1,'2019-02-09 13:08:22','2019-02-09 13:08:22','4f3a2d42-0106-4836-ab50-042275145d16'),
	(798,17,'Content',1,'2019-02-09 13:08:22','2019-02-09 13:08:22','e42d2bdf-028d-4899-be3e-61dd07d27f98'),
	(799,18,'Content',1,'2019-02-09 13:08:22','2019-02-09 13:08:22','e2994c6d-e42a-4bcf-880b-f282202b41bb'),
	(800,19,'Content',1,'2019-02-09 13:08:22','2019-02-09 13:08:22','c079e1c1-f3f2-4dd4-8a6b-5380ce920cbd'),
	(801,20,'Content',1,'2019-02-09 13:08:23','2019-02-09 13:08:23','c33a217b-2dcf-465c-ab3c-abdf629b5736');

/*!40000 ALTER TABLE `pt_fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_fields`;

CREATE TABLE `pt_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `pt_fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_fields` WRITE;
/*!40000 ALTER TABLE `pt_fields` DISABLE KEYS */;

INSERT INTO `pt_fields` (`id`, `groupId`, `name`, `handle`, `context`, `instructions`, `searchable`, `translationMethod`, `translationKeyFormat`, `type`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'Complex Content','cc','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"contentTable\":\"{{%matrixcontent_cc}}\",\"localizeBlocks\":false}','2018-11-06 19:29:37','2019-02-09 13:08:19','d1fe1a49-a8bf-46ab-ac74-d563effe3be7'),
	(3,NULL,'Background Color','backgroundColor','matrixBlockType:9c7038b3-900d-4b50-a5ee-7c445a476f87','Please select this sections background color.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"White\",\"value\":\"-base-background\",\"default\":\"1\"},{\"label\":\"Off White\",\"value\":\"-secondary-background\",\"default\":\"\"},{\"label\":\"Off Black\",\"value\":\"-dark-background\",\"default\":\"\"},{\"label\":\"Brand\",\"value\":\"-brand-background\",\"default\":\"\"}]}','2018-11-06 19:29:37','2019-02-09 13:08:19','fb2fb216-c076-435d-b399-bb0c92cbc106'),
	(4,NULL,'Background Image','backgroundImage','matrixBlockType:9c7038b3-900d-4b50-a5ee-7c445a476f87','Optional background image for the section. This image will override the selected background color.',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add a Background Image\",\"localizeRelations\":false}','2018-11-06 19:29:37','2019-02-09 13:08:19','d3f64f5e-8d98-4cfe-bc55-10e5c2497fff'),
	(5,NULL,'Background Video','backgroundVideo','matrixBlockType:9c7038b3-900d-4b50-a5ee-7c445a476f87','Optional background video for the section. This video will override the selected background color and image.',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:02433cef-1aec-4478-8f75-f5570480c436\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"video\"],\"sources\":[\"volume:02433cef-1aec-4478-8f75-f5570480c436\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add a Background Video\",\"localizeRelations\":false}','2018-11-06 19:35:22','2019-02-09 13:08:19','36459edb-92eb-4e49-b582-883cd750f9fd'),
	(6,NULL,'Copy','copy','matrixBlockType:e99be65c-5fee-4c83-9eed-8050793be42a','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-11-06 19:54:25','2019-02-09 13:08:19','c1466ef0-df37-4a2f-9ecb-82d6e9b3a223'),
	(7,NULL,'Font Size','fontSize','matrixBlockType:e99be65c-5fee-4c83-9eed-8050793be42a','How large should the font be?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Huge\",\"value\":\"o-h1\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"o-h2\",\"default\":\"\"},{\"label\":\"Medium\",\"value\":\"o-h3\",\"default\":\"1\"},{\"label\":\"Small\",\"value\":\"o-h4\",\"default\":\"\"},{\"label\":\"Title\",\"value\":\"o-h5\",\"default\":\"\"},{\"label\":\"Subtitle\",\"value\":\"o-h6\",\"default\":\"\"}]}','2018-11-06 19:54:26','2019-02-09 13:08:19','d6747373-70b8-49ad-82bd-33370282ee35'),
	(8,NULL,'Alignment','alignment','matrixBlockType:e99be65c-5fee-4c83-9eed-8050793be42a','How should the heading be aligned?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Left\",\"value\":\"u-text-left\",\"default\":\"1\"},{\"label\":\"Center\",\"value\":\"u-text-center\",\"default\":\"\"},{\"label\":\"Right\",\"value\":\"u-text-right\",\"default\":\"\"}]}','2018-11-06 19:54:26','2019-02-09 13:08:19','4421109a-d1a4-4e10-b64a-87b84b5a3773'),
	(10,NULL,'Padding Type','paddingType','matrixBlockType:e99be65c-5fee-4c83-9eed-8050793be42a','Select where the additional padding should be applied.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-11-06 19:58:42','2019-02-09 13:08:20','f16ece4b-b4a4-4532-9b03-305f0e107a9d'),
	(11,NULL,'Overlay','overlay','matrixBlockType:9c7038b3-900d-4b50-a5ee-7c445a476f87','Select an optional overlay for your background video or image.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"none\",\"default\":\"1\"},{\"label\":\"Light\",\"value\":\"35,35,35,0.33\",\"default\":\"\"},{\"label\":\"Medium\",\"value\":\"35,35,35,0.6\",\"default\":\"\"},{\"label\":\"Dark\",\"value\":\"35,35,35,0.87\",\"default\":\"\"}]}','2018-11-06 20:10:38','2019-02-09 13:08:19','c043d1ea-bbda-4790-9b09-ca031caf54d4'),
	(14,NULL,'Width','width','matrixBlockType:27f153c6-09ef-408c-a85b-50ee37263d52','How wide should this sections container be?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Normal\",\"value\":\"o-container\",\"default\":\"\"},{\"label\":\"Narrow\",\"value\":\"o-container-narrow\",\"default\":\"\"},{\"label\":\"Full\",\"value\":\"o-container-full\",\"default\":\"\"}]}','2018-11-07 13:26:27','2019-02-09 13:08:19','bbe771e9-89c0-4471-936a-5ebecf254b9b'),
	(15,NULL,'Column Layout','columnLayout','matrixBlockType:27f153c6-09ef-408c-a85b-50ee37263d52','Please select a column layout pattern.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Whole\",\"value\":\"1\",\"default\":\"1\"},{\"label\":\"Halves\",\"value\":\"2\",\"default\":\"\"},{\"label\":\"Thirds\",\"value\":\"3\",\"default\":\"\"},{\"label\":\"1/3 & 2/3\",\"value\":\"4\",\"default\":\"\"},{\"label\":\"2/3 & 1/3\",\"value\":\"5\",\"default\":\"\"}]}','2018-11-07 13:26:27','2019-02-09 13:08:19','a74d8612-5ca0-4325-9e7a-903893117219'),
	(16,NULL,'Column Gutter','columnGutter','matrixBlockType:27f153c6-09ef-408c-a85b-50ee37263d52','How large of a gap between columns do you want?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-gutter-none\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"-gutter\",\"default\":\"\"},{\"label\":\"Small\",\"value\":\"-gutter-small\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-gutter-large\",\"default\":\"1\"}]}','2018-11-07 14:16:46','2019-02-09 13:08:19','27da4f8a-238c-4681-b862-712689ec9187'),
	(17,NULL,'Vertical Align','verticalAlign','matrixBlockType:27f153c6-09ef-408c-a85b-50ee37263d52','',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Normal\",\"value\":\"-align-top\",\"default\":\"1\"},{\"label\":\"Middle\",\"value\":\"-align-center\",\"default\":\"\"},{\"label\":\"Bottom\",\"value\":\"-align-end\",\"default\":\"\"}]}','2018-11-20 20:35:00','2019-02-09 13:08:19','0318fd31-af0c-42d5-8f82-bda65318cbd2'),
	(18,NULL,'Body','body','matrixBlockType:d40a8732-c577-4d4a-a737-05fa930be6a2','',1,'none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Complex-Content.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"\",\"availableTransforms\":\"*\"}','2018-11-21 13:02:30','2019-02-09 13:08:20','9d5e8bb8-07be-40ec-803f-8296fa980c92'),
	(19,NULL,'Alignment','alignment','matrixBlockType:d40a8732-c577-4d4a-a737-05fa930be6a2','How should the copy in this block be aligned?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Left\",\"value\":\"u-text-left\",\"default\":\"1\"},{\"label\":\"Center\",\"value\":\"u-text-center\",\"default\":\"\"},{\"label\":\"Right\",\"value\":\"u-text-right\",\"default\":\"\"},{\"label\":\"Justify\",\"value\":\"u-text-justify\",\"default\":\"\"}]}','2018-11-21 13:02:30','2019-02-09 13:08:20','799dbe03-d659-4f0d-8598-926a4ddb37c0'),
	(20,NULL,'Padding Type','paddingType','matrixBlockType:d40a8732-c577-4d4a-a737-05fa930be6a2','Select where the additional padding should be applied.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"1\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-11-21 13:02:30','2019-02-09 13:08:20','d85da825-7ece-4810-af33-232c2cddf7d5'),
	(21,NULL,'Image','image','matrixBlockType:8cfe5e31-20a9-4ddc-ba3d-790f1b405450','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add an Image\",\"localizeRelations\":false}','2018-11-21 13:26:58','2019-02-09 13:08:20','34b63d30-e96e-4923-8396-7f331ac44ccd'),
	(22,NULL,'Aspect Ratio','aspectRatio','matrixBlockType:8cfe5e31-20a9-4ddc-ba3d-790f1b405450','',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"16:9\",\"value\":\"u-ratio-16/9\",\"default\":\"1\"},{\"label\":\"1:1\",\"value\":\"u-ratio-1/1\",\"default\":\"\"},{\"label\":\"4:3\",\"value\":\"u-ratio-4/3\",\"default\":\"\"},{\"label\":\"2:3\",\"value\":\"u-ratio-2/3\",\"default\":\"\"},{\"label\":\"Banner\",\"value\":\"u-ratio-36/10\",\"default\":\"\"},{\"label\":\"None\",\"value\":\"none\",\"default\":\"\"}]}','2018-11-21 13:26:58','2019-02-09 13:08:20','d81bf538-6c2f-47cb-a776-ffda5ecb3da1'),
	(23,NULL,'Padding Type','paddingType','matrixBlockType:8cfe5e31-20a9-4ddc-ba3d-790f1b405450','Select where the additional padding should be applied.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-11-21 13:26:58','2019-02-09 13:08:20','efaf6859-2c1a-4909-bc9e-38bd725624ec'),
	(24,NULL,'Enable Lightcase','enableLightcase','matrixBlockType:8cfe5e31-20a9-4ddc-ba3d-790f1b405450','When enabled users can click on the image to view a larger version of the image in a popup modal.',1,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"\"}','2018-11-21 13:26:58','2019-02-09 13:08:20','89593cd3-f8b6-4c0d-9060-e2e0eb2dde8e'),
	(25,NULL,'Overlay','overlay','matrixBlockType:8cfe5e31-20a9-4ddc-ba3d-790f1b405450','Select an optional overlay color for your image.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"none\",\"default\":\"1\"},{\"label\":\"Light\",\"value\":\"35,35,35,0.33\",\"default\":\"\"},{\"label\":\"Medium\",\"value\":\"35,35,35,0.6\",\"default\":\"\"},{\"label\":\"Dark\",\"value\":\"35,35,35,0.87\",\"default\":\"\"},{\"label\":\"Red\",\"value\":\"242,86,82,0.6\",\"default\":\"\"}]}','2018-11-21 13:26:58','2019-02-09 13:08:20','a23aaf6c-855c-4031-b283-e5076716fa3a'),
	(28,NULL,'Padding Type','paddingType','matrixBlockType:9c7038b3-900d-4b50-a5ee-7c445a476f87','Select where the additional padding should be applied.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"1\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"}]}','2018-11-27 13:19:20','2019-02-09 13:08:19','af04a3f1-22e2-4182-a22d-c6a44383b788'),
	(29,NULL,'Padding Size','paddingSize','matrixBlockType:e99be65c-5fee-4c83-9eed-8050793be42a','Add additional padding to this block.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Quarter\",\"value\":\"-quarter\",\"default\":\"\"},{\"label\":\"Half\",\"value\":\"-half\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"x2\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"x4\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-11-27 13:19:20','2019-02-09 13:08:19','93f6127f-2098-4d92-89a9-6c353bb22799'),
	(30,NULL,'Padding Size','paddingSize','matrixBlockType:d40a8732-c577-4d4a-a737-05fa930be6a2','Add additional padding to this block.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Quarter\",\"value\":\"-quarter\",\"default\":\"\"},{\"label\":\"Hafl\",\"value\":\"-half\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"x2\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"x4\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-11-27 13:32:54','2019-02-09 13:08:20','46892785-d8f7-443a-9215-a6fbbfc2e066'),
	(31,NULL,'Padding Size','paddingSize','matrixBlockType:8cfe5e31-20a9-4ddc-ba3d-790f1b405450','Add additional padding to this block.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Quarter\",\"value\":\"-quarter\",\"default\":\"\"},{\"label\":\"Half\",\"value\":\"-half\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"x2\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"x4\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-11-27 13:32:54','2019-02-09 13:08:20','71df45f7-bad9-4989-8d4b-8e056b6e712a'),
	(33,NULL,'Crop Zoom','cropZoom','matrixBlockType:8cfe5e31-20a9-4ddc-ba3d-790f1b405450','',1,'none',NULL,'craft\\fields\\Number','{\"defaultValue\":\"1\",\"min\":\"1\",\"max\":\"3\",\"decimals\":\"2\",\"size\":null}','2018-11-27 14:32:43','2019-02-09 13:08:20','33b35b3f-2dee-492a-b10e-ae7ef65688f9'),
	(34,NULL,'Image Width','imageWidth','matrixBlockType:8cfe5e31-20a9-4ddc-ba3d-790f1b405450','',1,'none',NULL,'craft\\fields\\Number','{\"defaultValue\":\"840\",\"min\":\"250\",\"max\":\"1920\",\"decimals\":0,\"size\":null}','2018-11-27 14:39:05','2019-02-09 13:08:20','1393ae5b-e051-4f54-9c23-fea61b8ef0fe'),
	(35,NULL,'Grayscale','grayscale','matrixBlockType:8cfe5e31-20a9-4ddc-ba3d-790f1b405450','Enable to convert the image to grayscale.',1,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"\"}','2018-11-27 15:23:01','2019-02-09 13:08:20','a5c58651-f39a-4384-a7c6-28ad2390f2e9'),
	(36,NULL,'Padding Type','paddingType','matrixBlockType:27f153c6-09ef-408c-a85b-50ee37263d52','Select where the additional padding should be applied.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"1\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"}]}','2018-11-27 16:34:59','2019-02-09 13:08:19','4c98e4da-8268-4e63-be65-60c159ffde69'),
	(37,NULL,'Padding Size','paddingSize','matrixBlockType:27f153c6-09ef-408c-a85b-50ee37263d52','Add additional padding to this block.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"x2\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"x4\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-11-28 16:58:20','2019-02-09 13:08:19','a8818a76-5083-4143-95ac-e666c321a091'),
	(38,NULL,'Padding Size','paddingSize','matrixBlockType:9c7038b3-900d-4b50-a5ee-7c445a476f87','Add additional padding to this block.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x4\",\"default\":\"1\"},{\"label\":\"Huge\",\"value\":\"-x6\",\"default\":\"\"},{\"label\":\"Massive\",\"value\":\"-x8\",\"default\":\"\"}]}','2018-11-28 17:47:23','2019-02-09 13:08:19','d939cdb6-5f72-48ee-b805-f16dde284b4a'),
	(39,NULL,'Buttons','buttons','matrixBlockType:86843e26-821b-41e7-8e3e-87321802c139','Add call to action buttons.',1,'site',NULL,'verbb\\supertable\\fields\\SuperTableField','{\"minRows\":\"1\",\"maxRows\":\"3\",\"contentTable\":\"{{%stc_7_buttons}}\",\"localizeBlocks\":false,\"staticField\":\"\",\"columns\":{\"40\":{\"width\":\"\"},\"41\":{\"width\":\"\"}},\"fieldLayout\":\"matrix\",\"selectionLabel\":\"Add a Button\"}','2018-11-28 19:07:47','2019-02-09 13:08:20','16afd3ef-94de-4db2-87a1-26b358f4aa61'),
	(40,NULL,'Link','buttonLink','superTableBlockType:e1d8381e-e9da-4f7a-897a-7ca3280e4deb','Where should the button take the user?',1,'none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"1\",\"allowedLinkNames\":{\"1\":\"asset\",\"2\":\"category\",\"3\":\"entry\",\"6\":\"custom\",\"7\":\"email\",\"8\":\"tel\",\"9\":\"url\"},\"allowTarget\":\"1\",\"autoNoReferrer\":\"\",\"defaultLinkName\":\"entry\",\"defaultText\":\"\",\"enableAriaLabel\":\"\",\"enableTitle\":\"\",\"typeSettings\":{\"asset\":{\"sources\":\"*\",\"allowCustomQuery\":\"\"},\"category\":{\"sources\":\"*\",\"allowCustomQuery\":\"\"},\"entry\":{\"sources\":\"*\",\"allowCustomQuery\":\"\"},\"site\":{\"sites\":\"*\"},\"user\":{\"sources\":\"*\",\"allowCustomQuery\":\"\"},\"custom\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"email\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"tel\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"url\":{\"disableValidation\":\"\",\"allowAliases\":\"\"}}}','2018-11-28 19:07:47','2019-02-09 13:08:21','42cf42aa-aed4-47d0-b3f9-8ee81b134df4'),
	(41,NULL,'Button Style','buttonStyle','superTableBlockType:e1d8381e-e9da-4f7a-897a-7ca3280e4deb','How should the button look?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Basic Action Button\",\"value\":\"-base\",\"default\":\"1\"},{\"label\":\"Solid Style Button\",\"value\":\"-solid\",\"default\":\"\"},{\"label\":\"Outline Style Button\",\"value\":\"-outline\",\"default\":\"\"},{\"label\":\"Raised Style Button\",\"value\":\"-raised\",\"default\":\"\"},{\"label\":\"Rounded Solid Style Button\",\"value\":\"-solid -round\",\"default\":\"\"},{\"label\":\"Rounded Outline Style Button\",\"value\":\"-outline -round\",\"default\":\"\"}]}','2018-11-28 19:07:47','2019-02-09 13:08:21','ee572988-84e1-46e8-8b29-c23ce20bac43'),
	(42,NULL,'Alignment','alignment','matrixBlockType:86843e26-821b-41e7-8e3e-87321802c139','How should the buttons be aligned?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Left Aligned\",\"value\":\"\",\"default\":\"1\"},{\"label\":\"Center Aligned\",\"value\":\"-justify-center\",\"default\":\"\"},{\"label\":\"Right Aligned\",\"value\":\"-justify-end\",\"default\":\"\"},{\"label\":\"Space Between\",\"value\":\"-space-between\",\"default\":\"\"},{\"label\":\"Space Around\",\"value\":\"-space-around\",\"default\":\"\"}]}','2018-11-28 19:14:56','2019-02-09 13:08:21','972a946c-797a-4f9c-8681-aaa29ef67856'),
	(43,NULL,'Padding Size','paddingSize','matrixBlockType:86843e26-821b-41e7-8e3e-87321802c139','Add additional padding to this block.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Quarter\",\"value\":\"-quarter\",\"default\":\"\"},{\"label\":\"Half\",\"value\":\"-half\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"x2\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"x4\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-11-28 19:14:56','2019-02-09 13:08:21','afa0d0fd-406e-4d41-9c96-e5f5d59b058f'),
	(44,NULL,'Padding Type','paddingType','matrixBlockType:86843e26-821b-41e7-8e3e-87321802c139','Select where the additional padding should be applied.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"1\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Buttom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-11-28 19:14:56','2019-02-09 13:08:21','1d7cea56-a8d6-4502-874c-779e624b3bf5'),
	(45,NULL,'Image Alignment','imageAlignment','matrixBlockType:8cfe5e31-20a9-4ddc-ba3d-790f1b405450','Align applied to images with an Aspect Ratio of None.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Left\",\"value\":\"u-text-left\",\"default\":\"\"},{\"label\":\"Center\",\"value\":\"u-text-center\",\"default\":\"1\"},{\"label\":\"Right\",\"value\":\"u-text-right\",\"default\":\"\"}]}','2018-11-29 13:19:25','2019-02-09 13:08:20','ab8da4d3-dc99-4cb3-a978-347132b072ca'),
	(46,NULL,'Body','body','matrixBlockType:42b013df-72dc-41a5-941f-d7a299502e38','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-11-29 13:45:52','2019-02-09 13:08:21','71e1aa18-0063-405d-955e-74b5ec1514b2'),
	(47,NULL,'Source','source','matrixBlockType:42b013df-72dc-41a5-941f-d7a299502e38','Optional source or author for the quote.',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-11-29 13:45:52','2019-02-09 13:08:21','cbdbc09b-11a0-4b1a-a0bd-5b991c3c75eb'),
	(48,NULL,'Padding Size','paddingSize','matrixBlockType:42b013df-72dc-41a5-941f-d7a299502e38','Add additional padding to this block.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Quarter\",\"value\":\"-quarter\",\"default\":\"\"},{\"label\":\"Half\",\"value\":\"-half\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"x2\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"x4\",\"value\":\"-x4\",\"default\":\"\"},{\"label\":\"x6\",\"value\":\"-x6\",\"default\":\"\"}]}','2018-11-29 13:45:52','2019-02-09 13:08:21','ebbd92ad-ec15-4d07-ae91-eccbb307569b'),
	(49,NULL,'Padding Type','paddingType','matrixBlockType:42b013df-72dc-41a5-941f-d7a299502e38','Select where the additional padding should be applied.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"1\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-11-29 13:45:52','2019-02-09 13:08:21','f544af32-b279-49f9-9fa4-60c1d0391b85'),
	(50,NULL,'Quote Style','quoteStyle','matrixBlockType:42b013df-72dc-41a5-941f-d7a299502e38','Select a quote block style.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Large\",\"value\":\"-large\",\"default\":\"1\"},{\"label\":\"Block\",\"value\":\"-block\",\"default\":\"\"}]}','2018-11-29 14:19:38','2019-02-09 13:08:21','984c9a76-6153-41af-9f4b-fbff36a88709'),
	(51,NULL,'Slides','slides','matrixBlockType:411496be-9759-4334-803e-790121fdee23','Add slides to the gallery.',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"\",\"selectionLabel\":\"Add an Image\",\"localizeRelations\":false}','2018-11-29 16:00:58','2019-02-09 13:08:21','00ccd03b-0a70-4fed-a14d-a0b846ecad51'),
	(52,NULL,'Image','image','superTableBlockType:bf867548-c6c8-4312-9ff6-501f221c53e8','Select or upload an image.',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"folder:eb2dafb2-9954-4850-9d47-56e2e80f3880\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:eb2dafb2-9954-4850-9d47-56e2e80f3880\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add an Image\",\"localizeRelations\":false}','2018-11-29 16:00:58','2018-11-29 19:01:53','c4dc3d58-6669-4037-840c-bc6369b067a3'),
	(53,NULL,'Padding Size','paddingSize','matrixBlockType:411496be-9759-4334-803e-790121fdee23','Add additional padding to this block.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Quarter\",\"value\":\"-quarter\",\"default\":\"\"},{\"label\":\"Half\",\"value\":\"-half\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"x2\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"x4\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-11-29 16:00:58','2019-02-09 13:08:21','0bf2b1b8-e3d3-47f7-bc51-628bd536b65c'),
	(54,NULL,'Padding Type','paddingType','matrixBlockType:411496be-9759-4334-803e-790121fdee23','Select where the additional padding should be applied.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"1\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-11-29 16:00:58','2019-02-09 13:08:21','418c41b9-d777-4c60-b660-7f8421a7f12d'),
	(55,NULL,'Slide Transition','slideTransition','matrixBlockType:411496be-9759-4334-803e-790121fdee23','Select how fast the slides transition. Setting this option to manual forces the user initiate the transition.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Manual\",\"value\":\"-1\",\"default\":\"1\"},{\"label\":\"Slow\",\"value\":\"12\",\"default\":\"\"},{\"label\":\"Medium\",\"value\":\"7\",\"default\":\"\"},{\"label\":\"Fast\",\"value\":\"5\",\"default\":\"\"}]}','2018-11-29 16:00:58','2019-02-09 13:08:21','f40a44dd-80c9-41bd-92f8-11ea5934e78d'),
	(56,NULL,'Style','style','matrixBlockType:411496be-9759-4334-803e-790121fdee23','Select a gallery style.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Fade\",\"value\":\"fade\",\"default\":\"1\"},{\"label\":\"Slide\",\"value\":\"slide\",\"default\":\"\"},{\"label\":\"Stack\",\"value\":\"stack\",\"default\":\"\"},{\"label\":\"Parallax\",\"value\":\"parallax\",\"default\":\"\"}]}','2018-11-29 16:00:58','2019-02-09 13:08:21','0ed585b2-9d94-4ebc-a088-f12f4474ecf4'),
	(57,NULL,'Aspect Ratio','aspectRatio','matrixBlockType:411496be-9759-4334-803e-790121fdee23','Select the galleries aspect ratio.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"1:1\",\"value\":\"u-ratio-1/1\",\"default\":\"1\"},{\"label\":\"2:3\",\"value\":\"u-ratio-2/3\",\"default\":\"\"},{\"label\":\"16:9\",\"value\":\"u-ratio-16/9\",\"default\":\"\"}]}','2018-11-29 16:00:58','2019-02-09 13:08:21','3b24986d-c663-48f7-86ca-a778bebbcd82'),
	(58,NULL,'Headline','headline','superTableBlockType:bf867548-c6c8-4312-9ff6-501f221c53e8','Optional headline. Not use on every style.',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"120\",\"columnType\":\"text\"}','2018-11-29 18:37:00','2018-11-29 19:01:53','c4ef4072-bd1f-4447-8f21-b05a86657c4f'),
	(59,NULL,'Body','body','superTableBlockType:bf867548-c6c8-4312-9ff6-501f221c53e8','Optional body copy. Not use on every style.',1,'none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Complex-Content.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"\",\"availableTransforms\":\"*\"}','2018-11-29 18:37:00','2019-01-30 12:23:09','2ffc941a-e160-475b-af3f-66b7b9f49ff2'),
	(60,NULL,'Rows','rows','matrixBlockType:2cb049e6-b35a-4271-8861-0bbde459b042','',1,'site',NULL,'verbb\\supertable\\fields\\SuperTableField','{\"minRows\":\"\",\"maxRows\":\"\",\"contentTable\":\"{{%stc_10_rows}}\",\"localizeBlocks\":false,\"staticField\":\"\",\"columns\":{\"61\":{\"width\":\"\"},\"62\":{\"width\":\"\"},\"71\":{\"width\":\"\"},\"72\":{\"width\":\"\"},\"73\":{\"width\":\"\"}},\"fieldLayout\":\"row\",\"selectionLabel\":\"\"}','2018-12-07 12:52:41','2019-02-09 13:08:21','89bb2fb3-11df-43a8-bc0e-dc9282624357'),
	(61,NULL,'Heading','heading','superTableBlockType:061368e4-5312-4599-93a2-c40f7165b4b6','What is the heading for this row?',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"32\",\"columnType\":\"text\"}','2018-12-07 12:52:41','2019-02-09 13:08:21','c7b72005-a498-41f9-979d-67d815d408e3'),
	(62,NULL,'Body','body','superTableBlockType:061368e4-5312-4599-93a2-c40f7165b4b6','Copy for the row.',1,'none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Basic.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"\",\"availableTransforms\":\"*\"}','2018-12-07 12:52:41','2019-02-09 13:08:22','a255042b-ffbc-48c6-87b5-dff502c8251d'),
	(63,NULL,'Padding Size','paddingSize','matrixBlockType:2cb049e6-b35a-4271-8861-0bbde459b042','Add additional padding to this block.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Quarter\",\"value\":\"-quarter\",\"default\":\"\"},{\"label\":\"Half\",\"value\":\"-half\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"x2\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"x4\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-12-07 12:52:42','2019-02-09 13:08:22','5842ae73-b069-45a3-b28a-0149781ddbea'),
	(64,NULL,'Padding Type','paddingType','matrixBlockType:2cb049e6-b35a-4271-8861-0bbde459b042','Select where the additional padding should be applied.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"1\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Buttom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-12-07 12:52:42','2019-02-09 13:08:22','b5e83c8a-e3ac-4e7f-aa5b-ae31369fe8b2'),
	(65,NULL,'List Items','listItems','matrixBlockType:3bf9043f-ddd4-4d72-b83d-c984f46fdecf','',1,'site',NULL,'verbb\\supertable\\fields\\SuperTableField','{\"minRows\":\"1\",\"maxRows\":\"\",\"contentTable\":\"{{%stc_11_listitems}}\",\"localizeBlocks\":false,\"staticField\":\"\",\"columns\":{\"66\":{\"width\":\"\"}},\"fieldLayout\":\"row\",\"selectionLabel\":\"\"}','2018-12-07 17:24:19','2019-02-09 13:08:22','9fcae5d9-54cc-4ce1-9ade-6fa31442abf1'),
	(66,NULL,'Item','item','superTableBlockType:326dbc91-cc61-404b-ad31-73f972c6e3de','',1,'none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Basic.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"\",\"availableTransforms\":\"*\"}','2018-12-07 17:24:19','2019-02-09 13:08:22','fc1bf467-a95f-4dff-99b8-b2e3ccb556d5'),
	(67,NULL,'Padding Size','paddingSize','matrixBlockType:3bf9043f-ddd4-4d72-b83d-c984f46fdecf','Add additional padding to this block.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Quarter\",\"value\":\"-quarter\",\"default\":\"\"},{\"label\":\"Half\",\"value\":\"-half\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"x2\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"x4\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-12-07 17:24:19','2019-02-09 13:08:22','0c87ae8e-ce72-414a-8f65-38af1031d8bc'),
	(68,NULL,'Padding Type','paddingType','matrixBlockType:3bf9043f-ddd4-4d72-b83d-c984f46fdecf','Select where the additional padding should be applied.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"1\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-12-07 17:24:19','2019-02-09 13:08:22','de8d5f7b-33fb-44be-b39a-2eab11dc3b9f'),
	(69,NULL,'Alignment','alignment','matrixBlockType:3bf9043f-ddd4-4d72-b83d-c984f46fdecf','',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Left\",\"value\":\"u-text-left\",\"default\":\"1\"},{\"label\":\"Center\",\"value\":\"u-text-center\",\"default\":\"\"},{\"label\":\"Right\",\"value\":\"u-text-right\",\"default\":\"\"}]}','2018-12-07 17:46:02','2019-02-09 13:08:22','fd4b318a-37e0-4db3-b40c-bb76badfae2e'),
	(70,NULL,'List Style','listStyle','matrixBlockType:3bf9043f-ddd4-4d72-b83d-c984f46fdecf','Select a style for the list.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Default\",\"value\":\"-default\",\"default\":\"1\"},{\"label\":\"Plus\",\"value\":\"-plus\",\"default\":\"\"}]}','2018-12-07 17:49:25','2019-02-09 13:08:22','462274cc-3cdd-49e8-83f2-c197f47959e8'),
	(71,NULL,'List','list','superTableBlockType:061368e4-5312-4599-93a2-c40f7165b4b6','Optional list element for the row. The list will be placed below any body copy.',1,'none',NULL,'craft\\fields\\Table','{\"addRowLabel\":\"Add a List Item\",\"maxRows\":\"18\",\"minRows\":\"0\",\"columns\":{\"col1\":{\"heading\":\"List Item\",\"handle\":\"listItem\",\"width\":\"\",\"type\":\"singleline\"}},\"defaults\":[],\"columnType\":\"text\"}','2018-12-07 18:04:27','2019-02-09 13:08:22','d5822862-1769-4f56-bdd9-03d7aeb583a1'),
	(72,NULL,'Split List','splitList','superTableBlockType:061368e4-5312-4599-93a2-c40f7165b4b6','When enabled and the list contains items the list will be placed to the right of the body copy.',1,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"\"}','2018-12-07 18:04:27','2019-02-09 13:08:22','43eacc7a-4e10-4194-875c-d90071579149'),
	(73,NULL,'List Style','listStyle','superTableBlockType:061368e4-5312-4599-93a2-c40f7165b4b6','Select a list style type.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Default\",\"value\":\"-default\",\"default\":\"1\"},{\"label\":\"Plus\",\"value\":\"-plus\",\"default\":\"\"}]}','2018-12-07 19:09:38','2019-02-09 13:08:22','b337860e-6281-433f-aa69-2d01b5f8e912'),
	(74,NULL,'Multi Row','multiRow','matrixBlockType:2cb049e6-b35a-4271-8861-0bbde459b042','When enabled users can open up several rows. When disabled when a user opens a row the previously opened row will be closed.',1,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"\"}','2018-12-07 19:34:21','2019-02-09 13:08:22','f8b603ed-7622-42e8-a6ca-022ec1da1159'),
	(75,NULL,'Selected Form','selectedForm','matrixBlockType:84f5b143-6cfd-4a3f-892f-e52a1b2731ee','',1,'none',NULL,'Solspace\\Freeform\\FieldTypes\\FormFieldType','[]','2019-01-31 19:31:00','2019-02-09 13:08:22','e733f390-3ace-4314-a59c-43f9f1dc1d19'),
	(76,NULL,'Form Style','formStyle','matrixBlockType:84f5b143-6cfd-4a3f-892f-e52a1b2731ee','',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Underline\",\"value\":\"-underline\",\"default\":\"1\"},{\"label\":\"Solid\",\"value\":\"-solid\",\"default\":\"\"},{\"label\":\"Outline\",\"value\":\"-outline\",\"default\":\"\"}]}','2019-01-31 19:31:00','2019-02-09 13:08:22','7bc9cddb-43cb-400c-a9d8-e924124151d2'),
	(77,NULL,'Padding Size','paddingSize','matrixBlockType:84f5b143-6cfd-4a3f-892f-e52a1b2731ee','Add additional padding to this block. Leave as \'none\' if you don\'t want additional padding.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Quarter\",\"value\":\"-quarter\",\"default\":\"\"},{\"label\":\"Half\",\"value\":\"-thin\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"x2\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"x4\",\"value\":\"-x4\",\"default\":\"\"}]}','2019-02-05 18:38:31','2019-02-09 13:08:23','f135a445-114f-4b17-90bc-1d7445a454f3'),
	(78,NULL,'Padding Type','paddingType','matrixBlockType:84f5b143-6cfd-4a3f-892f-e52a1b2731ee','Select where the additional padding should be applied.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"1\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2019-02-05 18:38:31','2019-02-09 13:08:23','dac84921-0c24-4f81-a8aa-eb7f141abc90'),
	(79,NULL,'Submission Message','submissionMessage','matrixBlockType:84f5b143-6cfd-4a3f-892f-e52a1b2731ee','This is the message that will be displayed after the user has submitted the form.',1,'none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Simple.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"\",\"availableTransforms\":\"*\"}','2019-02-05 20:15:56','2019-02-09 13:08:23','8132823b-72a1-4d56-ab84-7a6ea737d29b'),
	(80,3,'text1','text1','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-02-09 12:30:05','2019-02-09 12:30:05','a4fc8798-7670-4c7d-8c07-1af37af0df28'),
	(81,3,'text2','text2','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-02-09 12:30:11','2019-02-09 12:30:11','7cd24d1f-404a-48a0-a451-b5102c825080'),
	(82,3,'headline1','headline1','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-02-09 12:30:25','2019-02-09 12:30:25','ec11902d-33d1-437e-ac69-364410d941c6'),
	(83,3,'headline2','headline2','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-02-09 12:30:31','2019-02-09 12:30:31','e87fc440-8cda-4676-96d6-abb2d3b7dd1b'),
	(84,3,'subheadline1','subheadline1','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-02-09 12:30:42','2019-02-09 12:30:42','6fd20f12-c213-4fdd-9101-e95ef0374376'),
	(85,3,'subheadline2','subheadline2','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-02-09 12:30:49','2019-02-09 12:30:49','c63dc6b6-8f1e-4497-8e7a-b612a9570514'),
	(86,3,'singleImage1','singleImage1','global','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:b7f7001c-8d6f-4341-a869-732554429306\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add an Image\",\"localizeRelations\":false}','2019-02-09 12:31:29','2019-02-09 12:31:41','977bde35-60a4-4c06-a5e6-5fc91f15a300'),
	(87,3,'thumbnail1','thumbnail1','global','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:b7f7001c-8d6f-4341-a869-732554429306\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add an Image\",\"localizeRelations\":false}','2019-02-09 12:32:09','2019-02-09 12:32:09','c8b641ec-3e88-4250-af11-570112faac51'),
	(88,3,'video1','video1','global','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"volume:b7f7001c-8d6f-4341-a869-732554429306\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"video\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add a Video\",\"localizeRelations\":false}','2019-02-09 12:32:39','2019-02-09 12:32:39','bb8a8db1-01fa-4444-9cb5-5a95acc7957e'),
	(89,3,'copy1','copy1','global','',1,'none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Basic.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"\",\"availableTransforms\":\"*\"}','2019-02-09 12:33:00','2019-02-09 12:33:00','e8be50dd-1413-4c51-810a-c5ff874b571e'),
	(90,3,'copy2','copy2','global','',1,'none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Basic.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"\",\"availableTransforms\":\"*\"}','2019-02-09 12:33:15','2019-02-09 12:33:15','18c487ab-e98e-4854-b79b-aac154acd122'),
	(91,NULL,'Column Layout','columnLayout','matrixBlockType:d40a8732-c577-4d4a-a737-05fa930be6a2','Split the copy across multiple columns.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"One Column\",\"value\":\"-single-column\",\"default\":\"1\"},{\"label\":\"Two Columns\",\"value\":\"-double-column\",\"default\":\"\"},{\"label\":\"Three Columns\",\"value\":\"-tripple-column\",\"default\":\"\"}]}','2019-02-09 13:02:15','2019-02-09 13:08:20','2bbdb90a-3923-4b0f-b400-b3469f2cae63');

/*!40000 ALTER TABLE `pt_fields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_freeform_crm_fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_freeform_crm_fields`;

CREATE TABLE `pt_freeform_crm_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `integrationId` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `required` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `freeform_crm_fields_integrationId_fk` (`integrationId`),
  KEY `freeform_crm_fields_type_idx` (`type`),
  CONSTRAINT `freeform_crm_fields_integrationId_fk` FOREIGN KEY (`integrationId`) REFERENCES `pt_freeform_integrations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_freeform_fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_freeform_fields`;

CREATE TABLE `pt_freeform_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `required` tinyint(1) DEFAULT '0',
  `instructions` text,
  `metaProperties` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `handle` (`handle`),
  KEY `freeform_fields_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_freeform_fields` WRITE;
/*!40000 ALTER TABLE `pt_freeform_fields` DISABLE KEYS */;

INSERT INTO `pt_freeform_fields` (`id`, `type`, `handle`, `label`, `required`, `instructions`, `metaProperties`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(10,'select','state','State',0,NULL,'{\"options\":[{\"value\":\"\",\"label\":\"Select a State\"},{\"value\":\"AL\",\"label\":\"Alabama\"},{\"value\":\"AK\",\"label\":\"Alaska\"},{\"value\":\"AZ\",\"label\":\"Arizona\"},{\"value\":\"AR\",\"label\":\"Arkansas\"},{\"value\":\"CA\",\"label\":\"California\"},{\"value\":\"CO\",\"label\":\"Colorado\"},{\"value\":\"CT\",\"label\":\"Connecticut\"},{\"value\":\"DE\",\"label\":\"Delaware\"},{\"value\":\"DC\",\"label\":\"District of Columbia\"},{\"value\":\"FL\",\"label\":\"Florida\"},{\"value\":\"GA\",\"label\":\"Georgia\"},{\"value\":\"HI\",\"label\":\"Hawaii\"},{\"value\":\"ID\",\"label\":\"Idaho\"},{\"value\":\"IL\",\"label\":\"Illinois\"},{\"value\":\"IN\",\"label\":\"Indiana\"},{\"value\":\"IA\",\"label\":\"Iowa\"},{\"value\":\"KS\",\"label\":\"Kansas\"},{\"value\":\"KY\",\"label\":\"Kentucky\"},{\"value\":\"LA\",\"label\":\"Louisiana\"},{\"value\":\"ME\",\"label\":\"Maine\"},{\"value\":\"MD\",\"label\":\"Maryland\"},{\"value\":\"MA\",\"label\":\"Massachusetts\"},{\"value\":\"MI\",\"label\":\"Michigan\"},{\"value\":\"MN\",\"label\":\"Minnesota\"},{\"value\":\"MS\",\"label\":\"Mississippi\"},{\"value\":\"MO\",\"label\":\"Missouri\"},{\"value\":\"MT\",\"label\":\"Montana\"},{\"value\":\"NE\",\"label\":\"Nebraska\"},{\"value\":\"NV\",\"label\":\"Nevada\"},{\"value\":\"NH\",\"label\":\"New Hampshire\"},{\"value\":\"NJ\",\"label\":\"New Jersey\"},{\"value\":\"NM\",\"label\":\"New Mexico\"},{\"value\":\"NY\",\"label\":\"New York\"},{\"value\":\"NC\",\"label\":\"North Carolina\"},{\"value\":\"ND\",\"label\":\"North Dakota\"},{\"value\":\"OH\",\"label\":\"Ohio\"},{\"value\":\"OK\",\"label\":\"Oklahoma\"},{\"value\":\"OR\",\"label\":\"Oregon\"},{\"value\":\"PA\",\"label\":\"Pennsylvania\"},{\"value\":\"RI\",\"label\":\"Rhode Island\"},{\"value\":\"SC\",\"label\":\"South Carolina\"},{\"value\":\"SD\",\"label\":\"South Dakota\"},{\"value\":\"TN\",\"label\":\"Tennessee\"},{\"value\":\"TX\",\"label\":\"Texas\"},{\"value\":\"UT\",\"label\":\"Utah\"},{\"value\":\"VT\",\"label\":\"Vermont\"},{\"value\":\"VA\",\"label\":\"Virginia\"},{\"value\":\"WA\",\"label\":\"Washington\"},{\"value\":\"WV\",\"label\":\"West Virginia\"},{\"value\":\"WI\",\"label\":\"Wisconsin\"},{\"value\":\"WY\",\"label\":\"Wyoming\"}]}','2018-11-07 16:07:44','2018-11-07 16:07:44','3387aa42-7fd3-4404-ba53-6964ed82309b'),
	(14,'text','fullName','Full Name',1,'Please provide your full name','{\"value\":\"\",\"placeholder\":\"\"}','2019-01-29 19:19:38','2019-01-29 19:19:38','59905107-98b0-42ee-b8cf-0f9c76bf834c'),
	(15,'text','companyName','Company Name',0,'','{\"value\":\"\",\"placeholder\":\"\"}','2019-01-29 19:19:51','2019-01-29 19:19:51','1d4df61d-133f-4494-b6bc-234c522c6970'),
	(16,'email','emailAddress','Email Address',0,'','{\"placeholder\":\"\"}','2019-01-29 19:20:00','2019-01-29 19:20:00','902b0e18-3957-4d62-ba78-0bb626909623'),
	(17,'textarea','message','Message',0,'','{\"value\":\"\",\"placeholder\":\"\",\"rows\":\"2\"}','2019-01-29 19:20:11','2019-01-29 19:20:11','d0d09e2c-e557-494b-9cde-0c56367392a4'),
	(18,'text','city','City',0,'','{\"value\":\"\",\"placeholder\":\"\"}','2019-01-29 19:20:22','2019-01-29 19:20:22','b912a74c-bdb1-4ddd-918c-9c3dcb342289'),
	(19,'number','zipCode','Zip Code',0,'','{\"value\":\"\",\"placeholder\":\"\",\"allowNegative\":\"1\",\"minValue\":\"\",\"maxValue\":\"\",\"minLength\":\"\",\"maxLength\":\"\",\"decimalCount\":\"0\",\"decimalSeparator\":\".\",\"thousandsSeparator\":\"\"}','2019-01-29 19:20:32','2019-01-29 19:20:32','993914c7-6455-4aed-9106-5849cd68fd29'),
	(20,'radio_group','favoriteFlavor','Favorite Flavor',0,'','{\"customValues\":\"\",\"labels\":[\"Peanut Butter Cup\",\"Chocolate Chip Cookie Dough\",\"Vanilla Bean\",\"Birthday Cake\",\"Cookies & Cream\",\"Chocolate\"],\"options\":[{\"value\":\"Peanut Butter Cup\",\"label\":\"Peanut Butter Cup\"},{\"value\":\"Chocolate Chip Cookie Dough\",\"label\":\"Chocolate Chip Cookie Dough\"},{\"value\":\"Vanilla Bean\",\"label\":\"Vanilla Bean\"},{\"value\":\"Birthday Cake\",\"label\":\"Birthday Cake\"},{\"value\":\"Cookies & Cream\",\"label\":\"Cookies & Cream\"},{\"value\":\"Chocolate\",\"label\":\"Chocolate\"}],\"value\":\"Peanut Butter Cup\"}','2019-01-29 19:44:18','2019-01-29 19:44:18','ffd1ffb9-b8aa-4882-8ea4-343ed4f2c892'),
	(21,'checkbox_group','seasonalFlavors','Seasonal Flavors',0,'What seasonal flavor should we bring back?','{\"customValues\":\"\",\"labels\":[\"Pumpkin Pie\",\"Gingerbread House\",\"S\'mores\",\"Rainbow Swirl\",\"Peanut Butter & Jelly\"],\"options\":[{\"value\":\"Pumpkin Pie\",\"label\":\"Pumpkin Pie\"},{\"value\":\"Gingerbread House\",\"label\":\"Gingerbread House\"},{\"value\":\"S\'mores\",\"label\":\"S\'mores\"},{\"value\":\"Rainbow Swirl\",\"label\":\"Rainbow Swirl\"},{\"value\":\"Peanut Butter & Jelly\",\"label\":\"Peanut Butter & Jelly\"}]}','2019-01-29 20:02:19','2019-01-30 16:48:47','54c6f39d-56f1-4ece-b43c-0381eda527db'),
	(22,'checkbox','acceptTermsAndConditions','Accept Terms & Conditions',1,'You agree to this website\'s Terms & Conditions','{\"value\":\"no\",\"checked\":\"\"}','2019-01-29 20:16:46','2019-02-05 18:54:53','2c65083b-0ac4-47d9-9235-46d804f4ba59'),
	(23,'checkbox','newsletterSignup','Newsletter Signup',0,'','{\"value\":\"yes\",\"checked\":\"1\"}','2019-01-29 20:44:12','2019-01-29 20:44:12','bd6c7807-2192-4b4c-8511-ce3fcf94b037'),
	(24,'number','pinNumber','Pin Number',1,'','{\"value\":\"\",\"placeholder\":\"\",\"allowNegative\":\"\",\"minValue\":\"0\",\"maxValue\":\"9999\",\"minLength\":\"4\",\"maxLength\":\"8\",\"decimalCount\":\"0\",\"decimalSeparator\":\".\",\"thousandsSeparator\":\"\"}','2019-01-29 20:48:12','2019-02-04 14:46:58','8f21ea62-25fa-4ec6-b94d-3a76660dc8a6'),
	(25,'text','address','Address',0,'','{\"value\":\"\",\"placeholder\":\"\"}','2019-01-29 20:55:50','2019-01-29 20:55:50','4fbef3fe-1ffd-4757-add0-373edf626b3f'),
	(26,'file','uploadAFile','Upload a File',0,'This field accepts PDF files only.','{\"assetSourceId\":\"1\",\"fileCount\":\"1\",\"maxFileSizeKB\":\"2048\",\"fileKinds\":[\"pdf\"]}','2019-01-30 17:12:49','2019-01-30 17:28:34','5e5e2b9b-e91d-4fb2-9aa6-143ef1782b61');

/*!40000 ALTER TABLE `pt_freeform_fields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_freeform_forms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_freeform_forms`;

CREATE TABLE `pt_freeform_forms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `handle` varchar(100) NOT NULL,
  `spamBlockCount` int(11) unsigned NOT NULL DEFAULT '0',
  `submissionTitleFormat` varchar(255) NOT NULL,
  `description` text,
  `layoutJson` mediumtext,
  `returnUrl` varchar(255) DEFAULT NULL,
  `defaultStatus` int(11) unsigned DEFAULT NULL,
  `formTemplateId` int(11) unsigned DEFAULT NULL,
  `color` varchar(10) DEFAULT NULL,
  `optInDataStorageTargetHash` varchar(20) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `handle` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_freeform_forms` WRITE;
/*!40000 ALTER TABLE `pt_freeform_forms` DISABLE KEYS */;

INSERT INTO `pt_freeform_forms` (`id`, `name`, `handle`, `spamBlockCount`, `submissionTitleFormat`, `description`, `layoutJson`, `returnUrl`, `defaultStatus`, `formTemplateId`, `color`, `optInDataStorageTargetHash`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Sample Form','sampleForm',3,'{{ dateCreated|date(\"Y-m-d H:i:s\") }}','','{\"composer\":{\"layout\":[[{\"id\":\"pqOPoE19l\",\"columns\":[\"mgEePYZor\"]},{\"id\":\"QrY8bGNx1\",\"columns\":[\"AV34dy07p\"]},{\"id\":\"rM3jqGP8z\",\"columns\":[\"Bb10jE4K3\"]},{\"id\":\"dvB9MdyK2\",\"columns\":[\"QrYkoLGpL\"]},{\"id\":\"KrOaDXNN9\",\"columns\":[\"15rmRYW7M\"]},{\"id\":\"GRya5q7yB\",\"columns\":[\"AQbZNx0P3\"]},{\"id\":\"Bm2adJMMV\",\"columns\":[\"gGp461ZwQ\",\"jDMZQLe3y\",\"Jvb4m946X\"]},{\"id\":\"LLGwqXVwX\",\"columns\":[\"vGYmq1X8L\"]},{\"id\":\"LLGwqKWDA\",\"columns\":[\"n5deb50bB\",\"qlRZRw4XA\"]},{\"id\":\"YAdryB1b5\",\"columns\":[\"VarQD5Edb\"]},{\"id\":\"NzkOlRKa6\",\"columns\":[\"PN5Z8a4AM\"]},{\"id\":\"ldyA82zK7\",\"columns\":[\"dV8ZM8eob\"]}]],\"properties\":{\"page0\":{\"type\":\"page\",\"label\":\"Page 1\"},\"form\":{\"type\":\"form\",\"name\":\"Sample Form\",\"handle\":\"sampleForm\",\"color\":\"#16a388\",\"submissionTitleFormat\":\"{{ dateCreated|date(\\\"Y-m-d H:i:s\\\") }}\",\"description\":\"\",\"formTemplate\":\"papertrain.twig\",\"returnUrl\":\"\",\"storeData\":true,\"defaultStatus\":2,\"ajaxEnabled\":true},\"integration\":{\"type\":\"integration\",\"integrationId\":0,\"mapping\":[]},\"connections\":{\"type\":\"connections\",\"list\":null},\"rules\":{\"type\":\"rules\",\"list\":[]},\"admin_notifications\":{\"type\":\"admin_notifications\",\"notificationId\":0,\"recipients\":\"\"},\"payment\":{\"type\":\"payment\",\"integrationId\":0,\"mapping\":[]},\"mgEePYZor\":{\"hash\":\"mgEePYZor\",\"id\":14,\"type\":\"text\",\"handle\":\"fullName\",\"label\":\"Full Name\",\"required\":true,\"instructions\":\"Please provide your full name\",\"value\":\"\",\"placeholder\":\"\"},\"AV34dy07p\":{\"hash\":\"AV34dy07p\",\"id\":16,\"type\":\"email\",\"handle\":\"emailAddress\",\"label\":\"Email Address\",\"required\":true,\"instructions\":\"\",\"notificationId\":0,\"values\":[],\"placeholder\":\"\"},\"AQbZNx0P3\":{\"hash\":\"AQbZNx0P3\",\"id\":25,\"type\":\"text\",\"handle\":\"address\",\"label\":\"Address\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"gGp461ZwQ\":{\"hash\":\"gGp461ZwQ\",\"id\":18,\"type\":\"text\",\"handle\":\"city\",\"label\":\"City\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"jDMZQLe3y\":{\"hash\":\"jDMZQLe3y\",\"id\":10,\"type\":\"select\",\"handle\":\"state\",\"label\":\"State\",\"required\":true,\"instructions\":\"\",\"showCustomValues\":true,\"value\":\"\",\"options\":[{\"value\":\"\",\"label\":\"Select a State\"},{\"value\":\"AL\",\"label\":\"Alabama\"},{\"value\":\"AK\",\"label\":\"Alaska\"},{\"value\":\"AZ\",\"label\":\"Arizona\"},{\"value\":\"AR\",\"label\":\"Arkansas\"},{\"value\":\"CA\",\"label\":\"California\"},{\"value\":\"CO\",\"label\":\"Colorado\"},{\"value\":\"CT\",\"label\":\"Connecticut\"},{\"value\":\"DE\",\"label\":\"Delaware\"},{\"value\":\"DC\",\"label\":\"District of Columbia\"},{\"value\":\"FL\",\"label\":\"Florida\"},{\"value\":\"GA\",\"label\":\"Georgia\"},{\"value\":\"HI\",\"label\":\"Hawaii\"},{\"value\":\"ID\",\"label\":\"Idaho\"},{\"value\":\"IL\",\"label\":\"Illinois\"},{\"value\":\"IN\",\"label\":\"Indiana\"},{\"value\":\"IA\",\"label\":\"Iowa\"},{\"value\":\"KS\",\"label\":\"Kansas\"},{\"value\":\"KY\",\"label\":\"Kentucky\"},{\"value\":\"LA\",\"label\":\"Louisiana\"},{\"value\":\"ME\",\"label\":\"Maine\"},{\"value\":\"MD\",\"label\":\"Maryland\"},{\"value\":\"MA\",\"label\":\"Massachusetts\"},{\"value\":\"MI\",\"label\":\"Michigan\"},{\"value\":\"MN\",\"label\":\"Minnesota\"},{\"value\":\"MS\",\"label\":\"Mississippi\"},{\"value\":\"MO\",\"label\":\"Missouri\"},{\"value\":\"MT\",\"label\":\"Montana\"},{\"value\":\"NE\",\"label\":\"Nebraska\"},{\"value\":\"NV\",\"label\":\"Nevada\"},{\"value\":\"NH\",\"label\":\"New Hampshire\"},{\"value\":\"NJ\",\"label\":\"New Jersey\"},{\"value\":\"NM\",\"label\":\"New Mexico\"},{\"value\":\"NY\",\"label\":\"New York\"},{\"value\":\"NC\",\"label\":\"North Carolina\"},{\"value\":\"ND\",\"label\":\"North Dakota\"},{\"value\":\"OH\",\"label\":\"Ohio\"},{\"value\":\"OK\",\"label\":\"Oklahoma\"},{\"value\":\"OR\",\"label\":\"Oregon\"},{\"value\":\"PA\",\"label\":\"Pennsylvania\"},{\"value\":\"RI\",\"label\":\"Rhode Island\"},{\"value\":\"SC\",\"label\":\"South Carolina\"},{\"value\":\"SD\",\"label\":\"South Dakota\"},{\"value\":\"TN\",\"label\":\"Tennessee\"},{\"value\":\"TX\",\"label\":\"Texas\"},{\"value\":\"UT\",\"label\":\"Utah\"},{\"value\":\"VT\",\"label\":\"Vermont\"},{\"value\":\"VA\",\"label\":\"Virginia\"},{\"value\":\"WA\",\"label\":\"Washington\"},{\"value\":\"WV\",\"label\":\"West Virginia\"},{\"value\":\"WI\",\"label\":\"Wisconsin\"},{\"value\":\"WY\",\"label\":\"Wyoming\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null},\"Jvb4m946X\":{\"hash\":\"Jvb4m946X\",\"id\":19,\"type\":\"number\",\"handle\":\"zipCode\",\"label\":\"Zip Code\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\",\"minLength\":0,\"maxLength\":0,\"minValue\":0,\"maxValue\":0,\"decimalCount\":0,\"decimalSeparator\":\".\",\"thousandsSeparator\":\"\",\"allowNegative\":true},\"Bb10jE4K3\":{\"hash\":\"Bb10jE4K3\",\"id\":15,\"type\":\"text\",\"handle\":\"companyName\",\"label\":\"Company Name\",\"required\":false,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"n5deb50bB\":{\"hash\":\"n5deb50bB\",\"id\":20,\"type\":\"radio_group\",\"handle\":\"favoriteFlavor\",\"label\":\"Favorite Flavor\",\"required\":false,\"instructions\":\"\",\"showCustomValues\":false,\"value\":\"Peanut Butter Cup\",\"options\":[{\"value\":\"Peanut Butter Cup\",\"label\":\"Peanut Butter Cup\"},{\"value\":\"Chocolate Chip Cookie Dough\",\"label\":\"Chocolate Chip Cookie Dough\"},{\"value\":\"Vanilla Bean\",\"label\":\"Vanilla Bean\"},{\"value\":\"Birthday Cake\",\"label\":\"Birthday Cake\"},{\"value\":\"Cookies & Cream\",\"label\":\"Cookies & Cream\"},{\"value\":\"Chocolate\",\"label\":\"Chocolate\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null},\"qlRZRw4XA\":{\"hash\":\"qlRZRw4XA\",\"id\":21,\"type\":\"checkbox_group\",\"handle\":\"seasonalFlavors\",\"label\":\"Seasonal Flavors\",\"required\":false,\"instructions\":\"What seasonal flavor should we bring back?\",\"showCustomValues\":false,\"values\":[],\"options\":[{\"value\":\"Pumpkin Pie\",\"label\":\"Pumpkin Pie\"},{\"value\":\"Gingerbread House\",\"label\":\"Gingerbread House\"},{\"value\":\"S\'mores\",\"label\":\"S\'mores\"},{\"value\":\"Rainbow Swirl\",\"label\":\"Rainbow Swirl\"},{\"value\":\"Peanut Butter & Jelly\",\"label\":\"Peanut Butter & Jelly\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null},\"QrYkoLGpL\":{\"type\":\"password\",\"label\":\"Password\",\"handle\":\"password\",\"placeholder\":\"\",\"required\":true},\"15rmRYW7M\":{\"type\":\"submit\",\"label\":\"Submit\",\"labelNext\":\"Submit\",\"labelPrev\":\"Previous\",\"disablePrev\":false,\"position\":\"left\"},\"vGYmq1X8L\":{\"type\":\"submit\",\"label\":\"Submit\",\"labelNext\":\"Submit\",\"labelPrev\":\"Previous\",\"disablePrev\":false,\"position\":\"left\"},\"VarQD5Edb\":{\"type\":\"submit\",\"label\":\"Submit\",\"labelNext\":\"Submit\",\"labelPrev\":\"Previous\",\"disablePrev\":false,\"position\":\"left\"},\"PN5Z8a4AM\":{\"hash\":\"PN5Z8a4AM\",\"id\":23,\"type\":\"checkbox\",\"handle\":\"newsletterSignup\",\"label\":\"Newsletter Signup\",\"required\":false,\"instructions\":\"\",\"value\":\"yes\",\"checked\":true},\"dV8ZM8eob\":{\"hash\":\"dV8ZM8eob\",\"id\":22,\"type\":\"checkbox\",\"handle\":\"acceptTermsAndConditions\",\"label\":\"Accept Terms & Conditions\",\"required\":true,\"instructions\":\"You agree to this website\'s Terms & Conditions\",\"value\":\"no\",\"checked\":false}}},\"context\":{\"page\":0,\"hash\":\"Jvb4m946X\"}}','',2,NULL,'#16a388',NULL,'2019-01-29 19:18:35','2019-02-05 20:33:04','5588f7f4-3a6b-437d-8768-3e50635f1740');

/*!40000 ALTER TABLE `pt_freeform_forms` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_freeform_integrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_freeform_integrations`;

CREATE TABLE `pt_freeform_integrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `class` varchar(255) DEFAULT NULL,
  `accessToken` varchar(255) DEFAULT NULL,
  `settings` text,
  `forceUpdate` tinyint(1) DEFAULT '0',
  `lastUpdate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `handle` (`handle`),
  KEY `freeform_integrations_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_freeform_integrations_queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_freeform_integrations_queue`;

CREATE TABLE `pt_freeform_integrations_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `submissionId` int(11) NOT NULL,
  `integrationType` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `fieldHash` varchar(20) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `freeform_integrations_queue_status_unq_idx` (`status`),
  KEY `freeform_integrations_queue_submissionId_fk` (`submissionId`),
  CONSTRAINT `freeform_integrations_queue_id_fk` FOREIGN KEY (`id`) REFERENCES `pt_freeform_mailing_list_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `freeform_integrations_queue_submissionId_fk` FOREIGN KEY (`submissionId`) REFERENCES `pt_freeform_submissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_freeform_mailing_list_fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_freeform_mailing_list_fields`;

CREATE TABLE `pt_freeform_mailing_list_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mailingListId` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `required` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `freeform_mailing_list_fields_mailingListId_fk` (`mailingListId`),
  KEY `freeform_mailing_list_fields_type_idx` (`type`),
  CONSTRAINT `freeform_mailing_list_fields_mailingListId_fk` FOREIGN KEY (`mailingListId`) REFERENCES `pt_freeform_mailing_lists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_freeform_mailing_lists
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_freeform_mailing_lists`;

CREATE TABLE `pt_freeform_mailing_lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `integrationId` int(11) NOT NULL,
  `resourceId` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `memberCount` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `freeform_mailing_lists_integrationId_resourceId_unq_idx` (`integrationId`,`resourceId`),
  CONSTRAINT `freeform_mailing_lists_integrationId_fk` FOREIGN KEY (`integrationId`) REFERENCES `pt_freeform_integrations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_freeform_notifications
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_freeform_notifications`;

CREATE TABLE `pt_freeform_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `description` text,
  `fromName` varchar(255) NOT NULL,
  `fromEmail` varchar(255) NOT NULL,
  `replyToEmail` varchar(255) DEFAULT NULL,
  `bodyHtml` text,
  `bodyText` text,
  `includeAttachments` tinyint(1) DEFAULT '1',
  `sortOrder` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `handle` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_freeform_payment_gateway_fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_freeform_payment_gateway_fields`;

CREATE TABLE `pt_freeform_payment_gateway_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `integrationId` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `required` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `freeform_payment_gateway_fields_integrationId_fk` (`integrationId`),
  KEY `freeform_payment_gateway_fields_type_idx` (`type`),
  CONSTRAINT `freeform_payment_gateway_fields_integrationId_fk` FOREIGN KEY (`integrationId`) REFERENCES `pt_freeform_integrations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_freeform_statuses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_freeform_statuses`;

CREATE TABLE `pt_freeform_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `color` varchar(30) DEFAULT NULL,
  `isDefault` tinyint(1) DEFAULT NULL,
  `sortOrder` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `handle` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_freeform_statuses` WRITE;
/*!40000 ALTER TABLE `pt_freeform_statuses` DISABLE KEYS */;

INSERT INTO `pt_freeform_statuses` (`id`, `name`, `handle`, `color`, `isDefault`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Pending','pending','light',NULL,1,'2018-11-07 16:07:45','2018-11-07 16:07:45','e7d4eb9a-894b-4d84-9017-e69ff4bc22ed'),
	(2,'Open','open','green',1,2,'2018-11-07 16:07:45','2018-11-07 16:07:45','ecfee32d-a104-4aad-9b93-f11a3f8cef11'),
	(3,'Closed','closed','grey',NULL,3,'2018-11-07 16:07:45','2018-11-07 16:07:45','521f1b34-f0f6-4a6d-9f49-8a0fa0d9d239');

/*!40000 ALTER TABLE `pt_freeform_statuses` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_freeform_submissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_freeform_submissions`;

CREATE TABLE `pt_freeform_submissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `incrementalId` int(11) NOT NULL,
  `statusId` int(11) DEFAULT NULL,
  `formId` int(11) NOT NULL,
  `token` varchar(100) NOT NULL,
  `ip` varchar(46) DEFAULT NULL,
  `isSpam` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_10` varchar(100) DEFAULT NULL,
  `field_14` varchar(100) DEFAULT NULL,
  `field_15` varchar(100) DEFAULT NULL,
  `field_16` text,
  `field_17` text,
  `field_18` varchar(100) DEFAULT NULL,
  `field_19` varchar(100) DEFAULT NULL,
  `field_20` varchar(100) DEFAULT NULL,
  `field_21` text,
  `field_22` varchar(100) DEFAULT NULL,
  `field_23` varchar(100) DEFAULT NULL,
  `field_24` varchar(100) DEFAULT NULL,
  `field_25` varchar(100) DEFAULT NULL,
  `field_26` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `freeform_submissions_incrementalId_unq_idx` (`incrementalId`),
  UNIQUE KEY `freeform_submissions_token_unq_idx` (`token`),
  KEY `freeform_submissions_formId_fk` (`formId`),
  KEY `freeform_submissions_statusId_fk` (`statusId`),
  CONSTRAINT `freeform_submissions_formId_fk` FOREIGN KEY (`formId`) REFERENCES `pt_freeform_forms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `freeform_submissions_id_fk` FOREIGN KEY (`id`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `freeform_submissions_statusId_fk` FOREIGN KEY (`statusId`) REFERENCES `pt_freeform_statuses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_freeform_submissions` WRITE;
/*!40000 ALTER TABLE `pt_freeform_submissions` DISABLE KEYS */;

INSERT INTO `pt_freeform_submissions` (`id`, `incrementalId`, `statusId`, `formId`, `token`, `ip`, `isSpam`, `dateCreated`, `dateUpdated`, `uid`, `field_10`, `field_14`, `field_15`, `field_16`, `field_17`, `field_18`, `field_19`, `field_20`, `field_21`, `field_22`, `field_23`, `field_24`, `field_25`, `field_26`)
VALUES
	(184,1,2,1,'NXDwA0jVnzwv6qqZKq1zyE6wGaJJUU8eTkn4ysIzIe0ClhifAeA7rOYKgrqqcTGYGa3LESnuvw6ynVDUWuUvqqZ6XDBcF7Zx6fhN','127.0.0.1',0,'2019-02-04 16:46:29','2019-02-04 16:46:29','6eb1d6ab-f363-4a91-b0e1-8d61bbbcaddb','MI','Kyle Andrews','Pageworks','[\"kylea@page.works\"]','Kyle was here.','','',NULL,NULL,'no',NULL,'1234','',NULL),
	(185,2,2,1,'kdRpMEwVaKIywZtRrZj7mkL7ckE396Zl9Cr8wKnm0VBKMQ4081Bi5ZTzpXXQjUvRwGF4nTyb7GzcCkjDuJKks7LYryklqrMdPcmE','127.0.0.1',0,'2019-02-04 17:14:21','2019-02-04 17:14:21','6f701204-df91-4165-8646-94ae4ae3f056',NULL,NULL,'Test',NULL,NULL,NULL,NULL,NULL,NULL,'no',NULL,NULL,NULL,NULL),
	(186,3,2,1,'6YaXVm8Q7ZSZbeFK890SQrQAF169EyXQlvmB2vMT85EvKEbSBbmkzIk6VbZpWVHXPWtMvsCpSatvqu4V4a1zrs43hCQINKrx8bGl','127.0.0.1',0,'2019-02-04 18:20:22','2019-02-04 18:20:22','4b56e3cb-9b39-4e68-aeed-d3736e56d5a8',NULL,'test',NULL,'[\"\"]','',NULL,NULL,NULL,NULL,'no',NULL,NULL,NULL,NULL),
	(187,4,2,1,'WqdZavsknfDVLBexFHX4P1LFDAvQyK3jVrYu1v0UAvC6fy08w5yNKlVFO8qvA92DhuO7qwl8EY5pHSgwBptzFmxbeLAdWHjAMCgF','127.0.0.1',0,'2019-02-04 18:32:32','2019-02-04 18:32:32','4e54e4c1-f072-41f2-a1cd-466b2f3a373a',NULL,'test',NULL,'[\"\"]','',NULL,NULL,NULL,NULL,'no',NULL,NULL,NULL,NULL),
	(188,5,2,1,'SYQOZLuH0eUAhPAD3kPlj5XXKTsvyTdt5tGnWumyGkq1CUz0NmhSvlbiJDPUmSPKn0IM7SJIcSyUwIt9j0BVBgl8gFH8UKPD0HEY','127.0.0.1',0,'2019-02-04 18:34:12','2019-02-04 18:34:12','b2071a9d-de82-4ecd-a814-c4eeb41250f0',NULL,'test',NULL,'[\"\"]','',NULL,NULL,NULL,NULL,'no',NULL,NULL,NULL,NULL),
	(189,6,2,1,'LGpXXkGiJicCyC9yswvnHC971FWh38SDIQ7zS0iB6VDa0AdcLBgUxNhlFudjVp1cBWqpOxhLJy3VgO4m2dKdWx2CmS5ImdfNhqft','127.0.0.1',0,'2019-02-04 19:06:05','2019-02-04 19:06:05','9029aef5-f62a-40a6-bcf7-1c04126e7b41',NULL,'Test',NULL,'[\"\"]','',NULL,NULL,NULL,NULL,'no',NULL,NULL,NULL,NULL),
	(190,7,2,1,'8P7McKpN8xWsVrXTalxO5TTj8ummRGuUusrGo7n63BnsxiIQLLkvNgUj924PxJCAk54NwS0erXqHxkRKa5SjNz5yxMhRlfNW07f8','127.0.0.1',0,'2019-02-04 19:07:00','2019-02-04 19:07:00','6f0b1986-fd4f-4aa6-b0cc-8fd28049b0fc',NULL,'Test',NULL,'[\"\"]','',NULL,NULL,NULL,NULL,'no',NULL,NULL,NULL,NULL),
	(191,8,2,1,'uIMwkZfv6Ke5cWw0k2Y2GTyOWaz2ekAliYIbxwnc37Q87Z2FSTIxeFs5SOBpg0Ih9ewXCqzYDAepkEZbg7UrTIe2be3pt1tBliQw','127.0.0.1',0,'2019-02-04 19:13:24','2019-02-04 19:13:24','debd22c8-cd1e-4478-9695-4d95a0a56cdb',NULL,'Test',NULL,'[\"\"]','',NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL),
	(192,9,2,1,'01aGFLuyKutIOdLMsugVbOZmx4rPApSmYrS1lw9YtzZHCvApcwwizRwR8dWneZQE5NHb1jNku5uPg99xeVsdzAOK2Y2FWTtJ1y9g','127.0.0.1',0,'2019-02-04 19:19:49','2019-02-04 19:19:49','b03d9922-8cad-409a-81ca-a57e1bd9cc45',NULL,'Test',NULL,'[\"\"]','',NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL),
	(193,10,2,1,'X8k0j2rk0xIn35tdUbJk6FlifOHB1oZeSoZkTseBIowQbgs37TYmBLJhiKUks0RcdaeQl45xxtwflWCvg3chaY9ZlNSUboZuGSC4','127.0.0.1',0,'2019-02-04 19:21:32','2019-02-04 19:21:32','e812c549-388c-4ee9-a84e-c7022372e421',NULL,'Kyle Andrews',NULL,'[\"\"]','',NULL,NULL,NULL,NULL,'no',NULL,NULL,NULL,NULL),
	(194,11,2,1,'jLrLkLNmibE7pg6XrhgxIX7Wsg6WwghcQJCpJ9RpdcXhIrbN1c8T08xu37BXFwE08SLoHM5SzVkqQxGozK0eabi2bAhuhdtoWqW3','127.0.0.1',0,'2019-02-04 19:24:49','2019-02-04 19:24:49','1f2a34f8-c6a8-4ee1-bf63-e364df216242',NULL,'Kyle andrew',NULL,'[\"\"]','',NULL,NULL,NULL,NULL,'no',NULL,NULL,NULL,NULL),
	(195,12,2,1,'yPODnpyPZJKAOIoETXcQOQnashlfXXygD9cvsweGiEpvwa6DRW07dXbYeFq78AeyX3ZZVHgAQTbc21ppat83jd1dv4KL9oTqEEtP','127.0.0.1',0,'2019-02-04 20:16:08','2019-02-04 20:16:08','2711aa09-42d2-4886-92fc-3fd49ecf7caa',NULL,'Test',NULL,'[\"\"]','',NULL,NULL,NULL,NULL,'no',NULL,NULL,NULL,NULL),
	(196,13,2,1,'mkVHg8a4BfzGFUGLxjqTd34nYyqgHluKnNw3UiuP4445xxX0169WyxIG4AnStpg9Pf0kguEprbBDhOxUkzz84kN5emXXtvD6mBTR','127.0.0.1',0,'2019-02-04 20:17:14','2019-02-04 20:17:14','e21b53cc-69df-4627-9fae-4bba566fd0db',NULL,'Kyle Andrews',NULL,'[\"kylea@page.works\"]','This is a message.',NULL,NULL,NULL,NULL,'no',NULL,NULL,NULL,NULL),
	(197,14,2,1,'hKIeGKrHoGIhobprtzUUURXz3WLPrwzYdS9fIKeDnEqXyooBPkrnvaDLNBc6fYEftNQqEhgFVt0M64PBCpJnwbEprQ1FfAM0ZsLN','127.0.0.1',0,'2019-02-04 20:19:33','2019-02-04 20:19:33','3a510a87-a90a-439f-bc17-0e7f794cd804',NULL,'Kyle Andrews',NULL,'[\"kylea@page.works\"]','This is a message.',NULL,NULL,NULL,NULL,'no',NULL,NULL,NULL,NULL),
	(198,15,2,1,'wqFpNdnLhKIyWSFSKolIcAKiaOMatVeUwU5HJscDwrMmas3JkUi28zRh8sj5Z87UnKTWFksZDSoIJmmpPWyPsHVIFhqHwMJdBIh7','127.0.0.1',0,'2019-02-04 20:20:22','2019-02-04 20:20:22','4990824d-f52b-4b20-abe9-de5d4f5dd7c9',NULL,'Kyle Andrews',NULL,'[\"kylea@page.works\"]','This is the message.',NULL,NULL,NULL,NULL,'no',NULL,NULL,NULL,NULL),
	(199,16,2,1,'Ip96zmZEeHZlwji5fLgtSRNVcgrrgSAks2Q2XWamE1yqZ5emL9sLd4RnlHqaUttOyuaFawvX72RwGwAw3goWRM7GESGVKuZxxoYg','127.0.0.1',0,'2019-02-05 17:35:12','2019-02-05 17:35:12','eb0f51ac-453c-47f9-9c42-5c35f4aedd41',NULL,'Kyle Andrews',NULL,'[\"kylea@page.works\"]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(200,17,2,1,'VtGXoZQJhLSD8fIfz3FXj0oGRj5OETnlBCJXwTLToTz2MPP6kML0rghzuvXoHtzFvWbw3I9fVd8wtkcJ7VPEpdB3lrgcY49x9kTl','127.0.0.1',0,'2019-02-05 17:40:20','2019-02-05 17:40:20','b001753d-fefd-4365-8837-bfcf353318e0',NULL,'Kyle Andrews',NULL,'[\"kylea@page.works\"]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(201,18,2,1,'n1KP83uTEmVntCMis5AYosxOPtDZIvH1WdukYZDTjPLvDsLvNy49yWrTV178BvtqFj0N5vMufO1DXJi72KatDYRokY4zNJjGSthU','127.0.0.1',0,'2019-02-05 17:41:02','2019-02-05 17:41:02','8bfaad0d-33d8-4c83-ba33-b40e79eeb210',NULL,'Kyle Andrews',NULL,'[\"kylea@page.works\"]',NULL,NULL,NULL,NULL,NULL,'no','yes',NULL,NULL,NULL),
	(202,19,2,1,'Z0xoS3IEPjZUk4wExk6eubCDmu08GRLviJHTnRzY6IpnC2oXpIzMYITHnRNRHzZWn32PjAFt4V27yWgM5LmVtnX1FxbJeipt8bAp','127.0.0.1',0,'2019-02-05 17:41:31','2019-02-05 17:41:31','c792728d-f5b9-4909-b018-f30c9e35f6c0','MI','Kyle Andrews',NULL,'[\"kylea@page.works\"]',NULL,'Wayland','49348',NULL,NULL,'no','yes',NULL,'520 Discovery Drive',NULL),
	(203,20,2,1,'r9kiNb8KRVonqlvnoMbOXTZ7hCq9C42Rlgx9zizpLlvTttVJfcZtWa2264gOXOUJZPqdiv90cNMw24IWTMYHZhzftjvLZf5TWnEu','127.0.0.1',0,'2019-02-05 17:46:06','2019-02-05 17:46:06','5cdbd6cc-bcc8-41a8-a2e2-bdca7b7eeed1','MI','Kyle Andrews','Pageworks','[\"kylea@page.works\"]',NULL,'Wayland','49348','Chocolate Chip Cookie Dough','[\"S\'mores\",\"Peanut Butter & Jelly\"]','no','yes',NULL,'520 Discovery Drive',NULL),
	(204,21,2,1,'7tpnZpAh9uLhlthIUg69EYVxMt0xpUM1wJSjmQhkX0Ve5tCOdMG0LsEwv41EK0DkIedCvTyr7tcVEpzSk8bZNR4ZuiDEBzZAAalQ','127.0.0.1',0,'2019-02-05 17:48:37','2019-02-05 17:48:37','b4d87ce1-8fe2-47eb-a706-65e706e6ceab','MI','Kyle Andrews','Pageworks','[\"kylea@page.works\"]',NULL,'Wayland','49348','Chocolate Chip Cookie Dough','[\"S\'mores\",\"Peanut Butter & Jelly\"]','no','yes',NULL,'520 Discovery Drive','[]'),
	(205,22,2,1,'SNt1rzQipDYb02OTEDFwTsoUUIzBo0M6p6Dk9oJr0foCVcqMqFd7cFiF1GKP6LoKb4OCwS4hDukLjLK9z5IC4PxjeLgLZ6DSwraK','127.0.0.1',0,'2019-02-05 17:51:29','2019-02-05 17:51:29','5b236af0-53df-40ff-9b78-219680c5fca1','MI','Kyle Andrews','Pageworks','[\"kylea@page.works\"]',NULL,'Wayland','49348','Chocolate Chip Cookie Dough','[\"S\'mores\",\"Peanut Butter & Jelly\"]','no','yes',NULL,'520 Discovery Drive','[]'),
	(206,23,2,1,'NY3T9EznCTAQ7jte5GZlYLjg6lkw9oq14TLBRWTsLmjwvnzU0RjkdvsITImFZcwjIfuG0bCTFphlkr9JcSj2l3KKCAqHdylm2VBE','127.0.0.1',0,'2019-02-05 18:04:26','2019-02-05 18:04:26','6ed7a2b7-4afd-47e4-8107-ea3087cb8132','MI','Kyle Andrews','Pageworks','[\"kylea@page.works\"]',NULL,'Wayland','49348','Chocolate Chip Cookie Dough','[\"S\'mores\",\"Peanut Butter & Jelly\"]','no','yes',NULL,'520 Discovery Drive','[]'),
	(207,24,2,1,'2o9i4f4gUtZVnwiUktuEpLOfbFORakQtM10MvpwxkeAguLPrW8W36LxpQdMuP0hXOhggRHqFAHOIfEwfQWANmEbHYqYZjWYP85QU','127.0.0.1',0,'2019-02-05 18:11:30','2019-02-05 18:11:30','6e23cf38-5b5a-41c6-b395-1a9d09e42eee','any','Kyle Andrews','Pageworks','[\"kylea@page.works\"]',NULL,'','','Chocolate Chip Cookie Dough','[\"S\'mores\",\"Peanut Butter & Jelly\"]','no','yes',NULL,'','[]'),
	(208,25,2,1,'JguXcSjCFgGgH45ast19VmGWDkY9MvMgGD0Zm1P7HLL6tItlXQsZMy327R1NMnRjqrcpyQecn2NJttoZfTKN6mNFoVcC9sYsA3iI','127.0.0.1',0,'2019-02-05 18:14:05','2019-02-05 18:14:05','634334b6-aa4e-46ee-b58f-5c4fd0f90b63','MI','Kyle Andrews','Pageworks','[\"kylea@page.works\"]',NULL,'Wayland','49348','Chocolate Chip Cookie Dough','[\"S\'mores\",\"Peanut Butter & Jelly\"]','no','yes',NULL,'520 Discovery Drive','[]'),
	(209,26,2,1,'vL9edbgY0ToK0j4uEyOQ6lMxgHAuyz8BWGbvibkBYH3S3cAoNh8AqCPVkzRegmjvehxYzqZds41PWt8ROHz7laHh12evrsnrIcyV','127.0.0.1',0,'2019-02-05 18:15:41','2019-02-05 18:15:41','6bb20be7-b80e-486a-bc8a-b3e30bd86dcb','any','Kyle Andrews','Pageworks','[\"kylea@page.works\"]',NULL,'','','Vanilla Bean','[\"S\'mores\",\"Rainbow Swirl\"]','no','yes',NULL,'','[]'),
	(210,27,2,1,'KMAfeH95WcNySbXZh9xzCHD2A22AShEzu8W8JlcbW58gpfhB9fpAshsUPqhp7nMU9PdcPuJnCi1LtoRGNfWBcT5ff07HFJTjDlAS','127.0.0.1',0,'2019-02-05 18:16:56','2019-02-05 18:16:56','7babaa13-e942-480f-9205-d997e14a8454','any','Kyle Andrews','Pageworks','[\"kylea@page.works\"]',NULL,'','','Chocolate Chip Cookie Dough','[\"S\'mores\",\"Peanut Butter & Jelly\"]','no','yes',NULL,'','[]'),
	(211,28,2,1,'h12XUqobEWmcvpdwPF5ymreVSD3dUTUrT0wszlfXZb0QYR8Z6PPsPGYO6ZnTLIzAijsLROXqPNzsW11qMJja1GWtVvk2mlNgxx0H','127.0.0.1',0,'2019-02-05 18:18:16','2019-02-05 18:18:16','bc0200ae-f43b-4620-a131-e674469687c6','any','Kyle Andrews','Pageworks','[\"kylea@page.works\"]',NULL,'','','Peanut Butter Cup','[]','no','yes',NULL,'','[]'),
	(212,29,2,1,'ymBbBFyS0h3JHayR4wMRKsgFM9t0kF6RPg76oydS7QwpLi2W4zwTqCD3rk0As4xwLJnJnI8tsvRdGsHExSmy0mbVcARyWSug4ijN','127.0.0.1',0,'2019-02-05 18:22:11','2019-02-05 18:22:11','d1645758-b2b3-4aa0-8e27-5a19abf74d53','any','Kyle Andrews','Pageworks','[\"kylea@page.works\"]',NULL,'','','Chocolate Chip Cookie Dough','[\"S\'mores\",\"Peanut Butter & Jelly\"]','no','yes',NULL,'','[]'),
	(213,30,2,1,'6GtTUIjMow161GGravfdXOq9iDMHoqbOtMKhcgT8d8FImq65makga3M742OQIr8IAqYQPtvxETecylRLbANz7EIHtAyGdJT2ckIX','127.0.0.1',0,'2019-02-05 18:24:43','2019-02-05 18:24:43','77392085-d036-4fa1-a94c-da6795bc2611','any','Kyle Andrews','Pageworks','[\"kylea@page.works\"]',NULL,'','','Chocolate Chip Cookie Dough','[\"S\'mores\",\"Peanut Butter & Jelly\"]','no','',NULL,'','[]'),
	(221,31,2,1,'IaJrL1493CsbPeToHUC5d4xM7aoANQLckMllNCGhhMrqlPC9vsRAtuYgt0se9lzid06DYVcf3AwmCFhJAHMjIES5fjRfUX9Iladi','127.0.0.1',0,'2019-02-05 18:54:05','2019-02-05 18:54:05','5fef81e1-d1e3-4479-9e1e-aa5a13557f38','MI','Kyle Andrews','','[\"andrewskyle28@gmail.com\"]',NULL,'Wayland','49348','Chocolate Chip Cookie Dough','[\"Gingerbread House\",\"Peanut Butter & Jelly\"]','no','yes',NULL,'520 Discovery Drive','[]'),
	(222,32,2,1,'H6sXvI0Epx4XwB8NQfNkIyT4yrST4hnUrSy1ENmQlRmfriJvcOyJOQstmNK1YgFXNJhsHAaNjT5Ot1zmjq4mEFKoy74tEMoTmIKu','127.0.0.1',0,'2019-02-05 18:57:23','2019-02-05 18:57:23','5fb14468-d6dc-4bae-94b5-9e126ea87dd7','MI','Kyle Andrews','','[\"andrewskyle28@gmail.com\"]',NULL,'Wayland','49348','Chocolate Chip Cookie Dough','[\"S\'mores\",\"Peanut Butter & Jelly\"]','no','yes',NULL,'520 Discovery Drive','[]'),
	(223,33,2,1,'DPk6v0IGFiXhsZ4Of73pSc7LkmCZoOcdho9JkL1RKXFhF590PIWp5rJBEp2A9czBBM29eMYYKcN8TqFJAgDU567aBhaSkDQlwtDu','127.0.0.1',0,'2019-02-05 19:07:18','2019-02-05 19:07:18','7d1bdad5-a476-40d1-a573-eac61cb49431','MI','Kyle Andrews','','[\"andrewskyle28@gmail.com\"]',NULL,'','','Chocolate Chip Cookie Dough','[\"S\'mores\",\"Peanut Butter & Jelly\"]','no','',NULL,'','[]'),
	(224,34,2,1,'90rU9kZcDiQgUujHDP7hhaH8N1Lzpl74Fw8A98HWg6gqtLxYx3u2YJDTfsf4WOQ2T2OHBmcRCJfHQqq9L86OpPoWvtu7Nonid6Ah','127.0.0.1',0,'2019-02-05 19:09:16','2019-02-05 19:09:16','45218da9-685d-4121-9c04-9d86c7ede535','any','Kyle Andrews','Pageworks','[\"kylea@page.works\"]',NULL,'','','Chocolate Chip Cookie Dough','[\"Gingerbread House\",\"Rainbow Swirl\",\"Peanut Butter & Jelly\"]','no','',NULL,'','[]'),
	(225,35,2,1,'MbHPLuYSxbLaochwrjMh02zNCytIZvjb1FKUL0zilctqsEtaMXb5SoaQU540clPGA4xG7rRVA98yz7P8ZMYnB7pKGKobwdNO1jDG','127.0.0.1',0,'2019-02-05 19:11:02','2019-02-05 19:11:02','637304fb-db4f-4392-b54b-b7e3a0252562','any','Kyle Andrews','Pageworks','[\"kylea@page.works\"]',NULL,'','','Chocolate Chip Cookie Dough','[\"S\'mores\",\"Rainbow Swirl\",\"Peanut Butter & Jelly\"]','no','',NULL,'','[]'),
	(226,36,2,1,'EqzNaw5LcqM8cKq0rAKyqANa1T6jdTdElIxUQFNzLCInfhYX0LCxNesVV5pLQ2FTp2ipuE6evOj5O586X17RlpHkJKds0LAls0HF','127.0.0.1',0,'2019-02-05 19:11:16','2019-02-05 19:11:16','ec9eeccf-e704-4b5a-acb0-454c2e7dd17f','any','Kyle Andrews','Pageworks','[\"kylea@page.works\"]',NULL,'','','Chocolate Chip Cookie Dough','[\"S\'mores\",\"Peanut Butter & Jelly\"]','no','yes',NULL,'','[]'),
	(227,37,2,1,'7GC24LMRLwGjd2lxrFtfVZ43eb2ISUubG2PNi3XbELJrCGT2UPUfBaMkOFUq5GOh1fQaTWT4hQnJB1votife1GWLduIX4psuarVd','127.0.0.1',0,'2019-02-05 19:22:30','2019-02-05 19:22:30','ea3f3025-6ddc-4925-ad7f-edfb4ac2baa2','MI','Kyle Andrews','','[\"andrewskyle28@gmail.com\"]',NULL,'Wayland','49348','Chocolate Chip Cookie Dough','[\"S\'mores\",\"Peanut Butter & Jelly\"]','no','',NULL,'520 Discovery Drive',NULL),
	(228,38,2,1,'PGD2kMKtVyx576LOV6oHF5vsVCFBBT2aDOxnS3DaOvVhT8FktvNecJcVE6EY50Xi8fC25yysrHiO0qvmu7hDn0zEwrCaR1gMeruK','127.0.0.1',0,'2019-02-05 19:24:23','2019-02-05 19:24:23','d233f9f4-c7ce-411f-988d-fb78537d4eb5','any','Kyle Andrews','','[\"kylea@page.works\"]',NULL,'','','Chocolate Chip Cookie Dough','[\"S\'mores\",\"Peanut Butter & Jelly\"]','no','',NULL,'',NULL),
	(229,39,2,1,'Lp6GL4c3rm6GZ1TeEW1npcnNWsxZQP01OvAvZUEeE85wBPe38OxNZKIGj6wFtUVQkdmaUTu6XtGvH49RTCVnXKirhKA61ipeDymj','127.0.0.1',0,'2019-02-05 19:25:29','2019-02-05 19:25:29','bfe64431-265c-4482-9593-25aa4e18ed89','any','Khfdeerf','','[\"khhiii@gted.com\"]',NULL,'','','Chocolate Chip Cookie Dough','[\"S\'mores\",\"Peanut Butter & Jelly\"]','no','',NULL,'',NULL),
	(230,40,2,1,'wklu2HGyVup2nPug6SB98WcLO6gGwXC92M7tlSjx4BrjJRhuPAo8p2aNCGWl7Ukwj2eTFM0eWBrAVoHWfE8FzA46l4QAhHSY4FRh','127.0.0.1',0,'2019-02-05 19:36:08','2019-02-05 19:36:08','bac8de78-b874-4563-8715-b37f96d4f99b','any','Kyle','','[\"khgfff@fhi.com\"]',NULL,'','','Chocolate','[\"Rainbow Swirl\"]','no','yes',NULL,'',NULL),
	(231,41,2,1,'ZsxOQnliQrJRJizWL4wP0lcKpYSHKph1vaAIKOy4RKIY0OpjoPSpB6toVlSjo4s4v91qmwcLZJCfNF6YPsY40bmQ0YRrfZ6PCgj1','127.0.0.1',0,'2019-02-05 19:40:12','2019-02-05 19:40:12','2d81eca2-3041-45f8-97cb-c42ae66d202c','MI','Peter Tell','Pageworks','[\"pete@page.works\"]',NULL,'Grand Rapids','49505','Birthday Cake','[\"Pumpkin Pie\",\"Gingerbread House\",\"S\'mores\"]','no','',NULL,'2801 Oak Industrial Dr',NULL),
	(232,42,2,1,'CETLR7wuhpm20JXCL7J9A2BCoBsL2ej6roeBukBTVEmpB40p1hN5jpB16uhJTwUIpFzccZaYRZkWCQYvb13c6d4E2Kzf3IxLLf0C','127.0.0.1',0,'2019-02-05 19:43:59','2019-02-05 19:43:59','16d3b851-bc14-49a7-83ac-65e78ce4e6c8','any','Peter Tell','','[\"pete@page.works\"]',NULL,'Grand Rapids','49505','Birthday Cake','[\"Pumpkin Pie\",\"Gingerbread House\",\"S\'mores\",\"Peanut Butter & Jelly\"]','no','',NULL,'2801 Oak Industrial Dr',NULL),
	(233,43,2,1,'78dOX0QaJxJ9G236D4UFFQjJEXIVGjuonO7Exn5fMExZL7zbt2TKxJE93WDAwfkjCWuP0EYo02XKr4JCYdCcegCj2nqyDP1dEhqJ','127.0.0.1',0,'2019-02-05 19:49:14','2019-02-05 19:49:14','b48f07b0-9722-4560-926a-d4b57676965b','any','Peter Tell','Pageworks','[\"pete@page.works\"]',NULL,'','','Peanut Butter Cup','[]','no','yes',NULL,'',NULL),
	(234,44,2,1,'aIuM7BgAt4NVQzQTecv2SADTSDGhaxP3pZp1GvvaIwywo7wFfMEo9ZlqNcvhnMh9Ds3xcAHBoBxQ08KrNLexizdcvibDH5zjQxKo','127.0.0.1',0,'2019-02-05 20:12:55','2019-02-05 20:12:55','8b4819c6-dbf1-4566-a87c-16e7bc8ab625','any','Kyle Andrews','','[\"kylea@page.works\"]',NULL,'','','Peanut Butter Cup','[]','no','yes',NULL,'',NULL),
	(235,45,2,1,'AVGPxwOPaSUIzb8BoGWF1qjxWt1D6p5qzREgs87wBpIcTy54RAwbrlQoa2WmwDS3iBJQiHWJzwWyRA6aW6iy3ZLp4wsqgi2EgyJP','127.0.0.1',0,'2019-02-05 20:18:37','2019-02-05 20:18:37','a994be58-9d45-47b5-9d27-a07401725f17','any','Kyle Andrews','','[\"kylea@page.works\"]',NULL,'','','Cookies & Cream','[\"S\'mores\",\"Peanut Butter & Jelly\"]','no','yes',NULL,'',NULL),
	(236,46,2,1,'s48OWPS7Z3UOosWZx6zu17vgmDbgnvGPY82k9B3WrOT4NzPSOe6X1SQZEDtOrj2JqcyKwaXrmtnt1nO6rzulXRtt28VXVyxyMU18','127.0.0.1',0,'2019-02-05 20:18:38','2019-02-05 20:18:38','4af42c5a-44c2-4f91-aa3f-1b3e589f3a4d','any','Kyle Andrews','','[\"kylea@page.works\"]',NULL,'','','Cookies & Cream','[\"Gingerbread House\",\"S\'mores\",\"Peanut Butter & Jelly\"]','no','',NULL,'',NULL),
	(237,47,2,1,'E6lSAWQOwyaxIp6DK2GiMdtCDBpXln7Aaz62ZclwEK8Qrgmf0B6YiarTLK5SMSSmLy6CvjKSWqkOWbQvSWEpAdGb7mCwOPDUVB43','127.0.0.1',0,'2019-02-05 20:19:56','2019-02-05 20:19:56','cc34538f-8c04-4039-b0c4-4c6942a0ff63','any','Kyle Andrews','','[\"kylea@page.works\"]',NULL,'','','Vanilla Bean','[\"S\'mores\",\"Peanut Butter & Jelly\"]','no','yes',NULL,'',NULL),
	(238,48,2,1,'paS3pe2FsM3oWkRTBaNGnnrBKfgxp4kRLO0HMzFBqT5PW62M7lk7y72y0bSu0v8WHoigrWrs9t2FZnpmTmhZMwOygv8hVRyyOiug','127.0.0.1',0,'2019-02-05 20:42:14','2019-02-05 20:42:14','0a96fbc5-45ec-4e4c-8f6a-7bc750775efe','MI','Kyle Andrews','','[\"kylea@page.works\"]',NULL,'Wayland','49348','Chocolate Chip Cookie Dough','[\"S\'mores\",\"Peanut Butter & Jelly\"]','no','',NULL,'520 Discovery Drive',NULL);

/*!40000 ALTER TABLE `pt_freeform_submissions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_freeform_unfinalized_files
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_freeform_unfinalized_files`;

CREATE TABLE `pt_freeform_unfinalized_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_globalsets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_globalsets`;

CREATE TABLE `pt_globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `globalsets_name_unq_idx` (`name`),
  UNIQUE KEY `globalsets_handle_unq_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `pt_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_info`;

CREATE TABLE `pt_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `config` mediumtext,
  `configMap` mediumtext,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_info` WRITE;
/*!40000 ALTER TABLE `pt_info` DISABLE KEYS */;

INSERT INTO `pt_info` (`id`, `version`, `schemaVersion`, `maintenance`, `config`, `configMap`, `fieldVersion`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'3.1.8','3.1.23',0,'a:18:{s:12:\"dateModified\";i:1549717699;s:10:\"siteGroups\";a:1:{s:36:\"f5eb95d0-c53e-4630-b230-91539b9e08b2\";a:1:{s:4:\"name\";s:7:\"Website\";}}s:5:\"sites\";a:1:{s:36:\"ac246379-14f1-440a-82f2-90ef2b3e6443\";a:8:{s:9:\"siteGroup\";s:36:\"f5eb95d0-c53e-4630-b230-91539b9e08b2\";s:4:\"name\";s:22:\"Papertrain Boilerplate\";s:6:\"handle\";s:7:\"default\";s:8:\"language\";s:5:\"en-US\";s:7:\"hasUrls\";b:0;s:7:\"baseUrl\";N;s:9:\"sortOrder\";i:1;s:7:\"primary\";b:1;}}s:8:\"sections\";a:1:{s:36:\"b192f8ce-1e5a-495d-bb45-ede8cd1ad3d4\";a:8:{s:4:\"name\";s:14:\"Standard Pages\";s:6:\"handle\";s:13:\"standardPages\";s:4:\"type\";s:9:\"structure\";s:16:\"enableVersioning\";s:1:\"1\";s:16:\"propagateEntries\";s:1:\"1\";s:9:\"structure\";a:2:{s:3:\"uid\";s:36:\"705621d5-28f2-4ec0-b53c-8500b2bb1fd8\";s:9:\"maxLevels\";s:1:\"2\";}s:10:\"entryTypes\";a:1:{s:36:\"314ff677-634c-4a48-8499-6c2817266962\";a:7:{s:4:\"name\";s:14:\"Standard Pages\";s:6:\"handle\";s:13:\"standardPages\";s:13:\"hasTitleField\";s:1:\"1\";s:10:\"titleLabel\";s:5:\"Title\";s:11:\"titleFormat\";N;s:9:\"sortOrder\";s:1:\"1\";s:12:\"fieldLayouts\";a:1:{s:36:\"49f16c08-2073-4897-8f3e-92355d39b819\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:15:\"Complex Content\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:1:{s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}}}}}}}}s:12:\"siteSettings\";a:1:{s:36:\"ac246379-14f1-440a-82f2-90ef2b3e6443\";a:4:{s:16:\"enabledByDefault\";s:1:\"1\";s:7:\"hasUrls\";s:1:\"1\";s:9:\"uriFormat\";s:20:\"{parent.slug}/{slug}\";s:8:\"template\";s:22:\"_complex-content/entry\";}}}}s:11:\"fieldGroups\";a:3:{s:36:\"8dcdb4b8-5035-411c-8f7f-5e255dcca924\";a:1:{s:4:\"name\";s:6:\"Common\";}s:36:\"2e631263-d760-43da-adbd-abb7189fbd52\";a:1:{s:4:\"name\";s:13:\"Site Settings\";}s:36:\"f6bc4796-9e3b-4819-b11d-f927a538e259\";a:1:{s:4:\"name\";s:7:\"Generic\";}}s:6:\"fields\";a:12:{s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";a:10:{s:4:\"name\";s:15:\"Complex Content\";s:6:\"handle\";s:2:\"cc\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Matrix\";s:8:\"settings\";a:4:{s:9:\"minBlocks\";s:0:\"\";s:9:\"maxBlocks\";s:0:\"\";s:12:\"contentTable\";s:21:\"{{%matrixcontent_cc}}\";s:14:\"localizeBlocks\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"8dcdb4b8-5035-411c-8f7f-5e255dcca924\";}s:36:\"a4fc8798-7670-4c7d-8c07-1af37af0df28\";a:10:{s:4:\"name\";s:5:\"text1\";s:6:\"handle\";s:5:\"text1\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"f6bc4796-9e3b-4819-b11d-f927a538e259\";}s:36:\"7cd24d1f-404a-48a0-a451-b5102c825080\";a:10:{s:4:\"name\";s:5:\"text2\";s:6:\"handle\";s:5:\"text2\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"f6bc4796-9e3b-4819-b11d-f927a538e259\";}s:36:\"ec11902d-33d1-437e-ac69-364410d941c6\";a:10:{s:4:\"name\";s:9:\"headline1\";s:6:\"handle\";s:9:\"headline1\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"f6bc4796-9e3b-4819-b11d-f927a538e259\";}s:36:\"e87fc440-8cda-4676-96d6-abb2d3b7dd1b\";a:10:{s:4:\"name\";s:9:\"headline2\";s:6:\"handle\";s:9:\"headline2\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"f6bc4796-9e3b-4819-b11d-f927a538e259\";}s:36:\"6fd20f12-c213-4fdd-9101-e95ef0374376\";a:10:{s:4:\"name\";s:12:\"subheadline1\";s:6:\"handle\";s:12:\"subheadline1\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"f6bc4796-9e3b-4819-b11d-f927a538e259\";}s:36:\"c63dc6b6-8f1e-4497-8e7a-b612a9570514\";a:10:{s:4:\"name\";s:12:\"subheadline2\";s:6:\"handle\";s:12:\"subheadline2\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"f6bc4796-9e3b-4819-b11d-f927a538e259\";}s:36:\"977bde35-60a4-4c06-a5e6-5fc91f15a300\";a:10:{s:4:\"name\";s:12:\"singleImage1\";s:6:\"handle\";s:12:\"singleImage1\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:0:\"\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:b7f7001c-8d6f-4341-a869-732554429306\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:1:\"1\";s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:7:\"sources\";a:1:{i:0;s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";}s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:5:\"large\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:12:\"Add an Image\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"f6bc4796-9e3b-4819-b11d-f927a538e259\";}s:36:\"c8b641ec-3e88-4250-af11-570112faac51\";a:10:{s:4:\"name\";s:10:\"thumbnail1\";s:6:\"handle\";s:10:\"thumbnail1\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:0:\"\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:b7f7001c-8d6f-4341-a869-732554429306\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:1:\"1\";s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:7:\"sources\";a:1:{i:0;s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";}s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:5:\"large\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:12:\"Add an Image\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"f6bc4796-9e3b-4819-b11d-f927a538e259\";}s:36:\"bb8a8db1-01fa-4444-9cb5-5a95acc7957e\";a:10:{s:4:\"name\";s:6:\"video1\";s:6:\"handle\";s:6:\"video1\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:1:\"1\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:b7f7001c-8d6f-4341-a869-732554429306\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:1:\"1\";s:12:\"allowedKinds\";a:1:{i:0;s:5:\"video\";}s:7:\"sources\";s:1:\"*\";s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:5:\"large\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:11:\"Add a Video\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"f6bc4796-9e3b-4819-b11d-f927a538e259\";}s:36:\"e8be50dd-1413-4c51-810a-c5ff874b571e\";a:10:{s:4:\"name\";s:5:\"copy1\";s:6:\"handle\";s:5:\"copy1\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:20:\"craft\\redactor\\Field\";s:8:\"settings\";a:7:{s:14:\"redactorConfig\";s:10:\"Basic.json\";s:14:\"purifierConfig\";s:0:\"\";s:11:\"cleanupHtml\";s:1:\"1\";s:10:\"purifyHtml\";s:1:\"1\";s:10:\"columnType\";s:4:\"text\";s:16:\"availableVolumes\";s:0:\"\";s:19:\"availableTransforms\";s:1:\"*\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"f6bc4796-9e3b-4819-b11d-f927a538e259\";}s:36:\"18c487ab-e98e-4854-b79b-aac154acd122\";a:10:{s:4:\"name\";s:5:\"copy2\";s:6:\"handle\";s:5:\"copy2\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:20:\"craft\\redactor\\Field\";s:8:\"settings\";a:7:{s:14:\"redactorConfig\";s:10:\"Basic.json\";s:14:\"purifierConfig\";s:0:\"\";s:11:\"cleanupHtml\";s:1:\"1\";s:10:\"purifyHtml\";s:1:\"1\";s:10:\"columnType\";s:4:\"text\";s:16:\"availableVolumes\";s:0:\"\";s:19:\"availableTransforms\";s:1:\"*\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"f6bc4796-9e3b-4819-b11d-f927a538e259\";}}s:16:\"matrixBlockTypes\";a:12:{s:36:\"9c7038b3-900d-4b50-a5ee-7c445a476f87\";a:6:{s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:4:\"name\";s:7:\"Section\";s:6:\"handle\";s:15:\"sectionSettings\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:6:{s:36:\"fb2fb216-c076-435d-b399-bb0c92cbc106\";a:10:{s:4:\"name\";s:16:\"Background Color\";s:6:\"handle\";s:15:\"backgroundColor\";s:12:\"instructions\";s:45:\"Please select this sections background color.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:4:{i:0;a:3:{s:5:\"label\";s:5:\"White\";s:5:\"value\";s:16:\"-base-background\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:9:\"Off White\";s:5:\"value\";s:21:\"-secondary-background\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:9:\"Off Black\";s:5:\"value\";s:16:\"-dark-background\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:5:\"Brand\";s:5:\"value\";s:17:\"-brand-background\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"d3f64f5e-8d98-4cfe-bc55-10e5c2497fff\";a:10:{s:4:\"name\";s:16:\"Background Image\";s:6:\"handle\";s:15:\"backgroundImage\";s:12:\"instructions\";s:98:\"Optional background image for the section. This image will override the selected background color.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:0:\"\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:1:\"1\";s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:7:\"sources\";a:1:{i:0;s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";}s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:5:\"large\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:22:\"Add a Background Image\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"36459edb-92eb-4e49-b582-883cd750f9fd\";a:10:{s:4:\"name\";s:16:\"Background Video\";s:6:\"handle\";s:15:\"backgroundVideo\";s:12:\"instructions\";s:108:\"Optional background video for the section. This video will override the selected background color and image.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:0:\"\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:02433cef-1aec-4478-8f75-f5570480c436\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:1:\"1\";s:12:\"allowedKinds\";a:1:{i:0;s:5:\"video\";}s:7:\"sources\";a:1:{i:0;s:43:\"volume:02433cef-1aec-4478-8f75-f5570480c436\";}s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:5:\"large\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:22:\"Add a Background Video\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"c043d1ea-bbda-4790-9b09-ca031caf54d4\";a:10:{s:4:\"name\";s:7:\"Overlay\";s:6:\"handle\";s:7:\"overlay\";s:12:\"instructions\";s:62:\"Select an optional overlay for your background video or image.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:4:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:4:\"none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:5:\"Light\";s:5:\"value\";s:13:\"35,35,35,0.33\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:6:\"Medium\";s:5:\"value\";s:12:\"35,35,35,0.6\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:4:\"Dark\";s:5:\"value\";s:13:\"35,35,35,0.87\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"d939cdb6-5f72-48ee-b805-f16dde284b4a\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:37:\"Add additional padding to this block.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:5:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:0:\"\";}i:1;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:5:\"Large\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:1:\"1\";}i:3;a:3:{s:5:\"label\";s:4:\"Huge\";s:5:\"value\";s:3:\"-x6\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:7:\"Massive\";s:5:\"value\";s:3:\"-x8\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"af04a3f1-22e2-4182-a22d-c6a44383b788\";a:10:{s:4:\"name\";s:12:\"Padding Type\";s:6:\"handle\";s:11:\"paddingType\";s:12:\"instructions\";s:54:\"Select where the additional padding should be applied.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:3:{i:0;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:18:\"Add Padding Bottom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"cccaf184-6482-40a9-bdc8-acaaebe6917f\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:6:{s:36:\"fb2fb216-c076-435d-b399-bb0c92cbc106\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}s:36:\"d3f64f5e-8d98-4cfe-bc55-10e5c2497fff\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"36459edb-92eb-4e49-b582-883cd750f9fd\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}s:36:\"c043d1ea-bbda-4790-9b09-ca031caf54d4\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}s:36:\"d939cdb6-5f72-48ee-b805-f16dde284b4a\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:5;}s:36:\"af04a3f1-22e2-4182-a22d-c6a44383b788\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:6;}}}}}}}s:36:\"e99be65c-5fee-4c83-9eed-8050793be42a\";a:6:{s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:4:\"name\";s:7:\"Heading\";s:6:\"handle\";s:7:\"heading\";s:9:\"sortOrder\";i:4;s:6:\"fields\";a:5:{s:36:\"c1466ef0-df37-4a2f-9ecb-82d6e9b3a223\";a:10:{s:4:\"name\";s:4:\"Copy\";s:6:\"handle\";s:4:\"copy\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"d6747373-70b8-49ad-82bd-33370282ee35\";a:10:{s:4:\"name\";s:9:\"Font Size\";s:6:\"handle\";s:8:\"fontSize\";s:12:\"instructions\";s:29:\"How large should the font be?\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:6:{i:0;a:3:{s:5:\"label\";s:4:\"Huge\";s:5:\"value\";s:4:\"o-h1\";s:7:\"default\";s:0:\"\";}i:1;a:3:{s:5:\"label\";s:5:\"Large\";s:5:\"value\";s:4:\"o-h2\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:6:\"Medium\";s:5:\"value\";s:4:\"o-h3\";s:7:\"default\";s:1:\"1\";}i:3;a:3:{s:5:\"label\";s:5:\"Small\";s:5:\"value\";s:4:\"o-h4\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:5:\"Title\";s:5:\"value\";s:4:\"o-h5\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:8:\"Subtitle\";s:5:\"value\";s:4:\"o-h6\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"4421109a-d1a4-4e10-b64a-87b84b5a3773\";a:10:{s:4:\"name\";s:9:\"Alignment\";s:6:\"handle\";s:9:\"alignment\";s:12:\"instructions\";s:34:\"How should the heading be aligned?\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:3:{i:0;a:3:{s:5:\"label\";s:4:\"Left\";s:5:\"value\";s:11:\"u-text-left\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:6:\"Center\";s:5:\"value\";s:13:\"u-text-center\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:5:\"Right\";s:5:\"value\";s:12:\"u-text-right\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"93f6127f-2098-4d92-89a9-6c353bb22799\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:37:\"Add additional padding to this block.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:6:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:7:\"Quarter\";s:5:\"value\";s:8:\"-quarter\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:4:\"Half\";s:5:\"value\";s:5:\"-half\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:2:\"x2\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:2:\"x4\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"f16ece4b-b4a4-4532-9b03-305f0e107a9d\";a:10:{s:4:\"name\";s:12:\"Padding Type\";s:6:\"handle\";s:11:\"paddingType\";s:12:\"instructions\";s:54:\"Select where the additional padding should be applied.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:7:{i:0;a:3:{s:5:\"label\";s:16:\"Add Full Padding\";s:5:\"value\";s:9:\"u-padding\";s:7:\"default\";s:0:\"\";}i:1;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:22:\"Add Horizontal Padding\";s:5:\"value\";s:20:\"u-padding-horizontal\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:18:\"Add Padding Bottom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:16:\"Add Padding Left\";s:5:\"value\";s:14:\"u-padding-left\";s:7:\"default\";s:0:\"\";}i:6;a:3:{s:5:\"label\";s:17:\"Add Padding Right\";s:5:\"value\";s:15:\"u-padding-right\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"39856f0c-11eb-4fe4-a60d-07e698ae181c\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:5:{s:36:\"c1466ef0-df37-4a2f-9ecb-82d6e9b3a223\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}s:36:\"d6747373-70b8-49ad-82bd-33370282ee35\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"4421109a-d1a4-4e10-b64a-87b84b5a3773\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}s:36:\"93f6127f-2098-4d92-89a9-6c353bb22799\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}s:36:\"f16ece4b-b4a4-4532-9b03-305f0e107a9d\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:5;}}}}}}}s:36:\"27f153c6-09ef-408c-a85b-50ee37263d52\";a:6:{s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:4:\"name\";s:9:\"Container\";s:6:\"handle\";s:9:\"container\";s:9:\"sortOrder\";i:2;s:6:\"fields\";a:6:{s:36:\"bbe771e9-89c0-4471-936a-5ebecf254b9b\";a:10:{s:4:\"name\";s:5:\"Width\";s:6:\"handle\";s:5:\"width\";s:12:\"instructions\";s:43:\"How wide should this sections container be?\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:3:{i:0;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:11:\"o-container\";s:7:\"default\";s:0:\"\";}i:1;a:3:{s:5:\"label\";s:6:\"Narrow\";s:5:\"value\";s:18:\"o-container-narrow\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:4:\"Full\";s:5:\"value\";s:16:\"o-container-full\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"a74d8612-5ca0-4325-9e7a-903893117219\";a:10:{s:4:\"name\";s:13:\"Column Layout\";s:6:\"handle\";s:12:\"columnLayout\";s:12:\"instructions\";s:38:\"Please select a column layout pattern.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:5:{i:0;a:3:{s:5:\"label\";s:5:\"Whole\";s:5:\"value\";s:1:\"1\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:6:\"Halves\";s:5:\"value\";s:1:\"2\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:6:\"Thirds\";s:5:\"value\";s:1:\"3\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:9:\"1/3 & 2/3\";s:5:\"value\";s:1:\"4\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:9:\"2/3 & 1/3\";s:5:\"value\";s:1:\"5\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"27da4f8a-238c-4681-b862-712689ec9187\";a:10:{s:4:\"name\";s:13:\"Column Gutter\";s:6:\"handle\";s:12:\"columnGutter\";s:12:\"instructions\";s:47:\"How large of a gap between columns do you want?\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:4:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:12:\"-gutter-none\";s:7:\"default\";s:0:\"\";}i:1;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:7:\"-gutter\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:5:\"Small\";s:5:\"value\";s:13:\"-gutter-small\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:5:\"Large\";s:5:\"value\";s:13:\"-gutter-large\";s:7:\"default\";s:1:\"1\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"0318fd31-af0c-42d5-8f82-bda65318cbd2\";a:10:{s:4:\"name\";s:14:\"Vertical Align\";s:6:\"handle\";s:13:\"verticalAlign\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:3:{i:0;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:10:\"-align-top\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:6:\"Middle\";s:5:\"value\";s:13:\"-align-center\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:6:\"Bottom\";s:5:\"value\";s:10:\"-align-end\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"a8818a76-5083-4143-95ac-e666c321a091\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:37:\"Add additional padding to this block.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:4:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:2:\"x2\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:2:\"x4\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"4c98e4da-8268-4e63-be65-60c159ffde69\";a:10:{s:4:\"name\";s:12:\"Padding Type\";s:6:\"handle\";s:11:\"paddingType\";s:12:\"instructions\";s:54:\"Select where the additional padding should be applied.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:3:{i:0;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:18:\"Add Padding Bottom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"cb1fed6a-0e67-4c84-8d89-ebba225f2dad\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:6:{s:36:\"bbe771e9-89c0-4471-936a-5ebecf254b9b\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}s:36:\"a74d8612-5ca0-4325-9e7a-903893117219\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"27da4f8a-238c-4681-b862-712689ec9187\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}s:36:\"0318fd31-af0c-42d5-8f82-bda65318cbd2\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}s:36:\"a8818a76-5083-4143-95ac-e666c321a091\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:5;}s:36:\"4c98e4da-8268-4e63-be65-60c159ffde69\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:6;}}}}}}}s:36:\"8ca7c03d-aa9b-4611-b6be-6862e9a89ce1\";a:6:{s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:4:\"name\";s:10:\"End Column\";s:6:\"handle\";s:9:\"endColumn\";s:9:\"sortOrder\";i:3;s:6:\"fields\";a:0:{}s:12:\"fieldLayouts\";a:1:{s:36:\"4455065f-9480-4863-8fad-e12f4b0ddf84\";a:1:{s:4:\"tabs\";a:1:{i:0;a:2:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;}}}}}s:36:\"d40a8732-c577-4d4a-a737-05fa930be6a2\";a:6:{s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:4:\"name\";s:4:\"Copy\";s:6:\"handle\";s:4:\"copy\";s:9:\"sortOrder\";i:5;s:6:\"fields\";a:5:{s:36:\"9d5e8bb8-07be-40ec-803f-8296fa980c92\";a:10:{s:4:\"name\";s:4:\"Body\";s:6:\"handle\";s:4:\"body\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:20:\"craft\\redactor\\Field\";s:8:\"settings\";a:7:{s:14:\"redactorConfig\";s:20:\"Complex-Content.json\";s:14:\"purifierConfig\";s:0:\"\";s:11:\"cleanupHtml\";s:1:\"1\";s:10:\"purifyHtml\";s:1:\"1\";s:10:\"columnType\";s:4:\"text\";s:16:\"availableVolumes\";s:0:\"\";s:19:\"availableTransforms\";s:1:\"*\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"799dbe03-d659-4f0d-8598-926a4ddb37c0\";a:10:{s:4:\"name\";s:9:\"Alignment\";s:6:\"handle\";s:9:\"alignment\";s:12:\"instructions\";s:45:\"How should the copy in this block be aligned?\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:4:{i:0;a:3:{s:5:\"label\";s:4:\"Left\";s:5:\"value\";s:11:\"u-text-left\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:6:\"Center\";s:5:\"value\";s:13:\"u-text-center\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:5:\"Right\";s:5:\"value\";s:12:\"u-text-right\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:7:\"Justify\";s:5:\"value\";s:14:\"u-text-justify\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"2bbdb90a-3923-4b0f-b400-b3469f2cae63\";a:10:{s:4:\"name\";s:13:\"Column Layout\";s:6:\"handle\";s:12:\"columnLayout\";s:12:\"instructions\";s:39:\"Split the copy across multiple columns.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:3:{i:0;a:3:{s:5:\"label\";s:10:\"One Column\";s:5:\"value\";s:14:\"-single-column\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:11:\"Two Columns\";s:5:\"value\";s:14:\"-double-column\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:13:\"Three Columns\";s:5:\"value\";s:15:\"-tripple-column\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"46892785-d8f7-443a-9215-a6fbbfc2e066\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:37:\"Add additional padding to this block.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:6:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:7:\"Quarter\";s:5:\"value\";s:8:\"-quarter\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:4:\"Hafl\";s:5:\"value\";s:5:\"-half\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:2:\"x2\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:2:\"x4\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"d85da825-7ece-4810-af33-232c2cddf7d5\";a:10:{s:4:\"name\";s:12:\"Padding Type\";s:6:\"handle\";s:11:\"paddingType\";s:12:\"instructions\";s:54:\"Select where the additional padding should be applied.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:7:{i:0;a:3:{s:5:\"label\";s:16:\"Add Full Padding\";s:5:\"value\";s:9:\"u-padding\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:22:\"Add Horizontal Padding\";s:5:\"value\";s:20:\"u-padding-horizontal\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:18:\"Add Padding Bottom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:16:\"Add Padding Left\";s:5:\"value\";s:14:\"u-padding-left\";s:7:\"default\";s:0:\"\";}i:6;a:3:{s:5:\"label\";s:17:\"Add Padding Right\";s:5:\"value\";s:15:\"u-padding-right\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"4b28f1e5-4fd6-4d61-af99-5adc926b4e45\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:5:{s:36:\"9d5e8bb8-07be-40ec-803f-8296fa980c92\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}s:36:\"799dbe03-d659-4f0d-8598-926a4ddb37c0\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"2bbdb90a-3923-4b0f-b400-b3469f2cae63\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}s:36:\"46892785-d8f7-443a-9215-a6fbbfc2e066\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}s:36:\"d85da825-7ece-4810-af33-232c2cddf7d5\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:5;}}}}}}}s:36:\"8cfe5e31-20a9-4ddc-ba3d-790f1b405450\";a:6:{s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:4:\"name\";s:5:\"Image\";s:6:\"handle\";s:5:\"image\";s:9:\"sortOrder\";i:6;s:6:\"fields\";a:10:{s:36:\"34b63d30-e96e-4923-8396-7f331ac44ccd\";a:10:{s:4:\"name\";s:5:\"Image\";s:6:\"handle\";s:5:\"image\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:0:\"\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:1:\"1\";s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:7:\"sources\";a:1:{i:0;s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";}s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:5:\"large\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:12:\"Add an Image\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"d81bf538-6c2f-47cb-a776-ffda5ecb3da1\";a:10:{s:4:\"name\";s:12:\"Aspect Ratio\";s:6:\"handle\";s:11:\"aspectRatio\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:6:{i:0;a:3:{s:5:\"label\";s:4:\"16:9\";s:5:\"value\";s:12:\"u-ratio-16/9\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:3:\"1:1\";s:5:\"value\";s:11:\"u-ratio-1/1\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:3:\"4:3\";s:5:\"value\";s:11:\"u-ratio-4/3\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:3:\"2:3\";s:5:\"value\";s:11:\"u-ratio-2/3\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:6:\"Banner\";s:5:\"value\";s:13:\"u-ratio-36/10\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:4:\"none\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"1393ae5b-e051-4f54-9c23-fea61b8ef0fe\";a:10:{s:4:\"name\";s:11:\"Image Width\";s:6:\"handle\";s:10:\"imageWidth\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Number\";s:8:\"settings\";a:5:{s:12:\"defaultValue\";s:3:\"840\";s:3:\"min\";s:3:\"250\";s:3:\"max\";s:4:\"1920\";s:8:\"decimals\";i:0;s:4:\"size\";N;}s:17:\"contentColumnType\";s:11:\"smallint(4)\";s:10:\"fieldGroup\";N;}s:36:\"ab8da4d3-dc99-4cb3-a978-347132b072ca\";a:10:{s:4:\"name\";s:15:\"Image Alignment\";s:6:\"handle\";s:14:\"imageAlignment\";s:12:\"instructions\";s:53:\"Align applied to images with an Aspect Ratio of None.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:3:{i:0;a:3:{s:5:\"label\";s:4:\"Left\";s:5:\"value\";s:11:\"u-text-left\";s:7:\"default\";s:0:\"\";}i:1;a:3:{s:5:\"label\";s:6:\"Center\";s:5:\"value\";s:13:\"u-text-center\";s:7:\"default\";s:1:\"1\";}i:2;a:3:{s:5:\"label\";s:5:\"Right\";s:5:\"value\";s:12:\"u-text-right\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"33b35b3f-2dee-492a-b10e-ae7ef65688f9\";a:10:{s:4:\"name\";s:9:\"Crop Zoom\";s:6:\"handle\";s:8:\"cropZoom\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Number\";s:8:\"settings\";a:5:{s:12:\"defaultValue\";s:1:\"1\";s:3:\"min\";s:1:\"1\";s:3:\"max\";s:1:\"3\";s:8:\"decimals\";s:1:\"2\";s:4:\"size\";N;}s:17:\"contentColumnType\";s:12:\"decimal(3,2)\";s:10:\"fieldGroup\";N;}s:36:\"89593cd3-f8b6-4c0d-9060-e2e0eb2dde8e\";a:10:{s:4:\"name\";s:16:\"Enable Lightcase\";s:6:\"handle\";s:15:\"enableLightcase\";s:12:\"instructions\";s:97:\"When enabled users can click on the image to view a larger version of the image in a popup modal.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:24:\"craft\\fields\\Lightswitch\";s:8:\"settings\";a:1:{s:7:\"default\";s:0:\"\";}s:17:\"contentColumnType\";s:7:\"boolean\";s:10:\"fieldGroup\";N;}s:36:\"a5c58651-f39a-4384-a7c6-28ad2390f2e9\";a:10:{s:4:\"name\";s:9:\"Grayscale\";s:6:\"handle\";s:9:\"grayscale\";s:12:\"instructions\";s:41:\"Enable to convert the image to grayscale.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:24:\"craft\\fields\\Lightswitch\";s:8:\"settings\";a:1:{s:7:\"default\";s:0:\"\";}s:17:\"contentColumnType\";s:7:\"boolean\";s:10:\"fieldGroup\";N;}s:36:\"a23aaf6c-855c-4031-b283-e5076716fa3a\";a:10:{s:4:\"name\";s:7:\"Overlay\";s:6:\"handle\";s:7:\"overlay\";s:12:\"instructions\";s:48:\"Select an optional overlay color for your image.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:5:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:4:\"none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:5:\"Light\";s:5:\"value\";s:13:\"35,35,35,0.33\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:6:\"Medium\";s:5:\"value\";s:12:\"35,35,35,0.6\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:4:\"Dark\";s:5:\"value\";s:13:\"35,35,35,0.87\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:3:\"Red\";s:5:\"value\";s:13:\"242,86,82,0.6\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"71df45f7-bad9-4989-8d4b-8e056b6e712a\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:37:\"Add additional padding to this block.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:6:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:7:\"Quarter\";s:5:\"value\";s:8:\"-quarter\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:4:\"Half\";s:5:\"value\";s:5:\"-half\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:2:\"x2\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:2:\"x4\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"efaf6859-2c1a-4909-bc9e-38bd725624ec\";a:10:{s:4:\"name\";s:12:\"Padding Type\";s:6:\"handle\";s:11:\"paddingType\";s:12:\"instructions\";s:54:\"Select where the additional padding should be applied.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:7:{i:0;a:3:{s:5:\"label\";s:16:\"Add Full Padding\";s:5:\"value\";s:9:\"u-padding\";s:7:\"default\";s:0:\"\";}i:1;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:22:\"Add Horizontal Padding\";s:5:\"value\";s:20:\"u-padding-horizontal\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:18:\"Add Padding Bottom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:16:\"Add Padding Left\";s:5:\"value\";s:14:\"u-padding-left\";s:7:\"default\";s:0:\"\";}i:6;a:3:{s:5:\"label\";s:17:\"Add Padding Right\";s:5:\"value\";s:15:\"u-padding-right\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"93482697-e9bb-4748-bd38-cd3eb28b0f93\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:10:{s:36:\"34b63d30-e96e-4923-8396-7f331ac44ccd\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}s:36:\"d81bf538-6c2f-47cb-a776-ffda5ecb3da1\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"1393ae5b-e051-4f54-9c23-fea61b8ef0fe\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}s:36:\"ab8da4d3-dc99-4cb3-a978-347132b072ca\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}s:36:\"33b35b3f-2dee-492a-b10e-ae7ef65688f9\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:5;}s:36:\"89593cd3-f8b6-4c0d-9060-e2e0eb2dde8e\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:6;}s:36:\"a5c58651-f39a-4384-a7c6-28ad2390f2e9\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:7;}s:36:\"a23aaf6c-855c-4031-b283-e5076716fa3a\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:8;}s:36:\"71df45f7-bad9-4989-8d4b-8e056b6e712a\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:9;}s:36:\"efaf6859-2c1a-4909-bc9e-38bd725624ec\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:10;}}}}}}}s:36:\"86843e26-821b-41e7-8e3e-87321802c139\";a:6:{s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:4:\"name\";s:7:\"Buttons\";s:6:\"handle\";s:7:\"buttons\";s:9:\"sortOrder\";i:7;s:6:\"fields\";a:4:{s:36:\"16afd3ef-94de-4db2-87a1-26b358f4aa61\";a:10:{s:4:\"name\";s:7:\"Buttons\";s:6:\"handle\";s:7:\"buttons\";s:12:\"instructions\";s:27:\"Add call to action buttons.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:39:\"verbb\\supertable\\fields\\SuperTableField\";s:8:\"settings\";a:8:{s:7:\"minRows\";s:1:\"1\";s:7:\"maxRows\";s:1:\"3\";s:12:\"contentTable\";s:18:\"{{%stc_7_buttons}}\";s:14:\"localizeBlocks\";b:0;s:11:\"staticField\";s:0:\"\";s:7:\"columns\";a:2:{i:40;a:1:{s:5:\"width\";s:0:\"\";}i:41;a:1:{s:5:\"width\";s:0:\"\";}}s:11:\"fieldLayout\";s:6:\"matrix\";s:14:\"selectionLabel\";s:12:\"Add a Button\";}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"972a946c-797a-4f9c-8681-aaa29ef67856\";a:10:{s:4:\"name\";s:9:\"Alignment\";s:6:\"handle\";s:9:\"alignment\";s:12:\"instructions\";s:34:\"How should the buttons be aligned?\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:5:{i:0;a:3:{s:5:\"label\";s:12:\"Left Aligned\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:14:\"Center Aligned\";s:5:\"value\";s:15:\"-justify-center\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:13:\"Right Aligned\";s:5:\"value\";s:12:\"-justify-end\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:13:\"Space Between\";s:5:\"value\";s:14:\"-space-between\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:12:\"Space Around\";s:5:\"value\";s:13:\"-space-around\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"afa0d0fd-406e-4d41-9c96-e5f5d59b058f\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:37:\"Add additional padding to this block.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:6:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:7:\"Quarter\";s:5:\"value\";s:8:\"-quarter\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:4:\"Half\";s:5:\"value\";s:5:\"-half\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:2:\"x2\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:2:\"x4\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"1d7cea56-a8d6-4502-874c-779e624b3bf5\";a:10:{s:4:\"name\";s:12:\"Padding Type\";s:6:\"handle\";s:11:\"paddingType\";s:12:\"instructions\";s:54:\"Select where the additional padding should be applied.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:7:{i:0;a:3:{s:5:\"label\";s:16:\"Add Full Padding\";s:5:\"value\";s:9:\"u-padding\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:22:\"Add Horizontal Padding\";s:5:\"value\";s:20:\"u-padding-horizontal\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:18:\"Add Padding Buttom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:16:\"Add Padding Left\";s:5:\"value\";s:14:\"u-padding-left\";s:7:\"default\";s:0:\"\";}i:6;a:3:{s:5:\"label\";s:17:\"Add Padding Right\";s:5:\"value\";s:15:\"u-padding-right\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"e17d5a6b-1851-4037-9aba-45296cc932dc\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:4:{s:36:\"16afd3ef-94de-4db2-87a1-26b358f4aa61\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}s:36:\"972a946c-797a-4f9c-8681-aaa29ef67856\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"afa0d0fd-406e-4d41-9c96-e5f5d59b058f\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}s:36:\"1d7cea56-a8d6-4502-874c-779e624b3bf5\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}}}}}}}s:36:\"42b013df-72dc-41a5-941f-d7a299502e38\";a:6:{s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:4:\"name\";s:10:\"Pull Quote\";s:6:\"handle\";s:9:\"pullQuote\";s:9:\"sortOrder\";i:8;s:6:\"fields\";a:5:{s:36:\"71e1aa18-0063-405d-955e-74b5ec1514b2\";a:10:{s:4:\"name\";s:4:\"Body\";s:6:\"handle\";s:4:\"body\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"cbdbc09b-11a0-4b1a-a0bd-5b991c3c75eb\";a:10:{s:4:\"name\";s:6:\"Source\";s:6:\"handle\";s:6:\"source\";s:12:\"instructions\";s:40:\"Optional source or author for the quote.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"984c9a76-6153-41af-9f4b-fbff36a88709\";a:10:{s:4:\"name\";s:11:\"Quote Style\";s:6:\"handle\";s:10:\"quoteStyle\";s:12:\"instructions\";s:27:\"Select a quote block style.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:2:{i:0;a:3:{s:5:\"label\";s:5:\"Large\";s:5:\"value\";s:6:\"-large\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:5:\"Block\";s:5:\"value\";s:6:\"-block\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"ebbd92ad-ec15-4d07-ae91-eccbb307569b\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:37:\"Add additional padding to this block.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:7:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:7:\"Quarter\";s:5:\"value\";s:8:\"-quarter\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:4:\"Half\";s:5:\"value\";s:5:\"-half\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:2:\"x2\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:2:\"x4\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:0:\"\";}i:6;a:3:{s:5:\"label\";s:2:\"x6\";s:5:\"value\";s:3:\"-x6\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"f544af32-b279-49f9-9fa4-60c1d0391b85\";a:10:{s:4:\"name\";s:12:\"Padding Type\";s:6:\"handle\";s:11:\"paddingType\";s:12:\"instructions\";s:54:\"Select where the additional padding should be applied.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:7:{i:0;a:3:{s:5:\"label\";s:16:\"Add Full Padding\";s:5:\"value\";s:9:\"u-padding\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:22:\"Add Horizontal Padding\";s:5:\"value\";s:20:\"u-padding-horizontal\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:18:\"Add Padding Bottom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:16:\"Add Padding Left\";s:5:\"value\";s:14:\"u-padding-left\";s:7:\"default\";s:0:\"\";}i:6;a:3:{s:5:\"label\";s:17:\"Add Padding Right\";s:5:\"value\";s:15:\"u-padding-right\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"cbe6b628-b4ac-4766-88ff-b47c38af7989\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:5:{s:36:\"71e1aa18-0063-405d-955e-74b5ec1514b2\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}s:36:\"cbdbc09b-11a0-4b1a-a0bd-5b991c3c75eb\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"984c9a76-6153-41af-9f4b-fbff36a88709\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}s:36:\"ebbd92ad-ec15-4d07-ae91-eccbb307569b\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}s:36:\"f544af32-b279-49f9-9fa4-60c1d0391b85\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:5;}}}}}}}s:36:\"411496be-9759-4334-803e-790121fdee23\";a:6:{s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:4:\"name\";s:7:\"Gallery\";s:6:\"handle\";s:7:\"gallery\";s:9:\"sortOrder\";i:9;s:6:\"fields\";a:6:{s:36:\"00ccd03b-0a70-4fed-a14d-a0b846ecad51\";a:10:{s:4:\"name\";s:6:\"Slides\";s:6:\"handle\";s:6:\"slides\";s:12:\"instructions\";s:26:\"Add slides to the gallery.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:0:\"\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:1:\"1\";s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:7:\"sources\";a:1:{i:0;s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";}s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:5:\"large\";s:5:\"limit\";s:0:\"\";s:14:\"selectionLabel\";s:12:\"Add an Image\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"f40a44dd-80c9-41bd-92f8-11ea5934e78d\";a:10:{s:4:\"name\";s:16:\"Slide Transition\";s:6:\"handle\";s:15:\"slideTransition\";s:12:\"instructions\";s:109:\"Select how fast the slides transition. Setting this option to manual forces the user initiate the transition.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:4:{i:0;a:3:{s:5:\"label\";s:6:\"Manual\";s:5:\"value\";s:2:\"-1\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:4:\"Slow\";s:5:\"value\";s:2:\"12\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:6:\"Medium\";s:5:\"value\";s:1:\"7\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:4:\"Fast\";s:5:\"value\";s:1:\"5\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"0ed585b2-9d94-4ebc-a088-f12f4474ecf4\";a:10:{s:4:\"name\";s:5:\"Style\";s:6:\"handle\";s:5:\"style\";s:12:\"instructions\";s:23:\"Select a gallery style.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:4:{i:0;a:3:{s:5:\"label\";s:4:\"Fade\";s:5:\"value\";s:4:\"fade\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:5:\"Slide\";s:5:\"value\";s:5:\"slide\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:5:\"Stack\";s:5:\"value\";s:5:\"stack\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:8:\"Parallax\";s:5:\"value\";s:8:\"parallax\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"3b24986d-c663-48f7-86ca-a778bebbcd82\";a:10:{s:4:\"name\";s:12:\"Aspect Ratio\";s:6:\"handle\";s:11:\"aspectRatio\";s:12:\"instructions\";s:34:\"Select the galleries aspect ratio.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:3:{i:0;a:3:{s:5:\"label\";s:3:\"1:1\";s:5:\"value\";s:11:\"u-ratio-1/1\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:3:\"2:3\";s:5:\"value\";s:11:\"u-ratio-2/3\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:4:\"16:9\";s:5:\"value\";s:12:\"u-ratio-16/9\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"0bf2b1b8-e3d3-47f7-bc51-628bd536b65c\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:37:\"Add additional padding to this block.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:6:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:7:\"Quarter\";s:5:\"value\";s:8:\"-quarter\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:4:\"Half\";s:5:\"value\";s:5:\"-half\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:2:\"x2\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:2:\"x4\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"418c41b9-d777-4c60-b660-7f8421a7f12d\";a:10:{s:4:\"name\";s:12:\"Padding Type\";s:6:\"handle\";s:11:\"paddingType\";s:12:\"instructions\";s:54:\"Select where the additional padding should be applied.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:7:{i:0;a:3:{s:5:\"label\";s:16:\"Add Full Padding\";s:5:\"value\";s:9:\"u-padding\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:22:\"Add Horizontal Padding\";s:5:\"value\";s:20:\"u-padding-horizontal\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:18:\"Add Padding Bottom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:16:\"Add Padding Left\";s:5:\"value\";s:14:\"u-padding-left\";s:7:\"default\";s:0:\"\";}i:6;a:3:{s:5:\"label\";s:17:\"Add Padding Right\";s:5:\"value\";s:15:\"u-padding-right\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"57b3a20d-8b2a-4bce-a97d-b60a88dc71d9\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:6:{s:36:\"00ccd03b-0a70-4fed-a14d-a0b846ecad51\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}s:36:\"f40a44dd-80c9-41bd-92f8-11ea5934e78d\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"0ed585b2-9d94-4ebc-a088-f12f4474ecf4\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}s:36:\"3b24986d-c663-48f7-86ca-a778bebbcd82\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}s:36:\"0bf2b1b8-e3d3-47f7-bc51-628bd536b65c\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:5;}s:36:\"418c41b9-d777-4c60-b660-7f8421a7f12d\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:6;}}}}}}}s:36:\"2cb049e6-b35a-4271-8861-0bbde459b042\";a:6:{s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:4:\"name\";s:9:\"Accordion\";s:6:\"handle\";s:9:\"accordion\";s:9:\"sortOrder\";i:10;s:6:\"fields\";a:4:{s:36:\"89bb2fb3-11df-43a8-bc0e-dc9282624357\";a:10:{s:4:\"name\";s:4:\"Rows\";s:6:\"handle\";s:4:\"rows\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:39:\"verbb\\supertable\\fields\\SuperTableField\";s:8:\"settings\";a:8:{s:7:\"minRows\";s:0:\"\";s:7:\"maxRows\";s:0:\"\";s:12:\"contentTable\";s:16:\"{{%stc_10_rows}}\";s:14:\"localizeBlocks\";b:0;s:11:\"staticField\";s:0:\"\";s:7:\"columns\";a:5:{i:61;a:1:{s:5:\"width\";s:0:\"\";}i:62;a:1:{s:5:\"width\";s:0:\"\";}i:71;a:1:{s:5:\"width\";s:0:\"\";}i:72;a:1:{s:5:\"width\";s:0:\"\";}i:73;a:1:{s:5:\"width\";s:0:\"\";}}s:11:\"fieldLayout\";s:3:\"row\";s:14:\"selectionLabel\";s:0:\"\";}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"f8b603ed-7622-42e8-a6ca-022ec1da1159\";a:10:{s:4:\"name\";s:9:\"Multi Row\";s:6:\"handle\";s:8:\"multiRow\";s:12:\"instructions\";s:124:\"When enabled users can open up several rows. When disabled when a user opens a row the previously opened row will be closed.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:24:\"craft\\fields\\Lightswitch\";s:8:\"settings\";a:1:{s:7:\"default\";s:0:\"\";}s:17:\"contentColumnType\";s:7:\"boolean\";s:10:\"fieldGroup\";N;}s:36:\"5842ae73-b069-45a3-b28a-0149781ddbea\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:37:\"Add additional padding to this block.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:6:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:7:\"Quarter\";s:5:\"value\";s:8:\"-quarter\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:4:\"Half\";s:5:\"value\";s:5:\"-half\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:2:\"x2\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:2:\"x4\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"b5e83c8a-e3ac-4e7f-aa5b-ae31369fe8b2\";a:10:{s:4:\"name\";s:12:\"Padding Type\";s:6:\"handle\";s:11:\"paddingType\";s:12:\"instructions\";s:54:\"Select where the additional padding should be applied.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:7:{i:0;a:3:{s:5:\"label\";s:16:\"Add Full Padding\";s:5:\"value\";s:9:\"u-padding\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:22:\"Add Horizontal Padding\";s:5:\"value\";s:20:\"u-padding-horizontal\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:18:\"Add Padding Buttom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:16:\"Add Padding Left\";s:5:\"value\";s:14:\"u-padding-left\";s:7:\"default\";s:0:\"\";}i:6;a:3:{s:5:\"label\";s:17:\"Add Padding Right\";s:5:\"value\";s:15:\"u-padding-right\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"94c10d74-960d-479e-85fd-ece5fa16eaeb\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:4:{s:36:\"89bb2fb3-11df-43a8-bc0e-dc9282624357\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}s:36:\"f8b603ed-7622-42e8-a6ca-022ec1da1159\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"5842ae73-b069-45a3-b28a-0149781ddbea\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}s:36:\"b5e83c8a-e3ac-4e7f-aa5b-ae31369fe8b2\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}}}}}}}s:36:\"3bf9043f-ddd4-4d72-b83d-c984f46fdecf\";a:6:{s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:4:\"name\";s:4:\"List\";s:6:\"handle\";s:4:\"list\";s:9:\"sortOrder\";i:11;s:6:\"fields\";a:5:{s:36:\"9fcae5d9-54cc-4ce1-9ade-6fa31442abf1\";a:10:{s:4:\"name\";s:10:\"List Items\";s:6:\"handle\";s:9:\"listItems\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:39:\"verbb\\supertable\\fields\\SuperTableField\";s:8:\"settings\";a:8:{s:7:\"minRows\";s:1:\"1\";s:7:\"maxRows\";s:0:\"\";s:12:\"contentTable\";s:21:\"{{%stc_11_listitems}}\";s:14:\"localizeBlocks\";b:0;s:11:\"staticField\";s:0:\"\";s:7:\"columns\";a:1:{i:66;a:1:{s:5:\"width\";s:0:\"\";}}s:11:\"fieldLayout\";s:3:\"row\";s:14:\"selectionLabel\";s:0:\"\";}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"462274cc-3cdd-49e8-83f2-c197f47959e8\";a:10:{s:4:\"name\";s:10:\"List Style\";s:6:\"handle\";s:9:\"listStyle\";s:12:\"instructions\";s:28:\"Select a style for the list.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:2:{i:0;a:3:{s:5:\"label\";s:7:\"Default\";s:5:\"value\";s:8:\"-default\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:4:\"Plus\";s:5:\"value\";s:5:\"-plus\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"fd4b318a-37e0-4db3-b40c-bb76badfae2e\";a:10:{s:4:\"name\";s:9:\"Alignment\";s:6:\"handle\";s:9:\"alignment\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:3:{i:0;a:3:{s:5:\"label\";s:4:\"Left\";s:5:\"value\";s:11:\"u-text-left\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:6:\"Center\";s:5:\"value\";s:13:\"u-text-center\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:5:\"Right\";s:5:\"value\";s:12:\"u-text-right\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"0c87ae8e-ce72-414a-8f65-38af1031d8bc\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:37:\"Add additional padding to this block.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:6:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:7:\"Quarter\";s:5:\"value\";s:8:\"-quarter\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:4:\"Half\";s:5:\"value\";s:5:\"-half\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:2:\"x2\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:2:\"x4\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"de8d5f7b-33fb-44be-b39a-2eab11dc3b9f\";a:10:{s:4:\"name\";s:12:\"Padding Type\";s:6:\"handle\";s:11:\"paddingType\";s:12:\"instructions\";s:54:\"Select where the additional padding should be applied.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:7:{i:0;a:3:{s:5:\"label\";s:16:\"Add Full Padding\";s:5:\"value\";s:9:\"u-padding\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:22:\"Add Horizontal Padding\";s:5:\"value\";s:20:\"u-padding-horizontal\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:18:\"Add Padding Bottom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:16:\"Add Padding Left\";s:5:\"value\";s:14:\"u-padding-left\";s:7:\"default\";s:0:\"\";}i:6;a:3:{s:5:\"label\";s:17:\"Add Padding Right\";s:5:\"value\";s:15:\"u-padding-right\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"54e4b974-31e5-45f1-80c3-8074ec779330\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:5:{s:36:\"9fcae5d9-54cc-4ce1-9ade-6fa31442abf1\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}s:36:\"462274cc-3cdd-49e8-83f2-c197f47959e8\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"fd4b318a-37e0-4db3-b40c-bb76badfae2e\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}s:36:\"0c87ae8e-ce72-414a-8f65-38af1031d8bc\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}s:36:\"de8d5f7b-33fb-44be-b39a-2eab11dc3b9f\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:5;}}}}}}}s:36:\"84f5b143-6cfd-4a3f-892f-e52a1b2731ee\";a:6:{s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:4:\"name\";s:4:\"Form\";s:6:\"handle\";s:4:\"form\";s:9:\"sortOrder\";i:12;s:6:\"fields\";a:5:{s:36:\"e733f390-3ace-4314-a59c-43f9f1dc1d19\";a:10:{s:4:\"name\";s:13:\"Selected Form\";s:6:\"handle\";s:12:\"selectedForm\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:42:\"Solspace\\Freeform\\FieldTypes\\FormFieldType\";s:8:\"settings\";a:0:{}s:17:\"contentColumnType\";s:7:\"integer\";s:10:\"fieldGroup\";N;}s:36:\"7bc9cddb-43cb-400c-a9d8-e924124151d2\";a:10:{s:4:\"name\";s:10:\"Form Style\";s:6:\"handle\";s:9:\"formStyle\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:3:{i:0;a:3:{s:5:\"label\";s:9:\"Underline\";s:5:\"value\";s:10:\"-underline\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:5:\"Solid\";s:5:\"value\";s:6:\"-solid\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:7:\"Outline\";s:5:\"value\";s:8:\"-outline\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"8132823b-72a1-4d56-ab84-7a6ea737d29b\";a:10:{s:4:\"name\";s:18:\"Submission Message\";s:6:\"handle\";s:17:\"submissionMessage\";s:12:\"instructions\";s:81:\"This is the message that will be displayed after the user has submitted the form.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:20:\"craft\\redactor\\Field\";s:8:\"settings\";a:7:{s:14:\"redactorConfig\";s:11:\"Simple.json\";s:14:\"purifierConfig\";s:0:\"\";s:11:\"cleanupHtml\";s:1:\"1\";s:10:\"purifyHtml\";s:1:\"1\";s:10:\"columnType\";s:4:\"text\";s:16:\"availableVolumes\";s:0:\"\";s:19:\"availableTransforms\";s:1:\"*\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"f135a445-114f-4b17-90bc-1d7445a454f3\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:91:\"Add additional padding to this block. Leave as \'none\' if you don\'t want additional padding.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:6:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:7:\"Quarter\";s:5:\"value\";s:8:\"-quarter\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:4:\"Half\";s:5:\"value\";s:5:\"-thin\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:2:\"x2\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:2:\"x4\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"dac84921-0c24-4f81-a8aa-eb7f141abc90\";a:10:{s:4:\"name\";s:12:\"Padding Type\";s:6:\"handle\";s:11:\"paddingType\";s:12:\"instructions\";s:54:\"Select where the additional padding should be applied.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:7:{i:0;a:3:{s:5:\"label\";s:16:\"Add Full Padding\";s:5:\"value\";s:9:\"u-padding\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:22:\"Add Horizontal Padding\";s:5:\"value\";s:20:\"u-padding-horizontal\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:18:\"Add Padding Bottom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:16:\"Add Padding Left\";s:5:\"value\";s:14:\"u-padding-left\";s:7:\"default\";s:0:\"\";}i:6;a:3:{s:5:\"label\";s:17:\"Add Padding Right\";s:5:\"value\";s:15:\"u-padding-right\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"690cb536-5cb0-499e-9a5e-c39d45484f10\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:5:{s:36:\"e733f390-3ace-4314-a59c-43f9f1dc1d19\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}s:36:\"7bc9cddb-43cb-400c-a9d8-e924124151d2\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"8132823b-72a1-4d56-ab84-7a6ea737d29b\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}s:36:\"f135a445-114f-4b17-90bc-1d7445a454f3\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}s:36:\"dac84921-0c24-4f81-a8aa-eb7f141abc90\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:5;}}}}}}}}s:7:\"volumes\";a:3:{s:36:\"ea6beeac-3da3-43fe-a530-47032076abb2\";a:7:{s:4:\"name\";s:6:\"Images\";s:6:\"handle\";s:6:\"images\";s:4:\"type\";s:19:\"craft\\volumes\\Local\";s:7:\"hasUrls\";b:1;s:3:\"url\";s:23:\"@rootUrl/uploads/images\";s:8:\"settings\";a:1:{s:4:\"path\";s:23:\"@webroot/uploads/images\";}s:9:\"sortOrder\";s:1:\"1\";}s:36:\"02433cef-1aec-4478-8f75-f5570480c436\";a:7:{s:4:\"name\";s:6:\"Videos\";s:6:\"handle\";s:6:\"videos\";s:4:\"type\";s:19:\"craft\\volumes\\Local\";s:7:\"hasUrls\";b:1;s:3:\"url\";s:23:\"@rootUrl/uploads/videos\";s:8:\"settings\";a:1:{s:4:\"path\";s:23:\"@webroot/uploads/videos\";}s:9:\"sortOrder\";s:1:\"2\";}s:36:\"b7f7001c-8d6f-4341-a869-732554429306\";a:7:{s:4:\"name\";s:12:\"User Uploads\";s:6:\"handle\";s:11:\"userUploads\";s:4:\"type\";s:19:\"craft\\volumes\\Local\";s:7:\"hasUrls\";b:0;s:3:\"url\";s:0:\"\";s:8:\"settings\";a:1:{s:4:\"path\";s:18:\"@root/user-uploads\";}s:9:\"sortOrder\";N;}}s:14:\"categoryGroups\";a:0:{}s:9:\"tagGroups\";a:0:{}s:5:\"users\";a:5:{s:24:\"requireEmailVerification\";b:1;s:23:\"allowPublicRegistration\";b:0;s:12:\"defaultGroup\";N;s:14:\"photoVolumeUid\";N;s:12:\"photoSubpath\";s:0:\"\";}s:10:\"globalSets\";a:0:{}s:7:\"plugins\";a:9:{s:12:\"eager-beaver\";a:4:{s:8:\"settings\";N;s:10:\"licenseKey\";N;s:7:\"enabled\";s:1:\"1\";s:13:\"schemaVersion\";s:5:\"1.0.0\";}s:6:\"imager\";a:4:{s:8:\"settings\";N;s:10:\"licenseKey\";N;s:7:\"enabled\";s:1:\"1\";s:13:\"schemaVersion\";s:5:\"2.0.0\";}s:6:\"splash\";a:4:{s:8:\"settings\";a:4:{s:6:\"volume\";s:1:\"1\";s:11:\"authorField\";s:0:\"\";s:14:\"authorUrlField\";s:0:\"\";s:10:\"colorField\";s:0:\"\";}s:10:\"licenseKey\";N;s:7:\"enabled\";s:1:\"1\";s:13:\"schemaVersion\";s:5:\"3.0.0\";}s:8:\"freeform\";a:4:{s:8:\"settings\";a:34:{s:10:\"pluginName\";s:5:\"Forms\";s:21:\"formTemplateDirectory\";s:15:\"_includes/forms\";s:22:\"emailTemplateDirectory\";N;s:20:\"emailTemplateStorage\";s:2:\"db\";s:11:\"defaultView\";s:9:\"dashboard\";s:17:\"fieldDisplayOrder\";s:4:\"name\";s:12:\"showTutorial\";s:0:\"\";s:14:\"removeNewlines\";s:0:\"\";s:16:\"defaultTemplates\";s:0:\"\";s:13:\"footerScripts\";s:1:\"0\";s:17:\"formSubmitDisable\";s:0:\"\";s:16:\"freeformHoneypot\";s:1:\"1\";s:23:\"spamProtectionBehaviour\";s:16:\"simulate_success\";s:25:\"submissionThrottlingCount\";s:0:\"\";s:29:\"submissionThrottlingTimeFrame\";s:1:\"m\";s:13:\"blockedEmails\";s:0:\"\";s:15:\"blockedKeywords\";s:0:\"\";s:20:\"blockedKeywordsError\";s:18:\"Invalid Entry Data\";s:18:\"blockedEmailsError\";s:21:\"Invalid Email Address\";s:26:\"showErrorsForBlockedEmails\";s:0:\"\";s:28:\"showErrorsForBlockedKeywords\";s:0:\"\";s:18:\"blockedIpAddresses\";s:0:\"\";s:27:\"purgableSubmissionAgeInDays\";s:1:\"0\";s:21:\"purgableSpamAgeInDays\";s:1:\"0\";s:20:\"salesforce_client_id\";N;s:24:\"salesforce_client_secret\";N;s:19:\"salesforce_username\";N;s:19:\"salesforce_password\";N;s:17:\"spamFolderEnabled\";s:0:\"\";s:16:\"recaptchaEnabled\";b:0;s:12:\"recaptchaKey\";N;s:15:\"recaptchaSecret\";N;s:23:\"renderFormHtmlInCpViews\";s:1:\"1\";s:18:\"autoScrollToErrors\";s:1:\"1\";}s:10:\"licenseKey\";N;s:7:\"enabled\";s:1:\"1\";s:13:\"schemaVersion\";s:5:\"2.1.3\";}s:8:\"redactor\";a:4:{s:8:\"settings\";N;s:10:\"licenseKey\";N;s:7:\"enabled\";s:1:\"1\";s:13:\"schemaVersion\";s:5:\"2.2.1\";}s:11:\"super-table\";a:4:{s:8:\"settings\";N;s:10:\"licenseKey\";N;s:7:\"enabled\";s:1:\"1\";s:13:\"schemaVersion\";s:5:\"2.0.8\";}s:14:\"typedlinkfield\";a:4:{s:8:\"settings\";N;s:10:\"licenseKey\";N;s:7:\"enabled\";s:1:\"1\";s:13:\"schemaVersion\";s:5:\"1.0.0\";}s:7:\"relabel\";a:3:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"1.1.0\";}s:5:\"spoon\";a:3:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"3.0.0\";}}s:5:\"email\";a:5:{s:9:\"fromEmail\";s:21:\"$SYSTEM_EMAIL_ADDRESS\";s:8:\"fromName\";s:18:\"$SYSTEM_EMAIL_NAME\";s:8:\"template\";N;s:13:\"transportType\";s:37:\"craft\\mail\\transportadapters\\Sendmail\";s:17:\"transportSettings\";N;}s:6:\"system\";a:5:{s:7:\"edition\";s:4:\"solo\";s:4:\"live\";b:1;s:4:\"name\";s:12:\"$SYSTEM_NAME\";s:8:\"timeZone\";s:16:\"America/New_York\";s:13:\"schemaVersion\";s:6:\"3.1.23\";}s:15:\"imageTransforms\";a:0:{}s:6:\"routes\";a:0:{}s:20:\"superTableBlockTypes\";a:3:{s:36:\"e1d8381e-e9da-4f7a-897a-7ca3280e4deb\";a:3:{s:5:\"field\";s:36:\"16afd3ef-94de-4db2-87a1-26b358f4aa61\";s:6:\"fields\";a:2:{s:36:\"42cf42aa-aed4-47d0-b3f9-8ee81b134df4\";a:10:{s:4:\"name\";s:4:\"Link\";s:6:\"handle\";s:10:\"buttonLink\";s:12:\"instructions\";s:38:\"Where should the button take the user?\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:31:\"typedlinkfield\\fields\\LinkField\";s:8:\"settings\";a:9:{s:15:\"allowCustomText\";s:1:\"1\";s:16:\"allowedLinkNames\";a:7:{i:1;s:5:\"asset\";i:2;s:8:\"category\";i:3;s:5:\"entry\";i:6;s:6:\"custom\";i:7;s:5:\"email\";i:8;s:3:\"tel\";i:9;s:3:\"url\";}s:11:\"allowTarget\";s:1:\"1\";s:14:\"autoNoReferrer\";s:0:\"\";s:15:\"defaultLinkName\";s:5:\"entry\";s:11:\"defaultText\";s:0:\"\";s:15:\"enableAriaLabel\";s:0:\"\";s:11:\"enableTitle\";s:0:\"\";s:12:\"typeSettings\";a:9:{s:5:\"asset\";a:2:{s:7:\"sources\";s:1:\"*\";s:16:\"allowCustomQuery\";s:0:\"\";}s:8:\"category\";a:2:{s:7:\"sources\";s:1:\"*\";s:16:\"allowCustomQuery\";s:0:\"\";}s:5:\"entry\";a:2:{s:7:\"sources\";s:1:\"*\";s:16:\"allowCustomQuery\";s:0:\"\";}s:4:\"site\";a:1:{s:5:\"sites\";s:1:\"*\";}s:4:\"user\";a:2:{s:7:\"sources\";s:1:\"*\";s:16:\"allowCustomQuery\";s:0:\"\";}s:6:\"custom\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:5:\"email\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"tel\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"url\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}}}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"ee572988-84e1-46e8-8b29-c23ce20bac43\";a:10:{s:4:\"name\";s:12:\"Button Style\";s:6:\"handle\";s:11:\"buttonStyle\";s:12:\"instructions\";s:27:\"How should the button look?\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:6:{i:0;a:3:{s:5:\"label\";s:19:\"Basic Action Button\";s:5:\"value\";s:5:\"-base\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:18:\"Solid Style Button\";s:5:\"value\";s:6:\"-solid\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:20:\"Outline Style Button\";s:5:\"value\";s:8:\"-outline\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:19:\"Raised Style Button\";s:5:\"value\";s:7:\"-raised\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:26:\"Rounded Solid Style Button\";s:5:\"value\";s:13:\"-solid -round\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:28:\"Rounded Outline Style Button\";s:5:\"value\";s:15:\"-outline -round\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"975abb82-2d2e-45a0-8cef-bb19c73b3d2e\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:2:{s:36:\"42cf42aa-aed4-47d0-b3f9-8ee81b134df4\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}s:36:\"ee572988-84e1-46e8-8b29-c23ce20bac43\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}}}}}}}s:36:\"061368e4-5312-4599-93a2-c40f7165b4b6\";a:3:{s:5:\"field\";s:36:\"89bb2fb3-11df-43a8-bc0e-dc9282624357\";s:6:\"fields\";a:5:{s:36:\"c7b72005-a498-41f9-979d-67d815d408e3\";a:10:{s:4:\"name\";s:7:\"Heading\";s:6:\"handle\";s:7:\"heading\";s:12:\"instructions\";s:33:\"What is the heading for this row?\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:2:\"32\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"a255042b-ffbc-48c6-87b5-dff502c8251d\";a:10:{s:4:\"name\";s:4:\"Body\";s:6:\"handle\";s:4:\"body\";s:12:\"instructions\";s:17:\"Copy for the row.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:20:\"craft\\redactor\\Field\";s:8:\"settings\";a:7:{s:14:\"redactorConfig\";s:10:\"Basic.json\";s:14:\"purifierConfig\";s:0:\"\";s:11:\"cleanupHtml\";s:1:\"1\";s:10:\"purifyHtml\";s:1:\"1\";s:10:\"columnType\";s:4:\"text\";s:16:\"availableVolumes\";s:0:\"\";s:19:\"availableTransforms\";s:1:\"*\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"d5822862-1769-4f56-bdd9-03d7aeb583a1\";a:10:{s:4:\"name\";s:4:\"List\";s:6:\"handle\";s:4:\"list\";s:12:\"instructions\";s:79:\"Optional list element for the row. The list will be placed below any body copy.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:18:\"craft\\fields\\Table\";s:8:\"settings\";a:6:{s:11:\"addRowLabel\";s:15:\"Add a List Item\";s:7:\"maxRows\";s:2:\"18\";s:7:\"minRows\";s:1:\"0\";s:7:\"columns\";a:1:{s:4:\"col1\";a:4:{s:7:\"heading\";s:9:\"List Item\";s:6:\"handle\";s:8:\"listItem\";s:5:\"width\";s:0:\"\";s:4:\"type\";s:10:\"singleline\";}}s:8:\"defaults\";a:0:{}s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"43eacc7a-4e10-4194-875c-d90071579149\";a:10:{s:4:\"name\";s:10:\"Split List\";s:6:\"handle\";s:9:\"splitList\";s:12:\"instructions\";s:95:\"When enabled and the list contains items the list will be placed to the right of the body copy.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:24:\"craft\\fields\\Lightswitch\";s:8:\"settings\";a:1:{s:7:\"default\";s:0:\"\";}s:17:\"contentColumnType\";s:7:\"boolean\";s:10:\"fieldGroup\";N;}s:36:\"b337860e-6281-433f-aa69-2d01b5f8e912\";a:10:{s:4:\"name\";s:10:\"List Style\";s:6:\"handle\";s:9:\"listStyle\";s:12:\"instructions\";s:25:\"Select a list style type.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:2:{i:0;a:3:{s:5:\"label\";s:7:\"Default\";s:5:\"value\";s:8:\"-default\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:4:\"Plus\";s:5:\"value\";s:5:\"-plus\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"0ff68a13-d28a-4bab-bfdd-ea638bb9166b\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:5:{s:36:\"c7b72005-a498-41f9-979d-67d815d408e3\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}s:36:\"a255042b-ffbc-48c6-87b5-dff502c8251d\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"d5822862-1769-4f56-bdd9-03d7aeb583a1\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}s:36:\"43eacc7a-4e10-4194-875c-d90071579149\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}s:36:\"b337860e-6281-433f-aa69-2d01b5f8e912\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:5;}}}}}}}s:36:\"326dbc91-cc61-404b-ad31-73f972c6e3de\";a:3:{s:5:\"field\";s:36:\"9fcae5d9-54cc-4ce1-9ade-6fa31442abf1\";s:6:\"fields\";a:1:{s:36:\"fc1bf467-a95f-4dff-99b8-b2e3ccb556d5\";a:10:{s:4:\"name\";s:4:\"Item\";s:6:\"handle\";s:4:\"item\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:20:\"craft\\redactor\\Field\";s:8:\"settings\";a:7:{s:14:\"redactorConfig\";s:10:\"Basic.json\";s:14:\"purifierConfig\";s:0:\"\";s:11:\"cleanupHtml\";s:1:\"1\";s:10:\"purifyHtml\";s:1:\"1\";s:10:\"columnType\";s:4:\"text\";s:16:\"availableVolumes\";s:0:\"\";s:19:\"availableTransforms\";s:1:\"*\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"89001764-e066-4ae4-91cb-a4eaf6d519aa\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:1:{s:36:\"fc1bf467-a95f-4dff-99b8-b2e3ccb556d5\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}}}}}}}}}','[]','0eBcPxM4WqyP','2018-10-17 19:43:46','2019-02-09 13:08:23','bdebff9e-a915-4f72-a9be-e9715430bcd0');

/*!40000 ALTER TABLE `pt_info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_matrixblocks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_matrixblocks`;

CREATE TABLE `pt_matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `matrixblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `pt_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `pt_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `pt_matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_matrixblocks` WRITE;
/*!40000 ALTER TABLE `pt_matrixblocks` DISABLE KEYS */;

INSERT INTO `pt_matrixblocks` (`id`, `ownerId`, `ownerSiteId`, `fieldId`, `typeId`, `sortOrder`, `deletedWithOwner`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(176,175,NULL,1,1,1,1,'2019-01-31 19:31:32','2019-02-05 20:18:11','2d4de045-2e66-40bf-9a8a-4c992b84751a'),
	(177,175,NULL,1,3,2,1,'2019-01-31 19:31:32','2019-02-05 20:18:11','31892c68-210b-48bb-9cb6-93c6a750f63a'),
	(178,175,NULL,1,12,5,1,'2019-01-31 19:31:32','2019-02-05 20:18:11','26f48c71-2efb-4f33-a767-b1d0c33d856c'),
	(183,175,NULL,1,9,4,0,'2019-01-31 21:08:35','2019-01-31 21:09:18','c3d2e3d9-b5e3-475d-a51d-f1690f5fd9e3'),
	(214,175,NULL,1,2,3,1,'2019-02-05 18:33:08','2019-02-05 20:18:11','92d63384-a326-4218-af62-1d8146b70cb7'),
	(215,175,NULL,1,5,4,1,'2019-02-05 18:33:08','2019-02-05 20:18:11','fb72aacb-4d4e-4a31-925c-a24e3e8bf92c'),
	(216,175,NULL,1,5,7,1,'2019-02-05 18:33:44','2019-02-05 20:18:11','e9deb5ab-4e3e-482e-b7c2-18758668a3d9'),
	(217,175,NULL,1,2,6,1,'2019-02-05 18:35:03','2019-02-05 20:18:11','60055407-8c09-4335-a766-4c8355d13649'),
	(218,175,NULL,1,1,1,0,'2019-02-05 18:40:25','2019-02-05 18:41:09','0a57d3a9-378c-427a-b977-aa4c1152c075'),
	(219,175,NULL,1,3,2,0,'2019-02-05 18:40:25','2019-02-05 18:41:09','c7f4fbcd-b5ea-4272-8b0a-a1eb84f70057'),
	(220,175,NULL,1,2,3,0,'2019-02-05 18:40:25','2019-02-05 18:41:09','5da76739-053c-4ce7-b577-62d62d251deb'),
	(240,239,NULL,1,1,1,1,'2019-02-09 13:03:57','2019-02-09 13:08:36','da5d0062-8228-41c7-b4c0-e8c57fbb48dd'),
	(241,239,NULL,1,3,2,1,'2019-02-09 13:03:57','2019-02-09 13:08:36','a655f522-5536-4944-a03f-462df423980f'),
	(242,239,NULL,1,5,3,1,'2019-02-09 13:03:57','2019-02-09 13:08:36','5bae9ec8-3c69-4839-9c22-ae8589fb1903');

/*!40000 ALTER TABLE `pt_matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_matrixblocktypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_matrixblocktypes`;

CREATE TABLE `pt_matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `pt_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `pt_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `pt_matrixblocktypes` DISABLE KEYS */;

INSERT INTO `pt_matrixblocktypes` (`id`, `fieldId`, `fieldLayoutId`, `name`, `handle`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,3,'Section','sectionSettings',1,'2018-11-06 19:29:37','2019-02-09 13:08:19','9c7038b3-900d-4b50-a5ee-7c445a476f87'),
	(2,1,6,'Heading','heading',4,'2018-11-06 19:54:25','2019-02-09 13:08:20','e99be65c-5fee-4c83-9eed-8050793be42a'),
	(3,1,7,'Container','container',2,'2018-11-07 13:26:27','2019-02-09 13:08:19','27f153c6-09ef-408c-a85b-50ee37263d52'),
	(4,1,8,'End Column','endColumn',3,'2018-11-07 13:26:27','2019-02-09 13:08:19','8ca7c03d-aa9b-4611-b6be-6862e9a89ce1'),
	(5,1,9,'Copy','copy',5,'2018-11-21 13:02:29','2019-02-09 13:08:20','d40a8732-c577-4d4a-a737-05fa930be6a2'),
	(6,1,10,'Image','image',6,'2018-11-21 13:26:58','2019-02-09 13:08:20','8cfe5e31-20a9-4ddc-ba3d-790f1b405450'),
	(7,1,12,'Buttons','buttons',7,'2018-11-28 19:07:47','2019-02-09 13:08:21','86843e26-821b-41e7-8e3e-87321802c139'),
	(8,1,13,'Pull Quote','pullQuote',8,'2018-11-29 13:45:52','2019-02-09 13:08:21','42b013df-72dc-41a5-941f-d7a299502e38'),
	(9,1,15,'Gallery','gallery',9,'2018-11-29 16:00:58','2019-02-09 13:08:21','411496be-9759-4334-803e-790121fdee23'),
	(10,1,17,'Accordion','accordion',10,'2018-12-07 12:52:41','2019-02-09 13:08:22','2cb049e6-b35a-4271-8861-0bbde459b042'),
	(11,1,19,'List','list',11,'2018-12-07 17:24:19','2019-02-09 13:08:22','3bf9043f-ddd4-4d72-b83d-c984f46fdecf'),
	(12,1,20,'Form','form',12,'2019-01-31 19:31:00','2019-02-09 13:08:23','84f5b143-6cfd-4a3f-892f-e52a1b2731ee');

/*!40000 ALTER TABLE `pt_matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_matrixcontent_cc
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_matrixcontent_cc`;

CREATE TABLE `pt_matrixcontent_cc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_sectionSettings_backgroundColor` varchar(255) DEFAULT NULL,
  `field_heading_copy` text,
  `field_heading_fontSize` varchar(255) DEFAULT NULL,
  `field_heading_alignment` varchar(255) DEFAULT NULL,
  `field_heading_paddingType` varchar(255) DEFAULT NULL,
  `field_sectionSettings_overlay` varchar(255) DEFAULT NULL,
  `field_container_width` varchar(255) DEFAULT NULL,
  `field_container_columnLayout` varchar(255) DEFAULT NULL,
  `field_container_columnGutter` varchar(255) DEFAULT NULL,
  `field_container_verticalAlign` varchar(255) DEFAULT NULL,
  `field_copy_body` text,
  `field_copy_alignment` varchar(255) DEFAULT NULL,
  `field_copy_paddingType` varchar(255) DEFAULT NULL,
  `field_image_aspectRatio` varchar(255) DEFAULT NULL,
  `field_image_paddingType` varchar(255) DEFAULT NULL,
  `field_image_enableLightcase` tinyint(1) DEFAULT NULL,
  `field_image_overlay` varchar(255) DEFAULT NULL,
  `field_sectionSettings_paddingType` varchar(255) DEFAULT NULL,
  `field_heading_paddingSize` varchar(255) DEFAULT NULL,
  `field_copy_paddingSize` varchar(255) DEFAULT NULL,
  `field_image_paddingSize` varchar(255) DEFAULT NULL,
  `field_image_cropZoom` decimal(3,2) DEFAULT NULL,
  `field_image_imageWidth` smallint(4) DEFAULT NULL,
  `field_image_grayscale` tinyint(1) DEFAULT NULL,
  `field_container_paddingType` varchar(255) DEFAULT NULL,
  `field_container_paddingSize` varchar(255) DEFAULT NULL,
  `field_sectionSettings_paddingSize` varchar(255) DEFAULT NULL,
  `field_buttons_alignment` varchar(255) DEFAULT NULL,
  `field_buttons_paddingSize` varchar(255) DEFAULT NULL,
  `field_buttons_paddingType` varchar(255) DEFAULT NULL,
  `field_image_imageAlignment` varchar(255) DEFAULT NULL,
  `field_pullQuote_body` text,
  `field_pullQuote_source` text,
  `field_pullQuote_paddingSize` varchar(255) DEFAULT NULL,
  `field_pullQuote_paddingType` varchar(255) DEFAULT NULL,
  `field_pullQuote_quoteStyle` varchar(255) DEFAULT NULL,
  `field_gallery_paddingSize` varchar(255) DEFAULT NULL,
  `field_gallery_paddingType` varchar(255) DEFAULT NULL,
  `field_gallery_slideTransition` varchar(255) DEFAULT NULL,
  `field_gallery_style` varchar(255) DEFAULT NULL,
  `field_gallery_aspectRatio` varchar(255) DEFAULT NULL,
  `field_accordion_paddingSize` varchar(255) DEFAULT NULL,
  `field_accordion_paddingType` varchar(255) DEFAULT NULL,
  `field_list_paddingSize` varchar(255) DEFAULT NULL,
  `field_list_paddingType` varchar(255) DEFAULT NULL,
  `field_list_alignment` varchar(255) DEFAULT NULL,
  `field_list_listStyle` varchar(255) DEFAULT NULL,
  `field_accordion_multiRow` tinyint(1) DEFAULT NULL,
  `field_form_selectedForm` int(11) DEFAULT NULL,
  `field_form_formStyle` varchar(255) DEFAULT NULL,
  `field_form_paddingSize` varchar(255) DEFAULT NULL,
  `field_form_paddingType` varchar(255) DEFAULT NULL,
  `field_form_submissionMessage` text,
  `field_copy_columnLayout` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_cc_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_cc_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_cc_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_cc_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `pt_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_matrixcontent_cc` WRITE;
/*!40000 ALTER TABLE `pt_matrixcontent_cc` DISABLE KEYS */;

INSERT INTO `pt_matrixcontent_cc` (`id`, `elementId`, `siteId`, `dateCreated`, `dateUpdated`, `uid`, `field_sectionSettings_backgroundColor`, `field_heading_copy`, `field_heading_fontSize`, `field_heading_alignment`, `field_heading_paddingType`, `field_sectionSettings_overlay`, `field_container_width`, `field_container_columnLayout`, `field_container_columnGutter`, `field_container_verticalAlign`, `field_copy_body`, `field_copy_alignment`, `field_copy_paddingType`, `field_image_aspectRatio`, `field_image_paddingType`, `field_image_enableLightcase`, `field_image_overlay`, `field_sectionSettings_paddingType`, `field_heading_paddingSize`, `field_copy_paddingSize`, `field_image_paddingSize`, `field_image_cropZoom`, `field_image_imageWidth`, `field_image_grayscale`, `field_container_paddingType`, `field_container_paddingSize`, `field_sectionSettings_paddingSize`, `field_buttons_alignment`, `field_buttons_paddingSize`, `field_buttons_paddingType`, `field_image_imageAlignment`, `field_pullQuote_body`, `field_pullQuote_source`, `field_pullQuote_paddingSize`, `field_pullQuote_paddingType`, `field_pullQuote_quoteStyle`, `field_gallery_paddingSize`, `field_gallery_paddingType`, `field_gallery_slideTransition`, `field_gallery_style`, `field_gallery_aspectRatio`, `field_accordion_paddingSize`, `field_accordion_paddingType`, `field_list_paddingSize`, `field_list_paddingType`, `field_list_alignment`, `field_list_listStyle`, `field_accordion_multiRow`, `field_form_selectedForm`, `field_form_formStyle`, `field_form_paddingSize`, `field_form_paddingType`, `field_form_submissionMessage`, `field_copy_columnLayout`)
VALUES
	(1,176,1,'2019-01-31 19:31:32','2019-02-05 20:18:11','202adbb6-27ed-41e8-b5f2-c4e04e60a5c9','-base-background',NULL,NULL,NULL,NULL,'none',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'u-padding-vertical',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'-x4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(2,177,1,'2019-01-31 19:31:32','2019-02-05 20:18:11','463e52a0-e8f9-44cd-bafa-94c8e5bb3e5a',NULL,NULL,NULL,NULL,NULL,NULL,'o-container-narrow','1','-gutter-large','-align-top',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'u-padding-vertical','-none',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(3,178,1,'2019-01-31 19:31:32','2019-02-05 20:18:11','e1925b3f-dc98-4918-9cd5-4e77a0728d24',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'-outline','-x2','u-padding-vertical','<p>Testing</p>',NULL),
	(4,183,1,'2019-01-31 21:08:35','2019-01-31 21:09:18','bf4fae4f-304a-43f1-bd8c-ba3825bd00d7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'-none','u-padding','-1','parallax','u-ratio-1/1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(5,214,1,'2019-02-05 18:33:08','2019-02-05 20:18:11','1a41229c-4244-4687-938d-4d3c7da8e16f',NULL,'Sample Form','o-h2','u-text-left','u-padding',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'-none',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(6,215,1,'2019-02-05 18:33:08','2019-02-05 20:18:11','7a15a46c-e32d-4af6-b2ff-a635981f4b3e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>','u-text-left','u-padding-bottom',NULL,NULL,NULL,NULL,NULL,NULL,'-none',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(7,216,1,'2019-02-05 18:33:44','2019-02-05 20:18:11','70ccac72-ab84-4ed8-bc0a-b52844e9abe0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Et ultrices neque ornare aenean euismod. Interdum velit laoreet id donec. Velit euismod in pellentesque massa placerat duis ultricies lacus sed. Dapibus ultrices in iaculis nunc sed. A arcu cursus vitae congue mauris. At erat pellentesque adipiscing commodo elit at imperdiet dui. Malesuada fames ac turpis egestas maecenas pharetra convallis posuere. Consequat interdum varius sit amet mattis vulputate. Faucibus pulvinar elementum integer enim neque volutpat. Vitae aliquet nec ullamcorper sit. Pretium viverra suspendisse potenti nullam ac tortor. Sit amet luctus venenatis lectus magna fringilla urna porttitor. Est pellentesque elit ullamcorper dignissim cras tincidunt. Aliquam nulla facilisi cras fermentum odio eu feugiat pretium.</p>\n<p>Orci a scelerisque purus semper eget duis at tellus at. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Elit sed vulputate mi sit amet mauris commodo quis. Tortor aliquam nulla facilisi cras fermentum odio eu. Vitae semper quis lectus nulla at volutpat. Posuere morbi leo urna molestie at elementum eu. Magna eget est lorem ipsum dolor sit amet consectetur adipiscing. Tincidunt dui ut ornare lectus. Risus nullam eget felis eget nunc. Congue nisi vitae suscipit tellus. Metus aliquam eleifend mi in nulla posuere sollicitudin. Amet volutpat consequat mauris nunc congue nisi vitae. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa. Donec enim diam vulputate ut.</p>\n<p>Amet nisl purus in mollis nunc sed. Egestas purus viverra accumsan in. Venenatis tellus in metus vulputate eu. Id cursus metus aliquam eleifend mi in nulla. Pretium nibh ipsum consequat nisl vel pretium lectus. Pharetra sit amet aliquam id diam maecenas. Montes nascetur ridiculus mus mauris vitae ultricies leo integer. A diam maecenas sed enim ut sem viverra aliquet eget. Vestibulum morbi blandit cursus risus at ultrices. Ut venenatis tellus in metus vulputate eu scelerisque. Amet mauris commodo quis imperdiet massa tincidunt. Diam maecenas sed enim ut sem viverra aliquet eget.</p>\n<p>Vel pharetra vel turpis nunc eget lorem dolor. Lacus suspendisse faucibus interdum posuere lorem. Aenean euismod elementum nisi quis eleifend. Nisi porta lorem mollis aliquam ut porttitor leo a. Lorem donec massa sapien faucibus et. Aliquam sem et tortor consequat id porta nibh venenatis cras. Commodo nulla facilisi nullam vehicula. Viverra nam libero justo laoreet sit amet cursus sit amet. Mauris nunc congue nisi vitae suscipit tellus mauris a diam. Vel orci porta non pulvinar neque laoreet suspendisse. Nulla pellentesque dignissim enim sit. Sed tempus urna et pharetra pharetra massa massa ultricies mi. Vitae justo eget magna fermentum iaculis eu non diam. Tempor orci dapibus ultrices in iaculis. Pretium fusce id velit ut tortor pretium. Senectus et netus et malesuada fames ac turpis egestas maecenas.</p>\n<p>Massa massa ultricies mi quis. Habitasse platea dictumst quisque sagittis purus. Nullam non nisi est sit amet facilisis magna etiam tempor. Egestas dui id ornare arcu odio ut sem. Scelerisque eu ultrices vitae auctor. Quis ipsum suspendisse ultrices gravida dictum fusce ut. Imperdiet nulla malesuada pellentesque elit eget gravida. Pharetra diam sit amet nisl. Laoreet suspendisse interdum consectetur libero id faucibus nisl tincidunt eget. Sodales ut eu sem integer vitae. Felis donec et odio pellentesque diam volutpat commodo. In eu mi bibendum neque egestas congue quisque egestas diam. Massa massa ultricies mi quis hendrerit. Tristique magna sit amet purus gravida quis blandit turpis.</p>','u-text-left','u-padding',NULL,NULL,NULL,NULL,NULL,NULL,'-none',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(8,217,1,'2019-02-05 18:35:03','2019-02-05 20:18:11','ef7da8f9-4e2f-4bad-8c92-67cafd667cf2',NULL,'All About Lorem','o-h5','u-text-left','u-padding',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'-none',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(9,218,1,'2019-02-05 18:40:25','2019-02-05 18:41:09','633ddf95-067b-4b53-b82c-e6f2218063f7','-dark-background',NULL,NULL,NULL,NULL,'none',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'u-padding-vertical',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'-x2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(10,219,1,'2019-02-05 18:40:25','2019-02-05 18:41:09','b7277af9-41f0-4ed5-9648-7b12ea497d28',NULL,NULL,NULL,NULL,NULL,NULL,'o-container','1','-gutter-large','-align-top',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'u-padding-vertical','-none',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(11,220,1,'2019-02-05 18:40:25','2019-02-05 18:41:09','da79ccd8-85bd-411c-9359-8f0920aa8a37',NULL,'Freeform Template Example','o-h1','u-text-center','u-padding',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'-none',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(12,240,1,'2019-02-09 13:03:57','2019-02-09 13:08:36','094c95e1-e06b-43b7-b2b1-290ef7cde092','-base-background',NULL,NULL,NULL,NULL,'none',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'u-padding-vertical',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'-x4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(13,241,1,'2019-02-09 13:03:57','2019-02-09 13:08:36','67d53900-3c34-4f82-b358-75a9492ce1fb',NULL,NULL,NULL,NULL,NULL,NULL,'o-container','1','-gutter-large','-align-top',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'u-padding-vertical','-none',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(14,242,1,'2019-02-09 13:03:57','2019-02-09 13:08:36','36d8b1d6-155f-4b64-8e38-f35690173b89',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Leo urna molestie at elementum eu facilisis sed. Ut diam quam nulla porttitor massa id neque. Ullamcorper sit amet risus nullam eget felis. Amet consectetur adipiscing elit ut aliquam purus sit amet. Nullam non nisi est sit amet facilisis magna etiam tempor. Metus vulputate eu scelerisque felis imperdiet proin fermentum leo vel. Amet aliquam id diam maecenas ultricies mi eget mauris pharetra. Nibh nisl condimentum id venenatis a condimentum vitae sapien pellentesque. Eros in cursus turpis massa tincidunt. Pharetra diam sit amet nisl suscipit. Dui nunc mattis enim ut tellus elementum sagittis vitae. Tellus orci ac auctor augue mauris augue neque gravida. Vivamus arcu felis bibendum ut tristique et egestas quis. Nisl nisi scelerisque eu ultrices. Pretium fusce id velit ut tortor pretium viverra suspendisse potenti. Velit dignissim sodales ut eu sem integer.</p>\n<p>Pharetra vel turpis nunc eget lorem. Sit amet volutpat consequat mauris nunc congue. Mauris cursus mattis molestie a iaculis. Quam adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus. Turpis egestas pretium aenean pharetra. Tellus in hac habitasse platea dictumst vestibulum rhoncus est. Mattis enim ut tellus elementum sagittis. Quis viverra nibh cras pulvinar. Fermentum posuere urna nec tincidunt praesent semper. Vestibulum morbi blandit cursus risus at ultrices mi tempus. Et egestas quis ipsum suspendisse ultrices gravida dictum. Fringilla ut morbi tincidunt augue.</p>\n<p>Amet consectetur adipiscing elit pellentesque habitant morbi tristique senectus et. Eget mi proin sed libero enim sed faucibus. Augue neque gravida in fermentum. Tempus quam pellentesque nec nam aliquam sem et. Ut consequat semper viverra nam libero justo laoreet sit. Eget magna fermentum iaculis eu non. Consectetur libero id faucibus nisl tincidunt eget nullam. Adipiscing tristique risus nec feugiat. Massa eget egestas purus viverra. Maecenas sed enim ut sem viverra aliquet eget sit amet. Ut porttitor leo a diam sollicitudin tempor id. Vel pharetra vel turpis nunc eget lorem dolor sed.</p>','u-text-left','u-padding',NULL,NULL,NULL,NULL,NULL,NULL,'-none',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'-double-column');

/*!40000 ALTER TABLE `pt_matrixcontent_cc` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_migrations`;

CREATE TABLE `pt_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `pt_plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_migrations` WRITE;
/*!40000 ALTER TABLE `pt_migrations` DISABLE KEYS */;

INSERT INTO `pt_migrations` (`id`, `pluginId`, `type`, `name`, `applyTime`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'app','Install','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','4d683d3a-f136-4106-a2bb-e5a941aa6b28'),
	(2,NULL,'app','m150403_183908_migrations_table_changes','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','73c63030-a20f-446e-89a8-a26ac2e83a42'),
	(3,NULL,'app','m150403_184247_plugins_table_changes','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','cfb49a24-b5fc-461b-a946-1a189aad2d6d'),
	(4,NULL,'app','m150403_184533_field_version','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','1683e275-3297-4ce6-b503-c9baffa9e455'),
	(5,NULL,'app','m150403_184729_type_columns','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','dfd2dd5c-3330-45d6-98cb-9c7cc15e2fdc'),
	(6,NULL,'app','m150403_185142_volumes','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','06a003a9-1b82-4801-be0a-f0bc4b0e6e37'),
	(7,NULL,'app','m150428_231346_userpreferences','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','6856a914-5596-4acf-b25b-6ad29d896c6b'),
	(8,NULL,'app','m150519_150900_fieldversion_conversion','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','6ae8830a-eb06-4191-96d1-05d8dd767a3d'),
	(9,NULL,'app','m150617_213829_update_email_settings','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','793cbeff-9ffd-4d80-9b95-830d5ad945cf'),
	(10,NULL,'app','m150721_124739_templatecachequeries','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','67a2eb6a-ee9a-48d7-ad7d-11361f2ebbc6'),
	(11,NULL,'app','m150724_140822_adjust_quality_settings','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','71773624-9499-46c3-a6b7-31c9472504c4'),
	(12,NULL,'app','m150815_133521_last_login_attempt_ip','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','cc765bff-fc50-4bf1-b742-30bcec47440e'),
	(13,NULL,'app','m151002_095935_volume_cache_settings','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','656c7d89-a3e8-4607-a2bf-fd116a09fc17'),
	(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','5d082cfe-9882-4da9-bf1a-9d87767a57f5'),
	(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','2fd746b6-635b-4850-bb88-fa08b9c2dc44'),
	(16,NULL,'app','m151209_000000_move_logo','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','d62f6862-ce3a-4743-a69b-eeae0e77301c'),
	(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','ed13fd68-ba64-4a0b-955f-aca7ded6fbd1'),
	(18,NULL,'app','m151215_000000_rename_asset_permissions','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','07220a85-3713-4017-acfb-aac9c7f60fc0'),
	(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','4fb90ff6-d9bd-4b34-b838-941e6dcf3147'),
	(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','cf5b5945-7c5e-4091-99ec-86a7aaf6c6a7'),
	(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','e9a377a6-b0d2-4bac-8874-ade2dfa8d3c0'),
	(22,NULL,'app','m160727_194637_column_cleanup','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','54188aef-49a8-4ebc-b465-112b642bbf4b'),
	(23,NULL,'app','m160804_110002_userphotos_to_assets','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','80e61ad3-ee50-4ba0-b995-5b1e4dc32e4f'),
	(24,NULL,'app','m160807_144858_sites','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','20fbd5cb-7c18-4e2a-a93b-077bcce88257'),
	(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','f17b5045-25b9-49ca-a527-f0c2f28b04c5'),
	(26,NULL,'app','m160830_000000_asset_index_uri_increase','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','4a023a66-8302-47db-b97e-ac50118450bd'),
	(27,NULL,'app','m160912_230520_require_entry_type_id','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','434e82d3-2754-4b08-bff2-6261325a8cf9'),
	(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','d79726ca-f05d-428c-a3a7-46a106d58a3a'),
	(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','ddf40035-20c5-44c0-b846-db7a9898a98c'),
	(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','0e1b2dc3-e60d-4e73-977d-8943f14bfc08'),
	(31,NULL,'app','m160925_113941_route_uri_parts','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','9dab7301-c01c-4be2-b799-14bd013b8722'),
	(32,NULL,'app','m161006_205918_schemaVersion_not_null','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','d305ffd8-99cf-4504-b06a-891c40894e04'),
	(33,NULL,'app','m161007_130653_update_email_settings','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','a8c9b75a-77ab-494a-a80c-15fe1cb16848'),
	(34,NULL,'app','m161013_175052_newParentId','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','3e2cb02d-1e2c-4b92-9f87-39be7e7e03dc'),
	(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','36e584ad-1bbf-4741-96c2-35cb54f08f3e'),
	(36,NULL,'app','m161021_182140_rename_get_help_widget','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','7a3ba3aa-33bd-4975-a6fc-46afd6cac814'),
	(37,NULL,'app','m161025_000000_fix_char_columns','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','f6b7708a-dfcc-486f-8bf3-551bb17f9c4e'),
	(38,NULL,'app','m161029_124145_email_message_languages','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','ecf2d96d-bdff-4edd-8ae4-a8777f16f08a'),
	(39,NULL,'app','m161108_000000_new_version_format','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','6ff52e17-137a-46e4-bc2b-3664d95faa55'),
	(40,NULL,'app','m161109_000000_index_shuffle','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','1feec99a-3166-4853-a312-d23edf9b5470'),
	(41,NULL,'app','m161122_185500_no_craft_app','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','cdee0c33-edc3-428a-9857-bda46cdf9aef'),
	(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','8e16053d-f5eb-4baa-a782-9e21d5f3c7b1'),
	(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','a74fb5d5-a79d-4aac-a046-aceb96c12421'),
	(44,NULL,'app','m170114_161144_udates_permission','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','bb20b7f8-b8fb-48e6-9360-7d848a5141c0'),
	(45,NULL,'app','m170120_000000_schema_cleanup','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','2aa924b4-424b-43d9-98c9-9061d5ab27c0'),
	(46,NULL,'app','m170126_000000_assets_focal_point','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','c3efe66e-259b-4aad-941e-1d7e05670611'),
	(47,NULL,'app','m170206_142126_system_name','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','30dbf3da-090f-4459-96c9-4209232ca220'),
	(48,NULL,'app','m170217_044740_category_branch_limits','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','1531136f-2b9b-447b-a60e-aa5514794e78'),
	(49,NULL,'app','m170217_120224_asset_indexing_columns','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','c4ac569c-4a6b-4f36-a387-84ff544f0944'),
	(50,NULL,'app','m170223_224012_plain_text_settings','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','821ade1a-e4df-45db-b9ac-f85ba77ce57d'),
	(51,NULL,'app','m170227_120814_focal_point_percentage','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','5f41bd05-c3bc-4c20-9d78-c965304eb1e0'),
	(52,NULL,'app','m170228_171113_system_messages','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','4498da23-b772-4bf8-9831-fa0ffe94ccd3'),
	(53,NULL,'app','m170303_140500_asset_field_source_settings','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','66f26096-1b0e-4912-8535-de5375d8c6ab'),
	(54,NULL,'app','m170306_150500_asset_temporary_uploads','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','25965eff-1d52-4608-ad48-a3b40b7f1488'),
	(55,NULL,'app','m170414_162429_rich_text_config_setting','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','8ad5650f-e52a-4872-8c23-a75526f56c2a'),
	(56,NULL,'app','m170523_190652_element_field_layout_ids','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','fcdb98eb-e2f9-4f09-80c8-e0315a5e6887'),
	(57,NULL,'app','m170612_000000_route_index_shuffle','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','e80d71f3-f79e-4eeb-9e67-c2a8c1eeaefc'),
	(58,NULL,'app','m170621_195237_format_plugin_handles','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','c62e05ea-d874-45de-bc80-6dbf9c50ec79'),
	(59,NULL,'app','m170630_161028_deprecation_changes','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','f6d41997-a34f-483c-b9df-794679ff6cf1'),
	(60,NULL,'app','m170703_181539_plugins_table_tweaks','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','761640a5-bc59-490f-a974-01dca30ca04b'),
	(61,NULL,'app','m170704_134916_sites_tables','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','e8fcffe9-9b11-4169-98e0-e74f58ae674e'),
	(62,NULL,'app','m170706_183216_rename_sequences','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','9ed6be32-cebb-4f5c-b4ca-437645146a19'),
	(63,NULL,'app','m170707_094758_delete_compiled_traits','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','9b611cf4-ac6f-4f02-96d5-cc8aff799cfb'),
	(64,NULL,'app','m170731_190138_drop_asset_packagist','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','7cfc14ad-f133-4b92-ad2b-fcec4c969bd0'),
	(65,NULL,'app','m170810_201318_create_queue_table','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','76372278-6dca-4466-8054-0c6cd1e7c71c'),
	(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','414b9c1c-8af1-4804-b55b-44aa3e714295'),
	(67,NULL,'app','m170821_180624_deprecation_line_nullable','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','97d66654-4076-4879-8e34-aa325241ae76'),
	(68,NULL,'app','m170903_192801_longblob_for_queue_jobs','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','19cde2d7-be6b-400d-b47e-fcb2343bb4d7'),
	(69,NULL,'app','m170914_204621_asset_cache_shuffle','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','64b53045-2bdc-470b-aa74-315b06dcc8e5'),
	(70,NULL,'app','m171011_214115_site_groups','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','2ecc7116-935a-430a-a3b9-76ead6ea004b'),
	(71,NULL,'app','m171012_151440_primary_site','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','2683b91a-942e-4372-94b3-60f998974726'),
	(72,NULL,'app','m171013_142500_transform_interlace','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','807e7e31-1136-4004-898b-690733cc5910'),
	(73,NULL,'app','m171016_092553_drop_position_select','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','f08e15a0-ea74-438a-a87e-7240d65ed912'),
	(74,NULL,'app','m171016_221244_less_strict_translation_method','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','e1439ee4-d325-4faa-a53a-0be87faee768'),
	(75,NULL,'app','m171107_000000_assign_group_permissions','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','3a87272f-016f-4645-a919-fdd9f96489c0'),
	(76,NULL,'app','m171117_000001_templatecache_index_tune','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','41b24882-e191-4d7f-82d8-2d08b1cc7f76'),
	(77,NULL,'app','m171126_105927_disabled_plugins','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','99d2b63a-3b5b-4810-a083-6129df6f4948'),
	(78,NULL,'app','m171130_214407_craftidtokens_table','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','98fbadd6-a87c-4cef-add0-c7825daa4b79'),
	(79,NULL,'app','m171202_004225_update_email_settings','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','f30a9d60-acf4-489b-92e9-06a940a19c7f'),
	(80,NULL,'app','m171204_000001_templatecache_index_tune_deux','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','57830bf8-93e4-4201-9c64-720fdd8d2aaa'),
	(81,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','514a41d9-a808-4e60-ae3f-dc3278b06216'),
	(82,NULL,'app','m171218_143135_longtext_query_column','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','9fc2df83-3075-41dd-b8fa-998b7f948099'),
	(83,NULL,'app','m171231_055546_environment_variables_to_aliases','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','b7aa4bec-8c7f-4096-8580-33c75dd8ff7d'),
	(84,NULL,'app','m180113_153740_drop_users_archived_column','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','12c24913-4c4f-4d30-86d4-8371dd397974'),
	(85,NULL,'app','m180122_213433_propagate_entries_setting','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','4b8427a6-a757-424c-b4b0-3f05dac62ef9'),
	(86,NULL,'app','m180124_230459_fix_propagate_entries_values','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','eaa2433e-2646-454b-807b-30d647ee30ed'),
	(87,NULL,'app','m180128_235202_set_tag_slugs','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','b961ea65-2a82-471c-89df-e1af2486a33f'),
	(88,NULL,'app','m180202_185551_fix_focal_points','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','54abee1b-838d-4bf4-93c9-fdb453f73d8d'),
	(89,NULL,'app','m180217_172123_tiny_ints','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','174f59f8-90c4-4c27-b4ec-24e053906d35'),
	(90,NULL,'app','m180321_233505_small_ints','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','b4ef6448-120f-4d30-8b6a-b6a58b1ecfb8'),
	(91,NULL,'app','m180328_115523_new_license_key_statuses','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','a601d8d9-6f90-4b66-9c34-5018397cdf49'),
	(92,NULL,'app','m180404_182320_edition_changes','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','869fa4ef-5a61-4ffa-8327-ac7221e38af9'),
	(93,NULL,'app','m180411_102218_fix_db_routes','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','3cfef9e5-9b69-4efb-a419-43213f33d65f'),
	(94,NULL,'app','m180416_205628_resourcepaths_table','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','87d8afdb-c2ff-4ef7-9bb4-d602b7f626d1'),
	(95,NULL,'app','m180418_205713_widget_cleanup','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','de2d1b90-b127-4138-a705-2ea8599cc53c'),
	(96,NULL,'app','m180824_193422_case_sensitivity_fixes','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','a9ae33ea-95c8-4a1e-bd32-602cc5dbc412'),
	(97,NULL,'app','m180901_151639_fix_matrixcontent_tables','2018-10-17 19:43:49','2018-10-17 19:43:49','2018-10-17 19:43:49','02610e3c-0869-488c-a9a1-c6c03f13d2b0'),
	(98,5,'plugin','Install','2018-11-07 16:07:44','2018-11-07 16:07:44','2018-11-07 16:07:44','411dd09a-c41d-4281-8290-9d88349ce1eb'),
	(99,5,'plugin','m180120_140521_CraftUpgrade','2018-11-07 16:07:44','2018-11-07 16:07:44','2018-11-07 16:07:44','e8562952-fe07-49c3-aed7-ad5c31f2bdaa'),
	(100,5,'plugin','m180125_124339_UpdateForeignKeyNames','2018-11-07 16:07:44','2018-11-07 16:07:44','2018-11-07 16:07:44','dd963066-02e9-4f64-9aec-ce71affeb2e7'),
	(101,5,'plugin','m180214_094247_AddUniqueTokenToSubmissionsAndForms','2018-11-07 16:07:44','2018-11-07 16:07:44','2018-11-07 16:07:44','727847ee-0669-4683-bb92-f471f2e8d789'),
	(102,5,'plugin','m180220_072652_ChangeFileUploadFieldColumnType','2018-11-07 16:07:44','2018-11-07 16:07:44','2018-11-07 16:07:44','153e3c33-a657-4ea0-92dc-cc0559e078f6'),
	(103,5,'plugin','m180326_094124_AddIsSpamToSubmissions','2018-11-07 16:07:44','2018-11-07 16:07:44','2018-11-07 16:07:44','a33ca88d-6f30-4f53-b538-6174b8432d5c'),
	(104,5,'plugin','m180405_101920_AddIpAddressToSubmissions','2018-11-07 16:07:44','2018-11-07 16:07:44','2018-11-07 16:07:44','0f391b3d-3a5e-495a-94c5-ee3ea0bb40ba'),
	(105,5,'plugin','m180410_131206_CreateIntegrationsQueue','2018-11-07 16:07:44','2018-11-07 16:07:44','2018-11-07 16:07:44','0ee8d689-7b5d-40f4-8306-ad4e9a08cd57'),
	(106,5,'plugin','m180417_134527_AddMultipleSelectTypeToFields','2018-11-07 16:07:44','2018-11-07 16:07:44','2018-11-07 16:07:44','901c6266-221c-4ad2-9dc7-fe76d077f88a'),
	(107,5,'plugin','m180430_151626_PaymentGateways','2018-11-07 16:07:44','2018-11-07 16:07:44','2018-11-07 16:07:44','ebfa9fe4-d399-4aff-bf60-b0dbc16bfcc3'),
	(108,5,'plugin','m180508_095131_CreatePaymentGatewayFieldsTable','2018-11-07 16:07:44','2018-11-07 16:07:44','2018-11-07 16:07:44','a7a86b8d-4348-4d7f-a2a2-2e764fbe71db'),
	(109,5,'plugin','m180606_141402_AddConnectionsToFormProperties','2018-11-07 16:07:44','2018-11-07 16:07:44','2018-11-07 16:07:44','dea12de0-f924-4547-be26-ad90e7d94741'),
	(110,5,'plugin','m180730_171628_AddCcDetailsFieldType','2018-11-07 16:07:44','2018-11-07 16:07:44','2018-11-07 16:07:44','6a2c539f-bff1-4e58-b91b-ceff406ddeb4'),
	(111,5,'plugin','m180817_091801_AddRulesToFormProperties','2018-11-07 16:07:44','2018-11-07 16:07:44','2018-11-07 16:07:44','1125e315-472c-449a-a2b1-e7d99eb14cf1'),
	(112,NULL,'app','m181112_203955_sequences_table','2018-11-20 20:05:33','2018-11-20 20:05:33','2018-11-20 20:05:33','e31c2201-b241-41b2-a652-fdeb3d665f94'),
	(113,5,'plugin','m181112_152751_ChangeTypeEnumColumnsToIndexedText','2018-11-20 20:05:33','2018-11-20 20:05:33','2018-11-20 20:05:33','9ad82d4a-5969-44f8-9baa-cb06516c7056'),
	(114,6,'plugin','m180430_204710_remove_old_plugins','2018-11-21 13:02:36','2018-11-21 13:02:36','2018-11-21 13:02:36','56ac569f-e971-4694-9eee-a1bd3178e034'),
	(115,6,'plugin','Install','2018-11-21 13:02:36','2018-11-21 13:02:36','2018-11-21 13:02:36','966da188-9212-478a-887f-82f5d80e5bc4'),
	(116,7,'plugin','Install','2018-11-28 19:02:30','2018-11-28 19:02:30','2018-11-28 19:02:30','9224653d-ad9a-486b-a7ac-89098adacfa8'),
	(117,7,'plugin','m180210_000000_migrate_content_tables','2018-11-28 19:02:30','2018-11-28 19:02:30','2018-11-28 19:02:30','dc648cdd-4236-48da-b2d4-930b061ac765'),
	(118,7,'plugin','m180211_000000_type_columns','2018-11-28 19:02:30','2018-11-28 19:02:30','2018-11-28 19:02:30','40b397cf-1c2e-4055-b206-168542db5252'),
	(119,7,'plugin','m180219_000000_sites','2018-11-28 19:02:30','2018-11-28 19:02:30','2018-11-28 19:02:30','695cd846-3860-4f14-b40d-391b567487b5'),
	(120,7,'plugin','m180220_000000_fix_context','2018-11-28 19:02:30','2018-11-28 19:02:30','2018-11-28 19:02:30','012b850c-d509-4a15-b305-ce5e7d0b36d5'),
	(121,5,'plugin','m181129_083939_ChangeIntegrationFieldTypeColumnTypeToString','2019-01-05 00:21:19','2019-01-05 00:21:19','2019-01-05 00:21:19','724cd663-2ea7-42a8-9eb9-b393564f2784'),
	(122,NULL,'app','m170630_161027_deprecation_line_nullable','2019-01-30 12:22:34','2019-01-30 12:22:34','2019-01-30 12:22:34','d0dd3dfd-6e8e-41c5-89e1-9ce256dfc79e'),
	(123,NULL,'app','m180425_203349_searchable_fields','2019-01-30 12:22:34','2019-01-30 12:22:34','2019-01-30 12:22:34','8b955a48-4f7d-4834-bbe1-9a5cc21d420b'),
	(124,NULL,'app','m180516_153000_uids_in_field_settings','2019-01-30 12:22:34','2019-01-30 12:22:34','2019-01-30 12:22:34','4b427592-d5ab-4278-bcaa-8df707b064fb'),
	(125,NULL,'app','m180517_173000_user_photo_volume_to_uid','2019-01-30 12:22:34','2019-01-30 12:22:34','2019-01-30 12:22:34','b30676b1-bb62-4ce8-b2e0-d7734beefbb2'),
	(126,NULL,'app','m180518_173000_permissions_to_uid','2019-01-30 12:22:34','2019-01-30 12:22:34','2019-01-30 12:22:34','069272b2-8c6f-4e54-9890-58ff2c3298bd'),
	(127,NULL,'app','m180520_173000_matrix_context_to_uids','2019-01-30 12:22:34','2019-01-30 12:22:34','2019-01-30 12:22:34','b08d3a32-cc67-49a3-a012-16cb390f7a02'),
	(128,NULL,'app','m180521_173000_initial_yml_and_snapshot','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','cc89739f-44ae-4453-a525-cd9b83e4ff1b'),
	(129,NULL,'app','m180731_162030_soft_delete_sites','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','629315ee-e8c5-484a-94c7-ab40bca7ebb5'),
	(130,NULL,'app','m180810_214427_soft_delete_field_layouts','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','9fd23a04-77e4-4b2e-a242-28aaa6bc23bd'),
	(131,NULL,'app','m180810_214439_soft_delete_elements','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','186aee33-50b4-44e7-aebe-effe30325e0f'),
	(132,NULL,'app','m180904_112109_permission_changes','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','8b3e54b2-3948-48a0-962b-18d99d9931e8'),
	(133,NULL,'app','m180910_142030_soft_delete_sitegroups','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','fb35a2bf-f545-4545-8651-730bb7f780c6'),
	(134,NULL,'app','m181011_160000_soft_delete_asset_support','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','ddcc799c-d074-48f5-84ca-cb9f5f6af08d'),
	(135,NULL,'app','m181016_183648_set_default_user_settings','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','9c461d72-6d34-4add-b153-db7acb5b75b1'),
	(136,NULL,'app','m181017_225222_system_config_settings','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','071c5755-9aa6-410b-931e-0499b68d8c90'),
	(137,NULL,'app','m181018_222343_drop_userpermissions_from_config','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','be3ea3cf-1741-48be-8482-80043a89109d'),
	(138,NULL,'app','m181029_130000_add_transforms_routes_to_config','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','c8af7a3b-60ea-4979-a02d-940f29464d54'),
	(139,NULL,'app','m181121_001712_cleanup_field_configs','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','a73168a7-e606-43b9-bce6-6cd12eae4160'),
	(140,NULL,'app','m181128_193942_fix_project_config','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','a33ae4a9-4c7c-468d-9f7e-959eb2d95377'),
	(141,NULL,'app','m181130_143040_fix_schema_version','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','912331cf-b515-4c16-aa05-91925204b91f'),
	(142,NULL,'app','m181211_143040_fix_entry_type_uids','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','f871ef5f-e41c-41c8-b0dd-e3ce6f841959'),
	(143,NULL,'app','m181213_102500_config_map_aliases','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','e84353e2-c33c-4f5a-a9ff-690ac1581d63'),
	(144,NULL,'app','m181217_153000_fix_structure_uids','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','44228597-bfe9-4982-ad7f-d007529cd85d'),
	(145,NULL,'app','m190104_152725_store_licensed_plugin_editions','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','e3e43da7-9c7a-43be-bb3b-2fba98bc4b20'),
	(146,NULL,'app','m190108_110000_cleanup_project_config','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','c40b6fa3-dd53-47c1-a6d9-1b107797b1b0'),
	(147,NULL,'app','m190108_113000_asset_field_setting_change','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','54edd28c-f0d9-4c4d-a521-a73749072ace'),
	(148,NULL,'app','m190109_172845_fix_colspan','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','a4b7689e-05cc-437f-ab5d-5ee4b87dce79'),
	(149,NULL,'app','m190110_150000_prune_nonexisting_sites','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','5eb64c59-67e6-4cdc-97a6-dc0b18e3a95e'),
	(150,NULL,'app','m190110_214819_soft_delete_volumes','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','db865f1d-2e18-4159-b52d-61bfc32856d9'),
	(151,NULL,'app','m190112_124737_fix_user_settings','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','bd80401c-701e-4467-bee5-df0980031c74'),
	(152,NULL,'app','m190112_131225_fix_field_layouts','2019-01-30 12:22:35','2019-01-30 12:22:35','2019-01-30 12:22:35','4f0baf82-a046-4bb6-963d-6f34985e4169'),
	(153,NULL,'app','m190112_201010_more_soft_deletes','2019-01-30 12:22:36','2019-01-30 12:22:36','2019-01-30 12:22:36','8fef9dcf-2ad0-4dc0-bcb4-c8f38a114d22'),
	(154,NULL,'app','m190114_143000_more_asset_field_setting_changes','2019-01-30 12:22:36','2019-01-30 12:22:36','2019-01-30 12:22:36','84e50a8b-43b7-43c3-b61f-b11941f3c222'),
	(155,NULL,'app','m190121_120000_rich_text_config_setting','2019-01-30 12:22:36','2019-01-30 12:22:36','2019-01-30 12:22:36','fc9cf969-fed7-41cb-817e-c50cf27a4a75'),
	(156,NULL,'app','m190125_191628_fix_email_transport_password','2019-01-30 12:22:36','2019-01-30 12:22:36','2019-01-30 12:22:36','c3291c36-d0b7-4bac-8d30-6c76d0b39636'),
	(157,NULL,'app','m190128_181422_cleanup_volume_folders','2019-01-30 12:22:36','2019-01-30 12:22:36','2019-01-30 12:22:36','7e5e948f-a2e9-481a-a5c9-1d5fdb959550'),
	(158,NULL,'app','m190218_143000_element_index_settings_uid','2019-01-30 12:22:36','2019-01-30 12:22:36','2019-01-30 12:22:36','988bb58e-93ba-468a-8257-779da6bed6b7'),
	(159,6,'plugin','m181101_110000_ids_in_settings_to_uids','2019-01-30 12:23:09','2019-01-30 12:23:09','2019-01-30 12:23:09','bc5a3187-d177-4dec-9ffb-d6eba28bfdce'),
	(160,7,'plugin','m190117_000000_soft_deletes','2019-01-30 12:23:09','2019-01-30 12:23:09','2019-01-30 12:23:09','ea3be10b-69e6-4cf6-b823-464b435fbc92'),
	(161,7,'plugin','m190117_000001_context_to_uids','2019-01-30 12:23:09','2019-01-30 12:23:09','2019-01-30 12:23:09','d1e13262-5bfc-436a-a53c-3642ae03053b'),
	(162,7,'plugin','m190120_000000_fix_supertablecontent_tables','2019-01-30 12:23:09','2019-01-30 12:23:09','2019-01-30 12:23:09','305191cd-d05d-4a5c-a6b3-2ed44cb6f4b2'),
	(163,7,'plugin','m190131_000000_fix_supertable_missing_fields','2019-02-04 14:10:08','2019-02-04 14:10:08','2019-02-04 14:10:08','4cb62b70-f73a-45fa-9b54-3f27b1a66b65'),
	(164,9,'plugin','Install','2019-02-09 12:27:41','2019-02-09 12:27:41','2019-02-09 12:27:41','155fa741-5457-444e-b97a-9cbbe79d2213'),
	(165,9,'plugin','m190128_183303_include_project_config','2019-02-09 12:27:41','2019-02-09 12:27:41','2019-02-09 12:27:41','a347aa59-26c8-4ac8-afa9-23c0209059bd'),
	(166,10,'plugin','Install','2019-02-09 12:29:07','2019-02-09 12:29:07','2019-02-09 12:29:07','6f1420a5-463e-4196-8e0f-badf9692328d');

/*!40000 ALTER TABLE `pt_migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_plugins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_plugins`;

CREATE TABLE `pt_plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_plugins` WRITE;
/*!40000 ALTER TABLE `pt_plugins` DISABLE KEYS */;

INSERT INTO `pt_plugins` (`id`, `handle`, `version`, `schemaVersion`, `licenseKeyStatus`, `licensedEdition`, `installDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'eager-beaver','1.0.4','1.0.0','unknown',NULL,'2018-11-06 19:48:48','2018-11-06 19:48:48','2019-02-09 12:29:20','75e3b61a-23b8-440d-9ca8-02214229f452'),
	(2,'imager','v2.1.4','2.0.0','unknown',NULL,'2018-11-06 19:48:52','2018-11-06 19:48:52','2019-02-09 12:29:20','5880e16d-544d-40d8-a11e-18c07ee2cce6'),
	(3,'splash','3.0.2','3.0.0','unknown',NULL,'2018-11-06 20:03:24','2018-11-06 20:03:24','2019-02-09 12:29:20','7c311bf3-2d90-42f0-9a51-a4c6d4ed7132'),
	(5,'freeform','2.5.11','2.1.3','invalid',NULL,'2018-11-07 16:07:44','2018-11-07 16:07:44','2019-02-09 12:29:20','9010b6b3-f122-4d41-b17d-45d5d40ad60d'),
	(6,'redactor','2.3.1','2.2.1','unknown',NULL,'2018-11-21 13:02:36','2018-11-21 13:02:36','2019-02-09 12:29:20','fd1449da-2f55-4f0a-9ee8-bedac1c9d5f1'),
	(7,'super-table','2.1.6','2.0.8','unknown',NULL,'2018-11-28 19:02:30','2018-11-28 19:02:30','2019-02-09 12:29:20','728b3ecb-d511-457b-886b-d3fd46365966'),
	(8,'typedlinkfield','1.0.17','1.0.0','unknown',NULL,'2018-11-28 19:02:32','2018-11-28 19:02:32','2019-02-09 12:29:20','e5f156c9-3384-4316-9e6d-25430506b1cd'),
	(9,'relabel','1.2.2','1.1.0','unknown',NULL,'2019-02-09 12:27:41','2019-02-09 12:27:41','2019-02-09 12:29:20','ce8e03a4-899e-4383-986a-538693a2883d'),
	(10,'spoon','3.2.7','3.0.0','invalid',NULL,'2019-02-09 12:29:07','2019-02-09 12:29:07','2019-02-09 12:29:20','45246cde-5f00-4b57-bbb4-91e075a5677a');

/*!40000 ALTER TABLE `pt_plugins` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_queue`;

CREATE TABLE `pt_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_relabel
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_relabel`;

CREATE TABLE `pt_relabel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `instructions` varchar(255) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `pt_relabel_fieldId_fk` (`fieldId`),
  KEY `pt_relabel_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `pt_relabel_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `pt_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pt_relabel_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `pt_fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_relations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_relations`;

CREATE TABLE `pt_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `pt_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `pt_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_relations` WRITE;
/*!40000 ALTER TABLE `pt_relations` DISABLE KEYS */;

INSERT INTO `pt_relations` (`id`, `fieldId`, `sourceId`, `sourceSiteId`, `targetId`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(5,51,183,NULL,182,1,'2019-01-31 21:09:18','2019-01-31 21:09:18','08127e11-172c-456c-b074-aae379b0ec48'),
	(6,51,183,NULL,181,2,'2019-01-31 21:09:18','2019-01-31 21:09:18','765de2df-3a6b-4fc5-80c8-bf36042dae37'),
	(7,51,183,NULL,180,3,'2019-01-31 21:09:18','2019-01-31 21:09:18','0a3ec2ee-9491-4004-b9b4-b348b00b0848'),
	(8,51,183,NULL,179,4,'2019-01-31 21:09:18','2019-01-31 21:09:18','636977eb-ebc6-420a-a2cf-0eec2e60b2ba');

/*!40000 ALTER TABLE `pt_relations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_resourcepaths
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_resourcepaths`;

CREATE TABLE `pt_resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_resourcepaths` WRITE;
/*!40000 ALTER TABLE `pt_resourcepaths` DISABLE KEYS */;

INSERT INTO `pt_resourcepaths` (`hash`, `path`)
VALUES
	('104e4ffd','@lib/fileupload'),
	('10c8e54c','@app/web/assets/matrix/dist'),
	('11428b1f','@lib/prismjs'),
	('1298516d','@app/web/assets/updateswidget/dist'),
	('13c48196','@lib/jquery-touch-events'),
	('13ef96a3','@app/web/assets/generalsettings/dist'),
	('1460bd54','@lib/picturefill'),
	('15a95a80','@app/web/assets/tablesettings/dist'),
	('171ea88d','@app/web/assets/updater/dist'),
	('17c363fb','@lib'),
	('17dbe43c','@lib/jquery.payment'),
	('1a303697','@craft/web/assets/updateswidget/dist'),
	('1a73bca9','@bower/jquery/dist'),
	('1ac59d05','@lib/d3'),
	('1af88df','@craft/web/assets/plugins/dist'),
	('1b3e5648','@app/web/assets/edituser/dist'),
	('1c0afdac','@app/web/assets/craftsupport/dist'),
	('1c0b7320','@craft/web/assets/feed/dist'),
	('1c8334df','@app/web/assets/utilities/dist'),
	('1df657c5','@craft/redactor/assets/field/dist'),
	('1e2ed243','@lib'),
	('1f11396e','@lib/jquery-ui'),
	('1feac778','@app/web/assets/editentry/dist'),
	('2033442a','@app/web/assets/tablesettings/dist'),
	('20b1ca09','@app/web/assets/updates/dist'),
	('20f49bcd','@app/web/assets/utilities/dist'),
	('20f8adea','@lib/fabric'),
	('2241fa96','@lib/jquery.payment'),
	('231e4e64','@craft/web/assets/craftsupport/dist'),
	('238af62f','@app/web/assets/dashboard/dist'),
	('248a74f9','@craft/web/assets/recententries/dist'),
	('24bc9f51','@app/web/assets/cp/dist'),
	('24edd861','@app/web/assets/fields/dist'),
	('260413bb','@bower/jquery/dist'),
	('29192a75','@app/web/assets/utilities/dist'),
	('29788a83','@lib/garnishjs'),
	('29def592','@app/web/assets/tablesettings/dist'),
	('2b18f9a9','@craft/web/assets/login/dist'),
	('2bac4b2e','@lib/jquery.payment'),
	('2c221303','@app/web/assets/recententries/dist'),
	('2cd0352','@app/web/assets/updater/dist'),
	('2d4932a6','@craft/web/assets/updater/dist'),
	('2e20b196','@vendor/craftcms/redactor/lib/redactor'),
	('2fe9a203','@bower/jquery/dist'),
	('316f348e','@app/web/assets/cp/dist'),
	('3279235a','@app/web/assets/feed/dist'),
	('328220ef','@lib/jquery-ui'),
	('32c342f','@app/web/assets/editentry/dist'),
	('32e7b69a','@freeform/Resources'),
	('33f2d6b0','@lib/timepicker'),
	('355121f0','@app/web/assets/login/dist'),
	('35be79d4','@lib/garnishjs'),
	('35e3175c','@lib/element-resize-detector'),
	('3629699f','@app/web/assets/matrixsettings/dist'),
	('378be4c6','@lib/velocity'),
	('382b2b36','@app/web/assets/fields/dist'),
	('39716fcc','@lib/timepicker'),
	('39f1b8dc','@app/web/assets/recententries/dist'),
	('3a8db10c','@app/web/assets/updater/dist'),
	('3b37735','@app/web/assets/matrixsettings/dist'),
	('3b9492e2','@app/web/assets/feed/dist'),
	('3c3e5ebd','@lib/fabric'),
	('3c77395e','@app/web/assets/updates/dist'),
	('3e66557e','@lib/velocity'),
	('3f4c0578','@app/web/assets/dashboard/dist'),
	('3f84d27a','@app/web/assets/pluginstore/dist'),
	('401e90d0','@lib/selectize'),
	('403755b6','@bower/jquery/dist'),
	('40745f49','@lib/fileupload'),
	('40d75ca3','@typedlinkfield/resources'),
	('4234e7c2','@lib/element-resize-detector'),
	('428fd95c','@app/web/assets/cp/dist'),
	('446b0914','@lib/velocity'),
	('4555d071','@lib/jquery-ui'),
	('45ee97eb','@craft/web/assets/editentry/dist'),
	('46b1cc22','@app/web/assets/login/dist'),
	('46c7ddc0','@app/web/assets/utilities/dist'),
	('48747f30','@app/web/assets/feed/dist'),
	('4a72d45a','@lib/xregexp'),
	('4af7e635','@lib/fileupload'),
	('4b6268e4','@app/web/assets/cp/dist'),
	('4d5a4192','@app/web/assets/updater/dist'),
	('4d9f0d23','@lib/jquery.payment'),
	('4eeb3b45','@verbb/supertable/resources/dist'),
	('4eef06','@craft/web/assets/cp/dist'),
	('4f5c7d9a','@app/web/assets/login/dist'),
	('4fedb39f','@app/web/assets/tablesettings/dist'),
	('4ffe3669','@app/web/assets/sites/dist'),
	('505a25cf','@app/web/assets/pluginstore/dist'),
	('51b8a2cb','@lib/velocity'),
	('521fe7cb','@lib/picturefill'),
	('526703b5','@craft/web/assets/matrix/dist'),
	('52967fba','@craft/web/assets/tablesettings/dist'),
	('5314761f','@app/web/assets/utilities/dist'),
	('5316249b','@app/web/assets/editentry/dist'),
	('537a2c16','@craft/redactor/assets/field/dist'),
	('539dbf6c','@app/web/assets/craftsupport/dist'),
	('55bbdb09','@lib/jquery-touch-events'),
	('55e4fe69','@bower/jquery/dist'),
	('562f4f69','@app/web/assets/recententries/dist'),
	('56397ee6','@lib/d3'),
	('56b4270d','@lib/xregexp'),
	('573dd180','@lib/prismjs'),
	('584ca6fc','@lib/jquery.payment'),
	('589c5eb7','@lib/picturefill'),
	('5a3e1840','@app/web/assets/tablesettings/dist'),
	('5c3406af','@app/web/assets/matrix/dist'),
	('5cbac79a','@lib/d3'),
	('5cd86387','@lib/selectize'),
	('5d0f13ad','@app/web/assets/updateswidget/dist'),
	('5da7d4ef','@app/web/assets/feed/dist'),
	('5dbe68fc','@lib/prismjs'),
	('5f386275','@lib/jquery-touch-events'),
	('5fc2fed1','@app/web/assets/recententries/dist'),
	('600c14a2','@lib/jquery.payment'),
	('6036e52','@lib/d3'),
	('60acca45','@vendor/craftcms/redactor/lib/redactor'),
	('6141bb3c','@app/web/assets/plugins/dist'),
	('6178bcbf','@app/web/assets/updateswidget/dist'),
	('63b551c3','@app/web/assets/recententries/dist'),
	('654855eb','@craft/web/assets/dashboard/dist'),
	('65846960','@lib/garnishjs'),
	('6607a1c6','@app/web/assets/craftsupport/dist'),
	('661ca4f','@lib/selectize'),
	('66ce9096','@app/web/assets/updates/dist'),
	('68950d07','@app/web/assets/updateswidget/dist'),
	('68e37b9','@lib/xregexp'),
	('694b7f78','@lib/timepicker'),
	('6a7eeef1','@angellco/spoon/assetbundles/dist'),
	('6b54c441','@app/web/assets/utilities/dist'),
	('6c4d29ea','@app/web/assets/updates/dist'),
	('6c6d8080','@app/web/assets/matrixsettings/dist'),
	('6cbb8f71','@typedlinkfield/resources'),
	('6da44c37','@bower/jquery/dist'),
	('6f07d01c','@lib/garnishjs'),
	('6fa7fe43','@lib/element-resize-detector'),
	('6fea107e','@app/web/assets/craftsupport/dist'),
	('70c2bd5e','@lib/fabric'),
	('70cfcedb','@lib/jquery-ui'),
	('712dee80','@app/web/assets/updater/dist'),
	('73b0e69b','@app/web/assets/dashboard/dist'),
	('74d7c8d5','@app/web/assets/fields/dist'),
	('758d8c2f','@lib/timepicker'),
	('75dcd0ae','@app/web/assets/generalsettings/dist'),
	('76515211','@Solspace/Freeform/Resources'),
	('77c798b0','@verbb/supertable/resources/dist'),
	('781d944e','@lib'),
	('78c05f38','@app/web/assets/updater/dist'),
	('7909f6','@lib/element-resize-detector'),
	('79227f63','@lib/jquery-ui'),
	('79335fe7','@app/web/assets/dashboard/dist'),
	('79be2b5f','@app/web/assets/matrixsettings/dist'),
	('7a410422','@lib/fabric'),
	('7a74559c','@lib/element-resize-detector'),
	('7a82b687','@craft/web/assets/matrixsettings/dist'),
	('7a84cdcf','@craft/web/assets/fields/dist'),
	('7ac66330','@app/web/assets/login/dist'),
	('7c2bbb4a','@lib/velocity'),
	('7e33df0','@app/web/assets/feed/dist'),
	('7e5471a9','@app/web/assets/fields/dist'),
	('7ef8764e','@app/web/assets/cp/dist'),
	('7f590e50','@typedlinkfield/resources'),
	('81829710','@app/web/assets/dashboard/dist'),
	('8193b794','@lib/jquery-ui'),
	('8289fdda','@craft/web/assets/feed/dist'),
	('82f0ccd5','@lib/fabric'),
	('82fcfaf2','@app/web/assets/utilities/dist'),
	('831f9f0b','@app/web/assets/updater/dist'),
	('840c7284','@bower/jquery/dist'),
	('84b2b86d','@craft/web/assets/updateswidget/dist'),
	('855a008a','@app/web/assets/feed/dist'),
	('855d6fcc','@verbb/supertable/resources/dist'),
	('86e5b95e','@app/web/assets/fields/dist'),
	('875cabe0','@lib/xregexp'),
	('886f26a8','@app/web/assets/dashboard/dist'),
	('894576ae','@lib/velocity'),
	('899c2677','@app/web/assets/updater/dist'),
	('89a42a11','@lib/jquery.payment'),
	('8a64e03','@lib/picturefill'),
	('8b100ee8','@lib/jquery-ui'),
	('8b1d7d6d','@lib/fabric'),
	('8bb11d2e','@vendor/craftcms/redactor/lib/redactor'),
	('8bd694ad','@app/web/assets/tablesettings/dist'),
	('8d30ef6a','@lib/selectize'),
	('8d6d1859','@app/web/assets/generalsettings/dist'),
	('8dd16a8b','@verbb/supertable/resources/dist'),
	('8e3181d0','@lib/fileupload'),
	('8f0808e6','@app/web/assets/fields/dist'),
	('917dbcec','@lib/jquery-touch-events'),
	('9271d836','@app/web/assets/matrix/dist'),
	('928f003f','@lib/xregexp'),
	('92f86d0','@app/web/assets/cp/dist'),
	('934acd34','@app/web/assets/updateswidget/dist'),
	('935df7b','@craft/web/assets/pluginstore/dist'),
	('93fbb665','@lib/prismjs'),
	('9562d946','@lib/jquery.payment'),
	('958385f9','@lib/velocity'),
	('96d9802e','@lib/picturefill'),
	('971067fa','@app/web/assets/tablesettings/dist'),
	('975bd889','@app/web/assets/craftsupport/dist'),
	('9792e9d9','@app/web/assets/updates/dist'),
	('97b618eb','@lib/garnishjs'),
	('97b75181','@craft/web/assets/pluginstore/dist'),
	('987ca07f','@lib/d3'),
	('98ca81d3','@bower/jquery/dist'),
	('98e344b5','@lib/selectize'),
	('994b84e','@lib/element-resize-detector'),
	('999cf3dd','@app/web/assets/feed/dist'),
	('99c97448','@app/web/assets/updateswidget/dist'),
	('9d53fa02','@app/web/assets/editentry/dist'),
	('9d95673','@app/web/assets/craftsupport/dist'),
	('9dd861f5','@app/web/assets/craftsupport/dist'),
	('9e3a09a5','@app/web/assets/utilities/dist'),
	('9e5ba953','@lib/garnishjs'),
	('9e7f5861','@app/web/assets/updates/dist'),
	('9ecc61fc','@craft/web/assets/cp/dist'),
	('9f2d0625','@craft/web/assets/plugins/dist'),
	('a1065c80','@app/web/assets/pluginstore/dist'),
	('a1245510','@app/web/assets/editentry/dist'),
	('a208f773','@app/web/assets/updates/dist'),
	('a3439e84','@lib/picturefill'),
	('a40b0f6d','@lib/d3'),
	('a4e7a246','@lib/jquery-touch-events'),
	('a57a9c0e','@app/web/assets/plugins/dist'),
	('a5ec68d','@app/web/assets/matrixsettings/dist'),
	('a661a8cf','@lib/prismjs'),
	('a7733626','@app/web/assets/recententries/dist'),
	('a856a7b2','@app/web/assets/matrixsettings/dist'),
	('aaae2f3c','@lib/picturefill'),
	('ab9cd971','@lib/element-resize-detector'),
	('abc1b7f9','@lib/garnishjs'),
	('ac292b1','@lib/jquery-ui'),
	('ad0a13fe','@lib/jquery-touch-events'),
	('ad70584a','@lib/timepicker'),
	('ade6bed5','@lib/d3'),
	('adf08f5a','@app/web/assets/recententries/dist'),
	('ae03ff0f','@ether/splash/resources'),
	('ae067724','@app/web/assets/matrix/dist'),
	('af8c1977','@lib/prismjs'),
	('b0bda8d7','@app/web/assets/cp/dist'),
	('b2462ec2','@lib/fileupload'),
	('b3960da9','@anubarak/relabel/resources'),
	('b3cbbc5c','@craft/web/assets/updater/dist'),
	('b483bda9','@app/web/assets/login/dist'),
	('b49054e5','@app/web/assets/matrixsettings/dist'),
	('b5705d34','@lib/selectize'),
	('b74ffe9e','@app/web/assets/sites/dist'),
	('b75a2a26','@lib/element-resize-detector'),
	('b8a3f395','@lib/timepicker'),
	('ba08fa03','@craft/web/assets/recententries/dist'),
	('ba3e11ab','@app/web/assets/cp/dist'),
	('ba92164c','@app/web/assets/fields/dist'),
	('bbab9f7a','@lib/fileupload'),
	('bc692a07','@app/web/assets/deprecationerrors/dist'),
	('bd9cc09e','@craft/web/assets/craftsupport/dist'),
	('bdf53802','@app/web/assets/dashboard/dist'),
	('be0004d5','@app/web/assets/login/dist'),
	('be8763c7','@lib/fabric'),
	('bf1c19be','@lib/xregexp'),
	('bfc4bd4','@lib/velocity'),
	('c00c04c4','@typedlinkfield/resources'),
	('c0d8ec5','@lib/xregexp'),
	('c0e161b','@app/web/assets/matrix/dist'),
	('c1a6c310','@lib/fileupload'),
	('c2384960','@lib/d3'),
	('c2a7adaa','@lib/selectize'),
	('c2aeafff','@lib/timepicker'),
	('c3255a15','@app/web/assets/feed/dist'),
	('c349da03','@app/web/assets/plugins/dist'),
	('c370dd80','@app/web/assets/updateswidget/dist'),
	('c4af134c','@app/web/assets/sites/dist'),
	('c5b9954d','@lib/velocity'),
	('c717131d','@app/web/assets/editentry/dist'),
	('c7eced0b','@lib/jquery-ui'),
	('c8353129','@app/web/assets/matrix/dist'),
	('c88bcaa','@lib/fileupload'),
	('c8cbe920','@lib/xregexp'),
	('c9509359','@lib/fabric'),
	('c9a6e369','@app/web/assets/feed/dist'),
	('c9bf5f7a','@lib/prismjs'),
	('caa46bbb','@app/web/assets/plugins/dist'),
	('cb3955f3','@lib/jquery-touch-events'),
	('cb431e47','@lib/timepicker'),
	('cc14f140','@craft/web/assets/tablesettings/dist'),
	('cc9d6931','@lib/picturefill'),
	('cce58d4f','@craft/web/assets/matrix/dist'),
	('cde27141','@app/web/assets/craftsupport/dist'),
	('ce27333','@lib/selectize'),
	('cf3a2c31','@lib/velocity'),
	('cfe37ce8','@app/web/assets/updater/dist'),
	('d1248216','@app/web/assets/craftsupport/dist'),
	('d16f3d65','@app/web/assets/tablesettings/dist'),
	('d17cb893','@app/web/assets/sites/dist'),
	('d2c6ea46','@app/web/assets/utilities/dist'),
	('d31d83d9','@lib/jquery.payment'),
	('d3258fbf','@app/web/assets/updater/dist'),
	('d4366230','@bower/jquery/dist'),
	('d47568cf','@lib/fileupload'),
	('d57b88d1','@app/web/assets/edituser/dist'),
	('d5df07ed','@app/web/assets/updates/dist'),
	('d7ebe2bf','@lib/d3'),
	('d845533a','@app/web/assets/utilities/dist'),
	('d847848','@lib/prismjs'),
	('d94ec2ee','@lib/picturefill'),
	('d99e3aa5','@lib/jquery.payment'),
	('db2a1e5c','@lib/jquery-ui'),
	('db6c1911','@craft/web/assets/editentry/dist'),
	('dbec8419','@app/web/assets/tablesettings/dist'),
	('dc164767','@lib/garnishjs'),
	('deb5db4c','@bower/jquery/dist'),
	('deeafe2c','@lib/jquery-touch-events'),
	('dfb62ed7','@app/web/assets/updateswidget/dist'),
	('e087b863','@app/web/assets/cp/dist'),
	('e0d6ff53','@app/web/assets/fields/dist'),
	('e10c6cb9','@app/web/assets/recententries/dist'),
	('e10e70b0','@lib/picturefill'),
	('e400387d','@craft/web/assets/matrixsettings/dist'),
	('e4064335','@craft/web/assets/fields/dist'),
	('e456f539','@lib/garnishjs'),
	('e4b9ad1d','@app/web/assets/login/dist'),
	('e4c38ad8','@lib/fabric'),
	('e69f1ab4','@lib'),
	('e6aa4c72','@lib/jquery-touch-events'),
	('e7b1d11d','@app/web/assets/dashboard/dist'),
	('ed9fb5b3','@app/web/assets/updates/dist'),
	('ef2b98e1','@freeform/Resources'),
	('efab50e1','@lib/d3'),
	('f0272c1','@lib/jquery-touch-events'),
	('f1102107','@lib/fabric'),
	('f12570b9','@lib/element-resize-detector'),
	('f1855ee6','@lib/garnishjs'),
	('f2627ac2','@app/web/assets/dashboard/dist'),
	('f2ef0e7a','@app/web/assets/matrixsettings/dist'),
	('f4bc4632','@lib/xregexp'),
	('f505548c','@app/web/assets/fields/dist'),
	('f6eb80ae','@craft/redactor/assets/field/dist'),
	('f734b155','@lib/timepicker'),
	('f73db300','@lib/selectize'),
	('f84c1e6c','@app/web/assets/updates/dist'),
	('f86cb706','@app/web/assets/matrixsettings/dist'),
	('f87f5e4a','@app/web/assets/login/dist'),
	('f9e6714e','@lib/fileupload'),
	('fb3e48d3','@supercool/buttonbox/assetbundles/buttonbox/dist'),
	('fba6c9c5','@lib/element-resize-detector'),
	('fbcadb11','@craft/web/assets/dashboard/dist'),
	('fc414b34','@app/web/assets/cp/dist'),
	('fd51f78a','@lib/xregexp'),
	('fdca9fee','@app/web/assets/recententries/dist'),
	('fed002b8','@lib/selectize'),
	('ff3e7511','@app/web/assets/plugins/dist');

/*!40000 ALTER TABLE `pt_resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_searchindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_searchindex`;

CREATE TABLE `pt_searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `pt_searchindex` WRITE;
/*!40000 ALTER TABLE `pt_searchindex` DISABLE KEYS */;

INSERT INTO `pt_searchindex` (`elementId`, `attribute`, `fieldId`, `siteId`, `keywords`)
VALUES
	(1,'username',0,1,' kylea page works '),
	(1,'firstname',0,1,''),
	(1,'lastname',0,1,''),
	(1,'fullname',0,1,''),
	(1,'email',0,1,' kylea page works '),
	(1,'slug',0,1,''),
	(169,'field',52,1,' office 23p9zngsius '),
	(169,'field',58,1,''),
	(169,'field',59,1,''),
	(169,'slug',0,1,''),
	(170,'field',52,1,' office jjhvyxm34ny '),
	(170,'field',58,1,''),
	(170,'field',59,1,''),
	(170,'slug',0,1,''),
	(171,'field',52,1,' office nz50hrjafnc '),
	(171,'field',58,1,''),
	(171,'field',59,1,''),
	(171,'slug',0,1,''),
	(172,'field',52,1,' office qlqnalpe0ra '),
	(172,'field',58,1,''),
	(172,'field',59,1,''),
	(172,'slug',0,1,''),
	(173,'field',52,1,' office sklqgtlrykc '),
	(173,'field',58,1,''),
	(173,'field',59,1,''),
	(173,'slug',0,1,''),
	(179,'filename',0,1,' checkout png '),
	(179,'extension',0,1,' png '),
	(179,'kind',0,1,' image '),
	(179,'slug',0,1,''),
	(179,'title',0,1,' checkout '),
	(180,'filename',0,1,' checkout 2x png '),
	(180,'extension',0,1,' png '),
	(180,'kind',0,1,' image '),
	(180,'slug',0,1,''),
	(180,'title',0,1,' checkout 2x '),
	(181,'filename',0,1,' shopping png '),
	(181,'extension',0,1,' png '),
	(181,'kind',0,1,' image '),
	(181,'slug',0,1,''),
	(181,'title',0,1,' shopping '),
	(182,'filename',0,1,' shopping 2x png '),
	(182,'extension',0,1,' png '),
	(182,'kind',0,1,' image '),
	(182,'slug',0,1,''),
	(182,'title',0,1,' shopping 2x ');

/*!40000 ALTER TABLE `pt_searchindex` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_sections
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_sections`;

CREATE TABLE `pt_sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagateEntries` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `pt_sections_dateDeleted_idx` (`dateDeleted`),
  KEY `pt_sections_name_idx` (`name`),
  KEY `pt_sections_handle_idx` (`handle`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `pt_structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_sections` WRITE;
/*!40000 ALTER TABLE `pt_sections` DISABLE KEYS */;

INSERT INTO `pt_sections` (`id`, `structureId`, `name`, `handle`, `type`, `enableVersioning`, `propagateEntries`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(2,1,'Standard Pages','standardPages','structure',1,1,'2018-11-06 19:23:08','2018-11-20 20:01:32',NULL,'b192f8ce-1e5a-495d-bb45-ede8cd1ad3d4');

/*!40000 ALTER TABLE `pt_sections` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_sections_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_sections_sites`;

CREATE TABLE `pt_sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `pt_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `pt_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_sections_sites` WRITE;
/*!40000 ALTER TABLE `pt_sections_sites` DISABLE KEYS */;

INSERT INTO `pt_sections_sites` (`id`, `sectionId`, `siteId`, `hasUrls`, `uriFormat`, `template`, `enabledByDefault`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,2,1,1,'{parent.slug}/{slug}','_complex-content/entry',1,'2018-11-06 19:23:08','2018-11-20 20:01:32','f9cded0e-6ce6-4afe-b628-6337b597095b');

/*!40000 ALTER TABLE `pt_sections_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_sequences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_sequences`;

CREATE TABLE `pt_sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_sessions`;

CREATE TABLE `pt_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `pt_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_sessions` WRITE;
/*!40000 ALTER TABLE `pt_sessions` DISABLE KEYS */;

INSERT INTO `pt_sessions` (`id`, `userId`, `token`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'iPPgar9bzP5cCnb3FNJBfcr1c_Gge0YxR8ufc6-osx489nw0TscYX9UhZm_fUPZD3RoBHh6PGy89TkcUYGUvktHDDx6f3A1bl9FA','2018-11-06 19:21:04','2018-11-06 20:11:52','39a2d76f-e892-4b93-89c8-72e012bbeaa4'),
	(2,1,'UUILjvPnu_G6bvyL7HnCspQ39QOk7qCWWIlHgbCfqUsGXW_klmmbbmiYUnLURK3743jUgbmur4RlzRCmTpmZMD9BvqqNgmaEDsc9','2018-11-06 20:12:31','2018-11-06 20:26:49','7e342365-8bd5-4134-b2c6-6ffbfc4332f3'),
	(3,1,'ycU0DSgtKZUA6H5uMm2gdnjISf19mfHxv4nQTt-YGEVNOEezA3iCTLjMg0gD47F088ZB1UenyijWCrhCmKpWqxWY7CEjqrFQstNy','2018-11-06 20:27:18','2018-11-06 20:30:01','3f74149f-0179-4308-8e44-c55dbae1393c'),
	(4,1,'AtPllifZASf7lya0BzIXqBvyBEc5YOSsRlQJlDog0ACTOFiRUqqZ6EJLOpFuuoiC4O21M27_t0ztgXtnk4og1LUe0kpfsOgFZxjx','2018-11-06 20:30:16','2018-11-06 21:00:46','051bfde1-1ada-43a5-bbb5-b547773afe5c'),
	(5,1,'y9rep5fQxBlO-frBWlV20kpaZUOM73fGi-tGEUyEPQidMYJPx9MoZEQ55DCSpoEpXN_n_0Z5og6s1-2xx6vb9_vo-7goDmZXhAwo','2018-11-06 20:30:20','2018-11-06 20:30:20','40e0dfad-4e24-48c0-b6a2-85147e5a1dd2'),
	(6,1,'9saOpqZHOLVVIM-mEiyXUzUivws3Uhw-SnjccwnMlQ0YQi53_LVmC8sDkV_gzbJj6sF9nmmR5FWteKjzyuq58pQhhOPrAvpJDAx9','2018-11-07 12:58:03','2018-11-07 18:50:11','58a0a69a-8370-4e3f-a45d-6d4563f7bb3c'),
	(7,1,'CtWWiCclv2QBMBW72ipQ4XIiCA9jX-UUYg3Sn2E8ZIAbIj5rp3RQujFpYq24Qphx1_EQ3dD4m1OuTUuE6euc89vfFuzlrW7h18M6','2018-11-21 12:55:43','2018-11-21 13:57:37','2d553e10-beb8-4db0-8ab7-ef8263b3de9b'),
	(8,1,'togDY9Qlhnqo4WrfEZ5OPua6H17E0GeuA76okHGW6381Dxiwl8mjXOvN0iqGWNyjYFbm9oEboxrs_XboB3pFGdvpG5u2k9KbA4MD','2018-11-26 20:27:50','2018-11-26 21:00:00','eb9e505b-e102-4609-bf14-1b333a9e9fb0'),
	(9,1,'Ltqavom1CWn6f1oIwHiNojmstSqKtoyX5UUV5nbwo_lMkzqHuWtYIzT4xHGPohGGDSuGpjPJ_Q8LZ7iijWx1gwjnsghASuywsgJE','2018-11-27 19:27:40','2018-11-27 20:52:52','665bb8bd-7ef4-49b2-93a5-a3691115cf29'),
	(10,1,'YN6phNjDw8vUofJsMmRMIzIfjjSIPQL9ZIDkHO1wnh0UhqzLU-4dpe-Smar1Cen9EBqDmSNQpEDq-s6Z6tY12v1L0YuZmh0XI9YS','2018-11-28 13:21:10','2018-11-28 20:48:42','976481de-626d-4475-8018-253c083824cb'),
	(12,1,'mFvt396QLTDkgMCeDWS_CqYjeIUAVq4aOUmT74M24Uj9MhSPGCtpEPqsyDGBH4RAUERmteS823kKdpdpQ029YaT-szqHbbifKvWm','2018-11-29 13:14:39','2018-11-29 16:03:32','89a78b3f-f0ea-4c23-8ce7-fa300364cf8f'),
	(13,1,'KOb22sNNydNhLgZYah5MSFs_Y3KjL6gCBrPxX7_2kgY7mC2psoulViKgeSpYFAvOH5aEPmXhW0xDf7TEMCcPFqojnCtNHUSJY3DY','2018-11-29 18:34:34','2018-11-29 20:56:30','dd1afaba-44cb-4173-bc50-0fc5f0890785'),
	(14,1,'1n9Ku68avKyu5RM0TYdGTcfvtq7EsK_KJpv_9aU4nBE9Q_HmgKsURNDOqRFJGNU-96e5ys7UpNmtvE1YW4h7ATiNv0oRo_7B3W_B','2018-11-30 12:47:38','2018-11-30 12:48:03','62d97d99-5ef9-4672-9cd0-0b57068b299e'),
	(15,1,'4eZnigxvgTap-1Ne020IDcSBOyTbAlIj0IcAwRsilwhPsV0Fm1EIqfJ1w2mi8wjBLESxVSLDsq6YS80B1FEx64AHHL0Jj1CkCTdD','2018-11-30 19:56:12','2018-11-30 20:20:13','744e43d1-04a2-41b7-8598-d032ac7c9d72'),
	(16,1,'9B4aCQ27xAd5LRJj7CxKoETUp5mDLf400v4z2v5008jd4jXnLIUC5SIhmQdVWLrxsiWfs_nwEbPYJ_s0qsm7Mh3xvaKOP1IHP5Gr','2018-12-04 14:33:20','2018-12-04 15:17:26','9db1df81-b539-474e-9449-0cc569a88b8a'),
	(18,1,'Ml7XEtUmgdHARjd_UBhxD6N7iVk1yu7OV3qFSumoT0S5hhLxMs7VwN0ck5d9DQZEtyErKVAMEZJWmAj_ag2Ta3aaUx2aAmhJ8EXm','2018-12-07 16:57:48','2018-12-07 19:48:46','16d3dad4-19b3-47f1-ad68-9bad206c136e'),
	(19,1,'LE4yvcJluh_O79UlG_Z9lCC5X92BNL5MOG1Yf4C3HLStCy-Kf3lZ-caoapzyCD9FWy0RX_G1fh-vDoMfOeCr4trh7ZthV7Az2Ie1','2018-12-08 13:40:44','2018-12-08 15:10:46','fc333c11-cabf-493e-a059-c4c49f7739a6'),
	(20,1,'oZN4bHD8aFwIybAtbP9m_BpDycCIS099afxxz-UwCm0hyV4Xl4G_oU4wa_R2vQNtLS_0Z8-q6Dhq9u_b_VGKEXatsMHJMWN-_cI7','2018-12-14 16:58:13','2018-12-14 17:29:03','5c180750-e41a-4e67-a5aa-c2430ccd9e43'),
	(21,1,'dO9jBvgGuWGzbIBD4RrAPaXA5sd3VkJGhwDcaZoWrPKXmnz1NLaTvJR0ZCa0ZUVQX4gp1ywjnSlqkk9NHUICDw3VtfnMqi-H8G4p','2018-12-18 14:37:29','2018-12-18 15:14:40','8f0cf10e-cf36-4133-960d-7bd21fc859ee'),
	(22,1,'S5-W3KsvRWBxfYqHubdLehZifxygdZyrb7mYGVTN6Y_9H8yh-9ROU-Ioc3Q3B54E8vHKSRCXFdt7UGMMb9qvBYnkSfRLr9-_ythM','2019-01-05 00:07:19','2019-01-05 00:21:37','6c67ac9f-4393-4760-9ebd-6399bb0a47a0'),
	(23,1,'NXxhLbx-pmb4vnzP1Z7oXQZvmRS1sSCebWC_XV9CuBsuUjJs6FhCH7H0I18x15O-ou4kUwxPUx-DP9Ca5ZdWaw0jN9hSSO8ckt9b','2019-01-09 23:56:34','2019-01-09 23:58:10','b1435254-bea0-4fd0-869f-e7d0dbd36d41'),
	(24,1,'gprczZrsyWt5GM88iiXADX7ZBafPvuU8b2CoJ2RoyG4njoZ4PUuqXILURwS1q71D8ttvzzIQecD-fTRukE_OGQDq4rcoAJHQx6Vh','2019-01-29 19:09:41','2019-01-29 21:05:10','c4379591-9f6c-4ebe-a2bf-a37051bb2258'),
	(25,1,'hmyvQ0I78m1cR6zOLnWvO4nUyfgBEnQmByzKzej_EBWt1AQVImDKI1hMpRSP6acx4iX12qJ3WclXy9l1ylbjKG12rVQmX4wL6Vko','2019-01-30 12:13:39','2019-01-30 12:22:11','a3ddccbf-a9ba-4857-b0f5-c0c83108122f'),
	(26,1,'9wrA-oJPyXmeem7ahhz01_208HulHOY40XB5AqTPKrtankmc7pghImYmaHvLmP5HDfT7ryu1heAIrAb0Bxu9fKSBkzIY077WmgyG','2019-01-30 12:22:30','2019-01-30 12:53:43','40759c69-5f4e-43fb-9023-9f46f9f4001e'),
	(27,1,'QOaEwNTC-mtA3pSRWodP-koMh0LoIEp8WzjV8K0V_41-3jCEkzaSJiNzLlYGnBAE3sVqGvLH9qM3bdkLkxzDNSNhaE7vuWmmuBbE','2019-01-30 16:47:04','2019-01-30 18:50:11','0ef3e50c-5d50-4fc0-87ee-373efec26b1a'),
	(28,1,'SBk4AY2Xhfziy6FRcqr-LjcJLx3yJRk5tGZ19XDuAU2GSIA6HZvxVK0cbAzqlhm4rmldHvIpP1RLdhQN3OFUVaxJsSCg2S-pSXiP','2019-01-30 19:50:15','2019-01-30 19:50:15','fccb6a89-da4a-401e-af0b-ea1f6aba83de'),
	(29,1,'4QfR134OTvCRayFlXaCMjnIG3wopCp_IC7F53cYNE4hkpsUYOQ_-xKInrb3KnyVhmGyMIvKc75bRrPs6UAND9ykAhvHcKXmDdZCo','2019-01-31 18:30:26','2019-01-31 21:17:52','643cfb72-3039-48f6-902b-9848b4fc74e5'),
	(30,1,'T1R2n_CsIrOpSDfXPQfyxeVSUXmi5-Synzp_AvqUzF4wlNUx32hwh_tqGzeofIk-JlFuqngEm3oZ2QgYkdcoMB9QXBlyjvxdaOyF','2019-02-01 15:49:00','2019-02-01 16:13:41','d245d797-41f5-492a-987a-80ac84b3beba'),
	(31,1,'bvrPX0_azpmop-2HWDYVOaCWGcITWEkP_ZuZk6sdOzCrdowjSkLoOQbbI7w5EhRuHS0_o0XqRl7tUMca5p982K0aJJut4mP40nuO','2019-02-01 17:13:45','2019-02-01 21:08:50','e8cf10ff-3cb4-4a60-8804-6bab4010788e'),
	(32,1,'xd9RwBjKfaXUN-oadNR3f9j6TM00bVTWt_CPXtue_wYL4XtCw_J0GaDQUgklWvKBSY4Kb0mT09TY5VCgTpPG_xMRMddb8XFFLiPk','2019-02-04 14:07:56','2019-02-04 14:47:11','85bc8819-5502-4ac6-8611-cda8e36eda95'),
	(33,1,'-UlXXIBlie7Ts9nelzXC7syrC5vIFj9JKIxtzL-Edtz8zMWpXUf-_ehGdoZNh5wiqI9Tc66ej4a7pq3nwgOXNYpI4vmR6s8GtPkR','2019-02-04 15:47:15','2019-02-04 20:25:16','2bac22ab-dbce-4cbc-a84e-924446bd8393'),
	(34,1,'iKyOSaCSLaaEO9F3qkUwTuMJNU8oPf88pEOC9YqUVtlR0-6-FkUwp5x6X9eOLMZu3w6pRuhyzoPyhGZfVLJmz4Rq4Y_PCWLNCQS4','2019-02-05 16:46:51','2019-02-05 19:12:51','3cf2a12a-b23b-49cf-92c2-94da690b9b39'),
	(35,1,'jvyylvIqIMEvupEVVZNs089kspPMtlvCIExYYF4yt70I47xyBC71gKKftSiMhikYQ_HKqwiJ47t6JkSRuqRJT7NlWED1G0K-j6KW','2019-02-05 20:12:55','2019-02-05 20:59:55','a56e1f9f-ea96-4b31-8038-28475b3e42bc'),
	(36,1,'Cyh_RVHPhxTJFJlq53jxzcne3HESNGIKFPa3q5Z8pzutHLc3IWDHS6isgJFG871g4Hsidp_Kdv8T3VR0SF2AP5iqhUQ9UBEvuAkV','2019-02-06 16:43:56','2019-02-06 18:38:18','d3d85426-cb46-49d1-8768-1c3a16bc161b'),
	(37,1,'zEOcg7ahIYv83tEloFfB655qPvji4JJx52rlpi732qJSu85TbcwKcJ02IQyHP-XfjsnohOO5ABxt6NgLk1h71ggyh-CLDcTixfA5','2019-02-06 19:35:22','2019-02-06 19:36:17','0bfa3343-be91-4d16-8daa-48e39547db64'),
	(38,1,'wIRX1B54oEKK071LOBX05CFyGpLHkMPW-h04NusF8PgfNWG_s0SA0bOo4PttxRq4k8GJcWtfmGMfYMqPtYpOZ2Eqwt8NWkNVLVkY','2019-02-09 12:26:31','2019-02-09 13:09:36','87aa7a20-7b58-4652-a6e9-0f1b2d2026ed');

/*!40000 ALTER TABLE `pt_sessions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_shunnedmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_shunnedmessages`;

CREATE TABLE `pt_shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `pt_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_sitegroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_sitegroups`;

CREATE TABLE `pt_sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `pt_sitegroups_dateDeleted_idx` (`dateDeleted`),
  KEY `pt_sitegroups_name_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_sitegroups` WRITE;
/*!40000 ALTER TABLE `pt_sitegroups` DISABLE KEYS */;

INSERT INTO `pt_sitegroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,'Website','2018-10-17 19:43:46','2019-01-30 12:41:23',NULL,'f5eb95d0-c53e-4630-b230-91539b9e08b2');

/*!40000 ALTER TABLE `pt_sitegroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_sites`;

CREATE TABLE `pt_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  KEY `pt_sites_dateDeleted_idx` (`dateDeleted`),
  KEY `pt_sites_handle_idx` (`handle`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `pt_sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_sites` WRITE;
/*!40000 ALTER TABLE `pt_sites` DISABLE KEYS */;

INSERT INTO `pt_sites` (`id`, `groupId`, `primary`, `name`, `handle`, `language`, `hasUrls`, `baseUrl`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,1,1,'Papertrain Boilerplate','default','en-US',0,NULL,1,'2018-10-17 19:43:46','2019-01-30 12:45:30',NULL,'ac246379-14f1-440a-82f2-90ef2b3e6443');

/*!40000 ALTER TABLE `pt_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_spoon_blocktypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_spoon_blocktypes`;

CREATE TABLE `pt_spoon_blocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `matrixBlockTypeId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `groupName` varchar(255) NOT NULL DEFAULT '',
  `context` varchar(255) NOT NULL DEFAULT '',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `pt_spoon_blocktypes_fieldId_idx` (`fieldId`),
  KEY `pt_spoon_blocktypes_matrixBlockTypeId_idx` (`matrixBlockTypeId`),
  KEY `pt_spoon_blocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `pt_spoon_blocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `pt_fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pt_spoon_blocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `pt_fieldlayouts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pt_spoon_blocktypes_matrixBlockTypeId_fk` FOREIGN KEY (`matrixBlockTypeId`) REFERENCES `pt_matrixblocktypes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_spoon_blocktypes` WRITE;
/*!40000 ALTER TABLE `pt_spoon_blocktypes` DISABLE KEYS */;

INSERT INTO `pt_spoon_blocktypes` (`id`, `fieldId`, `matrixBlockTypeId`, `fieldLayoutId`, `groupName`, `context`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(241,1,1,21,'Section','global','2019-02-09 13:02:32','2019-02-09 13:02:32','582ab02f-e558-4fa2-9717-d8ab3ae55113'),
	(242,1,3,22,'Column Settings','global','2019-02-09 13:02:32','2019-02-09 13:02:32','0b76c707-93df-4888-be2c-6c627acd99de'),
	(243,1,4,NULL,'Column Settings','global','2019-02-09 13:02:32','2019-02-09 13:02:32','d6a0c3ef-2204-4950-8e92-588e40f01935'),
	(244,1,2,32,'Copy Content','global','2019-02-09 13:02:32','2019-02-09 13:02:32','ccee72fb-5827-478b-becb-99705ccf0cbd'),
	(245,1,5,37,'Copy Content','global','2019-02-09 13:02:32','2019-02-09 13:02:32','90dd80a5-e6d8-4b2b-ba99-6ccd350b1076'),
	(246,1,8,30,'Copy Content','global','2019-02-09 13:02:32','2019-02-09 13:02:32','399baf61-0423-4cb3-951d-46a3170db7bb'),
	(247,1,10,29,'Copy Content','global','2019-02-09 13:02:32','2019-02-09 13:02:32','15df8f81-8033-4dc6-88e9-9c75ed35fbb0'),
	(248,1,11,28,'Copy Content','global','2019-02-09 13:02:32','2019-02-09 13:02:32','3b8499d5-0366-4699-8bd4-97ce845af257'),
	(249,1,6,33,'Media Content','global','2019-02-09 13:02:32','2019-02-09 13:02:32','b2162fe7-80e2-4af0-802a-4e4cd9edc55a'),
	(250,1,9,34,'Media Content','global','2019-02-09 13:02:32','2019-02-09 13:02:32','c1411375-2944-4c17-9762-fcf7bef04972'),
	(251,1,7,35,'Interactive Content','global','2019-02-09 13:02:32','2019-02-09 13:02:32','a35c6327-512c-4655-ae39-d73d4af31621'),
	(252,1,12,36,'Interactive Content','global','2019-02-09 13:02:32','2019-02-09 13:02:32','da25addd-a728-4c7b-9a6b-da6fc345a673');

/*!40000 ALTER TABLE `pt_spoon_blocktypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_stc_10_rows
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_stc_10_rows`;

CREATE TABLE `pt_stc_10_rows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_heading` text,
  `field_body` text,
  `field_list` text,
  `field_splitList` tinyint(1) DEFAULT NULL,
  `field_listStyle` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stc_10_rows_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `stc_10_rows_siteId_fk` (`siteId`),
  CONSTRAINT `stc_10_rows_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `stc_10_rows_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `pt_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_stc_11_listitems
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_stc_11_listitems`;

CREATE TABLE `pt_stc_11_listitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_item` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stc_11_listitems_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `stc_11_listitems_siteId_fk` (`siteId`),
  CONSTRAINT `stc_11_listitems_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `stc_11_listitems_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `pt_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_stc_7_buttons
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_stc_7_buttons`;

CREATE TABLE `pt_stc_7_buttons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_buttonLink` text,
  `field_buttonStyle` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stc_7_buttons_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `stc_7_buttons_siteId_fk` (`siteId`),
  CONSTRAINT `stc_7_buttons_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `stc_7_buttons_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `pt_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_stc_9_slides
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_stc_9_slides`;

CREATE TABLE `pt_stc_9_slides` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_headline` text,
  `field_body` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stc_9_slides_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `stc_9_slides_siteId_fk` (`siteId`),
  CONSTRAINT `stc_9_slides_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `stc_9_slides_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `pt_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_stc_9_slides` WRITE;
/*!40000 ALTER TABLE `pt_stc_9_slides` DISABLE KEYS */;

INSERT INTO `pt_stc_9_slides` (`id`, `elementId`, `siteId`, `dateCreated`, `dateUpdated`, `uid`, `field_headline`, `field_body`)
VALUES
	(1,169,1,'2018-11-29 18:38:40','2018-11-30 12:48:00','78a957f6-c180-48df-81aa-5d2d97d8a9be',NULL,NULL),
	(2,170,1,'2018-11-29 18:38:40','2018-11-30 12:48:00','f6c65785-583c-4c7e-8f29-8f0a8f7ca71f',NULL,NULL),
	(3,171,1,'2018-11-29 18:38:40','2018-11-30 12:48:00','11ce2ac7-c72d-4a88-9c60-b5bf7afc8ed7',NULL,NULL),
	(4,172,1,'2018-11-29 18:38:40','2018-11-30 12:48:00','40548f49-12d1-4652-996d-850da0be8f33',NULL,NULL),
	(5,173,1,'2018-11-29 18:38:40','2018-11-30 12:48:00','5c14f02a-64fc-40ba-8172-b283d5c26ca8',NULL,NULL);

/*!40000 ALTER TABLE `pt_stc_9_slides` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_structureelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_structureelements`;

CREATE TABLE `pt_structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `pt_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_structureelements` WRITE;
/*!40000 ALTER TABLE `pt_structureelements` DISABLE KEYS */;

INSERT INTO `pt_structureelements` (`id`, `structureId`, `elementId`, `root`, `lft`, `rgt`, `level`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,NULL,1,1,2,0,'2018-11-06 19:47:54','2019-02-09 13:09:36','768e310c-2faf-495b-8cea-ff69328cc355');

/*!40000 ALTER TABLE `pt_structureelements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_structures
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_structures`;

CREATE TABLE `pt_structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `pt_structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_structures` WRITE;
/*!40000 ALTER TABLE `pt_structures` DISABLE KEYS */;

INSERT INTO `pt_structures` (`id`, `maxLevels`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,2,'2018-11-06 19:23:08','2018-11-20 20:01:32',NULL,'705621d5-28f2-4ec0-b53c-8500b2bb1fd8');

/*!40000 ALTER TABLE `pt_structures` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_supertableblocks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_supertableblocks`;

CREATE TABLE `pt_supertableblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `supertableblocks_ownerId_idx` (`ownerId`),
  KEY `supertableblocks_fieldId_idx` (`fieldId`),
  KEY `supertableblocks_typeId_idx` (`typeId`),
  KEY `supertableblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `supertableblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `pt_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `supertableblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `supertableblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `supertableblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `pt_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `supertableblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `pt_supertableblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_supertableblocktypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_supertableblocktypes`;

CREATE TABLE `pt_supertableblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `supertableblocktypes_fieldId_idx` (`fieldId`),
  KEY `supertableblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `supertableblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `pt_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `supertableblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `pt_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_supertableblocktypes` WRITE;
/*!40000 ALTER TABLE `pt_supertableblocktypes` DISABLE KEYS */;

INSERT INTO `pt_supertableblocktypes` (`id`, `fieldId`, `fieldLayoutId`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,39,11,'2018-11-28 19:07:47','2019-02-09 13:08:21','e1d8381e-e9da-4f7a-897a-7ca3280e4deb'),
	(2,51,14,'2018-11-29 16:00:58','2018-11-29 19:01:53','bf867548-c6c8-4312-9ff6-501f221c53e8'),
	(3,60,16,'2018-12-07 12:52:41','2019-02-09 13:08:22','061368e4-5312-4599-93a2-c40f7165b4b6'),
	(4,65,18,'2018-12-07 17:24:19','2019-02-09 13:08:22','326dbc91-cc61-404b-ad31-73f972c6e3de');

/*!40000 ALTER TABLE `pt_supertableblocktypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_systemmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_systemmessages`;

CREATE TABLE `pt_systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_taggroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_taggroups`;

CREATE TABLE `pt_taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  KEY `pt_taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `pt_taggroups_name_idx` (`name`),
  KEY `pt_taggroups_handle_idx` (`handle`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `pt_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_tags`;

CREATE TABLE `pt_tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `pt_taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_templatecacheelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_templatecacheelements`;

CREATE TABLE `pt_templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `pt_templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_templatecachequeries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_templatecachequeries`;

CREATE TABLE `pt_templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `pt_templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_templatecaches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_templatecaches`;

CREATE TABLE `pt_templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `pt_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_tokens`;

CREATE TABLE `pt_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_usergroups`;

CREATE TABLE `pt_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_usergroups_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_usergroups_users`;

CREATE TABLE `pt_usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `pt_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `pt_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_userpermissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_userpermissions`;

CREATE TABLE `pt_userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_userpermissions_usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_userpermissions_usergroups`;

CREATE TABLE `pt_userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `pt_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `pt_userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_userpermissions_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_userpermissions_users`;

CREATE TABLE `pt_userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `pt_userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `pt_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_userpreferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_userpreferences`;

CREATE TABLE `pt_userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `pt_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_userpreferences` WRITE;
/*!40000 ALTER TABLE `pt_userpreferences` DISABLE KEYS */;

INSERT INTO `pt_userpreferences` (`userId`, `preferences`)
VALUES
	(1,'{\"language\":\"en-US\",\"weekStartDay\":\"0\",\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false}');

/*!40000 ALTER TABLE `pt_userpreferences` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_users`;

CREATE TABLE `pt_users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `pt_assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_users` WRITE;
/*!40000 ALTER TABLE `pt_users` DISABLE KEYS */;

INSERT INTO `pt_users` (`id`, `username`, `photoId`, `firstName`, `lastName`, `email`, `password`, `admin`, `locked`, `suspended`, `pending`, `lastLoginDate`, `lastLoginAttemptIp`, `invalidLoginWindowStart`, `invalidLoginCount`, `lastInvalidLoginDate`, `lockoutDate`, `hasDashboard`, `verificationCode`, `verificationCodeIssuedDate`, `unverifiedEmail`, `passwordResetRequired`, `lastPasswordChangeDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'kylea@page.works',NULL,'','','kylea@page.works','$2y$13$.tPQ1u13.ms0je3ZbN1jnOaMx4ummoMNCAhSbB338o.Cs/6zf4swK',1,0,0,0,'2019-02-09 12:26:31','::1',NULL,NULL,'2019-02-06 16:43:49',NULL,1,NULL,NULL,NULL,0,'2018-12-08 13:41:32','2018-10-17 19:43:49','2019-02-09 12:26:31','e44094df-7375-4fff-a0a5-d88d45bbefcb');

/*!40000 ALTER TABLE `pt_users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_volumefolders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_volumefolders`;

CREATE TABLE `pt_volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `pt_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `pt_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_volumefolders` WRITE;
/*!40000 ALTER TABLE `pt_volumefolders` DISABLE KEYS */;

INSERT INTO `pt_volumefolders` (`id`, `parentId`, `volumeId`, `name`, `path`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,1,'Images','','2018-11-06 19:33:37','2019-01-30 12:51:10','eb2dafb2-9954-4850-9d47-56e2e80f3880'),
	(2,NULL,2,'Videos','','2018-11-06 19:33:56','2019-01-30 12:51:20','f1b1b0d9-4fde-4469-a030-603d50bb42d6'),
	(3,NULL,NULL,'Temporary source',NULL,'2018-11-06 20:04:20','2018-11-06 20:04:20','55f6a2d2-4d18-4c8b-9387-f81ab9601a1a'),
	(4,3,NULL,'user_1','user_1/','2018-11-06 20:04:20','2018-11-06 20:04:20','e58f2b68-05d5-4fce-aff6-fa34d0786b83'),
	(5,NULL,3,'User Uploads','','2019-01-30 17:10:47','2019-01-30 17:11:17','a570f17f-15ee-4f4c-94d9-b6e7f08ac70c');

/*!40000 ALTER TABLE `pt_volumefolders` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_volumes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_volumes`;

CREATE TABLE `pt_volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `pt_volumes_dateDeleted_idx` (`dateDeleted`),
  KEY `pt_volumes_name_idx` (`name`),
  KEY `pt_volumes_handle_idx` (`handle`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `pt_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_volumes` WRITE;
/*!40000 ALTER TABLE `pt_volumes` DISABLE KEYS */;

INSERT INTO `pt_volumes` (`id`, `fieldLayoutId`, `name`, `handle`, `type`, `hasUrls`, `url`, `settings`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,'Images','images','craft\\volumes\\Local',1,'@rootUrl/uploads/images','{\"path\":\"@webroot/uploads/images\"}',1,'2018-11-06 19:33:37','2019-01-30 12:51:10',NULL,'ea6beeac-3da3-43fe-a530-47032076abb2'),
	(2,NULL,'Videos','videos','craft\\volumes\\Local',1,'@rootUrl/uploads/videos','{\"path\":\"@webroot/uploads/videos\"}',2,'2018-11-06 19:33:56','2019-01-30 12:51:20',NULL,'02433cef-1aec-4478-8f75-f5570480c436'),
	(3,NULL,'User Uploads','userUploads','craft\\volumes\\Local',0,NULL,'{\"path\":\"@root/user-uploads\"}',NULL,'2019-01-30 17:10:47','2019-01-30 17:11:17',NULL,'b7f7001c-8d6f-4341-a869-732554429306');

/*!40000 ALTER TABLE `pt_volumes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_widgets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_widgets`;

CREATE TABLE `pt_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `pt_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_widgets` WRITE;
/*!40000 ALTER TABLE `pt_widgets` DISABLE KEYS */;

INSERT INTO `pt_widgets` (`id`, `userId`, `type`, `sortOrder`, `colspan`, `settings`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'craft\\widgets\\RecentEntries',1,0,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2018-10-17 19:43:51','2018-10-17 19:43:51','8f524da9-1104-443e-a4a9-a3661ca2d3dc'),
	(2,1,'craft\\widgets\\CraftSupport',2,0,'[]',1,'2018-10-17 19:43:51','2018-10-17 19:43:51','ca275e69-e163-473a-9816-1d0862fbd53a'),
	(3,1,'craft\\widgets\\Updates',3,0,'[]',1,'2018-10-17 19:43:51','2018-10-17 19:43:51','94598f39-1f60-4b7a-99a0-9526042dcfb8'),
	(4,1,'craft\\widgets\\Feed',4,0,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2018-10-17 19:43:51','2018-10-17 19:43:51','2ca3e459-c48e-47de-bea6-1e294997089a');

/*!40000 ALTER TABLE `pt_widgets` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
