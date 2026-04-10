-- ============================================
-- STUDENT MANAGEMENT SYSTEM
-- Database Schema
-- ============================================

-- Create and use database
CREATE DATABASE StudentSystem;
USE StudentSystem;

-- ============================================
-- Create Tables
-- ============================================

-- Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentNumber VARCHAR(20) UNIQUE NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    Address TEXT,
    BirthDate DATE,
    EnrollmentDate DATE DEFAULT CURRENT_DATE
);

-- Courses table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseCode VARCHAR(20) UNIQUE NOT NULL,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT DEFAULT 3,
    Description TEXT
);

-- Enrollments table (links Students and Courses)
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE DEFAULT CURRENT_DATE,
    Grade VARCHAR(2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Instructors table
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY AUTO_INCREMENT,
    InstructorCode VARCHAR(20) UNIQUE NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    Department VARCHAR(100)
);

-- Course Instructors (which instructor teaches which course)
CREATE TABLE CourseInstructors (
    CourseInstructorID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT NOT NULL,
    InstructorID INT NOT NULL,
    Semester VARCHAR(20),
    SchoolYear VARCHAR(20),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);

-- ============================================
-- Create Indexes for Performance
-- ============================================

CREATE INDEX idx_student_lastname ON Students(LastName);
CREATE INDEX idx_student_number ON Students(StudentNumber);
CREATE INDEX idx_course_code ON Courses(CourseCode);
CREATE INDEX idx_enrollment_student ON Enrollments(StudentID);
CREATE INDEX idx_enrollment_course ON Enrollments(CourseID);

-- ============================================
-- Create Views
-- ============================================

-- View: Student enrollment summary
CREATE VIEW StudentEnrollmentSummary AS
SELECT 
    s.StudentNumber,
    CONCAT(s.FirstName, ' ', s.LastName) AS FullName,
    s.Email,
    COUNT(e.CourseID) AS TotalCourses
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID;

-- View: Course enrollment count
CREATE VIEW CourseEnrollmentCount AS
SELECT 
    c.CourseCode,
    c.CourseName,
    COUNT(e.StudentID) AS EnrolledStudents
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseID;

-- ============================================
-- End of Schema
-- ============================================