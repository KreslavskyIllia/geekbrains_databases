CREATE TABLE `district` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `district` varchar(255) COLLATE utf8_bin NOT NULL,
  `population` int unsigned NOT NULL,
  `capital` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
SELECT * FROM israel_towns.town;CREATE TABLE `subdistrict` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `subdistrict` varchar(255) COLLATE utf8_bin NOT NULL,
  `population` int NOT NULL,
  `district_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_district_idx` (`district_id`),
  CONSTRAINT `fk_subdistrict_district_id` FOREIGN KEY (`district_id`) REFERENCES `district` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
CREATE TABLE `town` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `town` varchar(255) COLLATE utf8_bin NOT NULL,
  `population` int unsigned DEFAULT NULL,
  `district` int unsigned NOT NULL,
  `subdistrict` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_town_district_idx` (`district`),
  KEY `fk_town_subdistrict_id_idx` (`subdistrict`),
  CONSTRAINT `fk_town_district_id` FOREIGN KEY (`district`) REFERENCES `district` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_town_subdistrict_id` FOREIGN KEY (`subdistrict`) REFERENCES `subdistrict` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
