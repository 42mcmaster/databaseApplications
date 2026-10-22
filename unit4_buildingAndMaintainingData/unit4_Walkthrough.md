# Unit 4 — Build and Fill Your Database

Today you write the SQL that **builds the tables**, then the SQL that **puts data in them**. One day, one script.

## Contents

- [What you're doing today](#what-youre-doing-today)
- [Part 1 — Demo: build two tables together](#part-1--demo-build-two-tables-together)
- [Part 2 — Build yours](#part-2--build-yours)
- [The patterns](#the-patterns)
- [CHECK rule ideas](#check-rule-ideas)
- [Common errors](#common-errors)
- [Turn in](#turn-in)

---

## What you're doing today

- **Same client as 3e:** Baseball, Music, or Game.
- **Open your client's data file:** `unit4_Baseball_Data.xlsx`, `unit4_Music_Data.xlsx`, or `unit4_Game_Data.xlsx`. It lists every table in the order you build them. Each table has two grids:
  - **Schema** (top): the columns, data types, and keys. This is what goes in your `CREATE TABLE`.
  - **Data** (yellow): four rows. This is what goes in your `INSERT`.
- **You write one file:** `unit4_lastname.sql`. You run it in DB Browser to make `unit4_lastname.db`.

| Kind of SQL | What it does | Today's commands |
|---|---|---|
| **DDL** (Data Definition Language) | Builds the **structure**: the tables | `DROP TABLE`, `CREATE TABLE` |
| **DML** (Data Manipulation Language) | Works with the **rows** inside the tables | `INSERT`, `SELECT` |

---

## Part 1 — Demo: build two tables together

We'll do this as a class. Type along in DB Browser.

**Set up:**

1. Open **DB Browser for SQLite**. **File → New Database.** Name it `school_demo.db`. When the "define a table" window pops up, click **Cancel**.
2. Go to the **Edit Pragmas** tab. Check **Foreign Keys**. Click **Save**. (If this is off, foreign keys do nothing.)
3. Go to the **Execute SQL** tab.

**Build two tables:**

```sql
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
```

Run it: click ▶, or press **Ctrl+Return** (**Cmd+Return** on a Mac). Things to notice:

- Each column is **name, then type, then rules**.
- **No comma after the last line** before the `)`.
- The `FOREIGN KEY` line is not a column. It's a rule about `teacher_id`, and it goes after the columns.
- `teachers` comes first because `courses` points at it.

> **Don't see your tables in the Database Structure tab?** Press **F5** (**Cmd+R** on a Mac), or go to **View → Refresh**.

**Make an error on purpose.** Run this. It has a comma after the last column:

```sql
CREATE TABLE oops (
    oops_id  INTEGER PRIMARY KEY,
    room     TEXT,
);
```

The error says `near ")": syntax error`. The last line before the `)` never gets a comma. This is the most common mistake in this unit. (Nothing was created, so there's nothing to clean up.)

**Add data:**

```sql
INSERT INTO teachers (teacher_id, teacher_name, room) VALUES
    (1, 'Ryan McMaster', '214'),
    (2, 'Dana Lee',      '108');

INSERT INTO courses (course_id, title, teacher_id) VALUES
    (101, 'Database Applications', 1),
    (102, 'Web Design',            2);

SELECT * FROM courses;
```

- Text goes in **single quotes**. Numbers don't.
- One `INSERT` can add several rows. Put a comma between rows and a semicolon at the end.
- If text has an apostrophe, type it twice: `'God''s Plan'`.

**Watch the database refuse bad data.** Run these one at a time:

```sql
INSERT INTO courses (course_id, title, teacher_id) VALUES (103, 'Robotics', 99);
-- FOREIGN KEY constraint failed  (there is no teacher 99)

INSERT INTO teachers (teacher_id, teacher_name, room) VALUES (3, 'Sam Ortiz', '2200');
-- CHECK constraint failed  (room is 4 characters, not 3)
```

> **If the teacher 99 insert doesn't give an error,** Foreign Keys is off. Go back to **Edit Pragmas** and check it.

You set the rules once in `CREATE TABLE`. The database checks every row after that.

## Rebuilding a table: DROP TABLE IF EXISTS

Remember that if you try to create a table that already exists, you will get an error. Use `DROP TABLE IF EXISTS` to remove the table first if you are changing it.

Drop the **child** tables first, then the **parents**. That's the reverse of the order you created them. SQLite won't drop `teachers` while `courses` still points at it.

```sql
DROP TABLE IF EXISTS courses;    -- child first (it points at teachers)
DROP TABLE IF EXISTS teachers;   -- parent last
```

---

## Part 2 — Build yours

1. Copy `unit4_lastname.sql` into your repo and rename it with your last name.
2. **DROP:** write `DROP TABLE IF EXISTS` for every table, in **reverse** order (last table first).
3. **CREATE:** write a `CREATE TABLE` for every table, in the order in your data file. Use the **Schema** grid:
   - `PK` on one column → `PRIMARY KEY` on that column.
   - `PK` on two columns → a `PRIMARY KEY (col1, col2)` line after the columns.
   - `FK → table` → a `FOREIGN KEY (...) REFERENCES table (...)` line after the columns.
   - `not_null` = Y → `NOT NULL`.
4. **Add at least two `CHECK` rules** of your own. See [CHECK rule ideas](#check-rule-ideas). Every rule must be true for the four data rows, or your inserts will fail.
5. **INSERT:** write one `INSERT` per table, in the same order you created them. Type all four rows from the yellow **Data** grid.
6. **Run it:**
   - **File → New Database.** Save it in your repo as `unit4_lastname.db`. Click **Cancel** on the pop-up.
   - **Edit Pragmas** → check **Foreign Keys** → **Save**.
   - **Execute SQL** → paste your script → run all of it.
   - Add `SELECT * FROM` each table at the bottom to check your rows are there.
7. **Run it a second time.** No errors means your `DROP` lines work.
8. **Write Changes** (Ctrl+S / Cmd+S). DB Browser doesn't save to the `.db` file until you do this.

---

## The patterns

**CREATE TABLE — a table with a one-column key**

This is `courses` from the demo. The key is one column, so `PRIMARY KEY` goes right on that column's line.

```sql
-- courses: one row = one course
CREATE TABLE courses (
    course_id     INTEGER PRIMARY KEY,   -- the key: one column
    title         TEXT    NOT NULL,      -- must have a value
    teacher_id    INTEGER NOT NULL,      -- points at the teachers table
    FOREIGN KEY (teacher_id) REFERENCES teachers (teacher_id)
);
```

Read the `FOREIGN KEY` line as: "`teacher_id` in this table must match a `teacher_id` that's already in `teachers`."

**CREATE TABLE — a table with a two-column key**

This table connects students to courses. Neither column is the key by itself. The **pair** is the key, so it gets its own `PRIMARY KEY` line after the columns. Each column also points at a different table, so there are two `FOREIGN KEY` lines.

```sql
-- enrollments: one row = one student in one course
CREATE TABLE enrollments (
    student_id    INTEGER NOT NULL,
    course_id     INTEGER NOT NULL,
    final_grade   TEXT,
    PRIMARY KEY (student_id, course_id),                     -- the key: two columns together
    FOREIGN KEY (student_id) REFERENCES students (student_id),
    FOREIGN KEY (course_id)  REFERENCES courses (course_id)
);
```

Your client's last table (`batting`, `playlist_songs`, or `inventory`) looks like this one.

**INSERT**

List the columns, then the rows. Each row's values go in the same order as the columns.

```sql
INSERT INTO courses (course_id, title, teacher_id) VALUES
    (101, 'Database Applications', 1),   -- comma between rows
    (102, 'Web Design',            2);   -- semicolon after the last row
```

**Data types**

| Type | Holds | Example |
|---|---|---|
| `INTEGER` | Whole numbers | `home_runs`, `level` |
| `REAL` | Decimals | `danceability` (0.602) |
| `TEXT` | Words, codes, dates | `'CLE'`, `'2024-03-14'` |

On the exam you'll also see `INT` (= INTEGER), `DECIMAL(5,2)` / `FLOAT` (= REAL), and `VARCHAR(50)` / `CHAR(3)` (= TEXT).

**Rules (constraints)**

| Rule | Means |
|---|---|
| `PRIMARY KEY` | Identifies each row. Can't repeat. |
| `FOREIGN KEY … REFERENCES` | Value must already exist in the other table. |
| `NOT NULL` | Can't be left empty. |
| `UNIQUE` | No two rows can have the same value. |
| `CHECK (...)` | Value must pass a test. |
| `DEFAULT x` | Use `x` if no value is given. |

---

## CHECK rule ideas

| Kind | Baseball | Music | Game |
|---|---|---|---|
| **Range** | `games BETWEEN 1 AND 162` | `popularity BETWEEN 0 AND 100` | `level BETWEEN 1 AND 60` |
| **Length** | `length(team_id) = 3` | `length(track_id) = 22` | `length(player_username) >= 3` |
| **List** | `bats IN ('L', 'R', 'B')` | `playlist_genre IN (...)` | `item_rarity IN ('Common', 'Uncommon', 'Rare', 'Epic')` |
| **Other** | `CHECK (hits <= at_bats)` on its own line (compares two columns) | `danceability BETWEEN 0 AND 1` | `quantity > 0` |

---

## Common errors

| Error says | Usual cause |
|---|---|
| `near ")": syntax error` | A comma after the last line, right before `)` |
| `near "…": syntax error` | A missing comma between two columns or two rows |
| `table … already exists` | No `DROP TABLE IF EXISTS` lines at the top |
| `no such table` | A foreign key points at a table you haven't created yet. Check the order. |
| `FOREIGN KEY constraint failed` | An insert uses a key that isn't in the parent table yet, or a typo in the key |
| `CHECK constraint failed` | A row breaks one of your CHECK rules. Fix the row or the rule. |
| `table … has N columns but M values were supplied` | A value is missing or extra in one row |

---

## Turn in

Commit and push both files:

- `unit4_lastname.sql` — your script (DROP, CREATE, INSERT)
- `unit4_lastname.db` — your database with all four rows in every table
