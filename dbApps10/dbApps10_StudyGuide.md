# DBApps 10: Capstone Project — Study Guide & Quick Reference

**Database Applications Development (145085)**
Medina County Career Center | Instructor: Ryan McMaster

---

## 1. SQL Quick Reference

### Basic SELECT Queries

```sql
-- Simple SELECT
SELECT column1, column2 FROM table_name;

-- All columns
SELECT * FROM table_name;

-- WHERE clause (filter rows)
SELECT * FROM students WHERE age > 18;

-- AND / OR / NOT
SELECT * FROM students WHERE age > 18 AND grade = 'A';
SELECT * FROM students WHERE age > 18 OR grade = 'A';
SELECT * FROM students WHERE NOT grade = 'A';

-- LIKE (pattern matching)
SELECT * FROM students WHERE name LIKE 'J%';      -- starts with J
SELECT * FROM students WHERE email LIKE '%@gmail.com'; -- ends with @gmail.com

-- BETWEEN
SELECT * FROM orders WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31';

-- IN
SELECT * FROM students WHERE grade IN ('A', 'B', 'C');

-- ORDER BY
SELECT * FROM students ORDER BY grade DESC;        -- descending
SELECT * FROM students ORDER BY grade ASC;         -- ascending (default)

-- LIMIT
SELECT * FROM students LIMIT 10;                   -- first 10 rows
SELECT * FROM students LIMIT 10 OFFSET 5;          -- skip 5, then 10

-- DISTINCT (remove duplicates)
SELECT DISTINCT grade FROM students;
```

### Aggregate Functions

```sql
-- COUNT rows
SELECT COUNT(*) FROM students;                      -- total rows
SELECT COUNT(grade) FROM students;                  -- non-NULL values
SELECT COUNT(DISTINCT grade) FROM students;         -- unique grades

-- SUM / AVG / MIN / MAX
SELECT SUM(salary) FROM employees;
SELECT AVG(age) FROM students;
SELECT MIN(age), MAX(age) FROM students;

-- ROUND results
SELECT ROUND(AVG(age), 2) FROM students;            -- 2 decimal places
```

### GROUP BY & HAVING

```sql
-- GROUP BY (aggregate by category)
SELECT grade, COUNT(*) as student_count
FROM students
GROUP BY grade;

-- HAVING (filter groups)
SELECT grade, COUNT(*) as student_count
FROM students
GROUP BY grade
HAVING COUNT(*) > 5;

-- GROUP BY multiple columns
SELECT department, position, COUNT(*)
FROM employees
GROUP BY department, position;

-- AS (column alias)
SELECT COUNT(*) AS total_students FROM students;
SELECT AVG(salary) AS average_salary FROM employees;
```

### JOINs (Combine Tables)

```sql
-- INNER JOIN (only matching rows)
SELECT students.name, courses.title
FROM students
INNER JOIN enrollments ON students.id = enrollments.student_id
INNER JOIN courses ON enrollments.course_id = courses.id;

-- LEFT JOIN (all left rows + matching right)
SELECT students.name, courses.title
FROM students
LEFT JOIN enrollments ON students.id = enrollments.student_id
LEFT JOIN courses ON enrollments.course_id = courses.id;

-- ON clause (join condition)
SELECT * FROM orders
INNER JOIN customers ON orders.customer_id = customers.id;
```

### INSERT, UPDATE, DELETE

```sql
-- INSERT single row
INSERT INTO students (name, age, grade)
VALUES ('Alice', 20, 'A');

-- INSERT multiple rows
INSERT INTO students (name, age, grade) VALUES
('Alice', 20, 'A'),
('Bob', 19, 'B'),
('Charlie', 21, 'A');

-- UPDATE rows
UPDATE students SET grade = 'A' WHERE name = 'Bob';

-- DELETE rows (be careful!)
DELETE FROM students WHERE id = 5;
```

### CREATE TABLE & Constraints

```sql
CREATE TABLE students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER CHECK (age >= 18),
    email TEXT UNIQUE,
    grade TEXT DEFAULT 'C',
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Add foreign key to another table
CREATE TABLE enrollments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- Constraints explained:
-- PRIMARY KEY      — unique identifier, no NULLs
-- NOT NULL         — column must have a value
-- UNIQUE           — all values must be different
-- DEFAULT          — automatic value if not provided
-- CHECK            — validates data (e.g., age >= 18)
-- FOREIGN KEY      — links to another table's primary key
-- AUTOINCREMENT    — automatically increment on INSERT
```

### Transactions (ACID)

```sql
-- BEGIN transaction
BEGIN;

INSERT INTO accounts (name, balance) VALUES ('Alice', 1000);
INSERT INTO accounts (name, balance) VALUES ('Bob', 500);

-- COMMIT (save changes)
COMMIT;

-- Or ROLLBACK (undo changes)
ROLLBACK;

-- Practical example: money transfer
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE name = 'Alice';
UPDATE accounts SET balance = balance + 100 WHERE name = 'Bob';
COMMIT;
```

### Parameterized Queries (Prevent SQL Injection)

```sql
-- Python + SQLite3 example
import sqlite3

conn = sqlite3.connect('database.db')
cursor = conn.cursor()

-- GOOD: Use ? placeholders
query = "SELECT * FROM students WHERE name = ?"
cursor.execute(query, ('Alice',))

-- GOOD: Multiple parameters
query = "INSERT INTO students (name, age) VALUES (?, ?)"
cursor.execute(query, ('Bob', 20))

-- BAD: String concatenation (vulnerable to SQL injection)
# query = f"SELECT * FROM students WHERE name = '{user_input}'"  -- DON'T DO THIS!

conn.commit()
conn.close()
```

---

## 2. Python-SQLite Quick Reference

```python
import sqlite3
import pandas as pd

# Connect to database
conn = sqlite3.connect('mydatabase.db')
cursor = conn.cursor()

# Execute single query
cursor.execute("SELECT * FROM students")
results = cursor.fetchall()        # Get all rows (list of tuples)
result = cursor.fetchone()         # Get first row (single tuple)

# Execute with parameters (safe!)
cursor.execute("SELECT * FROM students WHERE name = ?", ('Alice',))

# Insert data
cursor.execute("INSERT INTO students (name, age) VALUES (?, ?)", ('Bob', 20))
conn.commit()                       # Save changes

# Read into Pandas DataFrame (very useful!)
df = pd.read_sql("SELECT * FROM students", conn)
print(df)

# Close connection
conn.close()
```

---

## 3. Project Checklist

Use this checklist as you work through each phase:

### Phase 10a: Kickoff
- [ ] Topic chosen and approved
- [ ] Understand project requirements
- [ ] Review rubric (what gets points?)
- [ ] Set up GitHub repository

### Phase 10b: Design
- [ ] Identified 3+ entities (tables)
- [ ] Listed attributes for each table
- [ ] Identified relationships
- [ ] Drew ER diagram (on paper or tool)
- [ ] Wrote CREATE TABLE statements
- [ ] All constraints in place (PKs, FKs, NOT NULL, etc.)

### Phase 10c: Build
- [ ] Database created
- [ ] All CREATE TABLE statements executed
- [ ] 20+ records inserted per main table (realistic data)
- [ ] No errors on INSERT
- [ ] Data looks correct in database viewer

### Phase 10d: Queries
- [ ] 10+ queries written
- [ ] At least 1 with WHERE clause
- [ ] At least 1 with INNER JOIN
- [ ] At least 1 with LEFT JOIN
- [ ] At least 1 with GROUP BY and aggregate
- [ ] At least 1 with HAVING
- [ ] All queries return correct results
- [ ] Queries are parameterized (use ?)
- [ ] Each query has a comment explaining it

### Phase 10e: Polish
- [ ] Data dictionary created (table & column descriptions)
- [ ] All queries use parameterized placeholders
- [ ] Transaction example written and tested
- [ ] SQL code is clean and readable
- [ ] Comments explain complex logic
- [ ] All files committed to GitHub

### Phase 10f: Presentation
- [ ] Presentation slides prepared
- [ ] ER diagram ready to show
- [ ] 3-4 best queries selected
- [ ] Queries tested and demo'd
- [ ] 10-minute speech prepared
- [ ] Files pushed to GitHub

---

## 4. ER Diagram Notation Reminder

### Quick Guide

**Entity (Table)**
```
┌─────────────┐
│   Student   │
├─────────────┤
│ id (PK)     │
│ name        │
│ age         │
└─────────────┘
```

**Relationship Lines**
- **1-to-Many:** One student enrolls in many courses
  ```
  Student ──1:M──> Enrollment
  ```
- **Many-to-Many:** Many students take many courses (via junction table)
  ```
  Student ──M──> Enrollment ──M──> Course
  ```

**Key Symbols**
- **PK** = Primary Key (unique identifier)
- **FK** = Foreign Key (links to another table)

**Example ER Diagram**
```
┌──────────────┐       ┌──────────────┐       ┌──────────────┐
│   Student    │       │ Enrollment   │       │   Course     │
├──────────────┤       ├──────────────┤       ├──────────────┤
│ id (PK)      │───1:M─│ id (PK)      │─M:1───│ id (PK)      │
│ name         │       │ student_id FK│       │ title        │
│ email        │       │ course_id FK │       │ credits      │
│ age          │       │ grade        │       │ instructor   │
└──────────────┘       └──────────────┘       └──────────────┘
```

---

## 5. Common Mistakes to Avoid

1. **Forgetting PRIMARY KEY** — every table needs a unique identifier
2. **Forgetting FOREIGN KEY** — relationships won't work without them
3. **String concatenation in queries** — always use parameterized queries (?)
4. **Not committing changes** — use `conn.commit()` after INSERT/UPDATE/DELETE
5. **Duplicate records** — add UNIQUE constraints where needed
6. **Too many tables** — 3-5 is plenty for this project
7. **Not testing queries** — run every query before presentation
8. **Missing comments** — explain what each query does

---

## 6. Git Workflow for Capstone

```bash
# Initialize (first time only)
git init
git add .
git commit -m "Initial commit: project setup"
git remote add origin https://github.com/YOUR_USERNAME/dbApps10.git
git branch -M main
git push -u origin main

# After each phase
git add .
git commit -m "Phase 10b: Design complete — ER diagram and CREATE TABLE"
git push

git add .
git commit -m "Phase 10c: Build complete — database populated with 20+ records"
git push

git add .
git commit -m "Phase 10d: Queries complete — 10+ queries with all required types"
git push
```

---

## 7. Helpful Resources

- **SQLite Docs:** https://www.sqlite.org/lang.html
- **Online ER Diagram Tool:** https://www.lucidchart.com/ or https://www.draw.io/
- **SQL Practice:** https://sqlzoo.net/ or https://www.w3schools.com/sql/
- **Python sqlite3:** https://docs.python.org/3/library/sqlite3.html

---

**Good luck with your capstone! Remember: keep it simple, ask questions early, and have fun building.**
