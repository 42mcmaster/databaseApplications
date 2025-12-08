---
marp: true
theme: default
class: invert
paginate: true
---
# Lesson 03 Part 2: Let's Build a Database
---

## Why SQLite?

**Perfect for learning:**
- ✅ No server setup needed - just a file
- ✅ Built into Python
- ✅ Real SQL syntax (same as bigger databases)
- ✅ Used by Chrome, Firefox, iPhone apps, Android

**Other options exist** (MySQL, PostgreSQL, MongoDB) but SQLite is perfect for us.

---

## Today's Goal

**Convert Titanic CSV → SQLite database**

Then write your first SQL query:
```sql
SELECT * FROM passengers LIMIT 5;
```

Compare to pandas:
```python
titanic.head()
```

**Same result, different tool!**

---

## The Workflow

```
CSV File  →  Load with pandas  →  Save to SQLite  →  Query with SQL
```

**You'll do all of this in the next 30 minutes.**

---

## Key Terms (Quick)

- **Table** = spreadsheet-like collection of data
- **Row** = one record (one passenger)
- **Column** = one attribute (like "Age")
- **Query** = asking the database a question

That's it for now!

---

## Your First SQL Query

```sql
SELECT * FROM passengers LIMIT 5;
```

**Translation:**
- `SELECT *` = "show me everything"
- `FROM passengers` = "from this table"
- `LIMIT 5` = "just the first 5"

**Pandas equivalent:** `titanic.head()`

---

## Converting DataFrame → Database

**Super easy with pandas:**

```python
import pandas as pd
import sqlite3

df = pd.read_csv('Titanic Dataset.csv')
conn = sqlite3.connect('titanic.db')
df.to_sql('passengers', conn, if_exists='replace', index=False)
```

**Done!** You now have a `.db` file.

---

## Let's Do It!

**Open:** `dbApps03_Walkthrough.ipynb`

**You will:**
1. Load the CSV
2. Create the database
3. Write SQL queries
4. Compare to pandas

**Follow along - let's build something!**
