# SQL Reference Guide
## Quick Reference for SQLite Commands

**Database Applications Development | Medina County Career Center**

---

## Table of Contents

1. [Basic Query Structure](#basic-query-structure)
2. [SELECT - Choosing Columns](#select---choosing-columns)
3. [WHERE - Filtering Rows](#where---filtering-rows)
4. [Comparison Operators](#comparison-operators)
5. [Logical Operators (AND, OR)](#logical-operators-and-or)
6. [ORDER BY - Sorting](#order-by---sorting)
7. [LIMIT - Controlling Results](#limit---controlling-results)
8. [Common Patterns](#common-patterns)
9. [pandas → SQL Cheat Sheet](#pandas--sql-cheat-sheet)
10. [Troubleshooting](#troubleshooting)

---

## Basic Query Structure

```sql
SELECT column1, column2, column3
FROM table_name
WHERE condition
ORDER BY column
LIMIT number;
```

**Order is IMPORTANT!** Always use this sequence:
1. SELECT (what to show)
2. FROM (which table)
3. WHERE (filter rows) - optional
4. ORDER BY (sort results) - optional
5. LIMIT (limit rows) - optional

---

## SELECT - Choosing Columns

### Select All Columns

```sql
SELECT * FROM passengers;
```
- `*` means "all columns"

### Select Specific Columns

```sql
-- One column
SELECT Name FROM passengers;

-- Multiple columns (use commas)
SELECT Name, Age, Sex FROM passengers;

-- Many columns
SELECT PassengerId, Name, Age, Sex, Pclass, Survived 
FROM passengers;
```

**Remember:**
- ✅ Separate columns with commas
- ✅ No comma after the last column
- ✅ Column names are case-sensitive

---

## WHERE - Filtering Rows

### Basic Filtering

```sql
-- Numbers (no quotes)
SELECT * FROM passengers WHERE Age > 30;
SELECT * FROM passengers WHERE Fare <= 10;
SELECT * FROM passengers WHERE Pclass = 1;

-- Text (needs single quotes!)
SELECT * FROM passengers WHERE Sex = 'male';
SELECT * FROM passengers WHERE Name = 'Smith, Mr. James';
```

**Critical:** Text values MUST be in single quotes!
- ✅ `WHERE Sex = 'male'`
- ❌ `WHERE Sex = male` (Error!)

---

## Comparison Operators

| Operator | Meaning | Example |
|----------|---------|---------|
| `=` | Equal to | `WHERE Age = 25` |
| `!=` or `<>` | Not equal to | `WHERE Sex != 'male'` |
| `>` | Greater than | `WHERE Fare > 50` |
| `<` | Less than | `WHERE Age < 18` |
| `>=` | Greater than or equal | `WHERE Age >= 18` |
| `<=` | Less than or equal | `WHERE Age <= 12` |

**Note:** In SQL, use `=` (not `==`) for comparison!

---

## Logical Operators (AND, OR)

### AND - Both conditions must be true

```sql
-- Adults only (age >= 18)
SELECT Name, Age FROM passengers 
WHERE Age >= 18 AND Sex = 'female';

-- First class survivors
SELECT Name FROM passengers 
WHERE Pclass = 1 AND Survived = 1;

-- Three conditions
SELECT Name FROM passengers 
WHERE Age < 18 AND Sex = 'male' AND Survived = 1;
```

### OR - At least one condition must be true

```sql
-- First or second class
SELECT Name, Pclass FROM passengers 
WHERE Pclass = 1 OR Pclass = 2;

-- Young or old (but not middle-aged)
SELECT Name, Age FROM passengers 
WHERE Age < 12 OR Age > 60;
```

### Combining AND/OR with Parentheses

```sql
-- Female passengers OR children under 12, who survived
SELECT Name, Age, Sex FROM passengers 
WHERE (Sex = 'female' OR Age < 12) AND Survived = 1;

-- Upper class OR paid high fare
SELECT Name, Pclass, Fare FROM passengers 
WHERE (Pclass = 1 OR Pclass = 2) AND Fare > 50;
```

**Best practice:** Use parentheses to make logic clear!

---

## ORDER BY - Sorting

### Sort Ascending (smallest to largest)

```sql
-- Youngest first (default is ascending)
SELECT Name, Age FROM passengers ORDER BY Age;

-- Can also explicitly say ASC
SELECT Name, Age FROM passengers ORDER BY Age ASC;

-- Alphabetical by name
SELECT Name FROM passengers ORDER BY Name;
```

### Sort Descending (largest to smallest)

```sql
-- Oldest first
SELECT Name, Age FROM passengers ORDER BY Age DESC;

-- Highest fare first
SELECT Name, Fare FROM passengers ORDER BY Fare DESC;
```

### Sort by Multiple Columns

```sql
-- Sort by class, then by fare within each class
SELECT Name, Pclass, Fare FROM passengers 
ORDER BY Pclass, Fare DESC;

-- Sort by sex, then by age within each sex
SELECT Name, Sex, Age FROM passengers 
ORDER BY Sex, Age;
```

**First column is primary sort, second is tie-breaker.**

---

## LIMIT - Controlling Results

### Get First N Rows

```sql
-- First 10 rows
SELECT * FROM passengers LIMIT 10;

-- First 5 names
SELECT Name FROM passengers LIMIT 5;
```

### LIMIT with ORDER BY (Top N queries)

```sql
-- 5 oldest passengers
SELECT Name, Age FROM passengers 
ORDER BY Age DESC 
LIMIT 5;

-- 10 highest fares
SELECT Name, Fare FROM passengers 
ORDER BY Fare DESC 
LIMIT 10;

-- 3 youngest female survivors
SELECT Name, Age FROM passengers 
WHERE Sex = 'female' AND Survived = 1
ORDER BY Age 
LIMIT 3;
```

**Order matters:** Filtering → Sorting → Limiting

---

## Common Patterns

### Pattern 1: Simple Selection

```sql
-- Get specific columns for all rows
SELECT Name, Age, Sex FROM passengers;
```

### Pattern 2: Filter and Display

```sql
-- Filter rows, show specific columns
SELECT Name, Age FROM passengers 
WHERE Age > 30;
```

### Pattern 3: Filter, Sort, Limit

```sql
-- Complete query: filter → sort → limit
SELECT Name, Age, Fare FROM passengers 
WHERE Age > 18 
ORDER BY Fare DESC 
LIMIT 10;
```

### Pattern 4: Multiple Conditions

```sql
-- Complex filtering with AND/OR
SELECT Name, Sex, Age, Pclass FROM passengers 
WHERE (Sex = 'female' OR Age < 12) 
  AND Pclass = 3 
ORDER BY Age;
```

### Pattern 5: Top N of Category

```sql
-- Youngest passengers in first class
SELECT Name, Age FROM passengers 
WHERE Pclass = 1 
ORDER BY Age 
LIMIT 5;
```

---

## pandas → SQL Cheat Sheet

| Operation | pandas | SQL |
|-----------|--------|-----|
| **Select all** | `df` | `SELECT * FROM table` |
| **Select columns** | `df[['col1', 'col2']]` | `SELECT col1, col2 FROM table` |
| **Filter rows** | `df[df['Age'] > 30]` | `SELECT * FROM table WHERE Age > 30` |
| **Sort ascending** | `df.sort_values('Age')` | `SELECT * FROM table ORDER BY Age` |
| **Sort descending** | `df.sort_values('Age', ascending=False)` | `SELECT * FROM table ORDER BY Age DESC` |
| **First N rows** | `df.head(10)` | `SELECT * FROM table LIMIT 10` |
| **AND condition** | `df[(df['A'] > 5) & (df['B'] == 'x')]` | `WHERE A > 5 AND B = 'x'` |
| **OR condition** | `df[(df['A'] == 1) | (df['B'] == 2)]` | `WHERE A = 1 OR B = 2` |
| **Count rows** | `len(df)` | `SELECT COUNT(*) FROM table` |
| **Not equal** | `df[df['Sex'] != 'male']` | `WHERE Sex != 'male'` |

---

## Troubleshooting

### Error: "no such table"
**Problem:** Table name is wrong or database not connected
```python
# Check what tables exist
query = "SELECT name FROM sqlite_master WHERE type='table'"
pd.read_sql(query, conn)
```

### Error: "no such column"
**Problem:** Column name is wrong or doesn't exist
```python
# Check column names
query = "PRAGMA table_info(passengers)"
pd.read_sql(query, conn)
```

### Error: "near WHERE: syntax error"
**Problem:** Missing FROM clause or wrong order
```sql
-- ❌ WRONG
SELECT Name WHERE Age > 30

-- ✅ RIGHT
SELECT Name FROM passengers WHERE Age > 30
```

### Error: Quotes around text not working
**Problem:** Using double quotes instead of single
```sql
-- ❌ WRONG (in most cases)
WHERE Sex = "male"

-- ✅ RIGHT
WHERE Sex = 'male'
```

### No results returned (empty DataFrame)
**Problem:** WHERE condition is too restrictive or wrong
```sql
-- Check if condition makes sense
-- Remove WHERE to see all data first
SELECT * FROM passengers;

-- Then add WHERE back to test
SELECT * FROM passengers WHERE Age > 30;
```

---

## Tips for Success

### 1. Build Queries Step by Step

```sql
-- Start simple
SELECT Name FROM passengers;

-- Add filtering
SELECT Name FROM passengers WHERE Age > 30;

-- Add sorting
SELECT Name FROM passengers WHERE Age > 30 ORDER BY Age;

-- Add limit
SELECT Name FROM passengers WHERE Age > 30 ORDER BY Age LIMIT 10;
```

### 2. Test Each Clause

Run the query after adding each new clause to catch errors early!

### 3. Use LIMIT While Testing

```sql
-- Always use LIMIT when testing on large datasets
SELECT * FROM passengers WHERE condition LIMIT 5;
```

### 4. Comment Your Queries

```sql
-- Find all female survivors under age 18
SELECT Name, Age, Sex 
FROM passengers 
WHERE Sex = 'female' 
  AND Survived = 1 
  AND Age < 18
ORDER BY Age;
```

### 5. Check Column Names

If you're not sure of the exact column name:
```python
# See all column names
query = "SELECT * FROM passengers LIMIT 1"
result = pd.read_sql(query, conn)
print(result.columns.tolist())
```

---

## Quick Debugging Checklist

When your query doesn't work:

- [ ] Is FROM clause present?
- [ ] Are clauses in the right order? (SELECT → FROM → WHERE → ORDER BY → LIMIT)
- [ ] Did you put single quotes around text values?
- [ ] Are column names spelled correctly?
- [ ] If using AND/OR, do you need parentheses?
- [ ] Is the table name correct?
- [ ] Did you forget a comma between columns?

---

## Running Queries in JupyterLab

### Standard Method

```python
import pandas as pd
import sqlite3

# Connect to database
conn = sqlite3.connect('titanic.db')

# Write your query
query = """
SELECT Name, Age, Sex
FROM passengers
WHERE Age > 30
ORDER BY Age
LIMIT 10
"""

# Execute and get results
result = pd.read_sql(query, conn)

# Display results
display(result)

# Close connection when done
conn.close()
```

### Quick Method (if connection already open)

```python
# Assuming conn is already created
query = "SELECT Name, Age FROM passengers WHERE Age > 30"
result = pd.read_sql(query, conn)
display(result)
```

---

## Practice Makes Perfect

**Keep this reference open while working!**

The more queries you write, the more natural SQL will feel. Remember:
- You already know the concepts (from pandas)
- You're just learning new syntax
- It's okay to look up syntax - professionals do it too!

**Happy querying!** 

---

## Quick Reference Card (Print & Keep)

```
┌─────────────────────────────────────────────────────┐
│              SQL QUERY STRUCTURE                    │
├─────────────────────────────────────────────────────┤
│ SELECT column1, column2     ← What to show          │
│ FROM table_name             ← Which table           │
│ WHERE condition             ← Filter (optional)     │
│ ORDER BY column             ← Sort (optional)       │
│ LIMIT number;               ← Limit (optional)      │
├─────────────────────────────────────────────────────┤
│              OPERATORS                              │
├─────────────────────────────────────────────────────┤
│ =    Equal to              AND  Both must be true   │
│ !=   Not equal             OR   One must be true    │
│ >    Greater than          ()   Group conditions    │
│ <    Less than                                      │
│ >=   Greater or equal      ASC   Low to high        │
│ <=   Less or equal         DESC  High to low        │
├─────────────────────────────────────────────────────┤
│              REMEMBER                               │
├─────────────────────────────────────────────────────┤
│ • Text needs single quotes: 'male'                  │
│ • Numbers don't need quotes: 30                     │
│ • Use = not == for comparison                       │
│ • Clause order matters!                             │
└─────────────────────────────────────────────────────┘
```
