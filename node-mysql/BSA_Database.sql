DROP DATABASE IF EXISTS BSA_Database;
CREATE DATABASE BSA_Database;
USE `BSA_Database`;

DROP TABLE IF EXISTS `customers`;

CREATE TABLE IF NOT EXISTS `BSA_Database`.`customers` (
  `customer_ID` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `thePassword` VARCHAR(45) NOT NULL,
  `company_name` VARCHAR(100) NOT NULL,
  UNIQUE INDEX `customer_ID_UNIQUE` (`customer_ID` ASC) VISIBLE,
  PRIMARY KEY (`customer_ID`))
ENGINE = InnoDB DEFAULT CHARSET=latin1;

/*-----------------------------------------------------------------------------
-- Creating Default temporay Data for Customer Table
-------------------------------------------------------------------------------*/


INSERT  INTO `customers`(`email`,`thePassword`,`company_name`) VALUES 
('HomeDepot123@gmail.com', 'Home123', 'Home Depot'),
('Microsoft@gmail.com', 'Microsoft123', 'Microsoft'),
('Wendys11@gmail.com', 'Wendys123', 'Wendys'),
('Mcdonlads123@gmail.com', 'Mcdonlads123', 'Mcdonlads'),
('Starbucks1@gmail.com', 'Starbucks123', 'Starkbucks'),
('DairyQueen@gmail.com', 'Dairy123', 'Dairy Queen'),
('Tesla@gmail.com', 'Tesla123', 'Tesla'),
('Spotify@gmail.com', 'Spotify123', 'Spotify'),
('Amazon@gmail.com', 'Amazon123', 'Amazon');

/*-----------------------------------------------------------------------------
-- Creating all PROCEDURE
-------------------------------------------------------------------------------*/

/*-----------------------------------------------------------------------------
--  PROCEDUREs to get information
-------------------------------------------------------------------------------*/
DROP PROCEDURE IF EXISTS `GetCustomersAll`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetCustomersAll` ()
BEGIN
	SELECT * FROM customers;
END$$

DELIMITER ;

/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `GetCustomersByID`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetCustomersByID` (IN cID INT)
BEGIN
   SELECT * FROM customers WHERE customer_ID = cID;
END$$

DELIMITER ;
/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `GetCustomersByName`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetCustomersByName` (IN cName VARCHAR(100))
BEGIN
   SELECT * FROM customers WHERE company_name = cName;
END$$

DELIMITER ;
/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `GetCustomersByEmail`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetCustomersByEmail` (IN cEmail VARCHAR(100))
BEGIN
   SELECT * FROM customers WHERE email = cEmail;
END$$

DELIMITER ;
/*-----------------------------------------------------------------------------*/

/*-----------------------------------------------------------------------------
--  PROCEDUREs to input information
-------------------------------------------------------------------------------*/
DROP PROCEDURE IF EXISTS `AddCompany`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `AddCompany` (IN cEmail VARCHAR(100), IN cPassword VARCHAR(45), IN cName VARCHAR(100) )
BEGIN
   INSERT INTO customers (Email, thePassword, company_name) VALUES (cEmail, cPassword, cName);
END$$

DELIMITER ;



