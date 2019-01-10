# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.6.38)
# Database: craft_papertrain
# Generation Time: 2019-01-10 14:56:04 +0000
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
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_filename_folderId_unq_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `pt_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `pt_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



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
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `pt_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE
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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_name_unq_idx` (`name`),
  UNIQUE KEY `categorygroups_handle_unq_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `pt_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_content` WRITE;
/*!40000 ALTER TABLE `pt_content` DISABLE KEYS */;

INSERT INTO `pt_content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,NULL,'2018-10-17 19:43:46','2018-12-08 13:41:30','4027dc44-49c1-4aaf-b85b-a6bc1a637bac');

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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `pt_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_elements` WRITE;
/*!40000 ALTER TABLE `pt_elements` DISABLE KEYS */;

INSERT INTO `pt_elements` (`id`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'craft\\elements\\User',1,0,'2018-10-17 19:43:46','2018-12-08 13:41:30','f5535ce9-aa32-4c64-8dc5-5d5876014bb3'),
	(169,14,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2018-11-29 18:38:40','2018-11-30 12:48:00','6053c3ed-ef28-41b9-978f-c2e546dfb222'),
	(170,14,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2018-11-29 18:38:40','2018-11-30 12:48:00','99307da3-0da3-4569-8246-e8b249ad2013'),
	(171,14,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2018-11-29 18:38:40','2018-11-30 12:48:00','f5202220-bcde-4ca7-89b4-c9cb29f40811'),
	(172,14,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2018-11-29 18:38:40','2018-11-30 12:48:00','adf3a415-f14c-4923-b534-746a23dd7ada'),
	(173,14,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2018-11-29 18:38:40','2018-11-30 12:48:00','f53ccea7-3b11-4e1f-a4bf-15e0be9d691b');

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
	(173,173,1,NULL,NULL,1,'2018-11-29 18:38:40','2018-11-30 12:48:00','e0e781e8-091d-4fc9-b46c-10d62d3907cd');

/*!40000 ALTER TABLE `pt_elements_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_entries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_entries`;

CREATE TABLE `pt_entries` (
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
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `pt_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `pt_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `pt_entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `entrytypes_name_sectionId_unq_idx` (`name`,`sectionId`),
  UNIQUE KEY `entrytypes_handle_sectionId_unq_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `pt_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `pt_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_entrytypes` WRITE;
/*!40000 ALTER TABLE `pt_entrytypes` DISABLE KEYS */;

INSERT INTO `pt_entrytypes` (`id`, `sectionId`, `fieldLayoutId`, `name`, `handle`, `hasTitleField`, `titleLabel`, `titleFormat`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,2,2,'Standard Pages','standardPages',1,'Title',NULL,1,'2018-11-06 19:23:08','2018-11-06 19:48:17','314ff677-634c-4a48-8499-6c2817266962');

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
	(2,'Site Settings','2018-12-08 15:05:48','2018-12-08 15:05:48','2e631263-d760-43da-adbd-abb7189fbd52');

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
	(2600,3,589,3,0,1,'2018-12-07 19:34:19','2018-12-07 19:34:19','fc9a378c-bb31-464e-b01d-8dc51c724b3d'),
	(2601,3,589,4,0,2,'2018-12-07 19:34:19','2018-12-07 19:34:19','25a59d07-eedc-42a0-8e10-ffd24f1e6aa6'),
	(2602,3,589,5,0,3,'2018-12-07 19:34:19','2018-12-07 19:34:19','04f329e4-1101-4ba0-a322-f053cc73faf6'),
	(2603,3,589,11,0,4,'2018-12-07 19:34:19','2018-12-07 19:34:19','ee8c6157-b1ba-4d56-b7e2-62f009ea934a'),
	(2604,3,589,38,0,5,'2018-12-07 19:34:19','2018-12-07 19:34:19','3b967411-5797-4f99-bd00-99a831f5243e'),
	(2605,3,589,28,0,6,'2018-12-07 19:34:19','2018-12-07 19:34:19','a31d1376-02e8-4d9a-8e9e-cf114bfdc1a9'),
	(2606,7,590,14,0,1,'2018-12-07 19:34:19','2018-12-07 19:34:19','b5aadf96-c004-469c-98e4-cbddc510670c'),
	(2607,7,590,15,0,2,'2018-12-07 19:34:19','2018-12-07 19:34:19','5f91472d-d7ea-4414-8339-7ea505d85fab'),
	(2608,7,590,16,0,3,'2018-12-07 19:34:19','2018-12-07 19:34:19','0fabd448-4c73-4860-90ab-81e381b03603'),
	(2609,7,590,17,0,4,'2018-12-07 19:34:19','2018-12-07 19:34:19','49236421-7a8a-4de1-bb1c-cfd550d17ac6'),
	(2610,7,590,37,0,5,'2018-12-07 19:34:19','2018-12-07 19:34:19','3f7f5db9-a40f-4c11-b899-d6a1eb473366'),
	(2611,7,590,36,0,6,'2018-12-07 19:34:19','2018-12-07 19:34:19','674646fd-d13e-4354-9702-797f27c9d8ef'),
	(2612,6,592,6,1,1,'2018-12-07 19:34:19','2018-12-07 19:34:19','84adc6fa-bc12-49dd-bac8-a9d1b470c425'),
	(2613,6,592,7,0,2,'2018-12-07 19:34:19','2018-12-07 19:34:19','21763e8b-0782-4e64-be34-645240377e33'),
	(2614,6,592,8,0,3,'2018-12-07 19:34:19','2018-12-07 19:34:19','a23e3132-c519-4b1f-9a79-32e65f86529d'),
	(2615,6,592,29,0,4,'2018-12-07 19:34:19','2018-12-07 19:34:19','f2f136a7-c25c-49c6-8e5f-c7434eae8cb6'),
	(2616,6,592,10,0,5,'2018-12-07 19:34:19','2018-12-07 19:34:19','fe88a1b2-ee3e-47a0-880f-d242427054d6'),
	(2617,9,593,18,1,1,'2018-12-07 19:34:19','2018-12-07 19:34:19','575a6f89-2cfd-474c-8588-a359b26c327f'),
	(2618,9,593,19,0,2,'2018-12-07 19:34:19','2018-12-07 19:34:19','41eb6a59-0069-4796-919f-053d448da4b8'),
	(2619,9,593,30,0,3,'2018-12-07 19:34:19','2018-12-07 19:34:19','a59272dc-0917-4e0c-bedc-a38bd48dde1f'),
	(2620,9,593,20,0,4,'2018-12-07 19:34:19','2018-12-07 19:34:19','a2547418-2f8e-4483-bad8-dac188e70add'),
	(2621,10,594,21,1,1,'2018-12-07 19:34:20','2018-12-07 19:34:20','be48c4d7-aaf6-4146-afa3-fed1e2abfa68'),
	(2622,10,594,22,0,2,'2018-12-07 19:34:20','2018-12-07 19:34:20','13b92d70-bb9d-40fa-a7d5-25298f7b3edd'),
	(2623,10,594,31,0,3,'2018-12-07 19:34:20','2018-12-07 19:34:20','ba48c056-681a-4278-9276-8a80498720e6'),
	(2624,10,594,23,0,4,'2018-12-07 19:34:20','2018-12-07 19:34:20','a0d5bb19-657e-4cf8-8ec3-32f7a1102c37'),
	(2625,10,594,34,0,5,'2018-12-07 19:34:20','2018-12-07 19:34:20','65f489d4-2a58-41a3-8f30-cd25d103bc0f'),
	(2626,10,594,45,0,6,'2018-12-07 19:34:20','2018-12-07 19:34:20','2f296e23-3e4d-4ebf-ba76-58b59a5dc8da'),
	(2627,10,594,33,0,7,'2018-12-07 19:34:20','2018-12-07 19:34:20','55f029a6-da10-4a05-b20e-cca9ad218e3b'),
	(2628,10,594,24,0,8,'2018-12-07 19:34:20','2018-12-07 19:34:20','d15cb3db-bead-484f-9fc2-6b4e3dcea337'),
	(2629,10,594,35,0,9,'2018-12-07 19:34:20','2018-12-07 19:34:20','7c5b8699-8e91-4032-9364-c2def0541971'),
	(2630,10,594,25,0,10,'2018-12-07 19:34:20','2018-12-07 19:34:20','1b9a78dd-2daa-46d0-9daf-10ed4f8373b7'),
	(2631,11,595,40,1,1,'2018-12-07 19:34:20','2018-12-07 19:34:20','6dadd562-a77e-4268-a3c0-efcc30e9c589'),
	(2632,11,595,41,0,2,'2018-12-07 19:34:20','2018-12-07 19:34:20','cbd56bf6-ffb2-4374-840e-f719ad026d97'),
	(2633,12,596,39,1,1,'2018-12-07 19:34:20','2018-12-07 19:34:20','4850e1a0-d1d7-4b5d-b596-c5611dbd87ae'),
	(2634,12,596,42,0,2,'2018-12-07 19:34:20','2018-12-07 19:34:20','aafaeb93-4052-41be-9b40-a99d969b33b5'),
	(2635,12,596,43,0,3,'2018-12-07 19:34:20','2018-12-07 19:34:20','e33a31ae-8aad-41d3-8820-69662bb4810b'),
	(2636,12,596,44,0,4,'2018-12-07 19:34:20','2018-12-07 19:34:20','cb5f089a-783b-4062-aa39-dd1dad4f3381'),
	(2637,13,597,46,0,1,'2018-12-07 19:34:20','2018-12-07 19:34:20','ed3adc85-d70f-405c-9fca-1ef4b956f307'),
	(2638,13,597,47,0,2,'2018-12-07 19:34:20','2018-12-07 19:34:20','b54056e4-126c-4e1b-8e69-e4d06902f17b'),
	(2639,13,597,48,0,3,'2018-12-07 19:34:20','2018-12-07 19:34:20','61405459-8592-4bd9-a691-4d0aa36e0750'),
	(2640,13,597,49,0,4,'2018-12-07 19:34:20','2018-12-07 19:34:20','ff03d52f-2035-443c-9f87-170ae0d8e0d0'),
	(2641,13,597,50,0,5,'2018-12-07 19:34:20','2018-12-07 19:34:20','53e68b8d-e526-41df-8184-78e71b48ad26'),
	(2642,15,598,51,1,1,'2018-12-07 19:34:20','2018-12-07 19:34:20','b11242f7-1c85-4444-b033-947754f06914'),
	(2643,15,598,53,0,2,'2018-12-07 19:34:20','2018-12-07 19:34:20','9caca602-08e4-4526-83f5-ed564cbadfc0'),
	(2644,15,598,54,0,3,'2018-12-07 19:34:20','2018-12-07 19:34:20','fa2fbf78-aa93-49aa-a41b-4e2f8e2d8e3b'),
	(2645,15,598,55,0,4,'2018-12-07 19:34:20','2018-12-07 19:34:20','b7b0e1fa-9122-4e26-be7d-f1f96ba6cff5'),
	(2646,15,598,56,0,5,'2018-12-07 19:34:20','2018-12-07 19:34:20','a7a05204-5ca6-40e4-bd84-bb751205c24a'),
	(2647,15,598,57,0,6,'2018-12-07 19:34:20','2018-12-07 19:34:20','b26c82ff-0eb2-4429-a7fa-d6a32944043b'),
	(2648,16,599,61,1,1,'2018-12-07 19:34:20','2018-12-07 19:34:20','2a2828c4-3315-44bb-b21b-58b44deec436'),
	(2649,16,599,62,0,2,'2018-12-07 19:34:20','2018-12-07 19:34:20','b5ba1efd-7f49-40af-8fe4-8d7dca9e848b'),
	(2650,16,599,71,0,3,'2018-12-07 19:34:20','2018-12-07 19:34:20','35c65791-d554-4580-aefd-b60092707103'),
	(2651,16,599,72,0,4,'2018-12-07 19:34:20','2018-12-07 19:34:20','54d1df49-1396-4cba-ada2-d36f07122cd6'),
	(2652,16,599,73,0,5,'2018-12-07 19:34:20','2018-12-07 19:34:20','eff49e91-de53-4bf0-bcc5-aa1e141c7810'),
	(2653,17,600,60,1,1,'2018-12-07 19:34:21','2018-12-07 19:34:21','5a7d90a1-335a-4ab3-966d-50a3eab149c5'),
	(2654,17,600,63,0,2,'2018-12-07 19:34:21','2018-12-07 19:34:21','9ca6c2d3-62d6-44e2-85f0-c525915bf974'),
	(2655,17,600,64,0,3,'2018-12-07 19:34:21','2018-12-07 19:34:21','9ff42e73-c0f5-4b86-b051-80e38f3d1604'),
	(2656,17,600,74,0,4,'2018-12-07 19:34:21','2018-12-07 19:34:21','cb351c03-3788-492f-be75-658a63b44878'),
	(2657,18,601,66,1,1,'2018-12-07 19:34:21','2018-12-07 19:34:21','e0e1a66e-700d-4ce6-8882-9c32eea55d54'),
	(2658,19,602,65,1,1,'2018-12-07 19:34:21','2018-12-07 19:34:21','1b2dab39-86b2-4a2a-8abc-c6019f322906'),
	(2659,19,602,67,0,2,'2018-12-07 19:34:21','2018-12-07 19:34:21','7539fb06-c116-4ed6-bcb1-5105bc581543'),
	(2660,19,602,68,0,3,'2018-12-07 19:34:21','2018-12-07 19:34:21','6d9578b4-a8e0-4bf4-824b-0189262c22c1'),
	(2661,19,602,69,0,4,'2018-12-07 19:34:21','2018-12-07 19:34:21','5ba138c6-877f-4c3e-b146-11a2ea798b75'),
	(2662,19,602,70,0,5,'2018-12-07 19:34:21','2018-12-07 19:34:21','d1f7baa9-fa23-4169-b4c3-8f35abad1d8f');

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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_fieldlayouts` WRITE;
/*!40000 ALTER TABLE `pt_fieldlayouts` DISABLE KEYS */;

INSERT INTO `pt_fieldlayouts` (`id`, `type`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,'craft\\elements\\Entry','2018-11-06 19:23:08','2018-11-06 19:48:17','49f16c08-2073-4897-8f3e-92355d39b819'),
	(3,'craft\\elements\\MatrixBlock','2018-11-06 19:29:37','2018-12-07 19:34:19','cccaf184-6482-40a9-bdc8-acaaebe6917f'),
	(4,'craft\\elements\\Asset','2018-11-06 19:33:37','2018-11-06 19:33:37','47c48e31-d23e-4089-b483-3ecfc95a95b0'),
	(5,'craft\\elements\\Asset','2018-11-06 19:33:56','2018-11-06 19:33:56','ecfdc16e-4402-41a4-a5af-09785582316a'),
	(6,'craft\\elements\\MatrixBlock','2018-11-06 19:54:26','2018-12-07 19:34:19','39856f0c-11eb-4fe4-a60d-07e698ae181c'),
	(7,'craft\\elements\\MatrixBlock','2018-11-07 13:26:27','2018-12-07 19:34:19','cb1fed6a-0e67-4c84-8d89-ebba225f2dad'),
	(8,'craft\\elements\\MatrixBlock','2018-11-07 13:26:27','2018-12-07 19:34:19','4455065f-9480-4863-8fad-e12f4b0ddf84'),
	(9,'craft\\elements\\MatrixBlock','2018-11-21 13:02:30','2018-12-07 19:34:19','4b28f1e5-4fd6-4d61-af99-5adc926b4e45'),
	(10,'craft\\elements\\MatrixBlock','2018-11-21 13:26:58','2018-12-07 19:34:20','93482697-e9bb-4748-bd38-cd3eb28b0f93'),
	(11,'verbb\\supertable\\elements\\SuperTableBlockElement','2018-11-28 19:07:47','2018-12-07 19:34:20','975abb82-2d2e-45a0-8cef-bb19c73b3d2e'),
	(12,'craft\\elements\\MatrixBlock','2018-11-28 19:07:47','2018-12-07 19:34:20','e17d5a6b-1851-4037-9aba-45296cc932dc'),
	(13,'craft\\elements\\MatrixBlock','2018-11-29 13:45:52','2018-12-07 19:34:20','cbe6b628-b4ac-4766-88ff-b47c38af7989'),
	(14,'verbb\\supertable\\elements\\SuperTableBlockElement','2018-11-29 16:00:58','2018-11-29 19:01:53','4060b2d8-29a2-42b7-b12d-1af66e985375'),
	(15,'craft\\elements\\MatrixBlock','2018-11-29 16:00:58','2018-12-07 19:34:20','57b3a20d-8b2a-4bce-a97d-b60a88dc71d9'),
	(16,'verbb\\supertable\\elements\\SuperTableBlockElement','2018-12-07 12:52:41','2018-12-07 19:34:20','0ff68a13-d28a-4bab-bfdd-ea638bb9166b'),
	(17,'craft\\elements\\MatrixBlock','2018-12-07 12:52:42','2018-12-07 19:34:21','94c10d74-960d-479e-85fd-ece5fa16eaeb'),
	(18,'verbb\\supertable\\elements\\SuperTableBlockElement','2018-12-07 17:24:19','2018-12-07 19:34:21','89001764-e066-4ae4-91cb-a4eaf6d519aa'),
	(19,'craft\\elements\\MatrixBlock','2018-12-07 17:24:19','2018-12-07 19:34:21','54e4b974-31e5-45f1-80c3-8074ec779330');

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
	(589,3,'Content',1,'2018-12-07 19:34:19','2018-12-07 19:34:19','431cab17-82b3-4328-8166-fbf35ca25b8f'),
	(590,7,'Content',1,'2018-12-07 19:34:19','2018-12-07 19:34:19','7cd20f07-b673-4d39-955f-618ff04a1d0d'),
	(591,8,'Content',1,'2018-12-07 19:34:19','2018-12-07 19:34:19','02f46ebe-a005-4b9c-a6ca-57475aee6c31'),
	(592,6,'Content',1,'2018-12-07 19:34:19','2018-12-07 19:34:19','e2e697c7-4591-4f18-aef7-15f9e2cdc34f'),
	(593,9,'Content',1,'2018-12-07 19:34:19','2018-12-07 19:34:19','0557e3fe-505e-4ee8-b22d-95b882ad81d2'),
	(594,10,'Content',1,'2018-12-07 19:34:20','2018-12-07 19:34:20','61909886-d225-43ab-91d2-0e3ef4cead3a'),
	(595,11,'Content',1,'2018-12-07 19:34:20','2018-12-07 19:34:20','11ea1ec2-3f39-426c-8488-ddc18408d6be'),
	(596,12,'Content',1,'2018-12-07 19:34:20','2018-12-07 19:34:20','3ccc2c8f-bdca-4bd0-992c-c56f4aff35fd'),
	(597,13,'Content',1,'2018-12-07 19:34:20','2018-12-07 19:34:20','c4ecc384-9ccb-42be-82f2-4ca9836d0b80'),
	(598,15,'Content',1,'2018-12-07 19:34:20','2018-12-07 19:34:20','caf14cbf-4639-4251-bebd-a6715f81c3cd'),
	(599,16,'Content',1,'2018-12-07 19:34:20','2018-12-07 19:34:20','d92ac903-0b56-42bc-9db0-6669cf024781'),
	(600,17,'Content',1,'2018-12-07 19:34:21','2018-12-07 19:34:21','5c008fae-621b-4935-9f29-20a3c1241677'),
	(601,18,'Content',1,'2018-12-07 19:34:21','2018-12-07 19:34:21','16a8d50e-b444-4d1c-a740-cc39c04c9a30'),
	(602,19,'Content',1,'2018-12-07 19:34:21','2018-12-07 19:34:21','531cb916-c28b-4ca3-b465-5b6b3b698cce');

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

INSERT INTO `pt_fields` (`id`, `groupId`, `name`, `handle`, `context`, `instructions`, `translationMethod`, `translationKeyFormat`, `type`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'Complex Content','cc','global','','site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"contentTable\":\"{{%matrixcontent_cc}}\",\"localizeBlocks\":false}','2018-11-06 19:29:37','2018-12-07 19:34:19','d1fe1a49-a8bf-46ab-ac74-d563effe3be7'),
	(3,NULL,'Background Color','backgroundColor','matrixBlockType:1','Please select this sections background color.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"White\",\"value\":\"-primary-background\",\"default\":\"1\"},{\"label\":\"Off White\",\"value\":\"-secondary-background\",\"default\":\"\"},{\"label\":\"Off Black\",\"value\":\"-dark-background\",\"default\":\"\"}]}','2018-11-06 19:29:37','2018-12-07 19:34:19','fb2fb216-c076-435d-b399-bb0c92cbc106'),
	(4,NULL,'Background Image','backgroundImage','matrixBlockType:1','Optional background image for the section. This image will override the selected background color.','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"folder:1\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add a Background Image\",\"localizeRelations\":false}','2018-11-06 19:29:37','2018-12-07 19:34:19','d3f64f5e-8d98-4cfe-bc55-10e5c2497fff'),
	(5,NULL,'Background Video','backgroundVideo','matrixBlockType:1','Optional background video for the section. This video will override the selected background color and image.','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:2\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"video\"],\"sources\":[\"folder:2\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add a Background Video\",\"localizeRelations\":false}','2018-11-06 19:35:22','2018-12-07 19:34:19','36459edb-92eb-4e49-b582-883cd750f9fd'),
	(6,NULL,'Copy','copy','matrixBlockType:2','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-11-06 19:54:25','2018-12-07 19:34:19','c1466ef0-df37-4a2f-9ecb-82d6e9b3a223'),
	(7,NULL,'Font Size','fontSize','matrixBlockType:2','How large should the font be?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Huge\",\"value\":\"o-h1\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"o-h2\",\"default\":\"\"},{\"label\":\"Medium\",\"value\":\"o-h3\",\"default\":\"1\"},{\"label\":\"Small\",\"value\":\"o-h4\",\"default\":\"\"},{\"label\":\"Title\",\"value\":\"o-h5\",\"default\":\"\"},{\"label\":\"Subtitle\",\"value\":\"o-h6\",\"default\":\"\"}]}','2018-11-06 19:54:26','2018-12-07 19:34:19','d6747373-70b8-49ad-82bd-33370282ee35'),
	(8,NULL,'Alignment','alignment','matrixBlockType:2','How should the heading be aligned?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Left\",\"value\":\"u-text-left\",\"default\":\"1\"},{\"label\":\"Center\",\"value\":\"u-text-center\",\"default\":\"\"},{\"label\":\"Right\",\"value\":\"u-text-right\",\"default\":\"\"}]}','2018-11-06 19:54:26','2018-12-07 19:34:19','4421109a-d1a4-4e10-b64a-87b84b5a3773'),
	(10,NULL,'Padding','padding','matrixBlockType:2','Add padding to the block.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-11-06 19:58:42','2018-12-07 19:34:19','f16ece4b-b4a4-4532-9b03-305f0e107a9d'),
	(11,NULL,'Overlay','overlay','matrixBlockType:1','Select an optional overlay for your background video or image.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"none\",\"default\":\"1\"},{\"label\":\"Light\",\"value\":\"35,35,35,0.33\",\"default\":\"\"},{\"label\":\"Medium\",\"value\":\"35,35,35,0.6\",\"default\":\"\"},{\"label\":\"Dark\",\"value\":\"35,35,35,0.87\",\"default\":\"\"}]}','2018-11-06 20:10:38','2018-12-07 19:34:19','c043d1ea-bbda-4790-9b09-ca031caf54d4'),
	(14,NULL,'Width','width','matrixBlockType:3','How wide should this sections container be?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Normal\",\"value\":\"o-container\",\"default\":\"\"},{\"label\":\"Narrow\",\"value\":\"o-container-narrow\",\"default\":\"\"},{\"label\":\"Full\",\"value\":\"o-container-full\",\"default\":\"\"}]}','2018-11-07 13:26:27','2018-12-07 19:34:19','bbe771e9-89c0-4471-936a-5ebecf254b9b'),
	(15,NULL,'Column Layout','columnLayout','matrixBlockType:3','Please select a column layout pattern.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Whole\",\"value\":\"1\",\"default\":\"1\"},{\"label\":\"Halves\",\"value\":\"2\",\"default\":\"\"},{\"label\":\"Thirds\",\"value\":\"3\",\"default\":\"\"},{\"label\":\"1/3 & 2/3\",\"value\":\"4\",\"default\":\"\"},{\"label\":\"2/3 & 1/3\",\"value\":\"5\",\"default\":\"\"}]}','2018-11-07 13:26:27','2018-12-07 19:34:19','a74d8612-5ca0-4325-9e7a-903893117219'),
	(16,NULL,'Column Gutter','columnGutter','matrixBlockType:3','How large of a gap between columns do you want?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-gutter-none\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"-gutter\",\"default\":\"\"},{\"label\":\"Small\",\"value\":\"-gutter-small\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-gutter-large\",\"default\":\"1\"}]}','2018-11-07 14:16:46','2018-12-07 19:34:19','27da4f8a-238c-4681-b862-712689ec9187'),
	(17,NULL,'Vertical Align','verticalAlign','matrixBlockType:3','','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Normal\",\"value\":\"-align-top\",\"default\":\"1\"},{\"label\":\"Middle\",\"value\":\"-align-center\",\"default\":\"\"},{\"label\":\"Bottom\",\"value\":\"-align-end\",\"default\":\"\"}]}','2018-11-20 20:35:00','2018-12-07 19:34:19','0318fd31-af0c-42d5-8f82-bda65318cbd2'),
	(18,NULL,'Body','body','matrixBlockType:5','','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Complex-Content.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"\",\"availableTransforms\":\"*\"}','2018-11-21 13:02:30','2018-12-07 19:34:19','9d5e8bb8-07be-40ec-803f-8296fa980c92'),
	(19,NULL,'Alignment','alignment','matrixBlockType:5','How should the copy in this block be aligned?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Left\",\"value\":\"u-text-left\",\"default\":\"1\"},{\"label\":\"Center\",\"value\":\"u-text-center\",\"default\":\"\"},{\"label\":\"Right\",\"value\":\"u-text-right\",\"default\":\"\"},{\"label\":\"Justify\",\"value\":\"u-text-justify\",\"default\":\"\"}]}','2018-11-21 13:02:30','2018-12-07 19:34:19','799dbe03-d659-4f0d-8598-926a4ddb37c0'),
	(20,NULL,'Padding','padding','matrixBlockType:5','Add padding to the block.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"1\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-11-21 13:02:30','2018-12-07 19:34:19','d85da825-7ece-4810-af33-232c2cddf7d5'),
	(21,NULL,'Image','image','matrixBlockType:6','','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"folder:1\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add an Image\",\"localizeRelations\":false}','2018-11-21 13:26:58','2018-12-07 19:34:19','34b63d30-e96e-4923-8396-7f331ac44ccd'),
	(22,NULL,'Aspect Ratio','aspectRatio','matrixBlockType:6','','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"16:9\",\"value\":\"u-ratio-16/9\",\"default\":\"1\"},{\"label\":\"1:1\",\"value\":\"u-ratio-1/1\",\"default\":\"\"},{\"label\":\"4:3\",\"value\":\"u-ratio-4/3\",\"default\":\"\"},{\"label\":\"2:3\",\"value\":\"u-ratio-2/3\",\"default\":\"\"},{\"label\":\"Banner\",\"value\":\"u-ratio-36/10\",\"default\":\"\"},{\"label\":\"None\",\"value\":\"none\",\"default\":\"\"}]}','2018-11-21 13:26:58','2018-12-07 19:34:19','d81bf538-6c2f-47cb-a776-ffda5ecb3da1'),
	(23,NULL,'Padding','padding','matrixBlockType:6','Add padding to the block.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-11-21 13:26:58','2018-12-07 19:34:20','efaf6859-2c1a-4909-bc9e-38bd725624ec'),
	(24,NULL,'Enable Lightcase','enableLightcase','matrixBlockType:6','When enabled users can click on the image to view a larger version of the image in a popup modal.','none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"\"}','2018-11-21 13:26:58','2018-12-07 19:34:20','89593cd3-f8b6-4c0d-9060-e2e0eb2dde8e'),
	(25,NULL,'Overlay','overlay','matrixBlockType:6','Select an optional overlay color for your image.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"none\",\"default\":\"1\"},{\"label\":\"Light\",\"value\":\"35,35,35,0.33\",\"default\":\"\"},{\"label\":\"Medium\",\"value\":\"35,35,35,0.6\",\"default\":\"\"},{\"label\":\"Dark\",\"value\":\"35,35,35,0.87\",\"default\":\"\"},{\"label\":\"Red\",\"value\":\"242,86,82,0.6\",\"default\":\"\"}]}','2018-11-21 13:26:58','2018-12-07 19:34:20','a23aaf6c-855c-4031-b283-e5076716fa3a'),
	(28,NULL,'Padding','padding','matrixBlockType:1','Add padding to the section.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"1\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"}]}','2018-11-27 13:19:20','2018-12-07 19:34:19','af04a3f1-22e2-4182-a22d-c6a44383b788'),
	(29,NULL,'Padding Size','paddingSize','matrixBlockType:2','How thick is the padding?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Thin\",\"value\":\"-thin\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Huge\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-11-27 13:19:20','2018-12-07 19:34:19','93f6127f-2098-4d92-89a9-6c353bb22799'),
	(30,NULL,'Padding Size','paddingSize','matrixBlockType:5','How thick is the padding?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Thin\",\"value\":\"-thin\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Huge\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-11-27 13:32:54','2018-12-07 19:34:19','46892785-d8f7-443a-9215-a6fbbfc2e066'),
	(31,NULL,'Padding Size','paddingSize','matrixBlockType:6','How thick is the padding?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Thin\",\"value\":\"-thin\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Huge\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-11-27 13:32:54','2018-12-07 19:34:20','71df45f7-bad9-4989-8d4b-8e056b6e712a'),
	(33,NULL,'Crop Zoom','cropZoom','matrixBlockType:6','','none',NULL,'craft\\fields\\Number','{\"defaultValue\":\"1\",\"min\":\"1\",\"max\":\"3\",\"decimals\":\"2\",\"size\":null}','2018-11-27 14:32:43','2018-12-07 19:34:20','33b35b3f-2dee-492a-b10e-ae7ef65688f9'),
	(34,NULL,'Image Width','imageWidth','matrixBlockType:6','','none',NULL,'craft\\fields\\Number','{\"defaultValue\":\"840\",\"min\":\"250\",\"max\":\"1920\",\"decimals\":0,\"size\":null}','2018-11-27 14:39:05','2018-12-07 19:34:20','1393ae5b-e051-4f54-9c23-fea61b8ef0fe'),
	(35,NULL,'Grayscale','grayscale','matrixBlockType:6','Enable to convert the image to grayscale.','none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"\"}','2018-11-27 15:23:01','2018-12-07 19:34:20','a5c58651-f39a-4384-a7c6-28ad2390f2e9'),
	(36,NULL,'Padding','padding','matrixBlockType:3','Add padding to the container.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"1\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"}]}','2018-11-27 16:34:59','2018-12-07 19:34:19','4c98e4da-8268-4e63-be65-60c159ffde69'),
	(37,NULL,'Padding Size','paddingSize','matrixBlockType:3','How thick is the containers padding?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Huge\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-11-28 16:58:20','2018-12-07 19:34:19','a8818a76-5083-4143-95ac-e666c321a091'),
	(38,NULL,'Padding Size','paddingSize','matrixBlockType:1','How thick is the sections padding?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x4\",\"default\":\"1\"},{\"label\":\"Huge\",\"value\":\"-x6\",\"default\":\"\"},{\"label\":\"Massive\",\"value\":\"-x8\",\"default\":\"\"}]}','2018-11-28 17:47:23','2018-12-07 19:34:19','d939cdb6-5f72-48ee-b805-f16dde284b4a'),
	(39,NULL,'Buttons','buttons','matrixBlockType:7','Add call to action buttons.','site',NULL,'verbb\\supertable\\fields\\SuperTableField','{\"minRows\":\"1\",\"maxRows\":\"3\",\"localizeBlocks\":false,\"staticField\":\"\",\"columns\":{\"40\":{\"width\":\"\"},\"41\":{\"width\":\"\"}},\"contentTable\":null,\"fieldLayout\":\"matrix\",\"selectionLabel\":\"Add a Button\"}','2018-11-28 19:07:47','2018-12-07 19:34:20','16afd3ef-94de-4db2-87a1-26b358f4aa61'),
	(40,NULL,'Link','buttonLink','superTableBlockType:1','Where should the button take the user?','none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"1\",\"allowedLinkNames\":{\"1\":\"asset\",\"2\":\"category\",\"3\":\"entry\",\"6\":\"custom\",\"7\":\"email\",\"8\":\"tel\",\"9\":\"url\"},\"allowTarget\":\"1\",\"defaultLinkName\":\"entry\",\"defaultText\":\"\",\"enableAriaLabel\":\"\",\"enableTitle\":\"\",\"typeSettings\":{\"asset\":{\"sources\":\"*\"},\"category\":{\"sources\":\"*\"},\"entry\":{\"sources\":\"*\"},\"site\":{\"sites\":\"*\"},\"user\":{\"sources\":\"*\"},\"custom\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"email\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"tel\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"url\":{\"disableValidation\":\"\",\"allowAliases\":\"\"}}}','2018-11-28 19:07:47','2018-12-07 19:34:20','42cf42aa-aed4-47d0-b3f9-8ee81b134df4'),
	(41,NULL,'Button Style','buttonStyle','superTableBlockType:1','How should the button look?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Basic Action Button\",\"value\":\"-base\",\"default\":\"1\"},{\"label\":\"Solid Style Button\",\"value\":\"-solid\",\"default\":\"\"},{\"label\":\"Outline Style Button\",\"value\":\"-outline\",\"default\":\"\"},{\"label\":\"Raised Style Button\",\"value\":\"-raised\",\"default\":\"\"},{\"label\":\"Rounded Solid Style Button\",\"value\":\"-solid -round\",\"default\":\"\"},{\"label\":\"Rounded Outline Style Button\",\"value\":\"-outline -round\",\"default\":\"\"}]}','2018-11-28 19:07:47','2018-12-07 19:34:20','ee572988-84e1-46e8-8b29-c23ce20bac43'),
	(42,NULL,'Alignment','alignment','matrixBlockType:7','How should the buttons be aligned?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Left Aligned\",\"value\":\"\",\"default\":\"1\"},{\"label\":\"Center Aligned\",\"value\":\"-justify-center\",\"default\":\"\"},{\"label\":\"Right Aligned\",\"value\":\"-justify-end\",\"default\":\"\"},{\"label\":\"Space Between\",\"value\":\"-space-between\",\"default\":\"\"},{\"label\":\"Space Around\",\"value\":\"-space-around\",\"default\":\"\"}]}','2018-11-28 19:14:56','2018-12-07 19:34:20','972a946c-797a-4f9c-8681-aaa29ef67856'),
	(43,NULL,'Padding Size','paddingSize','matrixBlockType:7','How thick is the padding?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Thin\",\"value\":\"-thin\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Huge\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-11-28 19:14:56','2018-12-07 19:34:20','afa0d0fd-406e-4d41-9c96-e5f5d59b058f'),
	(44,NULL,'Padding','padding','matrixBlockType:7','Add padding to the block.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"1\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Buttom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-11-28 19:14:56','2018-12-07 19:34:20','1d7cea56-a8d6-4502-874c-779e624b3bf5'),
	(45,NULL,'Image Alignment','imageAlignment','matrixBlockType:6','Align applied to images with an Aspect Ratio of None.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Left\",\"value\":\"u-text-left\",\"default\":\"\"},{\"label\":\"Center\",\"value\":\"u-text-center\",\"default\":\"1\"},{\"label\":\"Right\",\"value\":\"u-text-right\",\"default\":\"\"}]}','2018-11-29 13:19:25','2018-12-07 19:34:20','ab8da4d3-dc99-4cb3-a978-347132b072ca'),
	(46,NULL,'Body','body','matrixBlockType:8','','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-11-29 13:45:52','2018-12-07 19:34:20','71e1aa18-0063-405d-955e-74b5ec1514b2'),
	(47,NULL,'Source','source','matrixBlockType:8','Optional source or author for the quote.','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-11-29 13:45:52','2018-12-07 19:34:20','cbdbc09b-11a0-4b1a-a0bd-5b991c3c75eb'),
	(48,NULL,'Padding Size','paddingSize','matrixBlockType:8','How thick is the padding?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Thin\",\"value\":\"-thin\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Huge\",\"value\":\"-x4\",\"default\":\"\"},{\"label\":\"Massive\",\"value\":\"-x6\",\"default\":\"\"}]}','2018-11-29 13:45:52','2018-12-07 19:34:20','ebbd92ad-ec15-4d07-ae91-eccbb307569b'),
	(49,NULL,'Padding','padding','matrixBlockType:8','Add padding to the block.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"1\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-11-29 13:45:52','2018-12-07 19:34:20','f544af32-b279-49f9-9fa4-60c1d0391b85'),
	(50,NULL,'Quote Style','quoteStyle','matrixBlockType:8','Select a quote block style.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Large\",\"value\":\"-large\",\"default\":\"1\"},{\"label\":\"Block\",\"value\":\"-block\",\"default\":\"\"}]}','2018-11-29 14:19:38','2018-12-07 19:34:20','984c9a76-6153-41af-9f4b-fbff36a88709'),
	(51,NULL,'Slides','slides','matrixBlockType:9','Add slides to the gallery.','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"folder:1\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"\",\"selectionLabel\":\"Add an Image\",\"localizeRelations\":false}','2018-11-29 16:00:58','2018-12-07 19:34:20','00ccd03b-0a70-4fed-a14d-a0b846ecad51'),
	(52,NULL,'Image','image','superTableBlockType:2','Select or upload an image.','site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add an Image\",\"localizeRelations\":false}','2018-11-29 16:00:58','2018-11-29 19:01:53','c4dc3d58-6669-4037-840c-bc6369b067a3'),
	(53,NULL,'Padding Size','paddingSize','matrixBlockType:9','How thick is the padding?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Thin\",\"value\":\"-thin\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Huge\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-11-29 16:00:58','2018-12-07 19:34:20','0bf2b1b8-e3d3-47f7-bc51-628bd536b65c'),
	(54,NULL,'Padding','padding','matrixBlockType:9','Add padding to the block.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"1\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-11-29 16:00:58','2018-12-07 19:34:20','418c41b9-d777-4c60-b660-7f8421a7f12d'),
	(55,NULL,'Slide Transition','slideTransition','matrixBlockType:9','Select how fast the slides transition. Setting this option to manual forces the user initiate the transition.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Manual\",\"value\":\"-1\",\"default\":\"1\"},{\"label\":\"Slow\",\"value\":\"12\",\"default\":\"\"},{\"label\":\"Medium\",\"value\":\"7\",\"default\":\"\"},{\"label\":\"Fast\",\"value\":\"5\",\"default\":\"\"}]}','2018-11-29 16:00:58','2018-12-07 19:34:20','f40a44dd-80c9-41bd-92f8-11ea5934e78d'),
	(56,NULL,'Style','style','matrixBlockType:9','Select a gallery style.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Fade\",\"value\":\"fade\",\"default\":\"1\"},{\"label\":\"Slide\",\"value\":\"slide\",\"default\":\"\"},{\"label\":\"Stack\",\"value\":\"stack\",\"default\":\"\"},{\"label\":\"Parallax\",\"value\":\"parallax\",\"default\":\"\"}]}','2018-11-29 16:00:58','2018-12-07 19:34:20','0ed585b2-9d94-4ebc-a088-f12f4474ecf4'),
	(57,NULL,'Aspect Ratio','aspectRatio','matrixBlockType:9','Select the galleries aspect ratio.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"1:1\",\"value\":\"u-ratio-1/1\",\"default\":\"1\"},{\"label\":\"2:3\",\"value\":\"u-ratio-2/3\",\"default\":\"\"},{\"label\":\"16:9\",\"value\":\"u-ratio-16/9\",\"default\":\"\"}]}','2018-11-29 16:00:58','2018-12-07 19:34:20','3b24986d-c663-48f7-86ca-a778bebbcd82'),
	(58,NULL,'Headline','headline','superTableBlockType:2','Optional headline. Not use on every style.','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"120\",\"columnType\":\"text\"}','2018-11-29 18:37:00','2018-11-29 19:01:53','c4ef4072-bd1f-4447-8f21-b05a86657c4f'),
	(59,NULL,'Body','body','superTableBlockType:2','Optional body copy. Not use on every style.','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Complex-Content.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"\",\"availableTransforms\":\"*\"}','2018-11-29 18:37:00','2018-11-29 19:01:53','2ffc941a-e160-475b-af3f-66b7b9f49ff2'),
	(60,NULL,'Rows','rows','matrixBlockType:10','','site',NULL,'verbb\\supertable\\fields\\SuperTableField','{\"minRows\":\"\",\"maxRows\":\"\",\"localizeBlocks\":false,\"staticField\":\"\",\"columns\":{\"61\":{\"width\":\"\"},\"62\":{\"width\":\"\"},\"71\":{\"width\":\"\"},\"72\":{\"width\":\"\"},\"73\":{\"width\":\"\"}},\"contentTable\":null,\"fieldLayout\":\"row\",\"selectionLabel\":\"\"}','2018-12-07 12:52:41','2018-12-07 19:34:20','89bb2fb3-11df-43a8-bc0e-dc9282624357'),
	(61,NULL,'Heading','heading','superTableBlockType:3','What is the heading for this row?','none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"32\",\"columnType\":\"text\"}','2018-12-07 12:52:41','2018-12-07 19:34:20','c7b72005-a498-41f9-979d-67d815d408e3'),
	(62,NULL,'Body','body','superTableBlockType:3','Copy for the row.','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Basic.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"\",\"availableTransforms\":\"*\"}','2018-12-07 12:52:41','2018-12-07 19:34:20','a255042b-ffbc-48c6-87b5-dff502c8251d'),
	(63,NULL,'Padding Size','paddingSize','matrixBlockType:10','How thick is the padding?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Thin\",\"value\":\"-thin\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Huge\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-12-07 12:52:42','2018-12-07 19:34:20','5842ae73-b069-45a3-b28a-0149781ddbea'),
	(64,NULL,'Padding','padding','matrixBlockType:10','Add padding to the block.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"1\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Buttom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-12-07 12:52:42','2018-12-07 19:34:20','b5e83c8a-e3ac-4e7f-aa5b-ae31369fe8b2'),
	(65,NULL,'List Items','listItems','matrixBlockType:11','','site',NULL,'verbb\\supertable\\fields\\SuperTableField','{\"minRows\":\"1\",\"maxRows\":\"\",\"localizeBlocks\":false,\"staticField\":\"\",\"columns\":{\"66\":{\"width\":\"\"}},\"contentTable\":null,\"fieldLayout\":\"row\",\"selectionLabel\":\"\"}','2018-12-07 17:24:19','2018-12-07 19:34:21','9fcae5d9-54cc-4ce1-9ade-6fa31442abf1'),
	(66,NULL,'Item','item','superTableBlockType:4','','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Basic.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"\",\"availableTransforms\":\"*\"}','2018-12-07 17:24:19','2018-12-07 19:34:21','fc1bf467-a95f-4dff-99b8-b2e3ccb556d5'),
	(67,NULL,'Padding Size','paddingSize','matrixBlockType:11','How thick is the padding?','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Thin\",\"value\":\"-thin\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Huge\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-12-07 17:24:19','2018-12-07 19:34:21','0c87ae8e-ce72-414a-8f65-38af1031d8bc'),
	(68,NULL,'Padding','padding','matrixBlockType:11','Add padding to the block.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"1\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-12-07 17:24:19','2018-12-07 19:34:21','de8d5f7b-33fb-44be-b39a-2eab11dc3b9f'),
	(69,NULL,'Alignment','alignment','matrixBlockType:11','','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Left\",\"value\":\"u-text-left\",\"default\":\"1\"},{\"label\":\"Center\",\"value\":\"u-text-center\",\"default\":\"\"},{\"label\":\"Right\",\"value\":\"u-text-right\",\"default\":\"\"}]}','2018-12-07 17:46:02','2018-12-07 19:34:21','fd4b318a-37e0-4db3-b40c-bb76badfae2e'),
	(70,NULL,'List Style','listStyle','matrixBlockType:11','Select a style for the list.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Default\",\"value\":\"-default\",\"default\":\"1\"},{\"label\":\"Plus\",\"value\":\"-plus\",\"default\":\"\"}]}','2018-12-07 17:49:25','2018-12-07 19:34:21','462274cc-3cdd-49e8-83f2-c197f47959e8'),
	(71,NULL,'List','list','superTableBlockType:3','Optional list element for the row. The list will be placed below any body copy.','none',NULL,'craft\\fields\\Table','{\"addRowLabel\":\"Add a List Item\",\"maxRows\":\"18\",\"minRows\":\"0\",\"columns\":{\"col1\":{\"heading\":\"List Item\",\"handle\":\"listItem\",\"width\":\"\",\"type\":\"singleline\"}},\"defaults\":[],\"columnType\":\"text\"}','2018-12-07 18:04:27','2018-12-07 19:34:20','d5822862-1769-4f56-bdd9-03d7aeb583a1'),
	(72,NULL,'Split List','splitList','superTableBlockType:3','When enabled and the list contains items the list will be placed to the right of the body copy.','none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"\"}','2018-12-07 18:04:27','2018-12-07 19:34:20','43eacc7a-4e10-4194-875c-d90071579149'),
	(73,NULL,'List Style','listStyle','superTableBlockType:3','Select a list style type.','none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Default\",\"value\":\"-default\",\"default\":\"1\"},{\"label\":\"Plus\",\"value\":\"-plus\",\"default\":\"\"}]}','2018-12-07 19:09:38','2018-12-07 19:34:20','b337860e-6281-433f-aa69-2d01b5f8e912'),
	(74,NULL,'Multi Row','multiRow','matrixBlockType:10','When enabled users can open up several rows. When disabled when a user opens a row the previously opened row will be closed.','none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"\"}','2018-12-07 19:34:21','2018-12-07 19:34:21','f8b603ed-7622-42e8-a6ca-022ec1da1159');

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
  CONSTRAINT `freeform_submissions_formId_fk` FOREIGN KEY (`formId`) REFERENCES `pt_freeform_forms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `freeform_submissions_id_fk` FOREIGN KEY (`id`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `freeform_submissions_statusId_fk` FOREIGN KEY (`statusId`) REFERENCES `pt_freeform_statuses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



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

LOCK TABLES `pt_info` WRITE;
/*!40000 ALTER TABLE `pt_info` DISABLE KEYS */;

INSERT INTO `pt_info` (`id`, `version`, `schemaVersion`, `edition`, `timezone`, `name`, `on`, `maintenance`, `fieldVersion`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'3.0.36','3.0.94',0,'America/New_York','Papertrain Boilerplate',1,0,'MbUU3wns0nH1','2018-10-17 19:43:46','2019-01-09 23:57:50','bdebff9e-a915-4f72-a9be-e9715430bcd0');

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
	(1,1,3,'Section','sectionSettings',1,'2018-11-06 19:29:37','2018-12-07 19:34:19','9c7038b3-900d-4b50-a5ee-7c445a476f87'),
	(2,1,6,'Heading','heading',4,'2018-11-06 19:54:25','2018-12-07 19:34:19','e99be65c-5fee-4c83-9eed-8050793be42a'),
	(3,1,7,'Container','container',2,'2018-11-07 13:26:27','2018-12-07 19:34:19','27f153c6-09ef-408c-a85b-50ee37263d52'),
	(4,1,8,'End Column','endColumn',3,'2018-11-07 13:26:27','2018-12-07 19:34:19','8ca7c03d-aa9b-4611-b6be-6862e9a89ce1'),
	(5,1,9,'Copy','copy',5,'2018-11-21 13:02:29','2018-12-07 19:34:19','d40a8732-c577-4d4a-a737-05fa930be6a2'),
	(6,1,10,'Image','image',6,'2018-11-21 13:26:58','2018-12-07 19:34:20','8cfe5e31-20a9-4ddc-ba3d-790f1b405450'),
	(7,1,12,'Buttons','buttons',7,'2018-11-28 19:07:47','2018-12-07 19:34:20','86843e26-821b-41e7-8e3e-87321802c139'),
	(8,1,13,'Pull Quote','pullQuote',8,'2018-11-29 13:45:52','2018-12-07 19:34:20','42b013df-72dc-41a5-941f-d7a299502e38'),
	(9,1,15,'Gallery','gallery',9,'2018-11-29 16:00:58','2018-12-07 19:34:20','411496be-9759-4334-803e-790121fdee23'),
	(10,1,17,'Accordion','accordion',10,'2018-12-07 12:52:41','2018-12-07 19:34:21','2cb049e6-b35a-4271-8861-0bbde459b042'),
	(11,1,19,'List','list',11,'2018-12-07 17:24:19','2018-12-07 19:34:21','3bf9043f-ddd4-4d72-b83d-c984f46fdecf');

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
  `field_heading_padding` varchar(255) DEFAULT NULL,
  `field_sectionSettings_overlay` varchar(255) DEFAULT NULL,
  `field_container_width` varchar(255) DEFAULT NULL,
  `field_container_columnLayout` varchar(255) DEFAULT NULL,
  `field_container_columnGutter` varchar(255) DEFAULT NULL,
  `field_container_verticalAlign` varchar(255) DEFAULT NULL,
  `field_copy_body` text,
  `field_copy_alignment` varchar(255) DEFAULT NULL,
  `field_copy_padding` varchar(255) DEFAULT NULL,
  `field_image_aspectRatio` varchar(255) DEFAULT NULL,
  `field_image_padding` varchar(255) DEFAULT NULL,
  `field_image_enableLightcase` tinyint(1) DEFAULT NULL,
  `field_image_overlay` varchar(255) DEFAULT NULL,
  `field_sectionSettings_padding` varchar(255) DEFAULT NULL,
  `field_heading_paddingSize` varchar(255) DEFAULT NULL,
  `field_copy_paddingSize` varchar(255) DEFAULT NULL,
  `field_image_paddingSize` varchar(255) DEFAULT NULL,
  `field_image_cropZoom` decimal(3,2) DEFAULT NULL,
  `field_image_imageWidth` smallint(4) DEFAULT NULL,
  `field_image_grayscale` tinyint(1) DEFAULT NULL,
  `field_container_padding` varchar(255) DEFAULT NULL,
  `field_container_paddingSize` varchar(255) DEFAULT NULL,
  `field_sectionSettings_paddingSize` varchar(255) DEFAULT NULL,
  `field_buttons_alignment` varchar(255) DEFAULT NULL,
  `field_buttons_paddingSize` varchar(255) DEFAULT NULL,
  `field_buttons_padding` varchar(255) DEFAULT NULL,
  `field_image_imageAlignment` varchar(255) DEFAULT NULL,
  `field_pullQuote_body` text,
  `field_pullQuote_source` text,
  `field_pullQuote_paddingSize` varchar(255) DEFAULT NULL,
  `field_pullQuote_padding` varchar(255) DEFAULT NULL,
  `field_pullQuote_quoteStyle` varchar(255) DEFAULT NULL,
  `field_gallery_paddingSize` varchar(255) DEFAULT NULL,
  `field_gallery_padding` varchar(255) DEFAULT NULL,
  `field_gallery_slideTransition` varchar(255) DEFAULT NULL,
  `field_gallery_style` varchar(255) DEFAULT NULL,
  `field_gallery_aspectRatio` varchar(255) DEFAULT NULL,
  `field_accordion_paddingSize` varchar(255) DEFAULT NULL,
  `field_accordion_padding` varchar(255) DEFAULT NULL,
  `field_list_paddingSize` varchar(255) DEFAULT NULL,
  `field_list_padding` varchar(255) DEFAULT NULL,
  `field_list_alignment` varchar(255) DEFAULT NULL,
  `field_list_listStyle` varchar(255) DEFAULT NULL,
  `field_accordion_multiRow` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_cc_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_cc_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_cc_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `pt_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_cc_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `pt_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



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
	(121,5,'plugin','m181129_083939_ChangeIntegrationFieldTypeColumnTypeToString','2019-01-05 00:21:19','2019-01-05 00:21:19','2019-01-05 00:21:19','724cd663-2ea7-42a8-9eb9-b393564f2784');

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

LOCK TABLES `pt_plugins` WRITE;
/*!40000 ALTER TABLE `pt_plugins` DISABLE KEYS */;

INSERT INTO `pt_plugins` (`id`, `handle`, `version`, `schemaVersion`, `licenseKey`, `licenseKeyStatus`, `enabled`, `settings`, `installDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'eager-beaver','1.0.4','1.0.0',NULL,'unknown',1,NULL,'2018-11-06 19:48:48','2018-11-06 19:48:48','2019-01-09 23:58:11','75e3b61a-23b8-440d-9ca8-02214229f452'),
	(2,'imager','v2.1.3','2.0.0',NULL,'unknown',1,NULL,'2018-11-06 19:48:52','2018-11-06 19:48:52','2019-01-09 23:58:11','5880e16d-544d-40d8-a11e-18c07ee2cce6'),
	(3,'splash','3.0.2','3.0.0',NULL,'unknown',1,'{\"volume\":\"1\",\"authorField\":\"\",\"authorUrlField\":\"\",\"colorField\":\"\"}','2018-11-06 20:03:24','2018-11-06 20:03:24','2019-01-09 23:58:11','7c311bf3-2d90-42f0-9a51-a4c6d4ed7132'),
	(5,'freeform','2.5.7','2.1.3',NULL,'invalid',1,NULL,'2018-11-07 16:07:44','2018-11-07 16:07:44','2019-01-09 23:58:11','9010b6b3-f122-4d41-b17d-45d5d40ad60d'),
	(6,'redactor','2.1.7','2.0.0',NULL,'unknown',1,NULL,'2018-11-21 13:02:36','2018-11-21 13:02:36','2019-01-09 23:58:11','fd1449da-2f55-4f0a-9ee8-bedac1c9d5f1'),
	(7,'super-table','2.0.14','2.0.4',NULL,'unknown',1,NULL,'2018-11-28 19:02:30','2018-11-28 19:02:30','2019-01-09 23:58:11','728b3ecb-d511-457b-886b-d3fd46365966'),
	(8,'typedlinkfield','1.0.15','1.0.0',NULL,'unknown',1,NULL,'2018-11-28 19:02:32','2018-11-28 19:02:32','2019-01-09 23:58:11','e5f156c9-3384-4316-9e6d-25430506b1cd');

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
	('1298516d','@app/web/assets/updateswidget/dist'),
	('13ef96a3','@app/web/assets/generalsettings/dist'),
	('15a95a80','@app/web/assets/tablesettings/dist'),
	('171ea88d','@app/web/assets/updater/dist'),
	('17c363fb','@lib'),
	('17dbe43c','@lib/jquery.payment'),
	('1a73bca9','@bower/jquery/dist'),
	('1af88df','@craft/web/assets/plugins/dist'),
	('1b3e5648','@app/web/assets/edituser/dist'),
	('1c0afdac','@app/web/assets/craftsupport/dist'),
	('1c0b7320','@craft/web/assets/feed/dist'),
	('1c8334df','@app/web/assets/utilities/dist'),
	('1f11396e','@lib/jquery-ui'),
	('20f8adea','@lib/fabric'),
	('2241fa96','@lib/jquery.payment'),
	('231e4e64','@craft/web/assets/craftsupport/dist'),
	('238af62f','@app/web/assets/dashboard/dist'),
	('24bc9f51','@app/web/assets/cp/dist'),
	('24edd861','@app/web/assets/fields/dist'),
	('29192a75','@app/web/assets/utilities/dist'),
	('2b18f9a9','@craft/web/assets/login/dist'),
	('2c221303','@app/web/assets/recententries/dist'),
	('2cd0352','@app/web/assets/updater/dist'),
	('2e20b196','@vendor/craftcms/redactor/lib/redactor'),
	('2fe9a203','@bower/jquery/dist'),
	('316f348e','@app/web/assets/cp/dist'),
	('3279235a','@app/web/assets/feed/dist'),
	('32c342f','@app/web/assets/editentry/dist'),
	('355121f0','@app/web/assets/login/dist'),
	('35be79d4','@lib/garnishjs'),
	('35e3175c','@lib/element-resize-detector'),
	('3629699f','@app/web/assets/matrixsettings/dist'),
	('39716fcc','@lib/timepicker'),
	('39f1b8dc','@app/web/assets/recententries/dist'),
	('3c77395e','@app/web/assets/updates/dist'),
	('3e66557e','@lib/velocity'),
	('3f84d27a','@app/web/assets/pluginstore/dist'),
	('403755b6','@bower/jquery/dist'),
	('40745f49','@lib/fileupload'),
	('40d75ca3','@typedlinkfield/resources'),
	('446b0914','@lib/velocity'),
	('4555d071','@lib/jquery-ui'),
	('45ee97eb','@craft/web/assets/editentry/dist'),
	('46c7ddc0','@app/web/assets/utilities/dist'),
	('48747f30','@app/web/assets/feed/dist'),
	('4b6268e4','@app/web/assets/cp/dist'),
	('4d5a4192','@app/web/assets/updater/dist'),
	('4d9f0d23','@lib/jquery.payment'),
	('4f5c7d9a','@app/web/assets/login/dist'),
	('4fedb39f','@app/web/assets/tablesettings/dist'),
	('505a25cf','@app/web/assets/pluginstore/dist'),
	('51b8a2cb','@lib/velocity'),
	('5314761f','@app/web/assets/utilities/dist'),
	('5316249b','@app/web/assets/editentry/dist'),
	('537a2c16','@craft/redactor/assets/field/dist'),
	('539dbf6c','@app/web/assets/craftsupport/dist'),
	('55e4fe69','@bower/jquery/dist'),
	('562f4f69','@app/web/assets/recententries/dist'),
	('56397ee6','@lib/d3'),
	('56b4270d','@lib/xregexp'),
	('584ca6fc','@lib/jquery.payment'),
	('589c5eb7','@lib/picturefill'),
	('5a3e1840','@app/web/assets/tablesettings/dist'),
	('5c3406af','@app/web/assets/matrix/dist'),
	('5cd86387','@lib/selectize'),
	('5d0f13ad','@app/web/assets/updateswidget/dist'),
	('5da7d4ef','@app/web/assets/feed/dist'),
	('5dbe68fc','@lib/prismjs'),
	('5f386275','@lib/jquery-touch-events'),
	('6036e52','@lib/d3'),
	('6141bb3c','@app/web/assets/plugins/dist'),
	('63b551c3','@app/web/assets/recententries/dist'),
	('654855eb','@craft/web/assets/dashboard/dist'),
	('65846960','@lib/garnishjs'),
	('6607a1c6','@app/web/assets/craftsupport/dist'),
	('68950d07','@app/web/assets/updateswidget/dist'),
	('68e37b9','@lib/xregexp'),
	('694b7f78','@lib/timepicker'),
	('6c4d29ea','@app/web/assets/updates/dist'),
	('6c6d8080','@app/web/assets/matrixsettings/dist'),
	('6fa7fe43','@lib/element-resize-detector'),
	('70c2bd5e','@lib/fabric'),
	('70cfcedb','@lib/jquery-ui'),
	('73b0e69b','@app/web/assets/dashboard/dist'),
	('74d7c8d5','@app/web/assets/fields/dist'),
	('77c798b0','@verbb/supertable/resources/dist'),
	('781d944e','@lib'),
	('7909f6','@lib/element-resize-detector'),
	('79be2b5f','@app/web/assets/matrixsettings/dist'),
	('7a74559c','@lib/element-resize-detector'),
	('7a82b687','@craft/web/assets/matrixsettings/dist'),
	('7ac66330','@app/web/assets/login/dist'),
	('7e33df0','@app/web/assets/feed/dist'),
	('7ef8764e','@app/web/assets/cp/dist'),
	('7f590e50','@typedlinkfield/resources'),
	('82fcfaf2','@app/web/assets/utilities/dist'),
	('831f9f0b','@app/web/assets/updater/dist'),
	('840c7284','@bower/jquery/dist'),
	('84b2b86d','@craft/web/assets/updateswidget/dist'),
	('855d6fcc','@verbb/supertable/resources/dist'),
	('875cabe0','@lib/xregexp'),
	('886f26a8','@app/web/assets/dashboard/dist'),
	('89a42a11','@lib/jquery.payment'),
	('8a64e03','@lib/picturefill'),
	('8b100ee8','@lib/jquery-ui'),
	('8b1d7d6d','@lib/fabric'),
	('8bd694ad','@app/web/assets/tablesettings/dist'),
	('8d30ef6a','@lib/selectize'),
	('8e3181d0','@lib/fileupload'),
	('8f0808e6','@app/web/assets/fields/dist'),
	('917dbcec','@lib/jquery-touch-events'),
	('9271d836','@app/web/assets/matrix/dist'),
	('928f003f','@lib/xregexp'),
	('934acd34','@app/web/assets/updateswidget/dist'),
	('93fbb665','@lib/prismjs'),
	('958385f9','@lib/velocity'),
	('96d9802e','@lib/picturefill'),
	('9792e9d9','@app/web/assets/updates/dist'),
	('97b75181','@craft/web/assets/pluginstore/dist'),
	('987ca07f','@lib/d3'),
	('98e344b5','@lib/selectize'),
	('999cf3dd','@app/web/assets/feed/dist'),
	('9d53fa02','@app/web/assets/editentry/dist'),
	('9d95673','@app/web/assets/craftsupport/dist'),
	('9dd861f5','@app/web/assets/craftsupport/dist'),
	('9e5ba953','@lib/garnishjs'),
	('9ecc61fc','@craft/web/assets/cp/dist'),
	('a208f773','@app/web/assets/updates/dist'),
	('a3439e84','@lib/picturefill'),
	('a4e7a246','@lib/jquery-touch-events'),
	('a57a9c0e','@app/web/assets/plugins/dist'),
	('a856a7b2','@app/web/assets/matrixsettings/dist'),
	('ab9cd971','@lib/element-resize-detector'),
	('abc1b7f9','@lib/garnishjs'),
	('ac292b1','@lib/jquery-ui'),
	('ad70584a','@lib/timepicker'),
	('ade6bed5','@lib/d3'),
	('adf08f5a','@app/web/assets/recententries/dist'),
	('ae03ff0f','@ether/splash/resources'),
	('b0bda8d7','@app/web/assets/cp/dist'),
	('b3cbbc5c','@craft/web/assets/updater/dist'),
	('b483bda9','@app/web/assets/login/dist'),
	('b8a3f395','@lib/timepicker'),
	('ba08fa03','@craft/web/assets/recententries/dist'),
	('ba92164c','@app/web/assets/fields/dist'),
	('bbab9f7a','@lib/fileupload'),
	('bc692a07','@app/web/assets/deprecationerrors/dist'),
	('bdf53802','@app/web/assets/dashboard/dist'),
	('be8763c7','@lib/fabric'),
	('bfc4bd4','@lib/velocity'),
	('c0e161b','@app/web/assets/matrix/dist'),
	('c1a6c310','@lib/fileupload'),
	('c2384960','@lib/d3'),
	('c2a7adaa','@lib/selectize'),
	('c370dd80','@app/web/assets/updateswidget/dist'),
	('c4af134c','@app/web/assets/sites/dist'),
	('c5b9954d','@lib/velocity'),
	('c717131d','@app/web/assets/editentry/dist'),
	('c8353129','@app/web/assets/matrix/dist'),
	('c8cbe920','@lib/xregexp'),
	('c9a6e369','@app/web/assets/feed/dist'),
	('c9bf5f7a','@lib/prismjs'),
	('caa46bbb','@app/web/assets/plugins/dist'),
	('cb3955f3','@lib/jquery-touch-events'),
	('cc14f140','@craft/web/assets/tablesettings/dist'),
	('cc9d6931','@lib/picturefill'),
	('cce58d4f','@craft/web/assets/matrix/dist'),
	('cde27141','@app/web/assets/craftsupport/dist'),
	('ce27333','@lib/selectize'),
	('d17cb893','@app/web/assets/sites/dist'),
	('d2c6ea46','@app/web/assets/utilities/dist'),
	('d3258fbf','@app/web/assets/updater/dist'),
	('d4366230','@bower/jquery/dist'),
	('d47568cf','@lib/fileupload'),
	('d57b88d1','@app/web/assets/edituser/dist'),
	('d7ebe2bf','@lib/d3'),
	('d847848','@lib/prismjs'),
	('d94ec2ee','@lib/picturefill'),
	('d99e3aa5','@lib/jquery.payment'),
	('db2a1e5c','@lib/jquery-ui'),
	('dbec8419','@app/web/assets/tablesettings/dist'),
	('deeafe2c','@lib/jquery-touch-events'),
	('e087b863','@app/web/assets/cp/dist'),
	('e0d6ff53','@app/web/assets/fields/dist'),
	('e4064335','@craft/web/assets/fields/dist'),
	('e456f539','@lib/garnishjs'),
	('e4b9ad1d','@app/web/assets/login/dist'),
	('e4c38ad8','@lib/fabric'),
	('e7b1d11d','@app/web/assets/dashboard/dist'),
	('ed9fb5b3','@app/web/assets/updates/dist'),
	('f0272c1','@lib/jquery-touch-events'),
	('f1102107','@lib/fabric'),
	('f1855ee6','@lib/garnishjs'),
	('f2627ac2','@app/web/assets/dashboard/dist'),
	('f505548c','@app/web/assets/fields/dist'),
	('f734b155','@lib/timepicker'),
	('f73db300','@lib/selectize'),
	('f84c1e6c','@app/web/assets/updates/dist'),
	('f86cb706','@app/web/assets/matrixsettings/dist'),
	('fb3e48d3','@supercool/buttonbox/assetbundles/buttonbox/dist'),
	('fba6c9c5','@lib/element-resize-detector'),
	('fd51f78a','@lib/xregexp'),
	('fdca9fee','@app/web/assets/recententries/dist'),
	('ff3e7511','@app/web/assets/plugins/dist');

/*!40000 ALTER TABLE `pt_resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pt_routes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_routes`;

CREATE TABLE `pt_routes` (
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
  CONSTRAINT `routes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `pt_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



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
	(173,'slug',0,1,'');

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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_handle_unq_idx` (`handle`),
  UNIQUE KEY `sections_name_unq_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `pt_structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_sections` WRITE;
/*!40000 ALTER TABLE `pt_sections` DISABLE KEYS */;

INSERT INTO `pt_sections` (`id`, `structureId`, `name`, `handle`, `type`, `enableVersioning`, `propagateEntries`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,1,'Standard Pages','standardPages','structure',1,1,'2018-11-06 19:23:08','2018-11-20 20:01:32','b192f8ce-1e5a-495d-bb45-ede8cd1ad3d4');

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
	(23,1,'NXxhLbx-pmb4vnzP1Z7oXQZvmRS1sSCebWC_XV9CuBsuUjJs6FhCH7H0I18x15O-ou4kUwxPUx-DP9Ca5ZdWaw0jN9hSSO8ckt9b','2019-01-09 23:56:34','2019-01-09 23:58:10','b1435254-bea0-4fd0-869f-e7d0dbd36d41');

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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sitegroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_sitegroups` WRITE;
/*!40000 ALTER TABLE `pt_sitegroups` DISABLE KEYS */;

INSERT INTO `pt_sitegroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Papertrain Boilerplate','2018-10-17 19:43:46','2018-10-17 19:43:46','f5eb95d0-c53e-4630-b230-91539b9e08b2');

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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sites_handle_unq_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `pt_sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_sites` WRITE;
/*!40000 ALTER TABLE `pt_sites` DISABLE KEYS */;

INSERT INTO `pt_sites` (`id`, `groupId`, `primary`, `name`, `handle`, `language`, `hasUrls`, `baseUrl`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,'Papertrain Boilerplate','default','en-US',1,'@web/',1,'2018-10-17 19:43:46','2018-10-17 19:43:46','ac246379-14f1-440a-82f2-90ef2b3e6443');

/*!40000 ALTER TABLE `pt_sites` ENABLE KEYS */;
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
	(1,1,NULL,1,1,2,0,'2018-11-06 19:47:54','2019-01-05 00:07:41','768e310c-2faf-495b-8cea-ff69328cc355');

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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_structures` WRITE;
/*!40000 ALTER TABLE `pt_structures` DISABLE KEYS */;

INSERT INTO `pt_structures` (`id`, `maxLevels`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,2,'2018-11-06 19:23:08','2018-11-20 20:01:32','705621d5-28f2-4ec0-b53c-8500b2bb1fd8');

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
	(1,39,11,'2018-11-28 19:07:47','2018-12-07 19:34:20','e1d8381e-e9da-4f7a-897a-7ca3280e4deb'),
	(2,51,14,'2018-11-29 16:00:58','2018-11-29 19:01:53','bf867548-c6c8-4312-9ff6-501f221c53e8'),
	(3,60,16,'2018-12-07 12:52:41','2018-12-07 19:34:20','061368e4-5312-4599-93a2-c40f7165b4b6'),
	(4,65,18,'2018-12-07 17:24:19','2018-12-07 19:34:21','326dbc91-cc61-404b-ad31-73f972c6e3de');

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



# Dump of table pt_systemsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_systemsettings`;

CREATE TABLE `pt_systemsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(15) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemsettings_category_unq_idx` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_systemsettings` WRITE;
/*!40000 ALTER TABLE `pt_systemsettings` DISABLE KEYS */;

INSERT INTO `pt_systemsettings` (`id`, `category`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'email','{\"fromEmail\":\"no-reply@page.works\",\"fromName\":\"Papertrain Boilerplate\",\"template\":null,\"transportType\":\"craft\\\\mail\\\\transportadapters\\\\Sendmail\",\"transportSettings\":null}','2018-10-17 19:43:49','2018-11-20 20:03:10','79573005-19ff-4096-90e0-2b52de45cd28');

/*!40000 ALTER TABLE `pt_systemsettings` ENABLE KEYS */;
UNLOCK TABLES;


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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `taggroups_name_unq_idx` (`name`),
  UNIQUE KEY `taggroups_handle_unq_idx` (`handle`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `pt_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pt_tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pt_tags`;

CREATE TABLE `pt_tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
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
	(1,'kylea@page.works',NULL,'','','kylea@page.works','$2y$13$.tPQ1u13.ms0je3ZbN1jnOaMx4ummoMNCAhSbB338o.Cs/6zf4swK',1,0,0,0,'2019-01-09 23:56:34','::1',NULL,NULL,'2018-12-14 16:58:06',NULL,1,NULL,NULL,NULL,0,'2018-12-08 13:41:32','2018-10-17 19:43:49','2019-01-09 23:56:34','e44094df-7375-4fff-a0a5-d88d45bbefcb');

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
	(1,NULL,1,'Images','','2018-11-06 19:33:37','2018-11-06 19:33:37','eb2dafb2-9954-4850-9d47-56e2e80f3880'),
	(2,NULL,2,'Videos','','2018-11-06 19:33:56','2018-11-06 19:33:56','f1b1b0d9-4fde-4469-a030-603d50bb42d6'),
	(3,NULL,NULL,'Temporary source',NULL,'2018-11-06 20:04:20','2018-11-06 20:04:20','55f6a2d2-4d18-4c8b-9387-f81ab9601a1a'),
	(4,3,NULL,'user_1','user_1/','2018-11-06 20:04:20','2018-11-06 20:04:20','e58f2b68-05d5-4fce-aff6-fa34d0786b83');

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
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumes_name_unq_idx` (`name`),
  UNIQUE KEY `volumes_handle_unq_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `pt_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `pt_volumes` WRITE;
/*!40000 ALTER TABLE `pt_volumes` DISABLE KEYS */;

INSERT INTO `pt_volumes` (`id`, `fieldLayoutId`, `name`, `handle`, `type`, `hasUrls`, `url`, `settings`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,4,'Images','images','craft\\volumes\\Local',1,'@web/uploads/images','{\"path\":\"@webroot/uploads/images\"}',1,'2018-11-06 19:33:37','2018-11-06 19:33:37','ea6beeac-3da3-43fe-a530-47032076abb2'),
	(2,5,'Videos','videos','craft\\volumes\\Local',1,'@web/uploads/videos','{\"path\":\"@webroot/uploads/videos\"}',2,'2018-11-06 19:33:56','2018-11-06 19:33:56','02433cef-1aec-4478-8f75-f5570480c436');

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
  `colspan` tinyint(1) NOT NULL DEFAULT '0',
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
