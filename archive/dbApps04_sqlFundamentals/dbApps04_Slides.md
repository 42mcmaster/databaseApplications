---
marp: true
theme: default
class: invert
paginate: true
---

# Database Applications Development

## Software Engineering | Medina County Career Center

---

## What We're Learning Today

In Lesson 03, we **created and populated** databases.

Today, we learn the skill that makes databases powerful:

**Asking specific questions** and getting exactly the answers we need.

This is where SQL becomes your superpower!

---

## How SQL Works

Think of a database as a huge library. SQL is how you ask the librarian questions:

- "Show me all mystery books" → `SELECT`
- "Look only in the fiction section" → `FROM`
- "Skip the ones published before 2020" → `WHERE`

Every SQL query has a simple structure:

```sql
SELECT columns_you_want
FROM table_name
WHERE condition
```

---

## Your First Query: The Pattern

```sql
SELECT name, age
FROM passengers
WHERE age > 30
```

**What this does:**
- Pick the `name` and `age` columns
- From the `passengers` table
- Only for people older than 30

Result: A smaller table with just those rows.

---

## Running SQL in Python

```python
import pandas as pd
import sqlite3

conn = sqlite3.connect("titanic.db")
result = pd.read_sql(
    "SELECT name, age FROM passengers WHERE age > 30",
    conn
)
print(result)
```

> **Key Idea:** SQL queries always return a result you can work with in pandas.

---

## Filtering with Comparison Operators

`WHERE` acts like a gatekeeper — it keeps only rows where the condition is True.

| Operator | Meaning | Example |
|----------|---------|---------|
| `=` | Equal to | `WHERE pclass = 1` |
| `!=` | Not equal | `WHERE sex != 'male'` |
| `>` | Greater than | `WHERE age > 30` |
| `<` | Less than | `WHERE fare < 10` |
| `>=` | Greater or equal | `WHERE age >= 18` |
| `<=` | Less or equal | `WHERE pclass <= 2` |

**Pro tip:** Text values use single quotes: `'female'` not `"female"`

---

## Practice: Simple Filters

Write a query to find:

**All first-class passengers:**
```sql
SELECT * FROM passengers WHERE pclass = 1
```

**All female passengers:**
```sql
SELECT * FROM passengers WHERE sex = 'female'
```

**All passengers who paid more than $50:**
```sql
SELECT name, fare FROM passengers WHERE fare > 50
```

---

## Combining Conditions: AND

Use **AND** when **both** conditions must be true:

```sql
SELECT name, sex, age
FROM passengers
WHERE sex = 'female' AND age < 18
```

This finds young girls in the data.

**In your head:** "Give me passengers who are female AND under 18"

---

## Combining Conditions: OR

Use **OR** when **either** condition can be true:

```sql
SELECT name, pclass
FROM passengers
WHERE pclass = 1 OR pclass = 2
```

This finds all first- or second-class passengers.

**In your head:** "Give me passengers in class 1 OR class 2"

---

## Combining Conditions: NOT

Use **NOT** to reverse a condition:

```sql
SELECT name, pclass
FROM passengers
WHERE NOT pclass = 3
```

This finds everyone except third-class passengers. (Same as `pclass != 3`)

---

## Boolean Logic Summary

These logical operators work just like the `&` and `|` you used in pandas:

| Operator | Meaning | Example |
|----------|---------|---------|
| `AND` | Both must be true | `age > 18 AND sex = 'female'` |
| `OR` | Either can be true | `pclass = 1 OR pclass = 2` |
| `NOT` | Reverses the condition | `NOT survived = 1` |

> **Remember:** You can combine multiple conditions. The computer evaluates them left to right.

---

## Pattern Matching: LIKE

Use **LIKE** to search for text patterns. The `%` symbol means "any characters":

```sql
-- Find all names containing "Mrs"
SELECT name FROM passengers WHERE name LIKE '%Mrs%'

-- Find names starting with "Mr"
SELECT name FROM passengers WHERE name LIKE 'Mr%'
```

This is powerful for messy real-world data!

---

## Range Filtering: BETWEEN

Use **BETWEEN** to find values in a range (inclusive):

```sql
SELECT name, age
FROM passengers
WHERE age BETWEEN 18 AND 30
```

This is cleaner than writing: `WHERE age >= 18 AND age <= 30`

---

## List Matching: IN

Use **IN** when you want to match any value in a list:

```sql
SELECT name, embarked
FROM passengers
WHERE embarked IN ('C', 'Q')
```

Much easier than: `WHERE embarked = 'C' OR embarked = 'Q' OR embarked = 'S'`

---

## Three Shortcut Operators

| Operator | Purpose | Example |
|----------|---------|---------|
| `LIKE` | Pattern matching | `name LIKE '%Smith%'` |
| `BETWEEN` | Range of values | `age BETWEEN 20 AND 40` |
| `IN` | Match a list | `port IN ('C', 'Q')` |

> **Tip:** These make your queries easier to read and faster to write.

---

## Sorting Results: ORDER BY

Use **ORDER BY** to arrange your results:

```sql
-- Sort by age, youngest first (ASC = ascending)
SELECT name, age FROM passengers ORDER BY age ASC

-- Sort by age, oldest first (DESC = descending)
SELECT name, age FROM passengers ORDER BY age DESC
```

---

## Limiting Results: LIMIT

Use **LIMIT** to get only the first N rows:

```sql
-- Top 5 most expensive tickets
SELECT name, fare
FROM passengers
ORDER BY fare DESC
LIMIT 5
```

This is useful when you're working with huge datasets!

---

## The Complete Query: All Pieces Together

```sql
SELECT name, age, fare, survived
FROM passengers
WHERE pclass = 1 AND age >= 18
ORDER BY fare DESC
LIMIT 10
```

**Read it like this:**
1. "Give me name, age, fare, and survived"
2. "From the passengers table"
3. "Only rows where pclass = 1 AND age >= 18"
4. "Sort by fare (highest first)"
5. "Show me only the first 10"

---

## The Clause Order Rule

**This order ALWAYS matters in SQL:**

```
SELECT → FROM → WHERE → ORDER BY → LIMIT
```

**What → Where from → Filter → Sort → How many**

If you put them out of order, your query won't work!

---

## Practice: Putting It Together

Find the 5 most expensive tickets bought by female passengers over age 25:

```sql
SELECT name, age, fare
FROM passengers
WHERE sex = 'female' AND age > 25
ORDER BY fare DESC
LIMIT 5
```

**Break it down:**
- What: `name, age, fare`
- Where: `passengers`
- Filter: female AND over 25
- Sort: most expensive first
- Limit: 5 rows

---

## Formal Vocabulary: Boolean Logic

Now you know these concepts — here are their official names:

| Term | Definition |
|------|-----------|
| **Boolean logic** | Conditions that are True or False |
| **Relational operators** | `=`, `!=`, `>`, `<`, `>=`, `<=` |
| **Logical operators** | `AND`, `OR`, `NOT` |
| **Truth table** | Shows what happens when you combine AND/OR |

---

## Truth Table: AND and OR

| A | B | A AND B | A OR B |
|---|---|---------|--------|
| True | True | True | True |
| True | False | False | True |
| False | True | False | True |
| False | False | False | False |

**Key insight:** AND is strict (both must be true), OR is generous (either works).

---

## Key Takeaways

1. **SQL structure is always the same:** SELECT → FROM → WHERE → ORDER BY → LIMIT

2. **Comparison operators** (`=`, `>`, `<`, etc.) filter based on conditions

3. **Boolean logic** (AND, OR, NOT) lets you combine multiple conditions

4. **Shortcut operators** (LIKE, BETWEEN, IN) make filtering easier

5. **ORDER BY and LIMIT** let you sort and control how many rows you get back

---

## Next Steps

You're ready to tackle the **dbApps04 DIY Task!**

This is where you'll write real SQL queries on actual data. Start simple, test often, and build up to the harder challenges.

Let's make databases work for us.
