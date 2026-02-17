# dbApps02 Study Guide: Working with DataFrames

**Course:** Database Applications Development (145085)
**Lesson:** 02 — Working with DataFrames
**Dataset:** Titanic Dataset.csv

---

## Learning Objectives

After completing this lesson, you should be able to:

1. Explain what a DataFrame is and how it relates to a spreadsheet
2. Select one or more columns from a DataFrame
3. Filter rows using comparison operators and conditions
4. Combine filters with `&` (and) and `|` (or)
5. Sort data by one column in ascending or descending order
6. Calculate basic statistics (mean, max, min, sum, count)
7. Use `.value_counts()` to see the distribution of a column
8. Describe how each pandas operation maps to a SQL equivalent

---

## Key Vocabulary

| Term | Definition |
|------|-----------|
| **DataFrame** | A pandas data structure that holds data in rows and columns, like a spreadsheet |
| **Series** | A single column of data from a DataFrame |
| **Column Selection** | Picking specific columns from a DataFrame using bracket notation |
| **Filtering** | Keeping only the rows that match a condition |
| **Condition** | An expression that evaluates to True or False for each row |
| **Comparison Operator** | Symbols used to compare values: `==`, `!=`, `>`, `<`, `>=`, `<=` |
| **Boolean Filtering** | Using True/False conditions to select rows from a DataFrame |
| **Sorting** | Arranging rows in order based on a column's values |
| **Ascending** | Smallest to largest (A-Z, 0-9) — the default sort order |
| **Descending** | Largest to smallest (Z-A, 9-0) — use `ascending=False` |
| **Aggregate Function** | A function that calculates a single value from many values (mean, sum, etc.) |
| **`.mean()`** | Calculates the average of a column |
| **`.max()`** | Returns the largest value in a column |
| **`.min()`** | Returns the smallest value in a column |
| **`.sum()`** | Adds up all values in a column |
| **`.count()`** | Counts non-missing values in a column |
| **`.value_counts()`** | Counts how many times each unique value appears in a column |
| **NaN** | "Not a Number" — represents a missing value in pandas |

---

## Concept Review

### What is a DataFrame?

A DataFrame is the main way pandas stores data. Think of it as a spreadsheet: rows are individual records (like a passenger) and columns are attributes (like name, age, fare). When you load a CSV with `pd.read_csv()`, the result is a DataFrame.

### Column Selection

To get a single column, use single brackets: `titanic["name"]`. This returns a **Series** (one column). To get multiple columns, use double brackets with a list of names: `titanic[["name", "age", "survived"]]`. This returns a smaller DataFrame. Column names are case-sensitive and must match exactly.

### Filtering Rows

Filtering means keeping only the rows where a condition is True. The pattern is `df[condition]`. For example, `titanic[titanic["age"] > 30]` keeps only passengers older than 30. The condition `titanic["age"] > 30` creates a True/False value for every row, and the outer brackets keep only the True rows.

To combine conditions, use `&` for "and" and `|` for "or". Each condition must be in its own parentheses: `titanic[(titanic["age"] > 30) & (titanic["sex"] == "female")]`.

### Sorting

`.sort_values("columnName")` sorts rows by that column. Ascending (low to high) is the default. Use `ascending=False` for descending (high to low). Sorting does not change the original DataFrame — it returns a new sorted copy.

### Statistics

Pandas provides methods to calculate statistics on number columns. `.mean()` gives the average, `.max()` and `.min()` give the extremes, `.sum()` adds everything up, and `.count()` tells you how many non-missing values exist. You can chain these with filtering to get stats on a subset: `titanic[titanic["pclass"] == 1]["fare"].mean()` gives the average fare for first class only.

### Value Counts

`.value_counts()` is a quick way to see how data is distributed. It counts how many times each unique value appears and sorts by frequency. This is useful for categorical columns like `pclass`, `sex`, or `survived`.

### Pandas-to-SQL Bridge

Every operation you learn in pandas has a direct equivalent in SQL. This is intentional — understanding data manipulation in pandas makes learning SQL much easier. The table below shows the mapping.

---

## Pandas → SQL Reference

| What you want to do | Pandas | SQL |
|---------------------|--------|-----|
| Pick specific columns | `df[["name", "age"]]` | `SELECT name, age FROM table` |
| Get all columns | `df` | `SELECT * FROM table` |
| Filter rows (equals) | `df[df["pclass"] == 1]` | `WHERE pclass = 1` |
| Filter rows (greater than) | `df[df["age"] > 30]` | `WHERE age > 30` |
| Combine with AND | `df[(cond1) & (cond2)]` | `WHERE cond1 AND cond2` |
| Combine with OR | `df[(cond1) \| (cond2)]` | `WHERE cond1 OR cond2` |
| Sort ascending | `df.sort_values("age")` | `ORDER BY age` |
| Sort descending | `df.sort_values("age", ascending=False)` | `ORDER BY age DESC` |
| Average | `df["age"].mean()` | `SELECT AVG(age)` |
| Maximum | `df["fare"].max()` | `SELECT MAX(fare)` |
| Minimum | `df["age"].min()` | `SELECT MIN(age)` |
| Sum | `df["survived"].sum()` | `SELECT SUM(survived)` |
| Count | `df["age"].count()` | `SELECT COUNT(age)` |
| Count by category | `df["pclass"].value_counts()` | `SELECT pclass, COUNT(*) GROUP BY pclass` |

---

## Titanic Dataset — Data Dictionary

(Same dataset as Lesson 01 — included here for quick reference.)

| Column | Description | Data Type | Example Values |
|--------|-------------|-----------|----------------|
| **pclass** | Passenger class | int | 1 = First, 2 = Second, 3 = Third |
| **survived** | Survived? | int | 0 = No, 1 = Yes |
| **name** | Full name | str | "Braund, Mr. Owen Harris" |
| **sex** | Gender | str | "male" or "female" |
| **age** | Age in years | float | 22.0, 38.0 |
| **sibsp** | Siblings/spouses aboard | int | 0, 1, 2 |
| **parch** | Parents/children aboard | int | 0, 1, 2 |
| **ticket** | Ticket number | str | "A/5 21171" |
| **fare** | Ticket price (British pounds) | float | 7.25, 71.28 |
| **cabin** | Cabin number | str | "C85", "E46" |
| **embarked** | Port of embarkation | str | C = Cherbourg, Q = Queenstown, S = Southampton |
| **boat** | Lifeboat number | str | "13", "4" |
| **body** | Body ID number | float | 135.0 |
| **home.dest** | Home/destination | str | "New York, NY" |

---

## Quick Reference Card

### Loading Data
```python
import pandas as pd
titanic = pd.read_csv("Titanic Dataset.csv")
```

### Selecting Columns
```python
titanic["name"]                          # One column (Series)
titanic[["name", "age", "survived"]]     # Multiple columns (DataFrame)
```

### Filtering
```python
titanic[titanic["age"] > 30]                                        # Single condition
titanic[(titanic["sex"] == "female") & (titanic["survived"] == 1)]  # AND
titanic[(titanic["pclass"] == 1) | (titanic["pclass"] == 2)]       # OR
```

### Sorting
```python
titanic.sort_values("age")                    # Ascending (default)
titanic.sort_values("fare", ascending=False)  # Descending
```

### Statistics
```python
titanic["age"].mean()       # Average
titanic["fare"].max()       # Maximum
titanic["fare"].min()       # Minimum
titanic["survived"].sum()   # Total
titanic["age"].count()      # Count (non-missing)
```

### Value Counts
```python
titanic["pclass"].value_counts()    # Count per category
titanic["sex"].value_counts()       # Count per category
```

---

## ODE Competencies Covered

| Competency | Description |
|-----------|-------------|
| 5.1.2 | Explain algorithms and data structures |
| 5.1.5 | Data management through programming |
| 5.2.4 | String operations |
| 8.5.3 | Retrieve, filter, sort, and parse data (conceptual foundation) |
