/* MySQL3_University.sql */
-- Example_01: List the name, city, and GPA of students
-- with a high GPA (greater than or equal to 3.7). (2 rows)
-- Relational operators; numerical criteria
SELECT StdFirstName, StdLastName, StdCity, StdGPA
FROM Student
WHERE StdGPA >= 3.7


-- Example_02: List the name, city, state and GPA of juniors. 
-- Order the result by GPA in descending order. (4 rows)
-- String criteria; sorting on a single column
SELECT StdFirstName, StdLastName, StdCity, StdState, StdGPA
FROM Student
WHERE StdClass = 'JR'
ORDER BY StdGPA DESC


-- Example_03: List the name, city, current salary and the 10% 
-- planned salary increase of faculty hired after 2018. (3 rows)
-- Calculated column and date criteria
SELECT FacFirstName, FacLastName, FacCity, FacSalary, 
   1.1 * FacSalary AS NewSalary
FROM Faculty
WHERE YEAR(FacHireDate) > 2018 

-- Example_04: List the senior level IS courses. (3 rows)
-- Selecting all columns; partial string match
SELECT * FROM Course
WHERE CourseNo LIKE 'IS4%'

-- Example_05: List the name and hiring date of faculty
-- hired in 2021 and 2022. Order the result by hire year
-- descending. (2 rows)
-- Logical operators; compound criteria
SELECT FacFirstName, FacLastName, FacHireDate
FROM Faculty
-- WHERE YEAR(FacHireDate) = 2021 OR YEAR(FacHireDate) = 2022
-- WHERE YEAR(FacHireDate) IN (2021, 2022)
-- WHERE FacHireDate BETWEEN '2021-1-1' AND '2022-12-31'
WHERE FacHireDate >= '2021-1-1' AND FacHireDate <= '2022-12-31'
ORDER BY YEAR(FacHireDate) DESC

-- Example_06: List the offering and course numbers, days, 
-- times and location of offerings in summer 2028 without
-- an assigned instructor. (1 row) 
-- Working with NULL in criteria
SELECT OfferNo, CourseNo, OffDays, OffTime, OffLocation
FROM Offering
WHERE OffTerm = 'SUMMER' AND OffYear = 2028 AND FacNo IS NULL

-- Example_07: List the course, offering, and faculty numbers,
-- days, times and location of offerings scheduled in fall 2027
-- and winter 2028, sorted on course number and offer numbers
-- desceinding. (6 rows)
-- Multiple compound criteria; sorting on multiple columns
SELECT CourseNo, OfferNo, FacNo, OffDays, OffTime, OffLocation
FROM Offering
WHERE (OffTerm = 'FALL' AND OffYear = 2027) OR
	  (OffTerm = 'WINTER' AND OffYear = 2028)
ORDER BY CourseNo, OfferNo DESC

-- Example_08: List the offering and course numbers, days, 
-- times and location of offerings containing words database  
-- or programming in the course description and taught in 
-- spring 2028. (2 rows)
-- Joins (INNER vs. CROSS); ambiguous columns;
-- Order of precedence in complex compound criteria
SELECT OfferNo, Course.CourseNo, OffDays, OffTime, OffLocation, CrsDesc
-- Start with CROSS JOIN, replace with INNER JOIN
FROM Offering INNER JOIN Course
	ON Course.CourseNo = Offering.CourseNo
WHERE OffTerm = 'SPRING' AND OffYear = 2028
  AND (CrsDesc LIKE '%programming%' OR CrsDesc LIKE '%database%') -- must add parenthesis here

-- Example_09: Retrieve the name, city, and grade of students 
-- who have a high grade (greater than or equal to 3.5) in a 
-- course offered in spring 2028. (5 rows)
-- Joining more than two tables with nested joins;
-- Table aliases with AS; Nesting () do not matter
SELECT StdFirstName, StdLastName, StdCity, EnrGrade
FROM (Student AS S INNER JOIN Enrollment E  -- or just 'JOIN' due to inner join as default
  ON S.StdNo = E.StdNo)
    INNER JOIN Offering O
	  ON E.OfferNo = O.OfferNo
WHERE EnrGrade >= 3.5
  AND OffTerm = 'SPRING' AND OffYear = 2028
  
-- Example_10: For IS offerings, retrieve the offer number,
-- course number, and the faculty name. Include an offering in
-- the result even if the faculty is not yet assigned. (10 rows)
-- One-sided outer joins; aliases without AS
SELECT OfferNo, CourseNo, FacFirstName, FacLastName
FROM Offering O LEFT OUTER JOIN Faculty F
  ON O.FacNo = F.FacNo
WHERE CourseNo LIKE 'IS%'