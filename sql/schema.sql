-- =============================================
-- STUDENT MANAGEMENT SYSTEM 
-- =============================================

-- CREATE DATABASE
CREATE DATABASE IF NOT EXISTS StudentSystem;
USE StudentSystem;

-- STUDENTS TABLE
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    EnrollmentDate DATE DEFAULT CURRENT_DATE,
    Status ENUM('Active', 'Graduated', 'Suspended') DEFAULT 'Active'
);

-- COURSES TABLE
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseCode VARCHAR(20) UNIQUE NOT NULL,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT CHECK (Credits BETWEEN 1 AND 6)
);

-- ENROLLMENTS TABLE (Connects Students and Courses)
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE DEFAULT CURRENT_DATE,
    Grade CHAR(2) DEFAULT NULL,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE,
    UNIQUE KEY unique_enrollment (StudentID, CourseID)
);

-- Insert 3 Students
INSERT INTO Students (FirstName, LastName, Email, Phone, EnrollmentDate, Status) VALUES
('Abby', 'Llaguno', 'abby.llaguno@email.com', '09123456789', '2025-06-01', 'Active'),
('Anna', 'Juarez', 'anna.juarez@email.com', '09987654321', '2025-06-01', 'Active'),
('Eun', 'Lozano', 'eun.lozano@email.com', '09777778888', '2025-06-15', 'Active');

-- Insert 4 Courses
INSERT INTO Courses (CourseCode, CourseName, Credits) VALUES
('CS101', 'Introduction to Programming', 3),
('CS201', 'Data Structures', 3),
('IT105', 'Information Management', 3),
('IT103', 'Introduction to IT', 3);

-- Insert Enrollments (each student takes 2-3 courses)
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Grade) VALUES
-- Abby's enrollments
(1, 1, '2024-06-01', 'A'),
(1, 2, '2024-06-01', 'B+'),
(1, 3, '2024-06-01', 'A-'),

-- Anna's enrollments
(2, 1, '2024-06-01', 'B'),
(2, 3, '2024-06-01', 'A'),
(2, 4, '2024-06-01', 'B+'),

-- Eun's enrollments
(3, 2, '2024-06-15', NULL),  -- NULL means grade not yet available
(3, 4, '2024-06-15', NULL);

-- View: Student Enrollment Summary
CREATE VIEW StudentSummary AS
SELECT 
    s.StudentID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    COUNT(e.CourseID) AS NumberOfCourses,
    AVG(CASE 
        WHEN e.Grade = 'A' THEN 4.0
        WHEN e.Grade = 'A-' THEN 3.7
        WHEN e.Grade = 'B+' THEN 3.3
        WHEN e.Grade = 'B' THEN 3.0
        ELSE NULL
    END) AS AverageGrade
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID;

-- View: Course Enrollment Count
CREATE VIEW CourseSummary AS
SELECT 
    c.CourseCode,
    c.CourseName,
    COUNT(e.StudentID) AS EnrolledStudents
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseID;

-- List all students and their courses
SELECT 
    CONCAT(s.FirstName, ' ', s.LastName) AS Student,
    c.CourseCode,
    c.CourseName,
    IFNULL(e.Grade, 'Not yet graded') AS Grade
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
ORDER BY s.StudentID;

-- Get student's average grade (for Abby Llaguno - ID 1)
SELECT 
    CONCAT(FirstName, ' ', LastName) AS StudentName,
    ROUND(AVG(CASE 
        WHEN Grade = 'A' THEN 4.0
        WHEN Grade = 'A-' THEN 3.7
        WHEN Grade = 'B+' THEN 3.3
        WHEN Grade = 'B' THEN 3.0
        ELSE 0
    END), 2) AS GPA
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE s.StudentID = 1;

-- Find all active students
SELECT StudentID, FirstName, LastName, Email, Phone
FROM Students
WHERE Status = 'Active';