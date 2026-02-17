---
marp: true
theme: default
class: invert
paginate: true
---

# Building & Managing Data
**Database Applications Development (145085)**
*Medina County Career Center | Instructor: Ryan McMaster*

---

## Sub-Lesson 08a — CREATE TABLE & INSERT

### CREATE TABLE Syntax

```sql
CREATE TABLE table_name (
  column_name  DATA_TYPE  [constraints],
  column_name  DATA_TYPE  [constraints]
);
```

### SQLite Data Types
- **INTEGER** — whole numbers (-9223372036854775808 to 9223372036854775807)
- **TEXT** — strings, names, descriptions
- **REAL** — floating-point numbers (decimals)
- **BLOB** — binary data (images, files)
- **NULL** — missing or unknown value

---

## INSERT INTO — Adding Records

```sql
INSERT INTO table_name (column1, column2, column3)
VALUES (value1, value2, value3);
```

**Key Points:**
- Column names tell SQL which order the VALUES go in
- Match data types: TEXT values need quotes, INTEGER/REAL don't
- If a column has NOT NULL constraint, you must provide a value

**Example:**
```sql
INSERT INTO students (id, name, gpa)
VALUES (1, 'Alice Smith', 3.85);
```

---

## Sub-Lesson 08b — UPDATE & DELETE

### UPDATE Syntax with WHERE

```sql
UPDATE table_name
SET column1 = value1, column2 = value2
WHERE condition;
```

**CRITICAL: Test your WHERE clause first!**
```sql
-- Step 1: Test what rows you'll affect
SELECT * FROM students WHERE gpa < 2.0;

-- Step 2: Run the UPDATE only if results look right
UPDATE students SET status = 'probation' WHERE gpa < 2.0;
```

---

## The Danger: UPDATE Without WHERE

```sql
-- WRONG: This changes EVERY row!
UPDATE students SET gpa = 4.0;
```

**Result:** All students suddenly have a 4.0 GPA. Disaster.

**Right Approach:**
1. Write your WHERE clause
2. Test it with SELECT first
3. Copy the exact WHERE into UPDATE
4. Run UPDATE only after verification

---

## DELETE Syntax — Same Safety Principle

```sql
DELETE FROM table_name
WHERE condition;
```

**CRITICAL: Always test first!**
```sql
-- Step 1: Verify what you're deleting
SELECT * FROM students WHERE id = 5;

-- Step 2: Delete only if you're sure
DELETE FROM students WHERE id = 5;
```

**Never do this:**
```sql
-- WRONG: Deletes ALL rows!
DELETE FROM students;
```

---

## Sub-Lesson 08c — Constraints

### Why Constraints Matter

**Garbage In, Garbage Out (GIGO)**
- Without constraints, anyone can insert incomplete, duplicate, or invalid data
- Constraints enforce rules at the database level — before bad data gets in
- Data integrity = trustworthy data = reliable business decisions

---

## Column-Level Constraints

### NOT NULL
Ensures a column must always have a value.
```sql
CREATE TABLE employees (
  id INTEGER NOT NULL,
  name TEXT NOT NULL,
  salary REAL
);
```

### UNIQUE
Prevents duplicate values in a column.
```sql
CREATE TABLE users (
  id INTEGER,
  email TEXT UNIQUE
);
```

### DEFAULT
Provides an automatic value if none is given.
```sql
CREATE TABLE posts (
  id INTEGER,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);
```

---

## Value & Referential Constraints

### CHECK
Validates that values meet a condition.
```sql
CREATE TABLE products (
  id INTEGER,
  price REAL CHECK (price > 0)
);
```

### PRIMARY KEY
Uniquely identifies each row (NOT NULL + UNIQUE).
```sql
CREATE TABLE courses (
  course_id INTEGER PRIMARY KEY,
  title TEXT NOT NULL
);
```

### FOREIGN KEY
Links to a PRIMARY KEY in another table (referential integrity).
```sql
CREATE TABLE enrollments (
  id INTEGER PRIMARY KEY,
  student_id INTEGER REFERENCES students(id),
  course_id INTEGER REFERENCES courses(course_id)
);
```

---

## Key Takeaways & Syntax Reference

**CREATE TABLE:** Define structure before adding data
**INSERT:** Add one row at a time with VALUES
**UPDATE:** Change existing data — test WHERE first with SELECT
**DELETE:** Remove rows — test WHERE first with SELECT
**Constraints:** Enforce rules to protect data integrity

**Remember:** GIGO — good constraints prevent bad data from ever entering your database.

