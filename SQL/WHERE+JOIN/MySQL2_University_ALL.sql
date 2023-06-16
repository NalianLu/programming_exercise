/* MySQL2_University_ALL.sql */
-- Contains all CREATE TABLE statements as well as all the data

-- Student table
CREATE TABLE Student
( StdNo			CHAR(11), 
  StdFirstName	VARCHAR(50) NOT NULL,
  StdLastName	VARCHAR(50) NOT NULL,
  StdCity		VARCHAR(50)	NOT NULL,
  StdState		CHAR(2)		NOT NULL,
  StdZip		CHAR(10)	    NOT NULL,
  StdMajor		CHAR(4),
  StdClass		CHAR(2),
  StdGPA		DECIMAL(3,2),
  CONSTRAINT PKStudent PRIMARY KEY (StdNo)
);

-- Course table
CREATE TABLE Course
( CourseNo		CHAR(6),
  CrsDesc		VARCHAR(250) NOT NULL,
  CrsUnits		INTEGER,	
  CONSTRAINT PKCourse PRIMARY KEY (CourseNo),
  CONSTRAINT UniqueCrsDesc UNIQUE (CrsDesc)
);

-- Faculty table
CREATE TABLE Faculty
( FacNo			CHAR(11),
  FacFirstName	VARCHAR(50) NOT NULL,
  FacLastName	VARCHAR(50) NOT NULL,
  FacCity		VARCHAR(50) NOT NULL,
  FacState		CHAR(2)		NOT NULL,
  FacZipCode	CHAR(10)		NOT NULL,
  FacHireDate	DATE,
  FacDept		CHAR(6),
  FacRank		CHAR(4),
  FacSalary		DECIMAL(8,2),
  FacSupervisor	CHAR(11),
  CONSTRAINT PKFaculty PRIMARY KEY (FacNo)
  -- Self-referencing key, skip and come back to at the end
  -- CONSTRAINT FKSupervisor FOREIGN KEY (FacSupervisor) 
    -- REFERENCES Faculty(FacNo)
);

-- Offering table
CREATE TABLE Offering
( OfferNo		INTEGER,	
  CourseNo		CHAR(6) 	NOT NULL,
  OffTerm		VARCHAR(6)		NOT NULL,
  OffYear		INTEGER		NOT NULL, 
  OffLocation	CHAR(6),
  OffDays		CHAR(4),
  OffTime		TIME,
  FacNo			CHAR(11),
  CONSTRAINT PKOffering PRIMARY KEY (OfferNo),
  CONSTRAINT FKCourse FOREIGN KEY (CourseNo) 
    REFERENCES Course(CourseNo),
  CONSTRAINT FKFaculty FOREIGN KEY (FacNo) 
    REFERENCES Faculty(FacNo)
);

-- Enrollment table
CREATE TABLE Enrollment
( OfferNo		INTEGER,
  StdNo			CHAR(11),
  EnrGrade		DECIMAL(3,2),
  CONSTRAINT PKEnrollment PRIMARY KEY (OfferNo, StdNo), 
  CONSTRAINT FKOfferNo FOREIGN KEY (OfferNo) 
    REFERENCES Offering(OfferNo)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT FKStdNo FOREIGN KEY (StdNo) 
    REFERENCES Student(StdNo)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- Student data
INSERT INTO Student (StdNo,StdFirstName,StdLastName,StdCity,StdState,StdZip,StdMajor,StdClass,StdGPA) VALUES ('123-45-6789','HOMER','WELLS','SEATTLE','WA','98121-1111','IS','FR',3);
INSERT INTO Student (StdNo,StdFirstName,StdLastName,StdCity,StdState,StdZip,StdMajor,StdClass,StdGPA) VALUES ('124-56-7890','BOB','NORBERT','BOTHELL','WA','98011-2121','FIN','JR',2.7);
INSERT INTO Student (StdNo,StdFirstName,StdLastName,StdCity,StdState,StdZip,StdMajor,StdClass,StdGPA) VALUES ('234-56-7890','CANDY','KENDALL','TACOMA','WA','99042-3321','ACCT','JR',3.5);
INSERT INTO Student (StdNo,StdFirstName,StdLastName,StdCity,StdState,StdZip,StdMajor,StdClass,StdGPA) VALUES ('345-67-8901','WALLY','KENDALL','SEATTLE','WA','98123-1141','IS','SR',2.8);
INSERT INTO Student (StdNo,StdFirstName,StdLastName,StdCity,StdState,StdZip,StdMajor,StdClass,StdGPA) VALUES ('456-78-9012','JOE','ESTRADA','SEATTLE','WA','98121-2333','FIN','SR',3.2);
INSERT INTO Student (StdNo,StdFirstName,StdLastName,StdCity,StdState,StdZip,StdMajor,StdClass,StdGPA) VALUES ('567-89-0123','MARIAH','DODGE','SEATTLE','WA','98114-0021','IS','JR',3.6);
INSERT INTO Student (StdNo,StdFirstName,StdLastName,StdCity,StdState,StdZip,StdMajor,StdClass,StdGPA) VALUES ('678-90-1234','TESS','DODGE','REDMOND','WA','98116-2344','ACCT','SO',3.3);
INSERT INTO Student (StdNo,StdFirstName,StdLastName,StdCity,StdState,StdZip,StdMajor,StdClass,StdGPA) VALUES ('789-01-2345','ROBERTO','MORALES','SEATTLE','WA','98121-2212','FIN','JR',2.5);
INSERT INTO Student (StdNo,StdFirstName,StdLastName,StdCity,StdState,StdZip,StdMajor,StdClass,StdGPA) VALUES ('876-54-3210','CRISTOPHER','COLAN','SEATTLE','WA','98114-1332','IS','SR',4);
INSERT INTO Student (StdNo,StdFirstName,StdLastName,StdCity,StdState,StdZip,StdMajor,StdClass,StdGPA) VALUES ('890-12-3456','LUKE','BRAZZI','SEATTLE','WA','98116-0021','IS','SR',2.2);
INSERT INTO Student (StdNo,StdFirstName,StdLastName,StdCity,StdState,StdZip,StdMajor,StdClass,StdGPA) VALUES ('901-23-4567','WILLIAM','PILGRIM','BOTHELL','WA','98113-1885','IS','SO',3.8);

-- Course data
INSERT INTO Course (CourseNo,CrsDesc,CrsUnits) VALUES ('FIN300','FUNDAMENTALS OF FINANCE',3);
INSERT INTO Course (CourseNo,CrsDesc,CrsUnits) VALUES ('FIN450','PRINCIPLES OF INVESTMENTS',4);
INSERT INTO Course (CourseNo,CrsDesc,CrsUnits) VALUES ('FIN480','CORPORATE FINANCE',4);
INSERT INTO Course (CourseNo,CrsDesc,CrsUnits) VALUES ('IS320','FUNDAMENTALS OF BUSINESS PROGRAMMING',3);
INSERT INTO Course (CourseNo,CrsDesc,CrsUnits) VALUES ('IS460','SYSTEMS ANALYSIS',4);
INSERT INTO Course (CourseNo,CrsDesc,CrsUnits) VALUES ('IS470','BUSINESS DATA COMMUNICATIONS',4);
INSERT INTO Course (CourseNo,CrsDesc,CrsUnits) VALUES ('IS480','FUNDAMENTALS OF DATABASE MANAGEMENT',4);

-- Faculty data
INSERT INTO Faculty (FacNo,FacFirstName,FacLastName,FacCity,FacState,FacZipCode,FacHireDate,FacDept,FacRank,FacSalary,FacSupervisor) VALUES ('098-76-5432','LEONARD','VINCE','SEATTLE','WA','98111-9921','2017-04-10','MS','ASST',35000,'654-32-1098');
INSERT INTO Faculty (FacNo,FacFirstName,FacLastName,FacCity,FacState,FacZipCode,FacHireDate,FacDept,FacRank,FacSalary,FacSupervisor) VALUES ('543-21-0987','VICTORIA','EMMANUEL','BOTHELL','WA','98011-2242','2018-04-15','MS','PROF',120000,NULL);
INSERT INTO Faculty (FacNo,FacFirstName,FacLastName,FacCity,FacState,FacZipCode,FacHireDate,FacDept,FacRank,FacSalary,FacSupervisor) VALUES ('654-32-1098','LEONARD','FIBON','SEATTLE','WA','98121-0094','2016-05-01','MS','ASSC',70000,'543-21-0987');
INSERT INTO Faculty (FacNo,FacFirstName,FacLastName,FacCity,FacState,FacZipCode,FacHireDate,FacDept,FacRank,FacSalary,FacSupervisor) VALUES ('765-43-2109','NICKI','MACON','BELLEVUE','WA','98015-9945','2019-04-11','FIN','PROF',65000,NULL);
INSERT INTO Faculty (FacNo,FacFirstName,FacLastName,FacCity,FacState,FacZipCode,FacHireDate,FacDept,FacRank,FacSalary,FacSupervisor) VALUES ('876-54-3210','CRISTOPHER','COLAN','SEATTLE','WA','98114-1332','2021-03-01','MS','ASST',40000,'654-32-1098');
INSERT INTO Faculty (FacNo,FacFirstName,FacLastName,FacCity,FacState,FacZipCode,FacHireDate,FacDept,FacRank,FacSalary,FacSupervisor) VALUES ('987-65-4321','JULIA','MILLS','SEATTLE','WA','98114-9954','2022-03-15','FIN','ASSC',75000,'765-43-2109');

-- Offering data
INSERT INTO Offering (OfferNo,CourseNo,OffTerm,OffYear,OffLocation,OffTime,OffDays,FacNo) VALUES (1111,'IS320','SUMMER',2028,'BLM302','10:30','MW',NULL);
INSERT INTO Offering (OfferNo,CourseNo,OffTerm,OffYear,OffLocation,OffTime,OffDays,FacNo) VALUES (1234,'IS320','FALL',2027,'BLM302','10:30','MW','098-76-5432');
INSERT INTO Offering (OfferNo,CourseNo,OffTerm,OffYear,OffLocation,OffTime,OffDays,FacNo) VALUES (2222,'IS460','SUMMER',2027,'BLM412','13:30','TTH',NULL);
INSERT INTO Offering (OfferNo,CourseNo,OffTerm,OffYear,OffLocation,OffTime,OffDays,FacNo) VALUES (3333,'IS320','SPRING',2028,'BLM214','08:30','MW','098-76-5432');
INSERT INTO Offering (OfferNo,CourseNo,OffTerm,OffYear,OffLocation,OffTime,OffDays,FacNo) VALUES (4321,'IS320','FALL',2027,'BLM214','15:30','TTH','098-76-5432');
INSERT INTO Offering (OfferNo,CourseNo,OffTerm,OffYear,OffLocation,OffTime,OffDays,FacNo) VALUES (4444,'IS320','WINTER',2028,'BLM302','15:30','TTH','543-21-0987');
INSERT INTO Offering (OfferNo,CourseNo,OffTerm,OffYear,OffLocation,OffTime,OffDays,FacNo) VALUES (5555,'FIN300','WINTER',2028,'BLM207','08:30','MW','765-43-2109');
INSERT INTO Offering (OfferNo,CourseNo,OffTerm,OffYear,OffLocation,OffTime,OffDays,FacNo) VALUES (5678,'IS480','WINTER',2028,'BLM302','10:30','MW','987-65-4321');
INSERT INTO Offering (OfferNo,CourseNo,OffTerm,OffYear,OffLocation,OffTime,OffDays,FacNo) VALUES (5679,'IS480','SPRING',2028,'BLM412','15:30','TTH','876-54-3210');
INSERT INTO Offering (OfferNo,CourseNo,OffTerm,OffYear,OffLocation,OffTime,OffDays,FacNo) VALUES (6666,'FIN450','WINTER',2028,'BLM212','10:30','TTH','987-65-4321');
INSERT INTO Offering (OfferNo,CourseNo,OffTerm,OffYear,OffLocation,OffTime,OffDays,FacNo) VALUES (7777,'FIN480','SPRING',2028,'BLM305','13:30','MW','765-43-2109');
INSERT INTO Offering (OfferNo,CourseNo,OffTerm,OffYear,OffLocation,OffTime,OffDays,FacNo) VALUES (8888,'IS320','SUMMER',2028,'BLM405','13:30','MW','654-32-1098');
INSERT INTO Offering (OfferNo,CourseNo,OffTerm,OffYear,OffLocation,OffTime,OffDays,FacNo) VALUES (9876,'IS460','SPRING',2028,'BLM307','13:30','TTH','654-32-1098');

-- Enrollment data
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (1234,'123-45-6789',3.3);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (1234,'234-56-7890',3.5);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (1234,'345-67-8901',3.2);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (1234,'456-78-9012',3.1);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (1234,'567-89-0123',3.8);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (1234,'678-90-1234',3.4);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (4321,'123-45-6789',3.5);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (4321,'124-56-7890',3.2);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (4321,'789-01-2345',3.5);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (4321,'876-54-3210',3.1);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (4321,'890-12-3456',3.4);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (4321,'901-23-4567',3.1);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (5555,'123-45-6789',3.2);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (5555,'124-56-7890',2.7);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (5678,'123-45-6789',3.2);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (5678,'234-56-7890',2.8);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (5678,'345-67-8901',3.3);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (5678,'456-78-9012',3.4);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (5678,'567-89-0123',2.6);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (5679,'123-45-6789',2);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (5679,'124-56-7890',3.7);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (5679,'678-90-1234',3.3);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (5679,'789-01-2345',3.8);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (5679,'890-12-3456',2.9);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (5679,'901-23-4567',3.1);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (6666,'234-56-7890',3.1);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (6666,'567-89-0123',3.6);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (7777,'876-54-3210',3.4);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (7777,'890-12-3456',3.7);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (7777,'901-23-4567',3.4);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (9876,'124-56-7890',3.5);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (9876,'234-56-7890',3.2);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (9876,'345-67-8901',3.2);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (9876,'456-78-9012',3.4);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (9876,'567-89-0123',2.6);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (9876,'678-90-1234',3.3);
INSERT INTO Enrollment (OfferNo,StdNo,EnrGrade) VALUES (9876,'901-23-4567',4);

-- Add self-referencing key to the Faculty table
ALTER TABLE Faculty  ADD CONSTRAINT FKSupervisor FOREIGN KEY (FacSupervisor) REFERENCES Faculty(FacNo);
