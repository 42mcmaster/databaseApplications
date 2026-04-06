---
marp: true
theme: default
class: invert
paginate: true
---

# Building & Managing Data
## CREATE, INSERT, UPDATE, DELETE, and Constraints

**Database Applications Development**
Software Engineering | Medina County Career Center

---

## Quick Recap

So far, we've **read** data out of existing databases:
- SELECT, WHERE, JOINs, GROUP BY…

Today we flip it around and **build our own** database from scratch.

You'll learn how to:
1. **Create** a table
2. **Insert** rows into it
3. **Update** rows that already exist
4. **Delete** rows you don't want
5. **Protect** the table with constraints so bad data can't get in

---

## The Four Big Verbs

| Verb | What it does |
|------|--------------|
| **CREATE TABLE** | Build a new empty table with columns and rules |
| **INSERT** | Add new rows |
| **UPDATE** | Change existing rows |
| **DELETE** | Remove rows |

SELECT asks "what's in there?" — these four verbs actually change what's in there.

---

## CREATE TABLE — The Basics

You're making a blueprint. You tell SQL:
- What the table is called
- What columns it has
- What kind of data each column holds

```sql
CREATE TABLE students (
  student_id  INTEGER,
  name        TEXT,
  gpa         REAL
);
```

That's it. Empty table, ready for rows.

---

## SQLite Data Types (the simple version)

| Type | Use it for |
|------|-----------|
| **INTEGER** | Whole numbers (id, age, count) |
| **TEXT** | Strings — names, emails, descriptions |
| **REAL** | Decimals — gpa, price, height |
| **BLOB** | Raw binary — images, files (rarely used in class) |
| **NULL** | The column has no value yet |

Pick the smallest type that fits. If you'll never store decimals, use INTEGER not REAL.

---

## INSERT INTO — Adding Rows

```sql
INSERT INTO students (student_id, name, gpa)
VALUES (1, 'Arnold', 3.85);
```

**Read it like a sentence:**
> "INSERT INTO students, using these columns, these values."

- Text values need **quotes**: `'Arnold'`
- Numbers don't: `3.85`
- The order of values must match the order of columns you listed.

---

## INSERT — Multiple Rows at Once

You can stack rows in one statement:

```sql
INSERT INTO students (student_id, name, gpa)
VALUES
  (1, 'Arnold',      3.85),
  (2, 'Lebron',      3.70),
  (3, 'Kobe',        3.92),
  (4, 'Maxibillion', 2.45);
```

Fast, clean, and easy to read.

---

## UPDATE — Changing Existing Rows

```sql
UPDATE students
SET gpa = 3.90
WHERE student_id = 1;
```

**Read it like a sentence:**
> "UPDATE the students table, SET gpa to 3.90, WHERE student_id is 1."

The `WHERE` clause is what tells SQL **which rows** to change.

---

## ⚠️ The #1 Rookie Mistake

What happens if you forget the WHERE?

```sql
UPDATE students SET gpa = 4.0;
```

**Every single student now has a 4.0.**
No warning. No undo. You just rewrote your whole table.

This is the most common painful mistake in SQL. Be careful.

---

## The Safe UPDATE Workflow

Always do this in TWO steps:

**Step 1 — Test the WHERE with a SELECT:**
```sql
SELECT * FROM students WHERE gpa < 2.0;
```
Look at the rows. Are they the ones you actually want to change?

**Step 2 — Then UPDATE:**
```sql
UPDATE students SET status = 'probation' WHERE gpa < 2.0;
```

**SELECT first, UPDATE second.** Make this a habit.

---

## DELETE — Removing Rows

```sql
DELETE FROM students
WHERE student_id = 4;
```

Same shape as UPDATE: you need a WHERE to say **which** rows.

And the same scary trap…

```sql
DELETE FROM students;
```

**This deletes EVERY row in the table.** Gone. Just like that.

---

## The Safe DELETE Workflow

Same two-step habit:

```sql
-- Step 1: See what you'd delete
SELECT * FROM students WHERE student_id = 4;

-- Step 2: Delete only if the results look right
DELETE FROM students WHERE student_id = 4;
```

> **"SELECT before you UPDATE or DELETE. Always."**

---

## Why Constraints?

So far, our CREATE TABLE was wide open. Anybody could:
- Leave the name blank
- Insert two students with the same ID
- Type a negative GPA
- Invent a `dept_id` that doesn't exist

**Constraints** are rules you bake into the table so bad data can't get in.

> **Garbage in → Garbage out.** Constraints are how you keep the garbage out.

---

## Constraint 1: NOT NULL

"This column must have a value."

```sql
CREATE TABLE students (
  student_id INTEGER,
  name       TEXT NOT NULL,
  gpa        REAL
);
```

Now you can't insert a student with no name. SQL will refuse.

---

## Constraint 2: UNIQUE

"No two rows can have the same value in this column."

```sql
CREATE TABLE users (
  user_id INTEGER,
  email   TEXT UNIQUE
);
```

Try to insert two users with the same email? Rejected.
Perfect for emails, usernames, phone numbers.

---

## Constraint 3: DEFAULT

"If nobody provides a value, use this one."

```sql
CREATE TABLE posts (
  post_id    INTEGER,
  title      TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);
```

Now if you insert a post without `created_at`, SQL fills in the current time for you. Saves typing and prevents forgotten timestamps.

---

## Constraint 4: CHECK

"The value must make this condition true."

```sql
CREATE TABLE products (
  product_id INTEGER,
  name       TEXT,
  price      REAL CHECK (price > 0)
);
```

Try to insert a product with `price = -5`? Rejected.
CHECK catches impossible values before they ever enter the table.

---

## Constraint 5: PRIMARY KEY

The big one. It means:
- This column is the **unique ID** for each row
- Values must be unique (UNIQUE)
- Values can't be empty (NOT NULL)
- SQL will make lookups on this column very fast

```sql
CREATE TABLE courses (
  course_id INTEGER PRIMARY KEY,
  title     TEXT NOT NULL
);
```

Every good table should have a primary key.

---

## Constraint 6: FOREIGN KEY

"This column must match a primary key in another table."

```sql
CREATE TABLE enrollments (
  enrollment_id INTEGER PRIMARY KEY,
  student_id    INTEGER REFERENCES students(student_id),
  course_id     INTEGER REFERENCES courses(course_id)
);
```

Now you can't enroll a student who doesn't exist or in a course that doesn't exist. This is called **referential integrity** — your FKs always point to something real.

---

## Putting It All Together

A small but properly protected table:

```sql
CREATE TABLE students (
  student_id INTEGER PRIMARY KEY,
  name       TEXT NOT NULL,
  email      TEXT UNIQUE NOT NULL,
  gpa        REAL CHECK (gpa >= 0 AND gpa <= 4.0),
  dept_id    INTEGER REFERENCES departments(dept_id),
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);
```

Every column has a job, a type, and a rule. This is how real databases are built.

---

## Quick Review: What Does Each Constraint Catch?

| Rule | Blocks… |
|------|---------|
| NOT NULL | Missing values |
| UNIQUE | Duplicate values |
| DEFAULT | Forgotten values (fills them in) |
| CHECK | Invalid / impossible values |
| PRIMARY KEY | Missing IDs and duplicate IDs |
| FOREIGN KEY | Pointers to rows that don't exist |

Each one prevents a different category of "bad data."

---

## The Whole Recipe

1. **CREATE TABLE** with columns, types, and constraints.
2. **INSERT** rows using the column list + VALUES.
3. To change data, **SELECT first** to verify → then **UPDATE**.
4. To remove data, **SELECT first** to verify → then **DELETE**.
5. Use **constraints** so future you (and future students) can't break the table.

---

## Key Takeaways

- SELECT reads data. CREATE / INSERT / UPDATE / DELETE change it.
- **Always SELECT before UPDATE or DELETE.** Always.
- Constraints aren't extra work — they're how you keep your data clean.
- PRIMARY KEY + FOREIGN KEY are what turn separate tables into a real relational database.

**Next up:** Walkthrough, then tasks, then DIY.
