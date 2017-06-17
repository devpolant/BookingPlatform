DROP TABLE IF EXISTS `clients`;
DROP TABLE IF EXISTS `vendors`;
DROP TABLE IF EXISTS `locations`;
DROP TABLE IF EXISTS `places`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `order_items`;

CREATE TABLE `clients` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`login` VARCHAR(64) NOT NULL,
	`name` VARCHAR(128) NOT NULL,
	`email` VARCHAR(256),
	`password` VARCHAR(128) NOT NULL,
	`salt` VARCHAR(128) NOT NULL,
	`token` VARCHAR(128) NOT NULL
);

CREATE TABLE `vendors` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`login` VARCHAR(64) NOT NULL,
	`name` VARCHAR(128) NOT NULL,
	`email` VARCHAR(256),
	`password` VARCHAR(128) NOT NULL,
	`salt` VARCHAR(128) NOT NULL,
	`token` VARCHAR(128) NOT NULL
);

CREATE TABLE `locations` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`vendor_id` INT NOT NULL,
	`name` VARCHAR(128) NOT NULL,
	`lat` DECIMAL NOT NULL,
	`lng` DECIMAL NOT NULL,
	FOREIGN KEY (`vendor_id`) REFERENCES `vendors`(`id`)
);

CREATE TABLE `places` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`location_id` INT NOT NULL,
	`place_number` INT NOT NULL,
	FOREIGN KEY (`location_id`) REFERENCES `locations`(`id`)
);

CREATE TABLE `orders` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`vendor_id` INT NOT NULL,
	`client_id` INT NOT NULL,
    `date_from` DATETIME NOT NULL,
    `date_to` DATETIME NOT NULL,
	FOREIGN KEY (`vendor_id`) REFERENCES `vendors`(`id`),
	FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`)
);

CREATE TABLE `order_items` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`order_id` INT NOT NULL,
	`place_id` INT NOT NULL,
	FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`),
	FOREIGN KEY (`place_id`) REFERENCES `places`(`id`)
);
