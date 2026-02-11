# dbApps08 Study Guide: Building & Managing Data

**Course:** Database Applications Development (145085)
**Instructor:** Ryan McMaster | Medina County Career Center

---

## Vocabulary

| Term | Definition |
|------|-----------|
| **CREATE TABLE** | SQL command to define a new table with columns and data types |
| **DROP TABLE** | SQL command to delete an entire table (permanent) |
| **INSERT INTO** | SQL command to add a new row of data to a table |
| **VALUES** | Clause in INSERT that specifies the data for each column |
| **UPDATE** | SQL command to change existing data in a table |
| **SET** | Clause in UPDATE that specifies which columns to change |
| **DELETE FROM** | SQL command to remove rows from a table |
| **WHERE clause** | Condition that specifies which rows to affect in UPDATE, DELETE, or SELECT |
| **Data type** | Specification of what kind of data a column stores (INTEGER, TEXT, REAL, etc.) |
| **INTEGER** | SQLite data type for whole numbers |
| **TEXT** | SQLite data type for strings and text |
| **REAL** | SQLite data type for floating-point numbers (decimals) |
| **BLOB** | SQLite data type for binary large objects (images, files) |
| **NULL** | SQLite data type for missing or unknown values |
| **Constraint** | A rule enforced at the database level to maintain data integrity |
| **NOT NULL** | Constraint that requires a column to always have a value |
| **UNIQUE** | Constraint that prevents duplicate values in a column |
| **DEFAULT** | Constraint that provides an automatic value if none is specified |
| **CHECK** | Constraint that validates column values against a condition |
| **PRIMARY KEY** | Constraint that uniquely identifies each row (NOT NULL + UNIQUE) |
| **FOREIGN KEY** | Constraint that links to a PRIMARY KEY in another table |
| **REFERENCES** | Keyword used in FOREIGN KEY to specify the linked table and column |
| **Data integrity** | The accuracy, consistency, and reliability of data in a database |
| **Referential integrity** | The rule that FOREIGN KEY values must exist in the referenced table |
| **Test-first approach** | Best practice: test your WHERE clause with SELECT before running UPDATE/DELETE |

---

## SQLite Data Types Quick Reference

| Type | Purpose | Examples |
|------|---------|----------|
| **INTEGER** | Whole numbers | 42, -100, 2024 |
| **TEXT** | Strings and text | 'Alice', 'New York', 'alice@example.com' |
| **REAL** | Decimals and floats | 3.14, 99.99, 0.5 |
| **BLOB** | Binary data | Image files, PDF files, encrypted data |
| **NULL** | Missing/unknown | Not provided, unknown value |

**Note:** SQLite is flexible and will try to convert types, but it's best practice to match your data to the correct type.

---

## SQL Syntax Quick Reference

### CREATE TABLE
```sql
CREATE TABLE table_name (
  column_name  DATA_TYPE  [constraints],
  column_name  DATA_TYPE  [constraints]
);
```

**Example:**
```sql
CREATE TABLE students (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  gpa REAL,
  enrollment_date TEXT DEFAULT CURRENT_DATE
);
```

### INSERT INTO
```sql
INSERT INTO table_name (column1, column2, column3)
VALUES (value1, value2, value3);
```

**Example:**
```sql
INSERT INTO students (id, name, gpa)
VALUES (1, 'Alice Smith', 3.85);

INSERT INTO students (id, name)
VALUES (2, 'Bob Johnson');  -- gpa will be NULL
```

### UPDATE
```sql
UPDATE table_name
SET column1 = value1, column2 = value2
WHERE condition;
```

**Example:**
```sql
UPDATE students
SET gpa = 3.90
WHERE name = 'Alice Smith';
```

**DANGER — Missing WHERE (affects ALL rows):**
```sql
-- WRONG: Updates every student's GPA!
UPDATE students SET gpa = 4.0;
```

### DELETE
```sql
DELETE FROM table_name
WHERE condition;
```

**Example:**
```sql
DELETE FROM students
WHERE id = 5;
```

**DANGER — Missing WHERE (deletes ALL rows):**
```sql
-- WRONG: Deletes all students!
DELETE FROM students;
```

---

## Constraints Reference

### NOT NULL
**Purpose:** Ensures a column must always have a value

```sql
CREATE TABLE employees (
  id INTEGER NOT NULL,
  name TEXT NOT NULL,
  email TEXT
);
```

**What it prevents:** Inserting a row without a name or id

---

### UNIQUE
**Purpose:** Prevents duplicate values in a column

```sql
CREATE TABLE users (
  id INTEGER,
  email TEXT UNIQUE
);
```

**What it prevents:** Two users with the same email address

---

### DEFAULT
**Purpose:** Provides an automatic value if none is given

```sql
CREATE TABLE posts (
  id INTEGER,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  status TEXT DEFAULT 'draft'
);
```

**Example:**
```sql
INSERT INTO posts (id) VALUES (1);
-- created_at is automatically set to current timestamp
-- status is automatically set to 'draft'
```

---

### CHECK
**Purpose:** Validates that values meet a condition

```sql
CREATE TABLE products (
  id INTEGER,
  name TEXT,
  price REAL CHECK (price > 0)
);
```

**What it prevents:** Inserting a product with price = 0 or negative price

**Other CHECK examples:**
```sql
CREATE TABLE employees (
  age INTEGER CHECK (age >= 18),
  salary REAL CHECK (salary > 0)
);
```

---

### PRIMARY KEY
**Purpose:** Uniquely identifies each row (NOT NULL + UNIQUE combined)

```sql
CREATE TABLE courses (
  course_id INTEGER PRIMARY KEY,
  title TEXT NOT NULL
);
```

**What it prevents:** Two courses with the same course_id, or a NULL course_id

---

### FOREIGN KEY
**Purpose:** Links to a PRIMARY KEY in another table (referential integrity)

```sql
CREATE TABLE students (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE enrollments (
  id INTEGER PRIMARY KEY,
  student_id INTEGER REFERENCES students(id),
  course_id INTEGER REFERENCES courses(course_id)
);
```

**What it prevents:** Creating an enrollment for a non-existent student_id

---

## Safety Rules: The Test-First Approach

### For UPDATE Statements

**Step 1: Write your WHERE clause**
```sql
WHERE gpa < 2.0
```

**Step 2: Test it with SELECT first**
```sql
SELECT * FROM students WHERE gpa < 2.0;
```

Look at the results. Are these the rows you want to change? If yes, continue.

**Step 3: Copy the WHERE into UPDATE**
```sql
UPDATE students
SET status = 'probation'
WHERE gpa < 2.0;
```

---

### For DELETE Statements

**Step 1: Write your WHERE clause**
```sql
WHERE enrollment_year < 2020
```

**Step 2: Test it with SELECT first**
```sql
SELECT * FROM students WHERE enrollment_year < 2020;
```

Look at the results. Are these the rows you want to delete? If yes, continue.

**Step 3: Run DELETE with the same WHERE**
```sql
DELETE FROM students
WHERE enrollment_year < 2020;
```

---

## Why Constraints Matter

### The Problem: Garbage In, Garbage Out (GIGO)
Without constraints:
- Anyone can insert incomplete data (missing names, dates, etc.)
- Duplicate records can be created
- Invalid values can be stored (negative prices, impossible ages)
- Orphaned records can exist (enrollments for students who don't exist)

### The Solution: Constraints Enforce Rules at the Database Level
- NOT NULL: Prevents incomplete records
- UNIQUE: Prevents duplicates
- CHECK: Prevents invalid values
- FOREIGN KEY: Prevents orphaned records
- DEFAULT: Ensures sensible defaults

**Result:** Trustworthy, consistent, reliable data.

---

## ODE Competencies Covered

| Competency | Description |
|------------|-------------|
| **Data Definition** | Creating tables with appropriate data types and constraints |
| **Data Manipulation** | Using INSERT, UPDATE, DELETE to manage records |
| **Data Integrity** | Understanding constraints and why they protect database quality |
| **Database Design Principles** | Planning table structure before adding data |
| **Query Safety** | Testing WHERE clauses before running destructive operations |
| **SQL Syntax** | Writing correct CREATE TABLE, INSERT, UPDATE, DELETE statements |

---

## Next Steps

- **Sub-Lesson 08d:** DIY Task + Gimkit (test your knowledge)
- Practice creating tables with various constraints
- Practice the test-first approach with UPDATE and DELETE
- Build confidence before moving to more complex queries

