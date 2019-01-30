# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.6.38)
# Database: craft_papertrain
# Generation Time: 2019-01-30 12:30:32 +0000
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
	(173,14,'verbb\\supertable\\elements\\SuperTableBlockElement',1,0,'2018-11-29 18:38:40','2018-11-30 12:48:00',NULL,'f53ccea7-3b11-4e1f-a4bf-15e0be9d691b');

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
	(2653,17,600,60,1,1,'2018-12-07 19:34:21','2018-12-07 19:34:21','5a7d90a1-335a-4ab3-966d-50a3eab149c5'),
	(2654,17,600,63,0,2,'2018-12-07 19:34:21','2018-12-07 19:34:21','9ca6c2d3-62d6-44e2-85f0-c525915bf974'),
	(2655,17,600,64,0,3,'2018-12-07 19:34:21','2018-12-07 19:34:21','9ff42e73-c0f5-4b86-b051-80e38f3d1604'),
	(2656,17,600,74,0,4,'2018-12-07 19:34:21','2018-12-07 19:34:21','cb351c03-3788-492f-be75-658a63b44878'),
	(2658,19,602,65,1,1,'2018-12-07 19:34:21','2018-12-07 19:34:21','1b2dab39-86b2-4a2a-8abc-c6019f322906'),
	(2659,19,602,67,0,2,'2018-12-07 19:34:21','2018-12-07 19:34:21','7539fb06-c116-4ed6-bcb1-5105bc581543'),
	(2660,19,602,68,0,3,'2018-12-07 19:34:21','2018-12-07 19:34:21','6d9578b4-a8e0-4bf4-824b-0189262c22c1'),
	(2661,19,602,69,0,4,'2018-12-07 19:34:21','2018-12-07 19:34:21','5ba138c6-877f-4c3e-b146-11a2ea798b75'),
	(2662,19,602,70,0,5,'2018-12-07 19:34:21','2018-12-07 19:34:21','d1f7baa9-fa23-4169-b4c3-8f35abad1d8f'),
	(2663,11,603,40,1,1,'2019-01-30 12:23:09','2019-01-30 12:23:09','8ff00a91-0e8c-4c28-a1a9-84ce054aa950'),
	(2664,11,603,41,0,2,'2019-01-30 12:23:09','2019-01-30 12:23:09','517ccf43-b27c-4649-8dac-670d0e5946fe'),
	(2665,16,604,61,1,1,'2019-01-30 12:23:09','2019-01-30 12:23:09','2db7ef40-58cd-4624-b7be-92305e836a7b'),
	(2666,16,604,62,0,2,'2019-01-30 12:23:09','2019-01-30 12:23:09','9995ed0b-795d-4a6d-9b39-fb3651f4b185'),
	(2667,16,604,71,0,3,'2019-01-30 12:23:09','2019-01-30 12:23:09','a8541e7b-b69c-46c0-9829-2e5b602dc588'),
	(2668,16,604,72,0,4,'2019-01-30 12:23:09','2019-01-30 12:23:09','f8284fc3-4c64-46ad-a835-a70f53a251f4'),
	(2669,16,604,73,0,5,'2019-01-30 12:23:09','2019-01-30 12:23:09','2e22aeb1-ce66-4a84-917f-4e5629b0e952'),
	(2670,18,605,66,1,1,'2019-01-30 12:23:09','2019-01-30 12:23:09','68128f8a-fa38-4b59-a3bc-861376a09ef4');

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
	(3,'craft\\elements\\MatrixBlock','2018-11-06 19:29:37','2018-12-07 19:34:19',NULL,'cccaf184-6482-40a9-bdc8-acaaebe6917f'),
	(4,'craft\\elements\\Asset','2018-11-06 19:33:37','2018-11-06 19:33:37',NULL,'47c48e31-d23e-4089-b483-3ecfc95a95b0'),
	(5,'craft\\elements\\Asset','2018-11-06 19:33:56','2018-11-06 19:33:56',NULL,'ecfdc16e-4402-41a4-a5af-09785582316a'),
	(6,'craft\\elements\\MatrixBlock','2018-11-06 19:54:26','2018-12-07 19:34:19',NULL,'39856f0c-11eb-4fe4-a60d-07e698ae181c'),
	(7,'craft\\elements\\MatrixBlock','2018-11-07 13:26:27','2018-12-07 19:34:19',NULL,'cb1fed6a-0e67-4c84-8d89-ebba225f2dad'),
	(8,'craft\\elements\\MatrixBlock','2018-11-07 13:26:27','2018-12-07 19:34:19',NULL,'4455065f-9480-4863-8fad-e12f4b0ddf84'),
	(9,'craft\\elements\\MatrixBlock','2018-11-21 13:02:30','2018-12-07 19:34:19',NULL,'4b28f1e5-4fd6-4d61-af99-5adc926b4e45'),
	(10,'craft\\elements\\MatrixBlock','2018-11-21 13:26:58','2018-12-07 19:34:20',NULL,'93482697-e9bb-4748-bd38-cd3eb28b0f93'),
	(11,'verbb\\supertable\\elements\\SuperTableBlockElement','2018-11-28 19:07:47','2019-01-30 12:23:09',NULL,'975abb82-2d2e-45a0-8cef-bb19c73b3d2e'),
	(12,'craft\\elements\\MatrixBlock','2018-11-28 19:07:47','2018-12-07 19:34:20',NULL,'e17d5a6b-1851-4037-9aba-45296cc932dc'),
	(13,'craft\\elements\\MatrixBlock','2018-11-29 13:45:52','2018-12-07 19:34:20',NULL,'cbe6b628-b4ac-4766-88ff-b47c38af7989'),
	(14,'verbb\\supertable\\elements\\SuperTableBlockElement','2018-11-29 16:00:58','2018-11-29 19:01:53',NULL,'4060b2d8-29a2-42b7-b12d-1af66e985375'),
	(15,'craft\\elements\\MatrixBlock','2018-11-29 16:00:58','2018-12-07 19:34:20',NULL,'57b3a20d-8b2a-4bce-a97d-b60a88dc71d9'),
	(16,'verbb\\supertable\\elements\\SuperTableBlockElement','2018-12-07 12:52:41','2019-01-30 12:23:09',NULL,'0ff68a13-d28a-4bab-bfdd-ea638bb9166b'),
	(17,'craft\\elements\\MatrixBlock','2018-12-07 12:52:42','2018-12-07 19:34:21',NULL,'94c10d74-960d-479e-85fd-ece5fa16eaeb'),
	(18,'verbb\\supertable\\elements\\SuperTableBlockElement','2018-12-07 17:24:19','2019-01-30 12:23:09',NULL,'89001764-e066-4ae4-91cb-a4eaf6d519aa'),
	(19,'craft\\elements\\MatrixBlock','2018-12-07 17:24:19','2018-12-07 19:34:21',NULL,'54e4b974-31e5-45f1-80c3-8074ec779330');

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
	(596,12,'Content',1,'2018-12-07 19:34:20','2018-12-07 19:34:20','3ccc2c8f-bdca-4bd0-992c-c56f4aff35fd'),
	(597,13,'Content',1,'2018-12-07 19:34:20','2018-12-07 19:34:20','c4ecc384-9ccb-42be-82f2-4ca9836d0b80'),
	(598,15,'Content',1,'2018-12-07 19:34:20','2018-12-07 19:34:20','caf14cbf-4639-4251-bebd-a6715f81c3cd'),
	(600,17,'Content',1,'2018-12-07 19:34:21','2018-12-07 19:34:21','5c008fae-621b-4935-9f29-20a3c1241677'),
	(602,19,'Content',1,'2018-12-07 19:34:21','2018-12-07 19:34:21','531cb916-c28b-4ca3-b465-5b6b3b698cce'),
	(603,11,'Content',1,'2019-01-30 12:23:09','2019-01-30 12:23:09','5a4e68d7-b25d-4332-bdf6-07d3a5ef1c97'),
	(604,16,'Content',1,'2019-01-30 12:23:09','2019-01-30 12:23:09','5cd41bb3-a678-43f8-afb8-c2dea84ffc96'),
	(605,18,'Content',1,'2019-01-30 12:23:09','2019-01-30 12:23:09','c072e8da-eac4-442c-8ca3-05e3adb5695e');

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
	(1,1,'Complex Content','cc','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"contentTable\":\"{{%matrixcontent_cc}}\",\"localizeBlocks\":false}','2018-11-06 19:29:37','2018-12-07 19:34:19','d1fe1a49-a8bf-46ab-ac74-d563effe3be7'),
	(3,NULL,'Background Color','backgroundColor','matrixBlockType:9c7038b3-900d-4b50-a5ee-7c445a476f87','Please select this sections background color.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"White\",\"value\":\"-primary-background\",\"default\":\"1\"},{\"label\":\"Off White\",\"value\":\"-secondary-background\",\"default\":\"\"},{\"label\":\"Off Black\",\"value\":\"-dark-background\",\"default\":\"\"}]}','2018-11-06 19:29:37','2018-12-07 19:34:19','fb2fb216-c076-435d-b399-bb0c92cbc106'),
	(4,NULL,'Background Image','backgroundImage','matrixBlockType:9c7038b3-900d-4b50-a5ee-7c445a476f87','Optional background image for the section. This image will override the selected background color.',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:eb2dafb2-9954-4850-9d47-56e2e80f3880\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:eb2dafb2-9954-4850-9d47-56e2e80f3880\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"folder:eb2dafb2-9954-4850-9d47-56e2e80f3880\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add a Background Image\",\"localizeRelations\":false}','2018-11-06 19:29:37','2018-12-07 19:34:19','d3f64f5e-8d98-4cfe-bc55-10e5c2497fff'),
	(5,NULL,'Background Video','backgroundVideo','matrixBlockType:9c7038b3-900d-4b50-a5ee-7c445a476f87','Optional background video for the section. This video will override the selected background color and image.',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:f1b1b0d9-4fde-4469-a030-603d50bb42d6\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:eb2dafb2-9954-4850-9d47-56e2e80f3880\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"video\"],\"sources\":[\"folder:f1b1b0d9-4fde-4469-a030-603d50bb42d6\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add a Background Video\",\"localizeRelations\":false}','2018-11-06 19:35:22','2018-12-07 19:34:19','36459edb-92eb-4e49-b582-883cd750f9fd'),
	(6,NULL,'Copy','copy','matrixBlockType:e99be65c-5fee-4c83-9eed-8050793be42a','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-11-06 19:54:25','2018-12-07 19:34:19','c1466ef0-df37-4a2f-9ecb-82d6e9b3a223'),
	(7,NULL,'Font Size','fontSize','matrixBlockType:e99be65c-5fee-4c83-9eed-8050793be42a','How large should the font be?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Huge\",\"value\":\"o-h1\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"o-h2\",\"default\":\"\"},{\"label\":\"Medium\",\"value\":\"o-h3\",\"default\":\"1\"},{\"label\":\"Small\",\"value\":\"o-h4\",\"default\":\"\"},{\"label\":\"Title\",\"value\":\"o-h5\",\"default\":\"\"},{\"label\":\"Subtitle\",\"value\":\"o-h6\",\"default\":\"\"}]}','2018-11-06 19:54:26','2018-12-07 19:34:19','d6747373-70b8-49ad-82bd-33370282ee35'),
	(8,NULL,'Alignment','alignment','matrixBlockType:e99be65c-5fee-4c83-9eed-8050793be42a','How should the heading be aligned?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Left\",\"value\":\"u-text-left\",\"default\":\"1\"},{\"label\":\"Center\",\"value\":\"u-text-center\",\"default\":\"\"},{\"label\":\"Right\",\"value\":\"u-text-right\",\"default\":\"\"}]}','2018-11-06 19:54:26','2018-12-07 19:34:19','4421109a-d1a4-4e10-b64a-87b84b5a3773'),
	(10,NULL,'Padding','padding','matrixBlockType:e99be65c-5fee-4c83-9eed-8050793be42a','Add padding to the block.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-11-06 19:58:42','2018-12-07 19:34:19','f16ece4b-b4a4-4532-9b03-305f0e107a9d'),
	(11,NULL,'Overlay','overlay','matrixBlockType:9c7038b3-900d-4b50-a5ee-7c445a476f87','Select an optional overlay for your background video or image.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"none\",\"default\":\"1\"},{\"label\":\"Light\",\"value\":\"35,35,35,0.33\",\"default\":\"\"},{\"label\":\"Medium\",\"value\":\"35,35,35,0.6\",\"default\":\"\"},{\"label\":\"Dark\",\"value\":\"35,35,35,0.87\",\"default\":\"\"}]}','2018-11-06 20:10:38','2018-12-07 19:34:19','c043d1ea-bbda-4790-9b09-ca031caf54d4'),
	(14,NULL,'Width','width','matrixBlockType:27f153c6-09ef-408c-a85b-50ee37263d52','How wide should this sections container be?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Normal\",\"value\":\"o-container\",\"default\":\"\"},{\"label\":\"Narrow\",\"value\":\"o-container-narrow\",\"default\":\"\"},{\"label\":\"Full\",\"value\":\"o-container-full\",\"default\":\"\"}]}','2018-11-07 13:26:27','2018-12-07 19:34:19','bbe771e9-89c0-4471-936a-5ebecf254b9b'),
	(15,NULL,'Column Layout','columnLayout','matrixBlockType:27f153c6-09ef-408c-a85b-50ee37263d52','Please select a column layout pattern.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Whole\",\"value\":\"1\",\"default\":\"1\"},{\"label\":\"Halves\",\"value\":\"2\",\"default\":\"\"},{\"label\":\"Thirds\",\"value\":\"3\",\"default\":\"\"},{\"label\":\"1/3 & 2/3\",\"value\":\"4\",\"default\":\"\"},{\"label\":\"2/3 & 1/3\",\"value\":\"5\",\"default\":\"\"}]}','2018-11-07 13:26:27','2018-12-07 19:34:19','a74d8612-5ca0-4325-9e7a-903893117219'),
	(16,NULL,'Column Gutter','columnGutter','matrixBlockType:27f153c6-09ef-408c-a85b-50ee37263d52','How large of a gap between columns do you want?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-gutter-none\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"-gutter\",\"default\":\"\"},{\"label\":\"Small\",\"value\":\"-gutter-small\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-gutter-large\",\"default\":\"1\"}]}','2018-11-07 14:16:46','2018-12-07 19:34:19','27da4f8a-238c-4681-b862-712689ec9187'),
	(17,NULL,'Vertical Align','verticalAlign','matrixBlockType:27f153c6-09ef-408c-a85b-50ee37263d52','',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Normal\",\"value\":\"-align-top\",\"default\":\"1\"},{\"label\":\"Middle\",\"value\":\"-align-center\",\"default\":\"\"},{\"label\":\"Bottom\",\"value\":\"-align-end\",\"default\":\"\"}]}','2018-11-20 20:35:00','2018-12-07 19:34:19','0318fd31-af0c-42d5-8f82-bda65318cbd2'),
	(18,NULL,'Body','body','matrixBlockType:d40a8732-c577-4d4a-a737-05fa930be6a2','',1,'none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Complex-Content.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"\",\"availableTransforms\":\"*\"}','2018-11-21 13:02:30','2019-01-30 12:23:09','9d5e8bb8-07be-40ec-803f-8296fa980c92'),
	(19,NULL,'Alignment','alignment','matrixBlockType:d40a8732-c577-4d4a-a737-05fa930be6a2','How should the copy in this block be aligned?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Left\",\"value\":\"u-text-left\",\"default\":\"1\"},{\"label\":\"Center\",\"value\":\"u-text-center\",\"default\":\"\"},{\"label\":\"Right\",\"value\":\"u-text-right\",\"default\":\"\"},{\"label\":\"Justify\",\"value\":\"u-text-justify\",\"default\":\"\"}]}','2018-11-21 13:02:30','2018-12-07 19:34:19','799dbe03-d659-4f0d-8598-926a4ddb37c0'),
	(20,NULL,'Padding','padding','matrixBlockType:d40a8732-c577-4d4a-a737-05fa930be6a2','Add padding to the block.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"1\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-11-21 13:02:30','2018-12-07 19:34:19','d85da825-7ece-4810-af33-232c2cddf7d5'),
	(21,NULL,'Image','image','matrixBlockType:8cfe5e31-20a9-4ddc-ba3d-790f1b405450','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:eb2dafb2-9954-4850-9d47-56e2e80f3880\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:eb2dafb2-9954-4850-9d47-56e2e80f3880\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"folder:eb2dafb2-9954-4850-9d47-56e2e80f3880\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add an Image\",\"localizeRelations\":false}','2018-11-21 13:26:58','2018-12-07 19:34:19','34b63d30-e96e-4923-8396-7f331ac44ccd'),
	(22,NULL,'Aspect Ratio','aspectRatio','matrixBlockType:8cfe5e31-20a9-4ddc-ba3d-790f1b405450','',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"16:9\",\"value\":\"u-ratio-16/9\",\"default\":\"1\"},{\"label\":\"1:1\",\"value\":\"u-ratio-1/1\",\"default\":\"\"},{\"label\":\"4:3\",\"value\":\"u-ratio-4/3\",\"default\":\"\"},{\"label\":\"2:3\",\"value\":\"u-ratio-2/3\",\"default\":\"\"},{\"label\":\"Banner\",\"value\":\"u-ratio-36/10\",\"default\":\"\"},{\"label\":\"None\",\"value\":\"none\",\"default\":\"\"}]}','2018-11-21 13:26:58','2018-12-07 19:34:19','d81bf538-6c2f-47cb-a776-ffda5ecb3da1'),
	(23,NULL,'Padding','padding','matrixBlockType:8cfe5e31-20a9-4ddc-ba3d-790f1b405450','Add padding to the block.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-11-21 13:26:58','2018-12-07 19:34:20','efaf6859-2c1a-4909-bc9e-38bd725624ec'),
	(24,NULL,'Enable Lightcase','enableLightcase','matrixBlockType:8cfe5e31-20a9-4ddc-ba3d-790f1b405450','When enabled users can click on the image to view a larger version of the image in a popup modal.',1,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"\"}','2018-11-21 13:26:58','2018-12-07 19:34:20','89593cd3-f8b6-4c0d-9060-e2e0eb2dde8e'),
	(25,NULL,'Overlay','overlay','matrixBlockType:8cfe5e31-20a9-4ddc-ba3d-790f1b405450','Select an optional overlay color for your image.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"none\",\"default\":\"1\"},{\"label\":\"Light\",\"value\":\"35,35,35,0.33\",\"default\":\"\"},{\"label\":\"Medium\",\"value\":\"35,35,35,0.6\",\"default\":\"\"},{\"label\":\"Dark\",\"value\":\"35,35,35,0.87\",\"default\":\"\"},{\"label\":\"Red\",\"value\":\"242,86,82,0.6\",\"default\":\"\"}]}','2018-11-21 13:26:58','2018-12-07 19:34:20','a23aaf6c-855c-4031-b283-e5076716fa3a'),
	(28,NULL,'Padding','padding','matrixBlockType:9c7038b3-900d-4b50-a5ee-7c445a476f87','Add padding to the section.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"1\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"}]}','2018-11-27 13:19:20','2018-12-07 19:34:19','af04a3f1-22e2-4182-a22d-c6a44383b788'),
	(29,NULL,'Padding Size','paddingSize','matrixBlockType:e99be65c-5fee-4c83-9eed-8050793be42a','How thick is the padding?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Thin\",\"value\":\"-thin\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Huge\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-11-27 13:19:20','2019-01-30 12:22:36','93f6127f-2098-4d92-89a9-6c353bb22799'),
	(30,NULL,'Padding Size','paddingSize','matrixBlockType:d40a8732-c577-4d4a-a737-05fa930be6a2','How thick is the padding?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Thin\",\"value\":\"-thin\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Huge\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-11-27 13:32:54','2019-01-30 12:22:36','46892785-d8f7-443a-9215-a6fbbfc2e066'),
	(31,NULL,'Padding Size','paddingSize','matrixBlockType:8cfe5e31-20a9-4ddc-ba3d-790f1b405450','How thick is the padding?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Thin\",\"value\":\"-thin\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Huge\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-11-27 13:32:54','2018-12-07 19:34:20','71df45f7-bad9-4989-8d4b-8e056b6e712a'),
	(33,NULL,'Crop Zoom','cropZoom','matrixBlockType:8cfe5e31-20a9-4ddc-ba3d-790f1b405450','',1,'none',NULL,'craft\\fields\\Number','{\"defaultValue\":\"1\",\"min\":\"1\",\"max\":\"3\",\"decimals\":\"2\",\"size\":null}','2018-11-27 14:32:43','2018-12-07 19:34:20','33b35b3f-2dee-492a-b10e-ae7ef65688f9'),
	(34,NULL,'Image Width','imageWidth','matrixBlockType:8cfe5e31-20a9-4ddc-ba3d-790f1b405450','',1,'none',NULL,'craft\\fields\\Number','{\"defaultValue\":\"840\",\"min\":\"250\",\"max\":\"1920\",\"decimals\":0,\"size\":null}','2018-11-27 14:39:05','2018-12-07 19:34:20','1393ae5b-e051-4f54-9c23-fea61b8ef0fe'),
	(35,NULL,'Grayscale','grayscale','matrixBlockType:8cfe5e31-20a9-4ddc-ba3d-790f1b405450','Enable to convert the image to grayscale.',1,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"\"}','2018-11-27 15:23:01','2018-12-07 19:34:20','a5c58651-f39a-4384-a7c6-28ad2390f2e9'),
	(36,NULL,'Padding','padding','matrixBlockType:27f153c6-09ef-408c-a85b-50ee37263d52','Add padding to the container.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"1\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"}]}','2018-11-27 16:34:59','2018-12-07 19:34:19','4c98e4da-8268-4e63-be65-60c159ffde69'),
	(37,NULL,'Padding Size','paddingSize','matrixBlockType:27f153c6-09ef-408c-a85b-50ee37263d52','How thick is the containers padding?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Huge\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-11-28 16:58:20','2019-01-30 12:22:36','a8818a76-5083-4143-95ac-e666c321a091'),
	(38,NULL,'Padding Size','paddingSize','matrixBlockType:9c7038b3-900d-4b50-a5ee-7c445a476f87','How thick is the sections padding?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x4\",\"default\":\"1\"},{\"label\":\"Huge\",\"value\":\"-x6\",\"default\":\"\"},{\"label\":\"Massive\",\"value\":\"-x8\",\"default\":\"\"}]}','2018-11-28 17:47:23','2019-01-30 12:22:36','d939cdb6-5f72-48ee-b805-f16dde284b4a'),
	(39,NULL,'Buttons','buttons','matrixBlockType:86843e26-821b-41e7-8e3e-87321802c139','Add call to action buttons.',1,'site',NULL,'verbb\\supertable\\fields\\SuperTableField','{\"minRows\":\"1\",\"maxRows\":\"3\",\"localizeBlocks\":false,\"staticField\":\"\",\"columns\":{\"40\":{\"width\":\"\"},\"41\":{\"width\":\"\"}},\"contentTable\":\"{{%stc_7_buttons}}\",\"fieldLayout\":\"matrix\",\"selectionLabel\":\"Add a Button\"}','2018-11-28 19:07:47','2019-01-30 12:23:09','16afd3ef-94de-4db2-87a1-26b358f4aa61'),
	(40,NULL,'Link','buttonLink','superTableBlockType:e1d8381e-e9da-4f7a-897a-7ca3280e4deb','Where should the button take the user?',1,'none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"1\",\"allowedLinkNames\":{\"1\":\"asset\",\"2\":\"category\",\"3\":\"entry\",\"6\":\"custom\",\"7\":\"email\",\"8\":\"tel\",\"9\":\"url\"},\"allowTarget\":\"1\",\"autoNoReferrer\":false,\"defaultLinkName\":\"entry\",\"defaultText\":\"\",\"enableAriaLabel\":\"\",\"enableTitle\":\"\",\"typeSettings\":{\"asset\":{\"sources\":\"*\"},\"category\":{\"sources\":\"*\"},\"entry\":{\"sources\":\"*\"},\"site\":{\"sites\":\"*\"},\"user\":{\"sources\":\"*\"},\"custom\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"email\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"tel\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"url\":{\"disableValidation\":\"\",\"allowAliases\":\"\"}}}','2018-11-28 19:07:47','2019-01-30 12:23:09','42cf42aa-aed4-47d0-b3f9-8ee81b134df4'),
	(41,NULL,'Button Style','buttonStyle','superTableBlockType:e1d8381e-e9da-4f7a-897a-7ca3280e4deb','How should the button look?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Basic Action Button\",\"value\":\"-base\",\"default\":\"1\"},{\"label\":\"Solid Style Button\",\"value\":\"-solid\",\"default\":\"\"},{\"label\":\"Outline Style Button\",\"value\":\"-outline\",\"default\":\"\"},{\"label\":\"Raised Style Button\",\"value\":\"-raised\",\"default\":\"\"},{\"label\":\"Rounded Solid Style Button\",\"value\":\"-solid -round\",\"default\":\"\"},{\"label\":\"Rounded Outline Style Button\",\"value\":\"-outline -round\",\"default\":\"\"}]}','2018-11-28 19:07:47','2019-01-30 12:23:09','ee572988-84e1-46e8-8b29-c23ce20bac43'),
	(42,NULL,'Alignment','alignment','matrixBlockType:86843e26-821b-41e7-8e3e-87321802c139','How should the buttons be aligned?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Left Aligned\",\"value\":\"\",\"default\":\"1\"},{\"label\":\"Center Aligned\",\"value\":\"-justify-center\",\"default\":\"\"},{\"label\":\"Right Aligned\",\"value\":\"-justify-end\",\"default\":\"\"},{\"label\":\"Space Between\",\"value\":\"-space-between\",\"default\":\"\"},{\"label\":\"Space Around\",\"value\":\"-space-around\",\"default\":\"\"}]}','2018-11-28 19:14:56','2018-12-07 19:34:20','972a946c-797a-4f9c-8681-aaa29ef67856'),
	(43,NULL,'Padding Size','paddingSize','matrixBlockType:86843e26-821b-41e7-8e3e-87321802c139','How thick is the padding?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Thin\",\"value\":\"-thin\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Huge\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-11-28 19:14:56','2018-12-07 19:34:20','afa0d0fd-406e-4d41-9c96-e5f5d59b058f'),
	(44,NULL,'Padding','padding','matrixBlockType:86843e26-821b-41e7-8e3e-87321802c139','Add padding to the block.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"1\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Buttom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-11-28 19:14:56','2019-01-30 12:22:36','1d7cea56-a8d6-4502-874c-779e624b3bf5'),
	(45,NULL,'Image Alignment','imageAlignment','matrixBlockType:8cfe5e31-20a9-4ddc-ba3d-790f1b405450','Align applied to images with an Aspect Ratio of None.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Left\",\"value\":\"u-text-left\",\"default\":\"\"},{\"label\":\"Center\",\"value\":\"u-text-center\",\"default\":\"1\"},{\"label\":\"Right\",\"value\":\"u-text-right\",\"default\":\"\"}]}','2018-11-29 13:19:25','2019-01-30 12:22:36','ab8da4d3-dc99-4cb3-a978-347132b072ca'),
	(46,NULL,'Body','body','matrixBlockType:42b013df-72dc-41a5-941f-d7a299502e38','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-11-29 13:45:52','2018-12-07 19:34:20','71e1aa18-0063-405d-955e-74b5ec1514b2'),
	(47,NULL,'Source','source','matrixBlockType:42b013df-72dc-41a5-941f-d7a299502e38','Optional source or author for the quote.',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-11-29 13:45:52','2018-12-07 19:34:20','cbdbc09b-11a0-4b1a-a0bd-5b991c3c75eb'),
	(48,NULL,'Padding Size','paddingSize','matrixBlockType:42b013df-72dc-41a5-941f-d7a299502e38','How thick is the padding?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Thin\",\"value\":\"-thin\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Huge\",\"value\":\"-x4\",\"default\":\"\"},{\"label\":\"Massive\",\"value\":\"-x6\",\"default\":\"\"}]}','2018-11-29 13:45:52','2018-12-07 19:34:20','ebbd92ad-ec15-4d07-ae91-eccbb307569b'),
	(49,NULL,'Padding','padding','matrixBlockType:42b013df-72dc-41a5-941f-d7a299502e38','Add padding to the block.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"1\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-11-29 13:45:52','2018-12-07 19:34:20','f544af32-b279-49f9-9fa4-60c1d0391b85'),
	(50,NULL,'Quote Style','quoteStyle','matrixBlockType:42b013df-72dc-41a5-941f-d7a299502e38','Select a quote block style.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Large\",\"value\":\"-large\",\"default\":\"1\"},{\"label\":\"Block\",\"value\":\"-block\",\"default\":\"\"}]}','2018-11-29 14:19:38','2019-01-30 12:22:36','984c9a76-6153-41af-9f4b-fbff36a88709'),
	(51,NULL,'Slides','slides','matrixBlockType:411496be-9759-4334-803e-790121fdee23','Add slides to the gallery.',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:eb2dafb2-9954-4850-9d47-56e2e80f3880\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:eb2dafb2-9954-4850-9d47-56e2e80f3880\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"folder:eb2dafb2-9954-4850-9d47-56e2e80f3880\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"\",\"selectionLabel\":\"Add an Image\",\"localizeRelations\":false}','2018-11-29 16:00:58','2018-12-07 19:34:20','00ccd03b-0a70-4fed-a14d-a0b846ecad51'),
	(52,NULL,'Image','image','superTableBlockType:bf867548-c6c8-4312-9ff6-501f221c53e8','Select or upload an image.',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"folder:eb2dafb2-9954-4850-9d47-56e2e80f3880\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:eb2dafb2-9954-4850-9d47-56e2e80f3880\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add an Image\",\"localizeRelations\":false}','2018-11-29 16:00:58','2018-11-29 19:01:53','c4dc3d58-6669-4037-840c-bc6369b067a3'),
	(53,NULL,'Padding Size','paddingSize','matrixBlockType:411496be-9759-4334-803e-790121fdee23','How thick is the padding?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Thin\",\"value\":\"-thin\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Huge\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-11-29 16:00:58','2018-12-07 19:34:20','0bf2b1b8-e3d3-47f7-bc51-628bd536b65c'),
	(54,NULL,'Padding','padding','matrixBlockType:411496be-9759-4334-803e-790121fdee23','Add padding to the block.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"1\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-11-29 16:00:58','2018-12-07 19:34:20','418c41b9-d777-4c60-b660-7f8421a7f12d'),
	(55,NULL,'Slide Transition','slideTransition','matrixBlockType:411496be-9759-4334-803e-790121fdee23','Select how fast the slides transition. Setting this option to manual forces the user initiate the transition.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Manual\",\"value\":\"-1\",\"default\":\"1\"},{\"label\":\"Slow\",\"value\":\"12\",\"default\":\"\"},{\"label\":\"Medium\",\"value\":\"7\",\"default\":\"\"},{\"label\":\"Fast\",\"value\":\"5\",\"default\":\"\"}]}','2018-11-29 16:00:58','2018-12-07 19:34:20','f40a44dd-80c9-41bd-92f8-11ea5934e78d'),
	(56,NULL,'Style','style','matrixBlockType:411496be-9759-4334-803e-790121fdee23','Select a gallery style.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Fade\",\"value\":\"fade\",\"default\":\"1\"},{\"label\":\"Slide\",\"value\":\"slide\",\"default\":\"\"},{\"label\":\"Stack\",\"value\":\"stack\",\"default\":\"\"},{\"label\":\"Parallax\",\"value\":\"parallax\",\"default\":\"\"}]}','2018-11-29 16:00:58','2018-12-07 19:34:20','0ed585b2-9d94-4ebc-a088-f12f4474ecf4'),
	(57,NULL,'Aspect Ratio','aspectRatio','matrixBlockType:411496be-9759-4334-803e-790121fdee23','Select the galleries aspect ratio.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"1:1\",\"value\":\"u-ratio-1/1\",\"default\":\"1\"},{\"label\":\"2:3\",\"value\":\"u-ratio-2/3\",\"default\":\"\"},{\"label\":\"16:9\",\"value\":\"u-ratio-16/9\",\"default\":\"\"}]}','2018-11-29 16:00:58','2019-01-30 12:22:36','3b24986d-c663-48f7-86ca-a778bebbcd82'),
	(58,NULL,'Headline','headline','superTableBlockType:bf867548-c6c8-4312-9ff6-501f221c53e8','Optional headline. Not use on every style.',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"120\",\"columnType\":\"text\"}','2018-11-29 18:37:00','2018-11-29 19:01:53','c4ef4072-bd1f-4447-8f21-b05a86657c4f'),
	(59,NULL,'Body','body','superTableBlockType:bf867548-c6c8-4312-9ff6-501f221c53e8','Optional body copy. Not use on every style.',1,'none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Complex-Content.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"\",\"availableTransforms\":\"*\"}','2018-11-29 18:37:00','2019-01-30 12:23:09','2ffc941a-e160-475b-af3f-66b7b9f49ff2'),
	(60,NULL,'Rows','rows','matrixBlockType:2cb049e6-b35a-4271-8861-0bbde459b042','',1,'site',NULL,'verbb\\supertable\\fields\\SuperTableField','{\"minRows\":\"\",\"maxRows\":\"\",\"localizeBlocks\":false,\"staticField\":\"\",\"columns\":{\"61\":{\"width\":\"\"},\"62\":{\"width\":\"\"},\"71\":{\"width\":\"\"},\"72\":{\"width\":\"\"},\"73\":{\"width\":\"\"}},\"contentTable\":\"{{%stc_10_rows}}\",\"fieldLayout\":\"row\",\"selectionLabel\":\"\"}','2018-12-07 12:52:41','2019-01-30 12:23:09','89bb2fb3-11df-43a8-bc0e-dc9282624357'),
	(61,NULL,'Heading','heading','superTableBlockType:061368e4-5312-4599-93a2-c40f7165b4b6','What is the heading for this row?',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"32\",\"columnType\":\"text\"}','2018-12-07 12:52:41','2019-01-30 12:23:09','c7b72005-a498-41f9-979d-67d815d408e3'),
	(62,NULL,'Body','body','superTableBlockType:061368e4-5312-4599-93a2-c40f7165b4b6','Copy for the row.',1,'none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Basic.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"\",\"availableTransforms\":\"*\"}','2018-12-07 12:52:41','2019-01-30 12:23:09','a255042b-ffbc-48c6-87b5-dff502c8251d'),
	(63,NULL,'Padding Size','paddingSize','matrixBlockType:2cb049e6-b35a-4271-8861-0bbde459b042','How thick is the padding?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Thin\",\"value\":\"-thin\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Huge\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-12-07 12:52:42','2018-12-07 19:34:20','5842ae73-b069-45a3-b28a-0149781ddbea'),
	(64,NULL,'Padding','padding','matrixBlockType:2cb049e6-b35a-4271-8861-0bbde459b042','Add padding to the block.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"1\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Buttom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-12-07 12:52:42','2018-12-07 19:34:20','b5e83c8a-e3ac-4e7f-aa5b-ae31369fe8b2'),
	(65,NULL,'List Items','listItems','matrixBlockType:3bf9043f-ddd4-4d72-b83d-c984f46fdecf','',1,'site',NULL,'verbb\\supertable\\fields\\SuperTableField','{\"minRows\":\"1\",\"maxRows\":\"\",\"localizeBlocks\":false,\"staticField\":\"\",\"columns\":{\"66\":{\"width\":\"\"}},\"contentTable\":\"{{%stc_11_listitems}}\",\"fieldLayout\":\"row\",\"selectionLabel\":\"\"}','2018-12-07 17:24:19','2019-01-30 12:23:09','9fcae5d9-54cc-4ce1-9ade-6fa31442abf1'),
	(66,NULL,'Item','item','superTableBlockType:326dbc91-cc61-404b-ad31-73f972c6e3de','',1,'none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"Basic.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"\",\"availableTransforms\":\"*\"}','2018-12-07 17:24:19','2019-01-30 12:23:09','fc1bf467-a95f-4dff-99b8-b2e3ccb556d5'),
	(67,NULL,'Padding Size','paddingSize','matrixBlockType:3bf9043f-ddd4-4d72-b83d-c984f46fdecf','How thick is the padding?',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"None\",\"value\":\"-none\",\"default\":\"1\"},{\"label\":\"Thin\",\"value\":\"-thin\",\"default\":\"\"},{\"label\":\"Normal\",\"value\":\"\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"-x2\",\"default\":\"\"},{\"label\":\"Huge\",\"value\":\"-x4\",\"default\":\"\"}]}','2018-12-07 17:24:19','2018-12-07 19:34:21','0c87ae8e-ce72-414a-8f65-38af1031d8bc'),
	(68,NULL,'Padding','padding','matrixBlockType:3bf9043f-ddd4-4d72-b83d-c984f46fdecf','Add padding to the block.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Add Full Padding\",\"value\":\"u-padding\",\"default\":\"1\"},{\"label\":\"Add Vertical Padding\",\"value\":\"u-padding-vertical\",\"default\":\"\"},{\"label\":\"Add Horizontal Padding\",\"value\":\"u-padding-horizontal\",\"default\":\"\"},{\"label\":\"Add Padding Top\",\"value\":\"u-padding-top\",\"default\":\"\"},{\"label\":\"Add Padding Bottom\",\"value\":\"u-padding-bottom\",\"default\":\"\"},{\"label\":\"Add Padding Left\",\"value\":\"u-padding-left\",\"default\":\"\"},{\"label\":\"Add Padding Right\",\"value\":\"u-padding-right\",\"default\":\"\"}]}','2018-12-07 17:24:19','2018-12-07 19:34:21','de8d5f7b-33fb-44be-b39a-2eab11dc3b9f'),
	(69,NULL,'Alignment','alignment','matrixBlockType:3bf9043f-ddd4-4d72-b83d-c984f46fdecf','',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Left\",\"value\":\"u-text-left\",\"default\":\"1\"},{\"label\":\"Center\",\"value\":\"u-text-center\",\"default\":\"\"},{\"label\":\"Right\",\"value\":\"u-text-right\",\"default\":\"\"}]}','2018-12-07 17:46:02','2018-12-07 19:34:21','fd4b318a-37e0-4db3-b40c-bb76badfae2e'),
	(70,NULL,'List Style','listStyle','matrixBlockType:3bf9043f-ddd4-4d72-b83d-c984f46fdecf','Select a style for the list.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Default\",\"value\":\"-default\",\"default\":\"1\"},{\"label\":\"Plus\",\"value\":\"-plus\",\"default\":\"\"}]}','2018-12-07 17:49:25','2019-01-30 12:22:36','462274cc-3cdd-49e8-83f2-c197f47959e8'),
	(71,NULL,'List','list','superTableBlockType:061368e4-5312-4599-93a2-c40f7165b4b6','Optional list element for the row. The list will be placed below any body copy.',1,'none',NULL,'craft\\fields\\Table','{\"addRowLabel\":\"Add a List Item\",\"maxRows\":\"18\",\"minRows\":\"0\",\"columns\":{\"col1\":{\"heading\":\"List Item\",\"handle\":\"listItem\",\"width\":\"\",\"type\":\"singleline\"}},\"defaults\":[],\"columnType\":\"text\"}','2018-12-07 18:04:27','2019-01-30 12:23:09','d5822862-1769-4f56-bdd9-03d7aeb583a1'),
	(72,NULL,'Split List','splitList','superTableBlockType:061368e4-5312-4599-93a2-c40f7165b4b6','When enabled and the list contains items the list will be placed to the right of the body copy.',1,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"\"}','2018-12-07 18:04:27','2019-01-30 12:23:09','43eacc7a-4e10-4194-875c-d90071579149'),
	(73,NULL,'List Style','listStyle','superTableBlockType:061368e4-5312-4599-93a2-c40f7165b4b6','Select a list style type.',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Default\",\"value\":\"-default\",\"default\":\"1\"},{\"label\":\"Plus\",\"value\":\"-plus\",\"default\":\"\"}]}','2018-12-07 19:09:38','2019-01-30 12:23:09','b337860e-6281-433f-aa69-2d01b5f8e912'),
	(74,NULL,'Multi Row','multiRow','matrixBlockType:2cb049e6-b35a-4271-8861-0bbde459b042','When enabled users can open up several rows. When disabled when a user opens a row the previously opened row will be closed.',1,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"\"}','2018-12-07 19:34:21','2019-01-30 12:22:36','f8b603ed-7622-42e8-a6ca-022ec1da1159');

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
	(21,'checkbox_group','seasonalFlavors','Seasonal Flavors',0,'','{\"customValues\":\"\",\"labels\":[\"Pumpkin Pie\",\"Gingerbread House\",\"S\'mores\",\"Rainbow Swirl\",\"Peanut Butter & Jelly\"],\"options\":[{\"value\":\"Pumpkin Pie\",\"label\":\"Pumpkin Pie\"},{\"value\":\"Gingerbread House\",\"label\":\"Gingerbread House\"},{\"value\":\"S\'mores\",\"label\":\"S\'mores\"},{\"value\":\"Rainbow Swirl\",\"label\":\"Rainbow Swirl\"},{\"value\":\"Peanut Butter & Jelly\",\"label\":\"Peanut Butter & Jelly\"}]}','2019-01-29 20:02:19','2019-01-29 20:04:40','54c6f39d-56f1-4ece-b43c-0381eda527db'),
	(22,'checkbox','agreeToEula','Agree to EULA',0,'You have read and agree to the EULA agreement','{\"value\":\"no\",\"checked\":\"\"}','2019-01-29 20:16:46','2019-01-29 20:16:46','2c65083b-0ac4-47d9-9235-46d804f4ba59'),
	(23,'checkbox','newsletterSignup','Newsletter Signup',0,'','{\"value\":\"yes\",\"checked\":\"1\"}','2019-01-29 20:44:12','2019-01-29 20:44:12','bd6c7807-2192-4b4c-8511-ce3fcf94b037'),
	(24,'number','pinNumber','Pin Number',1,'','{\"value\":\"\",\"placeholder\":\"\",\"allowNegative\":\"\",\"minValue\":\"0\",\"maxValue\":\"9999\",\"minLength\":\"4\",\"maxLength\":\"4\",\"decimalCount\":\"0\",\"decimalSeparator\":\".\",\"thousandsSeparator\":\"\"}','2019-01-29 20:48:12','2019-01-29 20:48:12','8f21ea62-25fa-4ec6-b94d-3a76660dc8a6'),
	(25,'text','address','Address',0,'','{\"value\":\"\",\"placeholder\":\"\"}','2019-01-29 20:55:50','2019-01-29 20:55:50','4fbef3fe-1ffd-4757-add0-373edf626b3f');

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
	(1,'Sample Form','sampleForm',0,'{{ dateCreated|date(\"Y-m-d H:i:s\") }}','','{\"composer\":{\"layout\":[[{\"id\":\"15rMWW3jp\",\"columns\":[\"mgEePYZor\"]},{\"id\":\"Bm2q11KPG\",\"columns\":[\"Bb10jE4K3\"]},{\"id\":\"xkQ7LLno8\",\"columns\":[\"AV34dy07p\"]},{\"id\":\"rM3WxgVMb\",\"columns\":[\"AQbZNx0P3\"]},{\"id\":\"KrOVNgm8x\",\"columns\":[\"gGp461ZwQ\",\"jDMZQLe3y\",\"Jvb4m946X\"]},{\"id\":\"8RbnV6oQn\",\"columns\":[\"pqO3xVwPl\",\"Xna0EwZ32\"]},{\"id\":\"kyxKLLoBx\",\"columns\":[\"DBk0Xw4YJ\"]},{\"id\":\"ldywLVx2V\",\"columns\":[\"n5deb50bB\",\"qlRZRw4XA\"]},{\"id\":\"mEV9x13dL\",\"columns\":[\"PN5Z8a4AM\"]},{\"id\":\"bvNbQxn6m\",\"columns\":[\"dV8ZM8eob\"]},{\"id\":\"QrYVK6VVP\",\"columns\":[\"YAdE9LJNQ\"]}]],\"properties\":{\"page0\":{\"type\":\"page\",\"label\":\"Page 1\"},\"form\":{\"type\":\"form\",\"name\":\"Sample Form\",\"handle\":\"sampleForm\",\"color\":\"#16a388\",\"submissionTitleFormat\":\"{{ dateCreated|date(\\\"Y-m-d H:i:s\\\") }}\",\"description\":\"\",\"formTemplate\":\"papertrain.twig\",\"returnUrl\":\"\",\"storeData\":true,\"defaultStatus\":2},\"integration\":{\"type\":\"integration\",\"integrationId\":0,\"mapping\":[]},\"connections\":{\"type\":\"connections\",\"list\":null},\"rules\":{\"type\":\"rules\",\"list\":[]},\"admin_notifications\":{\"type\":\"admin_notifications\",\"notificationId\":0,\"recipients\":\"\"},\"payment\":{\"type\":\"payment\",\"integrationId\":0,\"mapping\":[]},\"mgEePYZor\":{\"hash\":\"mgEePYZor\",\"id\":14,\"type\":\"text\",\"handle\":\"fullName\",\"label\":\"Full Name\",\"required\":true,\"instructions\":\"Please provide your full name\",\"value\":\"\",\"placeholder\":\"\"},\"Bb10jE4K3\":{\"hash\":\"Bb10jE4K3\",\"id\":15,\"type\":\"text\",\"handle\":\"companyName\",\"label\":\"Company Name\",\"required\":false,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"AV34dy07p\":{\"hash\":\"AV34dy07p\",\"id\":16,\"type\":\"email\",\"handle\":\"emailAddress\",\"label\":\"Email Address\",\"required\":true,\"instructions\":\"\",\"notificationId\":0,\"values\":[],\"placeholder\":\"\"},\"gGp461ZwQ\":{\"hash\":\"gGp461ZwQ\",\"id\":18,\"type\":\"text\",\"handle\":\"city\",\"label\":\"City\",\"required\":false,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"jDMZQLe3y\":{\"hash\":\"jDMZQLe3y\",\"id\":10,\"type\":\"select\",\"handle\":\"state\",\"label\":\"State\",\"required\":false,\"instructions\":\"\",\"showCustomValues\":true,\"value\":\"\",\"options\":[{\"value\":\"\",\"label\":\"Select a State\"},{\"value\":\"AL\",\"label\":\"Alabama\"},{\"value\":\"AK\",\"label\":\"Alaska\"},{\"value\":\"AZ\",\"label\":\"Arizona\"},{\"value\":\"AR\",\"label\":\"Arkansas\"},{\"value\":\"CA\",\"label\":\"California\"},{\"value\":\"CO\",\"label\":\"Colorado\"},{\"value\":\"CT\",\"label\":\"Connecticut\"},{\"value\":\"DE\",\"label\":\"Delaware\"},{\"value\":\"DC\",\"label\":\"District of Columbia\"},{\"value\":\"FL\",\"label\":\"Florida\"},{\"value\":\"GA\",\"label\":\"Georgia\"},{\"value\":\"HI\",\"label\":\"Hawaii\"},{\"value\":\"ID\",\"label\":\"Idaho\"},{\"value\":\"IL\",\"label\":\"Illinois\"},{\"value\":\"IN\",\"label\":\"Indiana\"},{\"value\":\"IA\",\"label\":\"Iowa\"},{\"value\":\"KS\",\"label\":\"Kansas\"},{\"value\":\"KY\",\"label\":\"Kentucky\"},{\"value\":\"LA\",\"label\":\"Louisiana\"},{\"value\":\"ME\",\"label\":\"Maine\"},{\"value\":\"MD\",\"label\":\"Maryland\"},{\"value\":\"MA\",\"label\":\"Massachusetts\"},{\"value\":\"MI\",\"label\":\"Michigan\"},{\"value\":\"MN\",\"label\":\"Minnesota\"},{\"value\":\"MS\",\"label\":\"Mississippi\"},{\"value\":\"MO\",\"label\":\"Missouri\"},{\"value\":\"MT\",\"label\":\"Montana\"},{\"value\":\"NE\",\"label\":\"Nebraska\"},{\"value\":\"NV\",\"label\":\"Nevada\"},{\"value\":\"NH\",\"label\":\"New Hampshire\"},{\"value\":\"NJ\",\"label\":\"New Jersey\"},{\"value\":\"NM\",\"label\":\"New Mexico\"},{\"value\":\"NY\",\"label\":\"New York\"},{\"value\":\"NC\",\"label\":\"North Carolina\"},{\"value\":\"ND\",\"label\":\"North Dakota\"},{\"value\":\"OH\",\"label\":\"Ohio\"},{\"value\":\"OK\",\"label\":\"Oklahoma\"},{\"value\":\"OR\",\"label\":\"Oregon\"},{\"value\":\"PA\",\"label\":\"Pennsylvania\"},{\"value\":\"RI\",\"label\":\"Rhode Island\"},{\"value\":\"SC\",\"label\":\"South Carolina\"},{\"value\":\"SD\",\"label\":\"South Dakota\"},{\"value\":\"TN\",\"label\":\"Tennessee\"},{\"value\":\"TX\",\"label\":\"Texas\"},{\"value\":\"UT\",\"label\":\"Utah\"},{\"value\":\"VT\",\"label\":\"Vermont\"},{\"value\":\"VA\",\"label\":\"Virginia\"},{\"value\":\"WA\",\"label\":\"Washington\"},{\"value\":\"WV\",\"label\":\"West Virginia\"},{\"value\":\"WI\",\"label\":\"Wisconsin\"},{\"value\":\"WY\",\"label\":\"Wyoming\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null},\"Jvb4m946X\":{\"hash\":\"Jvb4m946X\",\"id\":19,\"type\":\"number\",\"handle\":\"zipCode\",\"label\":\"Zip Code\",\"required\":false,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\",\"minLength\":0,\"maxLength\":0,\"minValue\":0,\"maxValue\":0,\"decimalCount\":0,\"decimalSeparator\":\".\",\"thousandsSeparator\":\"\",\"allowNegative\":true},\"DBk0Xw4YJ\":{\"hash\":\"DBk0Xw4YJ\",\"id\":17,\"type\":\"textarea\",\"handle\":\"message\",\"label\":\"Message\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\",\"rows\":2},\"n5deb50bB\":{\"hash\":\"n5deb50bB\",\"id\":20,\"type\":\"radio_group\",\"handle\":\"favoriteFlavor\",\"label\":\"Favorite Flavor\",\"required\":false,\"instructions\":\"\",\"showCustomValues\":false,\"value\":\"Peanut Butter Cup\",\"options\":[{\"value\":\"Peanut Butter Cup\",\"label\":\"Peanut Butter Cup\"},{\"value\":\"Chocolate Chip Cookie Dough\",\"label\":\"Chocolate Chip Cookie Dough\"},{\"value\":\"Vanilla Bean\",\"label\":\"Vanilla Bean\"},{\"value\":\"Birthday Cake\",\"label\":\"Birthday Cake\"},{\"value\":\"Cookies & Cream\",\"label\":\"Cookies & Cream\"},{\"value\":\"Chocolate\",\"label\":\"Chocolate\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null},\"qlRZRw4XA\":{\"hash\":\"qlRZRw4XA\",\"id\":21,\"type\":\"checkbox_group\",\"handle\":\"seasonalFlavors\",\"label\":\"Seasonal Flavors\",\"required\":false,\"instructions\":\"\",\"showCustomValues\":false,\"values\":[],\"options\":[{\"value\":\"Pumpkin Pie\",\"label\":\"Pumpkin Pie\"},{\"value\":\"Gingerbread House\",\"label\":\"Gingerbread House\"},{\"value\":\"S\'mores\",\"label\":\"S\'mores\"},{\"value\":\"Rainbow Swirl\",\"label\":\"Rainbow Swirl\"},{\"value\":\"Peanut Butter & Jelly\",\"label\":\"Peanut Butter & Jelly\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null},\"dV8ZM8eob\":{\"hash\":\"dV8ZM8eob\",\"id\":22,\"type\":\"checkbox\",\"handle\":\"agreeToEula\",\"label\":\"Agree to EULA\",\"required\":true,\"instructions\":\"You have read and agree to the EULA agreement\",\"value\":\"yes\",\"checked\":false},\"PN5Z8a4AM\":{\"hash\":\"PN5Z8a4AM\",\"id\":23,\"type\":\"checkbox\",\"handle\":\"newsletterSignup\",\"label\":\"Newsletter Signup\",\"required\":false,\"instructions\":\"\",\"value\":\"yes\",\"checked\":true},\"YAdE9LJNQ\":{\"type\":\"submit\",\"label\":\"Submit\",\"labelNext\":\"Submit\",\"labelPrev\":\"Previous\",\"disablePrev\":false,\"position\":\"left\"},\"pqO3xVwPl\":{\"type\":\"password\",\"label\":\"Password\",\"handle\":\"password\",\"placeholder\":\"\",\"required\":true},\"Xna0EwZ32\":{\"hash\":\"Xna0EwZ32\",\"id\":24,\"type\":\"number\",\"handle\":\"pinNumber\",\"label\":\"Pin Number\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\",\"minLength\":4,\"maxLength\":4,\"minValue\":0,\"maxValue\":9999,\"decimalCount\":0,\"decimalSeparator\":\".\",\"thousandsSeparator\":\"\",\"allowNegative\":false,\"inputAttributes\":[]},\"AQbZNx0P3\":{\"hash\":\"AQbZNx0P3\",\"id\":25,\"type\":\"text\",\"handle\":\"address\",\"label\":\"Address\",\"required\":false,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"}}},\"context\":{\"page\":0,\"hash\":\"pqO3xVwPl\"}}','',2,NULL,'#16a388',NULL,'2019-01-29 19:18:35','2019-01-29 21:05:10','5588f7f4-3a6b-437d-8768-3e50635f1740');

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
	(1,'3.1.6.1','3.1.23',0,'a:18:{s:12:\"dateModified\";i:1548850989;s:10:\"siteGroups\";a:1:{s:36:\"f5eb95d0-c53e-4630-b230-91539b9e08b2\";a:1:{s:4:\"name\";s:22:\"Papertrain Boilerplate\";}}s:5:\"sites\";a:1:{s:36:\"ac246379-14f1-440a-82f2-90ef2b3e6443\";a:8:{s:4:\"name\";s:22:\"Papertrain Boilerplate\";s:6:\"handle\";s:7:\"default\";s:8:\"language\";s:5:\"en-US\";s:7:\"hasUrls\";s:1:\"1\";s:7:\"baseUrl\";s:5:\"@web/\";s:9:\"sortOrder\";s:1:\"1\";s:7:\"primary\";s:1:\"1\";s:9:\"siteGroup\";s:36:\"f5eb95d0-c53e-4630-b230-91539b9e08b2\";}}s:8:\"sections\";a:1:{s:36:\"b192f8ce-1e5a-495d-bb45-ede8cd1ad3d4\";a:8:{s:4:\"name\";s:14:\"Standard Pages\";s:6:\"handle\";s:13:\"standardPages\";s:4:\"type\";s:9:\"structure\";s:16:\"enableVersioning\";s:1:\"1\";s:16:\"propagateEntries\";s:1:\"1\";s:9:\"structure\";a:2:{s:3:\"uid\";s:36:\"705621d5-28f2-4ec0-b53c-8500b2bb1fd8\";s:9:\"maxLevels\";s:1:\"2\";}s:10:\"entryTypes\";a:1:{s:36:\"314ff677-634c-4a48-8499-6c2817266962\";a:7:{s:4:\"name\";s:14:\"Standard Pages\";s:6:\"handle\";s:13:\"standardPages\";s:13:\"hasTitleField\";s:1:\"1\";s:10:\"titleLabel\";s:5:\"Title\";s:11:\"titleFormat\";N;s:9:\"sortOrder\";s:1:\"1\";s:12:\"fieldLayouts\";a:1:{s:36:\"49f16c08-2073-4897-8f3e-92355d39b819\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:15:\"Complex Content\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:1:{s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}}}}}}}}s:12:\"siteSettings\";a:1:{s:36:\"ac246379-14f1-440a-82f2-90ef2b3e6443\";a:4:{s:16:\"enabledByDefault\";s:1:\"1\";s:7:\"hasUrls\";s:1:\"1\";s:9:\"uriFormat\";s:20:\"{parent.slug}/{slug}\";s:8:\"template\";s:22:\"_complex-content/entry\";}}}}s:11:\"fieldGroups\";a:2:{s:36:\"8dcdb4b8-5035-411c-8f7f-5e255dcca924\";a:1:{s:4:\"name\";s:6:\"Common\";}s:36:\"2e631263-d760-43da-adbd-abb7189fbd52\";a:1:{s:4:\"name\";s:13:\"Site Settings\";}}s:6:\"fields\";a:1:{s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";a:10:{s:4:\"name\";s:15:\"Complex Content\";s:6:\"handle\";s:2:\"cc\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Matrix\";s:8:\"settings\";a:4:{s:9:\"minBlocks\";s:0:\"\";s:9:\"maxBlocks\";s:0:\"\";s:12:\"contentTable\";s:21:\"{{%matrixcontent_cc}}\";s:14:\"localizeBlocks\";b:0;}s:10:\"fieldGroup\";s:36:\"8dcdb4b8-5035-411c-8f7f-5e255dcca924\";s:17:\"contentColumnType\";s:6:\"string\";}}s:16:\"matrixBlockTypes\";a:11:{s:36:\"9c7038b3-900d-4b50-a5ee-7c445a476f87\";a:6:{s:4:\"name\";s:7:\"Section\";s:6:\"handle\";s:15:\"sectionSettings\";s:9:\"sortOrder\";s:1:\"1\";s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:12:\"fieldLayouts\";a:1:{s:36:\"cccaf184-6482-40a9-bdc8-acaaebe6917f\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:6:{s:36:\"fb2fb216-c076-435d-b399-bb0c92cbc106\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"d3f64f5e-8d98-4cfe-bc55-10e5c2497fff\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}s:36:\"36459edb-92eb-4e49-b582-883cd750f9fd\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"3\";}s:36:\"c043d1ea-bbda-4790-9b09-ca031caf54d4\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"4\";}s:36:\"d939cdb6-5f72-48ee-b805-f16dde284b4a\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"5\";}s:36:\"af04a3f1-22e2-4182-a22d-c6a44383b788\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"6\";}}}}}}s:6:\"fields\";a:6:{s:36:\"fb2fb216-c076-435d-b399-bb0c92cbc106\";a:10:{s:4:\"name\";s:16:\"Background Color\";s:6:\"handle\";s:15:\"backgroundColor\";s:12:\"instructions\";s:45:\"Please select this sections background color.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:3:{i:0;a:3:{s:5:\"label\";s:5:\"White\";s:5:\"value\";s:19:\"-primary-background\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:9:\"Off White\";s:5:\"value\";s:21:\"-secondary-background\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:9:\"Off Black\";s:5:\"value\";s:16:\"-dark-background\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"d3f64f5e-8d98-4cfe-bc55-10e5c2497fff\";a:10:{s:4:\"name\";s:16:\"Background Image\";s:6:\"handle\";s:15:\"backgroundImage\";s:12:\"instructions\";s:98:\"Optional background image for the section. This image will override the selected background color.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:0:\"\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:1:\"1\";s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:7:\"sources\";a:1:{i:0;s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";}s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:5:\"large\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:22:\"Add a Background Image\";s:17:\"localizeRelations\";b:0;}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"36459edb-92eb-4e49-b582-883cd750f9fd\";a:10:{s:4:\"name\";s:16:\"Background Video\";s:6:\"handle\";s:15:\"backgroundVideo\";s:12:\"instructions\";s:108:\"Optional background video for the section. This video will override the selected background color and image.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:0:\"\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:02433cef-1aec-4478-8f75-f5570480c436\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:1:\"1\";s:12:\"allowedKinds\";a:1:{i:0;s:5:\"video\";}s:7:\"sources\";a:1:{i:0;s:43:\"volume:02433cef-1aec-4478-8f75-f5570480c436\";}s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:5:\"large\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:22:\"Add a Background Video\";s:17:\"localizeRelations\";b:0;}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"c043d1ea-bbda-4790-9b09-ca031caf54d4\";a:10:{s:4:\"name\";s:7:\"Overlay\";s:6:\"handle\";s:7:\"overlay\";s:12:\"instructions\";s:62:\"Select an optional overlay for your background video or image.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:4:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:4:\"none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:5:\"Light\";s:5:\"value\";s:13:\"35,35,35,0.33\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:6:\"Medium\";s:5:\"value\";s:12:\"35,35,35,0.6\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:4:\"Dark\";s:5:\"value\";s:13:\"35,35,35,0.87\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"af04a3f1-22e2-4182-a22d-c6a44383b788\";a:10:{s:4:\"name\";s:7:\"Padding\";s:6:\"handle\";s:7:\"padding\";s:12:\"instructions\";s:27:\"Add padding to the section.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:3:{i:0;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:18:\"Add Padding Bottom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"d939cdb6-5f72-48ee-b805-f16dde284b4a\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:34:\"How thick is the sections padding?\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:5:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:0:\"\";}i:1;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:5:\"Large\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:1:\"1\";}i:3;a:3:{s:5:\"label\";s:4:\"Huge\";s:5:\"value\";s:3:\"-x6\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:7:\"Massive\";s:5:\"value\";s:3:\"-x8\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}}}s:36:\"e99be65c-5fee-4c83-9eed-8050793be42a\";a:6:{s:4:\"name\";s:7:\"Heading\";s:6:\"handle\";s:7:\"heading\";s:9:\"sortOrder\";s:1:\"4\";s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:12:\"fieldLayouts\";a:1:{s:36:\"39856f0c-11eb-4fe4-a60d-07e698ae181c\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:5:{s:36:\"c1466ef0-df37-4a2f-9ecb-82d6e9b3a223\";a:2:{s:8:\"required\";s:1:\"1\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"d6747373-70b8-49ad-82bd-33370282ee35\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}s:36:\"4421109a-d1a4-4e10-b64a-87b84b5a3773\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"3\";}s:36:\"93f6127f-2098-4d92-89a9-6c353bb22799\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"4\";}s:36:\"f16ece4b-b4a4-4532-9b03-305f0e107a9d\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"5\";}}}}}}s:6:\"fields\";a:5:{s:36:\"c1466ef0-df37-4a2f-9ecb-82d6e9b3a223\";a:10:{s:4:\"name\";s:4:\"Copy\";s:6:\"handle\";s:4:\"copy\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"d6747373-70b8-49ad-82bd-33370282ee35\";a:10:{s:4:\"name\";s:9:\"Font Size\";s:6:\"handle\";s:8:\"fontSize\";s:12:\"instructions\";s:29:\"How large should the font be?\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:6:{i:0;a:3:{s:5:\"label\";s:4:\"Huge\";s:5:\"value\";s:4:\"o-h1\";s:7:\"default\";s:0:\"\";}i:1;a:3:{s:5:\"label\";s:5:\"Large\";s:5:\"value\";s:4:\"o-h2\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:6:\"Medium\";s:5:\"value\";s:4:\"o-h3\";s:7:\"default\";s:1:\"1\";}i:3;a:3:{s:5:\"label\";s:5:\"Small\";s:5:\"value\";s:4:\"o-h4\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:5:\"Title\";s:5:\"value\";s:4:\"o-h5\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:8:\"Subtitle\";s:5:\"value\";s:4:\"o-h6\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"4421109a-d1a4-4e10-b64a-87b84b5a3773\";a:10:{s:4:\"name\";s:9:\"Alignment\";s:6:\"handle\";s:9:\"alignment\";s:12:\"instructions\";s:34:\"How should the heading be aligned?\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:3:{i:0;a:3:{s:5:\"label\";s:4:\"Left\";s:5:\"value\";s:11:\"u-text-left\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:6:\"Center\";s:5:\"value\";s:13:\"u-text-center\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:5:\"Right\";s:5:\"value\";s:12:\"u-text-right\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"f16ece4b-b4a4-4532-9b03-305f0e107a9d\";a:10:{s:4:\"name\";s:7:\"Padding\";s:6:\"handle\";s:7:\"padding\";s:12:\"instructions\";s:25:\"Add padding to the block.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:7:{i:0;a:3:{s:5:\"label\";s:16:\"Add Full Padding\";s:5:\"value\";s:9:\"u-padding\";s:7:\"default\";s:0:\"\";}i:1;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:22:\"Add Horizontal Padding\";s:5:\"value\";s:20:\"u-padding-horizontal\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:18:\"Add Padding Bottom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:16:\"Add Padding Left\";s:5:\"value\";s:14:\"u-padding-left\";s:7:\"default\";s:0:\"\";}i:6;a:3:{s:5:\"label\";s:17:\"Add Padding Right\";s:5:\"value\";s:15:\"u-padding-right\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"93f6127f-2098-4d92-89a9-6c353bb22799\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:25:\"How thick is the padding?\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:5:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:4:\"Thin\";s:5:\"value\";s:5:\"-thin\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:5:\"Large\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:4:\"Huge\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}}}s:36:\"27f153c6-09ef-408c-a85b-50ee37263d52\";a:6:{s:4:\"name\";s:9:\"Container\";s:6:\"handle\";s:9:\"container\";s:9:\"sortOrder\";s:1:\"2\";s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:12:\"fieldLayouts\";a:1:{s:36:\"cb1fed6a-0e67-4c84-8d89-ebba225f2dad\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:6:{s:36:\"bbe771e9-89c0-4471-936a-5ebecf254b9b\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"a74d8612-5ca0-4325-9e7a-903893117219\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}s:36:\"27da4f8a-238c-4681-b862-712689ec9187\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"3\";}s:36:\"0318fd31-af0c-42d5-8f82-bda65318cbd2\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"4\";}s:36:\"a8818a76-5083-4143-95ac-e666c321a091\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"5\";}s:36:\"4c98e4da-8268-4e63-be65-60c159ffde69\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"6\";}}}}}}s:6:\"fields\";a:6:{s:36:\"bbe771e9-89c0-4471-936a-5ebecf254b9b\";a:10:{s:4:\"name\";s:5:\"Width\";s:6:\"handle\";s:5:\"width\";s:12:\"instructions\";s:43:\"How wide should this sections container be?\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:3:{i:0;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:11:\"o-container\";s:7:\"default\";s:0:\"\";}i:1;a:3:{s:5:\"label\";s:6:\"Narrow\";s:5:\"value\";s:18:\"o-container-narrow\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:4:\"Full\";s:5:\"value\";s:16:\"o-container-full\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"a74d8612-5ca0-4325-9e7a-903893117219\";a:10:{s:4:\"name\";s:13:\"Column Layout\";s:6:\"handle\";s:12:\"columnLayout\";s:12:\"instructions\";s:38:\"Please select a column layout pattern.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:5:{i:0;a:3:{s:5:\"label\";s:5:\"Whole\";s:5:\"value\";s:1:\"1\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:6:\"Halves\";s:5:\"value\";s:1:\"2\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:6:\"Thirds\";s:5:\"value\";s:1:\"3\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:9:\"1/3 & 2/3\";s:5:\"value\";s:1:\"4\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:9:\"2/3 & 1/3\";s:5:\"value\";s:1:\"5\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"27da4f8a-238c-4681-b862-712689ec9187\";a:10:{s:4:\"name\";s:13:\"Column Gutter\";s:6:\"handle\";s:12:\"columnGutter\";s:12:\"instructions\";s:47:\"How large of a gap between columns do you want?\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:4:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:12:\"-gutter-none\";s:7:\"default\";s:0:\"\";}i:1;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:7:\"-gutter\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:5:\"Small\";s:5:\"value\";s:13:\"-gutter-small\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:5:\"Large\";s:5:\"value\";s:13:\"-gutter-large\";s:7:\"default\";s:1:\"1\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"0318fd31-af0c-42d5-8f82-bda65318cbd2\";a:10:{s:4:\"name\";s:14:\"Vertical Align\";s:6:\"handle\";s:13:\"verticalAlign\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:3:{i:0;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:10:\"-align-top\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:6:\"Middle\";s:5:\"value\";s:13:\"-align-center\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:6:\"Bottom\";s:5:\"value\";s:10:\"-align-end\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"4c98e4da-8268-4e63-be65-60c159ffde69\";a:10:{s:4:\"name\";s:7:\"Padding\";s:6:\"handle\";s:7:\"padding\";s:12:\"instructions\";s:29:\"Add padding to the container.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:3:{i:0;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:18:\"Add Padding Bottom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"a8818a76-5083-4143-95ac-e666c321a091\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:36:\"How thick is the containers padding?\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:4:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:5:\"Large\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:4:\"Huge\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}}}s:36:\"8ca7c03d-aa9b-4611-b6be-6862e9a89ce1\";a:6:{s:4:\"name\";s:10:\"End Column\";s:6:\"handle\";s:9:\"endColumn\";s:9:\"sortOrder\";s:1:\"3\";s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:12:\"fieldLayouts\";a:1:{s:36:\"4455065f-9480-4863-8fad-e12f4b0ddf84\";a:1:{s:4:\"tabs\";a:0:{}}}s:6:\"fields\";N;}s:36:\"d40a8732-c577-4d4a-a737-05fa930be6a2\";a:6:{s:4:\"name\";s:4:\"Copy\";s:6:\"handle\";s:4:\"copy\";s:9:\"sortOrder\";s:1:\"5\";s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:12:\"fieldLayouts\";a:1:{s:36:\"4b28f1e5-4fd6-4d61-af99-5adc926b4e45\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:4:{s:36:\"9d5e8bb8-07be-40ec-803f-8296fa980c92\";a:2:{s:8:\"required\";s:1:\"1\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"799dbe03-d659-4f0d-8598-926a4ddb37c0\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}s:36:\"46892785-d8f7-443a-9215-a6fbbfc2e066\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"3\";}s:36:\"d85da825-7ece-4810-af33-232c2cddf7d5\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"4\";}}}}}}s:6:\"fields\";a:4:{s:36:\"9d5e8bb8-07be-40ec-803f-8296fa980c92\";a:10:{s:4:\"name\";s:4:\"Body\";s:6:\"handle\";s:4:\"body\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:20:\"craft\\redactor\\Field\";s:8:\"settings\";a:7:{s:14:\"redactorConfig\";s:20:\"Complex-Content.json\";s:14:\"purifierConfig\";s:0:\"\";s:11:\"cleanupHtml\";s:1:\"1\";s:10:\"purifyHtml\";s:1:\"1\";s:10:\"columnType\";s:4:\"text\";s:16:\"availableVolumes\";s:0:\"\";s:19:\"availableTransforms\";s:1:\"*\";}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"799dbe03-d659-4f0d-8598-926a4ddb37c0\";a:10:{s:4:\"name\";s:9:\"Alignment\";s:6:\"handle\";s:9:\"alignment\";s:12:\"instructions\";s:45:\"How should the copy in this block be aligned?\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:4:{i:0;a:3:{s:5:\"label\";s:4:\"Left\";s:5:\"value\";s:11:\"u-text-left\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:6:\"Center\";s:5:\"value\";s:13:\"u-text-center\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:5:\"Right\";s:5:\"value\";s:12:\"u-text-right\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:7:\"Justify\";s:5:\"value\";s:14:\"u-text-justify\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"d85da825-7ece-4810-af33-232c2cddf7d5\";a:10:{s:4:\"name\";s:7:\"Padding\";s:6:\"handle\";s:7:\"padding\";s:12:\"instructions\";s:25:\"Add padding to the block.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:7:{i:0;a:3:{s:5:\"label\";s:16:\"Add Full Padding\";s:5:\"value\";s:9:\"u-padding\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:22:\"Add Horizontal Padding\";s:5:\"value\";s:20:\"u-padding-horizontal\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:18:\"Add Padding Bottom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:16:\"Add Padding Left\";s:5:\"value\";s:14:\"u-padding-left\";s:7:\"default\";s:0:\"\";}i:6;a:3:{s:5:\"label\";s:17:\"Add Padding Right\";s:5:\"value\";s:15:\"u-padding-right\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"46892785-d8f7-443a-9215-a6fbbfc2e066\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:25:\"How thick is the padding?\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:5:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:4:\"Thin\";s:5:\"value\";s:5:\"-thin\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:5:\"Large\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:4:\"Huge\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}}}s:36:\"8cfe5e31-20a9-4ddc-ba3d-790f1b405450\";a:6:{s:4:\"name\";s:5:\"Image\";s:6:\"handle\";s:5:\"image\";s:9:\"sortOrder\";s:1:\"6\";s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:12:\"fieldLayouts\";a:1:{s:36:\"93482697-e9bb-4748-bd38-cd3eb28b0f93\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:10:{s:36:\"34b63d30-e96e-4923-8396-7f331ac44ccd\";a:2:{s:8:\"required\";s:1:\"1\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"d81bf538-6c2f-47cb-a776-ffda5ecb3da1\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}s:36:\"71df45f7-bad9-4989-8d4b-8e056b6e712a\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"3\";}s:36:\"efaf6859-2c1a-4909-bc9e-38bd725624ec\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"4\";}s:36:\"1393ae5b-e051-4f54-9c23-fea61b8ef0fe\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"5\";}s:36:\"ab8da4d3-dc99-4cb3-a978-347132b072ca\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"6\";}s:36:\"33b35b3f-2dee-492a-b10e-ae7ef65688f9\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"7\";}s:36:\"89593cd3-f8b6-4c0d-9060-e2e0eb2dde8e\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"8\";}s:36:\"a5c58651-f39a-4384-a7c6-28ad2390f2e9\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"9\";}s:36:\"a23aaf6c-855c-4031-b283-e5076716fa3a\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:2:\"10\";}}}}}}s:6:\"fields\";a:10:{s:36:\"34b63d30-e96e-4923-8396-7f331ac44ccd\";a:10:{s:4:\"name\";s:5:\"Image\";s:6:\"handle\";s:5:\"image\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:0:\"\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:1:\"1\";s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:7:\"sources\";a:1:{i:0;s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";}s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:5:\"large\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:12:\"Add an Image\";s:17:\"localizeRelations\";b:0;}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"d81bf538-6c2f-47cb-a776-ffda5ecb3da1\";a:10:{s:4:\"name\";s:12:\"Aspect Ratio\";s:6:\"handle\";s:11:\"aspectRatio\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:6:{i:0;a:3:{s:5:\"label\";s:4:\"16:9\";s:5:\"value\";s:12:\"u-ratio-16/9\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:3:\"1:1\";s:5:\"value\";s:11:\"u-ratio-1/1\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:3:\"4:3\";s:5:\"value\";s:11:\"u-ratio-4/3\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:3:\"2:3\";s:5:\"value\";s:11:\"u-ratio-2/3\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:6:\"Banner\";s:5:\"value\";s:13:\"u-ratio-36/10\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:4:\"none\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"efaf6859-2c1a-4909-bc9e-38bd725624ec\";a:10:{s:4:\"name\";s:7:\"Padding\";s:6:\"handle\";s:7:\"padding\";s:12:\"instructions\";s:25:\"Add padding to the block.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:7:{i:0;a:3:{s:5:\"label\";s:16:\"Add Full Padding\";s:5:\"value\";s:9:\"u-padding\";s:7:\"default\";s:0:\"\";}i:1;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:22:\"Add Horizontal Padding\";s:5:\"value\";s:20:\"u-padding-horizontal\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:18:\"Add Padding Bottom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:16:\"Add Padding Left\";s:5:\"value\";s:14:\"u-padding-left\";s:7:\"default\";s:0:\"\";}i:6;a:3:{s:5:\"label\";s:17:\"Add Padding Right\";s:5:\"value\";s:15:\"u-padding-right\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"89593cd3-f8b6-4c0d-9060-e2e0eb2dde8e\";a:10:{s:4:\"name\";s:16:\"Enable Lightcase\";s:6:\"handle\";s:15:\"enableLightcase\";s:12:\"instructions\";s:97:\"When enabled users can click on the image to view a larger version of the image in a popup modal.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:24:\"craft\\fields\\Lightswitch\";s:8:\"settings\";a:1:{s:7:\"default\";s:0:\"\";}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:7:\"boolean\";}s:36:\"a23aaf6c-855c-4031-b283-e5076716fa3a\";a:10:{s:4:\"name\";s:7:\"Overlay\";s:6:\"handle\";s:7:\"overlay\";s:12:\"instructions\";s:48:\"Select an optional overlay color for your image.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:5:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:4:\"none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:5:\"Light\";s:5:\"value\";s:13:\"35,35,35,0.33\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:6:\"Medium\";s:5:\"value\";s:12:\"35,35,35,0.6\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:4:\"Dark\";s:5:\"value\";s:13:\"35,35,35,0.87\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:3:\"Red\";s:5:\"value\";s:13:\"242,86,82,0.6\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"71df45f7-bad9-4989-8d4b-8e056b6e712a\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:25:\"How thick is the padding?\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:5:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:4:\"Thin\";s:5:\"value\";s:5:\"-thin\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:5:\"Large\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:4:\"Huge\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"33b35b3f-2dee-492a-b10e-ae7ef65688f9\";a:10:{s:4:\"name\";s:9:\"Crop Zoom\";s:6:\"handle\";s:8:\"cropZoom\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Number\";s:8:\"settings\";a:5:{s:12:\"defaultValue\";s:1:\"1\";s:3:\"min\";s:1:\"1\";s:3:\"max\";s:1:\"3\";s:8:\"decimals\";s:1:\"2\";s:4:\"size\";N;}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:12:\"decimal(3,2)\";}s:36:\"1393ae5b-e051-4f54-9c23-fea61b8ef0fe\";a:10:{s:4:\"name\";s:11:\"Image Width\";s:6:\"handle\";s:10:\"imageWidth\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Number\";s:8:\"settings\";a:5:{s:12:\"defaultValue\";s:3:\"840\";s:3:\"min\";s:3:\"250\";s:3:\"max\";s:4:\"1920\";s:8:\"decimals\";i:0;s:4:\"size\";N;}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:11:\"smallint(4)\";}s:36:\"a5c58651-f39a-4384-a7c6-28ad2390f2e9\";a:10:{s:4:\"name\";s:9:\"Grayscale\";s:6:\"handle\";s:9:\"grayscale\";s:12:\"instructions\";s:41:\"Enable to convert the image to grayscale.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:24:\"craft\\fields\\Lightswitch\";s:8:\"settings\";a:1:{s:7:\"default\";s:0:\"\";}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:7:\"boolean\";}s:36:\"ab8da4d3-dc99-4cb3-a978-347132b072ca\";a:10:{s:4:\"name\";s:15:\"Image Alignment\";s:6:\"handle\";s:14:\"imageAlignment\";s:12:\"instructions\";s:53:\"Align applied to images with an Aspect Ratio of None.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:3:{i:0;a:3:{s:5:\"label\";s:4:\"Left\";s:5:\"value\";s:11:\"u-text-left\";s:7:\"default\";s:0:\"\";}i:1;a:3:{s:5:\"label\";s:6:\"Center\";s:5:\"value\";s:13:\"u-text-center\";s:7:\"default\";s:1:\"1\";}i:2;a:3:{s:5:\"label\";s:5:\"Right\";s:5:\"value\";s:12:\"u-text-right\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}}}s:36:\"86843e26-821b-41e7-8e3e-87321802c139\";a:6:{s:4:\"name\";s:7:\"Buttons\";s:6:\"handle\";s:7:\"buttons\";s:9:\"sortOrder\";s:1:\"7\";s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:12:\"fieldLayouts\";a:1:{s:36:\"e17d5a6b-1851-4037-9aba-45296cc932dc\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:4:{s:36:\"16afd3ef-94de-4db2-87a1-26b358f4aa61\";a:2:{s:8:\"required\";s:1:\"1\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"972a946c-797a-4f9c-8681-aaa29ef67856\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}s:36:\"afa0d0fd-406e-4d41-9c96-e5f5d59b058f\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"3\";}s:36:\"1d7cea56-a8d6-4502-874c-779e624b3bf5\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"4\";}}}}}}s:6:\"fields\";a:4:{s:36:\"16afd3ef-94de-4db2-87a1-26b358f4aa61\";a:10:{s:4:\"name\";s:7:\"Buttons\";s:6:\"handle\";s:7:\"buttons\";s:12:\"instructions\";s:27:\"Add call to action buttons.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:39:\"verbb\\supertable\\fields\\SuperTableField\";s:8:\"settings\";a:8:{s:7:\"minRows\";s:1:\"1\";s:7:\"maxRows\";s:1:\"3\";s:14:\"localizeBlocks\";b:0;s:11:\"staticField\";s:0:\"\";s:7:\"columns\";a:2:{i:40;a:1:{s:5:\"width\";s:0:\"\";}i:41;a:1:{s:5:\"width\";s:0:\"\";}}s:12:\"contentTable\";N;s:11:\"fieldLayout\";s:6:\"matrix\";s:14:\"selectionLabel\";s:12:\"Add a Button\";}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"972a946c-797a-4f9c-8681-aaa29ef67856\";a:10:{s:4:\"name\";s:9:\"Alignment\";s:6:\"handle\";s:9:\"alignment\";s:12:\"instructions\";s:34:\"How should the buttons be aligned?\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:5:{i:0;a:3:{s:5:\"label\";s:12:\"Left Aligned\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:14:\"Center Aligned\";s:5:\"value\";s:15:\"-justify-center\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:13:\"Right Aligned\";s:5:\"value\";s:12:\"-justify-end\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:13:\"Space Between\";s:5:\"value\";s:14:\"-space-between\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:12:\"Space Around\";s:5:\"value\";s:13:\"-space-around\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"afa0d0fd-406e-4d41-9c96-e5f5d59b058f\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:25:\"How thick is the padding?\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:5:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:4:\"Thin\";s:5:\"value\";s:5:\"-thin\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:5:\"Large\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:4:\"Huge\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"1d7cea56-a8d6-4502-874c-779e624b3bf5\";a:10:{s:4:\"name\";s:7:\"Padding\";s:6:\"handle\";s:7:\"padding\";s:12:\"instructions\";s:25:\"Add padding to the block.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:7:{i:0;a:3:{s:5:\"label\";s:16:\"Add Full Padding\";s:5:\"value\";s:9:\"u-padding\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:22:\"Add Horizontal Padding\";s:5:\"value\";s:20:\"u-padding-horizontal\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:18:\"Add Padding Buttom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:16:\"Add Padding Left\";s:5:\"value\";s:14:\"u-padding-left\";s:7:\"default\";s:0:\"\";}i:6;a:3:{s:5:\"label\";s:17:\"Add Padding Right\";s:5:\"value\";s:15:\"u-padding-right\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}}}s:36:\"42b013df-72dc-41a5-941f-d7a299502e38\";a:6:{s:4:\"name\";s:10:\"Pull Quote\";s:6:\"handle\";s:9:\"pullQuote\";s:9:\"sortOrder\";s:1:\"8\";s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:12:\"fieldLayouts\";a:1:{s:36:\"cbe6b628-b4ac-4766-88ff-b47c38af7989\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:5:{s:36:\"71e1aa18-0063-405d-955e-74b5ec1514b2\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"cbdbc09b-11a0-4b1a-a0bd-5b991c3c75eb\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}s:36:\"ebbd92ad-ec15-4d07-ae91-eccbb307569b\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"3\";}s:36:\"f544af32-b279-49f9-9fa4-60c1d0391b85\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"4\";}s:36:\"984c9a76-6153-41af-9f4b-fbff36a88709\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"5\";}}}}}}s:6:\"fields\";a:5:{s:36:\"71e1aa18-0063-405d-955e-74b5ec1514b2\";a:10:{s:4:\"name\";s:4:\"Body\";s:6:\"handle\";s:4:\"body\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"cbdbc09b-11a0-4b1a-a0bd-5b991c3c75eb\";a:10:{s:4:\"name\";s:6:\"Source\";s:6:\"handle\";s:6:\"source\";s:12:\"instructions\";s:40:\"Optional source or author for the quote.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"ebbd92ad-ec15-4d07-ae91-eccbb307569b\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:25:\"How thick is the padding?\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:6:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:4:\"Thin\";s:5:\"value\";s:5:\"-thin\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:5:\"Large\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:4:\"Huge\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:7:\"Massive\";s:5:\"value\";s:3:\"-x6\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"f544af32-b279-49f9-9fa4-60c1d0391b85\";a:10:{s:4:\"name\";s:7:\"Padding\";s:6:\"handle\";s:7:\"padding\";s:12:\"instructions\";s:25:\"Add padding to the block.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:7:{i:0;a:3:{s:5:\"label\";s:16:\"Add Full Padding\";s:5:\"value\";s:9:\"u-padding\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:22:\"Add Horizontal Padding\";s:5:\"value\";s:20:\"u-padding-horizontal\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:18:\"Add Padding Bottom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:16:\"Add Padding Left\";s:5:\"value\";s:14:\"u-padding-left\";s:7:\"default\";s:0:\"\";}i:6;a:3:{s:5:\"label\";s:17:\"Add Padding Right\";s:5:\"value\";s:15:\"u-padding-right\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"984c9a76-6153-41af-9f4b-fbff36a88709\";a:10:{s:4:\"name\";s:11:\"Quote Style\";s:6:\"handle\";s:10:\"quoteStyle\";s:12:\"instructions\";s:27:\"Select a quote block style.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:2:{i:0;a:3:{s:5:\"label\";s:5:\"Large\";s:5:\"value\";s:6:\"-large\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:5:\"Block\";s:5:\"value\";s:6:\"-block\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}}}s:36:\"411496be-9759-4334-803e-790121fdee23\";a:6:{s:4:\"name\";s:7:\"Gallery\";s:6:\"handle\";s:7:\"gallery\";s:9:\"sortOrder\";s:1:\"9\";s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:12:\"fieldLayouts\";a:1:{s:36:\"57b3a20d-8b2a-4bce-a97d-b60a88dc71d9\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:6:{s:36:\"00ccd03b-0a70-4fed-a14d-a0b846ecad51\";a:2:{s:8:\"required\";s:1:\"1\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"0bf2b1b8-e3d3-47f7-bc51-628bd536b65c\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}s:36:\"418c41b9-d777-4c60-b660-7f8421a7f12d\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"3\";}s:36:\"f40a44dd-80c9-41bd-92f8-11ea5934e78d\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"4\";}s:36:\"0ed585b2-9d94-4ebc-a088-f12f4474ecf4\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"5\";}s:36:\"3b24986d-c663-48f7-86ca-a778bebbcd82\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"6\";}}}}}}s:6:\"fields\";a:6:{s:36:\"00ccd03b-0a70-4fed-a14d-a0b846ecad51\";a:10:{s:4:\"name\";s:6:\"Slides\";s:6:\"handle\";s:6:\"slides\";s:12:\"instructions\";s:26:\"Add slides to the gallery.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:0:\"\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:1:\"1\";s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:7:\"sources\";a:1:{i:0;s:43:\"volume:ea6beeac-3da3-43fe-a530-47032076abb2\";}s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:5:\"large\";s:5:\"limit\";s:0:\"\";s:14:\"selectionLabel\";s:12:\"Add an Image\";s:17:\"localizeRelations\";b:0;}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"0bf2b1b8-e3d3-47f7-bc51-628bd536b65c\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:25:\"How thick is the padding?\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:5:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:4:\"Thin\";s:5:\"value\";s:5:\"-thin\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:5:\"Large\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:4:\"Huge\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"418c41b9-d777-4c60-b660-7f8421a7f12d\";a:10:{s:4:\"name\";s:7:\"Padding\";s:6:\"handle\";s:7:\"padding\";s:12:\"instructions\";s:25:\"Add padding to the block.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:7:{i:0;a:3:{s:5:\"label\";s:16:\"Add Full Padding\";s:5:\"value\";s:9:\"u-padding\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:22:\"Add Horizontal Padding\";s:5:\"value\";s:20:\"u-padding-horizontal\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:18:\"Add Padding Bottom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:16:\"Add Padding Left\";s:5:\"value\";s:14:\"u-padding-left\";s:7:\"default\";s:0:\"\";}i:6;a:3:{s:5:\"label\";s:17:\"Add Padding Right\";s:5:\"value\";s:15:\"u-padding-right\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"f40a44dd-80c9-41bd-92f8-11ea5934e78d\";a:10:{s:4:\"name\";s:16:\"Slide Transition\";s:6:\"handle\";s:15:\"slideTransition\";s:12:\"instructions\";s:109:\"Select how fast the slides transition. Setting this option to manual forces the user initiate the transition.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:4:{i:0;a:3:{s:5:\"label\";s:6:\"Manual\";s:5:\"value\";s:2:\"-1\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:4:\"Slow\";s:5:\"value\";s:2:\"12\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:6:\"Medium\";s:5:\"value\";s:1:\"7\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:4:\"Fast\";s:5:\"value\";s:1:\"5\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"0ed585b2-9d94-4ebc-a088-f12f4474ecf4\";a:10:{s:4:\"name\";s:5:\"Style\";s:6:\"handle\";s:5:\"style\";s:12:\"instructions\";s:23:\"Select a gallery style.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:4:{i:0;a:3:{s:5:\"label\";s:4:\"Fade\";s:5:\"value\";s:4:\"fade\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:5:\"Slide\";s:5:\"value\";s:5:\"slide\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:5:\"Stack\";s:5:\"value\";s:5:\"stack\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:8:\"Parallax\";s:5:\"value\";s:8:\"parallax\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"3b24986d-c663-48f7-86ca-a778bebbcd82\";a:10:{s:4:\"name\";s:12:\"Aspect Ratio\";s:6:\"handle\";s:11:\"aspectRatio\";s:12:\"instructions\";s:34:\"Select the galleries aspect ratio.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:3:{i:0;a:3:{s:5:\"label\";s:3:\"1:1\";s:5:\"value\";s:11:\"u-ratio-1/1\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:3:\"2:3\";s:5:\"value\";s:11:\"u-ratio-2/3\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:4:\"16:9\";s:5:\"value\";s:12:\"u-ratio-16/9\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}}}s:36:\"2cb049e6-b35a-4271-8861-0bbde459b042\";a:6:{s:4:\"name\";s:9:\"Accordion\";s:6:\"handle\";s:9:\"accordion\";s:9:\"sortOrder\";s:2:\"10\";s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:12:\"fieldLayouts\";a:1:{s:36:\"94c10d74-960d-479e-85fd-ece5fa16eaeb\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:4:{s:36:\"89bb2fb3-11df-43a8-bc0e-dc9282624357\";a:2:{s:8:\"required\";s:1:\"1\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"5842ae73-b069-45a3-b28a-0149781ddbea\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}s:36:\"b5e83c8a-e3ac-4e7f-aa5b-ae31369fe8b2\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"3\";}s:36:\"f8b603ed-7622-42e8-a6ca-022ec1da1159\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"4\";}}}}}}s:6:\"fields\";a:4:{s:36:\"89bb2fb3-11df-43a8-bc0e-dc9282624357\";a:10:{s:4:\"name\";s:4:\"Rows\";s:6:\"handle\";s:4:\"rows\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:39:\"verbb\\supertable\\fields\\SuperTableField\";s:8:\"settings\";a:8:{s:7:\"minRows\";s:0:\"\";s:7:\"maxRows\";s:0:\"\";s:14:\"localizeBlocks\";b:0;s:11:\"staticField\";s:0:\"\";s:7:\"columns\";a:5:{i:61;a:1:{s:5:\"width\";s:0:\"\";}i:62;a:1:{s:5:\"width\";s:0:\"\";}i:71;a:1:{s:5:\"width\";s:0:\"\";}i:72;a:1:{s:5:\"width\";s:0:\"\";}i:73;a:1:{s:5:\"width\";s:0:\"\";}}s:12:\"contentTable\";N;s:11:\"fieldLayout\";s:3:\"row\";s:14:\"selectionLabel\";s:0:\"\";}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"5842ae73-b069-45a3-b28a-0149781ddbea\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:25:\"How thick is the padding?\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:5:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:4:\"Thin\";s:5:\"value\";s:5:\"-thin\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:5:\"Large\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:4:\"Huge\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"b5e83c8a-e3ac-4e7f-aa5b-ae31369fe8b2\";a:10:{s:4:\"name\";s:7:\"Padding\";s:6:\"handle\";s:7:\"padding\";s:12:\"instructions\";s:25:\"Add padding to the block.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:7:{i:0;a:3:{s:5:\"label\";s:16:\"Add Full Padding\";s:5:\"value\";s:9:\"u-padding\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:22:\"Add Horizontal Padding\";s:5:\"value\";s:20:\"u-padding-horizontal\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:18:\"Add Padding Buttom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:16:\"Add Padding Left\";s:5:\"value\";s:14:\"u-padding-left\";s:7:\"default\";s:0:\"\";}i:6;a:3:{s:5:\"label\";s:17:\"Add Padding Right\";s:5:\"value\";s:15:\"u-padding-right\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"f8b603ed-7622-42e8-a6ca-022ec1da1159\";a:10:{s:4:\"name\";s:9:\"Multi Row\";s:6:\"handle\";s:8:\"multiRow\";s:12:\"instructions\";s:124:\"When enabled users can open up several rows. When disabled when a user opens a row the previously opened row will be closed.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:24:\"craft\\fields\\Lightswitch\";s:8:\"settings\";a:1:{s:7:\"default\";s:0:\"\";}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:7:\"boolean\";}}}s:36:\"3bf9043f-ddd4-4d72-b83d-c984f46fdecf\";a:6:{s:4:\"name\";s:4:\"List\";s:6:\"handle\";s:4:\"list\";s:9:\"sortOrder\";s:2:\"11\";s:5:\"field\";s:36:\"d1fe1a49-a8bf-46ab-ac74-d563effe3be7\";s:12:\"fieldLayouts\";a:1:{s:36:\"54e4b974-31e5-45f1-80c3-8074ec779330\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:5:{s:36:\"9fcae5d9-54cc-4ce1-9ade-6fa31442abf1\";a:2:{s:8:\"required\";s:1:\"1\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"0c87ae8e-ce72-414a-8f65-38af1031d8bc\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}s:36:\"de8d5f7b-33fb-44be-b39a-2eab11dc3b9f\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"3\";}s:36:\"fd4b318a-37e0-4db3-b40c-bb76badfae2e\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"4\";}s:36:\"462274cc-3cdd-49e8-83f2-c197f47959e8\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"5\";}}}}}}s:6:\"fields\";a:5:{s:36:\"9fcae5d9-54cc-4ce1-9ade-6fa31442abf1\";a:10:{s:4:\"name\";s:10:\"List Items\";s:6:\"handle\";s:9:\"listItems\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:39:\"verbb\\supertable\\fields\\SuperTableField\";s:8:\"settings\";a:8:{s:7:\"minRows\";s:1:\"1\";s:7:\"maxRows\";s:0:\"\";s:14:\"localizeBlocks\";b:0;s:11:\"staticField\";s:0:\"\";s:7:\"columns\";a:1:{i:66;a:1:{s:5:\"width\";s:0:\"\";}}s:12:\"contentTable\";N;s:11:\"fieldLayout\";s:3:\"row\";s:14:\"selectionLabel\";s:0:\"\";}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"0c87ae8e-ce72-414a-8f65-38af1031d8bc\";a:10:{s:4:\"name\";s:12:\"Padding Size\";s:6:\"handle\";s:11:\"paddingSize\";s:12:\"instructions\";s:25:\"How thick is the padding?\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:5:{i:0;a:3:{s:5:\"label\";s:4:\"None\";s:5:\"value\";s:5:\"-none\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:4:\"Thin\";s:5:\"value\";s:5:\"-thin\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:6:\"Normal\";s:5:\"value\";s:0:\"\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:5:\"Large\";s:5:\"value\";s:3:\"-x2\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:4:\"Huge\";s:5:\"value\";s:3:\"-x4\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"de8d5f7b-33fb-44be-b39a-2eab11dc3b9f\";a:10:{s:4:\"name\";s:7:\"Padding\";s:6:\"handle\";s:7:\"padding\";s:12:\"instructions\";s:25:\"Add padding to the block.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:7:{i:0;a:3:{s:5:\"label\";s:16:\"Add Full Padding\";s:5:\"value\";s:9:\"u-padding\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:20:\"Add Vertical Padding\";s:5:\"value\";s:18:\"u-padding-vertical\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:22:\"Add Horizontal Padding\";s:5:\"value\";s:20:\"u-padding-horizontal\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:15:\"Add Padding Top\";s:5:\"value\";s:13:\"u-padding-top\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:18:\"Add Padding Bottom\";s:5:\"value\";s:16:\"u-padding-bottom\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:16:\"Add Padding Left\";s:5:\"value\";s:14:\"u-padding-left\";s:7:\"default\";s:0:\"\";}i:6;a:3:{s:5:\"label\";s:17:\"Add Padding Right\";s:5:\"value\";s:15:\"u-padding-right\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"fd4b318a-37e0-4db3-b40c-bb76badfae2e\";a:10:{s:4:\"name\";s:9:\"Alignment\";s:6:\"handle\";s:9:\"alignment\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:3:{i:0;a:3:{s:5:\"label\";s:4:\"Left\";s:5:\"value\";s:11:\"u-text-left\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:6:\"Center\";s:5:\"value\";s:13:\"u-text-center\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:5:\"Right\";s:5:\"value\";s:12:\"u-text-right\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"462274cc-3cdd-49e8-83f2-c197f47959e8\";a:10:{s:4:\"name\";s:10:\"List Style\";s:6:\"handle\";s:9:\"listStyle\";s:12:\"instructions\";s:28:\"Select a style for the list.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:2:{i:0;a:3:{s:5:\"label\";s:7:\"Default\";s:5:\"value\";s:8:\"-default\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:4:\"Plus\";s:5:\"value\";s:5:\"-plus\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}}}}s:7:\"volumes\";a:2:{s:36:\"ea6beeac-3da3-43fe-a530-47032076abb2\";a:8:{s:4:\"name\";s:6:\"Images\";s:6:\"handle\";s:6:\"images\";s:4:\"type\";s:19:\"craft\\volumes\\Local\";s:7:\"hasUrls\";s:1:\"1\";s:3:\"url\";s:19:\"@web/uploads/images\";s:8:\"settings\";a:1:{s:4:\"path\";s:23:\"@webroot/uploads/images\";}s:9:\"sortOrder\";s:1:\"1\";s:12:\"fieldLayouts\";a:1:{s:36:\"47c48e31-d23e-4089-b483-3ecfc95a95b0\";a:1:{s:4:\"tabs\";a:0:{}}}}s:36:\"02433cef-1aec-4478-8f75-f5570480c436\";a:8:{s:4:\"name\";s:6:\"Videos\";s:6:\"handle\";s:6:\"videos\";s:4:\"type\";s:19:\"craft\\volumes\\Local\";s:7:\"hasUrls\";s:1:\"1\";s:3:\"url\";s:19:\"@web/uploads/videos\";s:8:\"settings\";a:1:{s:4:\"path\";s:23:\"@webroot/uploads/videos\";}s:9:\"sortOrder\";s:1:\"2\";s:12:\"fieldLayouts\";a:1:{s:36:\"ecfdc16e-4402-41a4-a5af-09785582316a\";a:1:{s:4:\"tabs\";a:0:{}}}}}s:14:\"categoryGroups\";a:0:{}s:9:\"tagGroups\";a:0:{}s:5:\"users\";a:5:{s:24:\"requireEmailVerification\";b:1;s:23:\"allowPublicRegistration\";b:0;s:12:\"defaultGroup\";N;s:14:\"photoVolumeUid\";N;s:12:\"photoSubpath\";s:0:\"\";}s:10:\"globalSets\";a:0:{}s:7:\"plugins\";a:7:{s:12:\"eager-beaver\";a:4:{s:8:\"settings\";N;s:10:\"licenseKey\";N;s:7:\"enabled\";s:1:\"1\";s:13:\"schemaVersion\";s:5:\"1.0.0\";}s:6:\"imager\";a:4:{s:8:\"settings\";N;s:10:\"licenseKey\";N;s:7:\"enabled\";s:1:\"1\";s:13:\"schemaVersion\";s:5:\"2.0.0\";}s:6:\"splash\";a:4:{s:8:\"settings\";a:4:{s:6:\"volume\";s:1:\"1\";s:11:\"authorField\";s:0:\"\";s:14:\"authorUrlField\";s:0:\"\";s:10:\"colorField\";s:0:\"\";}s:10:\"licenseKey\";N;s:7:\"enabled\";s:1:\"1\";s:13:\"schemaVersion\";s:5:\"3.0.0\";}s:8:\"freeform\";a:4:{s:8:\"settings\";a:33:{s:10:\"pluginName\";s:0:\"\";s:21:\"formTemplateDirectory\";s:15:\"_includes/forms\";s:22:\"emailTemplateDirectory\";N;s:20:\"emailTemplateStorage\";s:2:\"db\";s:11:\"defaultView\";s:9:\"dashboard\";s:17:\"fieldDisplayOrder\";s:4:\"name\";s:12:\"showTutorial\";s:1:\"1\";s:14:\"removeNewlines\";s:0:\"\";s:16:\"defaultTemplates\";s:0:\"\";s:13:\"footerScripts\";s:1:\"0\";s:17:\"formSubmitDisable\";s:1:\"1\";s:16:\"freeformHoneypot\";b:1;s:23:\"spamProtectionBehaviour\";s:16:\"simulate_success\";s:25:\"submissionThrottlingCount\";N;s:29:\"submissionThrottlingTimeFrame\";N;s:13:\"blockedEmails\";N;s:15:\"blockedKeywords\";N;s:20:\"blockedKeywordsError\";s:18:\"Invalid Entry Data\";s:18:\"blockedEmailsError\";s:21:\"Invalid Email Address\";s:26:\"showErrorsForBlockedEmails\";b:0;s:28:\"showErrorsForBlockedKeywords\";b:0;s:18:\"blockedIpAddresses\";N;s:27:\"purgableSubmissionAgeInDays\";s:1:\"0\";s:21:\"purgableSpamAgeInDays\";N;s:20:\"salesforce_client_id\";N;s:24:\"salesforce_client_secret\";N;s:19:\"salesforce_username\";N;s:19:\"salesforce_password\";N;s:17:\"spamFolderEnabled\";b:0;s:16:\"recaptchaEnabled\";b:0;s:12:\"recaptchaKey\";N;s:15:\"recaptchaSecret\";N;s:23:\"renderFormHtmlInCpViews\";s:1:\"1\";}s:10:\"licenseKey\";N;s:7:\"enabled\";s:1:\"1\";s:13:\"schemaVersion\";s:5:\"2.1.3\";}s:8:\"redactor\";a:4:{s:8:\"settings\";N;s:10:\"licenseKey\";N;s:7:\"enabled\";s:1:\"1\";s:13:\"schemaVersion\";s:5:\"2.2.1\";}s:11:\"super-table\";a:4:{s:8:\"settings\";N;s:10:\"licenseKey\";N;s:7:\"enabled\";s:1:\"1\";s:13:\"schemaVersion\";s:5:\"2.0.7\";}s:14:\"typedlinkfield\";a:4:{s:8:\"settings\";N;s:10:\"licenseKey\";N;s:7:\"enabled\";s:1:\"1\";s:13:\"schemaVersion\";s:5:\"1.0.0\";}}s:5:\"email\";a:5:{s:9:\"fromEmail\";s:19:\"no-reply@page.works\";s:8:\"fromName\";s:22:\"Papertrain Boilerplate\";s:8:\"template\";N;s:13:\"transportType\";s:37:\"craft\\mail\\transportadapters\\Sendmail\";s:17:\"transportSettings\";N;}s:6:\"system\";a:5:{s:7:\"edition\";s:4:\"solo\";s:4:\"live\";b:1;s:4:\"name\";s:22:\"Papertrain Boilerplate\";s:8:\"timeZone\";s:16:\"America/New_York\";s:13:\"schemaVersion\";s:6:\"3.1.23\";}s:15:\"imageTransforms\";a:0:{}s:6:\"routes\";a:0:{}s:20:\"superTableBlockTypes\";a:3:{s:36:\"e1d8381e-e9da-4f7a-897a-7ca3280e4deb\";a:3:{s:5:\"field\";s:36:\"16afd3ef-94de-4db2-87a1-26b358f4aa61\";s:6:\"fields\";a:2:{s:36:\"42cf42aa-aed4-47d0-b3f9-8ee81b134df4\";a:10:{s:4:\"name\";s:4:\"Link\";s:6:\"handle\";s:10:\"buttonLink\";s:12:\"instructions\";s:38:\"Where should the button take the user?\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:31:\"typedlinkfield\\fields\\LinkField\";s:8:\"settings\";a:9:{s:15:\"allowCustomText\";s:1:\"1\";s:16:\"allowedLinkNames\";a:7:{i:1;s:5:\"asset\";i:2;s:8:\"category\";i:3;s:5:\"entry\";i:6;s:6:\"custom\";i:7;s:5:\"email\";i:8;s:3:\"tel\";i:9;s:3:\"url\";}s:11:\"allowTarget\";s:1:\"1\";s:14:\"autoNoReferrer\";b:0;s:15:\"defaultLinkName\";s:5:\"entry\";s:11:\"defaultText\";s:0:\"\";s:15:\"enableAriaLabel\";s:0:\"\";s:11:\"enableTitle\";s:0:\"\";s:12:\"typeSettings\";a:9:{s:5:\"asset\";a:1:{s:7:\"sources\";s:1:\"*\";}s:8:\"category\";a:1:{s:7:\"sources\";s:1:\"*\";}s:5:\"entry\";a:1:{s:7:\"sources\";s:1:\"*\";}s:4:\"site\";a:1:{s:5:\"sites\";s:1:\"*\";}s:4:\"user\";a:1:{s:7:\"sources\";s:1:\"*\";}s:6:\"custom\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:5:\"email\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"tel\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"url\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}}}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"ee572988-84e1-46e8-8b29-c23ce20bac43\";a:10:{s:4:\"name\";s:12:\"Button Style\";s:6:\"handle\";s:11:\"buttonStyle\";s:12:\"instructions\";s:27:\"How should the button look?\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:6:{i:0;a:3:{s:5:\"label\";s:19:\"Basic Action Button\";s:5:\"value\";s:5:\"-base\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:18:\"Solid Style Button\";s:5:\"value\";s:6:\"-solid\";s:7:\"default\";s:0:\"\";}i:2;a:3:{s:5:\"label\";s:20:\"Outline Style Button\";s:5:\"value\";s:8:\"-outline\";s:7:\"default\";s:0:\"\";}i:3;a:3:{s:5:\"label\";s:19:\"Raised Style Button\";s:5:\"value\";s:7:\"-raised\";s:7:\"default\";s:0:\"\";}i:4;a:3:{s:5:\"label\";s:26:\"Rounded Solid Style Button\";s:5:\"value\";s:13:\"-solid -round\";s:7:\"default\";s:0:\"\";}i:5;a:3:{s:5:\"label\";s:28:\"Rounded Outline Style Button\";s:5:\"value\";s:15:\"-outline -round\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"975abb82-2d2e-45a0-8cef-bb19c73b3d2e\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:2:{s:36:\"42cf42aa-aed4-47d0-b3f9-8ee81b134df4\";a:2:{s:8:\"required\";s:1:\"1\";s:9:\"sortOrder\";i:1;}s:36:\"ee572988-84e1-46e8-8b29-c23ce20bac43\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";i:2;}}}}}}}s:36:\"061368e4-5312-4599-93a2-c40f7165b4b6\";a:3:{s:5:\"field\";s:36:\"89bb2fb3-11df-43a8-bc0e-dc9282624357\";s:6:\"fields\";a:5:{s:36:\"c7b72005-a498-41f9-979d-67d815d408e3\";a:10:{s:4:\"name\";s:7:\"Heading\";s:6:\"handle\";s:7:\"heading\";s:12:\"instructions\";s:33:\"What is the heading for this row?\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:2:\"32\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"a255042b-ffbc-48c6-87b5-dff502c8251d\";a:10:{s:4:\"name\";s:4:\"Body\";s:6:\"handle\";s:4:\"body\";s:12:\"instructions\";s:17:\"Copy for the row.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:20:\"craft\\redactor\\Field\";s:8:\"settings\";a:7:{s:14:\"redactorConfig\";s:10:\"Basic.json\";s:14:\"purifierConfig\";s:0:\"\";s:11:\"cleanupHtml\";s:1:\"1\";s:10:\"purifyHtml\";s:1:\"1\";s:10:\"columnType\";s:4:\"text\";s:16:\"availableVolumes\";s:0:\"\";s:19:\"availableTransforms\";s:1:\"*\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"d5822862-1769-4f56-bdd9-03d7aeb583a1\";a:10:{s:4:\"name\";s:4:\"List\";s:6:\"handle\";s:4:\"list\";s:12:\"instructions\";s:79:\"Optional list element for the row. The list will be placed below any body copy.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:18:\"craft\\fields\\Table\";s:8:\"settings\";a:6:{s:11:\"addRowLabel\";s:15:\"Add a List Item\";s:7:\"maxRows\";s:2:\"18\";s:7:\"minRows\";s:1:\"0\";s:7:\"columns\";a:1:{s:4:\"col1\";a:4:{s:7:\"heading\";s:9:\"List Item\";s:6:\"handle\";s:8:\"listItem\";s:5:\"width\";s:0:\"\";s:4:\"type\";s:10:\"singleline\";}}s:8:\"defaults\";a:0:{}s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"43eacc7a-4e10-4194-875c-d90071579149\";a:10:{s:4:\"name\";s:10:\"Split List\";s:6:\"handle\";s:9:\"splitList\";s:12:\"instructions\";s:95:\"When enabled and the list contains items the list will be placed to the right of the body copy.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:24:\"craft\\fields\\Lightswitch\";s:8:\"settings\";a:1:{s:7:\"default\";s:0:\"\";}s:17:\"contentColumnType\";s:7:\"boolean\";s:10:\"fieldGroup\";N;}s:36:\"b337860e-6281-433f-aa69-2d01b5f8e912\";a:10:{s:4:\"name\";s:10:\"List Style\";s:6:\"handle\";s:9:\"listStyle\";s:12:\"instructions\";s:25:\"Select a list style type.\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:21:\"craft\\fields\\Dropdown\";s:8:\"settings\";a:1:{s:7:\"options\";a:2:{i:0;a:3:{s:5:\"label\";s:7:\"Default\";s:5:\"value\";s:8:\"-default\";s:7:\"default\";s:1:\"1\";}i:1;a:3:{s:5:\"label\";s:4:\"Plus\";s:5:\"value\";s:5:\"-plus\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"0ff68a13-d28a-4bab-bfdd-ea638bb9166b\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:5:{s:36:\"c7b72005-a498-41f9-979d-67d815d408e3\";a:2:{s:8:\"required\";s:1:\"1\";s:9:\"sortOrder\";i:1;}s:36:\"a255042b-ffbc-48c6-87b5-dff502c8251d\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";i:2;}s:36:\"d5822862-1769-4f56-bdd9-03d7aeb583a1\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";i:3;}s:36:\"43eacc7a-4e10-4194-875c-d90071579149\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";i:4;}s:36:\"b337860e-6281-433f-aa69-2d01b5f8e912\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";i:5;}}}}}}}s:36:\"326dbc91-cc61-404b-ad31-73f972c6e3de\";a:3:{s:5:\"field\";s:36:\"9fcae5d9-54cc-4ce1-9ade-6fa31442abf1\";s:6:\"fields\";a:1:{s:36:\"fc1bf467-a95f-4dff-99b8-b2e3ccb556d5\";a:10:{s:4:\"name\";s:4:\"Item\";s:6:\"handle\";s:4:\"item\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:20:\"craft\\redactor\\Field\";s:8:\"settings\";a:7:{s:14:\"redactorConfig\";s:10:\"Basic.json\";s:14:\"purifierConfig\";s:0:\"\";s:11:\"cleanupHtml\";s:1:\"1\";s:10:\"purifyHtml\";s:1:\"1\";s:10:\"columnType\";s:4:\"text\";s:16:\"availableVolumes\";s:0:\"\";s:19:\"availableTransforms\";s:1:\"*\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"89001764-e066-4ae4-91cb-a4eaf6d519aa\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:1:{s:36:\"fc1bf467-a95f-4dff-99b8-b2e3ccb556d5\";a:2:{s:8:\"required\";s:1:\"1\";s:9:\"sortOrder\";i:1;}}}}}}}}}','[]','rz6b5AVlJMvh','2018-10-17 19:43:46','2019-01-30 12:23:09','bdebff9e-a915-4f72-a9be-e9715430bcd0');

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
	(162,7,'plugin','m190120_000000_fix_supertablecontent_tables','2019-01-30 12:23:09','2019-01-30 12:23:09','2019-01-30 12:23:09','305191cd-d05d-4a5c-a6b3-2ed44cb6f4b2');

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
	(1,'eager-beaver','1.0.4','1.0.0','unknown',NULL,'2018-11-06 19:48:48','2018-11-06 19:48:48','2019-01-30 12:27:43','75e3b61a-23b8-440d-9ca8-02214229f452'),
	(2,'imager','v2.1.4','2.0.0','unknown',NULL,'2018-11-06 19:48:52','2018-11-06 19:48:52','2019-01-30 12:27:43','5880e16d-544d-40d8-a11e-18c07ee2cce6'),
	(3,'splash','3.0.2','3.0.0','unknown',NULL,'2018-11-06 20:03:24','2018-11-06 20:03:24','2019-01-30 12:27:43','7c311bf3-2d90-42f0-9a51-a4c6d4ed7132'),
	(5,'freeform','2.5.10','2.1.3','unknown',NULL,'2018-11-07 16:07:44','2018-11-07 16:07:44','2019-01-30 12:27:43','9010b6b3-f122-4d41-b17d-45d5d40ad60d'),
	(6,'redactor','2.3.0','2.2.1','unknown',NULL,'2018-11-21 13:02:36','2018-11-21 13:02:36','2019-01-30 12:27:43','fd1449da-2f55-4f0a-9ee8-bedac1c9d5f1'),
	(7,'super-table','2.1.5.3','2.0.7','unknown',NULL,'2018-11-28 19:02:30','2018-11-28 19:02:30','2019-01-30 12:27:43','728b3ecb-d511-457b-886b-d3fd46365966'),
	(8,'typedlinkfield','1.0.16','1.0.0','unknown',NULL,'2018-11-28 19:02:32','2018-11-28 19:02:32','2019-01-30 12:27:43','e5f156c9-3384-4316-9e6d-25430506b1cd');

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
	('2033442a','@app/web/assets/tablesettings/dist'),
	('20f49bcd','@app/web/assets/utilities/dist'),
	('20f8adea','@lib/fabric'),
	('2241fa96','@lib/jquery.payment'),
	('231e4e64','@craft/web/assets/craftsupport/dist'),
	('238af62f','@app/web/assets/dashboard/dist'),
	('24bc9f51','@app/web/assets/cp/dist'),
	('24edd861','@app/web/assets/fields/dist'),
	('260413bb','@bower/jquery/dist'),
	('29192a75','@app/web/assets/utilities/dist'),
	('29def592','@app/web/assets/tablesettings/dist'),
	('2b18f9a9','@craft/web/assets/login/dist'),
	('2bac4b2e','@lib/jquery.payment'),
	('2c221303','@app/web/assets/recententries/dist'),
	('2cd0352','@app/web/assets/updater/dist'),
	('2e20b196','@vendor/craftcms/redactor/lib/redactor'),
	('2fe9a203','@bower/jquery/dist'),
	('316f348e','@app/web/assets/cp/dist'),
	('3279235a','@app/web/assets/feed/dist'),
	('328220ef','@lib/jquery-ui'),
	('32c342f','@app/web/assets/editentry/dist'),
	('355121f0','@app/web/assets/login/dist'),
	('35be79d4','@lib/garnishjs'),
	('35e3175c','@lib/element-resize-detector'),
	('3629699f','@app/web/assets/matrixsettings/dist'),
	('378be4c6','@lib/velocity'),
	('39716fcc','@lib/timepicker'),
	('39f1b8dc','@app/web/assets/recententries/dist'),
	('3a8db10c','@app/web/assets/updater/dist'),
	('3b37735','@app/web/assets/matrixsettings/dist'),
	('3c77395e','@app/web/assets/updates/dist'),
	('3e66557e','@lib/velocity'),
	('3f84d27a','@app/web/assets/pluginstore/dist'),
	('403755b6','@bower/jquery/dist'),
	('40745f49','@lib/fileupload'),
	('40d75ca3','@typedlinkfield/resources'),
	('4234e7c2','@lib/element-resize-detector'),
	('428fd95c','@app/web/assets/cp/dist'),
	('446b0914','@lib/velocity'),
	('4555d071','@lib/jquery-ui'),
	('45ee97eb','@craft/web/assets/editentry/dist'),
	('46c7ddc0','@app/web/assets/utilities/dist'),
	('48747f30','@app/web/assets/feed/dist'),
	('4b6268e4','@app/web/assets/cp/dist'),
	('4d5a4192','@app/web/assets/updater/dist'),
	('4d9f0d23','@lib/jquery.payment'),
	('4eeb3b45','@verbb/supertable/resources/dist'),
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
	('600c14a2','@lib/jquery.payment'),
	('6036e52','@lib/d3'),
	('6141bb3c','@app/web/assets/plugins/dist'),
	('63b551c3','@app/web/assets/recententries/dist'),
	('654855eb','@craft/web/assets/dashboard/dist'),
	('65846960','@lib/garnishjs'),
	('6607a1c6','@app/web/assets/craftsupport/dist'),
	('68950d07','@app/web/assets/updateswidget/dist'),
	('68e37b9','@lib/xregexp'),
	('694b7f78','@lib/timepicker'),
	('6b54c441','@app/web/assets/utilities/dist'),
	('6c4d29ea','@app/web/assets/updates/dist'),
	('6c6d8080','@app/web/assets/matrixsettings/dist'),
	('6da44c37','@bower/jquery/dist'),
	('6fa7fe43','@lib/element-resize-detector'),
	('70c2bd5e','@lib/fabric'),
	('70cfcedb','@lib/jquery-ui'),
	('712dee80','@app/web/assets/updater/dist'),
	('73b0e69b','@app/web/assets/dashboard/dist'),
	('74d7c8d5','@app/web/assets/fields/dist'),
	('76515211','@Solspace/Freeform/Resources'),
	('77c798b0','@verbb/supertable/resources/dist'),
	('781d944e','@lib'),
	('78c05f38','@app/web/assets/updater/dist'),
	('7909f6','@lib/element-resize-detector'),
	('79227f63','@lib/jquery-ui'),
	('79be2b5f','@app/web/assets/matrixsettings/dist'),
	('7a74559c','@lib/element-resize-detector'),
	('7a82b687','@craft/web/assets/matrixsettings/dist'),
	('7ac66330','@app/web/assets/login/dist'),
	('7c2bbb4a','@lib/velocity'),
	('7e33df0','@app/web/assets/feed/dist'),
	('7ef8764e','@app/web/assets/cp/dist'),
	('7f590e50','@typedlinkfield/resources'),
	('82f0ccd5','@lib/fabric'),
	('82fcfaf2','@app/web/assets/utilities/dist'),
	('831f9f0b','@app/web/assets/updater/dist'),
	('840c7284','@bower/jquery/dist'),
	('84b2b86d','@craft/web/assets/updateswidget/dist'),
	('855d6fcc','@verbb/supertable/resources/dist'),
	('86e5b95e','@app/web/assets/fields/dist'),
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
	('92f86d0','@app/web/assets/cp/dist'),
	('934acd34','@app/web/assets/updateswidget/dist'),
	('93fbb665','@lib/prismjs'),
	('958385f9','@lib/velocity'),
	('96d9802e','@lib/picturefill'),
	('9792e9d9','@app/web/assets/updates/dist'),
	('97b618eb','@lib/garnishjs'),
	('97b75181','@craft/web/assets/pluginstore/dist'),
	('987ca07f','@lib/d3'),
	('98e344b5','@lib/selectize'),
	('994b84e','@lib/element-resize-detector'),
	('999cf3dd','@app/web/assets/feed/dist'),
	('9d53fa02','@app/web/assets/editentry/dist'),
	('9d95673','@app/web/assets/craftsupport/dist'),
	('9dd861f5','@app/web/assets/craftsupport/dist'),
	('9e5ba953','@lib/garnishjs'),
	('9e7f5861','@app/web/assets/updates/dist'),
	('9ecc61fc','@craft/web/assets/cp/dist'),
	('a208f773','@app/web/assets/updates/dist'),
	('a3439e84','@lib/picturefill'),
	('a40b0f6d','@lib/d3'),
	('a4e7a246','@lib/jquery-touch-events'),
	('a57a9c0e','@app/web/assets/plugins/dist'),
	('a5ec68d','@app/web/assets/matrixsettings/dist'),
	('a661a8cf','@lib/prismjs'),
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
	('b0bda8d7','@app/web/assets/cp/dist'),
	('b2462ec2','@lib/fileupload'),
	('b3cbbc5c','@craft/web/assets/updater/dist'),
	('b483bda9','@app/web/assets/login/dist'),
	('b5705d34','@lib/selectize'),
	('b8a3f395','@lib/timepicker'),
	('ba08fa03','@craft/web/assets/recententries/dist'),
	('ba92164c','@app/web/assets/fields/dist'),
	('bbab9f7a','@lib/fileupload'),
	('bc692a07','@app/web/assets/deprecationerrors/dist'),
	('bdf53802','@app/web/assets/dashboard/dist'),
	('be8763c7','@lib/fabric'),
	('bf1c19be','@lib/xregexp'),
	('bfc4bd4','@lib/velocity'),
	('c00c04c4','@typedlinkfield/resources'),
	('c0e161b','@app/web/assets/matrix/dist'),
	('c1a6c310','@lib/fileupload'),
	('c2384960','@lib/d3'),
	('c2a7adaa','@lib/selectize'),
	('c2aeafff','@lib/timepicker'),
	('c349da03','@app/web/assets/plugins/dist'),
	('c370dd80','@app/web/assets/updateswidget/dist'),
	('c4af134c','@app/web/assets/sites/dist'),
	('c5b9954d','@lib/velocity'),
	('c717131d','@app/web/assets/editentry/dist'),
	('c8353129','@app/web/assets/matrix/dist'),
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
	('d17cb893','@app/web/assets/sites/dist'),
	('d2c6ea46','@app/web/assets/utilities/dist'),
	('d3258fbf','@app/web/assets/updater/dist'),
	('d4366230','@bower/jquery/dist'),
	('d47568cf','@lib/fileupload'),
	('d57b88d1','@app/web/assets/edituser/dist'),
	('d5df07ed','@app/web/assets/updates/dist'),
	('d7ebe2bf','@lib/d3'),
	('d847848','@lib/prismjs'),
	('d94ec2ee','@lib/picturefill'),
	('d99e3aa5','@lib/jquery.payment'),
	('db2a1e5c','@lib/jquery-ui'),
	('dbec8419','@app/web/assets/tablesettings/dist'),
	('dc164767','@lib/garnishjs'),
	('deeafe2c','@lib/jquery-touch-events'),
	('e087b863','@app/web/assets/cp/dist'),
	('e0d6ff53','@app/web/assets/fields/dist'),
	('e10e70b0','@lib/picturefill'),
	('e4064335','@craft/web/assets/fields/dist'),
	('e456f539','@lib/garnishjs'),
	('e4b9ad1d','@app/web/assets/login/dist'),
	('e4c38ad8','@lib/fabric'),
	('e6aa4c72','@lib/jquery-touch-events'),
	('e7b1d11d','@app/web/assets/dashboard/dist'),
	('ed9fb5b3','@app/web/assets/updates/dist'),
	('efab50e1','@lib/d3'),
	('f0272c1','@lib/jquery-touch-events'),
	('f1102107','@lib/fabric'),
	('f1855ee6','@lib/garnishjs'),
	('f2627ac2','@app/web/assets/dashboard/dist'),
	('f4bc4632','@lib/xregexp'),
	('f505548c','@app/web/assets/fields/dist'),
	('f734b155','@lib/timepicker'),
	('f73db300','@lib/selectize'),
	('f84c1e6c','@app/web/assets/updates/dist'),
	('f86cb706','@app/web/assets/matrixsettings/dist'),
	('f9e6714e','@lib/fileupload'),
	('fb3e48d3','@supercool/buttonbox/assetbundles/buttonbox/dist'),
	('fba6c9c5','@lib/element-resize-detector'),
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
	(26,1,'9wrA-oJPyXmeem7ahhz01_208HulHOY40XB5AqTPKrtankmc7pghImYmaHvLmP5HDfT7ryu1heAIrAb0Bxu9fKSBkzIY077WmgyG','2019-01-30 12:22:30','2019-01-30 12:28:01','40759c69-5f4e-43fb-9023-9f46f9f4001e');

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
	(1,'Papertrain Boilerplate','2018-10-17 19:43:46','2018-10-17 19:43:46',NULL,'f5eb95d0-c53e-4630-b230-91539b9e08b2');

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
	(1,1,1,'Papertrain Boilerplate','default','en-US',1,'@web/',1,'2018-10-17 19:43:46','2018-10-17 19:43:46',NULL,'ac246379-14f1-440a-82f2-90ef2b3e6443');

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
	(1,39,11,'2018-11-28 19:07:47','2019-01-30 12:23:09','e1d8381e-e9da-4f7a-897a-7ca3280e4deb'),
	(2,51,14,'2018-11-29 16:00:58','2018-11-29 19:01:53','bf867548-c6c8-4312-9ff6-501f221c53e8'),
	(3,60,16,'2018-12-07 12:52:41','2019-01-30 12:23:09','061368e4-5312-4599-93a2-c40f7165b4b6'),
	(4,65,18,'2018-12-07 17:24:19','2019-01-30 12:23:09','326dbc91-cc61-404b-ad31-73f972c6e3de');

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
	(1,'kylea@page.works',NULL,'','','kylea@page.works','$2y$13$.tPQ1u13.ms0je3ZbN1jnOaMx4ummoMNCAhSbB338o.Cs/6zf4swK',1,0,0,0,'2019-01-30 12:13:39','::1',NULL,NULL,'2018-12-14 16:58:06',NULL,1,NULL,NULL,NULL,0,'2018-12-08 13:41:32','2018-10-17 19:43:49','2019-01-30 12:13:39','e44094df-7375-4fff-a0a5-d88d45bbefcb');

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
	(1,4,'Images','images','craft\\volumes\\Local',1,'@web/uploads/images','{\"path\":\"@webroot/uploads/images\"}',1,'2018-11-06 19:33:37','2018-11-06 19:33:37',NULL,'ea6beeac-3da3-43fe-a530-47032076abb2'),
	(2,5,'Videos','videos','craft\\volumes\\Local',1,'@web/uploads/videos','{\"path\":\"@webroot/uploads/videos\"}',2,'2018-11-06 19:33:56','2018-11-06 19:33:56',NULL,'02433cef-1aec-4478-8f75-f5570480c436');

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
