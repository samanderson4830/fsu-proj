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
  UNIQUE INDEX `customer_ID_UNIQUE` (`customer_ID` ASC)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `BSA_Database`.`surveys_created`(
    `survey_ID` INT NOT NULL AUTO_INCREMENT, 
    `customer_ID` INT NOT NULL, 
    `survey_name` VARCHAR(30) NOT NULL, 
    `date_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP, 
    PRIMARY KEY(`survey_ID`), 
    INDEX `idx.customer` (customer_ID),
    CONSTRAINT `fk_customer_ID` 
    FOREIGN KEY(`customer_ID`)
    REFERENCES customers(`customer_ID`) ON UPDATE CASCADE ON DELETE RESTRICT
)ENGINE = InnoDB ;

CREATE TABLE IF NOT EXISTS `BSA_Database`.`questions`(
    `question_ID` INT NOT NULL AUTO_INCREMENT, 
    `survey_ID` INT NOT NULL, 
    `question_order` INT NOT NULL, 
    `question_string` VARCHAR(250) NOT NULL, 
    `date_time`  TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,  
    PRIMARY KEY(`question_ID`), 
    INDEX `idx.survey_ID` (survey_ID),
    CONSTRAINT `fk_survey_ID` 
    FOREIGN KEY(`survey_ID`) REFERENCES surveys_created(`survey_ID`) ON UPDATE CASCADE ON DELETE RESTRICT
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `BSA_Database`.`answers`(
    `answer_ID` INT NOT NULL AUTO_INCREMENT, 
    `question_ID` INT NOT NULL, 
    `answer_string` VARCHAR(100) NOT NULL, 
    `answer_order` INT NOT NULL, 
    `date_time`  TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP, 
    PRIMARY KEY(`answer_ID`,`question_ID`)
)ENGINE = InnoDB;

CREATE TABLE `BSA_Database`.`survey_results`(
    `result_ID` INT NOT NULL AUTO_INCREMENT, 
    `survey_ID` INT NOT NULL,
    `answer_ID` INT NOT NULL, 
    `taker_ID` INT NOT NULL , 
    `is_done` BOOLEAN NOT NULL, 
    `date_time`  TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP, 
    PRIMARY KEY(`result_ID`), 
    INDEX `idx.answer_ID` (answer_ID),
    CONSTRAINT `fk_answer_ID` 
    FOREIGN KEY(`answer_ID`) REFERENCES answers(`answer_ID`) ON UPDATE CASCADE ON DELETE RESTRICT
)ENGINE = InnoDB;

/*-----------------------------------------------------------------------------
-- Creating Default temporay Data for Customer Table
-------------------------------------------------------------------------------*/

INSERT  INTO `customers`(`email`,`thePassword`,`company_name`) VALUES 
('HomeDepot123@gmail.com', 'Home123',       'Home Depot'),
('Microsoft@gmail.com',    'Microsoft123',  'Microsoft'),
('Wendys11@gmail.com',     'Wendys123',     'Wendys'),
('Mcdonlads123@gmail.com', 'Mcdonlads123',  'Mcdonlads'),
('Starbucks1@gmail.com',   'Starbucks123',  'Starkbucks'),
('DairyQueen@gmail.com',   'Dairy123',      'Dairy Queen'),
('Tesla@gmail.com',        'Tesla123',      'Tesla'),
('Spotify@gmail.com',      'Spotify123',    'Spotify'),
('Amazon@gmail.com',       'Amazon123',     'Amazon');

/*-----------------------------------------------------------------------------
-- Creating Default temporay Data for Surveys Created Table
-------------------------------------------------------------------------------*/

INSERT INTO `surveys_created`(`customer_ID`,`survey_name`) VALUES
(1,  'Home Depot Performance Survey'),
(1,  'Home Depot Employee Survey'),
(2,  'Microsoft Vista Survey'),
(3,  'BACONATOR Review'),
(4,  'Customer Survey'),
(5,  'How manly is your order?'),
(6,  'Did you flip your Blizzard?'),
(7,  'Rate X-AE-12\'s performance'),
(8,  'Spotify Survey'),
(9,  'Overlord Bezos Survey');

/*-----------------------------------------------------------------------------
-- Creating Default temporay Data for Questions Table
-------------------------------------------------------------------------------*/
 INSERT INTO `questions`(`survey_ID`,`question_order`,`question_string`) VALUES
(1,  1,  'How would you rate our performance today?'),
(1,  2,  'Will you return to this Home Depot?'),
(2,  1,  'Do you enjoy working at Home Depot'),
(3,  1,  'Do you like windows vista??'),
(5,  1,  'How much bacon do you estimate was on your burger (in lbs.)?'),
(5,  2,  'Did you enjoy to burger?'),
(5,  3,  'What else could the BACONATOR use to make it even better?');

/*-----------------------------------------------------------------------------
-- Creating Default temporay Data for Answers Table
-------------------------------------------------------------------------------*/
 INSERT INTO `answers`(`question_ID`,`answer_string`, `answer_order`) VALUES
-- Home Depot Performance Survey
(1,    'Great', 1),
(1,    'Good',  2),
(1,    'ok',    3),
(1,    'poor',  4),

(2,    'YES ', 1),
(2,    'NO',   2),

-- Home Depot Employee Survey
(3,    'Yes, home depot is great', 1),
(3,    'No, I want a new job',     2),

-- Windows Vista Survey
(4,    'Yes, its great', 1),
(4,    'No!',            2),

-- BACONATOR Review
(5,    'less than 1lb', 1),
(5,    '1lb - 2lb'    , 2),
(5,    'more than 3lb', 3),

(6,    'Yes!',          1),
(6,    'No!',           2),

(7,    'More Bacon!',          1),
(7,    'Nothing its great!',   2);

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
DROP PROCEDURE IF EXISTS `AddSurvey`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `AddSurvey` (IN cID INT, IN sName VARCHAR(100))
BEGIN
   INSERT INTO surveys_created (customer_ID, survey_name) VALUES (cID, sName);
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
   SELECT question_string, question_order FROM questions WHERE survey_ID = sID; 
 
END$$

DELIMITER ;

/*-----------------------------------------------------------------------------*/
DROP PROCEDURE IF EXISTS `GetQuestionNumber`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetQuestionNumber` (IN qID INT)
BEGIN
   SELECT question_order FROM questions WHERE question_ID = qID; 
 
END$$

DELIMITER ;

/*-----------------------------------------------------------------------------*/
DROP PROCEDURE IF EXISTS `AddQuestions`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `AddQuestions` (IN sID INT, IN qOrder INT, IN qString VARCHAR(250) )
BEGIN
    INSERT INTO questions (survey_ID, question_order, question_string) VALUES (sID, qOrder, qString);
END$$

DELIMITER ;

/*-----------------------------------------------------------------------------
--  PROCEDUREs for answers table
-------------------------------------------------------------------------------*/
DROP PROCEDURE IF EXISTS `GetAnswersByQuestionID`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetAnswersByQuestionID` (IN qID INT)
BEGIN
   SELECT * FROM answers WHERE question_ID = qID; 
 
END$$

DELIMITER ;

/*-----------------------------------------------------------------------------*/
DROP PROCEDURE IF EXISTS `AddAnswer`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `AddAnswer` (IN qID INT, IN aOrder INT, IN aString VARCHAR(100) )
BEGIN
   INSERT INTO answers (question_ID, answer_order, answer_string) VALUES (qID, aOrder, aString);
 
END$$

DELIMITER ;


/*-----------------------------------------------------------------------------
--  PROCEDUREs for survey_results table
-------------------------------------------------------------------------------*/

/*-----------------------------------------------------------------------------
--  All Functions 
-------------------------------------------------------------------------------*/
DROP FUNCTION IF EXISTS `ValidLogin`;

DELIMITER $$
CREATE FUNCTION `ValidLogin` (cEmail VARCHAR(100))  RETURNS BOOL DETERMINISTIC
BEGIN
      # email exists flag
      DECLARE is_valid BOOLEAN DEFAULT FALSE;

      # email count will be 1 if true
      DECLARE email_count INT DEFAULT 0;

      # check for exsiting email in customer table 
            SELECT COUNT(1) INTO email_count
            FROM  `customers`
            WHERE email = cEmail;

            # set if email exists
            IF email_count = 1 THEN
                  SET is_valid = TRUE;
            END IF;

      RETURN is_valid;
END $$

DELIMITER ;

