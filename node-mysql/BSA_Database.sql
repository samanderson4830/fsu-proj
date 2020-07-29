DROP SCHEMA IF EXISTS BSA_Database;
CREATE SCHEMA BSA_Database;
USE `BSA_Database`;

DROP TABLE IF EXISTS `customers`;
DROP TABLE IF EXISTS `answers`;
DROP TABLE IF EXISTS `questions`;
DROP TABLE IF EXISTS `survey_results`;
DROP TABLE IF EXISTS `surveys_created`;

CREATE TABLE IF NOT EXISTS `BSA_Database`.`customers` (
  `customer_ID`  INT NOT NULL AUTO_INCREMENT,
  `email`        VARCHAR(100) NOT NULL,
  `first_name`   VARCHAR(50),
  `last_name`    VARCHAR(50),
  `thePassword`  VARCHAR(45)  NOT NULL,
  `company_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`customer_ID`),
  UNIQUE INDEX `customer_ID_UNIQUE` (`customer_ID` ASC)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `BSA_Database`.`surveys_created`(
    `survey_ID`         INT NOT NULL AUTO_INCREMENT, 
    `quick_description` VARCHAR(100), 
    `total_questions`   INT NOT NULL,
    `customer_ID`       INT NOT NULL, 
    `survey_name`       VARCHAR(30) NOT NULL, 
    `date_time`         TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP, 
    PRIMARY KEY (`survey_ID`), 
    INDEX        `idx.customer` (customer_ID),
    CONSTRAINT   `fk_customer_ID` 
    FOREIGN KEY (`customer_ID`)
    REFERENCES customers(`customer_ID`) ON UPDATE CASCADE ON DELETE RESTRICT
)ENGINE = InnoDB ;

CREATE TABLE IF NOT EXISTS `BSA_Database`.`questions`(
    `question_ID`     INT NOT NULL AUTO_INCREMENT, 
    `survey_ID`       INT NOT NULL, 
    `question_order`  INT NOT NULL, 
    `question_string` VARCHAR(250) NOT NULL, 
    `date_time`       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,  
    PRIMARY KEY(`question_ID`), 
    INDEX `idx.survey_ID` (survey_ID),
    CONSTRAINT `fk_survey_ID` 
    FOREIGN KEY(`survey_ID`)
    REFERENCES surveys_created(`survey_ID`) ON UPDATE CASCADE ON DELETE RESTRICT
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `BSA_Database`.`answers`(
    `answer_ID`     INT NOT NULL AUTO_INCREMENT, 
    `question_ID`   INT NOT NULL, 
    `answer_string` VARCHAR(100) NOT NULL, 
    `answer_order`  INT NOT NULL, 
    `date_time`     TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP, 
    PRIMARY KEY(`answer_ID`,`question_ID`),
    FOREIGN KEY(`question_ID`)
    REFERENCES questions(`question_ID`) ON UPDATE CASCADE ON DELETE RESTRICT

)ENGINE = InnoDB;

CREATE TABLE `BSA_Database`.`survey_results`(
	`entry_ID`  INT NOT NULL AUTO_INCREMENT, 
    `taker_ID`  INT NOT NULL, 
    `survey_ID` INT NOT NULL,
    `answer_ID` INT NOT NULL,  
    `is_done`   BOOLEAN, 
    `date_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP, 
	PRIMARY KEY (`entry_ID`),
    INDEX `idx.answer_ID` (answer_ID),
    CONSTRAINT `fk_answer_ID` 
    FOREIGN KEY(`answer_ID`) 
    REFERENCES answers(`answer_ID`) ON UPDATE CASCADE ON DELETE RESTRICT
)ENGINE = InnoDB;

/*-----------------------------------------------------------------------------
-- Creating Default temporay Data for Customer Table
-------------------------------------------------------------------------------*/

INSERT  INTO `customers`(`email`,`thePassword`,`company_name`, `first_name`, `last_name`) VALUES 
# all of the registered customers
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

INSERT INTO `surveys_created`(`customer_ID`,`survey_name`,`quick_description`, `total_questions`) VALUES
# All of the created surveys note note all have questiions
(1,  'Home Depot Performance Survey',   'Get some feedback about our Performance',                  2),
(1,  'Home Depot Employee Survey',      'Get some feedback from our Employees',                     1),
(2,  'Microsoft Vista Survey',          'Get some feedback about our product',                      1),
(3,  'BACONATOR Review',                'Check out what people think about the Baconator',          3),
(4,  'Customer Survey',                 'Get some feedback from our customers',                     0),
(5,  'How manly is your order?',        'To gauge the toxic masculinity levels',                    0),
(6,  'Did you flip your Blizzard?',     'To see if people are really this annoying',                0),
(7,  'Rate X-AE-12\'s performance',     'Get some on our child',                                    0),
(8,  'Spotify Survey',                  'Trying to get feedback on the bangers and sadboi tunes',   0),
(9,  'Overlord Bezos Survey',           'Get some feedback about our product',                      0);

/*-----------------------------------------------------------------------------
-- Creating Default temporay Data for Questions Table
-------------------------------------------------------------------------------*/

 INSERT INTO `questions`(`survey_ID`,`question_order`,`question_string`) VALUES
 # questions(2) for survey 1
(1,  1,  'How would you rate our performance today?'),
(1,  2,  'Will you return to this Home Depot?'),

 # questions(1) for survey 2
(2,  1,  'Do you enjoy working at Home Depot'),

 # questions(1) for survey 3
(3,  1,  'Do you like windows vista??'),

 # questions(3) for survey 4
(4,  1,  'There was a lot of bacon on my burger.'),
(4,  2,  'Did you enjoy to burger?'),
(4,  3,  'Rate the burger on a scale of 1 - 10 (10 being the best).');

/*-----------------------------------------------------------------------------
-- Creating Default temporay Data for Answers Table
-------------------------------------------------------------------------------*/
 INSERT INTO `answers`(`question_ID`,`answer_string`, `answer_order`) VALUES
 
-- Home Depot Performance Survey
# Ans for Q1
(1,    'Strongly Agree',          1), 
(1,    'Agree',                   2),
(1,    'Disagree',                3),
(1,    'Strongly Disagree',       4),

# Ans for Q2
(2,    'Yes',    1),
(2,    'No',     2),

-- Home Depot Employee Survey
# Ans for Q1
(3,    'Yes',    1),
(3,    'No',     2),

-- Windows Vista Survey
# Ans for Q1
(4,    'Yes',     1),
(4,    'No',      2),

-- BACONATOR Review
# Ans for Q1
(5,    'True',    1),   # 11
(5,    'False',   2),

# Ans for Q2
(6,    'Yes',     1),
(6,    'No',      2),

# Ans for Q3
(7,    '1',       1),  # 15
(7,    '2',       2),
(7,    '3',       3),
(7,    '4',       4),
(7,    '5',       5),
(7,    '6',       6),  # 20
(7,    '7',       7),
(7,    '8',       8),
(7,    '9',       9),
(7,    '10',      10);


/*-----------------------------------------------------------------------------
-- Creating Default temporay Data for survey_results Table
-------------------------------------------------------------------------------*/
 INSERT INTO `survey_results`(`taker_ID`,`survey_ID`,`answer_ID`, `is_done`) VALUES
 
-- Home Depot Performance Survey Answers / Has (2) questions
(1,      1,     2,     NULL),  # new taker 1
(1,      1,     6,     true),

(2,      1,     1,     NULL),  # new taker 2
(2,      1,     5,     true),

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

	SELECT * 
    FROM customers;
    
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `GetCustomersByID`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetCustomersByID` (IN cID INT)
BEGIN

   SELECT * 
   FROM customers 
   WHERE customer_ID = cID;
   
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `GetCustomersByName`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetCustomersByName` (IN cName VARCHAR(100) )
BEGIN

   SELECT * 
   FROM customers 
   WHERE company_name = cName;
   
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `GetCustomersByEmail`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetCustomersByEmail` (IN cEmail VARCHAR(100) )
BEGIN

   SELECT * 
   FROM customers 
   WHERE email = cEmail;
   
END $$

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
   
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------
--  PROCEDUREs for surveys_created table
-------------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `GetSurveyByID`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetSurveyByID` (IN sID INT)
BEGIN

   SELECT * 
   FROM surveys_created 
   WHERE survey_ID = sID;
   
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `GetSurveyCustomerByID`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetSurveyCustomerByID` (IN cID INT)
BEGIN

   SELECT * 
   FROM surveys_created
   WHERE customer_ID = cID;
   
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `GetDescription`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetDescription` (IN sID INT)
BEGIN

   SELECT quick_description 
   FROM surveys_created 
   WHERE survey_ID = sID;
   
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `GetTotalQuestions`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetTotalQuestions` (IN sID INT)
BEGIN

   SELECT total_questions 
   FROM surveys_created 
   WHERE survey_ID = sID;
   
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `GetOffset`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetOffset` (IN sID INT)
BEGIN

   SELECT total_questions 
   FROM surveys_created 
   WHERE survey_ID < sID;
   
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `SetTotalQuestions`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `SetTotalQuestions` (IN sID INT)
BEGIN

	UPDATE surveys_created 
	SET total_questions = TotalQuestions (sID)
    WHERE survey_ID = sID;
   
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `AddSurvey`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `AddSurvey` (IN cID INT, IN sName VARCHAR(100), IN qd  VARCHAR(100), IN total INT)
BEGIN

   INSERT INTO surveys_created (customer_ID, survey_name, quick_description, total_questions) 
   VALUES (cID, sName, qd , total);
   
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------
--  PROCEDUREs for questions table
-------------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `GetSurveyQuestion`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetSurveyQuestions` (IN sID INT)
BEGIN

   SELECT question_string
   FROM questions 
   WHERE survey_ID = sID;
   
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `GetSurveyAnswers`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetSurveyAnswers` (IN qID INT)
BEGIN

   SELECT answer_string
   FROM answers 
   WHERE answers.question_ID = qID;
   
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `GetQuestionNumber`;

DELIMITER $$
USE `BSA_Database` $$
CREATE PROCEDURE `GetQuestionNumber` (IN qID INT)
BEGIN

   SELECT question_order 
   FROM questions 
   WHERE question_ID = qID; 
 
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `GetQuestionID`;

DELIMITER $$
USE `BSA_Database` $$
CREATE PROCEDURE `GetQuestionID` (IN q_string VARCHAR(250))
BEGIN

   SELECT question_ID 
   FROM questions 
   WHERE question_string = q_string; 
 
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `AddQuestions`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `AddQuestions` (IN sID INT, IN qOrder INT, IN qString VARCHAR(250) )
BEGIN
	DECLARE qID  INT DEFAULT 0 ;

    INSERT INTO questions (survey_ID, question_order, question_string) 
    VALUES (sID, qOrder, qString);
    
    SET qID = QuestionStringToID(qString);
    CALL UpdateQuestionOrder (qID ,sID);
    
END $$

DELIMITER ;
/*-----------------------------------------------------------------------------*/

DROP FUNCTION IF EXISTS `UpdateQuestionOrder`;

#**************************************
# Helper function for Login           *
#**************************************

DELIMITER $$
CREATE PROCEDURE `UpdateQuestionOrder` (inputQuestionID INT, inputSurveyID INT) 
BEGIN

	UPDATE questions 
    SET question_order = TotalQuestions (inputSurveyID)
    WHERE survey_ID = inputSurveyID && question_ID = inputQuestionID;
    
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------
--  PROCEDUREs for answers table
-------------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `GetAnswersByQuestionID`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetAnswersByQuestionID` (IN qID INT)
BEGIN

   SELECT * 
   FROM answers 
   WHERE question_ID = qID; 
 
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `GetAnswerStringByID`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetAnswerStringByID` (IN aID INT)
BEGIN

   SELECT answer_string 
   FROM answers 
   WHERE answer_ID = aID; 
 
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `AddAnswer`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `AddAnswer` (IN qID INT, IN aOrder INT, IN aString VARCHAR(100) )
BEGIN

   INSERT INTO answers (question_ID, answer_order, answer_string) 
   VALUES (qID, aOrder, aString);
 
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------
--  PROCEDUREs for survey_results table
-------------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `GetResultsFromTaker`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetResultsFromTaker` (IN tID INT)
BEGIN

   SELECT * 
   FROM survey_results 
   WHERE taker_ID = tID; 
 
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `AddResult`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `AddResult` (IN ans_string VARCHAR(100), IN sID INT, IN qID INT) 
BEGIN
	
   DECLARE done BOOLEAN DEFAULT NULL;
   DECLARE tID INT DEFAULT SetTakerID (sID);
   DECLARE aID INT DEFAULT FindAnswerID(ans_string, qID);
   
   # check if survey is done 
		IF IsSurveyFinished (qID, sID) = TRUE THEN
			SET done = TRUE; 
		END IF;
        
   # if false done will remain null
    
   INSERT INTO survey_results (taker_ID, answer_ID, survey_ID, is_done) 
   VALUES (tID ,aID, sID, done);
      
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------
--  PROCEDUREs for Login
-------------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `ValidLogin`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `ValidLogin` (IN inputEmail VARCHAR(100), IN inputPass VARCHAR(100), OUT valid BOOL)
BEGIN
   IF LoginMatch(inputEmail, inputPass) IS NOT NULL
		THEN SET valid = 1;
   ELSE SET valid = 0;
   END IF;
END $$

/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `Login`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `Login` (IN inputEmail VARCHAR(100), IN inputPass VARCHAR(100))
BEGIN
	CALL ValidLogin(inputEmail, inputPass, @valid);
	SELECT @valid AS isValidLogin;
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------
--  PROCEDUREs for Picked Choices
-------------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `GetPrecent`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `GetPrecent` (IN inputAnswerString VARCHAR(100), 
							   IN inputQuestionString VARCHAR(250),
							   IN inputSurveyID INT)
BEGIN
	CALL SetPrecent(inputAnswerString, inputQuestionString, inputSurveyID ,@precent);
    SELECT @precent * 100 AS thePrecent;
END $$

/*-----------------------------------------------------------------------------*/

DROP PROCEDURE IF EXISTS `SetPrecent`;

DELIMITER $$
USE `BSA_Database`$$
CREATE PROCEDURE `SetPrecent` (IN inputAnswerString VARCHAR(100), 
                               IN inputQuestionString VARCHAR(250),
							   IN inputSurveyID INT,
                               OUT precent DOUBLE)
BEGIN
	DECLARE aID INT DEFAULT  0;
    DECLARE qID INT DEFAULT 0;
    
    SELECT question_ID INTO qID
    FROM questions
    WHERE question_string = inputQuestionString;
    
    SET aID = FindAnswerID(inputAnswerString, qID);  
    # SET aID = 5;
    # if aID is 0 then answerID wasnt found
    IF aID > 0 THEN
		SET precent = PickedChoice(aID, inputSurveyID);
    END IF;
END $$

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

#**************************************
# Helper function for PickedChoice.   *
#**************************************

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
      DECLARE taken DOUBLE DEFAULT TakenSurvey (sID);
      
            SELECT COUNT(taker_ID) INTO total
            FROM  `survey_results`
            WHERE answer_ID = aID;
            
      IF taken > 0 THEN      
		SET total =  total / taken;  
      ELSE 
		SET total = 0;
	  END IF;
      
	  # precent of survey takers that selected an answer
      RETURN total;
      
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/

DROP FUNCTION IF EXISTS `SetTakerID`;

#**************************************
# Helper function for AddResult       *
#**************************************

DELIMITER $$
CREATE FUNCTION `SetTakerID` (sID INT) RETURNS INT DETERMINISTIC
BEGIN
		
      DECLARE eID INT DEFAULT -1;   
	  DECLARE tID INT DEFAULT 0;  
      DECLARE done BOOL DEFAULT  TakenSurvey(sID);
      
      #***********************************
	  # find the last entryID
      
	  SELECT MAX(entry_ID) INTO eID 
      FROM survey_results 
      LIMIT 1 ;
      
	 #***********************************
     # get prev. taker_ID
      
      SELECT taker_ID INTO tID
      FROM survey_results 
      WHERE entry_ID = eID;
      
      #***********************************
      # get is_done value
      
      SELECT is_done INTO done 
      FROM survey_results 
      WHERE entry_ID = eID;
      
      #***********************************
      # if the last is_done is true the its a new taker
      # otherwise same taker dont change taker_ID
      
      IF (done = TRUE) THEN
			SET tID = tID + 1;
      END IF;

      RETURN tID;
      
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/

DROP FUNCTION IF EXISTS `FindAnswerID`;

#**************************************
# Helper function for AddResult       *
#**************************************

DELIMITER $$
CREATE FUNCTION `FindAnswerID` (ans_string VARCHAR (100), qID INT) RETURNS INT DETERMINISTIC
BEGIN

   # a question_ID will a have a set of associated answer_strings where it can
   # be reasonably assumed that all answer_strings(within that set) would be unique
   
   DECLARE a VARCHAR (100) DEFAULT ans_string; 
   DECLARE aID INT  DEFAULT 0; 
	
   SELECT MAX(answer_ID) INTO aID 
   FROM  answers 
   WHERE question_ID = qID
   LIMIT 1;
   
   L1: LOOP
   
		SELECT answer_string INTO ans_string 
		FROM answers 
		WHERE answer_ID = aID;
    
		IF ans_string = a || aID < 0  THEN
			LEAVE L1;
		ELSE 
			SET aID = aID - 1;
		END IF;
        
   END LOOP;
   
   RETURN aID;
      
END $$

DELIMITER ;

/*-----------------------------------------------------------------------------*/

DROP FUNCTION IF EXISTS `LoginMatch`;

#**************************************
# Helper function for Login           *
#**************************************

DELIMITER $$
CREATE FUNCTION `LoginMatch` (inputEmail VARCHAR(100), inputPass VARCHAR(100)) RETURNS VARCHAR(100) DETERMINISTIC
BEGIN

	DECLARE pwd VARCHAR(100);
	SELECT thePassword INTO pwd
    FROM 
	(
		SELECT * FROM CUSTOMERS 
        WHERE CUSTOMERS.email = InputEmail
	) AS userPass
    WHERE thePassword = inputPass;
	RETURN pwd;
END $$

DELIMITER ;
/*-----------------------------------------------------------------------------*/

DROP FUNCTION IF EXISTS `QuestionStringToID`;

#**************************************
# Helper function for Login           *
#**************************************

DELIMITER $$
CREATE FUNCTION `QuestionStringToID` (qString VARCHAR(100)) RETURNS INT DETERMINISTIC
BEGIN
	DECLARE qID INT;
    
	SELECT question_ID INTO qID
    FROM questions
    WHERE question_string = qString;
    
	RETURN qID;
END $$

DELIMITER ;
