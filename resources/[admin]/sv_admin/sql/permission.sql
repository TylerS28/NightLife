-- Dumping structure for table arp3_0.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `license` varchar(255) NOT NULL,
  `permission` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `license` (`license`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- Dumping data for table arp3_0.permissions: ~2 rows (approximately)
INSERT INTO `permissions` (`id`, `name`, `license`, `permission`) VALUES
	(11, 'karxi', 'license:88c4f89bfcbbf4c5eac449133f45b45043d146c1', 'god'),
	(12, 'coreyj101997', 'license:042f0b5980a33fbbd1a99b302f12a8c61d9d9e40', 'god'),
	(15, 'Danny3tb', 'license:c7eb2c3e9853cc04b1c7da580986aeeb8191acd1', 'god');