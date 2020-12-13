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
	VALUES ('cprg352+admin2@gmail.com', true, 'Admin2','Admin2', '1399c5f5ad82dfbbeba73a1a1f48b533a0787fda16999eb5da2a1e8e40e9a418', 'esxHtLwFsnG0SRWQtiKw/DYlKm9XcgDMYrBSmfwomtk=', 3, 2);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('cprg352+anne@gmail.com', true, 'Anne','Annerson', 'jzi/nw5ILSBHMEFDItHsYKFwDdMkzlAOZCKV0HiDQnk=', 'bc2f28ee08a5f8f7f8fa0d665c515f46fddb25660d3df41a3c850b8c51e88cd1', 2, 3);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('cprg352+barb@gmail.com', true, 'Barb','Barber', '104dfb01dabf8c06772a56a17d96081f9585e32785c1bcd7925cb90586c7c560', 'R4qMjy8t03OzE3wTBUj9DRigBbvqN051tCh3uyUR85Q=', 2, 1);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('denise.lee@calgary.ca', true, 'Denise','Lee', 'password', 's', 2, 2);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('jack.graver@calgary.ca', true, 'Jack','Graver', 'password', 's', 2, 3);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('sean.chen@calgary.ca', true, 'Sean','Chen', 'password', 's', 2, 1);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('jones.matthew@calgary.ca', true, 'Jones','Matthew', 'password', 's', 2, 2);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('ethan.gervais@calgary.ca', false, 'Ethan','Gervais', 'password', 's', 2, 3);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('naeun.kim@calgary.ca', false, 'Naeun','Kim', 'password', 's', 2, 1);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('jaeyoung.kim.test@gmail.com', true, 'Jaeyoung','Kim', 'password', 's', 2, 2);
INSERT INTO `user` (`email`,`active`,`first_name`,`last_name`,`password`, `salt`,`role`,`company`)
	VALUES ('aaron.warsylewicz@calgary.ca', false, 'Aaron','Warsylewicz', 'password', 's', 2, 3);

INSERT INTO `item` (`category`,`item_name`,`price`,`owner`) VALUES (1, 'blender',29.99,'cprg352+anne@gmail.com');
INSERT INTO `item` (`category`,`item_name`,`price`,`owner`) VALUES (1, 'toaster',19.99,'cprg352+anne@gmail.com');
INSERT INTO `item` (`category`,`item_name`,`price`,`owner`) VALUES (3, 'lamp',5,'cprg352+anne@gmail.com');
INSERT INTO `item` (`category`,`item_name`,`price`,`owner`) VALUES (6, 'winter tires',200,'cprg352+anne@gmail.com');
INSERT INTO `item` (`category`,`item_name`,`price`,`owner`) VALUES (5, 'dresser',50,'cprg352+anne@gmail.com');
INSERT INTO `item` (`category`,`item_name`,`price`,`owner`) VALUES (7, 'microwave',120,'cprg352+barb@gmail.com');
