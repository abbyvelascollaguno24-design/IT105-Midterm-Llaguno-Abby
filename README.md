-- ============================================
-- STUDENT MANAGEMENT SYSTEM
-- README | Reflection
-- ============================================

## Project Title
**Student Management System Database** - A comprehensive MySQL database solution for managing students, courses, instructors, and enrollments.

## System Description
The **Student Management System** is a relational database designed to efficiently manage educational institution data. It tracks student information, course offerings, instructor assignments, and student enrollments with grades. This system eliminates data redundancy, ensures data integrity, and provides fast query performance through proper normalization and indexing.

### Purpose
- Streamline student enrollment processes
- Track academic performance and grades
- Manage course-instructor assignments
- Generate reports on student progress
- Maintain historical enrollment records

### Target Users
- School Administrators
- Faculty Members
- Students
- Academic Advisors

---

## Tables Description
The database consists of 5 main tables in 3NF (Third Normal Form):

### 1. **Students** 
Stores personal and contact information of all students.

| Column         | Type               | Description                        |
|----------------|--------------------|------------------------------------|
| StudentID      | INT PRIMARY KEY    | Unique identifier (auto-increment) |
| StudentNumber  | VARCHAR(20) UNIQUE | Student ID number                  |
| FirstName      | VARCHAR(50)        | Student's first name               |
| LastName       | VARCHAR(50)        | Student's last name                |
| Email          | VARCHAR(100) UNIQUE| Email address                      |
| Phone          | VARCHAR(20)        | Contact number                     |
| Address        | TEXT               | Home address                       |
| BirthDate      | DATE               | Date of birth                      |
| EnrollmentDate | DATE               | When student enrolled              |
| Status         | ENUM               | Active/Graduated/Suspended         |

### 2. **Courses**
Contains all course offerings and their details.

| Column     | Type              | Description               |
|------------|-------------------|---------------------------|
| CourseID   | INT PRIMARY KEY   | Unique identifier         |
| CourseCode | VARCHAR(20) UNIQUE| Subject code (e.g., CS101)|
| CourseName | VARCHAR(100)      | Full course name          |
| Credits    | INT               | Credit units (1-6)        |
| Description| TEXT              | Course overview           |

### 3. **Instructors**
Stores faculty/instructor information.

| Column         | Type               | Description        |
|----------------|--------------------|--------------------|
| InstructorID   | INT PRIMARY KEY    | Unique identifier  |
| InstructorCode | VARCHAR(20) UNIQUE | Faculty ID         |
| FirstName      | VARCHAR(50)        | First name         |
| LastName       | VARCHAR(50)        | Last name          |
| Email          | VARCHAR(100) UNIQUE| University email   |
| Phone          | VARCHAR(20)        | Contact number     |
| Department     | VARCHAR(100)       | Academic department|

### 4. **Enrollments**
Junction table linking students to courses (many-to-many).

| Column         | Type            | Description               |
|----------------|-----------------|---------------------------|
| EnrollmentID   | INT PRIMARY KEY | Unique identifier         |
| StudentID      | INT FOREIGN KEY | References Students       |
| CourseID       | INT FOREIGN KEY | References Courses        |
| EnrollmentDate | DATE            | When student enrolled     |
| Grade          | VARCHAR(2)      | Final grade (A, B+, etc.) |

### 5. **CourseInstructors**
Links courses to instructors (many-to-many relationship).

| Column             | Type            | Description            |
|--------------------|-----------------|------------------------|
| CourseInstructorID | INT PRIMARY KEY | Unique identifier      |
| CourseID           | INT FOREIGN KEY | References Courses     |
| InstructorID       | INT FOREIGN KEY | References Instructors |
| Semester           | VARCHAR(20)     | 1st/2nd Semester       |
| SchoolYear         | VARCHAR(20)     | Academic year          |

---

## Features Implemented

### ✅ Database Design
- **3NF Normalization** - Eliminates data redundancy and anomalies
- **Referential Integrity** - Foreign keys with CASCADE DELETE
- **Data Validation** - CHECK constraints and ENUM types
- **Unique Constraints** - Prevents duplicate emails and IDs

### ✅ SQL Operations
| Operation    | Examples Implemented                                          |
|--------------|---------------------------------------------------------------|
| **SELECT**   | Basic queries, WHERE conditions, ORDER BY, LIMIT, aggregation |
| **INSERT**   | Single and multiple record insertion                          |
| **UPDATE**   | Modifying student info, grades, and course details            |
| **DELETE**   | Removing enrollments, students, and courses                   |  
| **JOIN**     | INNER JOIN, LEFT JOIN, multiple table joins                   |
| **SUBQUERY** | Nested queries with IN, EXISTS, ANY, and correlated subqueries|

### ✅ Performance Optimization
- **Indexes** on frequently searched columns (LastName, StudentNumber, CourseCode)
- **Foreign key indexes** for faster JOIN operations
- **B-Tree indexing** for O(log n) search complexity

### ✅ Views for Reporting
- `StudentEnrollmentSummary` - Shows total courses per student
- `CourseEnrollmentCount` - Displays enrollment numbers per course

### ✅ Sample Data
- 10+ students with realistic information
- 10+ courses across different departments
- 10+ instructors from various fields
- 20+ enrollment records with grades
- 10+ course-instructor assignments

---

## Technologies Used

| Technolog      | Purpose                             |
|----------------|-------------------------------------|
| **MySQL**      | Database management system          |
| **phpMyAdmin** | Database administration and testing |
| **Git**        | Version control                     |
| **GitHub**     | Remote repository hosting           |
| **VS Code**    | Code editor                         |

---

## Reflection (What I Learned)
Through this project, I learned how proper database normalization (UNF to 3NF) eliminates data redundancy and prevents update anomalies. I discovered that creating indexes on frequently searched columns dramatically improves query performance, making searches up to 7x faster by using B-Tree structure instead of full table scans. I also gained practical experience with SQL operations including SELECT, INSERT, UPDATE, DELETE, JOINs, and subqueries. Additionally, I learned to troubleshoot Git errors like remote URL typos and branch management between main and master. Overall, this project taught me that good database design is essential for building efficient and scalable systems.
