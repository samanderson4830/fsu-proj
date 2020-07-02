DROP SCHEMA IF EXISTS BSA_Database;
CREATE SCHEMA BSA_Database;
USE `BSA_Database`;

DROP TABLE IF EXISTS `customers`;
DROP TABLE IF EXISTS `answers`;
DROP TABLE IF EXISTS `questions`;
DROP TABLE IF EXISTS `survey_results`;
DROP TABLE IF EXISTS `surveys_created`;

CREATE TABLE IF NOT EXISTS `BSA_Database`.`customers` (
  `customer_ID` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `thePassword` VARCHAR(45) NOT NULL,
  `company_name` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`customer_ID`),
  UNIQUE INDEX `customer_ID_UNIQUE` (`customer_ID` ASC))

ENGINE = InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `BSA_Database`.`surveys_created`(
    `survey_ID` INT NOT NULL AUTO_INCREMENT, 
    `customer_ID` INT NOT NULL, 
    `survey_name` VARCHAR(30) NOT NULL, 
    `date_created` TIMESTAMP NOT NULL, 
    PRIMARY KEY(`survey_ID`), 
    FOREIGN KEY(`customer_ID`) REFERENCES customers(`customer_ID`));

CREATE TABLE IF NOT EXISTS `BSA_Database`.`questions`(
    `question_ID` INT NOT NULL AUTO_INCREMENT, 
    `survey_ID` INT NOT NULL, 
    `question_order` INT NOT NULL, 
    `question_string` VARCHAR(100) NOT NULL, 
    `date_time` TIMESTAMP NOT NULL, 
    PRIMARY KEY(`question_ID`), 
    FOREIGN KEY(`survey_ID`) REFERENCES surveys_created(`survey_ID`));

CREATE TABLE IF NOT EXISTS `BSA_Database`.`answers`(
    `answer_ID` INT NOT NULL AUTO_INCREMENT, 
    `question_ID` INT NOT NULL, 
    `answer_string` VARCHAR(30) NOT NULL, 
    `answer_order` INT NOT NULL, 
    `date_time` TIMESTAMP NOT NULL, 
    PRIMARY KEY(`answer_ID`,`question_ID`));

CREATE TABLE `BSA_Database`.`survey_results`(
    `result_ID` INT NOT NULL AUTO_INCREMENT, 
    `survey_ID` INT NOT NULL,
    `answer_ID` INT NOT NULL, 
    `taker_ID` INT NOT NULL, 
    `is_done` BOOLEAN NOT NULL, 
    `date_time` TIMESTAMP NOT NULL, 
    PRIMARY KEY(`result_ID`), 
    FOREIGN KEY(`survey_ID`) REFERENCES questions(`survey_ID`), 
    FOREIGN KEY(`answer_ID`) REFERENCES answers(`answer_ID`));

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
-- Creating Default temporay Data for Surveys Created Table
-------------------------------------------------------------------------------*/

INSERT INTO `surveys_created`(`customer_ID`,`survey_name`,`date_created`) VALUES
(1,'Home Depot Performance Survey','2020-06-17 11:39:30'),
(1,'Home Depot Employee Survey','2020-03-04 05:30:29'),
(2,'Microsoft Vista Survey','2006-11-01 00:00:00'),
(2,'Is Bill Gates Cool?','2010-12-13 12:30:13'),
(3,'BACONATOR Review', '2008-01-01 01:01:01'),
(4,'Customer Survey','1978-02-02 06:54:29'),
(5,'How manly is your order?','2019-08-21 15:16:17'),
(6,'Did you flip your Blizzard?','2011-09-27 18:00:00'),
(7,'Rate X-AE-12\'s performance','2037-06-25 23:59:59'),
(8,'Spotify Survey','2015-11-02 08:31:00'),
(9,'Overlord Bezos Survey','2038-01-03 11:11:11');
/*-----------------------------------------------------------------------------
-- Creating Default temporay Data for Questions Table
-------------------------------------------------------------------------------*/
 INSERT INTO `questions`(`survey_ID`,`question_order`,`question_string`, `date_time`) VALUES
(1,1,'How would you rate our performance today?', '2020-06-17 12:06:30'),
(2,2,'Did you find the tool you needed for the job?', '2020-06-17 12:06:30'),
(2,3,'Will you return to this Home Depot?', '2020-06-17 12:06:30'),
(5,1,'How much bacon do you estimate was on your burger (in lbs.)?', '2020-06-17 12:06:30'),
(5,2,'Did you enjoy to burger?', '2020-06-17 12:06:30'),
(5,3,'What else could the BACONATOR use to make it even better?', '2020-06-17 12:06:30'),
(11,1,'State your Amazon Birth Name', '2020-06-17 12:06:30'),
(4,2,'Have any of your neighbors expressed dissatisfaction?', '2020-06-17 12:06:30'),
(11,3,'Rate Overlod Bezos from 10 to 10', '2020-06-17 12:06:30');
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
/*-----------------------------------------------------------------------------
--  PROCEDUREs for surveys_created table
-------------------------------------------------------------------------------*/
DROP PROCEDURE IF EXISTS `GetSurveyByID`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetSurveyByID` (IN sID INT)
BEGIN
   SELECT * FROM surveys_created WHERE survey_ID = sID;
END$$

DELIMITER ;

/*-----------------------------------------------------------------------------*/
DROP PROCEDURE IF EXISTS `GetAllSurveysByCustomerID`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetAllSurveysByCustomerID` (IN cID INT)
BEGIN
   SELECT survey_name FROM surveys_created WHERE cID = customer_ID ;
END$$

DELIMITER ;

/*-----------------------------------------------------------------------------
--  PROCEDUREs for questions table
-------------------------------------------------------------------------------*/
DROP PROCEDURE IF EXISTS `GetSurveyQuestions`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetSurveyQuestions` (IN sID INT)
BEGIN
   SELECT question_string FROM questions WHERE survey_ID = sID; 
 
END$$

DELIMITER ;
/*-----------------------------------------------------------------------------*/

