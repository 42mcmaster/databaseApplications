# Unit 4b — Change, Delete, and Import Data

Yesterday you built your tables and added four rows to each. Today you **import** more rows from a CSV file, **change** rows with `UPDATE`, **remove** rows with `DELETE`, and learn how **transactions** keep a database safe. You work in the same database you built in Unit 4.

## Contents

- [What you're doing today](#what-youre-doing-today)
- [Part 1 — Demo: import, change, and delete](#part-1--demo-import-change-and-delete)
- [Transactions](#transactions)
- [Part 2 — Do it in your database](#part-2--do-it-in-your-database)
- [The patterns](#the-patterns)
- [Common errors](#common-errors)
- [Words for the exam](#words-for-the-exam)
- [Turn in](#turn-in)

---

## What you're doing today

| Command | What it does | When you learned it |
|---|---|---|
| `INSERT` | Adds new rows | Unit 4 |
| `SELECT` | Shows rows | Unit 2 |
| `UPDATE` | **Changes** values in rows that are already there | Today |
| `DELETE` | **Removes** rows | Today |

All four are **DML** (Data Manipulation Language). They work with the rows, not the table structure.

You also learn two more things:

- **Importing a CSV file** — adding a lot of rows at once without typing them.
- **Transactions** — saving a group of changes together, or undoing them together.

---

## Part 1 — Demo: import, change, and delete

We'll do this as a class in `school_demo.db` from Unit 4. It has two teachers and two courses.

**Set up:**

1. Open `school_demo.db` in DB Browser. **Don't have it?** Make a new one: **File → New Database**, name it `school_demo.db`, and click **Cancel** on the pop-up.
2. **Edit Pragmas** tab → make sure **Foreign Keys** is checked → **Save**.
3. **Execute SQL** tab → paste and run this whole script. It builds both tables from scratch with the starting data. It's safe to run even if you already have the tables.

```sql
-- Start fresh: drop the child table first, then the parent
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS teachers;

-- teachers: one row = one teacher
CREATE TABLE teachers (
    teacher_id    INTEGER PRIMARY KEY,
    teacher_name  TEXT    NOT NULL,
    room          TEXT    CHECK (length(room) = 3)
);

-- courses: one row = one course
CREATE TABLE courses (
    course_id     INTEGER PRIMARY KEY,
    title         TEXT    NOT NULL,
    teacher_id    INTEGER NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teachers (teacher_id)
);

-- Starting data
INSERT INTO teachers (teacher_id, teacher_name, room) VALUES
    (1, 'Ryan McMaster', '214'),
    (2, 'Dana Lee',      '108');

INSERT INTO courses (course_id, title, teacher_id) VALUES
    (101, 'Database Applications', 1),
    (102, 'Web Design',            2);

-- Check it: 2 teachers, 2 courses
SELECT * FROM teachers;
SELECT * FROM courses;
```

4. **VERY IMPORTANT!**  Click **Write Changes**.  This saves your database changes to the actual database file>

### Import a CSV file

The office sent three new teachers in a CSV file. We'll start with the version that has a mistake in it.

1. **File → Import → Table from CSV file...** Pick `unit4b_demo_teachers_bad.csv`.
2. In the import window:
   - **Table name:** change it to `teachers` (the table that already exists).
   - **Column names in first line:** checked.
   - **Field separator:** comma.
3. Click **OK**. DB Browser asks: *There is already a table named 'teachers'. Do you want to import the data into it?* Click **Yes**.

It fails: `CHECK constraint failed`. Priya Shah's room is `1150`, which is 4 characters. Our rule says rooms are 3 characters.

Now look at the teachers table. **None of the three teachers got in**, not even the two good ones. The import is all-or-nothing. That's a transaction at work (more on that below).

Now import `unit4b_demo_teachers.csv` the same way. All three rows go in. Click **Write Changes**.

> **The CSV columns must be in the same order as the table's columns.** DB Browser matches them by position, not by name.

### UPDATE: change a row

```sql
UPDATE teachers
SET room = '216'
WHERE teacher_id = 3;
```

Read it as: "In `teachers`, set `room` to `'216'`, but only for the row where `teacher_id` is 3."

DB Browser shows **1 rows affected**. Run `SELECT * FROM teachers;` to see it.

### DELETE: remove a row

```sql
DELETE FROM teachers
WHERE teacher_id = 5;
```

Ben Carter is gone. Now try to delete a teacher who has a course:

```sql
DELETE FROM teachers
WHERE teacher_id = 1;
-- FOREIGN KEY constraint failed
```

Course 101 points at teacher 1. If teacher 1 were deleted, course 101 would point at nobody. The foreign key stops it. That's **referential integrity**.

Click **Write Changes**.

### The disaster: forgetting WHERE

Run this. It has no `WHERE`:

```sql
UPDATE teachers
SET room = '999';
```

DB Browser says **4 rows affected**. Run `SELECT * FROM teachers;`. Every teacher is now in room 999.

**Without `WHERE`, `UPDATE` changes every row and `DELETE` removes every row.** The database doesn't ask "are you sure?"

Click **Revert Changes**. Run the `SELECT` again. The rooms are back. That worked because we clicked Write Changes right before the mistake.

---

## Transactions

A **transaction** is a group of changes that either all happen or all get undone. It's never half done.

The classic example is moving $100 from savings to checking. That takes two steps:

```sql
BEGIN TRANSACTION;

UPDATE accounts SET balance = balance - 100 WHERE account_id = 'savings';
UPDATE accounts SET balance = balance + 100 WHERE account_id = 'checking';

COMMIT;
```

If the power goes out after the first step, $100 is gone from savings and never reached checking. A transaction prevents that: the database either keeps both steps or neither.

| SQL command | What it does | DB Browser button |
|---|---|---|
| `BEGIN TRANSACTION` | Starts a group of changes | DB Browser starts one for you as soon as you change anything |
| `COMMIT` | Saves the whole group for good | **Write Changes** |
| `ROLLBACK` | Undoes the whole group | **Revert Changes** |

> **In DB Browser, use the buttons. Don't type `BEGIN`, `COMMIT`, or `ROLLBACK` into Execute SQL.** DB Browser already has a transaction open, so typing your own causes errors. On a real database server you type them; in DB Browser the buttons do it.

**The habit:** click **Write Changes** after every step you're happy with. Then if you make a mistake, **Revert Changes** only undoes the mistake.

---

## Part 2 — Do it in your database

1. Copy `unit4b_lastname.sql` from your client's folder into your repo and rename it with your last name.
2. Open your `unit4_lastname.db` in DB Browser. Check **Edit Pragmas → Foreign Keys** is on.
3. **Import** your client's CSV into the table it names in Part 1 of the file. Use the steps from the demo. Click **Write Changes**.
4. Open your `.sql` file in the **Execute SQL** tab.
5. Do the tasks **one at a time**: type the SQL under the task, **highlight just that task's lines**, and press **Ctrl+Return** (**Cmd+Return** on a Mac).
6. After each part, run the check `SELECT`s and click **Write Changes**.
7. Answer the questions in the comments.

> **Don't run the whole file at once.** Some tasks add to a number (`level = level + 1`). Running them twice changes the data twice.

---

## The patterns

**UPDATE one column**

```sql
UPDATE items
SET item_gold_value = 15
WHERE item_name = 'Mana Potion';
```

**UPDATE two columns at once** — put a comma between them

```sql
UPDATE teachers
SET teacher_name = 'Sam Ortiz-Lee', room = '220'
WHERE teacher_id = 3;
```

**UPDATE using the old value** — math on the column

```sql
UPDATE characters
SET level = level + 1        -- whatever it was, plus 1
WHERE character_id = 3;
```

**UPDATE many rows on purpose** — the `WHERE` picks a group

```sql
UPDATE items
SET item_gold_value = item_gold_value - 5
WHERE item_rarity = 'Common';   -- every Common item, and only those
```

**DELETE one row**

```sql
DELETE FROM items
WHERE item_name = 'Phoenix Feather';
```

**DELETE when the key is two columns** — use `AND` to name both

```sql
DELETE FROM inventory
WHERE character_id = 4 AND item_name = 'Health Potion';
```

**Before any UPDATE or DELETE, run a SELECT with the same WHERE.** It shows exactly which rows you're about to change.

```sql
SELECT * FROM items WHERE item_rarity = 'Common';   -- look first
```

---

## Common errors

| What happens | Usual cause |
|---|---|
| `FOREIGN KEY constraint failed` on a DELETE | Another table still points at this row. Delete or change the child row first. |
| `CHECK constraint failed` on an UPDATE | The new value breaks one of your CHECK rules. The rule is working. |
| `UNIQUE constraint failed` on an import | A row in the CSV has the same key as a row already in the table |
| Import says the number of columns doesn't match | You picked the wrong table name, or the CSV has a different number of columns |
| Import added nothing | One row broke a rule, so the whole import was undone. Read the error message for which rule. |
| `0 rows affected` | The `WHERE` didn't match anything. Check spelling and capital letters in the quoted text. |
| Every row changed | You left off the `WHERE`. Click **Revert Changes**. |
| `cannot start a transaction within a transaction` | You typed `BEGIN` in DB Browser. Use the buttons instead. |

---

## Words for the exam

| Word | Means |
|---|---|
| **UPDATE** | Changes values in existing rows |
| **DELETE** | Removes rows |
| **DML** | Data Manipulation Language: `SELECT`, `INSERT`, `UPDATE`, `DELETE` |
| **Transaction** | A group of changes that all happen or all get undone |
| **COMMIT** | Saves a transaction for good |
| **ROLLBACK** | Undoes a transaction |
| **ACID** | The four promises a transaction makes (below) |
| **Import** | Loading data into a database from a file |
| **Bulk import** | Loading many rows at once. Three common ways: a **CSV file**, a **SQL script** full of `INSERT`s, or a **bulk command** like SQL Server's `BULK INSERT` |
| **Referential integrity** | Every foreign key points at a row that really exists |

**ACID** — you'll see this on tests:

| Letter | Word | Plain meaning |
|---|---|---|
| **A** | Atomic | All of it happens, or none of it |
| **C** | Consistent | The rules (keys, CHECKs) are still true afterward |
| **I** | Isolated | Two people's transactions don't mix together halfway |
| **D** | Durable | Once committed, it stays saved, even if the power goes out |

---

## Turn in

Commit and push both files:

- `unit4b_lastname.sql` — your UPDATE and DELETE statements and your answers
- `unit4_lastname.db` — your database with the changes written (click **Write Changes** first)
