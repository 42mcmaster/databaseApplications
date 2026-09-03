# Unit 3d Walkthrough — Design Vocabulary

**Read this first. Then open `unit3d_lastname.md` and do the work.**

---

## What you're doing today

This is the describe-it lesson. Five short topics the state outline names that you need to recognize and explain, but don't need to build. Read each section, then do the matching task for it. The last part is six practice questions where the job is explaining why the wrong answers are wrong.

No database file today.

---

## 1. Four levels of a design

A database design goes through levels, from vague to exact. The outline calls these **levels of data abstraction**.

| Level | What's in it | What it looks like |
|---|---|---|
| **Conceptual** | Entities and relationships only. No columns. | Boxes and lines: "Students take Courses. Teachers teach Courses." |
| **Logical** | Tables, columns, keys, relationships. No data types, no storage details. | The ER diagram you wrote in 3b |
| **Physical** | Data types, indexes, constraints, the actual file and DBMS. | `student_id INTEGER PRIMARY KEY`, an index on `last_name`, a SQLite file |
| **View** | The slice one user or role is allowed to see. | A teacher sees their own gradebook, not the whole school |

Unit 3 lives at conceptual and logical. Unit 4 is physical. Views come back in Unit 5 when we talk about who can see what.

---

## 2. Picking a data model

Unit 1 covered *types of databases*. This is a different question: given a client's situation, which **data model** fits? The outline lists eleven. You need to recognize them and be able to pick one for a client with a reason.

| Model | What it is | Pick it when the client says… |
|---|---|---|
| **Relational** | Tables, keys, joins. Everything in this course. | "Nothing can be out of sync." Strict rules, lots of linked records. |
| **Document** | Each record is a self-contained document (usually JSON); records can have different fields. | "Every product has completely different attributes." |
| **Graph** | Nodes and edges. Relationships are the point. | "Who is connected to whom, several hops out." |
| **Star** (data warehouse) | One big fact table (sales) surrounded by dimension tables (region, month, product). Denormalized on purpose. | "Totals by region by month, ten years of history." |
| **Key-value** | One key, one value. Nothing else. | "Look up one thing by ID, millions of times a second." |
| **Hierarchical** | A tree. Every record has one parent. | Folders on a drive, an org chart, old mainframe systems. |
| **Object-oriented** | Stores program objects as-is, no tables. | "Our app is all objects and we hate writing joins." |
| **Object-relational** | A relational database that also understands objects and custom types. | PostgreSQL is the usual example. |
| **Entity-attribute-value** | One row per (thing, attribute, value) triple. | Sparse data with thousands of possible attributes, like medical records. |
| **Multidimensional** | Data organized as a cube with several dimensions, for analysis. | Spreadsheet-style pivoting over big data (OLAP). |
| **Multivalue** | A field can legally hold a list. The thing 1NF forbids, done on purpose. | Older business systems (Pick, UniVerse). |

The first five are the ones you'll be asked to choose between. The other six you should be able to say one sentence about.

---

## 3. Four kinds of documentation

The outline says a designer produces documentation, and names four kinds.

| Document | What it shows | Who reads it |
|---|---|---|
| **ER diagram** | Entities, keys, relationships | The database designer |
| **Data dictionary** | Every table and column: type, key, required or not, what it means | Everyone who writes queries |
| **Workflow diagram** | The steps a process goes through, start to finish (a flowchart) | The people running the process |
| **UML class diagram** | The program's classes, their fields and methods | The programmers |

You will produce the first two in 3e. Recognize the other two.

A data dictionary is just a table. One row per column, everything anyone would need to know about it:

| Table | Column | Type | Key | Required? | Description |
|---|---|---|---|---|---|
| teams | team_id | INTEGER | PK | yes | Surrogate ID for the team |
| teams | full_name | TEXT | | yes | City plus nickname, e.g. "Cleveland Cavaliers" |
| games | home_team_id | INTEGER | FK → teams | yes | The team playing at home |

---

## 4. Storage types

Every column needs a type. For now you only need the families, not the SQL Server sizes.

| Family | Holds | Examples |
|---|---|---|
| **INTEGER** | Whole numbers | points, quantity, an ID |
| **REAL** | Decimals | price, height in meters, a rating |
| **TEXT** | Characters | names, addresses, anything you'd never do math on |
| **DATE / TIME** | Dates and times | game_date, created_at |
| **BOOLEAN** | True / false | is_active, is_paid |

The one rule that catches people: **if you'd never do math on it, it's TEXT.** Phone numbers and zip codes look like numbers but aren't. A zip code can start with 0 (`03104` becomes `3104` as a number), a phone number has dashes and a country code, and nobody ever adds two of them together.

SQLite is loose about types — it stores dates as TEXT and booleans as 0/1 — but the design decision is the same.

---

## 5. Constraints as design decisions

A **constraint** is a rule the database enforces so bad data can't get in. You'll write them in SQL in Unit 4. Today you just pick the right one.

| Problem | Constraint | What it does |
|---|---|---|
| Two students with the same email | `UNIQUE` | No two rows may have the same value in this column |
| A game saved with no date | `NOT NULL` | The column can't be empty |
| Two rows that are the same team | `PRIMARY KEY` | Unique and not null, and identifies the row |
| A game pointing at team 99, which doesn't exist | `FOREIGN KEY` | The value must exist in the other table |
| A height of −5 | `CHECK` | A custom rule you write: `CHECK (height > 0)` |

Every constraint is a design decision: you're saying *this can never be true in our data*. Get them right in the design and Unit 4 is easy.

---

## 6. Practice items — how to do them

Six multiple-choice questions at the end of the turn-in file. Answer each one, and then **for every wrong option, write one sentence about why it's wrong.**

That second step is the point. Anyone can guess. Knowing what makes the other three answers false is what the exam actually tests.

---

## Now do the work

Open `unit3d_lastname.md`. Five short matching tasks, then the six practice items.
