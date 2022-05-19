-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema dbsclab2022
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customer` (
  `ID` VARCHAR(20) NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `address` VARCHAR(20) NULL,
  `telephone` VARCHAR(20) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vip_card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vip_card` (
  `card_id` VARCHAR(20) NOT NULL,
  `level` INT NULL,
  `points` INT NULL,
  `customer_ID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`card_id`, `customer_ID`),
  INDEX `fk_vip_card_customer_idx` (`customer_ID` ASC) VISIBLE,
  CONSTRAINT `fk_vip_card_customer`
    FOREIGN KEY (`customer_ID`)
    REFERENCES `mydb`.`customer` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`address` (
  `province` VARCHAR(20) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `district` VARCHAR(45) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `customer_ID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`province`, `city`, `district`, `street`, `customer_ID`),
  INDEX `fk_address_customer1_idx` (`customer_ID` ASC) VISIBLE,
  CONSTRAINT `fk_address_customer1`
    FOREIGN KEY (`customer_ID`)
    REFERENCES `mydb`.`customer` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`telephone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`telephone` (
  `area_code` INT NOT NULL,
  `tele_code` VARCHAR(45) NULL,
  `customer_ID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`area_code`, `customer_ID`),
  INDEX `fk_telephone_customer1_idx` (`customer_ID` ASC) VISIBLE,
  CONSTRAINT `fk_telephone_customer1`
    FOREIGN KEY (`customer_ID`)
    REFERENCES `mydb`.`customer` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
