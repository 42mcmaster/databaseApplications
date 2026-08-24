---
marp: true
theme: default
class: invert
paginate: true
---

# Working with DataFrames

## Database Applications Development
### Software Engineering | Medina County Career Center

---

## Quick Recap: What We Know

Last lesson you learned **Python basics** in JupyterLab.

Today: Learn to **manipulate data** using pandas — a Python library for working with tables of data.

**Why?** Everything you do with pandas today has a **direct equivalent in SQL** (which we'll learn in Lesson 03).

---

## What is a DataFrame?

A **DataFrame** is a table of data with rows and columns — like a spreadsheet in Python.

Think of it as your data organized into a nice, organized grid.

```python
import pandas as pd
titanic = pd.read_csv("Titanic Dataset.csv")
```

> A **DataFrame** is a table with labeled rows and columns that you can read, filter, and calculate from.

---

## Exploring Your Data

Once you load data, the first step is always to **look at it** and understand what you have.

```python
titanic.head()       # Show first 5 rows
titanic.shape        # How many rows and columns? (rows, columns)
titanic.info()       # Column names, data types, missing values
titanic.columns      # List of all column names
```

---

## Getting Summary Statistics

Pandas can quickly calculate basic math across columns:

```python
titanic["age"].mean()      # Average age
titanic["fare"].max()      # Highest fare paid
titanic["survived"].sum()  # Total number who survived
```

> **In SQL** you'd use `AVG()`, `MAX()`, `SUM()` — same idea!

---

## Selecting One Column

To grab a single column, use **single brackets**:

```python
names = titanic["name"]
```

This gives you a **Series** — a single column of data.

---

## Selecting Multiple Columns

To pick several columns, use **double brackets**:

```python
subset = titanic[["name", "age", "survived"]]
```

This gives you a **DataFrame** — a new table with just those columns.

> **In SQL:** `SELECT name, age, survived FROM titanic`

---

## Filtering Rows: Simple Example

You can keep only rows that match a condition:

```python
adults = titanic[titanic["age"] > 18]
```

Read this as: "Show me rows where age is greater than 18"

---

## Filtering Rows: More Examples

```python
firstClass = titanic[titanic["pclass"] == 1]
women = titanic[titanic["sex"] == "female"]
```

> **In SQL:** `WHERE pclass = 1` or `WHERE sex = 'female'`

---

## Combining Multiple Conditions

Use `&` for AND and `|` for OR. **Important: Always use parentheses!**

```python
femaleSurvivors = titanic[
    (titanic["sex"] == "female") & (titanic["survived"] == 1)
]
```

This finds rows where sex is "female" **AND** survived equals 1.

> **In SQL:** `WHERE sex = 'female' AND survived = 1`

---

## Sorting Data

Sort in ascending order (smallest to largest):

```python
byAge = titanic.sort_values("age")
```

Sort in descending order (largest to smallest):

```python
byFare = titanic.sort_values("fare", ascending=False)
```

> **In SQL:** `ORDER BY age` or `ORDER BY fare DESC`

---

## Counting Values

`.value_counts()` counts how many times each value appears in a column:

```python
titanic["pclass"].value_counts()
```

Output:
```
3    709
1    323
2    277
```

This tells us: 709 passengers were in 3rd class, 323 in 1st class, etc.

> **In SQL:** `SELECT pclass, COUNT(*) FROM titanic GROUP BY pclass`

---

## Filter, Then Calculate

You can combine filtering and statistics:

```python
firstClassFare = titanic[titanic["pclass"] == 1]["fare"].mean()
```

This finds the average fare **only for 1st class passengers**.

---

## Pandas Operations → SQL Equivalents

| What You Want | Pandas Code | SQL Equivalent |
|---|---|---|
| Pick columns | `df[["col1", "col2"]]` | `SELECT col1, col2` |
| Filter rows | `df[df["col"] > 5]` | `WHERE col > 5` |
| Sort results | `df.sort_values("col")` | `ORDER BY col` |
| Calculate average | `df["col"].mean()` | `AVG(col)` |
| Count occurrences | `df["col"].value_counts()` | `GROUP BY col` |

---

## Key Takeaways

- **DataFrames** are tables of data — like spreadsheets in Python
- **Select columns** with brackets: single `[]` for one, double `[[]]` for many
- **Filter rows** by writing conditions: `df[df["age"] > 30]`
- **Calculate stats** with `.mean()`, `.sum()`, `.max()`, etc.
- **Every pandas operation** will have a SQL equivalent — you'll see it in Lesson 03!

---

## What's Next?

Now that you can manipulate data in pandas, the next step is to learn **SQL** — the language databases use.

You'll discover that SQL lets you do the exact same operations, but on data stored in a real database.

**Activity:** Complete the DataFrame Manipulation Exercises using these techniques!
