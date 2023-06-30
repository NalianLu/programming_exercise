/* MySQL6_University.sql */
-- **********************************************************************
-- Type I and Type II Subqueries
-- **********************************************************************
-- Example_01: List finance students who took all offered information 
-- systems classes using two Type I subqueries, sorted on student last 
-- names. (2 rows)
-- Type I summary subqueries in the WHERE and HAVING clauses
SELECT S1.StdFirstName, S1.StdLastName
FROM Student S1
WHERE S1.StdMajor = 'FIN' AND S1.StdNo IN
  (SELECT E2.StdNo,
   FROM Enrollment E2 JOIN Offering O2 USING(OfferNo)
   WHERE O2.CourseNo LIKE 'IS%'
   GROUP BY E2.StdNo -- finance student who took IS courses;
   HAVING COUNT(DISTINCT O3.CourseNo) = -- to avoid someone took the same course twice
   (SELECT COUNT(DISTINCT O3.CourseNo)
    FROM Offering O3
    WHERE O3.CourseNo LIKE '%IS%'))
ORDER BY S1.StdLastName

-- Typical solution for finance student who took IS courses
SELECT S1.StdFirstName, S1.StdLastName, COUNT(DISTINCT O1.CourseNo)
FROM Student S1
	JOIN Enrollment E1 USING(StdNo) 
	JOIN Offering O1 USING(OfferNo)
WHERE S1.StdMajor = 'FIN' AND O1.CourseNo LIKE '%IS%'
GROUP BY S1.StdNo
HAVING COUNT(DISTINCT O1.CourseNo) = -- to avoid someone took the same course twice
   (SELECT COUNT(DISTINCT O2.CourseNo)
    FROM Offering O2
    WHERE O2.CourseNo LIKE '%IS%')

-- Example_02: List the faculty and the number of sections and unique 
-- courses (aka preps) they taught using a subquery to first filter out 
-- faculty teaching schedules. Sort the result on number of preps
-- descending and faculty last names. (6 rows)
-- Type I subquery in the FROM clause, i.e. using a derived table
SELECT FO1.FacLastName, FO1.FacFirstName, 
	COUNT(*) AS NumSections,
	COUNT(DISTINCT FO1.CourseNo) AS NumPreps
FROM (SELECT F2.FacNo, F2.FacFirstName, F2.FacLastName, O2.CourseNo
      FROM Faculty F2 INNER JOIN Offering O2
        ON F2.FacNo = O2.FacNo) FO1
GROUP BY FO1.FacNo
ORDER BY NumPreps DESC, FO1.FacLastName

-- Example_03: List the students and the last start of clases they 
-- took in Spring 2028 using a subquery in the SELECT statement, 
-- sorted by the student last name. (11 rows)
-- Type II subquery, where the subquery depends on the main query
SELECT S1.StdFirstName, S1.StdLastName, 
 (SELECT MAX(O2.OffTime)
   FROM Enrollment E2 JOIN Offering O2 USING(OfferNo)
   WHERE O2.OffTerm = 'SPRING' AND O2.OffYear = 2028 
	 AND E2.StdNo = S1.StdNo) -- E2.StdNo changes following the S1.StdNo changes
   AS LastClassStart
FROM Student S1
ORDER BY S1.StdLastName

-- Typical solution
SELECT S1.StdFirstName, S1.StdLastName, MAX(O1.OffTime) AS MaxofFTime
FROM Student S1
	JOIN Enrollment E1 USING(StdNo) 
	JOIN Offering O1 USING(OfferNo)
WHERE O1.OffTerm = 'SPRING' AND O1.OffYear = 2028
GROUP BY S1.StdNo
ORDER BY S1.StdNo

-- Example_04: List IS students with enrollments in finance classes
-- using Type II subquery in the WHERE clause and the EXIST operator,
-- sorted by student last names. (5 rows)
-- Type II subquery and EXISTS operator
SELECT S1.StdFirstname, S1.StdLastName
FROM Student S1
WHERE S1.StdMajor = 'IS' AND EXISTS
  (SELECT * -- rows for that student took Fin courses
   FROM Enrollment E2 JOIN Offering O2 USING(OfferNo)
   WHERE O2.CourseNo LIKE 'FIN%' 
     AND E2.StdNo = S1.StdNo) -- inner-outer connected
ORDER BY S1.StdLastName

-- Typical Solutions
SELECT DISTINCT -- to avoid duplicates for IS Student with multiple finance courses
	S1.StdFirstname, S1.StdLastName
FROM Student S1
	JOIN Enrollment E1 USING(StdNo) 
	JOIN Offering O1 USING(OfferNo)
WHERE S1.StdMajor = 'IS' AND O1.CourseNo LIKE 'FIN%'
ORDER BY S1.StdLastName

-- Example_05: List the students who are NOT taking classes in Winter 
-- of 2028 using Type II subquery in the WHERE clause and NOT EXISTS
-- operators, sorted by student last names. (5 rows)
-- Type II subquery and NOT EXISTS operators
SELECT DISTINCT S1.StdNo, S1.StdFirstName, S1.StdLastName
FROM Student S1
WHERE NOT EXISTS
  (SELECT * -- rows for that student about courses in 2028 WINTER
   FROM Enrollment E2 INNER JOIN Offering O2 ON E2.OfferNo = O2.OfferNo
   WHERE O2.OffTerm = 'WINTER' AND O2.OffYear = 2028  
	  AND E2.StdNo = S1.StdNo)
ORDER BY S1.StdLastName

-- Typical solution
SELECT DISTINCT S1.StdFirstname, S1.StdLastName, O1.OffTerm, O1.OffYear
FROM Student S1
	JOIN Enrollment E1 USING(StdNo) 
	JOIN Offering O1 USING(OfferNo)
GROUP BY S1.StdNo
HAVING
	SUM(CASE
		WHEN O1.OffTerm = 'WINTER' AND O1.OffYear = 2028 THEN 1
		ELSE 0
	END) = 0
ORDER BY S1.StdLastName

-- Example_06: List the faculty who are ONLY teaching in Winter of 2028
-- using Type II subquery in the WHERE clause and NOT EXISTS operators
-- sorted descending on faculty last names. (2 rows)
-- Type II subquery and NOT EXISTS operators
SELECT DISTINCT F1.FacNo, F1.FacFirstName, F1.FacLastName
FROM Faculty F1 INNER JOIN Offering O1
  ON F1.FacNo = O1.FacNo
WHERE O1.OffTerm = 'WINTER' AND O1.OffYear = 2028
  AND NOT EXISTS
	(SELECT * 
	 FROM Offering O2
	 WHERE (O2.OffTerm != 'WINTER' OR O2.OffYear != 2028) -- Spring28 True OR False = True
       AND O2.FacNo = F1.FacNo)
ORDER BY F1.FacLastName

-- Typical Solutions
SELECT F1.FacNo, F1.FacFirstName, F1.FacLastName
FROM Faculty F1 INNER JOIN Offering O1 ON F1.FacNo = O1.FacNo
GROUP BY F1.FacNo
HAVING
	SUM(CASE
		WHEN (O1.OffTerm != 'WINTER' OR O1.OffYear != 2028) THEN 1
		ELSE 0
	END) = 0
ORDER BY F1.FacLastName


-- **********************************************************************
-- Working with Views
-- **********************************************************************
-- Example_07: Create a single-table view, named Std_IS_Upper, showing 
-- the name, city, state, zip, class and GPA for IS juniors and 
-- seniors. (4 rows)
-- Creating a simple single table view
CREATE VIEW ??? AS
  SELECT StdNo, StdFirstName, StdLastName, StdClass, StdGPA
  FROM Student
  WHERE StdMajor = 'IS' AND (StdClass = 'JR' OR StdClass = 'SR')

-- List the upper-division IS students and their average grade by joining
-- the view with the base table. (4 rows)
-- View materialization (not supported by MySQL) vs. view modification
SELECT SV.StdFirstName, SV.StdLastName, 
  ROUND(AVG(E.EnrGrade),1) AS AvgGrade
FROM Std_IS_Upper SV INNER JOIN Enrollment E
  ON SV.StdNo = E.StdNo
GROUP BY SV.StdNo

-- Example_08: Create a multiple table view, named Std_Crs_Asst, showing
-- student name, major and class, as well as course description, grade, 
-- and faculty names for faculty with rank of assistant professor 
-- teaching sections of those courses. (18 rows)
-- Creating a multiple-table view 
CREATE VIEW ??? AS
  SELECT StdFirstName, StdLastName, StdMajor, StdClass, 
    CrsDesc, EnrGrade, FacFirstName, FacLastName
  FROM (((Student INNER JOIN Enrollment
    ON Student.StdNo = Enrollment.StdNo)
	  INNER JOIN Offering
	    ON Enrollment.OfferNo = Offering.OfferNo)
		  INNER JOIN Course
		    ON Offering.CourseNo = Course.CourseNo)
			  INNER JOIN Faculty
			    ON Offering.FacNo = Faculty.FacNo
  WHERE FacRank = 'ASST'

-- Use the view to find the average grade by course and class for IS
-- majors ordered by course and class. (7 rows)
-- Creating a summary query based on a multi-table view
SELECT CrsDesc, StdClass, ROUND(AVG(EnrGrade), 1) AS AvgGrade
FROM Std_Crs_Asst
WHERE StdMajor = 'IS'
GROUP BY CrsDesc, StdClass
ORDER BY CrsDesc, StdClass

-- Example_09: Create a grouping view, named Enroll_Summary summarizing 
-- the enrollments by course and offering, using the following names: 
-- CourseName, SectionNo, TotOffEnroll and AvgOffGrade. (8 rows)
-- Creating a grouping/summary view 
CREATE VIEW Enroll_Summary (???, ???, ???, ???) AS
  SELECT C.CrsDesc, O.OfferNo, ???, ???
  FROM (Course C INNER JOIN Offering O
    ON C.CourseNo = O.CourseNo)
	  INNER JOIN Enrollment E
	    ON O.OfferNo = E.OfferNo
GROUP BY C.CrsDesc, O.OfferNo

-- Using grouping/summary query on a grouping/summary view to further 
-- summarize the data by finding the total enrollment and average grade 
-- by course. (6 rows)
SELECT CourseName, ???, ???
FROM Enroll_Summary
GROUP BY ???
ORDER BY ???

-- **********************************************************************
-- Self-referencing / Hierarchical / Recursive Queries
-- **********************************************************************
-- Example_10: List faculty members who have higher salary than their 
-- supervisor. List the faculty number, name, and salary of the faculty 
-- and their supervisors. (1 row)
-- Hierarchical (self-referencing) query
SELECT F1.FacNo, F1.FacFirstName, F1.FacLastName, F1.FacSalary,
       F2.FacNo AS SupNo, F2.FacFirstName AS SupFirstName,
	   F2.FacLastName AS SupLastName, F2.FacSalary AS SupSalary
FROM Faculty F1 INNER JOIN Faculty F2
  ON ???
WHERE ???

-- Example_11: List the faculty supervisors and the number of faculty 
-- members they are supervising, sorting descending on the number of 
-- faculty members being supervised. (3 rows) 
SELECT F2.FacFirstName, F2.FacLastName, ???
FROM Faculty F1 INNER JOIN Faculty F2
  ON ???
GROUP BY ???
ORDER BY ???

-- **********************************************************************
-- Overview of PL/SQL
-- **********************************************************************
-- Example_12: Create PL/SQL procedure to insert 2 enrollments into Summer 
-- 2027 offering 2222 of IS460 using the 2 IS SR students (Chris and Luke) 
-- that have not taken this class.
-- Designing a PL/SQL procedure that can be called anytime an enrollment 
-- for a particular section of a particular class for a particular student 
-- needs to be processed, typically for several of students in a batch.
DROP PROCEDURE IF EXISTS insert_enrollment;
DELIMITER $$
CREATE PROCEDURE insert_enrollment
  (IN ???,
   IN ???,
   IN ???)
  BEGIN 
    ???
  END$$

-- Call the procedure twice, once for each student enrollment 
-- Chris Colan IS SR with 4.0 GPA should get a high grade
CALL ???
-- Luke Brazzi IS SR with 2.2 GPA should get a lower grade
CALL ???

-- Example_13: List all the students with their major and class for 
-- students that have NOT taken IS460: Systems Analysis class. (4 rows)
-- Another Type II subquery and NOT EXISTS operators example utilizing
-- the 2 newly added IS460 enrollments.
SELECT S1.StdNo, S1.StdFirstName, S1.StdLastName, 
  S1.StdMajor, S1.StdClass
FROM Student S1
WHERE ???
  (SELECT * 
   FROM Student S2 INNER JOIN Enrollment E2 
     ON S2.StdNo = E2.StdNo
	   INNER JOIN Offering O2 
	     ON O2.OfferNo = E2.OfferNo
   WHERE ??? AND ???)

-- Example_14: Create PL/SQL function to calculate a weighted GPA for a 
-- given student number.
DROP FUNCTION IF EXISTS calc_weighted_GPA;
DELIMITER $$
CREATE FUNCTION calc_weighted_GPA (???) 
  RETURNS ???
  DETERMINISTIC 
  READS SQL DATA 
  BEGIN
    DECLARE ???;
    SELECT ???
	INTO ???
	FROM Enrollment JOIN Offering USING(OfferNo)
	  JOIN Course USING(CourseNo)
	WHERE StdNo = ???;
	RETURN ???;
  END$$

-- Testing procedure for Weighted GPA calculation function
DROP PROCEDURE IF EXISTS test_weighted_GPA;
DELIMITER $$
CREATE PROCEDURE test_weighted_GPA(IN sNo CHAR(11))
  BEGIN 
    DECLARE weight_GPA DECIMAL(3,2);
	DECLARE result_msg VARCHAR(100);
	SET weight_GPA = ???;
	IF weight_GPA IS NULL THEN 
	  SET result_msg = ???;
	ELSE 
	  SET result_msg = ???; 
	END IF;
	SELECT result_msg;
  END$$	

-- Test with valid student number which should return 3.42
CALL test_weighted_GPA('901-23-4567')

-- Test with invalid student number which should fail to find the student
CALL test_weighted_GPA('905-23-4567')

-- Example_15: Create PL/SQL function to use implicit cursor looping 
-- through the students and determines a given student's ranking based on 
-- his or her weighted GPA.
-- Note: We just want to read through the procedure and have a general
-- understanding of how database cursor works without coding it ourselves
DROP FUNCTION IF EXISTS student_ranking;
DELIMITER $$
CREATE FUNCTION student_ranking (sNo CHAR(11))
  RETURNS INTEGER
  DETERMINISTIC 
  READS SQL DATA
  BEGIN 
    DECLARE cursor_done INTEGER DEFAULT 0;
    -- Assume the student starts as top ranked
    DECLARE student_rank INTEGER DEFAULT 1;
	-- Declare student variables
	DECLARE std_no CHAR(11);
	DECLARE std_weight_GPA, weight_GPA DECIMAL(3,2);
	-- Declare and define student cursor
	DECLARE student_cursor CURSOR FOR 
	  SELECT StdNo, calc_weighted_GPA(StdNo) AS WeightGPA
	  FROM Student 
	  ORDER BY WeightGPA DESC;	
	-- Declare continue handler 
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET cursor_done = 1;
		
	-- Calculate the student's weighted GPA
	SET std_weight_GPA = calc_weighted_GPA(sNo);
	IF std_weight_GPA IS NULL THEN
	  return NULL;
	ELSE
	  -- Open the cursor
	  OPEN student_cursor;
	  -- Loop through students via cursor determining rank
	  lbl: LOOP
	  FETCH student_cursor INTO std_no, weight_GPA;
	  IF cursor_done = 1 THEN
	    LEAVE lbl;
	  END IF;
	  IF weight_GPA > std_weight_GPA THEN 
	    SET student_rank = student_rank + 1;
	  END IF;
	  END LOOP lbl;
	  -- Close the cursor
	  CLOSE student_cursor;
	  RETURN student_rank;
	END IF;
  END$$
	   
-- Testing procedure for Student Ranking calculation function	   
DROP PROCEDURE IF EXISTS test_std_rank;
DELIMITER $$
CREATE PROCEDURE test_std_rank(IN sNo CHAR(11))
  BEGIN 
    DECLARE std_rank INTEGER;
	DECLARE result_msg VARCHAR(100);
	SET std_rank = student_ranking(sNo);
	IF std_rank IS NULL THEN 
	  SET result_msg = CONCAT('Student ', sNo, ' not found!');
	ELSE 
	  SET result_msg = CONCAT('Student ', sNo, ' has a rank of ', 
	    CAST(std_rank AS CHAR)); 
	END IF;
	SELECT result_msg;
  END$$    

-- Test with valid student number which should be ranked #3 
CALL test_std_rank('901-23-4567');

-- Test with invalid student number which should fail to find the student
CALL test_weighted_GPA('905-23-4567')

-- Delete the 2 added 2222 enrollments if needed
DELETE FROM Enrollment WHERE OfferNo = 2222;
