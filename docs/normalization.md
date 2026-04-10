-- ============================================
-- STUDENT MANAGEMENT SYSTEM
-- Normalization
-- ============================================

### Original Raw Data (UNF - Unnormalized Form)

A single table with repeating groups:

| StudentID | StudentName | Email          | CourseCode   | CourseName           | Grade |
|-----------|-------------|----------------|--------------|----------------------|-------|
| S001      | Abby Llaguno| abby@email.com | CS101, CS102 | Programming, Database| A, B+ |
| S002      | Anna Juarez | anna@email.com | CS101        | Programming          | A-    |
| S003      | Eun Lozano  | eun@email.com  | CS102, CS103 | Database, Networking | B+, A |

**Problems in UNF:**
- Multiple values in one cell (CS101, CS102)
- Repeating groups
- Difficult to query, update, or delete
- Data redundancy

## Convert UNF → 1NF

**Rule:** Eliminate repeating groups. Each cell contains a single value.

### 1NF Table:

| StudentID | StudentName | Email         | CourseCode | CourseName | Grade |
|-----------|-------------|---------------|------------|------------|-------|
| S001      | Abby Llaguno| abby@email.com| CS101      | Programming| A     |
| S001      | Abby Llaguno| abby@email.com| CS102      | Database   | B+    |
| S002      | Anna Juarez | anna@email.com| CS101      | Programming| A-    |
| S003      | Eun Lozano  | eun@email.com | CS102      | Database   | B+    |
| S003      | Eun Lozano  | eun@email.com | CS103      | Networking | A     |

**Still has problems:**
- Partial dependency (StudentName depends on StudentID, not on full key)
- Data redundancy (StudentName, Email repeated)
- Update anomaly (changing a student's name requires multiple updates)


## Convert 1NF → 2NF

**Rule:** Remove partial dependencies. All non-key attributes must depend on the ENTIRE primary key.

### Create separate tables:

**Table 1: Students** (depends on StudentID)

| StudentID | StudentName | Email          |
|-----------|-------------|----------------|
| S001      | Abby Llaguno| abby@email.com |
| S002      | Anna Juarez | anna@email.com |
| S003      | Eun Lozano  | eun@email.com  |

**Table 2: Courses** (depends on CourseCode)

| CourseCode | CourseName |
|------------|------------|
| CS101      | Programming|
| CS102      | Database   |
| CS103      | Networking |

**Table 3: Enrollments** (links StudentID and CourseCode)

| StudentID | CourseCode | Grade |
|-----------|------------|-------|
| S001      |CS101       | A     |
| S001      | CS102      | B+    |
| S002      | CS101      | A-    |
| S003      | CS102      | B+    |
| S003      | CS103      | A     |

**2NF achieved!** Partial dependencies removed.


## Convert 2NF → 3NF

**Rule:** Remove transitive dependencies. Non-key attributes cannot depend on other non-key attributes.

### Check each table:

**Students Table** - No transitive dependency ✓

**Courses Table** - No transitive dependency ✓

**Enrollments Table** - No transitive dependency ✓

### No changes needed! The design is already in 3NF.


## Final 3NF Schema Summary

| Table           | Primary Key             | Foreign Key           | Attributes         |
|-----------------|-------------------------|-----------------------|--------------------|
| **Students**    | StudentID               | -                     | StudentName, Email |
| **Courses**     | CourseCode              | -                     | CourseName         |
| **Enrollments** | (StudentID, CourseCode) | StudentID, CourseCode | Grade              |

---

## Benefits of Normalization

| Before (UNF)           | After (3NF)        |
|------------------------|--------------------|
| Data redundancy        | Minimal redundancy |
| Update anomalies       | Clean updates      |
| Insert/Delete problems | Easy maintenance   |
| Difficult queries      | Simple JOIN queries|

---

## ER Relationship (3NF)