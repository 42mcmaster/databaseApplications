---
marp: true
theme: default
class: invert
paginate: true
---

# Welcome Back! Lessons 3 & 4 Review
## Database Foundations & SQL Basics

## Database Applications Development
### Software Engineering | Medina County Career Center

---

## This Week's Focus

**Today (Mon):** Review Lessons 3 & 4 concepts
**Work Time:** Complete dbApps03 and dbApps04 tasks
**Tuesday:** Continue work on tasks + Excel introduction
**Wednesday-Friday:** Excel skills + Lesson 5 preview

**Remember:** dbApps03 due Monday, dbApps04 due Tuesday!

---

## Lesson 03 Quick Recap: Why Databases?

**Problem with CSV files:**
- ❌ No validation
- ❌ No relationships
- ❌ Data redundancy
- ❌ No security
- ❌ Can't handle multiple users

---

**Solution: Databases!**
- ✅ Data integrity
- ✅ Relationships between tables
- ✅ Security and access control
- ✅ Powerful querying

---

## Key Lesson 03 Terms

**Database:** Organized collection of related data
**DBMS:** Database Management System - intermediary between you and data
**SQLite:** Lightweight database system (perfect for learning!)
**SQL:** Structured Query Language
**Table:** Collection of data in rows and columns
**Row:** Single record
**Column:** Single attribute/field

---

## Converting DataFrames to Databases

**You learned how to:**

```python
import pandas as pd
import sqlite3

# Load CSV
df = pd.read_csv('Titanic Dataset.csv')

# Create database
conn = sqlite3.connect('titanic.db')

# Save to database
df.to_sql('passengers', conn, if_exists='replace', index=False)
```

**Result:** A `.db` file you can query with SQL!

---

## Your First SQL Query

**Basic SELECT:**
```sql
SELECT * FROM passengers LIMIT 5;
```

**Translation:**
- `SELECT *` = show all columns
- `FROM passengers` = from this table
- `LIMIT 5` = just first 5 rows

**Pandas equivalent:**
```python
titanic.head()
```

---

## Lesson 04 Quick Recap: SQL Fundamentals

**You learned 4 key SQL clauses:**

1. **SELECT** - Choose which columns
2. **WHERE** - Filter which rows
3. **ORDER BY** - Sort results
4. **LIMIT** - Control how many rows

**Key rule:** Order matters!
`SELECT → FROM → WHERE → ORDER BY → LIMIT`

---

## SELECT: Choosing Columns

**Get all columns:**
```sql
SELECT * FROM passengers;
```

**Get specific columns:**
```sql
SELECT Name, Age, Sex FROM passengers;
```

**Pandas equivalent:**
```python
titanic[['Name', 'Age', 'Sex']]
```

---

## WHERE: Filtering Rows

**Basic filtering:**
```sql
SELECT * FROM passengers
WHERE Age > 30;
```

**With text (needs quotes!):**
```sql
SELECT * FROM passengers
WHERE Sex = 'female';
```

**Pandas equivalent:**
```python
titanic[titanic['Age'] > 30]
titanic[titanic['Sex'] == 'female']
```

---

## Combining Conditions: AND / OR

**Both conditions must be true (AND):**
```sql
SELECT Name, Age
FROM passengers
WHERE Age > 30 AND Sex = 'female';
```

**At least one condition true (OR):**
```sql
SELECT Name, Pclass
FROM passengers
WHERE Pclass = 1 OR Pclass = 2;
```

---

## ORDER BY: Sorting Results

**Ascending (smallest first - default):**
```sql
SELECT Name, Age
FROM passengers
ORDER BY Age;
```

**Descending (largest first):**
```sql
SELECT Name, Fare
FROM passengers
ORDER BY Fare DESC;
```

**Pandas equivalent:**
```python
titanic.sort_values('Age')
titanic.sort_values('Fare', ascending=False)
```

---

## LIMIT: Controlling Result Size

**Get first N rows:**
```sql
SELECT * FROM passengers
LIMIT 10;
```

**Top N with ORDER BY:**
```sql
-- 5 oldest passengers
SELECT Name, Age
FROM passengers
ORDER BY Age DESC
LIMIT 5;
```

---

## Putting It All Together

**Complex query example:**
```sql
SELECT Name, Age, Sex, Fare
FROM passengers
WHERE Age > 18 AND Fare < 50
ORDER BY Age DESC
LIMIT 10;
```

**What this does:**
1. Selects 4 columns
2. Filters: adults who paid less than $50
3. Sorts by age (oldest first)
4. Shows only top 10 results

---

## Comparison Operators Quick Reference

| Operator | Meaning | Example |
|----------|---------|---------|
| `=` | Equal | `WHERE Age = 25` |
| `!=` or `<>` | Not equal | `WHERE Sex != 'male'` |
| `>` | Greater than | `WHERE Fare > 50` |
| `<` | Less than | `WHERE Age < 18` |
| `>=` | Greater or equal | `WHERE Age >= 18` |
| `<=` | Less or equal | `WHERE Age <= 12` |

---

## Common Mistakes to Avoid

**1. Forgetting quotes around text:**
- ❌ `WHERE Sex = male`
- ✅ `WHERE Sex = 'male'`

**2. Wrong clause order:**
- ❌ `SELECT * LIMIT 10 WHERE Age > 30`
- ✅ `SELECT * FROM passengers WHERE Age > 30 LIMIT 10`

**3. SQL uses `=` not `==` for comparison**
- Python: `Age == 25`
- SQL: `Age = 25`

---

## Pandas vs SQL Quick Reference

| Pandas | SQL |
|--------|-----|
| `df[['col1', 'col2']]` | `SELECT col1, col2` |
| `df[df['Age'] > 30]` | `WHERE Age > 30` |
| `df.sort_values('Age')` | `ORDER BY Age` |
| `df.head(10)` | `LIMIT 10` |
| `(cond1) & (cond2)` | `cond1 AND cond2` |
| `(cond1) | (cond2)` | `cond1 OR cond2` |

---

## Task Completion Checklist

**Before you submit:**

✅ All queries run without errors?
✅ Results match what was asked for?
✅ Used correct column names?
✅ Text values have quotes?
✅ Clauses in correct order?
✅ Committed and pushed to GitHub?

**Remember:** No names in file - submit via GitHub link!

---

## Today's Work Time

**What to work on:**

1. **dbApps03 Tasks** (due today!)
   - Create your database
   - Write basic SELECT queries
   - Compare to pandas operations

2. **dbApps04 Tasks** (due tomorrow!)
   - SELECT specific columns
   - WHERE filtering
   - ORDER BY sorting
   - Combine all clauses

---

## Getting Help

**If you're stuck:**

1. Check the SQL Reference Guide
2. Review the walkthrough notebooks
3. Compare to similar pandas code
4. Ask a neighbor
5. Raise your hand for instructor help

**Remember:** The reference guide is your friend - use it!

---

## Looking Ahead: What's Next?

**Rest of this week:**
- Excel formulas and visualization basics
- Getting comfortable with data presentation

**Next week (Lesson 05):**
- SQL aggregate functions (COUNT, SUM, AVG, MIN, MAX)
- GROUP BY for categorical analysis
- Exporting SQL data to Excel
- Creating professional reports

**Big picture:** You're building a complete data analysis workflow!

---

## Questions?

**Before you start working:**

- Database concepts clear?
- SQL syntax making sense?
- Comparison to pandas helpful?
- Ready to complete your tasks?

**Let's make today productive!**
