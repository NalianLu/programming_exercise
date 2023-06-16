/* MySQL2_University.sql */
-- CREATE TABLE statement, column naming, data types
-- based on data source, required vs. optional values
CREATE TABLE Student (
  -- Data type based on data source: CHAR vs. VARCHAR
  StdNo         CHAR(11),
  StdFirstName  VARCHAR(50)  NOT NULL,
  StdLastName	VARCHAR(50)  NOT NULL,
  StdCity		VARCHAR(50)  NOT NULL,
  StdState      CHAR(2)      NOT NULL,
  StdZip        CHAR(10)     NOT NULL,
  StdMajor      CHAR(4),
  StdClass      CHAR(2),
  StdGPA        DECIMAL(3,2), -- 9.99 is the largest number, 0 or 1 decimal are also accepted
  -- Primary key
  CONSTRAINT PKStudent PRIMARY KEY (StdNo) -- no comma becuase nothing follows
 );
 
CREATE TABLE Course
( CourseNo		CHAR(6),
  CrsDesc		VARCHAR(250) NOT NULL,
  CrsUnits		INTEGER,		-- Numerical data types
  -- Primary key
  CONSTRAINT PKCourse PRIMARY KEY (CourseNo),
  -- Unique key
  CONSTRAINT UKCourse UNIQUE KEY (CrsDesc)
);

CREATE TABLE Faculty
( FacNo			CHAR(11),
  FacFirstName	VARCHAR(50) NOT NULL,
  FacLastName	VARCHAR(50) NOT NULL,
  FacCity		VARCHAR(50) NOT NULL,
  FacState		CHAR(2)		NOT NULL,
  FacZipCode	CHAR(9)		NOT NULL,
  FacHireDate	DATE,			-- Date/Time data types
  FacDept		CHAR(6),
  FacRank		CHAR(4),
  FacSalary		DECIMAL(8,2),
  FacSupervisor	CHAR(11),
  CONSTRAINT PKFaculty PRIMARY KEY (FacNo)
  -- Self-referencing key, skip and come back to at the end after import
);
-- FacZipCode incorrectly specified as CHAR(9) instead of CHAR(10)
ALTER TABLE Faculty MODIFY COLUMN FacZipCode CHAR(10);

CREATE TABLE Offering -- must after table student, course, and faculty based on relationship
( -- Data type based on data source
  OfferNo		INTEGER,  
  CourseNo		CHAR(6)    NOT NULL, -- FK required for the relationship
  OffTerm		VARCHAR(6),
  -- Data type based on data source
  OffYear		INTEGER,  
  OffLocation	CHAR(6),
  OffDays		CHAR(4),
  OffTime		TIME,  			-- Date/Time data type
  FacNo			CHAR(11),  		-- FK optional for the relationship
  -- Primary key
  CONSTRAINT PKOffering PRIMARY KEY (OfferNo),
  -- Foreign keys
  CONSTRAINT FKCourse FOREIGN KEY (CourseNo) 
	REFERENCES Course (CourseNo), -- refer to the CourseNo in course table, which means courseNo must exist in the Course table
  CONSTRAINT FKFaculty FOREIGN KEY (FacNo) 
	REFERENCES Faculty (FacNo)
);


CREATE TABLE Enrollment
( OfferNo		INTEGER,
  StdNo			CHAR(11),
  EnrGrade		DECIMAL(3,2),
  -- Compound primary key
  CONSTRAINT PKEnrollment PRIMARY KEY (OfferNo, StdNo),
  -- Foreign keys, restrict vs. cascade
  CONSTRAINT FKStudent FOREIGN KEY (StdNo) 
    REFERENCES Student(StdNo)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT, -- If I want to delete the student, I should go back to student table not in enrollment table
  CONSTRAINT FKOffering FOREIGN KEY (OfferNo) 
    REFERENCES Offering(OfferNo)
	ON UPDATE CASCADE
	ON DELETE CASCADE -- ? 
);

-- DO NOT run until after all the faculty have been imported!!!
ALTER TABLE Faculty ADD 
  CONSTRAINT FKSupervisor FOREIGN KEY (FacSupervisor) 
    REFERENCES Faculty(FacNo);