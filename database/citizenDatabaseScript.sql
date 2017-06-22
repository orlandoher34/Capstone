/*

Author: Richard McDonald

About Script:
This script will automate the database build and will include some intial
records for User accounts and the rooms. All you should need to do is import the
script with your preferred MySQL management program or if you feel like getting
adventerous, you can run the following command line:

mysql -u <yourDBUsername> -p < /path/to/file/citizenDatabaseScript.sql

Note:
Initially the db username should be root and whatever password you used when installing mysql.

*/


-- Create Datbase

CREATE DATABASE CITIZEN;

/*
To use the same database user account that is in the project code
uncomment the next three lines by deleting the '--' characters at
the begging of each line.
*/

--GRANT USAGE ON *.* TO dbadmin@localhost IDENTIFIED BY 'db123';

--GRANT ALL PRIVILEGES ON CITIZEN.* TO dbadmin@localhost;

--FLUSH PRIVILEGES;

USE CITIZEN;

-- This table should be used for login, user authentication, reservations and confirmations

CREATE TABLE User(
   `userEmail` VARCHAR(35) NOT NULL,
   `fName` VARCHAR(30) NOT NULL,
   `lName` VARCHAR(30) NOT NULL,
   `userPassword` VARCHAR(15) NOT NULL,
   `role` VARCHAR(5) NOT NULL,
   PRIMARY KEY ( `userEmail` )
);

-- Insertion data for user table

INSERT INTO User VALUES ('jsmith@citizen.com', 'John', 'Smith', 'js123', 'user');
INSERT INTO User VALUES ('caltman@citizen.com', 'Camila', 'Altman', 'ca123', 'admin');
INSERT INTO User VALUES ('ohernandez@citizen.com', 'Orlando', 'Hernandez', 'oh123', 'admin');
INSERT INTO User VALUES ('fkahn@citizen.com', 'Fahd', 'Kahn', 'fk123', 'admin');
INSERT INTO User VALUES ('rmcdonald@citizen.com', 'Richard', 'McDonald', 'rm123', 'user');

--- Create table for Rooms

CREATE TABLE Room(
`roomNumber` INT NOT NULL,
`roomName` VARCHAR(40) NOT NULL,
PRIMARY KEY(`roomNumber`)
);

-- Insertion data for Rooms table

INSERT INTO Room VALUES (01, 'Winter Room');
INSERT INTO Room VALUES (02, 'Spring Room');
INSERT INTO Room VALUES (03, 'Fall Room');
INSERT INTO Room VALUES (04, 'Summer Room');
INSERT INTO Room VALUES (05, 'Chicago Room');
INSERT INTO Room VALUES (06, 'Evanston Room');
INSERT INTO Room VALUES (07, 'Qatar Room');
INSERT INTO Room VALUES (08, 'Ball Room');
INSERT INTO Room VALUES (09, 'Beer Room');
INSERT INTO Room VALUES (10, 'Fizzy Lifting Drink Room');

-- Create table for reservations created by app

CREATE TABLE Reservation(
`task` VARCHAR(50) NOT NULL,
`startYear` VARCHAR(4) NOT NULL,
`startMonth` VARCHAR(2) NOT NULL,
`startDay` VARCHAR(2) NOT NULL,
`startHour` VARCHAR(2) NOT NULL,
`startMinute` VARCHAR(2) NOT NULL,
`startSecond` VARCHAR(2) NOT NULL,
`endYear` VARCHAR(4) NOT NULL,
`endMonth` VARCHAR(2) NOT NULL,
`endDay` VARCHAR(2) NOT NULL,
`endHour` VARCHAR(2) NOT NULL,
`endMinute` VARCHAR(2) NOT NULL,
`endSecond` VARCHAR(2) NOT NULL,
`roomNumber` INT NOT NULL,
`resID` INT NOT NULL AUTO_INCREMENT,

PRIMARY KEY(`resID`)
FOREIGN KEY(`roomNumber`) REFERENCES Room(`roomNumber`)
);


/*
Old Reservation TABLE

CREATE TABLE Reservation(
`resID` INT NOT NULL AUTO_INCREMENT,
`roomNumber` INT NOT NULL,
`userEmail` VARCHAR(30) NOT NULL,
`resStart` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
`resStop` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
`comments` VARCHAR(64),

PRIMARY KEY( `resID`, `roomNumber`, `userEmail`),
FOREIGN KEY(`roomNumber`) REFERENCES Room(`roomNumber`),
FOREIGN KEY(`userEmail`) REFERENCES User(`userEmail`)
);

*/

-- Values for TIMESTAMP follow 'YYYY-MM-DD HH:MM:SS[.fraction]'

/* <-- Remove this and the reverse mark at bottom to uncomment these tables
-- Here is a sample insertion that would be coded from web app to give us an idea of variables needed

INSERT INTO Reservation VALUES (02, 'rmcdonald@citizen.com', '2017-04-12 12:00:00.0', '2017-04-12 13:00:00.0', 'Richards Super Meeting');

*/
