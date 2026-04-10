-- ============================================
-- STUDENT MANAGEMENT SYSTEM
-- Sample Data
-- ============================================

USE StudentSystem;

-- ============================================
-- INSERT STUDENTS (10 records)
-- ============================================

INSERT INTO Students (StudentNumber, FirstName, LastName, Email, Phone, Address, BirthDate, EnrollmentDate) VALUES
('2024-001', 'Abby', 'Llaguno', 'abby.llaguno@email.com', '09123456789', '123 Main St, Manila', '2000-05-15', '2024-06-01'),
('2024-002', 'Anna', 'Juarez', 'anna.juarez@email.com', '09234567890', '456 Oak Ave, Quezon City', '2001-08-22', '2024-06-01'),
('2024-003', 'Eun', 'Lozano', 'eun.lozano@email.com', '09345678901', '789 Pine Rd, Makati', '1999-11-10', '2024-06-01'),
('2024-004', 'Donz', 'Rico', 'donz.rico@email.com', '09456789012', '321 Elm St, Pasig', '2000-03-03', '2024-06-15'),
('2024-005', 'San', 'Murillo', 'san.murillo@email.com', '09567890123', '654 Maple Dr, Taguig', '2001-07-19', '2024-06-15'),
('2024-006', 'Fran', 'Batalla', 'fran.batalla@email.com', '09678901234', '987 Cedar Ln, Mandaluyong', '2000-12-25', '2024-07-01'),
('2024-007', 'Franx', 'Nicol', 'franx.nicol@email.com', '09789012345', '147 Birch St, Pasay', '1999-09-08', '2024-07-01'),
('2024-008', 'Mari', 'Zuniega', 'mari.zuniega@email.com', '09890123456', '258 Spruce Ave, Paranaque', '2001-01-14', '2024-07-15'),
('2024-009', 'Arle', 'Cornal', 'arle.cornal@email.com', '09901234567', '369 Willow Rd, Las Pinas', '2000-06-30', '2024-07-15'),
('2024-010', 'Mat', 'Nami', 'mat.nami@email.com', '09012345678', '741 Ash Ct, Muntinlupa', '2001-04-17', '2024-08-01');

-- ============================================
--  INSERT COURSES (10 records)
-- ============================================

INSERT INTO Courses (CourseCode, CourseName, Credits, Description) VALUES
('CS101', 'Introduction to Programming', 3, 'Basic programming concepts using Python'),
('CS102', 'Web Development', 3, 'HTML, CSS, and JavaScript fundamentals'),
('CS201', 'Data Structures', 3, 'Arrays, linked lists, trees, and graphs'),
('CS202', 'Database Management', 3, 'SQL, database design, and normalization'),
('CS301', 'Software Engineering', 3, 'Software development lifecycle and methodologies'),
('MATH101', 'College Algebra', 3, 'Algebraic equations, functions, and graphs'),
('MATH201', 'Calculus I', 4, 'Limits, derivatives, and integrals'),
('ENGL101', 'English Composition', 3, 'Academic writing and research skills'),
('PHYS101', 'Physics I', 4, 'Mechanics, motion, and energy'),
('BUS101', 'Business Fundamentals', 3, 'Introduction to business and management');

-- ============================================
-- INSERT INSTRUCTORS (10 records)
-- ============================================

INSERT INTO Instructors (InstructorCode, FirstName, LastName, Email, Phone, Department) VALUES
('INST001', 'Dr. Robert', 'Anderson', 'r.anderson@university.edu', '09111111111', 'Computer Science'),
('INST002', 'Prof. Maria', 'Garcia', 'm.garcia@university.edu', '09222222222', 'Mathematics'),
('INST003', 'Dr. James', 'Martinez', 'j.martinez@university.edu', '09333333333', 'Physics'),
('INST004', 'Prof. Lisa', 'Santos', 'l.santos@university.edu', '09444444444', 'English'),
('INST005', 'Dr. William', 'Gutierrez', 'w.gutierrez@university.edu', '09555555555', 'Computer Science'),
('INST006', 'Prof. Jennifer', 'Wilson', 'j.wilson@university.edu', '09666666666', 'Business'),
('INST007', 'Dr. Charles', 'Davis', 'c.davis@university.edu', '09777777777', 'Mathematics'),
('INST008', 'Prof. Susan', 'Miller', 's.miller@university.edu', '09888888888', 'Physics'),
('INST009', 'Dr. Jerry', 'Nicoleta', 'j.nicoleta@university.edu', '09999999999', 'Computer Science'),
('INST010', 'Prof. Karen', 'White', 'k.white@university.edu', '09000000000', 'English');

-- ============================================
-- INSERT ENROLLMENTS (at least 10 records)
-- ============================================

INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Grade) VALUES
-- Student 1 (John Smith)
(1, 1, '2024-06-01', 'A'),
(1, 2, '2024-06-01', 'B+'),
(1, 5, '2024-06-01', 'A-'),

-- Student 2 (Emma Johnson)
(2, 1, '2024-06-01', 'B'),
(2, 3, '2024-06-01', 'A'),
(2, 8, '2024-06-01', 'B+'),

-- Student 3 (Michael Brown)
(3, 3, '2024-06-15', NULL),
(3, 4, '2024-06-15', 'B'),
(3, 7, '2024-06-15', NULL),

-- Student 4 (Sarah Davis)
(4, 2, '2024-06-15', 'A-'),
(4, 4, '2024-06-15', 'A'),
(4, 9, '2024-06-15', 'B+'),

-- Student 5 (David Wilson)
(5, 5, '2024-07-01', 'B'),
(5, 6, '2024-07-01', 'A'),

-- Student 6 (Lisa Garcia)
(6, 1, '2024-07-01', 'B+'),
(6, 7, '2024-07-01', NULL),
(6, 10, '2024-07-01', 'A'),

-- Student 7 (James Martinez)
(7, 2, '2024-07-15', 'A'),
(7, 4, '2024-07-15', 'A-'),
(7, 8, '2024-07-15', 'B'),

-- Student 8 (Maria Rodriguez)
(8, 3, '2024-07-15', 'B+'),
(8, 6, '2024-07-15', 'A-'),
(8, 9, '2024-07-15', 'B'),

-- Student 9 (Robert Lee)
(9, 5, '2024-08-01', NULL),
(9, 10, '2024-08-01', 'B+'),

-- Student 10 (Patricia Taylor)
(10, 1, '2024-08-01', 'A'),
(10, 8, '2024-08-01', 'A-'),
(10, 9, '2024-08-01', NULL);

-- ============================================
-- INSERT COURSE INSTRUCTORS (at least 10 records)
-- ============================================

INSERT INTO CourseInstructors (CourseID, InstructorID, Semester, SchoolYear) VALUES
-- CS101 (Programming)
(1, 1, '1st Semester', '2024-2025'),
(1, 5, '2nd Semester', '2024-2025'),

-- CS102 (Web Development)
(2, 1, '1st Semester', '2024-2025'),
(2, 9, '2nd Semester', '2024-2025'),

-- CS201 (Data Structures)
(3, 5, '1st Semester', '2024-2025'),
(3, 9, '2nd Semester', '2024-2025'),

-- CS202 (Database Management)
(4, 1, '1st Semester', '2024-2025'),

-- CS301 (Software Engineering)
(5, 9, '1st Semester', '2024-2025'),

-- MATH101 (Algebra)
(6, 2, '1st Semester', '2024-2025'),
(6, 7, '2nd Semester', '2024-2025'),

-- MATH201 (Calculus)
(7, 2, '1st Semester', '2024-2025'),
(7, 7, '1st Semester', '2024-2025'),

-- ENGL101 (English)
(8, 4, '1st Semester', '2024-2025'),
(8, 10, '2nd Semester', '2024-2025'),

-- PHYS101 (Physics)
(9, 3, '1st Semester', '2024-2025'),
(9, 8, '2nd Semester', '2024-2025'),

-- BUS101 (Business)
(10, 6, '1st Semester', '2024-2025');

-- ============================================
-- VERIFICATION QUERIES (Run these to check)
-- ============================================

-- Check counts
SELECT 'Students' AS TableName, COUNT(*) AS RecordCount FROM Students
UNION ALL
SELECT 'Courses', COUNT(*) FROM Courses
UNION ALL
SELECT 'Instructors', COUNT(*) FROM Instructors
UNION ALL
SELECT 'Enrollments', COUNT(*) FROM Enrollments
UNION ALL
SELECT 'CourseInstructors', COUNT(*) FROM CourseInstructors;

-- Sample verification
SELECT * FROM Students LIMIT 5;
SELECT * FROM Courses LIMIT 5;
SELECT * FROM Instructors LIMIT 5;