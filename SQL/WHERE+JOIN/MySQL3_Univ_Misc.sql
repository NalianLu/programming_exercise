/* MySQL3_Univ_Misc.sql */
-- Example_11: List the student enrolled in sections 1234 and 
-- 3333, both IS320: Fundamentals of Business Programming. Use 
-- the IN set operator for the section criteria, JOIN and USING 
-- instead of INNER JOIN. (6 rows)
-- Concept(s): Thinking about sets and using IN set operator 
SELECT S.StdNo, S.StdFirstName, S.StdLastName 
FROM Enrollment E JOIN Student S USING(StdNo)
WHERE OfferNo IN (1234, 3333)
ORDER BY S.StdNo

-- Example_11 (cont.): Repeat for Spring 2028, section 5679 of
-- Fundamentals of Database Management (IS480). (Also 6 rows)
SELECT S.StdNo, S.StdFirstName, S.StdLastName 
FROM Enrollment E JOIN Student S USING(StdNo)
WHERE OfferNo IN (5679)

-- Example_11 (cont.): Combine the two lists of students from 
-- the previous step in the exercise. Create two solutions,
-- one without and another with the UNION operator. (10 rows)
-- Concept(s): Using DISTINCT operator to remove duplicates;
-- combining two result sets into one with UNION

-- Without UNION
SELECT DISTINCT S.StdNo, S.StdFirstName, S.StdLastName 
FROM Enrollment E JOIN Student S USING(StdNo)
WHERE OfferNo IN (1234, 3333, 5679)
ORDER BY S.StdNo

-- UNION automatically removes duplicates, UNION ALL does not (need to add DISTINCT StdNo)
SELECT S.StdNo AS SNo, S.StdFirstName, S.StdLastName 
FROM Enrollment E JOIN Student S USING(StdNo)
WHERE OfferNo IN (5679)
UNION
SELECT S.StdNo AS SNo, S.StdFirstName, S.StdLastName 
FROM Enrollment E JOIN Student S USING(StdNo)
WHERE OfferNo IN (1234, 3333)
ORDER BY SNo

-- **********************************************************************

-- Example_12:  MySQL does not implement INTERSECT to find the 2
-- students: Homer and Tess that took both IS320 and IS480. (2 rows)
-- Concept(s): Finding the intersect of two result sets using 
-- Type I subquery. Subqueries will be studied in detail next week.
SELECT StdNo, StdFirstName, StdLastName 
FROM Enrollment JOIN Student USING(StdNo)
WHERE OfferNo IN (5679) AND StdNo IN 
  (SELECT StdNo FROM Enrollment
   WHERE OfferNo IN (1234, 3333))
ORDER BY StdNo 

-- Example_12 (cont.):  MySQL does not implement EXCEPT to find
-- the 4 students: Bob, Roberto, Luke and William that took
-- IS480 (5679) but did not take IS320 (1234, 3333). (4 rows)
-- Concept(s): Finding the complement of two result sets using 
-- Type I subquery. Subqueries will be studied in detail next week.
SELECT StdNo, StdFirstName, StdLastName 
FROM Enrollment JOIN Student USING(StdNo)
WHERE OfferNo IN (5679) AND StdNo NOT IN 
  (SELECT StdNo FROM Enrollment 
   WHERE OfferNo IN (1234, 3333))
ORDER BY StdNo 

-- **********************************************************************

-- Example_13: List the students taking the 3 sections of 2  classes 
-- used in the previous exercise, as well as the faculty teaching those 
-- classes. (12 rows)
-- Concept(s): Using UNION to combine two complementary result sets
SELECT S.StdNo AS PersonNo, S.StdFirstName AS FstName, 
  S.StdLastName AS LstName, 'Student' AS Person 
FROM Enrollment E JOIN Student S USING(StdNo)
WHERE OfferNo IN (1234, 3333, 5679)
UNION
SELECT F.FacNo AS PersonNo, F.FacFirstName AS FstName, 
  F.FacLastName AS LstName, 'Faculty' AS Person
FROM Offering O JOIN Faculty F USING(FacNo)
WHERE OfferNo IN (1234, 3333, 5679)
ORDER BY Person, PersonNo

-- **********************************************************************

-- Concept(s): Writing to (rather then just reading from) database tables.
-- INSERT INTO Faculty table a made up faculty member with a name 
-- and address that is identical to the student by the same name.
-- While unlikely, faculty could be a student, the only difference
-- would be the primary key (more likely with customers and employees).
INSERT INTO Faculty (FacNo, FacFirstName, FacLastName, 
  FacCity, FacState, FacZipCode)
 VALUES('123-45-6789', 'HOMER', 'WELLS', 
 'SEATTLE', 'WA', '98121-1111')

-- UPDATE Faculty hire date, rank and department
UPDATE Faculty 
  SET FacHireDate = '2030-01-01', FacRank = 'ASST', FacDept = 'MIS'
  WHERE FacNo = '123-45-6789'
  
-- Example_14: MySQL does not implement FULL OUTER JOIN to find 
-- offerings with and without faculty assigned, as well as faculty
-- without any offerings, i.e. a union between faculty and offering.
-- List offer and course numbers as well as faculty names for all 
-- sections of all classes in the database. Include an offering even 
-- if the faculty is not yet assigned. Also include a faculty even 
-- if they do not teach any offerings. (14 rows)
-- Concept(s): Implementing full outer join by combining the left 
-- and right outer joins of two tables.
SELECT OfferNo, CourseNo, FacFirstName, FacLastName
FROM Offering LEFT OUTER JOIN Faculty
  ON Offering.FacNo = Faculty.FacNo
UNION
SELECT OfferNo, CourseNo, FacFirstName, FacLastName
FROM Offering RIGHT OUTER JOIN Faculty
  ON Offering.FacNo = Faculty.FacNo

-- Example_15: List all the student and faculty names and addresses, 
-- including duplicates (if any). (18 rows)
-- Concept(s): Using UNION ALL to combine two complementary result sets
SELECT Student.StdFirstName AS FstName, Student.StdLastName AS LstName, 
  Student.StdCity AS City, Student.StdState AS ST, Student.StdZip AS Zip
FROM Student
UNION ALL
SELECT Faculty.FacFirstName AS FstName, Faculty.FacLastName AS LstName, 
  Faculty.FacCity AS City, Faculty.FacState AS ST, Faculty.FacZipCode AS Zip
FROM Faculty
ORDER BY LstName DESC

-- DELETE the fake faculty member 
DELETE FROM Faculty WHERE FacNo = '999-99-9999'
