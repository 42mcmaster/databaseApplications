---
marp: true
theme: default
class: invert
paginate: true
---

# Lesson 02: Working with DataFrames

## Database Applications Development
### Medina County Career Center

---

<!-- _header: "Sub-Lesson 02a — DataFrames, Loading, Exploring" -->

## Where We Are

| Lesson 01 (Done) | **Lesson 02 (Today)** | Lesson 03 (Next) |
|---|---|---|
| JupyterLab & Python basics | Manipulate data with pandas | Same operations in SQL |

Everything you learn today in pandas has a **direct SQL equivalent**:

| Pandas | SQL |
|--------|-----|
| `df[["name", "age"]]` | `SELECT name, age` |
| `df[df["age"] > 30]` | `WHERE age > 30` |
| `df.sort_values("age")` | `ORDER BY age` |
| `df["age"].mean()` | `AVG(age)` |

---

<!-- _header: "Sub-Lesson 02a — DataFrames, Loading, Exploring" -->

## What is a DataFrame?

A **DataFrame** is a table of data with rows and columns — like a spreadsheet in Python.

```python
import pandas as pd
titanic = pd.read_csv("Titanic Dataset.csv")
```

| Method | What it returns |
|--------|----------------|
| `titanic.head()` | First 5 rows |
| `titanic.shape` | (rows, columns) |
| `titanic.info()` | Column names, types, missing values |
| `titanic.columns` | List of all column names |
| `titanic.describe()` | Stats for number columns |

> **02a Task:** Load the Titanic data and explore it with provided exercises

---

<!-- _header: "Sub-Lesson 02b — Column Selection, Filtering, Sorting" -->

## Selecting Columns

**One column** — single brackets, returns a Series:
```python
names = titanic["name"]
```

**Multiple columns** — double brackets, returns a DataFrame:
```python
subset = titanic[["name", "age", "survived"]]
```

> **SQL preview:** `SELECT name, age, survived FROM titanic`

---

<!-- _header: "Sub-Lesson 02b — Column Selection, Filtering, Sorting" -->

## Filtering Rows

Use a **condition** inside brackets to keep only matching rows:

```python
firstClass = titanic[titanic["pclass"] == 1]
older = titanic[titanic["age"] > 30]
```

**Combine with** `&` (and) or `|` (or) — parentheses required:
```python
femaleSurvivors = titanic[
    (titanic["sex"] == "female") & (titanic["survived"] == 1)
]
```

> **SQL preview:** `WHERE sex = 'female' AND survived = 1`

---

<!-- _header: "Sub-Lesson 02b — Column Selection, Filtering, Sorting" -->

## Sorting Data

```python
byAge = titanic.sort_values("age")                    # Ascending
byFare = titanic.sort_values("fare", ascending=False)  # Descending
```

> **SQL preview:** `ORDER BY age` or `ORDER BY fare DESC`

## Basic Statistics

```python
titanic["age"].mean()      # Average
titanic["fare"].max()      # Highest value
titanic["survived"].sum()  # Total survivors
```

**Filter first, then calculate:**
```python
titanic[titanic["pclass"] == 1]["fare"].mean()
```

> **02b Task:** DataFrame Manipulation Exercises (use walkthrough as reference)

---

<!-- _header: "Sub-Lesson 02b — Column Selection, Filtering, Sorting" -->

## Value Counts

`.value_counts()` counts how many times each value appears:

```python
titanic["pclass"].value_counts()
# 3    709
# 1    323
# 2    277
```

> **SQL preview:** `SELECT pclass, COUNT(*) FROM titanic GROUP BY pclass`

---

<!-- _header: "Summary" -->

## Pandas → SQL Bridge

| Operation | Pandas | SQL |
|-----------|--------|-----|
| Pick columns | `df[["col1", "col2"]]` | `SELECT col1, col2` |
| Filter rows | `df[df["col"] > 5]` | `WHERE col > 5` |
| Sort | `df.sort_values("col")` | `ORDER BY col` |
| Average | `df["col"].mean()` | `AVG(col)` |
| Count values | `df["col"].value_counts()` | `GROUP BY col` |

> **02c:** Complete dbApps02 DIY Task → Unit 1 Quiz when ready

**Next lesson:** We move this data into a real database and write SQL!
