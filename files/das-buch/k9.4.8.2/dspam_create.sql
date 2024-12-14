CREATE TABLE IF NOT EXISTS `dspam_preferences` ( 
	`uid` int(10) unsigned NOT NULL,
	`preference` varchar(32) NOT NULL,
	`value` varchar(64) NOT NULL,
	UNIQUE KEY `id_preferences_01` (`uid`,`preference`) ) 
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dspam_signature_data` ( 
	`uid` int(10) unsigned NOT NULL,
	`signature` char(32) NOT NULL,
	`data` longblob NOT NULL,
	`length` int(10) unsigned NOT NULL,
	`created_on` date NOT NULL,
	UNIQUE KEY `id_signature_data_01` (`uid`,`signature`), KEY `id_signature_data_02` (`created_on`) ) 
ENGINE=InnoDB
DEFAULT CHARSET=utf8
MAX_ROWS=2500000
AVG_ROW_LENGTH=8096;

CREATE TABLE IF NOT EXISTS `dspam_stats` (
	`uid` int(10) unsigned NOT NULL,
	`spam_learned` bigint(20) unsigned NOT NULL, 
	`innocent_learned` bigint(20) unsigned NOT NULL, 
	`spam_misclassified` bigint(20) unsigned NOT NULL, 
	`innocent_misclassified` bigint(20) unsigned NOT NULL, 
	`spam_corpusfed` bigint(20) unsigned NOT NULL, 
	`innocent_corpusfed` bigint(20) unsigned NOT NULL, 
	`spam_classified` bigint(20) unsigned NOT NULL, 
	`innocent_classified` bigint(20) unsigned NOT NULL,
PRIMARY KEY (`uid`) )
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dspam_token_data` ( 
	`uid` int(10) unsigned NOT NULL,
	`token` bigint(20) unsigned NOT NULL, 
	`spam_hits` bigint(20) unsigned NOT NULL, 
	`innocent_hits` bigint(20) unsigned NOT NULL, 
	`last_hit` date NOT NULL,
UNIQUE KEY `id_token_data_01` (`uid`,`token`) ) 
ENGINE=InnoDB
DEFAULT CHARSET=utf8
PACK_KEYS=1;

CREATE TABLE IF NOT EXISTS `dspam_virtual_uids` ( 
	`uid` int(10) unsigned NOT NULL AUTO_INCREMENT, 
	`username` varchar(128) NOT NULL,
PRIMARY KEY `id_virtual_uids_01` (`uid`), 
UNIQUE KEY `id_virtual_uids_02` (`username`) ) 
ENGINE=InnoDB
DEFAULT CHARSET=utf8;

ALTER TABLE dspam_token_data ADD INDEX(spam_hits); 
ALTER TABLE dspam_token_data ADD INDEX(innocent_hits); 
ALTER TABLE dspam_token_data ADD INDEX(last_hit);
       
SET FOREIGN_KEY_CHECKS=0;

ALTER TABLE `dspam_signature_data`
	ADD CONSTRAINT `dspam_signature_data_ibfk_1`
	FOREIGN KEY (`uid`) REFERENCES `dspam_virtual_uids` (`uid`) ON DELETE CASCADE;

ALTER TABLE `dspam_stats`
	ADD CONSTRAINT `dspam_stats_ibfk_1` 
	FOREIGN KEY (`uid`) REFERENCES `dspam_virtual_uids` (`uid`) ON DELETE CASCADE;

ALTER TABLE `dspam_token_data`
	ADD CONSTRAINT `dspam_token_data_ibfk_1` 
	FOREIGN KEY (`uid`) REFERENCES `dspam_virtual_uids` (`uid`) ON DELETE CASCADE;

SET FOREIGN_KEY_CHECKS=1;