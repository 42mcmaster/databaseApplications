# Certiport ITS Databases — Student Study Guide

A self-paced review for the Certiport / GMetrix Information Technology Specialist (ITS) Databases certification exam.

---

## How to Use This Guide

This guide is structured as **fourteen short modules**, building from database vocabulary up through SQL queries, schema design, security, and finishing with test-taking strategy. Work through them in order — each module assumes the ones before it.

Every module follows the same rhythm:

1. **Concept** — read the explanation.
2. **Anchor** — a small diagram, table, code snippet, or rule of thumb you should be able to redraw from memory.
3. **Self-check** — exam-style question(s) plus "explain the distractor" practice.

The single most powerful study habit for this exam is **explaining why the wrong answers are wrong**. If you can do that, the right answer takes care of itself.

### What This Exam Tests Most Heavily

Across the three practice exams (128 questions total), the heaviest weight is on:

- **The `SELECT` statement** — clause order, filtering, sorting, grouping.
- **Joins** — inner, outer, cross, self, and set operators (`UNION` / `INTERSECT` / `EXCEPT`).
- **Keys and constraints** — primary, foreign, composite, unique, check.
- **Data modification** — `INSERT`, `UPDATE`, `DELETE` and their syntax traps.
- **Schema objects** — `CREATE` / `ALTER` / `DROP`, views, stored procedures, functions, indexes.

Lighter but reliable: security/permissions and backups (especially in Practice Exam 3), normalization, and data type selection.

---

## Table of Contents

1. [Database Fundamentals and Vocabulary](#module-1--database-fundamentals-and-vocabulary)
2. [The Four SQL Language Categories](#module-2--the-four-sql-language-categories)
3. [The `SELECT` Statement and Clause Order](#module-3--the-select-statement-and-clause-order)
4. [Filtering: `WHERE`, Operators, Wildcards](#module-4--filtering-where-operators-wildcards)
5. [Modifying Data: `INSERT`, `UPDATE`, `DELETE`](#module-5--modifying-data-insert-update-delete)
6. [Aggregate Functions and `GROUP BY`](#module-6--aggregate-functions-and-group-by)
7. [Joins and Set Operators](#module-7--joins-and-set-operators)
8. [Subqueries](#module-8--subqueries)
9. [Keys, Constraints, and Referential Integrity](#module-9--keys-constraints-and-referential-integrity)
10. [Data Types — Choose the Most Economical](#module-10--data-types--choose-the-most-economical)
11. [Schema Objects: Tables, Views, Procedures, Functions, Indexes](#module-11--schema-objects-tables-views-procedures-functions-indexes)
12. [Normalization and Database Design](#module-12--normalization-and-database-design)
13. [Security, Permissions, and Backups](#module-13--security-permissions-and-backups)
14. [Test-Taking Strategy and Final Review](#module-14--test-taking-strategy-and-final-review)
15. [Exam-Day Cheat Card](#exam-day-cheat-card)
16. [Master Glossary](#master-glossary)

---

## Module 1 — Database Fundamentals and Vocabulary

### Concept

Before any SQL question makes sense, you need fluency in the basic relational vocabulary. The exam reuses these words constantly — and many wrong answers swap one for another (e.g., calling a column a "field" or a "record" a "table").

### Anchor: The Building Blocks

```
DATABASE
   └── TABLE (also called an Entity)
          ├── COLUMN  (also called a Field)
          └── ROW     (also called a Record)
                 └── FIELD = one cell in one row
```

| Term       | Plain-English Definition                                                        |
| ---------- | ------------------------------------------------------------------------------- |
| **Table**  | A structure of rows and columns storing data about one subject (one entity).    |
| **Row**    | One instance of the entity (one customer, one order). Also called a *record*.   |
| **Column** | A vertical group of values storing one type of data for every row. Also a *field*. |
| **Field**  | A single cell — one column's value for one row.                                 |
| **Schema** | The structural blueprint: tables, columns, data types, constraints, relationships. |
| **RDBMS**  | Relational Database Management System — uses tables linked by keys.             |
| **SQL**    | Structured Query Language — designed to manage data in an RDBMS; based on relational algebra. |

### Self-Check

> Which term describes the *structural blueprint* of a database — the tables, columns, data types, constraints, and relationships?
> A) Schema
> B) Record
> C) Field
> D) View

**Answer:** A.
**Why the others are wrong:** B is a single row. C is one cell. D is a saved query that *uses* the schema, not the schema itself.

> An RDBMS organizes data into:
> A) Folders and files
> B) Tables linked by keys
> C) Free-form documents
> D) Spreadsheet workbooks

**Answer:** B. Tables + keys = the relational model.

---

## Module 2 — The Four SQL Language Categories

### Concept

Every SQL keyword belongs to one of four categories. The exam loves "which category does this keyword belong to?" questions, plus the related trap of swapping `DROP` / `DELETE` / `TRUNCATE`.

### Anchor: The Four Categories

| Category | Stands For                  | Operates On    | Keywords                              |
| -------- | --------------------------- | -------------- | ------------------------------------- |
| **DDL**  | Data Definition Language    | Structure      | `CREATE`, `ALTER`, `DROP`, `TRUNCATE` |
| **DML**  | Data Manipulation Language  | Data (rows)    | `INSERT`, `UPDATE`, `DELETE`          |
| **DQL**  | Data Query Language         | Reading data   | `SELECT`                              |
| **DCL**  | Data Control Language       | Permissions    | `GRANT`, `REVOKE`, `DENY`             |

Memorize the mnemonic: **DDL changes structure, DML changes data, DQL reads data, DCL controls who can do what.**

### Anchor: `DROP` vs. `DELETE` vs. `TRUNCATE`

This is the single most-tested distinction in this category.

| Keyword     | What It Does                                                  | Affects             |
| ----------- | ------------------------------------------------------------- | ------------------- |
| `DROP`      | Removes the **object itself** (table, view, etc.)             | Schema              |
| `DELETE`    | Removes **rows** (can be filtered with `WHERE`); fully logged | Data                |
| `TRUNCATE`  | Removes **all rows** quickly without per-row logging          | Data (whole table)  |

`DROP` and `TRUNCATE` are DDL (they change structure or do bulk reset operations). `DELETE` is DML.

### Self-Check

> Which keyword removes a table from the database, including its definition?
> A) `DELETE`
> B) `DROP`
> C) `TRUNCATE`
> D) `REVOKE`

**Answer:** B.
**Why the others are wrong:** A removes rows but keeps the table. C empties the table but keeps it. D removes a permission, not data.

> Which category does `GRANT` belong to?
> A) DDL
> B) DML
> C) DQL
> D) DCL

**Answer:** D. Permissions = Data Control Language.

---

## Module 3 — The `SELECT` Statement and Clause Order

### Concept

Most exam questions are anchored on a `SELECT` statement. The clause order is fixed — keywords out of order are syntax errors, and many distractors are intentionally misordered.

### Anchor: Canonical Clause Order

```
SELECT     column_list
FROM       table_or_join
WHERE      row_filter
GROUP BY   grouping_columns
HAVING     group_filter
ORDER BY   sort_columns
```

Memorize this acronym: **S F W G H O** — *"So Few Workers Get Hired Often."*

### Anchor: Rules to Memorize

- **`WHERE` filters rows BEFORE aggregation. `HAVING` filters AFTER aggregation.**
- **`ORDER BY` sorts** results. Default is ascending (`ASC`); use `DESC` for descending.
- **Every non-aggregated column in `SELECT` must also appear in `GROUP BY`.**
- **`GROUP BY` is two words.** `GROUPBY` is a syntax error.
- **`GROUP BY` does not require `HAVING` or `WHERE`.** It can stand alone.
- **`ORDER BY` is NOT allowed inside `CREATE VIEW`.**
- **Use `DISTINCT` (right after `SELECT`)** to return each unique combination once. (`UNIQUE` is a constraint, not a query keyword.)

### Anchor: A Worked Example

```sql
SELECT   Region, COUNT(*) AS NumCustomers
FROM     Customers
WHERE    Active = 1                -- filter rows first
GROUP BY Region                    -- group what's left
HAVING   COUNT(*) > 50             -- filter the groups
ORDER BY NumCustomers DESC;        -- sort the result
```

Reading order: filter individual customers (`WHERE`), group them by region, keep only regions with more than 50 customers (`HAVING`), then sort.

### Self-Check

> Which clause filters **groups** after aggregation has been performed?
> A) `WHERE`
> B) `HAVING`
> C) `GROUP BY`
> D) `ORDER BY`

**Answer:** B.
**Why the others are wrong:** A filters individual rows *before* aggregation. C creates the groups. D sorts the final result.

> Which line contains a syntax error?
>
> ```sql
> SELECT Department, COUNT(*)
> FROM Employees
> WHERE Active = 1
> GROUPBY Department;
> ```
>
> A) The `SELECT` line
> B) The `FROM` line
> C) The `WHERE` line
> D) `GROUPBY` should be `GROUP BY`

**Answer:** D.

---

## Module 4 — Filtering: `WHERE`, Operators, Wildcards

### Concept

The `WHERE` clause uses a small but precise set of comparison and pattern operators. Most filtering questions test one of three things: which operator pairs with which use case, the difference between `=` and `LIKE`, and the proper use of `BETWEEN` and `IN`.

### Anchor: Comparison Operators

| Operator    | Meaning                                                              |
| ----------- | -------------------------------------------------------------------- |
| `=`         | Equal to                                                             |
| `<>`        | **Not equal** (SQL standard — `!=` is from other languages)          |
| `>`, `<`    | Greater than / Less than                                             |
| `>=`, `<=`  | Greater than or equal / Less than or equal                           |
| `IN (...)`  | Matches any value in a list — `state IN ('NV', 'AZ', 'UT')`          |
| `BETWEEN x AND y` | Inclusive range — `Age BETWEEN 18 AND 65`. **Exactly two values.** |
| `LIKE '...'`      | Pattern match using wildcards.                                  |
| `IS NULL` / `IS NOT NULL` | Test for null. **Never use `= NULL`** — that's always false. |

### Anchor: Logical Operators and Negation

```sql
WHERE  (state = 'NV' OR state = 'AZ')
  AND  age >= 21
  AND  active = 1;
```

- **`AND`** — both conditions must be true.
- **`OR`** — at least one must be true.
- **`NOT`** — negates a condition. Goes after `WHERE`/`AND`/`OR`.
- **Parentheses** control precedence — when in doubt, parenthesize.

### Anchor: `LIKE` and Wildcards

```sql
WHERE Name LIKE 'A%'        -- starts with A
WHERE Name LIKE '%son'      -- ends with "son"
WHERE Name LIKE '%an%'      -- contains "an"
WHERE Code LIKE 'B_3'       -- B, then any one character, then 3
```

| Wildcard | Matches                                  |
| -------- | ---------------------------------------- |
| `%`      | Any number of characters (including zero) |
| `_`      | Exactly one character                     |

**Wildcards do not work with `=`** — they only work with `LIKE`. Writing `WHERE Name = 'A%'` looks for a name that literally equals the string `A%`.

### Anchor: String Literals and `DISTINCT`

- **Strings are wrapped in single quotes**: `WHERE State = 'New Mexico'`. Double quotes are for identifiers in some dialects, not values.
- **`DISTINCT`** removes duplicates from the result: `SELECT DISTINCT Department FROM Employees`. It belongs **right after** `SELECT`.

### Self-Check

> Which clause correctly finds all customers whose name starts with the letter S?
> A) `WHERE Name = 'S%'`
> B) `WHERE Name LIKE 'S%'`
> C) `WHERE Name BETWEEN 'S' AND 'T'`
> D) `WHERE Name IN ('S%')`

**Answer:** B.
**Why the others are wrong:** A treats `S%` as a literal string. C is a clumsy approximation that also misses some valid names. D treats `S%` as a literal value in a list.

> Which is the correct SQL "not equal" operator?
> A) `!=`
> B) `==`
> C) `<>`
> D) `=!`

**Answer:** C. `!=` works in some dialects but `<>` is the SQL standard.

---

## Module 5 — Modifying Data: `INSERT`, `UPDATE`, `DELETE`

### Concept

Three statements modify rows. Each has a few classic syntax traps that the exam loves to test.

### Anchor: `INSERT` Patterns

```sql
-- Insert one row
INSERT INTO Customers (FirstName, LastName)
VALUES ('Ada', 'Lovelace');

-- Insert multiple rows (row value constructor)
INSERT INTO Customers (FirstName, LastName)
VALUES ('Ada', 'Lovelace'),
       ('Alan', 'Turing'),
       ('Grace', 'Hopper');

-- Insert from another table (table must already exist)
INSERT INTO ArchivedOrders (OrderID, Total)
SELECT OrderID, Total FROM Orders WHERE OrderDate < '2025-01-01';

-- Create a new table from a query
SELECT OrderID, Total
INTO   ArchivedOrders
FROM   Orders
WHERE  OrderDate < '2025-01-01';
```

Common traps:

- **`INSERT * INTO ...` is invalid syntax.** The `*` does not belong there.
- **`INSERT ... SELECT`** copies into an *existing* table.
- **`SELECT ... INTO`** *creates* a new table from the result.

### Anchor: `UPDATE`

```sql
UPDATE Park
SET    Ticket = Ticket * 1.10            -- raise prices by 10%
WHERE  Region = 'West';
```

- The keyword to filter is **`WHERE`**, never `IF`.
- **Without `WHERE`, every row is updated.** This is the most common UPDATE bug.
- You can use math and existing column values: `SET Ticket = Ticket * 1.10`.

### Anchor: `DELETE`

```sql
DELETE FROM Customers
WHERE  Active = 0;
```

- Removes rows; the table itself stays.
- **Without `WHERE`, every row is deleted.**
- Compare to `TRUNCATE TABLE Customers` — also empties the table, but faster, and not row-by-row logged.
- Compare to `DROP TABLE Customers` — deletes the table itself, schema and all.

### Self-Check

> Which statement increases every product's price by 5%?
> A) `INCREASE Products SET Price = Price + 5%;`
> B) `UPDATE Products SET Price = Price * 1.05;`
> C) `ALTER Products SET Price = Price * 1.05;`
> D) `INSERT Products SET Price = Price * 1.05;`

**Answer:** B.

> Which is the most common bug in a `DELETE` statement?
> A) Using a comma instead of a semicolon
> B) Forgetting the `WHERE` clause and deleting every row
> C) Capitalizing the keyword
> D) Using `DELETE` instead of `DROP`

**Answer:** B.

---

## Module 6 — Aggregate Functions and `GROUP BY`

### Concept

Aggregate functions reduce many rows into one summary value. The trick most students miss is the **`GROUP BY` rule**: every non-aggregated column in the `SELECT` must appear in `GROUP BY`.

### Anchor: The Five Aggregates

| Function     | Returns                                          |
| ------------ | ------------------------------------------------ |
| `COUNT(*)`   | Number of rows                                   |
| `COUNT(col)` | Number of non-null values in that column         |
| `SUM(col)`   | Sum of numeric values                            |
| `AVG(col)`   | Average of numeric values                        |
| `MIN(col)` / `MAX(col)` | Smallest / largest value             |

### Anchor: The `GROUP BY` Rule

```sql
SELECT   Region, Department, COUNT(*) AS Count
FROM     Employees
GROUP BY Region, Department;
```

`Region` and `Department` are non-aggregated → both must appear in `GROUP BY`. Listing only `Region` while still selecting `Department` is a syntax error.

### Anchor: A Common Trap — "Day with the Lowest Calls"

You **cannot** simply write:

```sql
SELECT CallDate, MIN(Calls)
FROM   CallLog;
```

That mixes a non-aggregated column (`CallDate`) with an aggregate, with no `GROUP BY`. To get the day with the fewest calls *and* the count, you typically need a subquery:

```sql
SELECT CallDate, Calls
FROM   CallLog
WHERE  Calls = (SELECT MIN(Calls) FROM CallLog);
```

### Self-Check

> Which query returns the number of orders per customer?
> A) `SELECT CustomerID, COUNT(*) FROM Orders;`
> B) `SELECT CustomerID, COUNT(*) FROM Orders GROUP BY CustomerID;`
> C) `SELECT COUNT(CustomerID) FROM Orders;`
> D) `SELECT CustomerID FROM Orders ORDER BY COUNT(*);`

**Answer:** B.
**Why the others are wrong:** A is missing `GROUP BY` and is a syntax error in standard SQL. C returns one number for the whole table. D doesn't actually return a count per customer.

---

## Module 7 — Joins and Set Operators

### Concept

This is the highest-leverage topic on the exam. Joins combine columns from multiple tables; set operators combine the rows of two query results. You should be able to recognize each type instantly from a small Venn diagram or a written description.

### Anchor: The Join Family (Venn Diagrams)

```
INNER JOIN              LEFT OUTER JOIN
  A ∩ B (overlap only)    All of A + matched B (NULL when no match)

  ●●─────●●               ●●●●●─────●●
   shared rows            all of A
                          plus matches

RIGHT OUTER JOIN        FULL OUTER JOIN
  All of B + matched A    All of A and All of B

  ●●─────●●●●●            ●●●●●─────●●●●●

CROSS JOIN              SELF JOIN
  Cartesian product       A table joined to itself
  every A × every B       (with two aliases)
```

### Anchor: Join Syntax

```sql
-- INNER JOIN: only matching rows
SELECT c.Name, o.Total
FROM   Customers c
JOIN   Orders o ON o.CustomerID = c.CustomerID;

-- LEFT OUTER JOIN: all customers, even those with no orders
SELECT c.Name, o.Total
FROM   Customers c
LEFT OUTER JOIN Orders o ON o.CustomerID = c.CustomerID;

-- CROSS JOIN: every product paired with every store
SELECT p.Product, s.Store
FROM   Products p
CROSS JOIN Stores s;

-- SELF JOIN: each employee with their supervisor
SELECT e.Name AS Employee, m.Name AS Manager
FROM   Employees e
JOIN   Employees m ON m.EmployeeID = e.ReportsTo;
```

When to reach for each:

- **`INNER JOIN`** — you only care about matches.
- **`LEFT OUTER JOIN`** — you want all rows from the "main" table, with optional related data.
- **`CROSS JOIN`** — you want every combination (e.g., an inventory matrix of every product in every store).
- **`SELF JOIN`** — hierarchy or "find rows that relate to other rows in the same table" (employees and supervisors, parts and sub-parts).

### Anchor: Set Operators

Set operators stack the **rows** of two queries with the same column shape.

| Operator      | Returns                                                         |
| ------------- | --------------------------------------------------------------- |
| `UNION`       | All rows from both queries; duplicates **removed**              |
| `UNION ALL`   | All rows from both queries; duplicates **kept**                 |
| `INTERSECT`   | Rows that appear in **both** result sets (deduplicated)         |
| `EXCEPT` / `MINUS` | Rows in the first set that are **not** in the second        |

Worked example: a `UNION` of a 300-row query and a 10-row query that share 2 duplicates → **308 rows**.

### Self-Check

> Which join returns one row for every possible combination of rows from two tables?
> A) `INNER JOIN`
> B) `LEFT OUTER JOIN`
> C) `CROSS JOIN`
> D) `SELF JOIN`

**Answer:** C. Cartesian product = cross join.

> Two queries each return 100 rows. They share 20 duplicate rows. How many rows does `Q1 UNION Q2` return?
> A) 200
> B) 180
> C) 220
> D) 80

**Answer:** B. `UNION` removes duplicates: 100 + 100 − 20 = 180. (`UNION ALL` would give 200.)

---

## Module 8 — Subqueries

### Concept

A subquery is a query nested inside another query — usually in a `WHERE` clause to pre-compute a value or list. The exam tests two related operators in particular: `= ANY` and `= ALL`.

### Anchor: Subquery in `WHERE`

```sql
SELECT Name
FROM   Employees
WHERE  Salary > (SELECT AVG(Salary) FROM Employees);
```

The inner query runs first and returns one number; the outer query uses it.

### Anchor: `ANY` vs. `ALL` vs. `IN`

```sql
WHERE Price = ANY (SELECT Price FROM Competitors)   -- matches AT LEAST ONE
WHERE Price = ALL (SELECT Price FROM Competitors)   -- matches EVERY one
WHERE Price IN  (SELECT Price FROM Competitors)     -- equivalent to = ANY
```

| Operator | Meaning                                                  |
| -------- | -------------------------------------------------------- |
| `= ANY`  | True if the value equals at least one row in the subquery |
| `= ALL`  | True only if the value equals every row in the subquery   |
| `IN`     | Same as `= ANY` for equality lists                        |

**Common bug:** writing `= ALL` when you meant `= ANY`. If the subquery returns more than one distinct value, `= ALL` typically returns zero rows, which looks like a "no results" bug.

### Self-Check

> Which clause finds rows whose price matches **any** price in the `Competitors` table?
> A) `WHERE Price = ALL (SELECT Price FROM Competitors)`
> B) `WHERE Price = ANY (SELECT Price FROM Competitors)`
> C) `WHERE Price > ALL (SELECT Price FROM Competitors)`
> D) `WHERE Price NOT IN (SELECT Price FROM Competitors)`

**Answer:** B (or `IN`, which is equivalent).

---

## Module 9 — Keys, Constraints, and Referential Integrity

### Concept

This is the design-side counterpart to SQL queries. The exam tests both the *concepts* (what each key/constraint guarantees) and the *syntax* (how to declare them).

### Anchor: The Key Family

| Key                     | What It Does                                                                                | Notes                                                               |
| ----------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| **Primary Key (PK)**    | Uniquely identifies each row                                                                | Cannot be NULL; only one PK per table                               |
| **Composite / Compound Key** | A PK made of two or more columns                                                       | Used when no single column is unique (e.g., `(StudentID, ClassID)`) |
| **Foreign Key (FK)**    | A column (or columns) that references another table's PK                                    | Enforces **referential integrity**                                  |
| **Unique Constraint**   | Enforces uniqueness on a column                                                             | Like a PK but allows NULL and isn't the table's main identifier     |

### Anchor: Referential Integrity Rules

- **You can't insert an FK value that doesn't exist** in the parent table's PK column.
- **A NULL FK** means the row simply has no relationship to a parent.
- **Cascade Delete** — when a parent row is deleted, child rows referencing it are automatically deleted too.
- **A table containing only an FK cannot serve as a PK** by itself — uniqueness isn't guaranteed.

### Anchor: The Six Constraints

| Constraint     | What It Enforces                                            |
| -------------- | ----------------------------------------------------------- |
| `NOT NULL`     | Value is required                                           |
| `UNIQUE`       | No duplicate values                                         |
| `PRIMARY KEY`  | NOT NULL + UNIQUE + table identifier                        |
| `FOREIGN KEY`  | References a PK in another table                            |
| `CHECK`        | Restricts allowed values — `CHECK (Quantity >= 1)`          |
| `DEFAULT`      | Supplies a default value if none is provided                |

### Anchor: Composite Key Syntax

```sql
CREATE TABLE Signups (
   StudentID  INT NOT NULL,
   ClassID    INT NOT NULL,
   SignupDate DATETIME,
   PRIMARY KEY (StudentID, ClassID)
);
```

Neither column alone is unique — a student can be in many classes, a class has many students — but the *pair* is unique.

### Self-Check

> Which best describes a Primary Key?
> A) Any column that contains unique values.
> B) A column or set of columns that uniquely identifies each row, cannot be NULL, and serves as the table's main identifier.
> C) A column referencing a column in another table.
> D) A constraint that allows duplicates.

**Answer:** B.
**Why the others are wrong:** A describes a unique constraint (which still allows NULL). C describes a foreign key. D contradicts the definition.

> A `Signups` table needs to record that a student is enrolled in a class. Neither `StudentID` nor `ClassID` is unique on its own, but each pair should appear only once. The right design is:
> A) `StudentID` as PK, `ClassID` as FK
> B) `ClassID` as PK, `StudentID` as FK
> C) A composite primary key on `(StudentID, ClassID)`
> D) No primary key

**Answer:** C.

---

## Module 10 — Data Types — Choose the Most Economical

### Concept

The exam regularly asks you to pick the most efficient data type for a column. The principle: **pick the smallest type that comfortably fits the actual range of values.** Smaller types use less storage and produce faster queries and smaller indexes.

### Anchor: Integer Types

| Type        | Storage | Range                                  | Use For                          |
| ----------- | ------- | -------------------------------------- | -------------------------------- |
| `TINYINT`   | 1 byte  | 0 to 255                               | Ratings 1–100, small enums       |
| `SMALLINT`  | 2 bytes | −32,768 to 32,767                      | Quantities up to ~32k (e.g., 0–1024) |
| `INT`       | 4 bytes | ~ ±2.1 billion                         | General-purpose IDs              |
| `BIGINT`    | 8 bytes | ~ ±9.2 quintillion                     | Very large counts / IDs          |

### Anchor: String Types

| Type           | Stored As                       | Use For                                  |
| -------------- | ------------------------------- | ---------------------------------------- |
| `CHAR(n)`      | **Fixed length**, max 8,000     | Codes that are always the same length (e.g., state code `CHAR(2)`) |
| `VARCHAR(n)`   | **Variable length** up to *n*   | Names, descriptions where length varies  |
| `TEXT`         | Large variable-length string    | Long-form content. Not fixed-length.     |

### Anchor: Date/Time Types

| Type             | Format                             |
| ---------------- | ---------------------------------- |
| `DATE`           | `YYYY-MM-DD`                       |
| `DATETIME`       | `YYYY-MM-DD HH:MI:SS`              |
| `SMALLDATETIME`  | `YYYY-MM-DD HH:MI:SS` (smaller range, less precision) |
| `TIMESTAMP`      | A unique time-based number         |

### Anchor: Boolean Substitute

SQL Server doesn't have a native Boolean — use **`BIT`**, which stores `0` or `1`.

### Why It Matters

Choosing the right data type:

- **Saves storage** — a `TINYINT` is 4× smaller than an `INT`.
- **Improves performance** — smaller rows mean more rows per page, less I/O.
- **Enforces integrity** — only valid values can be stored. A `DATE` column can't hold "Tuesday."

### Self-Check

> A column will store satisfaction ratings from 1 to 100. Which is the most economical data type?
> A) `BIGINT`
> B) `INT`
> C) `SMALLINT`
> D) `TINYINT`

**Answer:** D. `TINYINT` (0–255) easily covers 1–100 and uses the least storage.

> Which type would you use for a column that holds first names, where the length varies?
> A) `CHAR(50)`
> B) `VARCHAR(50)`
> C) `INT`
> D) `BIT`

**Answer:** B. Variable length names → `VARCHAR`. `CHAR(50)` would pad short names with spaces.

---

## Module 11 — Schema Objects: Tables, Views, Procedures, Functions, Indexes

### Concept

Beyond raw `SELECT` queries, the exam expects you to know how to **create**, **modify**, and **drop** the major database objects — and to know the difference between a view, a stored procedure, and a function.

### Anchor: `CREATE TABLE` Patterns

```sql
-- Basic table with PK
CREATE TABLE Member (
   Id   INT NOT NULL PRIMARY KEY,
   Name VARCHAR(50)
);

-- Foreign key
CREATE TABLE OrderDetails (
   OrderDetailID INT PRIMARY KEY,
   OrderID INT FOREIGN KEY REFERENCES Orders(OrderID)
);
```

### Anchor: `ALTER TABLE`

You can:

- Add a new column
- Drop one or multiple columns
- Modify the data type of an existing column
- Add or drop a constraint

You **cannot** change a column's `IDENTITY` specification with `ALTER COLUMN`.

```sql
ALTER TABLE Customers ADD MiddleName VARCHAR(40);
ALTER TABLE Customers DROP COLUMN OldField;
ALTER TABLE Customers ALTER COLUMN PhoneNumber VARCHAR(20);
ALTER TABLE Customers ADD CONSTRAINT CK_Age CHECK (Age >= 0);
```

### Anchor: Views

A **view** is a saved `SELECT` query that behaves like a virtual table.

```sql
CREATE VIEW vw_UtahCustomers AS
SELECT CustomerID, Name, City
FROM   Customers
WHERE  State = 'UT';
```

Then query it like a table: `SELECT * FROM vw_UtahCustomers;`.

Rules:

- Built with **`CREATE VIEW name AS SELECT …`**.
- **`ORDER BY` is not allowed** inside a `CREATE VIEW`.
- Modify with **`ALTER VIEW`** — not `ADD COLUMN`.
- Remove with **`DROP VIEW vw_name;`** — does not delete the underlying data.
- **Object names cannot contain spaces** — `vw UtahCustomers` is a syntax error.
- Views can join multiple tables and are commonly used to **limit what users see** (security).

### Anchor: Stored Procedures vs. Functions

| Stored Procedure                                         | Function                                            |
| -------------------------------------------------------- | --------------------------------------------------- |
| Pre-compiled (compiled once, reused)                     | Compiled every call                                 |
| May or may not return a value                            | **Must** return a value (scalar or table)           |
| Can have INPUT and OUTPUT parameters                     | Returns one value or one table                      |
| Called via `EXEC procname @param = value`                | Used inline in `SELECT`, `WHERE`, `CASE`, `JOIN`    |

```sql
CREATE PROCEDURE GetCustomerCount @Region VARCHAR(50), @Total INT OUTPUT
AS
BEGIN
   SET NOCOUNT ON;          -- suppress "(N rows affected)" messages
   SELECT @Total = COUNT(*)
   FROM   Customers
   WHERE  Region = @Region;
END;
```

Stored procedure benefits: **speed** (precompiled), **code reuse**, **security** (grant `EXEC` instead of direct table access), and **reduced network traffic**.

### Anchor: Indexes

An index speeds up data retrieval at a small cost to writes.

```sql
CREATE INDEX idx_Customers_LastName
ON Customers (LastName);
```

| Index Type        | Behavior                                                                                | Limit                                  |
| ----------------- | --------------------------------------------------------------------------------------- | -------------------------------------- |
| **Clustered**     | Sorts the actual data rows on disk by the indexed column                                | **One per table** (data sorts once)    |
| **Non-Clustered** | Stored separately and points to the data rows                                           | Many allowed per table                 |

Use a clustered index for columns frequently used in **range queries** (`BETWEEN`, `>`, `<`), large result sets, and columns with many distinct values.

### Self-Check

> Which is **not** allowed inside a `CREATE VIEW` statement?
> A) A `JOIN` between two tables
> B) A `WHERE` clause
> C) An `ORDER BY` clause
> D) A `GROUP BY` clause

**Answer:** C.

> Which best describes a **clustered** index?
> A) A separate structure that points to the data; many allowed per table
> B) The actual data rows physically sorted by the indexed column; only one per table
> C) An index on a foreign key
> D) A constraint enforcing uniqueness

**Answer:** B.

---

## Module 12 — Normalization and Database Design

### Concept

Normalization is the process of reducing **redundancy** and **dependencies** in a database. It typically *increases* the number of tables (because data gets split out) and is **not** about correcting data errors or reducing the number of tables.

### Anchor: The Normal Forms

| Form            | Requirement                                                                                                              |
| --------------- | ------------------------------------------------------------------------------------------------------------------------ |
| **1NF**         | No repeating groups; every cell is a single atomic value.                                                                |
| **2NF**         | Already 1NF; every non-prime attribute fully depends on the **whole** primary key (matters when PK is composite).        |
| **3NF**         | Already 2NF; **no transitive dependencies** — every non-key column depends *only* on the PK, not on another non-key column. |
| **BCNF (3.5NF)**, 4NF, 5NF | Stricter forms beyond 3NF. Five normal forms total.                                                           |

### Anchor: A 3NF Violation Example

An `Events` table that stores `EventID`, `Winner`, and `Birthdate` violates 3NF: `Birthdate` depends on `Winner`, not on `EventID`. Fix: move `Birthdate` to a separate `Winners` table keyed by `Winner`. The `Events` table then keeps only `Winner` as a foreign key.

### Anchor: Relationships and Diagrams

| Relationship    | Example                                          | Implementation                                |
| --------------- | ------------------------------------------------ | --------------------------------------------- |
| **One-to-One**  | One person ↔ one passport                       | Either side's PK can be the FK on the other   |
| **One-to-Many** | One customer → many orders                      | FK on the "many" side                         |
| **Many-to-Many**| Students ↔ classes                              | Junction / linking table holding two FKs      |

A many-to-many between `Customers` and `Accounts` is implemented through a `CustomerAccount` table holding `CustomerID` and `AccountID`. An **ER (Entity-Relationship) diagram** visualizes entities, attributes, keys, and relationships.

### Self-Check

> Normalization primarily aims to:
> A) Reduce the number of tables in the database.
> B) Reduce data redundancy and dependencies.
> C) Correct typos and bad data values.
> D) Increase the number of indexes.

**Answer:** B.
**Why the others are wrong:** A is the opposite — normalization usually *adds* tables. C is data cleansing, not normalization. D is unrelated.

> Which relationship requires a junction table?
> A) One-to-one
> B) One-to-many
> C) Many-to-many
> D) None — every relationship is implemented with a single FK

**Answer:** C.

---

## Module 13 — Security, Permissions, and Backups

### Concept

The administration cluster shows up most prominently on Practice Exam 3. You don't need deep DBA expertise — you need fluency in three things: the DCL keywords (`GRANT`, `REVOKE`, `DENY`), the principle of least privilege and the major fixed server roles, and the three backup types.

### Anchor: DCL Permission Commands

```sql
GRANT  SELECT ON Customers TO Sales;
GRANT  SELECT ON Customers TO Sales WITH GRANT OPTION;  -- recipient can re-grant
REVOKE SELECT ON Customers FROM Sales;
DENY   SELECT ON Customers TO Sales;                    -- explicit block; overrides GRANT
```

- **`GRANT`** — gives a permission.
- **`WITH GRANT OPTION`** — lets the recipient grant the same permission to others.
- **`REVOKE`** — removes a previously granted permission.
- **`DENY`** — explicitly forbids access. **`DENY` overrides `GRANT`.**

### Anchor: The Principle of Least Privilege

> Users should receive only the permissions necessary to do their job — no more.

This is *the* security principle the exam expects you to recognize. Granting "everyone is sysadmin" is the wrong answer every single time.

### Anchor: Logins, Users, and Fixed Server Roles

- **Logins** — server-level identities. SQL Server logins or Windows logins. Membership in a Windows group can also identify server-level security.
- **Users** — database-level identities, mapped from logins.
- **`DROP LOGIN`** removes a SQL Server login.

| Fixed Server Role | What It Can Do                                                |
| ----------------- | ------------------------------------------------------------- |
| **sysadmin**      | Full control of the server                                    |
| **serveradmin**   | Server-wide settings; can issue **SHUTDOWN**                  |
| **bulkadmin**     | Bulk insert operations                                        |
| **dbcreator**     | Create / alter / drop / restore databases                     |
| **diskadmin**     | Manage disk files                                             |
| **setupadmin**    | Configure linked servers                                      |

### Anchor: Common Attacks

- **SQL Injection** — an attack that exploits unsanitized user input passed to SQL, altering or extending the query maliciously. Prevent with **parameterized queries / prepared statements** and input validation.
- **Brute-force / dictionary attacks** — trying many passwords, often from a wordlist of common passwords.
- Use **views and stored procedures as permission boundaries** — grant `EXEC` on a procedure rather than direct access to the underlying tables.

### Anchor: Backup Types

```
FULL          → entire database; biggest and slowest
DIFFERENTIAL  → everything changed since the last FULL backup
INCREMENTAL   → everything changed since the last backup of any kind; smallest and fastest
```

```sql
BACKUP  DATABASE Sales TO   DISK = 'C:\backups\sales.bak';
RESTORE DATABASE Sales FROM DISK = 'C:\backups\sales.bak';
```

Common causes of data loss the exam likes to mention: **physical media failure** (hard-drive death is very common), **human error**, **malware**, and **theft**. The exam favors strategies that combine regular backups with **offsite or cloud copies**.

### Self-Check

> Which command **explicitly forbids** access, overriding any matching `GRANT`?
> A) `REVOKE`
> B) `DROP`
> C) `DENY`
> D) `GRANT WITH GRANT OPTION`

**Answer:** C. `REVOKE` removes a grant; `DENY` blocks access outright.

> Which backup type captures only the changes since the **last full** backup?
> A) Full
> B) Differential
> C) Incremental
> D) Snapshot

**Answer:** B.
**Why the others are wrong:** A captures everything. C captures changes since the last backup of any kind (smallest of the three). D isn't one of the three options the exam tests here.

---

## Module 14 — Test-Taking Strategy and Final Review

### The Distractor-Autopsy Method

For every practice question, do this:

1. Pick your answer.
2. **For each *wrong* option, write one sentence explaining why it is wrong.**
3. Only then check the answer key.

If you can articulate why every distractor is wrong, you have actually mastered the concept. If you can't, that's where to study next.

### Reading SQL Under Time Pressure

When a query appears, before reading the answer choices:

1. Identify the **statement type** — `SELECT`, `INSERT`, `UPDATE`, `DELETE`, `CREATE`, `ALTER`, `DROP`, `GRANT`.
2. Find the **clause order** — `SELECT`, `FROM`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`. Anything out of order is a syntax error.
3. Spot **misspellings of two-word keywords** — `GROUPBY`, `ORDERBY` are red flags.
4. Verify any **`GROUP BY`** lists every non-aggregated `SELECT` column.
5. Note any **`WHERE` clauses missing from `UPDATE` / `DELETE`** — that's almost always the trap.

### Common Syntax Pitfalls (Drill These)

The exam loves spot-the-error questions. Memorize these traps:

1. `IF` instead of `WHERE` in `UPDATE` / `DELETE`.
2. `GROUPBY` instead of `GROUP BY` (or `ORDERBY` instead of `ORDER BY`).
3. `ORDER BY` inside a `CREATE VIEW`.
4. Missing column from `GROUP BY` when `SELECT` lists non-aggregated columns.
5. `DELETE` used to drop an object (should be `DROP`).
6. `INSERT * INTO …` — `*` does not belong there.
7. Wildcards (`%`, `_`) used with `=` instead of `LIKE`.
8. `BETWEEN` chained with another range expression.
9. Object names with spaces (e.g., `vw UtahCustomers`).
10. `= ALL` used where `= ANY` was intended in subqueries.
11. `= NULL` instead of `IS NULL`.
12. `!=` instead of `<>` (works in some dialects but `<>` is the SQL standard).

### One Sentence to Repeat During the Exam

Pick one of these and repeat it under your breath whenever you get stuck:

- *"`WHERE` filters rows; `HAVING` filters groups."*
- *"`DROP` removes the object; `DELETE` removes rows; `TRUNCATE` empties the table."*
- *"Every non-aggregated column in `SELECT` belongs in `GROUP BY`."*
- *"PK = unique + not null + table identifier."*
- *"Pick the smallest data type that fits."*
- *"`DENY` overrides `GRANT`."*

### Mock Quiz (12 Questions Across the Whole Exam)

Try these timed — about 90 seconds per question.

1. Which keyword removes a table from the database, including its definition?
2. Which clause filters groups *after* aggregation?
3. Which operator is the SQL standard "not equal"?
4. Which clause correctly finds names starting with "S"?
5. Without a `WHERE` clause, what happens when you run an `UPDATE`?
6. Which join returns every combination of rows from two tables?
7. Two queries return 100 rows each and share 20 duplicates. How many rows does `UNION` return?
8. Which constraint is implied by a `PRIMARY KEY`?
9. Which data type is most economical for ratings 1–100?
10. Which is **not** allowed inside a `CREATE VIEW`?
11. Which command explicitly forbids access, overriding any `GRANT`?
12. Which backup type captures everything that changed since the last *full* backup?

#### Answer Key (cover until done)

1. **`DROP`** — Module 2.
2. **`HAVING`** — Module 3.
3. **`<>`** — Module 4.
4. **`WHERE Name LIKE 'S%'`** — Module 4.
5. **Every row in the table is updated.** — Module 5.
6. **`CROSS JOIN`** — Module 7.
7. **180** (100 + 100 − 20). — Module 7.
8. **`NOT NULL` + `UNIQUE`**, plus the role of table identifier. — Modules 9, 10.
9. **`TINYINT`** (0–255). — Module 10.
10. **`ORDER BY`** — Module 11.
11. **`DENY`** — Module 13.
12. **Differential** — Module 13.

---

## Exam-Day Cheat Card

Read this on the morning of the exam. It's the whole guide compressed into a single paragraph:

> A **table** has rows (records) and columns (fields); a **schema** is the structural blueprint. SQL has four categories: **DDL** (`CREATE`/`ALTER`/`DROP`/`TRUNCATE`) changes structure, **DML** (`INSERT`/`UPDATE`/`DELETE`) changes data, **DQL** (`SELECT`) reads data, **DCL** (`GRANT`/`REVOKE`/`DENY`) controls permissions. `DROP` removes the object; `DELETE` removes rows; `TRUNCATE` empties the table fast. Clause order: `SELECT FROM WHERE GROUP BY HAVING ORDER BY` — `WHERE` filters rows before aggregation, `HAVING` filters groups after, `ORDER BY` sorts (default ASC), and `ORDER BY` is forbidden inside `CREATE VIEW`. Every non-aggregated `SELECT` column must appear in `GROUP BY`. The SQL "not equal" is `<>`. Strings use single quotes; `IS NULL`, never `= NULL`. `LIKE` with `%` (any chars) and `_` (one char); wildcards don't work with `=`. `BETWEEN x AND y` takes exactly two values. `IN (...)`, `=ANY` matches at least one; `=ALL` matches every row in a subquery. `INSERT INTO ... VALUES (...)` for one or many rows; `INSERT INTO ... SELECT` copies into an existing table; `SELECT ... INTO` creates a new table. `UPDATE` and `DELETE` without `WHERE` affect every row. Aggregates: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`. Joins: `INNER` returns matches; `LEFT/RIGHT/FULL OUTER` includes unmatched rows; `CROSS` is the Cartesian product; `SELF` joins a table to itself with two aliases. `UNION` removes duplicates, `UNION ALL` keeps them; `INTERSECT` is overlap; `EXCEPT/MINUS` is set difference. PK = unique + not null + main identifier (only one per table). Composite PK uses two or more columns. FK enforces referential integrity. Constraints: `NOT NULL`, `UNIQUE`, `PRIMARY KEY`, `FOREIGN KEY`, `CHECK`, `DEFAULT`. Pick the smallest data type that fits: `TINYINT` (0–255), `SMALLINT`, `INT`, `BIGINT`; `CHAR(n)` for fixed length, `VARCHAR(n)` for variable; `BIT` is the boolean substitute. `ALTER TABLE` can add/drop columns or change types; can't change `IDENTITY`. Views are saved `SELECT` queries — built with `CREATE VIEW`, modified with `ALTER VIEW`, dropped with `DROP VIEW`; no `ORDER BY`, no spaces in names. Stored procedures are pre-compiled, may or may not return values, called with `EXEC`; functions must return a value and can be used inline in `SELECT`/`WHERE`/`JOIN`. `SET NOCOUNT ON` hides "(N rows affected)" messages. Indexes speed reads; clustered indexes physically sort the data and there's only one per table; non-clustered indexes are separate structures and you can have many. Normalization reduces redundancy and dependencies; 1NF (atomic), 2NF (full dependence on full PK), 3NF (no transitive dependencies). Many-to-many needs a junction table. Permissions: `GRANT` allows, `REVOKE` removes, `DENY` blocks (and overrides `GRANT`). Apply the principle of least privilege. Fixed roles: sysadmin (full), serveradmin (shutdown), bulkadmin, dbcreator, diskadmin, setupadmin. Prevent SQL injection with parameterized queries. Backups: full (everything), differential (changes since last full), incremental (changes since last backup of any kind, smallest).

---

## Master Glossary

**Aggregate Function** — a function (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`) that reduces many rows to one summary value.

**`ALTER TABLE`** — DDL statement to add, drop, or modify columns and constraints on an existing table.

**`ANY` / `ALL`** — subquery operators: `ANY` matches at least one returned row; `ALL` requires matching every row.

**Backup (Full / Differential / Incremental)** — full = whole DB; differential = changes since last full; incremental = changes since last backup of any kind.

**`BETWEEN`** — inclusive range filter taking exactly two endpoints.

**`BIT`** — 0/1 data type used as a boolean substitute.

**`CHECK` Constraint** — restricts allowed values in a column (e.g., `CHECK (Quantity >= 1)`).

**Clustered Index** — index that physically sorts the data rows; only one allowed per table.

**Collation** — rules for how text is sorted and compared (alphabetical order, case sensitivity, accent sensitivity).

**Composite (Compound) Key** — a primary key made of two or more columns.

**Constraint** — a rule enforced on column values (e.g., `NOT NULL`, `UNIQUE`, `PRIMARY KEY`, `FOREIGN KEY`, `CHECK`, `DEFAULT`).

**`CREATE VIEW`** — defines a saved `SELECT` query; cannot include `ORDER BY`.

**Cross Join** — Cartesian product of two tables.

**DCL (Data Control Language)** — `GRANT`, `REVOKE`, `DENY`.

**DDL (Data Definition Language)** — `CREATE`, `ALTER`, `DROP`, `TRUNCATE`.

**`DELETE`** — DML statement removing rows; without `WHERE`, removes every row.

**`DENY`** — permission command that explicitly forbids access; overrides `GRANT`.

**Differential Backup** — captures everything changed since the last full backup.

**`DISTINCT`** — keyword right after `SELECT` that returns each unique combination once.

**DML (Data Manipulation Language)** — `INSERT`, `UPDATE`, `DELETE`.

**DQL (Data Query Language)** — `SELECT`.

**`DROP`** — DDL statement that removes an object (table, view, etc.) entirely.

**ER Diagram** — entity-relationship diagram showing tables, attributes, keys, and relationships.

**`EXCEPT` / `MINUS`** — set operator returning rows in the first query that aren't in the second.

**Field** — a single cell in a row (one column's value for one row).

**Foreign Key (FK)** — column(s) referencing the primary key of another table; enforces referential integrity.

**Function (User-Defined)** — must return a value; can be used inline in `SELECT`, `WHERE`, `CASE`, or `JOIN`.

**`GRANT`** — DCL command that gives a permission. With `WITH GRANT OPTION`, the recipient can re-grant it.

**`GROUP BY`** — clause that groups rows for aggregation. Must include every non-aggregated `SELECT` column.

**`HAVING`** — filters groups after aggregation; counterpart to `WHERE` (which filters rows before).

**Incremental Backup** — captures everything changed since the last backup of any kind.

**Index** — auxiliary structure that speeds up reads; can be clustered or non-clustered.

**Inner Join** — returns only rows that match in both tables.

**`INSERT`** — DML statement that adds rows.

**`INTERSECT`** — set operator returning rows that appear in both result sets.

**Junction Table (Linking Table)** — a table holding two foreign keys to implement a many-to-many relationship.

**`LIKE`** — pattern-matching operator using `%` (any characters) and `_` (one character).

**Login** — server-level identity (SQL Server or Windows); contrast with database-level user.

**Many-to-Many** — relationship implemented through a junction table.

**Non-Clustered Index** — separate structure pointing to data rows; multiple allowed per table.

**Normalization** — process of reducing redundancy and dependencies. 1NF (atomic) → 2NF (full PK dependence) → 3NF (no transitive dependence).

**`NOT NULL`** — constraint requiring a value.

**One-to-Many** — most common relationship; FK lives on the "many" side.

**Primary Key (PK)** — column(s) uniquely identifying each row; not nullable; one per table.

**Principle of Least Privilege** — users get only the permissions necessary for their job.

**RDBMS** — Relational Database Management System.

**Record** — one row in a table.

**Referential Integrity** — rule that an FK value must exist in the referenced PK column or be NULL.

**`REVOKE`** — removes a previously granted permission.

**Schema** — the structural definition of a database.

**Self Join** — joining a table to itself using two aliases (used for hierarchies).

**Set Operator** — `UNION`, `UNION ALL`, `INTERSECT`, `EXCEPT` / `MINUS` — combine query result rows.

**`SET NOCOUNT ON`** — suppresses the "(N rows affected)" messages inside a stored procedure.

**SQL Injection** — attack exploiting unsanitized user input passed into SQL; prevented by parameterized queries.

**Stored Procedure** — pre-compiled routine, may or may not return a value, called with `EXEC`.

**Subquery** — a query nested inside another query, often in the `WHERE` clause.

**`TRUNCATE`** — DDL statement that empties a table quickly without per-row logging.

**`UNION` / `UNION ALL`** — `UNION` removes duplicates; `UNION ALL` keeps them.

**`UNIQUE` Constraint** — enforces uniqueness; allows NULL; not the table's main identifier.

**`UPDATE`** — DML statement that modifies existing rows; without `WHERE`, modifies every row.

**`VARCHAR(n)`** — variable-length string up to *n* characters.

**View** — saved `SELECT` query that behaves like a virtual table; built with `CREATE VIEW`, modified with `ALTER VIEW`, dropped with `DROP VIEW`.

**`WHERE`** — filters rows before aggregation; required for selective `UPDATE` and `DELETE`.
