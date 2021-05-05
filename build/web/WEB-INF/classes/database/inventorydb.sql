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
	VALUES ('jaeyoung.kim.test+admin@gmail.com', true, 'Admin','Admin', 'a3d84673a6a9aa5d42115e04842a452aa4d8cc761d04b2ef11ace6757469a5e0', 'MiANusnPzYA0aM8OjJSlk/ITRIZTrhr8BBXR82y2UvI=', 1, 1);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('jaeyoung.kim.test+admin2@gmail.com', true, 'Admin2','Admin2', 'a02fef4a7844fdc152bcadb33b18ad7528911f557deb562d50a21578abd82393', 'esxHtLwFsnG0SRWQtiKw/DYlKm9XcgDMYrBSmfwomtk=', 3, 2);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('jaeyoung.kim.test+anne@gmail.com', true, 'Anne','Annerson', '893d08c984a7b1084d0fa0bf9bd4e7eb148e06ad8833d12d9ae365a802582b3c', 'KK4EApfBQC4x1YHpKyofXY6O7sZSN94XcIAk3NCfrHw=', 2, 3);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('jaeyoung.kim.test+barb@gmail.com', true, 'Barb','Barber', '3839750f53785cdca21f50ddfc7ad99525f3494a2c2070d87206cd73b637a17d', 'a7zoNaNHBiOTk9VkHg/wEnoFlLdmEHTwLUrq+gY85zg=', 2, 1);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('jaeyoung.kim.test@gmail.com', true, 'Jaeyoung','Kim', '22e66fecb165768b00a82fe1cdc9554389dc1ed3db605f8c417a9ebf744e33fd', 'kWnXmfcfTQANAWoSfssHFOhB04Ky/25VqyDDIFge5fU=', 2, 2);

INSERT INTO `item` (`category`,`item_name`,`price`,`owner`) VALUES (1, 'blender',29.99,'jaeyoung.kim.test+anne@gmail.com');
INSERT INTO `item` (`category`,`item_name`,`price`,`owner`) VALUES (1, 'toaster',19.99,'jaeyoung.kim.test+anne@gmail.com');
INSERT INTO `item` (`category`,`item_name`,`price`,`owner`) VALUES (3, 'lamp',5,'jaeyoung.kim.test+anne@gmail.com');
INSERT INTO `item` (`category`,`item_name`,`price`,`owner`) VALUES (6, 'winter tires',200,'jaeyoung.kim.test+anne@gmail.com');
INSERT INTO `item` (`category`,`item_name`,`price`,`owner`) VALUES (5, 'dresser',50,'jaeyoung.kim.test+anne@gmail.com');
INSERT INTO `item` (`category`,`item_name`,`price`,`owner`) VALUES (7, 'microwave',120,'jaeyoung.kim.test+barb@gmail.com');
