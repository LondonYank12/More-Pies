SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `MorePies` ;
CREATE SCHEMA IF NOT EXISTS `MorePies` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `MorePies` ;

-- -----------------------------------------------------
-- Table `MorePies`.`REST_RESTAURANT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MorePies`.`REST_RESTAURANT` ;

CREATE  TABLE IF NOT EXISTS `MorePies`.`REST_RESTAURANT` (
  `REST_SID` INT NOT NULL ,
  `REST_NM` VARCHAR(45) NULL ,
  PRIMARY KEY (`REST_SID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MorePies`.`MENU_MENU`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MorePies`.`MENU_MENU` ;

CREATE  TABLE IF NOT EXISTS `MorePies`.`MENU_MENU` (
  `MENU_ID` INT NOT NULL ,
  `REST_RESTAURANT_REST_SID` INT NOT NULL ,
  PRIMARY KEY (`MENU_ID`) ,
  INDEX `fk_MENU_MENU_REST_RESTAURANT` (`REST_RESTAURANT_REST_SID` ASC) ,
  CONSTRAINT `fk_MENU_MENU_REST_RESTAURANT`
    FOREIGN KEY (`REST_RESTAURANT_REST_SID` )
    REFERENCES `MorePies`.`REST_RESTAURANT` (`REST_SID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MorePies`.`MENIT_MENU_ITEM`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MorePies`.`MENIT_MENU_ITEM` ;

CREATE  TABLE IF NOT EXISTS `MorePies`.`MENIT_MENU_ITEM` (
  `MENIT_SID` INT NOT NULL ,
  `MENU_MENU_MENU_ID` INT NOT NULL ,
  `MENIT_NM` VARCHAR(45) NULL ,
  `MENIT_SIZE` VARCHAR(45) NULL ,
  PRIMARY KEY (`MENIT_SID`) ,
  INDEX `fk_MENIT_MENU` (`MENU_MENU_MENU_ID` ASC) ,
  CONSTRAINT `fk_MENIT_MENU`
    FOREIGN KEY (`MENU_MENU_MENU_ID` )
    REFERENCES `MorePies`.`MENU_MENU` (`MENU_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MorePies`.`DAY`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MorePies`.`DAY` ;

CREATE  TABLE IF NOT EXISTS `MorePies`.`DAY` (
  `DAY_SID` INT NOT NULL ,
  `DAY_NM` VARCHAR(45) NULL ,
  PRIMARY KEY (`DAY_SID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MorePies`.`OPDY_OPERATING_DAY`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MorePies`.`OPDY_OPERATING_DAY` ;

CREATE  TABLE IF NOT EXISTS `MorePies`.`OPDY_OPERATING_DAY` (
  `REST_RESTAURANT_REST_SID` INT NOT NULL ,
  `DAY_DAY_SID` INT NOT NULL ,
  `OPENING_TIME` TIME NULL ,
  `CLOSING_TIME` TIME NULL ,
  INDEX `fk_OPDY_OPERATING_DAY_REST_RESTAURANT1` (`REST_RESTAURANT_REST_SID` ASC) ,
  PRIMARY KEY (`REST_RESTAURANT_REST_SID`, `DAY_DAY_SID`) ,
  INDEX `fk_OPDY_OPERATING_DAY_DAY1` (`DAY_DAY_SID` ASC) ,
  CONSTRAINT `fk_OPDY_OPERATING_DAY_REST_RESTAURANT1`
    FOREIGN KEY (`REST_RESTAURANT_REST_SID` )
    REFERENCES `MorePies`.`REST_RESTAURANT` (`REST_SID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OPDY_OPERATING_DAY_DAY1`
    FOREIGN KEY (`DAY_DAY_SID` )
    REFERENCES `MorePies`.`DAY` (`DAY_SID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MorePies`.`ADDR_ADDRESS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MorePies`.`ADDR_ADDRESS` ;

CREATE  TABLE IF NOT EXISTS `MorePies`.`ADDR_ADDRESS` (
  `REST_RESTAURANT_REST_SID` INT NOT NULL ,
  INDEX `fk_ADDR_ADDRESS_REST_RESTAURANT1` (`REST_RESTAURANT_REST_SID` ASC) ,
  CONSTRAINT `fk_ADDR_ADDRESS_REST_RESTAURANT1`
    FOREIGN KEY (`REST_RESTAURANT_REST_SID` )
    REFERENCES `MorePies`.`REST_RESTAURANT` (`REST_SID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `MorePies`.`DAY`
-- -----------------------------------------------------
START TRANSACTION;
USE `MorePies`;
INSERT INTO `MorePies`.`DAY` (`DAY_SID`, `DAY_NM`) VALUES (1, 'Sunday');
INSERT INTO `MorePies`.`DAY` (`DAY_SID`, `DAY_NM`) VALUES (2, 'Monday');
INSERT INTO `MorePies`.`DAY` (`DAY_SID`, `DAY_NM`) VALUES (3, 'Tuesday');
INSERT INTO `MorePies`.`DAY` (`DAY_SID`, `DAY_NM`) VALUES (4, 'Wednesday');
INSERT INTO `MorePies`.`DAY` (`DAY_SID`, `DAY_NM`) VALUES (5, 'Thursday');
INSERT INTO `MorePies`.`DAY` (`DAY_SID`, `DAY_NM`) VALUES (6, 'Friday');
INSERT INTO `MorePies`.`DAY` (`DAY_SID`, `DAY_NM`) VALUES (7, NULL);

COMMIT;
