CREATE DATABASE RegionalSchool;
USE RegionalSchool;

CREATE TABLE school (
	schoolID INT PRIMARY KEY NOT NULL,
    school_name VARCHAR(64),
    town VARCHAR(64),
    street VARCHAR(64),
    zipcode VARCHAR(32),
    phone VARCHAR(16));

CREATE TABLE pupil (
	pupilID INT PRIMARY KEY NOT NULL,
    first_name VARCHAR(64),
    last_name VARCHAR(64),
    sex CHAR(1),
    birth_date DATE,
    schoolID INT,
    FOREIGN KEY (schoolID) REFERENCES school(schoolID) ON DELETE RESTRICT ON UPDATE RESTRICT);
    
CREATE TABLE teacher ( 
	NIN CHAR(9) PRIMARY KEY NOT NULL,
    first_name VARCHAR(64),
    last_name VARCHAR(64),
    sex CHAR(1),
    qualifications TEXT,
    schoolID INT,
    FOREIGN KEY (schoolID) REFERENCES school(schoolID) ON DELETE RESTRICT ON UPDATE RESTRICT);
    
CREATE TABLE management (
	managementID INT PRIMARY KEY AUTO_INCREMENT NOT NULL, 
    start_date DATE, 
    schoolID INT,
    teacherNIN CHAR(9),
    FOREIGN KEY (schoolID) REFERENCES school(schoolID) ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (teacherNIN) REFERENCES teacher(NIN) ON DELETE RESTRICT ON UPDATE RESTRICT);
    
CREATE TABLE subject (
	subject_name VARCHAR(64) PRIMARY KEY NOT NULL,
    subject_level ENUM ('undergraduate', 'graduate') NOT NULL,
    subject_abbrev VARCHAR(16) UNIQUE NOT NULL);
    
CREATE TABLE class (
	hours_taught INT,
    class_number INT,
    teacherNIN CHAR(9),
    subjectName VARCHAR(64),
    PRIMARY KEY(class_number, subjectName),
    FOREIGN KEY (teacherNIN) REFERENCES teacher(NIN) ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (subjectName) REFERENCES subject(subject_name) ON DELETE RESTRICT ON UPDATE RESTRICT);

CREATE TABLE pupilRegistration (
	pupilID INT,
    classNumber INT,
    subjectName VARCHAR(64),
    PRIMARY KEY(pupilID, classNumber, subjectName),
    FOREIGN KEY (pupilID) REFERENCES pupil(pupilID) ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (classNumber, subjectName) 
		REFERENCES class(class_number, subjectName) ON DELETE RESTRICT ON UPDATE RESTRICT);

    