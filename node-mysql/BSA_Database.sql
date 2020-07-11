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
  `first_name` VARCHAR(50),
  `last_name` VARCHAR(50) ,
  `thePassword` VARCHAR(45) NOT NULL,
  `company_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`customer_ID`),
  UNIQUE INDEX `customer_ID_UNIQUE` (`customer_ID` ASC)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `BSA_Database`.`surveys_created`(
    `survey_ID` INT NOT NULL AUTO_INCREMENT, 
    `customer_ID` INT NOT NULL, 
    `survey_name` VARCHAR(30) NOT NULL, 
    `date_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP, 
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
    `taker_ID` INT NOT NULL, 
    `survey_ID` INT NOT NULL,
    `answer_ID` INT NOT NULL,  
    `is_done` BOOLEAN, 
    `date_time`  TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP, 
	KEY (`taker_ID`, survey_ID),
    INDEX `idx.answer_ID` (answer_ID),
    CONSTRAINT `fk_answer_ID` 
    FOREIGN KEY(`answer_ID`) REFERENCES answers(`answer_ID`) ON UPDATE CASCADE ON DELETE RESTRICT
)ENGINE = InnoDB;

/*-----------------------------------------------------------------------------
-- Creating Default temporay Data for Customer Table
-------------------------------------------------------------------------------*/

INSERT  INTO `customers`(`email`,`thePassword`,`company_name`, `first_name`, `last_name`) VALUES 
('HomeDepot123@gmail.com', 'Home123',       'Home Depot', 'Jamis', 'Winston'),
('Microsoft@gmail.com',    'Microsoft123',  'Microsoft',   NULL,    NULL),
('Wendys11@gmail.com',     'Wendys123',     'Wendys',      NULL,    NULL),
('Mcdonlads123@gmail.com', 'Mcdonlads123',  'Mcdonlads',   NULL,    NULL),
('Starbucks1@gmail.com',   'Starbucks123',  'Starkbucks',  NULL,    NULL),
('DairyQueen@gmail.com',   'Dairy123',      'Dairy Queen', NULL,    NULL),
('Tesla@gmail.com',        'Tesla123',      'Tesla',       NULL,    NULL),
('Spotify@gmail.com',      'Spotify123',    'Spotify',     NULL,    NULL),
('Amazon@gmail.com',       'Amazon123',     'Amazon',      NULL,    NULL);

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
(4,  1,  'How much bacon do you estimate was on your burger (in lbs.)?'),
(4,  2,  'Did you enjoy to burger?'),
(4,  3,  'What else could the BACONATOR use to make it even better?');

/*-----------------------------------------------------------------------------
-- Creating Default temporay Data for Answers Table
-------------------------------------------------------------------------------*/
 INSERT INTO `answers`(`question_ID`,`answer_string`, `answer_order`) VALUES
-- Home Depot Performance Survey
# Ans for Q1
(1,    'Great', 1),
(1,    'Good',  2),
(1,    'ok',    3),
(1,    'poor',  4),
# Ans for Q2
(2,    'YES ', 1),
(2,    'NO',   2),

-- Home Depot Employee Survey
# Ans for Q1
(3,    'Yes, home depot is great', 1),
(3,    'No, I want a new job',     2),

-- Windows Vista Survey
# Ans for Q1
(4,    'Yes, its great', 1),
(4,    'No!',            2),

-- BACONATOR Review
# Ans for Q1
(5,    'less than 1lb', 1),
(5,    '1lb - 2lb'    , 2),
(5,    'more than 3lb', 3),

# Ans for Q2
(6,    'Yes!',          1),
(6,    'No!',           2),

# Ans for Q3
(7,    'More Bacon!',          1),
(7,    'Nothing its great!',   2);

/*-----------------------------------------------------------------------------
-- Creating Default temporay Data for survey_results Table
-------------------------------------------------------------------------------*/
 INSERT INTO `survey_results`(`taker_ID`,`survey_ID`,`answer_ID`, `is_done`) VALUES
-- Home Depot Performance Survey Answers / Has (2) questions
(1,      1,     2,     NULL),  # new taker 1
(1,      1,     3,     true),

(2,      1,     1,     NULL),  # new taker 2
(2,      1,     4,     true),

-- Home Depot Employee Survey Answers / Has (1) question
(3,      2,    7,     true),   # new taker 3
(4,      2,    7,     true),   # new taker 4
(5,      2,    8,     true),   # new taker 5

-- Windows Vista Survey Answers / Has (1) question
(6,      3,    9,     true),   # new taker 6
(7,      3,    10,    true),   # new taker 7
(8,      3,    9,     true),   # new taker 8

-- BACONATOR Review Survey Answers / Has (3) question
(9,      4,    11,    NULL),   # new taker 9
(9,      4,    15,    NULL),   
(9,      4,    16,    true),   

(10,     4,    12,    NULL),   # new taker 10
(10,     4,    14,    NULL),   
(10,     4,    16,    true); 

/*-----------------------------------------------------------------------------
-- Creating all PROCEDURE
-------------------------------------------------------------------------------*/

/*-----------------------------------------------------------------------------
--  PROCEDUREs for customer table
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
CREATE PROCEDURE `GetCustomersByName` (IN cName VARCHAR(100) )
BEGIN
   SELECT * FROM customers WHERE company_name = cName;
END$$

DELIMITER ;

/*-----------------------------------------------------------------------------*/
DROP PROCEDURE IF EXISTS `GetCustomersByEmail`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetCustomersByEmail` (IN cEmail VARCHAR(100) )
BEGIN
   SELECT * FROM customers WHERE email = cEmail;
END$$

DELIMITER ;
/*-----------------------------------------------------------------------------*/
DROP PROCEDURE IF EXISTS `AddCompany`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `AddCompany` (IN cEmail VARCHAR(100), IN cPassword VARCHAR(45), 
						       IN cName VARCHAR(100),  IN fName VARCHAR(100),
                               IN lName VARCHAR(100) )
BEGIN
   INSERT INTO customers (Email, thePassword, company_name, first_name, last_name) 
   VALUES (cEmail, cPassword, cName, fName, lName);
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
CREATE PROCEDURE `AddSurvey` (IN cID INT, IN sName VARCHAR(100) )
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
DROP PROCEDURE IF EXISTS `GetAnswerStringByID`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetAnswerStringByID` (IN aID INT)
BEGIN
   SELECT answer_string FROM answers WHERE answer_ID = aID; 
 
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
DROP PROCEDURE IF EXISTS `GetResultsFromTaker`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetResultsFromTaker` (IN tID INT)
BEGIN
   SELECT * FROM survey_results WHERE taker_ID = tID; 
 
END$$

DELIMITER ;

/*-----------------------------------------------------------------------------*/
DROP PROCEDURE IF EXISTS `AddResult`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `AddResult` (IN aID INT, IN sID INT, IN qID INT)
BEGIN
   DECLARE done BOOLEAN DEFAULT NULL;

   # check if survey is done 
		IF IsSurveyFinished (qID, aID) = TRUE THEN
			SET done = TRUE; 
		END IF;
   # if false done will remain null
   INSERT INTO survey_results (answer_ID, survey_ID, is_done) VALUES (aID, sID, done);
 
END$$

DELIMITER ;

/*-----------------------------------------------------------------------------
--  All Functions 
-------------------------------------------------------------------------------*/
DROP FUNCTION IF EXISTS `ValidLogin`;

DELIMITER $$
CREATE FUNCTION `ValidLogin` (cEmail VARCHAR(100) ) RETURNS BOOL DETERMINISTIC
BEGIN
      # variables 
      DECLARE is_valid BOOLEAN DEFAULT FALSE;  # email exists flag
      DECLARE email_count INT DEFAULT 0;       # email count will be 1 if true

      # check for exsiting email in customer table 
            SELECT COUNT(1) INTO email_count
            FROM  `customers`
            WHERE email = cEmail;

	  # set true if email exists assumed all emials are unique
            IF email_count = 1 THEN
                  SET is_valid = TRUE;
            END IF;

      RETURN is_valid;
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/
DROP FUNCTION IF EXISTS `FindQuestionID`;

DELIMITER $$
CREATE FUNCTION `FindQuestionID` (aID INT) RETURNS INT DETERMINISTIC
BEGIN
	  # variables 
      DECLARE qID INT DEFAULT -1;
      
	  # match answer_ID to corresponding question
            SELECT question_ID INTO qID
            FROM  `answers`
            WHERE answer_ID = aID;
            
	  # if not found retuns -1
      RETURN qID;
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/
DROP FUNCTION IF EXISTS `TotalQuestions`;

DELIMITER $$
CREATE FUNCTION `TotalQuestions` (sID INT) RETURNS INT DETERMINISTIC
BEGIN
      # variables 
      DECLARE total INT DEFAULT -1;
      
	  # match answer_ID to corresponding question
            SELECT COUNT(survey_ID) INTO total
            FROM  `questions`
            WHERE survey_ID = sID;
            
	  # total num of questions in a survey
      RETURN total;
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/
DROP FUNCTION IF EXISTS `IsSurveyFinished`;

DELIMITER $$
CREATE FUNCTION `IsSurveyFinished` (qID INT, sID INT)  RETURNS BOOL DETERMINISTIC
BEGIN
	  # variables 
      DECLARE total INT DEFAULT totalQuestions (sID); # set total to total number of question in a survey
      DECLARE num INT DEFAULT -1; 
	  DECLARE done BOOLEAN DEFAULT FALSE;
      
	  # set values of num 
			SELECT question_order INTO num
            FROM questions 
            WHERE question_ID = qID; 
            
	  # if last question is being answered and question exits
			IF num = total && num != -1 THEN
				SET done = TRUE;
			END IF;
      
      RETURN done;
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/
DROP FUNCTION IF EXISTS `TotalSurveys`;

DELIMITER $$
CREATE FUNCTION `TotalSurveys` (cID INT) RETURNS INT DETERMINISTIC
BEGIN
      # variables 
      DECLARE total INT DEFAULT -1;
      
            SELECT COUNT(survey_ID) INTO total
            FROM  `surveys_created`
            WHERE customer_ID = cID;
            
	  # total num of surveys from a customer
      RETURN total;
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/
DROP FUNCTION IF EXISTS `TakenSurvey`;

DELIMITER $$
CREATE FUNCTION `TakenSurvey` (sID INT) RETURNS INT DETERMINISTIC
BEGIN
      # variables 
      DECLARE total INT DEFAULT -1;
   
            SELECT COUNT(taker_ID) INTO total
            FROM  `survey_results`
            WHERE survey_ID = sID;
            
      SET total =  total / TotalQuestions (sID) ;     
	  # total num of surveys from a customer
      RETURN total;
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/
DROP FUNCTION IF EXISTS `PickedChoice`;

DELIMITER $$
CREATE FUNCTION `PickedChoice` (aID INT, sID INT) RETURNS DOUBLE DETERMINISTIC
BEGIN
      # variable must be a double
      DECLARE total DOUBLE DEFAULT -1;
      DECLARE d DOUBLE DEFAULT TakenSurvey (sID);
      
   
            SELECT COUNT(taker_ID) INTO total
            FROM  `survey_results`
            WHERE answer_ID = aID;
            
      SET total =  total / d;     
	  # precent of survey takers that selected an answer
      RETURN total;
END $$

DELIMITER ;
