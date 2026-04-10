-- ============================================
-- STUDENT MANAGEMENT SYSTEM
-- SQL QUERIES
-- ============================================

USE StudentSystem;

-- ============================================
-- SELECT QUERIES (Different variations)
-- ============================================

-- Select all students
SELECT * FROM Students;

-- Select specific columns
SELECT StudentNumber, FirstName, LastName, Email FROM Students;

-- Select with WHERE condition
SELECT * FROM Students WHERE Status = 'Active';

-- Select with ORDER BY
SELECT FirstName, LastName, EnrollmentDate FROM Students ORDER BY EnrollmentDate DESC;

-- Select with LIMIT
SELECT * FROM Students LIMIT 5;

--  Select with aggregate function
SELECT COUNT(*) AS TotalStudents FROM Students;

-- ============================================
-- INSERT QUERIES (Adding new records)
-- ============================================

-- Insert a new student
INSERT INTO Students (StudentNumber, FirstName, LastName, Email, Phone, Address, BirthDate, EnrollmentDate)
VALUES ('2024-011', 'Christopher', 'Lee', 'chris.lee@email.com', '09123456789', '123 New St, Manila', '2000-09-15', CURDATE());

-- Insert a new course
INSERT INTO Courses (CourseCode, CourseName, Credits, Description)
VALUES ('CS401', 'Artificial Intelligence', 3, 'Introduction to AI and machine learning');

-- Insert a new instructor
INSERT INTO Instructors (InstructorCode, FirstName, LastName, Email, Phone, Department)
VALUES ('INST011', 'Dr. Anna', 'Sta. Ana', 'anna.staana@university.edu', '09123456789', 'Computer Science');

-- Insert a new enrollment
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Grade)
VALUES (1, 11, CURDATE(), NULL);

-- Insert multiple records at once
INSERT INTO Students (StudentNumber, FirstName, LastName, Email, Phone, BirthDate) VALUES
('2024-012', 'Diana', 'Rose', 'diana.rose@email.com', '09234567890', '2001-03-20'),
('2024-013', 'Mark', 'Tan', 'mark.tan@email.com', '09345678901', '2000-11-05');

-- ============================================
-- UPDATE QUERIES (Modifying existing records)
-- ============================================

-- Update a student's email
UPDATE Students 
SET Email = 'abby.new@email.com' 
WHERE StudentID = 1;

-- Update a student's phone number
UPDATE Students 
SET Phone = '09999999999' 
WHERE StudentNumber = '2024-002';

-- Update a course credit
UPDATE Courses 
SET Credits = 4 
WHERE CourseCode = 'CS102';

-- Update a student's grade
UPDATE Enrollments 
SET Grade = 'A' 
WHERE StudentID = 3 AND CourseID = 4;

-- Update multiple columns
UPDATE Instructors 
SET Department = 'Information Technology', Phone = '09888888888' 
WHERE InstructorCode = 'INST005';

-- Update with condition (all students enrolled before 2024-07-01)
UPDATE Students 
SET Status = 'Active' 
WHERE EnrollmentDate < '2024-07-01';

-- ============================================
-- DELETE QUERIES (Removing records)
-- ============================================

-- Delete a specific enrollment
DELETE FROM Enrollments 
WHERE StudentID = 10 AND CourseID = 9;

-- Delete a student (will cascade to enrollments)
DELETE FROM Students 
WHERE StudentID = 11;

-- Delete a course (will cascade to enrollments and courseinstructors)
DELETE FROM Courses 
WHERE CourseID = 11;

--Delete with condition
DELETE FROM CourseInstructors 
WHERE Semester = '2nd Semester' AND SchoolYear = '2024-2025';

-- Delete all records from a table (be careful!)
-- DELETE FROM Enrollments WHERE EnrollmentID > 30;

-- ============================================
-- JOIN QUERIES (Combining multiple tables)
-- ============================================

-- INNER JOIN: Get students with their courses and grades
SELECT 
    s.StudentNumber,
    s.FirstName,
    s.LastName,
    c.CourseCode,
    c.CourseName,
    e.Grade
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID
ORDER BY s.LastName;

-- LEFT JOIN: All students even those without enrollments
SELECT 
    s.FirstName,
    s.LastName,
    COUNT(e.CourseID) AS NumberOfCourses
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID;

-- JOIN with multiple tables: Students, Enrollments, Courses, Instructors
SELECT 
    s.FirstName AS StudentFirstName,
    s.LastName AS StudentLastName,
    c.CourseCode,
    c.CourseName,
    i.FirstName AS InstructorFirstName,
    i.LastName AS InstructorLastName,
    e.Grade
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
JOIN CourseInstructors ci ON c.CourseID = ci.CourseID
JOIN Instructors i ON ci.InstructorID = i.InstructorID
WHERE ci.Semester = '1st Semester'
LIMIT 10;

-- JOIN with aggregation: Course enrollment statistics
SELECT 
    c.CourseCode,
    c.CourseName,
    COUNT(e.StudentID) AS EnrolledStudents,
    COUNT(DISTINCT ci.InstructorID) AS NumberOfInstructors
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
LEFT JOIN CourseInstructors ci ON c.CourseID = ci.CourseID
GROUP BY c.CourseID;

-- Self JOIN example (if applicable - students with same birth month)
SELECT 
    a.FirstName AS Student1,
    b.FirstName AS Student2,
    MONTH(a.BirthDate) AS BirthMonth
FROM Students a
JOIN Students b ON MONTH(a.BirthDate) = MONTH(b.BirthDate) AND a.StudentID < b.StudentID
ORDER BY BirthMonth;

-- ============================================
-- SUBQUERY QUERIES (Nested queries)
-- ============================================

-- Subquery in WHERE: Students enrolled in more than average courses
SELECT 
    s.FirstName,
    s.LastName,
    COUNT(e.CourseID) AS TotalCourses
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID
HAVING COUNT(e.CourseID) > (
    SELECT AVG(course_count) 
    FROM (
        SELECT COUNT(*) AS course_count 
        FROM Enrollments 
        GROUP BY StudentID
    ) AS avg_courses
);

-- Subquery with IN: Students enrolled in CS101
SELECT FirstName, LastName, Email
FROM Students
WHERE StudentID IN (
    SELECT StudentID 
    FROM Enrollments 
    WHERE CourseID = (
        SELECT CourseID 
        FROM Courses 
        WHERE CourseCode = 'CS101'
    )
);

-- Subquery with EXISTS: Courses that have at least one enrollment
SELECT CourseCode, CourseName
FROM Courses c
WHERE EXISTS (
    SELECT 1 
    FROM Enrollments e 
    WHERE e.CourseID = c.CourseID
);

-- Subquery in SELECT: Get student count per course
SELECT 
    c.CourseCode,
    c.CourseName,
    (SELECT COUNT(*) 
     FROM Enrollments e 
     WHERE e.CourseID = c.CourseID) AS EnrolledCount
FROM Courses c;

-- Subquery with ANY: Students who got grades higher than any student in CS101
SELECT DISTINCT s.FirstName, s.LastName, e.Grade
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.GradePoints > ANY (
    SELECT GradePoints 
    FROM Enrollments 
    WHERE CourseID = (SELECT CourseID FROM Courses WHERE CourseCode = 'CS101')
    AND GradePoints IS NOT NULL
);

-- Subquery with NOT EXISTS: Courses with no enrollments
SELECT CourseCode, CourseName
FROM Courses c
WHERE NOT EXISTS (
    SELECT 1 
    FROM Enrollments e 
    WHERE e.CourseID = c.CourseID
);

-- Nested subquery: Students with highest number of courses
SELECT FirstName, LastName, (
    SELECT COUNT(*) 
    FROM Enrollments e 
    WHERE e.StudentID = s.StudentID
) AS CourseCount
FROM Students s
WHERE (
    SELECT COUNT(*) 
    FROM Enrollments e 
    WHERE e.StudentID = s.StudentID
) = (
    SELECT MAX(course_count)
    FROM (
        SELECT COUNT(*) AS course_count
        FROM Enrollments
        GROUP BY StudentID
    ) AS counts
);

-- ============================================
-- COMPLEX QUERIES (Combining multiple concepts)
-- ============================================

-- Get all students with their grades summary
SELECT 
    s.StudentNumber,
    s.FirstName,
    s.LastName,
    COUNT(e.CourseID) AS TotalEnrolled,
    ROUND(AVG(CASE 
        WHEN e.Grade = 'A' THEN 4.0
        WHEN e.Grade = 'A-' THEN 3.7
        WHEN e.Grade = 'B+' THEN 3.3
        WHEN e.Grade = 'B' THEN 3.0
        WHEN e.Grade = 'B-' THEN 2.7
        WHEN e.Grade = 'C+' THEN 2.3
        WHEN e.Grade = 'C' THEN 2.0
        ELSE NULL
    END), 2) AS GPA
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID
ORDER BY GPA DESC;

-- Instructor workload summary
SELECT 
    i.InstructorCode,
    i.FirstName,
    i.LastName,
    COUNT(DISTINCT ci.CourseID) AS CoursesTaught,
    COUNT(DISTINCT e.StudentID) AS TotalStudents
FROM Instructors i
LEFT JOIN CourseInstructors ci ON i.InstructorID = ci.InstructorID
LEFT JOIN Courses c ON ci.CourseID = c.CourseID
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY i.InstructorID
ORDER BY CoursesTaught DESC;

-- ============================================
-- VERIFICATION QUERIES (Check your data)
-- ============================================

-- Check all tables record count
SELECT 'Students' AS TableName, COUNT(*) AS Count FROM Students
UNION ALL
SELECT 'Courses', COUNT(*) FROM Courses
UNION ALL
SELECT 'Instructors', COUNT(*) FROM Instructors
UNION ALL
SELECT 'Enrollments', COUNT(*) FROM Enrollments
UNION ALL
SELECT 'CourseInstructors', COUNT(*) FROM CourseInstructors;

-- Show sample of each join type
SELECT 'INNER JOIN Example' AS QueryType;
SELECT s.FirstName, c.CourseCode, e.Grade
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID
LIMIT 5;

-- ============================================
-- END OF QUERIES
-- ============================================