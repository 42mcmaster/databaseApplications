# dbApps04 Study Guide: SQL Fundamentals

**Course:** Database Applications Development (145085)
**Lesson:** 04 — SQL Fundamentals (SELECT, WHERE, ORDER BY)
**Dataset:** titanic.db (passengers table)

---

## Learning Objectives

After completing this lesson, you should be able to:

1. Write a SELECT query to retrieve specific columns from a table
2. Use WHERE with comparison operators to filter rows
3. Combine conditions using AND, OR, and NOT
4. Use LIKE for pattern matching, BETWEEN for ranges, and IN for lists
5. Sort results with ORDER BY (ASC and DESC)
6. Limit results with LIMIT
7. Combine all clauses in the correct order
8. Define Boolean logic, relational operators, and logical operators by name

---

## Key Vocabulary

| Term | Definition |
|------|-----------|
| **SELECT** | SQL keyword that specifies which columns to return |
| **FROM** | SQL keyword that specifies which table to query |
| **WHERE** | SQL keyword that filters rows based on a condition |
| **ORDER BY** | SQL keyword that sorts results by a column |
| **ASC** | Ascending order (A-Z, 0-9) — the default for ORDER BY |
| **DESC** | Descending order (Z-A, 9-0) |
| **LIMIT** | SQL keyword that restricts how many rows are returned |
| **AND** | Logical operator — both conditions must be True |
| **OR** | Logical operator — at least one condition must be True |
| **NOT** | Logical operator — reverses the condition |
| **LIKE** | SQL operator for pattern matching with wildcards |
| **%** | Wildcard in LIKE — matches any number of characters |
| **BETWEEN** | SQL operator for inclusive range filtering |
| **IN** | SQL operator for matching against a list of values |
| **Boolean Logic** | A system of logic where values are True or False |
| **Relational Operator** | Compares two values: `=`, `!=`, `>`, `<`, `>=`, `<=` |
| **Logical Operator** | Combines conditions: `AND`, `OR`, `NOT` |
| **Truth Table** | A table showing the result of combining True/False values with AND/OR |
| **Clause** | A part of a SQL statement (SELECT clause, WHERE clause, etc.) |
| **Wildcard** | A character that represents one or more unknown characters (`%` in SQL) |

---

## Concept Review

### SELECT and FROM

Every SQL query starts with SELECT (what columns) and FROM (which table). Use `*` for all columns, or list specific column names separated by commas. Column names must match exactly — SQL is not case-sensitive for keywords (SELECT = select) but column names must match the table.

### WHERE and Comparison Operators

WHERE filters rows. Only rows where the condition is True are included in the results. The six comparison (relational) operators are: `=` (equal), `!=` or `<>` (not equal), `>` (greater than), `<` (less than), `>=` (greater or equal), `<=` (less or equal). Text values must be wrapped in single quotes: `WHERE sex = 'female'`.

### Boolean Logic and Logical Operators

Boolean logic is a system where conditions evaluate to True or False. You combine conditions using logical operators: AND (both must be true), OR (at least one must be true), NOT (reverses the result). These are the same concepts you used in pandas with `&`, `|`, and `~`. The formal names — Boolean logic, relational operators, logical operators — are what you'll see on assessments and in the industry.

### LIKE, BETWEEN, IN

LIKE does pattern matching with `%` as a wildcard. `WHERE name LIKE '%Mrs.%'` finds any name containing "Mrs." anywhere. BETWEEN filters an inclusive range: `WHERE age BETWEEN 18 AND 30` includes both 18 and 30. IN matches against a list: `WHERE embarked IN ('C', 'Q')` matches C or Q.

### ORDER BY and LIMIT

ORDER BY sorts results. ASC (ascending, low to high) is the default. DESC (descending, high to low) must be specified. LIMIT restricts the number of rows returned. These always come after WHERE in the query.

### Clause Order

SQL requires clauses in a specific order: `SELECT → FROM → WHERE → ORDER BY → LIMIT`. You don't have to use every clause, but the ones you do use must be in this order.

---

## SQL Quick Reference

### Basic Queries
```sql
SELECT * FROM passengers                         -- All columns, all rows
SELECT name, age FROM passengers                  -- Specific columns
SELECT name, age FROM passengers LIMIT 10         -- First 10 rows
```

### Filtering with WHERE
```sql
SELECT * FROM passengers WHERE pclass = 1         -- First class only
SELECT * FROM passengers WHERE age > 30           -- Older than 30
SELECT * FROM passengers WHERE sex = 'female'     -- Females only
SELECT * FROM passengers WHERE fare >= 50         -- Fare at least 50
```

### Combining Conditions
```sql
-- AND: both must be true
SELECT * FROM passengers WHERE sex = 'female' AND survived = 1

-- OR: either can be true
SELECT * FROM passengers WHERE pclass = 1 OR pclass = 2

-- NOT: reverse the condition
SELECT * FROM passengers WHERE NOT pclass = 3
```

### Pattern Matching and Ranges
```sql
-- LIKE: pattern matching
SELECT * FROM passengers WHERE name LIKE '%Dr.%'
SELECT * FROM passengers WHERE name LIKE 'A%'      -- Names starting with A

-- BETWEEN: inclusive range
SELECT * FROM passengers WHERE age BETWEEN 20 AND 40

-- IN: match from a list
SELECT * FROM passengers WHERE embarked IN ('C', 'Q')
SELECT * FROM passengers WHERE pclass IN (1, 2)
```

### Sorting and Limiting
```sql
-- Sort ascending (default)
SELECT name, age FROM passengers ORDER BY age

-- Sort descending
SELECT name, fare FROM passengers ORDER BY fare DESC

-- Combine everything
SELECT name, age, fare
FROM passengers
WHERE pclass = 1 AND survived = 1
ORDER BY fare DESC
LIMIT 10
```

---

## Boolean Logic Reference

### Relational Operators
| Operator | Meaning | Example |
|----------|---------|---------|
| `=` | Equal to | `age = 30` |
| `!=` or `<>` | Not equal to | `sex != 'male'` |
| `>` | Greater than | `age > 30` |
| `<` | Less than | `fare < 10` |
| `>=` | Greater or equal | `age >= 18` |
| `<=` | Less or equal | `pclass <= 2` |

### Truth Table
| A | B | A AND B | A OR B | NOT A |
|---|---|---------|--------|-------|
| True | True | **True** | **True** | False |
| True | False | False | **True** | False |
| False | True | False | **True** | True |
| False | False | False | False | True |

---

## ODE Competencies Covered

| Competency | Description |
|-----------|-------------|
| 8.5.1 | Write SQL scripts |
| 8.5.3 | Retrieve, filter, sort, and parse data |
| 2.8.6 | Describe SQL |
| 5.3.1 | Boolean logic |
| 5.3.3 | Logical operators (AND, OR, NOT) |
| 5.3.4 | Relational operators |
| 5.3.11 | Access data repositories |
