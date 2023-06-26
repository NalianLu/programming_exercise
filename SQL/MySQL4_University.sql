/* MySQL4_University.sql */
-- Example_01: List all faculty (first and last name) who taught 
-- finance classes using subqueries, sorted by faculty last name. 
-- (2 rows, Nicki and Julia)
-- One subquery of Type I (independent from main query) 
SELECT F1.FacFirstName, F1.FacLastName
FROM Faculty F1 
WHERE F1.FacNo IN 
  (SELECT O2.FacNo
   FROM Offering O2
   WHERE O2.CourseNo LIKE 'FIN%')
ORDER BY F1.FacLastName

-- Without subquery DISTINCT is needed.
SELECT DISTINCT FacFirstName, FacLastName
FROM Faculty JOIN Offering USING(FacNo)
WHERE CourseNo LIKE 'FIN%'
ORDER BY FacLastName

-- Example_02: List all faculty (first and last name) who taught finance
-- and information systems classes using subqueries, sorted by faculty 
-- last name. (1 row, Julia)
-- Two Type I subqueries nested within one another
SELECT F1.FacFirstName, F1.FacLastName
FROM Faculty F1 
WHERE F1.FacNo IN 
  (SELECT O2.FacNo
   FROM Offering O2
   WHERE O2.CourseNo LIKE 'FIN%' AND O2.FacNo IN
	(SELECT O3.FacNo
	 FROM Offering O3
	 WHERE O3.CourseNo LIKE 'IS%'))
ORDER BY F1.FacLastName
 
-- Example_03: List all faculty (first and last name) who taught finance 
-- classes and all the students (first and last name) who took classes 
-- taught by those faculty members, as well as the course and offering 
-- numbers, sorted by course number and faculty last name. (12 rows)
-- Note that this is different than listing faculty teaching and students 
-- taking only finance classes because Julia also teaches IS classes
SELECT F1.FacFirstName, F1.FacLastName, 
  S1.StdFirstName, S1.StdLastName, O1.OfferNo, O1.CourseNo
FROM Faculty F1 JOIN Offering O1 USING(FacNo)
  JOIN Enrollment E1 USING(OfferNo)
  JOIN Student S1 USING(StdNo)
WHERE F1.FacNo IN 
  (SELECT O2.FacNo
   FROM Offering O2
   WHERE O2.CourseNo LIKE 'FIN%')
ORDER BY O1.CourseNo, F1.FacLastName

-- **********************************************************************

-- Example_04: List the number of IS sections offered (10), as 
-- well as the number of IS sections offered that have an assigned
-- faculty member (8). (1 row)
-- Using COUNT function to count rows, but also how to skip NULLs
SELECT COUNT(CourseNo) AS NumOffering, COUNT(FacNo) AS NumOfferingWFaculty
FROM Offering
WHERE CourseNo LIKE 'IS%'

-- Example_05: List IS majors (first, last name and GPA) who have GPA's 
-- higher than all finance majors, sorted descending on GPA. (3 rows)
-- Using MAX function in Type I subquery
SELECT S1.StdFirstname, S1.StdLastName, S1.StdGPA
FROM Student S1
WHERE S1.StdMajor = 'IS' AND S1.StdGPA > 
  (SELECT MAX(S2.StdGPA)
   FROM Student S2
   WHERE S2.StdMajor = 'FIN')
ORDER BY S1.StdGPA DESC

--or
SELECT S1.StdFirstname, S1.StdLastName, S1.StdGPA
FROM Student S1
WHERE S1.StdMajor = 'IS' AND S1.StdGPA > ALL
  (SELECT S2.StdGPA
   FROM Student S2
   WHERE S2.StdMajor = 'FIN')
ORDER BY S1.StdGPA DESC

-- Example_06: Find the number of students and their average GPA's 
-- by major. (3 rows)
-- Grouping by a single column using GROUP BY clause
SELECT StdMajor, COUNT(*) AS NumStudents, AVG(StdGPA) AS AvgGPA
FROM Student
GROUP BY StdMajor
ORDER BY StdMajor


-- Example_07: Find the number of IS course offerings by course
-- description, including courses with no offerings. (4 rows)
-- Including the categories with no items and getting the 
-- correct COUNT of zero (0)
SELECT CrsDesc, COUNT(OfferNo) AS NumOffering -- use count(*) will show up 1 but the course doesn't have any offering
FROM Course C LEFT JOIN Offering O 
   ON C.CourseNo = O.CourseNo
WHERE C.CourseNo LIKE 'IS%'
GROUP BY CrsDesc

-- Example_08: Find the number of offerings and unique courses 
-- by year. (2 rows)
-- Counting distinct number of items in a group
SELECT OffYear, COUNT(*) AS NumOffering, COUNT(DISTINCT CourseNo) AS NumCourse
FROM Offering
GROUP BY OffYear

-- Example_09: Find the number of upper division students (juniors 
-- and seniors) and their average GPA's by major and class. Only list 
-- the rows with average GPA greater than 3.0. (3 rows)
-- Grouping by multiple columns and restricting the resulting
-- number of groups with HAVING clause
SELECT StdMajor, StdClass, COUNT(*) AS NumStudents, AVG(StdGPA) AS AvgGPA
FROM Student
WHERE StdClass = 'JR' OR StdClass = 'SR'
GROUP BY StdMajor, StdClass
HAVING AvgGPA > 3 -- where filter out individual student with GPA<=3, having filter out the whole group with avgGPA<=3
ORDER BY StdMajor, StdClass

-- Example_10: List the IS course and section numbers, and the number  
-- of students enrolled, for those sections whose enrollment meets or 
-- exceeds the total enrollment of all finance sections. (1 row)
-- Type I subquery in the HAVING clause
SELECT O1.CourseNo, O1.OfferNo, COUNT(*) AS NumEnroll
FROM Offering O1 INNER JOIN Enrollment E1 
  ON O1.OfferNo = E1.OfferNo 
WHERE O1.CourseNo LIKE 'IS%' 
GROUP BY O1.CourseNo, O1.OfferNo
HAVING NumEnroll >= 
  (SELECT COUNT(*) AS NumEnroll
   FROM Offering O2 INNER JOIN Enrollment E2
   ON O2.OfferNo = E2.OfferNo
   WHERE O2.CourseNo LIKE 'FIN%')

-- Change Setting
-- previous: 'sql_mode', 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'
SHOW VARIABLES LIKE '%sql_mode%';
SET sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'