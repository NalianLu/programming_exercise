/* MySQL2_University_Import.sql */
-- Edit my.ini file (Windows, under hidden ProgramData folder) or my.cnf file (macOS) 
-- secure_file_priv = ""
-- Restart the server, go to Workbench and type: 
SHOW VARIABLES LIKE 'secure_file_priv'
-- Vefify it is blank, which should allow importing from any folder
-- LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/File.csv'

-- Notes on importing experience with my daughter's old MacBook Air Big Sur 11.7.7
-- using MySQL Community Server and Workbench client version 8.0.28
-- Open Terminal app and type: 
-- $ pwd 
-- to get your present working directory: 
-- /Users/username
-- Assuming all the class files will be in Downloads, make sure to make the folder
-- and all subfolders read-write-execute: 
-- $ chmod -R 755 Downloads
-- My installation did not create the configuration file my.cnf, so I had to create
-- one on my own with 3 lines shown below: 
-- $ nano
-- [mysqld] 
-- secure_file_priv=''
-- local_infile=ON
-- Control+O will prompt you to save the file 
-- /Users/username/my.cnf
-- Control+X will exit nano
-- Go under Apple -> System Preferences -> MySQL -> Configuration -> Select my.cnf as the 
-- configuration file from /Users/username folder
-- Go back to Instances -> Stop and Start the Server
-- Open Workbench and Edit Connection (Local instance 3306) -> Advanced -> Others
-- type: OPT_LOCAL_INFILE=1 to enable loading data from the local machine
SHOW VARIABLES LIKE 'local_infile'
-- Modify all the LOAD DATA INFILE 'Path...' statements below to 
-- LOAD DATA LOCAL INFILE '/Users/username/Downloads...'
-- After a couple of hours of googling all this, I finally got it to work, but there
-- may be other issues that pop up ... 
-- If you need to delete data from a table and try again, you first must go to:
-- MySQLWorkbench -> Preferences -> SQL Editor -> uncheck Safe Updates (rejects DELETEs)
-- and restart Workbench. This will allow: DELETE FROM Table to execute

LOAD DATA INFILE 'C:/Users/65159/Downloads/MSBA_6321/02_Relate_DM/Lectures/Demos/University/University_Data/Student.csv'
INTO TABLE Student
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/65159/Downloads/MSBA_6321/02_Relate_DM/Lectures/Demos/University/University_Data/Course.csv'
INTO TABLE Course
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/65159/Downloads/MSBA_6321/02_Relate_DM/Lectures/Demos/University/University_Data/Faculty.csv'
INTO TABLE Faculty
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(FacNo,FacFirstName,FacLastName,FacCity,FacState,FacZipCode,
 @FacHireDate,FacDept,FacRank,FacSalary,@FacSupervisor)
SET FacHireDate = DATE_FORMAT(STR_TO_DATE(@FacHireDate, '%m/%d/%Y'), '%Y-%m-%d'), -- '%m/%d/%Y %H:%i:%s.%f' for time
	FacSupervisor = NULLIF(@FacSupervisor, '');
	
LOAD DATA INFILE 'C:/Users/65159/Downloads/MSBA_6321/02_Relate_DM/Lectures/Demos/University/University_Data/Offering.csv'
INTO TABLE Offering
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(OfferNo,CourseNo,OffTerm,OffYear,OffDays,OffLocation,OffTime,@FacNo)
SET FacNo = NULLIF(@FacNo, '');

LOAD DATA INFILE 'C:/Users/65159/Downloads/MSBA_6321/02_Relate_DM/Lectures/Demos/University/University_Data/Enrollment.csv'
INTO TABLE Enrollment
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;