DROP SCHEMA IF EXISTS `inventorydb`;
CREATE SCHEMA IF NOT EXISTS `inventorydb` DEFAULT CHARACTER SET latin1;
USE `inventorydb`;

-- -----------------------------------------------------
-- Table `inventorydb`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventorydb`.`category` (
  `category_id` INT(11) NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`category_id`));

-- -----------------------------------------------------
-- Table `inventorydb`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventorydb`.`role` (
  `role_id` INT(11) NOT NULL,
  `role_name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`role_id`));

-- -----------------------------------------------------
-- Table `inventorydb`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventorydb`.`company` (
  `company_id` INT(11) NOT NULL,
  `company_name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`company_id`));

-- -----------------------------------------------------
-- Table `inventorydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventorydb`.`user` (
  `email` VARCHAR(40) NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT '1',
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `password` VARCHAR(70) NOT NULL,
  `salt` VARCHAR(70) NOT NULL,
  `role` INT(11) NOT NULL,
  `company` INT(11) NOT NULL,
  `email_verify_uuid` VARCHAR(50),
  `reset_password_uuid` VARCHAR(50),
  PRIMARY KEY (`email`),
  CONSTRAINT `fk_user_role`
    FOREIGN KEY (`role`)
    REFERENCES `inventorydb`.`role` (`role_id`),
  CONSTRAINT `fk_user_company`
    FOREIGN KEY (`company`)
    REFERENCES `inventorydb`.`company` (`company_id`));


-- -----------------------------------------------------
-- Table `inventorydb`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventorydb`.`item` (
  `item_id` INT(11) NOT NULL AUTO_INCREMENT,
  `category` INT(11) NOT NULL,
  `item_name` VARCHAR(45) NOT NULL,
  `price` DOUBLE NOT NULL,
  `owner` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`item_id`),
  CONSTRAINT `fk_items_categories`
    FOREIGN KEY (`category`)
    REFERENCES `inventorydb`.`category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_items_owner`
    FOREIGN KEY (`owner`)
    REFERENCES `inventorydb`.`user` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

INSERT INTO `role` VALUES (1, 'system admin');
INSERT INTO `role` VALUES (2, 'regular user');
INSERT INTO `role` VALUES (3, 'company admin');

INSERT INTO `company` VALUES (1, 'Apple');
INSERT INTO `company` VALUES (2, 'Google');
INSERT INTO `company` VALUES (3, 'Microsoft');

INSERT INTO `category` (`category_name`) VALUES ('kitchen');
INSERT INTO `category` (`category_name`) VALUES ('bathroom');
INSERT INTO `category` (`category_name`) VALUES ('living room');
INSERT INTO `category` (`category_name`) VALUES ('basement');
INSERT INTO `category` (`category_name`) VALUES ('bedrooom');
INSERT INTO `category` (`category_name`) VALUES ('garage');
INSERT INTO `category` (`category_name`) VALUES ('office');
INSERT INTO `category` (`category_name`) VALUES ('utility room');
INSERT INTO `category` (`category_name`) VALUES ('storage');
INSERT INTO `category` (`category_name`) VALUES ('other');

INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('cprg352+admin@gmail.com', true, 'Admin','Admin', 'a3d84673a6a9aa5d42115e04842a452aa4d8cc761d04b2ef11ace6757469a5e0', 'MiANusnPzYA0aM8OjJSlk/ITRIZTrhr8BBXR82y2UvI=', 1, 1);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('cprg352+admin2@gmail.com', true, 'Admin2','Admin2', 'a02fef4a7844fdc152bcadb33b18ad7528911f557deb562d50a21578abd82393', 'esxHtLwFsnG0SRWQtiKw/DYlKm9XcgDMYrBSmfwomtk=', 3, 2);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('cprg352+anne@gmail.com', true, 'Anne','Annerson', '893d08c984a7b1084d0fa0bf9bd4e7eb148e06ad8833d12d9ae365a802582b3c', 'KK4EApfBQC4x1YHpKyofXY6O7sZSN94XcIAk3NCfrHw=', 2, 3);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('cprg352+barb@gmail.com', true, 'Barb','Barber', '3839750f53785cdca21f50ddfc7ad99525f3494a2c2070d87206cd73b637a17d', 'a7zoNaNHBiOTk9VkHg/wEnoFlLdmEHTwLUrq+gY85zg=', 2, 1);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('denise.lee@calgary.ca', true, 'Denise','Lee', '11bd7268a7b734f482c0b25966a1f336abb2773a4c4bd10bcdeb82bae1b00cfc ', 'Jt0aM40zwrj2JBCPWFerN4gACptalS6MXru/XLeuMiM=', 2, 2);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('jack.graver@calgary.ca', true, 'Jack','Graver', '2639013b7ea776bacbfa7bb086dff5ac56d8f059aef574ef6ca5b536d45c40a1', 'zTXaCm8JzgGRIfw8J4x02nq8fRUJAbtQtjPxC+JqieA=', 2, 3);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('sean.chen@calgary.ca', true, 'Sean','Chen', '17cd8afde84b1888599e05630d401c397409388ef57e9d4af29e48f01e43d3a4', 'Q+kZsTKDI6AUONpClA+9wCtEh80kcg6LVSpIlWo2RTU=', 2, 1);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('jones.matthew@calgary.ca', true, 'Jones','Matthew', 'a972e33f511f8e324e69ba250f0b85b7cb058da0648b7a2ccd54d91aaa7c98a3', 'iN/G1D/Bv73TX7LPh8yIDFZQw0SJLWBfeA+b281XlUY=', 2, 2);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('ethan.gervais@calgary.ca', false, 'Ethan','Gervais', '09d3813fc007e0ece0c8bc913a64bb7029edfeb47a5f2eab2f607439725b85fb', '0/KHw11dQJj6zcR6FRRpyF9o29zpfswz8AgMrB3IwdM=', 2, 3);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('naeun.kim@calgary.ca', false, 'Naeun','Kim', 'c7c186d88d55e2e2bbda68e04a25e7f6ef21ff8ce5352930281d406375365d88', 'Rw+v0ONtTPw6cGOITH0mtY5vNPbskp8AIXBKcBjaW0c=', 2, 1);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('jaeyoung.kim.test@gmail.com', true, 'Jaeyoung','Kim', '22e66fecb165768b00a82fe1cdc9554389dc1ed3db605f8c417a9ebf744e33fd', 'kWnXmfcfTQANAWoSfssHFOhB04Ky/25VqyDDIFge5fU=', 2, 2);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('aaron.warsylewicz@calgary.ca', false, 'Aaron','Warsylewicz', '1b5fe187a747650538cf7ed8bd6f4257c86e328352bcbde0e0eca505d3b3929d', 'g+vGnL6q0a9UWoYbHtvm2PdJKy9W61BKkHLKhp4SpIY=', 2, 3);

INSERT INTO `item` (`category`,`item_name`,`price`,`owner`) VALUES (1, 'blender',29.99,'cprg352+anne@gmail.com');
INSERT INTO `item` (`category`,`item_name`,`price`,`owner`) VALUES (1, 'toaster',19.99,'cprg352+anne@gmail.com');
INSERT INTO `item` (`category`,`item_name`,`price`,`owner`) VALUES (3, 'lamp',5,'cprg352+anne@gmail.com');
INSERT INTO `item` (`category`,`item_name`,`price`,`owner`) VALUES (6, 'winter tires',200,'cprg352+anne@gmail.com');
INSERT INTO `item` (`category`,`item_name`,`price`,`owner`) VALUES (5, 'dresser',50,'cprg352+anne@gmail.com');
INSERT INTO `item` (`category`,`item_name`,`price`,`owner`) VALUES (7, 'microwave',120,'cprg352+barb@gmail.com');
