# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.6.38)
# Database: craft_papertrain
# Generation Time: 2018-11-20 20:43:25 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table assetindexdata
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assetindexdata`;

CREATE TABLE `assetindexdata` (
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
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assets`;

CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_filename_folderId_unq_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;

INSERT INTO `assets` (`id`, `volumeId`, `folderId`, `filename`, `kind`, `width`, `height`, `size`, `focalPoint`, `dateModified`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(6,1,1,'aKwxEY_sWPk.jpg','image',4160,6240,3871993,NULL,'2018-11-06 20:05:37','2018-11-06 20:05:39','2018-11-06 20:05:39','16b7f70a-eea5-4ad5-b94b-509a35b560df');

/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table assettransformindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assettransformindex`;

CREATE TABLE `assettransformindex` (
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



# Dump of table assettransforms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assettransforms`;

CREATE TABLE `assettransforms` (
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



# Dump of table categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categorygroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups`;

CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_name_unq_idx` (`name`),
  UNIQUE KEY `categorygroups_handle_unq_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categorygroups_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups_sites`;

CREATE TABLE `categorygroups_sites` (
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
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table content
# ------------------------------------------------------------

DROP TABLE IF EXISTS `content`;

CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;

INSERT INTO `content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,NULL,'2018-10-17 19:43:46','2018-10-17 19:43:46','4027dc44-49c1-4aaf-b85b-a6bc1a637bac'),
	(2,2,1,'Example','2018-10-17 19:44:21','2018-10-17 19:44:21','b9cb2e60-23ce-4eb4-80a1-72c22e20f013'),
	(3,3,1,'Example Complex Content Page','2018-11-06 19:47:54','2018-11-20 20:43:10','8a557ba9-ab6a-4dd4-83ae-67ea2260180a'),
	(4,6,1,' Akwxey_Swpk','2018-11-06 20:05:28','2018-11-06 20:05:28','935a8b55-f5c1-41c1-a3c2-121366cc6bca');

/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table craftidtokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `craftidtokens`;

CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table deprecationerrors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `deprecationerrors`;

CREATE TABLE `deprecationerrors` (
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



# Dump of table elementindexsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elementindexsettings`;

CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table elements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements`;

CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;

INSERT INTO `elements` (`id`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'craft\\elements\\User',1,0,'2018-10-17 19:43:46','2018-10-17 19:43:46','f5535ce9-aa32-4c64-8dc5-5d5876014bb3'),
	(2,1,'craft\\elements\\Entry',1,0,'2018-10-17 19:44:21','2018-10-17 19:44:21','7eb74ee0-ea2c-4f28-9f90-cdee58f26b78'),
	(3,2,'craft\\elements\\Entry',1,0,'2018-11-06 19:47:54','2018-11-20 20:43:10','6df04e31-e79f-4f18-8c91-42b9bd672f7b'),
	(6,4,'craft\\elements\\Asset',1,0,'2018-11-06 20:05:28','2018-11-06 20:05:28','3a977264-3c78-4e5b-bdd5-0acddb7e9bde');

/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table elements_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements_sites`;

CREATE TABLE `elements_sites` (
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
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;

INSERT INTO `elements_sites` (`id`, `elementId`, `siteId`, `slug`, `uri`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,NULL,NULL,1,'2018-10-17 19:43:46','2018-10-17 19:43:46','d9de158a-7398-4aae-9bb2-aecd247144ae'),
	(2,2,1,'example','example',1,'2018-10-17 19:44:21','2018-10-17 19:44:21','7b9b031b-682d-4493-a0f4-6208dc95cd4e'),
	(3,3,1,'example-complex-content-page','example-complex-content-page',1,'2018-11-06 19:47:54','2018-11-20 20:43:10','d001a141-8da2-460a-969d-5fc92e1dd4b2'),
	(6,6,1,NULL,NULL,1,'2018-11-06 20:05:28','2018-11-06 20:05:28','139b4cde-45b3-472f-b5ac-9bcc42f0d1a7');

/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entries`;

CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;

INSERT INTO `entries` (`id`, `sectionId`, `typeId`, `authorId`, `postDate`, `expiryDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,1,1,NULL,'2018-10-17 19:44:00',NULL,'2018-10-17 19:44:21','2018-10-17 19:44:21','3b35d719-f768-44ed-91c4-9c835cb1a983'),
	(3,2,2,1,'2018-11-06 19:47:00',NULL,'2018-11-06 19:47:54','2018-11-20 20:43:10','e4bd9fc0-91ef-43f8-838d-8597bd193b17');

/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entrydrafts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entrydrafts`;

CREATE TABLE `entrydrafts` (
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
  CONSTRAINT `entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table entrytypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entrytypes`;

CREATE TABLE `entrytypes` (
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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `entrytypes_name_sectionId_unq_idx` (`name`,`sectionId`),
  UNIQUE KEY `entrytypes_handle_sectionId_unq_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;

INSERT INTO `entrytypes` (`id`, `sectionId`, `fieldLayoutId`, `name`, `handle`, `hasTitleField`, `titleLabel`, `titleFormat`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,'Example','example',0,NULL,'{section.name|raw}',1,'2018-10-17 19:44:20','2018-10-17 19:44:20','c2b864cf-2387-427a-8c7e-8aaca7e146d3'),
	(2,2,2,'Standard Pages','standardPages',1,'Title',NULL,1,'2018-11-06 19:23:08','2018-11-06 19:48:17','314ff677-634c-4a48-8499-6c2817266962');

/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entryversions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entryversions`;

CREATE TABLE `entryversions` (
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
  CONSTRAINT `entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entryversions` WRITE;
/*!40000 ALTER TABLE `entryversions` DISABLE KEYS */;

INSERT INTO `entryversions` (`id`, `entryId`, `sectionId`, `creatorId`, `siteId`, `num`, `notes`, `data`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,3,2,1,1,1,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":[]}','2018-11-06 19:47:55','2018-11-06 19:47:55','8d7cc027-4038-4af2-b197-f0405e484e9c'),
	(2,3,2,1,1,2,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[]}}}}}','2018-11-06 19:48:34','2018-11-06 19:48:34','330c79e3-abd9-47bd-8c9b-c58e0fd71e81'),
	(3,3,2,1,1,3,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-secondary-background\",\"backgroundImage\":[],\"backgroundVideo\":[]}}}}}','2018-11-06 19:50:11','2018-11-06 19:50:11','5761588b-1254-414b-8f40-e572d6a94433'),
	(4,3,2,1,1,4,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-dark-background\",\"backgroundImage\":[],\"backgroundVideo\":[]}}}}}','2018-11-06 19:50:18','2018-11-06 19:50:18','5eee7596-f20d-456d-ac4c-4b4fb7b22112'),
	(5,3,2,1,1,5,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-dark-background\",\"backgroundImage\":[],\"backgroundVideo\":[]}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-left\"}}}}}','2018-11-06 19:54:56','2018-11-06 19:54:56','6a12e4c8-022f-4ec4-aacd-aaff2422f0f3'),
	(6,3,2,1,1,6,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-dark-background\",\"backgroundImage\":[],\"backgroundVideo\":[]}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-left\",\"width\":\"50\",\"padding\":\"u-padding-none\"}}}}}','2018-11-06 19:59:44','2018-11-06 19:59:44','00209d17-061b-4f96-98b5-14c17a8d5742'),
	(7,3,2,1,1,7,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-dark-background\",\"backgroundImage\":[],\"backgroundVideo\":[]}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"50\",\"padding\":\"u-padding-none\"}}}}}','2018-11-06 20:02:19','2018-11-06 20:02:19','12730c78-6ea9-4fc9-9a64-895085e13295'),
	(8,3,2,1,1,8,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-dark-background\",\"backgroundImage\":[],\"backgroundVideo\":[]}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-none\"}}}}}','2018-11-06 20:02:26','2018-11-06 20:02:26','c2b1d457-9638-462a-b6d7-649d42bdf712'),
	(9,3,2,1,1,9,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-dark-background\",\"backgroundImage\":[],\"backgroundVideo\":[]}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-right\",\"width\":\"100\",\"padding\":\"u-padding-none\"}}}}}','2018-11-06 20:02:32','2018-11-06 20:02:32','b7080e5b-2aa3-40dd-8f5f-18b8dc7d1e54'),
	(10,3,2,1,1,10,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-dark-background\",\"backgroundImage\":[],\"backgroundVideo\":[]}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-right\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:02:50','2018-11-06 20:02:50','8abe2a35-89f6-4c55-ab0e-147805421fc7'),
	(11,3,2,1,1,11,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-secondary-background\",\"backgroundImage\":[],\"backgroundVideo\":[]}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:03:02','2018-11-06 20:03:02','46de4a39-e09e-43a7-b3a9-67823732e906'),
	(12,3,2,1,1,12,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[]}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:03:09','2018-11-06 20:03:09','d5d0589a-0083-46bf-92d5-28102fbe0aa1'),
	(13,3,2,1,1,13,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[]}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:05:55','2018-11-06 20:05:55','baa24870-f2cc-4638-b223-88bc5e0e64c1'),
	(14,3,2,1,1,14,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlay\":\"#ff6b66\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:11:44','2018-11-06 20:11:44','b58b8a11-a499-4698-89fb-3579fa29cf28'),
	(15,3,2,1,1,15,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlay\":\"#73fdff\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:12:56','2018-11-06 20:12:56','f335ff21-47af-4238-ad9c-62196b58e366'),
	(16,3,2,1,1,16,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#73fdff\",\"overlayDensity\":\"0.33\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:20:31','2018-11-06 20:20:31','7cc53674-31de-4e8d-839c-31d441ab31b4'),
	(17,3,2,1,1,17,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#ffaa38\",\"overlayDensity\":\"0.33\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:20:49','2018-11-06 20:20:49','9dc4454f-3e58-4ed4-9c27-6d1404cbe293'),
	(18,3,2,1,1,18,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#ffaa38\",\"overlayDensity\":\"0.33\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:21:33','2018-11-06 20:21:33','dbcbfb8d-a29b-4598-8037-876620b0ce24'),
	(19,3,2,1,1,19,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-dark-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#ffaa38\",\"overlayDensity\":\"0.33\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:21:39','2018-11-06 20:21:39','84922957-1543-4616-a2d5-729ddd49b556'),
	(20,3,2,1,1,20,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#ffaa38\",\"overlayDensity\":\"0.33\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:21:46','2018-11-06 20:21:46','9506322e-a994-4f9d-b9e3-37ba8a7bedbf'),
	(21,3,2,1,1,21,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#ffaa38\",\"overlayDensity\":\"0.75\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:23:37','2018-11-06 20:23:37','c94ca133-073e-49f0-b282-74b4a2d09b2b'),
	(22,3,2,1,1,22,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#ffaa38\",\"overlayDensity\":\"0.75\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:23:41','2018-11-06 20:23:41','7b0ff5ba-ba60-4c91-b213-7e40040d117e'),
	(23,3,2,1,1,23,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#ffaa38\",\"overlayDensity\":\"0.33\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:23:50','2018-11-06 20:23:50','758713d9-e392-4ce7-8cec-26956cb2b089'),
	(24,3,2,1,1,24,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#ffaa38\",\"overlayDensity\":\"0.15\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:23:57','2018-11-06 20:23:57','1c81f4b1-a7c4-4728-acb1-51d94242df1b'),
	(25,3,2,1,1,25,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#ffaa38\",\"overlayDensity\":null}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:24:02','2018-11-06 20:24:02','38e98209-5eac-40e7-b410-a560bc26ddb1'),
	(26,3,2,1,1,26,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#ffaa38\",\"overlayDensity\":\"0.15\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:25:23','2018-11-06 20:25:23','c72661bb-703d-47c4-9005-029b9c938191'),
	(27,3,2,1,1,27,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#ffaa38\",\"overlayDensity\":null}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:25:28','2018-11-06 20:25:28','680839c4-e088-4834-ac01-3c1dcb7413dd'),
	(28,3,2,1,1,28,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#ffaa38\",\"overlayDensity\":\"1.0E-5\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:26:47','2018-11-06 20:26:47','62ecfb76-0922-4c84-9561-a8a47fb5f616'),
	(29,3,2,1,1,29,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#ffaa38\",\"overlayDensity\":null}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:28:05','2018-11-06 20:28:05','4455cf0b-e6e3-443c-9ba7-4324e5a5bfd9'),
	(30,3,2,1,1,30,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#ffaa38\",\"overlayDensity\":\"0.15\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:28:13','2018-11-06 20:28:13','5ce31f50-aae2-4511-8260-6394a68b2b2b'),
	(31,3,2,1,1,31,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#ffaa38\",\"overlayDensity\":null}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:28:18','2018-11-06 20:28:18','58403aeb-7914-4cf5-b5e1-c421a26c23cf'),
	(32,3,2,1,1,32,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#ffaa38\",\"overlayDensity\":\"0.33\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:28:51','2018-11-06 20:28:51','20157710-04df-40eb-86dc-80bf768f9b4d'),
	(33,3,2,1,1,33,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#ffaa38\",\"overlayDensity\":null}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:29:17','2018-11-06 20:29:17','5b431724-54c7-46a4-ad7d-4398dcbc3207'),
	(34,3,2,1,1,34,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#181818\",\"overlayDensity\":\"0.33\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:30:45','2018-11-06 20:30:45','8351cfe9-584d-4ac5-88c0-7103c52bb2a4'),
	(35,3,2,1,1,35,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#181818\",\"overlayDensity\":\"0.75\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:30:54','2018-11-06 20:30:54','4faee219-9aa4-4aea-a03a-062c079c1a19'),
	(36,3,2,1,1,36,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#181818\",\"overlayDensity\":\"0.15\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:31:02','2018-11-06 20:31:02','5c69a405-65d6-4eaa-b379-a8b4eaafabfc'),
	(37,3,2,1,1,37,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"4\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#181818\",\"overlayDensity\":\"0.15\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-06 20:31:10','2018-11-06 20:31:10','174d44be-dc52-4592-b6d6-96e4d3943c1c'),
	(38,3,2,1,1,38,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"7\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-07 13:09:57','2018-11-07 13:09:57','3f2acf3b-4df0-4918-a5ab-8461457277c5'),
	(39,3,2,1,1,39,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"7\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#eeeeee\",\"overlayDensity\":null}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-07 13:10:07','2018-11-07 13:10:07','0c6f22d7-9b1d-4fb1-a450-780e0a9e23da'),
	(40,3,2,1,1,40,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"7\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#eeeeee\",\"overlayDensity\":\"0.75\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-07 13:10:10','2018-11-07 13:10:10','738fb2cd-3d42-403e-be22-beb78230c7c3'),
	(41,3,2,1,1,41,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"7\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":\"0.75\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-x2\"}}}}}','2018-11-07 13:10:18','2018-11-07 13:10:18','0eed2bb0-4f5a-43b7-8546-738b4f4d5776'),
	(42,3,2,1,1,42,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"7\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[\"6\"],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":\"0.75\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-horizontal-x2\"}}}}}','2018-11-07 13:10:37','2018-11-07 13:10:37','4711886a-2361-4b0a-9eff-a77e18dd0a7c'),
	(43,3,2,1,1,43,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"7\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":\"0.75\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"6\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-none\"}}}}}','2018-11-07 13:16:32','2018-11-07 13:16:32','436318b5-ca55-4614-aeaa-82f262ae0ea5'),
	(44,3,2,1,1,44,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"7\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":\"0.75\"}},\"5\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Sample Heading Copy\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"width\":\"100\",\"padding\":\"u-padding-none\"}}}}}','2018-11-07 13:16:40','2018-11-07 13:16:40','01ffd1da-456f-4a28-aafd-cc2ceba8886d'),
	(45,3,2,1,1,45,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":[]}}','2018-11-07 13:26:47','2018-11-07 13:26:47','40070848-e2cd-4b19-84c1-569810351ace'),
	(46,3,2,1,1,46,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"9\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"2\"}},\"10\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Left Column\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-horizontal-x4\"}},\"11\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"12\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Right Column\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-horizontal-x4\"}},\"13\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]}}}}','2018-11-07 13:27:59','2018-11-07 13:27:59','987a4340-e388-4e7c-90bc-a4bbd5e3dcdd'),
	(47,3,2,1,1,47,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}}}}}','2018-11-07 13:39:52','2018-11-07 13:39:52','cf57d344-f1a6-46b9-baef-bb4fea635052'),
	(48,3,2,1,1,48,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"14\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"1\"}}}}}','2018-11-07 13:54:50','2018-11-07 13:54:50','0b0704fc-10f2-4fcf-9062-d3e7df6c4282'),
	(49,3,2,1,1,49,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"14\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"2\"}}}}}','2018-11-07 13:54:54','2018-11-07 13:54:54','37aae745-1e36-4a8c-aae1-e6174d98c683'),
	(50,3,2,1,1,50,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"14\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"2\"}},\"15\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Test\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-07 13:56:30','2018-11-07 13:56:30','577d26d9-f917-4e90-aaa3-f0f994b9b85a'),
	(51,3,2,1,1,51,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"14\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"3\"}},\"15\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Test\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-07 14:12:14','2018-11-07 14:12:14','bf8fa156-d2f8-45e6-a38f-a257423a6354'),
	(52,3,2,1,1,52,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"14\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"4\"}},\"15\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Test\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-07 14:12:29','2018-11-07 14:12:29','3e24a7ee-d6c2-4186-901b-1eb223f063cb'),
	(53,3,2,1,1,53,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"14\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"4\"}},\"15\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Test\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"16\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]}}}}','2018-11-07 14:12:41','2018-11-07 14:12:41','4ea42ddf-c452-4eb3-abf1-a3d6f5496cc0'),
	(54,3,2,1,1,54,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"14\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"4\"}},\"15\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Test\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"16\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"17\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-07 14:13:52','2018-11-07 14:13:52','c7935545-565e-4157-ad3a-dafc4f0ffc65'),
	(55,3,2,1,1,55,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"14\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"4\"}},\"15\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Test\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"16\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"17\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-07 14:14:20','2018-11-07 14:14:20','c8bb96c7-6a9a-465f-b67e-d210f8019295'),
	(56,3,2,1,1,56,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"14\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"4\"}},\"15\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Test\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"16\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"17\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"18\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"19\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Third Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-07 14:14:52','2018-11-07 14:14:52','eff52e4e-4896-41c0-80ce-49e64b708673'),
	(57,3,2,1,1,57,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"14\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"4\",\"columnGutter\":\"-gutter\"}},\"15\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Test\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"16\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"17\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"18\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"19\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Third Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-07 14:16:54','2018-11-07 14:16:54','4006af6b-a92c-42a3-a1c7-1001b3a40a15'),
	(58,3,2,1,1,58,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"14\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"5\",\"columnGutter\":\"-gutter\"}},\"15\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Test\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"16\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"17\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"18\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"19\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Third Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-07 14:19:12','2018-11-07 14:19:12','6315478c-7f6d-44dc-b2e4-324598c8ae20'),
	(59,3,2,1,1,59,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"14\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"3\",\"columnGutter\":\"-gutter\"}},\"15\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Test\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"16\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"17\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"18\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"19\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Third Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-07 14:24:20','2018-11-07 14:24:20','65e6cddd-f8db-4fd5-9eea-b581dd16bcd2'),
	(60,3,2,1,1,60,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"14\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"3\",\"columnGutter\":\"-gutter-small\"}},\"15\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Test\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"16\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"17\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"18\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"19\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Third Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-07 14:24:32','2018-11-07 14:24:32','57f2a37d-2e26-43d5-9a1f-313fd4336f6e'),
	(61,3,2,1,1,61,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"14\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"3\",\"columnGutter\":\"-gutter-large\"}},\"15\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Test\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"16\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"17\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"18\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"19\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Third Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-07 14:24:52','2018-11-07 14:24:52','52f74c34-957b-45ab-a90f-1fd179a899b4'),
	(62,3,2,1,1,62,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"14\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"3\",\"columnGutter\":\"-gutter-large\"}},\"15\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Test\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"16\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"17\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"18\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"19\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Third Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"20\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-full\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter-none\"}},\"21\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"FULL WIDTH CONTAINER\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-07 14:26:04','2018-11-07 14:26:04','22446524-fa9f-4f93-a4ba-e2a9509f3d83'),
	(63,3,2,1,1,63,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"14\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"3\",\"columnGutter\":\"-gutter-large\"}},\"15\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Test\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"16\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"17\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"18\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"19\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Third Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"20\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-full\",\"columnLayout\":\"2\",\"columnGutter\":\"-gutter-none\"}},\"21\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"FULL WIDTH CONTAINER\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-top-x4\"}},\"22\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-dark-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}}}}}','2018-11-07 14:28:03','2018-11-07 14:28:03','50c602c0-f361-4e71-947c-f9cf13bcbc7f'),
	(64,3,2,1,1,64,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"14\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"3\",\"columnGutter\":\"-gutter-large\"}},\"15\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Test\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"16\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"17\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"18\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"19\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Third Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"20\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-full\",\"columnLayout\":\"2\",\"columnGutter\":\"-gutter-none\"}},\"21\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"FULL WIDTH CONTAINER\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-top-x4\"}},\"22\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-dark-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"23\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-full\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter\"}},\"24\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"New Section\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-07 14:28:29','2018-11-07 14:28:29','8b99adfc-c2f0-4334-be36-efd2b11608f9'),
	(65,3,2,1,1,65,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"14\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"3\",\"columnGutter\":\"-gutter-large\"}},\"15\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Test\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"16\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"17\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"18\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"19\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Third Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"20\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-full\",\"columnLayout\":\"2\",\"columnGutter\":\"-gutter-none\"}},\"21\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"FULL WIDTH CONTAINER\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-top-x4\"}},\"22\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-dark-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"23\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-full\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter\"}},\"24\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"New Section\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-vertical-x4\"}}}}}','2018-11-07 14:28:34','2018-11-07 14:28:34','cd2959bc-6372-4bd3-8f0f-a9af54d6fcaa'),
	(66,3,2,1,1,66,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"8\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"14\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"3\",\"columnGutter\":\"-gutter-large\"}},\"15\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Test\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"16\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"17\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"18\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"19\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Third Heading\",\"fontSize\":\"2\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"20\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-full\",\"columnLayout\":\"2\",\"columnGutter\":\"-gutter-none\"}},\"21\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"FULL WIDTH CONTAINER\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-top-x4\"}},\"25\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"26\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"SPLIT INTO TWO\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-top-x4\"}},\"22\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-dark-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#070707\",\"overlayDensity\":null}},\"23\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container-full\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter\"}},\"24\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"New Section\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-vertical-x4\"}}}}}','2018-11-07 14:31:16','2018-11-07 14:31:16','bbb73da0-9092-4f84-a0a8-75383ed2544a'),
	(67,3,2,1,1,67,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":[]}}','2018-11-07 16:13:27','2018-11-07 16:13:27','5bf92760-9d28-454c-90fd-d3c2730eec08'),
	(68,3,2,1,1,68,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"7\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#353535\",\"overlayDensity\":null}},\"8\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter\"}},\"9\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Example Heading\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-20 20:31:48','2018-11-20 20:31:48','a5e8b191-51c3-46fa-bc55-c634267c33ec'),
	(69,3,2,1,1,69,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"7\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#353535\",\"overlayDensity\":null}},\"8\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"2\",\"columnGutter\":\"-gutter\"}},\"9\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Example Heading\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"10\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"11\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Example\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-20 20:32:52','2018-11-20 20:32:52','62357658-f87a-4e1d-8a44-99b9f0d010cc'),
	(70,3,2,1,1,70,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"7\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#353535\",\"overlayDensity\":null}},\"8\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"2\",\"columnGutter\":\"-gutter\",\"verticalAlign\":\"-align-center\"}},\"9\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Example Heading\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"10\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"11\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Example\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-20 20:35:07','2018-11-20 20:35:07','88727299-c7ea-43f2-8669-8d61576b6847'),
	(71,3,2,1,1,71,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"7\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#353535\",\"overlayDensity\":null}},\"8\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"2\",\"columnGutter\":\"-gutter\",\"verticalAlign\":\"-align-bottom\"}},\"9\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Example Heading\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"10\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"11\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Example\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-20 20:40:12','2018-11-20 20:40:12','18558977-83f8-482c-98e5-d0ea13c66e25'),
	(72,3,2,1,1,72,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"7\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#353535\",\"overlayDensity\":null}},\"8\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"2\",\"columnGutter\":\"-gutter\",\"verticalAlign\":\"-align-top\"}},\"9\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Example Heading\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"10\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"11\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Example\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-20 20:40:22','2018-11-20 20:40:22','8e733539-1201-4e68-8b66-91074ac2d3d2'),
	(73,3,2,1,1,73,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"7\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#353535\",\"overlayDensity\":null}},\"8\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"2\",\"columnGutter\":\"-gutter\",\"verticalAlign\":\"-align-end\"}},\"9\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Example Heading\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"10\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"11\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Example\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-20 20:41:12','2018-11-20 20:41:12','f6afd74f-07aa-43bf-be5b-dab36d7d3188'),
	(74,3,2,1,1,74,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"7\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#353535\",\"overlayDensity\":null}},\"8\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"2\",\"columnGutter\":\"-gutter\",\"verticalAlign\":\"-align-end\"}},\"9\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Example Heading\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"10\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"11\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Example\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"12\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"13\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Another Heading\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-20 20:41:28','2018-11-20 20:41:28','a3aec14d-ba86-47ae-bf61-dc6f140b4f2a'),
	(75,3,2,1,1,75,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"7\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#353535\",\"overlayDensity\":null}},\"8\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"2\",\"columnGutter\":\"-gutter\",\"verticalAlign\":\"-align-center\"}},\"9\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Example Heading\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"10\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"11\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Example\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"12\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"13\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Another Heading\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-20 20:41:41','2018-11-20 20:41:41','98b0dd35-e2a3-40e3-b08b-ab23ae55c8d7'),
	(76,3,2,1,1,76,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":{\"7\":{\"type\":\"sectionSettings\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"backgroundColor\":\"-primary-background\",\"backgroundImage\":[],\"backgroundVideo\":[],\"overlayTint\":\"#353535\",\"overlayDensity\":null}},\"8\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"2\",\"columnGutter\":\"-gutter\",\"verticalAlign\":\"-align-center\"}},\"9\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Example Heading\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"10\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"11\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Second Example\",\"fontSize\":\"3\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}},\"12\":{\"type\":\"endColumn\",\"enabled\":true,\"collapsed\":false,\"fields\":[]},\"14\":{\"type\":\"container\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"width\":\"o-container\",\"columnLayout\":\"1\",\"columnGutter\":\"-gutter\",\"verticalAlign\":\"-align-top\"}},\"13\":{\"type\":\"heading\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"copy\":\"Another Heading\",\"fontSize\":\"1\",\"alignment\":\"u-text-center\",\"padding\":\"u-padding-none\"}}}}}','2018-11-20 20:41:58','2018-11-20 20:41:58','cf4fd5e9-4fb2-4cb1-bf4c-a9e226eb25c5'),
	(77,3,2,1,1,77,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Example Complex Content Page\",\"slug\":\"example-complex-content-page\",\"postDate\":1541533620,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":{\"1\":[]}}','2018-11-20 20:43:10','2018-11-20 20:43:10','11a0f46e-2898-4f79-bf9e-7a50d90e5921');

/*!40000 ALTER TABLE `entryversions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldgroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldgroups`;

CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;

INSERT INTO `fieldgroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Common','2018-10-17 19:43:46','2018-10-17 19:43:46','8dcdb4b8-5035-411c-8f7f-5e255dcca924');

/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayoutfields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayoutfields`;

CREATE TABLE `fieldlayoutfields` (
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
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;

INSERT INTO `fieldlayoutfields` (`id`, `layoutId`, `tabId`, `fieldId`, `required`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(14,2,5,1,0,1,'2018-11-06 19:48:17','2018-11-06 19:48:17','593cc2cf-e045-4890-afc0-f79e148c290f'),
	(248,3,64,3,0,1,'2018-11-20 20:41:04','2018-11-20 20:41:04','794da4ea-9bbb-406f-ad19-50cc67daf870'),
	(249,3,64,4,0,2,'2018-11-20 20:41:04','2018-11-20 20:41:04','c2210d2b-b582-40a4-9ea5-d8a4a1b32ffd'),
	(250,3,64,5,0,3,'2018-11-20 20:41:04','2018-11-20 20:41:04','0afd58eb-401d-41cc-b46e-d5cd97ccc20b'),
	(251,3,64,11,0,4,'2018-11-20 20:41:04','2018-11-20 20:41:04','f73cc4a9-3a0a-492e-8cbc-c086673f43ea'),
	(252,3,64,12,0,5,'2018-11-20 20:41:04','2018-11-20 20:41:04','c720f8f7-7403-4c35-8651-74c3e053ee76'),
	(253,7,65,14,0,1,'2018-11-20 20:41:04','2018-11-20 20:41:04','a738e320-8e16-4b67-b856-e2c259bd02bc'),
	(254,7,65,15,0,2,'2018-11-20 20:41:04','2018-11-20 20:41:04','61afb096-4376-4873-816e-3cd991260b8f'),
	(255,7,65,16,0,3,'2018-11-20 20:41:04','2018-11-20 20:41:04','5de38699-a8d6-4879-9a25-63bd53731597'),
	(256,7,65,17,0,4,'2018-11-20 20:41:04','2018-11-20 20:41:04','d5247f7e-350f-437c-8bf1-91c227029632'),
	(257,6,67,6,1,1,'2018-11-20 20:41:04','2018-11-20 20:41:04','dfbaa4dc-1d1f-4bc4-a364-0caa12b6bc3b'),
	(258,6,67,7,0,2,'2018-11-20 20:41:04','2018-11-20 20:41:04','d9f7c3eb-c94b-41f4-a17b-20a48a36cbc9'),
	(259,6,67,8,0,3,'2018-11-20 20:41:04','2018-11-20 20:41:04','88538b98-3e11-439d-b34e-969c5a1c8d3a'),
	(260,6,67,10,0,4,'2018-11-20 20:41:04','2018-11-20 20:41:04','f5416a5d-6cbd-4709-8fd5-53bf12a3678a');

/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayouts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouts`;

CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;

INSERT INTO `fieldlayouts` (`id`, `type`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'craft\\elements\\Entry','2018-10-17 19:44:20','2018-10-17 19:44:20','b98f4322-2a6e-4bbb-ad33-f6bc05e23bb7'),
	(2,'craft\\elements\\Entry','2018-11-06 19:23:08','2018-11-06 19:48:17','49f16c08-2073-4897-8f3e-92355d39b819'),
	(3,'craft\\elements\\MatrixBlock','2018-11-06 19:29:37','2018-11-20 20:41:04','cccaf184-6482-40a9-bdc8-acaaebe6917f'),
	(4,'craft\\elements\\Asset','2018-11-06 19:33:37','2018-11-06 19:33:37','47c48e31-d23e-4089-b483-3ecfc95a95b0'),
	(5,'craft\\elements\\Asset','2018-11-06 19:33:56','2018-11-06 19:33:56','ecfdc16e-4402-41a4-a5af-09785582316a'),
	(6,'craft\\elements\\MatrixBlock','2018-11-06 19:54:26','2018-11-20 20:41:04','39856f0c-11eb-4fe4-a60d-07e698ae181c'),
	(7,'craft\\elements\\MatrixBlock','2018-11-07 13:26:27','2018-11-20 20:41:04','cb1fed6a-0e67-4c84-8d89-ebba225f2dad'),
	(8,'craft\\elements\\MatrixBlock','2018-11-07 13:26:27','2018-11-20 20:41:04','4455065f-9480-4863-8fad-e12f4b0ddf84');

/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayouttabs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouttabs`;

CREATE TABLE `fieldlayouttabs` (
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
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;

INSERT INTO `fieldlayouttabs` (`id`, `layoutId`, `name`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(5,2,'Complex Content',1,'2018-11-06 19:48:17','2018-11-06 19:48:17','7fa25098-b49a-47c8-8b0d-11b7273afd5c'),
	(64,3,'Content',1,'2018-11-20 20:41:04','2018-11-20 20:41:04','ec04f555-dc4c-451b-aa53-ea2ecefb62ad'),
	(65,7,'Content',1,'2018-11-20 20:41:04','2018-11-20 20:41:04','2928af41-df16-40dc-bd25-195c606ee170'),
	(66,8,'Content',1,'2018-11-20 20:41:04','2018-11-20 20:41:04','33da1858-ea84-4618-89de-666b2deeda26'),
	(67,6,'Content',1,'2018-11-20 20:41:04','2018-11-20 20:41:04','b8f3b772-3f84-431d-861d-6bea08d189ab');

/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fields`;

CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
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
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;

INSERT INTO `fields` (`id`, `groupId`, `name`, `handle`, `context`, `instructions`, `translationMethod`, `translationKeyFormat`, `type`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'Complex Content','cc','global','','site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"contentTable\":\"{{%matrixcontent_cc}}\",\"localizeBlocks\":false}','2018-11-06 19:29:37','2018-11-20 20:41:03','d1fe1a49-a8bf-46ab-ac74-d563effe3be7'),
	(3,NULL,'Background Color','backgroundColor','matrixBlockType:1','Please select this sections background color.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"White\",\"value\":\"-primary-background\",\"default\":\"1\"},{\"label\":\"Off White\",\"value\":\"-secondary-background\",\"default\":\"\"},{\"label\":\"Off Black\",\"value\":\"-dark-background\",\"default\":\"\"}]}','2018-11-06 19:29:37','2018-11-20 20:41:04','fb2fb216-c076-435d-b399-bb0c92cbc106'),
	(4,NULL,'Background Image','backgroundImage','matrixBlockType:1','Optional background image for the section. This image will override the selected background color.','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"folder:1\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add a Background Image\",\"localizeRelations\":false}','2018-11-06 19:29:37','2018-11-20 20:41:04','d3f64f5e-8d98-4cfe-bc55-10e5c2497fff'),
	(5,NULL,'Background Video','backgroundVideo','matrixBlockType:1','Optional background video for the section. This video will override the selected background color and image.','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:2\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"video\"],\"sources\":[\"folder:2\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add a Background Video\",\"localizeRelations\":false}','2018-11-06 19:35:22','2018-11-20 20:41:04','36459edb-92eb-4e49-b582-883cd750f9fd'),
	(6,NULL,'Copy','copy','matrixBlockType:2','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-11-06 19:54:25','2018-11-20 20:41:04','c1466ef0-df37-4a2f-9ecb-82d6e9b3a223'),
	(7,NULL,'Font Size','fontSize','matrixBlockType:2','How large should the font be?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Large\",\"value\":\"1\",\"default\":\"\"},{\"label\":\"Medium\",\"value\":\"2\",\"default\":\"1\"},{\"label\":\"Small\",\"value\":\"3\",\"default\":\"\"}]}','2018-11-06 19:54:26','2018-11-20 20:41:04','d6747373-70b8-49ad-82bd-33370282ee35'),
	(8,NULL,'Alignment','alignment','matrixBlockType:2','How should the heading be aligned?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Left\",\"value\":\"u-text-left\",\"default\":\"1\"},{\"label\":\"Center\",\"value\":\"u-text-center\",\"default\":\"\"},{\"label\":\"Right\",\"value\":\"u-text-right\",\"default\":\"\"}]}','2018-11-06 19:54:26','2018-11-20 20:41:04','4421109a-d1a4-4e10-b64a-87b84b5a3773'),
	(10,NULL,'Padding','padding','matrixBlockType:2','Add padding to the block.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"No Padding\",\"value\":\"u-padding-none\",\"default\":\"1\"},{\"label\":\"Add Full Padding\",\"value\":\"u-padding-x4\",\"default\":\"\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical-x4\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal-x4\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top-x4\",\"default\":\"\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom-x4\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left-x4\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right-x4\",\"default\":\"\"}]}','2018-11-06 19:58:42','2018-11-20 20:41:04','f16ece4b-b4a4-4532-9b03-305f0e107a9d'),
	(11,NULL,'Overlay Tint','overlayTint','matrixBlockType:1','Select the overlay tint color for your background video or image. Selecting a dark color is suggested.','none',NULL,'craft\\fields\\Color','{\"defaultColor\":\"#353535\"}','2018-11-06 20:10:38','2018-11-20 20:41:04','c043d1ea-bbda-4790-9b09-ca031caf54d4'),
	(12,NULL,'Overlay Density','overlayDensity','matrixBlockType:1','Select the overlay density for your background video or image. The larger the number the darker the overlay will be.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"0\",\"default\":\"1\"},{\"label\":\"Light\",\"value\":\"0.15\",\"default\":\"\"},{\"label\":\"Medium\",\"value\":\"0.33\",\"default\":\"\"},{\"label\":\"Dark\",\"value\":\"0.75\",\"default\":\"\"}]}','2018-11-06 20:19:35','2018-11-20 20:41:04','19199c2c-e842-4b20-8eb1-d5de4363d5b1'),
	(14,NULL,'Width','width','matrixBlockType:3','How wide should this sections container be?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Normal\",\"value\":\"o-container\",\"default\":\"\"},{\"label\":\"Narrow\",\"value\":\"o-container-narrow\",\"default\":\"\"},{\"label\":\"Full\",\"value\":\"o-container-full\",\"default\":\"\"}]}','2018-11-07 13:26:27','2018-11-20 20:41:04','bbe771e9-89c0-4471-936a-5ebecf254b9b'),
	(15,NULL,'Column Layout','columnLayout','matrixBlockType:3','Please select a column layout pattern.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Whole\",\"value\":\"1\",\"default\":\"1\"},{\"label\":\"Halves\",\"value\":\"2\",\"default\":\"\"},{\"label\":\"Thirds\",\"value\":\"3\",\"default\":\"\"},{\"label\":\"1/3 & 2/3\",\"value\":\"4\",\"default\":\"\"},{\"label\":\"2/3 & 1/3\",\"value\":\"5\",\"default\":\"\"}]}','2018-11-07 13:26:27','2018-11-20 20:41:04','a74d8612-5ca0-4325-9e7a-903893117219'),
	(16,NULL,'Column Gutter','columnGutter','matrixBlockType:3','How large of a gap between columns do you want?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-gutter-none\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"-gutter\",\"default\":\"1\"},{\"label\":\"Small\",\"value\":\"-gutter-small\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-gutter-large\",\"default\":\"\"}]}','2018-11-07 14:16:46','2018-11-20 20:41:04','27da4f8a-238c-4681-b862-712689ec9187'),
	(17,NULL,'Vertical Align','verticalAlign','matrixBlockType:3','','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Normal\",\"value\":\"-align-top\",\"default\":\"1\"},{\"label\":\"Middle\",\"value\":\"-align-center\",\"default\":\"\"},{\"label\":\"Bottom\",\"value\":\"-align-end\",\"default\":\"\"}]}','2018-11-20 20:35:00','2018-11-20 20:41:04','0318fd31-af0c-42d5-8f82-bda65318cbd2');

/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table freeform_crm_fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `freeform_crm_fields`;

CREATE TABLE `freeform_crm_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `integrationId` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('string','numeric','boolean','array') NOT NULL,
  `required` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `freeform_crm_fields_integrationId_fk` (`integrationId`),
  CONSTRAINT `freeform_crm_fields_integrationId_fk` FOREIGN KEY (`integrationId`) REFERENCES `freeform_integrations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table freeform_fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `freeform_fields`;

CREATE TABLE `freeform_fields` (
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

LOCK TABLES `freeform_fields` WRITE;
/*!40000 ALTER TABLE `freeform_fields` DISABLE KEYS */;

INSERT INTO `freeform_fields` (`id`, `type`, `handle`, `label`, `required`, `instructions`, `metaProperties`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'text','firstName','First Name',0,NULL,NULL,'2018-11-07 16:07:44','2018-11-07 16:07:44','90dd142a-b772-444e-aa6d-8628cb84bf4f'),
	(2,'text','lastName','Last Name',0,NULL,NULL,'2018-11-07 16:07:44','2018-11-07 16:07:44','52f46f68-9c85-47ba-9edc-044ad3c47bbb'),
	(3,'email','email','Email',0,NULL,NULL,'2018-11-07 16:07:44','2018-11-07 16:07:44','1e8fe4eb-816a-45b1-acb5-bcd8c65b83aa'),
	(4,'text','website','Website',0,NULL,NULL,'2018-11-07 16:07:44','2018-11-07 16:07:44','c423412a-d666-44a3-ab83-9b9ef09f3d27'),
	(5,'text','cellPhone','Cell Phone',0,NULL,NULL,'2018-11-07 16:07:44','2018-11-07 16:07:44','8793eabf-e30b-4b58-8527-a5f6ec3dca38'),
	(6,'text','homePhone','Home Phone',0,NULL,NULL,'2018-11-07 16:07:44','2018-11-07 16:07:44','4ebdc3f0-be1c-4455-a6d2-3b8db3ec4b78'),
	(7,'text','companyName','Company Name',0,NULL,NULL,'2018-11-07 16:07:44','2018-11-07 16:07:44','667a2407-8390-46b6-9619-fd8b177c35eb'),
	(8,'textarea','address','Address',0,NULL,'{\"rows\":2}','2018-11-07 16:07:44','2018-11-07 16:07:44','edc4c61d-9988-4f17-b293-56d36ad65e0b'),
	(9,'text','city','City',0,NULL,NULL,'2018-11-07 16:07:44','2018-11-07 16:07:44','9d3d8a9f-9160-44a6-b27e-5d9c964e5126'),
	(10,'select','state','State',0,NULL,'{\"options\":[{\"value\":\"\",\"label\":\"Select a State\"},{\"value\":\"AL\",\"label\":\"Alabama\"},{\"value\":\"AK\",\"label\":\"Alaska\"},{\"value\":\"AZ\",\"label\":\"Arizona\"},{\"value\":\"AR\",\"label\":\"Arkansas\"},{\"value\":\"CA\",\"label\":\"California\"},{\"value\":\"CO\",\"label\":\"Colorado\"},{\"value\":\"CT\",\"label\":\"Connecticut\"},{\"value\":\"DE\",\"label\":\"Delaware\"},{\"value\":\"DC\",\"label\":\"District of Columbia\"},{\"value\":\"FL\",\"label\":\"Florida\"},{\"value\":\"GA\",\"label\":\"Georgia\"},{\"value\":\"HI\",\"label\":\"Hawaii\"},{\"value\":\"ID\",\"label\":\"Idaho\"},{\"value\":\"IL\",\"label\":\"Illinois\"},{\"value\":\"IN\",\"label\":\"Indiana\"},{\"value\":\"IA\",\"label\":\"Iowa\"},{\"value\":\"KS\",\"label\":\"Kansas\"},{\"value\":\"KY\",\"label\":\"Kentucky\"},{\"value\":\"LA\",\"label\":\"Louisiana\"},{\"value\":\"ME\",\"label\":\"Maine\"},{\"value\":\"MD\",\"label\":\"Maryland\"},{\"value\":\"MA\",\"label\":\"Massachusetts\"},{\"value\":\"MI\",\"label\":\"Michigan\"},{\"value\":\"MN\",\"label\":\"Minnesota\"},{\"value\":\"MS\",\"label\":\"Mississippi\"},{\"value\":\"MO\",\"label\":\"Missouri\"},{\"value\":\"MT\",\"label\":\"Montana\"},{\"value\":\"NE\",\"label\":\"Nebraska\"},{\"value\":\"NV\",\"label\":\"Nevada\"},{\"value\":\"NH\",\"label\":\"New Hampshire\"},{\"value\":\"NJ\",\"label\":\"New Jersey\"},{\"value\":\"NM\",\"label\":\"New Mexico\"},{\"value\":\"NY\",\"label\":\"New York\"},{\"value\":\"NC\",\"label\":\"North Carolina\"},{\"value\":\"ND\",\"label\":\"North Dakota\"},{\"value\":\"OH\",\"label\":\"Ohio\"},{\"value\":\"OK\",\"label\":\"Oklahoma\"},{\"value\":\"OR\",\"label\":\"Oregon\"},{\"value\":\"PA\",\"label\":\"Pennsylvania\"},{\"value\":\"RI\",\"label\":\"Rhode Island\"},{\"value\":\"SC\",\"label\":\"South Carolina\"},{\"value\":\"SD\",\"label\":\"South Dakota\"},{\"value\":\"TN\",\"label\":\"Tennessee\"},{\"value\":\"TX\",\"label\":\"Texas\"},{\"value\":\"UT\",\"label\":\"Utah\"},{\"value\":\"VT\",\"label\":\"Vermont\"},{\"value\":\"VA\",\"label\":\"Virginia\"},{\"value\":\"WA\",\"label\":\"Washington\"},{\"value\":\"WV\",\"label\":\"West Virginia\"},{\"value\":\"WI\",\"label\":\"Wisconsin\"},{\"value\":\"WY\",\"label\":\"Wyoming\"}]}','2018-11-07 16:07:44','2018-11-07 16:07:44','3387aa42-7fd3-4404-ba53-6964ed82309b'),
	(11,'text','zipCode','Zip Code',0,NULL,NULL,'2018-11-07 16:07:44','2018-11-07 16:07:44','69c3c4bb-1181-419d-8c03-370c07b8d6d7'),
	(12,'textarea','message','Message',0,NULL,'{\"rows\":5}','2018-11-07 16:07:45','2018-11-07 16:07:45','1cb2c917-0abd-46ba-9f34-4983146a2bb0'),
	(13,'number','number','Number',0,NULL,NULL,'2018-11-07 16:07:45','2018-11-07 16:07:45','4e66999c-b2fe-4c18-9d20-d4fd44a5ad0f');

/*!40000 ALTER TABLE `freeform_fields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table freeform_forms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `freeform_forms`;

CREATE TABLE `freeform_forms` (
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



# Dump of table freeform_integrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `freeform_integrations`;

CREATE TABLE `freeform_integrations` (
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



# Dump of table freeform_integrations_queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `freeform_integrations_queue`;

CREATE TABLE `freeform_integrations_queue` (
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
  CONSTRAINT `freeform_integrations_queue_id_fk` FOREIGN KEY (`id`) REFERENCES `freeform_mailing_list_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `freeform_integrations_queue_submissionId_fk` FOREIGN KEY (`submissionId`) REFERENCES `freeform_submissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table freeform_mailing_list_fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `freeform_mailing_list_fields`;

CREATE TABLE `freeform_mailing_list_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mailingListId` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('string','numeric','boolean','array') NOT NULL,
  `required` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `freeform_mailing_list_fields_mailingListId_fk` (`mailingListId`),
  CONSTRAINT `freeform_mailing_list_fields_mailingListId_fk` FOREIGN KEY (`mailingListId`) REFERENCES `freeform_mailing_lists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table freeform_mailing_lists
# ------------------------------------------------------------

DROP TABLE IF EXISTS `freeform_mailing_lists`;

CREATE TABLE `freeform_mailing_lists` (
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
  CONSTRAINT `freeform_mailing_lists_integrationId_fk` FOREIGN KEY (`integrationId`) REFERENCES `freeform_integrations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table freeform_notifications
# ------------------------------------------------------------

DROP TABLE IF EXISTS `freeform_notifications`;

CREATE TABLE `freeform_notifications` (
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



# Dump of table freeform_payment_gateway_fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `freeform_payment_gateway_fields`;

CREATE TABLE `freeform_payment_gateway_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `integrationId` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('string','numeric','boolean','array') NOT NULL,
  `required` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `freeform_payment_gateway_fields_integrationId_fk` (`integrationId`),
  CONSTRAINT `freeform_payment_gateway_fields_integrationId_fk` FOREIGN KEY (`integrationId`) REFERENCES `freeform_integrations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table freeform_statuses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `freeform_statuses`;

CREATE TABLE `freeform_statuses` (
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

LOCK TABLES `freeform_statuses` WRITE;
/*!40000 ALTER TABLE `freeform_statuses` DISABLE KEYS */;

INSERT INTO `freeform_statuses` (`id`, `name`, `handle`, `color`, `isDefault`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Pending','pending','light',NULL,1,'2018-11-07 16:07:45','2018-11-07 16:07:45','e7d4eb9a-894b-4d84-9017-e69ff4bc22ed'),
	(2,'Open','open','green',1,2,'2018-11-07 16:07:45','2018-11-07 16:07:45','ecfee32d-a104-4aad-9b93-f11a3f8cef11'),
	(3,'Closed','closed','grey',NULL,3,'2018-11-07 16:07:45','2018-11-07 16:07:45','521f1b34-f0f6-4a6d-9f49-8a0fa0d9d239');

/*!40000 ALTER TABLE `freeform_statuses` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table freeform_submissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `freeform_submissions`;

CREATE TABLE `freeform_submissions` (
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
  `field_1` varchar(100) DEFAULT NULL,
  `field_2` varchar(100) DEFAULT NULL,
  `field_3` text,
  `field_4` varchar(100) DEFAULT NULL,
  `field_5` varchar(100) DEFAULT NULL,
  `field_6` varchar(100) DEFAULT NULL,
  `field_7` varchar(100) DEFAULT NULL,
  `field_8` text,
  `field_9` varchar(100) DEFAULT NULL,
  `field_10` varchar(100) DEFAULT NULL,
  `field_11` varchar(100) DEFAULT NULL,
  `field_12` text,
  `field_13` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `freeform_submissions_incrementalId_unq_idx` (`incrementalId`),
  UNIQUE KEY `freeform_submissions_token_unq_idx` (`token`),
  KEY `freeform_submissions_formId_fk` (`formId`),
  KEY `freeform_submissions_statusId_fk` (`statusId`),
  CONSTRAINT `freeform_submissions_formId_fk` FOREIGN KEY (`formId`) REFERENCES `freeform_forms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `freeform_submissions_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `freeform_submissions_statusId_fk` FOREIGN KEY (`statusId`) REFERENCES `freeform_statuses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table freeform_unfinalized_files
# ------------------------------------------------------------

DROP TABLE IF EXISTS `freeform_unfinalized_files`;

CREATE TABLE `freeform_unfinalized_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table globalsets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `globalsets`;

CREATE TABLE `globalsets` (
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
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `info`;

CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `edition` tinyint(3) unsigned NOT NULL,
  `timezone` varchar(30) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `on` tinyint(1) NOT NULL DEFAULT '0',
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;

INSERT INTO `info` (`id`, `version`, `schemaVersion`, `edition`, `timezone`, `name`, `on`, `maintenance`, `fieldVersion`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'3.0.32','3.0.94',0,'America/New_York','Papertrain Boilerplate',1,0,'3HkC4QsDrZk4','2018-10-17 19:43:46','2018-11-20 20:41:04','bdebff9e-a915-4f72-a9be-e9715430bcd0');

/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixblocks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocks`;

CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `matrixblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table matrixblocktypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocktypes`;

CREATE TABLE `matrixblocktypes` (
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
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;

INSERT INTO `matrixblocktypes` (`id`, `fieldId`, `fieldLayoutId`, `name`, `handle`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,3,'Section','sectionSettings',1,'2018-11-06 19:29:37','2018-11-20 20:41:04','9c7038b3-900d-4b50-a5ee-7c445a476f87'),
	(2,1,6,'Heading','heading',4,'2018-11-06 19:54:25','2018-11-20 20:41:04','e99be65c-5fee-4c83-9eed-8050793be42a'),
	(3,1,7,'Container','container',2,'2018-11-07 13:26:27','2018-11-20 20:41:04','27f153c6-09ef-408c-a85b-50ee37263d52'),
	(4,1,8,'End Column','endColumn',3,'2018-11-07 13:26:27','2018-11-20 20:41:04','8ca7c03d-aa9b-4611-b6be-6862e9a89ce1');

/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixcontent_cc
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixcontent_cc`;

CREATE TABLE `matrixcontent_cc` (
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
  `field_heading_padding` varchar(255) DEFAULT NULL,
  `field_sectionSettings_overlayTint` varchar(7) DEFAULT NULL,
  `field_sectionSettings_overlayDensity` varchar(255) DEFAULT NULL,
  `field_container_width` varchar(255) DEFAULT NULL,
  `field_container_columnLayout` varchar(255) DEFAULT NULL,
  `field_container_columnGutter` varchar(255) DEFAULT NULL,
  `field_container_verticalAlign` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_cc_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_cc_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_cc_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_cc_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
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
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`id`, `pluginId`, `type`, `name`, `applyTime`, `dateCreated`, `dateUpdated`, `uid`)
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
	(113,5,'plugin','m181112_152751_ChangeTypeEnumColumnsToIndexedText','2018-11-20 20:05:33','2018-11-20 20:05:33','2018-11-20 20:05:33','9ad82d4a-5969-44f8-9baa-cb06516c7056');

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table plugins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plugins`;

CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKey` char(24) DEFAULT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `settings` text,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`),
  KEY `plugins_enabled_idx` (`enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;

INSERT INTO `plugins` (`id`, `handle`, `version`, `schemaVersion`, `licenseKey`, `licenseKeyStatus`, `enabled`, `settings`, `installDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'eager-beaver','1.0.4','1.0.0',NULL,'unknown',1,NULL,'2018-11-06 19:48:48','2018-11-06 19:48:48','2018-11-20 20:05:42','75e3b61a-23b8-440d-9ca8-02214229f452'),
	(2,'imager','v2.1.1','2.0.0',NULL,'unknown',1,NULL,'2018-11-06 19:48:52','2018-11-06 19:48:52','2018-11-20 20:05:42','5880e16d-544d-40d8-a11e-18c07ee2cce6'),
	(3,'splash','3.0.2','3.0.0',NULL,'unknown',1,'{\"volume\":\"1\",\"authorField\":\"\",\"authorUrlField\":\"\",\"colorField\":\"\"}','2018-11-06 20:03:24','2018-11-06 20:03:24','2018-11-20 20:05:42','7c311bf3-2d90-42f0-9a51-a4c6d4ed7132'),
	(5,'freeform','2.5.1','2.1.2',NULL,'invalid',1,NULL,'2018-11-07 16:07:44','2018-11-07 16:07:44','2018-11-20 20:05:42','9010b6b3-f122-4d41-b17d-45d5d40ad60d');

/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `queue`;

CREATE TABLE `queue` (
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



# Dump of table relations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `relations`;

CREATE TABLE `relations` (
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
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table resourcepaths
# ------------------------------------------------------------

DROP TABLE IF EXISTS `resourcepaths`;

CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;

INSERT INTO `resourcepaths` (`hash`, `path`)
VALUES
	('104e4ffd','@lib/fileupload'),
	('1298516d','@app/web/assets/updateswidget/dist'),
	('13ef96a3','@app/web/assets/generalsettings/dist'),
	('171ea88d','@app/web/assets/updater/dist'),
	('1af88df','@craft/web/assets/plugins/dist'),
	('1c0afdac','@app/web/assets/craftsupport/dist'),
	('1c0b7320','@craft/web/assets/feed/dist'),
	('1f11396e','@lib/jquery-ui'),
	('20f8adea','@lib/fabric'),
	('231e4e64','@craft/web/assets/craftsupport/dist'),
	('238af62f','@app/web/assets/dashboard/dist'),
	('24bc9f51','@app/web/assets/cp/dist'),
	('24edd861','@app/web/assets/fields/dist'),
	('2b18f9a9','@craft/web/assets/login/dist'),
	('2c221303','@app/web/assets/recententries/dist'),
	('2cd0352','@app/web/assets/updater/dist'),
	('316f348e','@app/web/assets/cp/dist'),
	('32c342f','@app/web/assets/editentry/dist'),
	('355121f0','@app/web/assets/login/dist'),
	('35be79d4','@lib/garnishjs'),
	('39f1b8dc','@app/web/assets/recententries/dist'),
	('3c77395e','@app/web/assets/updates/dist'),
	('3f84d27a','@app/web/assets/pluginstore/dist'),
	('403755b6','@bower/jquery/dist'),
	('446b0914','@lib/velocity'),
	('45ee97eb','@craft/web/assets/editentry/dist'),
	('46c7ddc0','@app/web/assets/utilities/dist'),
	('48747f30','@app/web/assets/feed/dist'),
	('4d9f0d23','@lib/jquery.payment'),
	('4fedb39f','@app/web/assets/tablesettings/dist'),
	('51b8a2cb','@lib/velocity'),
	('5314761f','@app/web/assets/utilities/dist'),
	('55e4fe69','@bower/jquery/dist'),
	('56b4270d','@lib/xregexp'),
	('584ca6fc','@lib/jquery.payment'),
	('5a3e1840','@app/web/assets/tablesettings/dist'),
	('5cd86387','@lib/selectize'),
	('5da7d4ef','@app/web/assets/feed/dist'),
	('6036e52','@lib/d3'),
	('654855eb','@craft/web/assets/dashboard/dist'),
	('694b7f78','@lib/timepicker'),
	('6c6d8080','@app/web/assets/matrixsettings/dist'),
	('6fa7fe43','@lib/element-resize-detector'),
	('781d944e','@lib'),
	('79be2b5f','@app/web/assets/matrixsettings/dist'),
	('7a74559c','@lib/element-resize-detector'),
	('7a82b687','@craft/web/assets/matrixsettings/dist'),
	('82fcfaf2','@app/web/assets/utilities/dist'),
	('840c7284','@bower/jquery/dist'),
	('84b2b86d','@craft/web/assets/updateswidget/dist'),
	('875cabe0','@lib/xregexp'),
	('89a42a11','@lib/jquery.payment'),
	('8a64e03','@lib/picturefill'),
	('8bd694ad','@app/web/assets/tablesettings/dist'),
	('8d30ef6a','@lib/selectize'),
	('928f003f','@lib/xregexp'),
	('958385f9','@lib/velocity'),
	('97b75181','@craft/web/assets/pluginstore/dist'),
	('98e344b5','@lib/selectize'),
	('999cf3dd','@app/web/assets/feed/dist'),
	('9d95673','@app/web/assets/craftsupport/dist'),
	('9ecc61fc','@craft/web/assets/cp/dist'),
	('a57a9c0e','@app/web/assets/plugins/dist'),
	('a856a7b2','@app/web/assets/matrixsettings/dist'),
	('ab9cd971','@lib/element-resize-detector'),
	('ac292b1','@lib/jquery-ui'),
	('ad70584a','@lib/timepicker'),
	('ae03ff0f','@ether/splash/resources'),
	('b3cbbc5c','@craft/web/assets/updater/dist'),
	('b8a3f395','@lib/timepicker'),
	('ba08fa03','@craft/web/assets/recententries/dist'),
	('c0e161b','@app/web/assets/matrix/dist'),
	('c1a6c310','@lib/fileupload'),
	('c2384960','@lib/d3'),
	('c370dd80','@app/web/assets/updateswidget/dist'),
	('c4af134c','@app/web/assets/sites/dist'),
	('c717131d','@app/web/assets/editentry/dist'),
	('c8353129','@app/web/assets/matrix/dist'),
	('c9bf5f7a','@lib/prismjs'),
	('cb3955f3','@lib/jquery-touch-events'),
	('cc14f140','@craft/web/assets/tablesettings/dist'),
	('cc9d6931','@lib/picturefill'),
	('cce58d4f','@craft/web/assets/matrix/dist'),
	('cde27141','@app/web/assets/craftsupport/dist'),
	('d17cb893','@app/web/assets/sites/dist'),
	('d3258fbf','@app/web/assets/updater/dist'),
	('d47568cf','@lib/fileupload'),
	('d7ebe2bf','@lib/d3'),
	('d847848','@lib/prismjs'),
	('d94ec2ee','@lib/picturefill'),
	('db2a1e5c','@lib/jquery-ui'),
	('deeafe2c','@lib/jquery-touch-events'),
	('e087b863','@app/web/assets/cp/dist'),
	('e0d6ff53','@app/web/assets/fields/dist'),
	('e4064335','@craft/web/assets/fields/dist'),
	('e456f539','@lib/garnishjs'),
	('e4c38ad8','@lib/fabric'),
	('e7b1d11d','@app/web/assets/dashboard/dist'),
	('ed9fb5b3','@app/web/assets/updates/dist'),
	('f0272c1','@lib/jquery-touch-events'),
	('f1102107','@lib/fabric'),
	('f1855ee6','@lib/garnishjs'),
	('f2627ac2','@app/web/assets/dashboard/dist'),
	('f505548c','@app/web/assets/fields/dist'),
	('f84c1e6c','@app/web/assets/updates/dist'),
	('fb3e48d3','@supercool/buttonbox/assetbundles/buttonbox/dist'),
	('fdca9fee','@app/web/assets/recententries/dist');

/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table routes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `routes`;

CREATE TABLE `routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) DEFAULT NULL,
  `uriParts` varchar(255) NOT NULL,
  `uriPattern` varchar(255) NOT NULL,
  `template` varchar(500) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `routes_uriPattern_idx` (`uriPattern`),
  KEY `routes_siteId_idx` (`siteId`),
  CONSTRAINT `routes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table searchindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `searchindex`;

CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;

INSERT INTO `searchindex` (`elementId`, `attribute`, `fieldId`, `siteId`, `keywords`)
VALUES
	(1,'username',0,1,' kylea page works '),
	(1,'firstname',0,1,''),
	(1,'lastname',0,1,''),
	(1,'fullname',0,1,''),
	(1,'email',0,1,' kylea page works '),
	(1,'slug',0,1,''),
	(2,'slug',0,1,' example '),
	(2,'title',0,1,' example '),
	(3,'slug',0,1,' example complex content page '),
	(3,'title',0,1,' example complex content page '),
	(3,'field',1,1,''),
	(6,'filename',0,1,' akwxey_swpk jpg '),
	(6,'extension',0,1,' jpg '),
	(6,'kind',0,1,' image '),
	(6,'slug',0,1,''),
	(6,'title',0,1,' akwxey_swpk ');

/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sections
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections`;

CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagateEntries` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_handle_unq_idx` (`handle`),
  UNIQUE KEY `sections_name_unq_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;

INSERT INTO `sections` (`id`, `structureId`, `name`, `handle`, `type`, `enableVersioning`, `propagateEntries`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'Example','example','single',1,1,'2018-10-17 19:44:20','2018-10-17 19:44:20','e7f66ada-d89e-4850-bd54-fe5d24ff548a'),
	(2,1,'Standard Pages','standardPages','structure',1,1,'2018-11-06 19:23:08','2018-11-20 20:01:32','b192f8ce-1e5a-495d-bb45-ede8cd1ad3d4');

/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sections_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections_sites`;

CREATE TABLE `sections_sites` (
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
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;

INSERT INTO `sections_sites` (`id`, `sectionId`, `siteId`, `hasUrls`, `uriFormat`, `template`, `enabledByDefault`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,1,'example','_singles/example',1,'2018-10-17 19:44:20','2018-10-17 19:44:20','5d65b850-c905-4055-965c-b48b0c46c79a'),
	(2,2,1,1,'{parent.slug}/{slug}','_complex-content/entry',1,'2018-11-06 19:23:08','2018-11-20 20:01:32','f9cded0e-6ce6-4afe-b628-6337b597095b');

/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sequences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sequences`;

CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
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
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;

INSERT INTO `sessions` (`id`, `userId`, `token`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'iPPgar9bzP5cCnb3FNJBfcr1c_Gge0YxR8ufc6-osx489nw0TscYX9UhZm_fUPZD3RoBHh6PGy89TkcUYGUvktHDDx6f3A1bl9FA','2018-11-06 19:21:04','2018-11-06 20:11:52','39a2d76f-e892-4b93-89c8-72e012bbeaa4'),
	(2,1,'UUILjvPnu_G6bvyL7HnCspQ39QOk7qCWWIlHgbCfqUsGXW_klmmbbmiYUnLURK3743jUgbmur4RlzRCmTpmZMD9BvqqNgmaEDsc9','2018-11-06 20:12:31','2018-11-06 20:26:49','7e342365-8bd5-4134-b2c6-6ffbfc4332f3'),
	(3,1,'ycU0DSgtKZUA6H5uMm2gdnjISf19mfHxv4nQTt-YGEVNOEezA3iCTLjMg0gD47F088ZB1UenyijWCrhCmKpWqxWY7CEjqrFQstNy','2018-11-06 20:27:18','2018-11-06 20:30:01','3f74149f-0179-4308-8e44-c55dbae1393c'),
	(4,1,'AtPllifZASf7lya0BzIXqBvyBEc5YOSsRlQJlDog0ACTOFiRUqqZ6EJLOpFuuoiC4O21M27_t0ztgXtnk4og1LUe0kpfsOgFZxjx','2018-11-06 20:30:16','2018-11-06 21:00:46','051bfde1-1ada-43a5-bbb5-b547773afe5c'),
	(5,1,'y9rep5fQxBlO-frBWlV20kpaZUOM73fGi-tGEUyEPQidMYJPx9MoZEQ55DCSpoEpXN_n_0Z5og6s1-2xx6vb9_vo-7goDmZXhAwo','2018-11-06 20:30:20','2018-11-06 20:30:20','40e0dfad-4e24-48c0-b6a2-85147e5a1dd2'),
	(6,1,'9saOpqZHOLVVIM-mEiyXUzUivws3Uhw-SnjccwnMlQ0YQi53_LVmC8sDkV_gzbJj6sF9nmmR5FWteKjzyuq58pQhhOPrAvpJDAx9','2018-11-07 12:58:03','2018-11-07 18:50:11','58a0a69a-8370-4e3f-a45d-6d4563f7bb3c');

/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table shunnedmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shunnedmessages`;

CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sitegroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sitegroups`;

CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sitegroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;

INSERT INTO `sitegroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Papertrain Boilerplate','2018-10-17 19:43:46','2018-10-17 19:43:46','f5eb95d0-c53e-4630-b230-91539b9e08b2');

/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sites`;

CREATE TABLE `sites` (
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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sites_handle_unq_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;

INSERT INTO `sites` (`id`, `groupId`, `primary`, `name`, `handle`, `language`, `hasUrls`, `baseUrl`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,'Papertrain Boilerplate','default','en-US',1,'@web/',1,'2018-10-17 19:43:46','2018-10-17 19:43:46','ac246379-14f1-440a-82f2-90ef2b3e6443');

/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table structureelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structureelements`;

CREATE TABLE `structureelements` (
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
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;

INSERT INTO `structureelements` (`id`, `structureId`, `elementId`, `root`, `lft`, `rgt`, `level`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,NULL,1,1,4,0,'2018-11-06 19:47:54','2018-11-06 19:47:55','768e310c-2faf-495b-8cea-ff69328cc355'),
	(2,1,3,1,2,3,1,'2018-11-06 19:47:55','2018-11-06 19:47:55','7ac0c2b4-419b-417c-84be-3e99f569b3a7');

/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table structures
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structures`;

CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;

INSERT INTO `structures` (`id`, `maxLevels`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,2,'2018-11-06 19:23:08','2018-11-20 20:01:32','705621d5-28f2-4ec0-b53c-8500b2bb1fd8');

/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table systemmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `systemmessages`;

CREATE TABLE `systemmessages` (
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



# Dump of table systemsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `systemsettings`;

CREATE TABLE `systemsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(15) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemsettings_category_unq_idx` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `systemsettings` WRITE;
/*!40000 ALTER TABLE `systemsettings` DISABLE KEYS */;

INSERT INTO `systemsettings` (`id`, `category`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'email','{\"fromEmail\":\"no-reply@page.works\",\"fromName\":\"Papertrain Boilerplate\",\"template\":null,\"transportType\":\"craft\\\\mail\\\\transportadapters\\\\Sendmail\",\"transportSettings\":null}','2018-10-17 19:43:49','2018-11-20 20:03:10','79573005-19ff-4096-90e0-2b52de45cd28');

/*!40000 ALTER TABLE `systemsettings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table taggroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taggroups`;

CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `taggroups_name_unq_idx` (`name`),
  UNIQUE KEY `taggroups_handle_unq_idx` (`handle`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecacheelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecacheelements`;

CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecachequeries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecachequeries`;

CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecaches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecaches`;

CREATE TABLE `templatecaches` (
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
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tokens`;

CREATE TABLE `tokens` (
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



# Dump of table usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups`;

CREATE TABLE `usergroups` (
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



# Dump of table usergroups_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups_users`;

CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions`;

CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions_usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_usergroups`;

CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_users`;

CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpreferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpreferences`;

CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;

INSERT INTO `userpreferences` (`userId`, `preferences`)
VALUES
	(1,'{\"language\":\"en-US\"}');

/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
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
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `username`, `photoId`, `firstName`, `lastName`, `email`, `password`, `admin`, `locked`, `suspended`, `pending`, `lastLoginDate`, `lastLoginAttemptIp`, `invalidLoginWindowStart`, `invalidLoginCount`, `lastInvalidLoginDate`, `lockoutDate`, `hasDashboard`, `verificationCode`, `verificationCodeIssuedDate`, `unverifiedEmail`, `passwordResetRequired`, `lastPasswordChangeDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'kylea@page.works',NULL,NULL,NULL,'kylea@page.works','$2y$13$5xrJjAA39F7whInlKHwZrO9JvlUQ7yl2pWwnQpILBZMl8JGRlFE4C',1,0,0,0,'2018-11-07 12:58:04','::1',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2018-10-17 19:43:49','2018-10-17 19:43:49','2018-11-07 12:58:04','e44094df-7375-4fff-a0a5-d88d45bbefcb');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table volumefolders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumefolders`;

CREATE TABLE `volumefolders` (
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
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;

INSERT INTO `volumefolders` (`id`, `parentId`, `volumeId`, `name`, `path`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,1,'Images','','2018-11-06 19:33:37','2018-11-06 19:33:37','eb2dafb2-9954-4850-9d47-56e2e80f3880'),
	(2,NULL,2,'Videos','','2018-11-06 19:33:56','2018-11-06 19:33:56','f1b1b0d9-4fde-4469-a030-603d50bb42d6'),
	(3,NULL,NULL,'Temporary source',NULL,'2018-11-06 20:04:20','2018-11-06 20:04:20','55f6a2d2-4d18-4c8b-9387-f81ab9601a1a'),
	(4,3,NULL,'user_1','user_1/','2018-11-06 20:04:20','2018-11-06 20:04:20','e58f2b68-05d5-4fce-aff6-fa34d0786b83');

/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table volumes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumes`;

CREATE TABLE `volumes` (
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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumes_name_unq_idx` (`name`),
  UNIQUE KEY `volumes_handle_unq_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;

INSERT INTO `volumes` (`id`, `fieldLayoutId`, `name`, `handle`, `type`, `hasUrls`, `url`, `settings`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,4,'Images','images','craft\\volumes\\Local',1,'@web/uploads/images','{\"path\":\"@webroot/uploads/images\"}',1,'2018-11-06 19:33:37','2018-11-06 19:33:37','ea6beeac-3da3-43fe-a530-47032076abb2'),
	(2,5,'Videos','videos','craft\\volumes\\Local',1,'@web/uploads/videos','{\"path\":\"@webroot/uploads/videos\"}',2,'2018-11-06 19:33:56','2018-11-06 19:33:56','02433cef-1aec-4478-8f75-f5570480c436');

/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table widgets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `widgets`;

CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(1) NOT NULL DEFAULT '0',
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;

INSERT INTO `widgets` (`id`, `userId`, `type`, `sortOrder`, `colspan`, `settings`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'craft\\widgets\\RecentEntries',1,0,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2018-10-17 19:43:51','2018-10-17 19:43:51','8f524da9-1104-443e-a4a9-a3661ca2d3dc'),
	(2,1,'craft\\widgets\\CraftSupport',2,0,'[]',1,'2018-10-17 19:43:51','2018-10-17 19:43:51','ca275e69-e163-473a-9816-1d0862fbd53a'),
	(3,1,'craft\\widgets\\Updates',3,0,'[]',1,'2018-10-17 19:43:51','2018-10-17 19:43:51','94598f39-1f60-4b7a-99a0-9526042dcfb8'),
	(4,1,'craft\\widgets\\Feed',4,0,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2018-10-17 19:43:51','2018-10-17 19:43:51','2ca3e459-c48e-47de-bea6-1e294997089a');

/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
