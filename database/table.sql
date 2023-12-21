CREATE DATABASE IF NOT EXISTS `QuizApp` ;
USE `QuizApp`;
DROP TABLE IF EXISTS `USER`, `CLASS`, `STUDENT_IN_CLASS`, `QUIZ`, `QUIZ_QUESTION`, `SCORE`;
--
-- Table structure for table `USER`
--
CREATE TABLE `USER` (
  `ID` varchar(20) NOT NULL,
  `USER_NAME` varchar(20) NOT NULL,
  `EMAIL` varchar(50) NOT NULL,
  `NAME` varchar(100) NOT NULL,
  `PASSWORD` varchar(100) NOT NULL,
  `IS_DELETED` TINYINT(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Table structure for table `CLASS`
--
CREATE TABLE `CLASS` (
  `CLASS_ID` varchar(20) NOT NULL,
  `CLASS_NAME` varchar(20) NOT NULL,
  `TEACHER_ID` varchar(20) NOT NULL,
  `IS_DELETED` TINYINT(1) NOT NULL,
  PRIMARY KEY (`CLASS_ID`),
  CONSTRAINT `TEACHER_ID1` FOREIGN KEY (`TEACHER_ID`) REFERENCES `USER` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Table structure for table `STUDENT_IN_CLASS`
--
CREATE TABLE `STUDENT_IN_CLASS` (
  `ID` varchar(20) NOT NULL,
  `CLASS_ID` varchar(20) NOT NULL,
  `STUDENT_ID` varchar(20) NOT NULL,
  `SCORE` DECIMAL(3, 2) NOT NULL,
  `IS_DELETED` TINYINT(1) NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `CLASS_ID1` FOREIGN KEY (`CLASS_ID`) REFERENCES `CLASS` (`CLASS_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `STUDENT_ID1` FOREIGN KEY (`STUDENT_ID`) REFERENCES `USER` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Table structure for table `QUIZ`
--
CREATE TABLE `QUIZ` (
  `QUIZ_ID` varchar(20) NOT NULL,
  `CLASS_ID` varchar(20) NOT NULL,
  `QUIZ_NAME` varchar(20) NOT NULL,
  `START_TIME` datetime NOT NULL,
  `END_TIME` datetime NOT NULL,
  `LENGTH` int NOT NULL,
  `WEIGHT`  DECIMAL(3, 2) NOT NULL,
  `IS_DELETED` TINYINT(1) NOT NULL,
  PRIMARY KEY (`QUIZ_ID`),
  CONSTRAINT `CLASS_ID2` FOREIGN KEY (`CLASS_ID`) REFERENCES `CLASS` (`CLASS_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Table structure for table `QUIZ_QUESTION`
--
CREATE TABLE `QUIZ_QUESTION` (
  `QUESTION_ID` varchar(20) NOT NULL,
  `QUIZ_ID` varchar(20) NOT NULL,
  `QUESTION` varchar(10000) NOT NULL,
  `ANSWER_1` varchar(1000) NOT NULL,
  `ANSWER_2` varchar(1000) NOT NULL,
  `ANSWER_3` varchar(1000) NOT NULL,
  `ANSWER_4` varchar(1000) NOT NULL,
  `CORRECT_ANSWER` int NOT NULL,
  `IS_DELETED` TINYINT(1) NOT NULL,
  PRIMARY KEY (`QUESTION_ID`),
  CONSTRAINT `QUIZ_ID1` FOREIGN KEY (`QUIZ_ID`) REFERENCES `QUIZ` (`QUIZ_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Table structure for table `SCORE`
--
CREATE TABLE `SCORE` (
  `SCORE_ID` varchar(20) NOT NULL,
  `QUIZ_ID` varchar(20) NOT NULL,
  `STUDENT_ID` varchar(20) NOT NULL,
  `TRY` int NOT NULL,
  `NUMBER_OF_CORRECT` int NOT NULL,
  `IS_DELETED` TINYINT(1) NOT NULL,
  PRIMARY KEY (`SCORE_ID`),
  CONSTRAINT `QUIZ_ID2` FOREIGN KEY (`QUIZ_ID`) REFERENCES `QUIZ` (`QUIZ_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `STUDENT_ID2` FOREIGN KEY (`STUDENT_ID`) REFERENCES `USER` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;