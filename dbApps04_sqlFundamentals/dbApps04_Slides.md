---
marp: true
theme: default
class: invert
paginate: true
---

# Lesson 04: SQL Fundamentals

## Database Applications Development
### Medina County Career Center

---

<!-- _header: "Sub-Lesson 04a — SELECT, FROM, WHERE" -->

## SQL Query Structure

Every SQL query follows this pattern:

```sql
SELECT columns
FROM table
WHERE condition
```

```python
# Run any SQL query using pandas
import pandas as pd, sqlite3
conn = sqlite3.connect("titanic.db")

pd.read_sql("SELECT name, age FROM passengers WHERE age > 30", conn)
```

Today we learn to ask **specific questions** of our database.

---

<!-- _header: "Sub-Lesson 04a — SELECT, FROM, WHERE" -->

## WHERE with Comparison Operators

`WHERE` filters rows — only rows where the condition is True are returned.

| Operator | Meaning | Example |
|----------|---------|---------|
| `=` | Equal to | `WHERE pclass = 1` |
| `!=` or `<>` | Not equal | `WHERE sex != 'male'` |
| `>` | Greater than | `WHERE age > 30` |
| `<` | Less than | `WHERE fare < 10` |
| `>=` | Greater or equal | `WHERE age >= 18` |
| `<=` | Less or equal | `WHERE pclass <= 2` |

**Note:** Text values use single quotes: `'female'` not `"female"`

> **04a Task:** Basic query exercises — find specific passengers

---

<!-- _header: "Sub-Lesson 04b — AND/OR/NOT, LIKE, BETWEEN, IN" -->

## Combining Conditions: Boolean Logic

**Boolean logic** uses AND, OR, and NOT to combine True/False conditions.

```sql
-- AND: both conditions must be true
SELECT * FROM passengers WHERE sex = 'female' AND survived = 1

-- OR: either condition can be true
SELECT * FROM passengers WHERE pclass = 1 OR pclass = 2

-- NOT: reverses the condition
SELECT * FROM passengers WHERE NOT pclass = 3
```

These are called **logical operators** — you already used `&` and `|` in pandas!

---

<!-- _header: "Sub-Lesson 04b — AND/OR/NOT, LIKE, BETWEEN, IN" -->

## LIKE, BETWEEN, IN

Three powerful shortcuts for common filters:

```sql
-- LIKE: pattern matching (% = any characters)
SELECT * FROM passengers WHERE name LIKE '%Mrs.%'

-- BETWEEN: range of values (inclusive)
SELECT * FROM passengers WHERE age BETWEEN 18 AND 30

-- IN: match any value in a list
SELECT * FROM passengers WHERE embarked IN ('C', 'Q')
```

| Operator | What it does | Without it |
|----------|-------------|------------|
| `LIKE '%Mrs.%'` | Names containing "Mrs." | No simple alternative |
| `BETWEEN 18 AND 30` | Age 18 to 30 | `age >= 18 AND age <= 30` |
| `IN ('C', 'Q')` | Embarked is C or Q | `embarked = 'C' OR embarked = 'Q'` |

> **04b Task:** Multi-condition query challenge

---

<!-- _header: "Sub-Lesson 04c — ORDER BY, LIMIT, Combining All" -->

## ORDER BY and LIMIT

**ORDER BY** sorts your results. **LIMIT** controls how many rows come back.

```sql
-- Sort by age, youngest first (ASC is default)
SELECT name, age FROM passengers ORDER BY age ASC

-- Sort by fare, most expensive first
SELECT name, fare FROM passengers ORDER BY fare DESC

-- Top 10 most expensive tickets
SELECT name, fare FROM passengers ORDER BY fare DESC LIMIT 10
```

---

<!-- _header: "Sub-Lesson 04c — ORDER BY, Combining All Clauses" -->

## Putting It All Together

A full SQL query can combine everything:

```sql
SELECT name, age, fare, survived
FROM passengers
WHERE pclass = 1 AND age >= 18
ORDER BY fare DESC
LIMIT 10
```

**Clause order matters:**
```
SELECT → FROM → WHERE → ORDER BY → LIMIT
```

Think of it as: **What** columns → **Where** from → **Filter** → **Sort** → **How many**

> **04c Task:** Complete dbApps04 DIY Task

---

<!-- _header: "Sub-Lesson 04c — Boolean Logic Vocabulary" -->

## Formal Vocabulary: Boolean Logic

You've been using these concepts — here are their formal names:

| Formal Term | What you already know |
|------------|----------------------|
| **Boolean logic** | Conditions that are True or False |
| **Relational operators** | `=`, `!=`, `>`, `<`, `>=`, `<=` |
| **Logical operators** | `AND`, `OR`, `NOT` |
| **Truth table** | Shows result of combining AND/OR |

| A | B | A AND B | A OR B |
|---|---|---------|--------|
| True | True | True | True |
| True | False | False | True |
| False | True | False | True |
| False | False | False | False |

> **04d:** Unit 2 Quiz + catch-up time
