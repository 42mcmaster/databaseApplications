**Before you start:** rename this file to `unit3d_lastname.md`, using your own last name. Read `unit3d_Walkthrough.md` first. Commit and push when you're done.

**Name:**

---

# Unit 3d — Design Vocabulary

Short tasks. No SQL.

## 1. Levels of abstraction

Four descriptions of the same school database. Match each to its level.

**Choose from:** Conceptual · Logical · Physical · View

| # | Description | Level |
|:-:|---|---|
| 1 | "Students take courses. Teachers teach courses." — boxes and lines, no column names yet | |
| 2 | Tables with column names, keys, and relationships, but no data types picked | |
| 3 | `student_id INTEGER PRIMARY KEY`, an index on `last_name`, stored in a SQLite file | |
| 4 | What a teacher sees when they open their gradebook — only their own students | |

## 2. Pick the data model

For each client, pick the model that fits best and give one reason.

**Choose from:** Relational · Document · Graph · Star (data warehouse) · Key-value

| # | Client says… | Model | One reason |
|:-:|---|---|---|
| 1 | "We run a pharmacy. Every prescription must link to exactly one patient and one doctor, and nothing can ever be out of sync." | | |
| 2 | "Our online store sells 40,000 products and every category has completely different attributes — shoes have sizes, laptops have RAM." | | |
| 3 | "We want to know who is friends with whom, and friends of friends, six hops out." | | |
| 4 | "We keep ten years of sales and only ever ask questions like 'total by region by month.'" | | |
| 5 | "We just need to remember which user is logged in — a session ID and a username, looked up millions of times a second." | | |

**a.** The outline also names hierarchical, object-oriented, entity-attribute-value, multidimensional, and multivalue models. Pick one and write one sentence about what it is.

**Answer:**


## 3. Documentation types

Match each artifact to what it is.

**Choose from:** ER diagram · Data dictionary · Workflow diagram · UML class diagram

| # | Artifact | Type |
|:-:|---|---|
| 1 | A table listing every column, its type, whether it's a key, and what it means | |
| 2 | Boxes for entities, lines with crow's feet between them | |
| 3 | Boxes for `Student` and `Course` classes with their fields and methods, used by the programmers | |
| 4 | A flowchart of what happens from "student requests a schedule change" to "counselor approves" | |

## 4. Storage types

Pick a type family for each column. **Choose from:** INTEGER · REAL · TEXT · DATE/TIME · BOOLEAN

| Column | Type | Why |
|---|---|---|
| `points_scored` | | |
| `ticket_price` | | |
| `phone_number` | | |
| `game_date` | | |
| `is_active` | | |
| `zip_code` | | |

**b.** Two of these look like numbers but shouldn't be stored as numbers. Which two, and why?

**Answer:**


## 5. Constraints as design decisions

Which constraint fixes each problem? **Choose from:** NOT NULL · UNIQUE · PRIMARY KEY · FOREIGN KEY · CHECK (custom)

| # | Problem | Constraint |
|:-:|---|---|
| 1 | Two students got the same email address | |
| 2 | Someone saved a game with no date | |
| 3 | A row in `games` points at a team that doesn't exist | |
| 4 | A player's height was entered as -5 | |
| 5 | Two rows in `teams` are the exact same team | |

## 6. Practice items

Answer each. **Then, for every wrong option, write one sentence explaining why it's wrong.**

---

**1.** A table stores each student's name in every row of their attendance record. When a student changes their name, 180 rows must be edited. This is a(n):

A) Insert anomaly  B) Update anomaly  C) Delete anomaly  D) Referential integrity error

**My answer:**
**Why the others are wrong:**

---

**2.** Which best describes a foreign key?

A) A column that must be unique in its own table
B) A column that references the primary key of another table
C) A key made of two or more columns
D) A key generated automatically by the database

**My answer:**
**Why the others are wrong:**

---

**3.** A table is in 1NF and has a composite primary key. One column depends on only part of that key. Which normal form does it fail?

A) 1NF  B) 2NF  C) 3NF  D) It passes all three

**My answer:**
**Why the others are wrong:**

---

**4.** Students and courses have a many-to-many relationship. The correct fix is:

A) Put a list of course IDs in one column of the student table
B) Add a course column to the student table for each course
C) Create a junction table with student_id and course_id
D) Merge students and courses into one table

**My answer:**
**Why the others are wrong:**

---

**5.** Which level of data abstraction includes data types, indexes, and how the file is stored?

A) Conceptual  B) Logical  C) Physical  D) View

**My answer:**
**Why the others are wrong:**

---

**6.** A reporting database stores the customer's city in the orders table on purpose, so reports don't need a join. This is an example of:

A) A transitive dependency that must be fixed
B) Denormalization for performance
C) A composite key
D) First normal form

**My answer:**
**Why the others are wrong:**

---

## Closing 3d — Vocabulary

| Term | Your definition |
|---|---|
| Conceptual model | |
| Logical model | |
| Physical model | |
| Data dictionary | |
| Constraint | |

**Partner check:** trade files. For your partner's five model choices in Part 2, could you argue the opposite for any of them? Tell them which one.
