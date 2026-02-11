---
marp: true
theme: default
class: invert
paginate: true
---

# Lesson 03: Introduction to Databases

## Database Applications Development
### Medina County Career Center

---

<!-- _header: "Sub-Lesson 03a — What is a Database?" -->

## Data vs Information

**Data** = raw facts with no context: `17, "Alice", 3.75, True`

**Information** = data that has been organized and given meaning:
"Student Alice is 17 years old with a 3.75 GPA and is currently enrolled."

Your phone stores millions of data points. When you ask Siri a question, it processes **data** into useful **information** — often using a SQLite database behind the scenes.

---

<!-- _header: "Sub-Lesson 03a — What is a Database?" -->

## What is a Database? Why Not Just CSV Files?

A **database** is an organized collection of related data managed by software.

| CSV Files | Databases |
|-----------|-----------|
| No validation — anything goes | Rules enforce correct data |
| Data repeated across files | Store once, use everywhere |
| Hard to ask complex questions | SQL makes complex queries easy |
| One person at a time | Multiple users safely |
| No security | Access control built in |

---

<!-- _header: "Sub-Lesson 03a — What is a Database?" -->

## DBMS and Types of Databases

A **DBMS** (Database Management System) is the software that manages a database — it stores, organizes, secures, and retrieves data for you.

| Type | How it stores data | Examples |
|------|-------------------|----------|
| **Relational** | Tables with rows & columns | SQLite, MySQL, PostgreSQL |
| **NoSQL** | Documents, key-value pairs | MongoDB, Firebase |
| **Cloud** | Hosted online, pay-per-use | AWS RDS, Google BigQuery |

**We use SQLite** — it's a relational database stored as a single file. No server needed.

> **03a Task:** Database Identification Activity — categorize real-world examples

---

<!-- _header: "Sub-Lesson 03b — SQLite, CSV → DB, First SQL Query" -->

## From CSV to Database

In Lessons 01–02 we used pandas to work with CSV files. Now we move that same data into a **real database**.

```python
import pandas as pd
import sqlite3

# Load CSV into pandas (you already know this)
titanic = pd.read_csv("Titanic Dataset.csv")

# Create a SQLite database and save the data to it
conn = sqlite3.connect("titanic.db")
titanic.to_sql("passengers", conn, if_exists="replace", index=False)
```

That's it — you now have a database file called `titanic.db` with a table called `passengers`.

---

<!-- _header: "Sub-Lesson 03b — SQLite, CSV → DB, First SQL Query" -->

## Your First SQL Query

**SQL** (Structured Query Language) is how you talk to a database.

```python
# Connect to the database
conn = sqlite3.connect("titanic.db")

# Write a SQL query and run it with pandas
result = pd.read_sql("SELECT * FROM passengers LIMIT 5", conn)
result
```

| Pandas (Lesson 02) | SQL (Lesson 03) |
|---------------------|-----------------|
| `titanic.head()` | `SELECT * FROM passengers LIMIT 5` |
| `titanic[["name", "age"]]` | `SELECT name, age FROM passengers` |

---

<!-- _header: "Sub-Lesson 03b — SQLite, CSV → DB, First SQL Query" -->

## SQL Basics: SELECT and FROM

Every SQL query starts with **what** you want and **where** it is:

```sql
SELECT column1, column2 FROM tableName
```

```python
# All columns
pd.read_sql("SELECT * FROM passengers", conn)

# Specific columns
pd.read_sql("SELECT name, age, survived FROM passengers", conn)
```

`*` means "all columns" — same as `titanic` with no column filter.

---

<!-- _header: "Sub-Lesson 03b — SQLite, CSV → DB, First SQL Query" -->

## Exploring Your Database with PRAGMA

**PRAGMA** commands let you inspect the structure of your database:

```python
# See all tables in the database
pd.read_sql("SELECT name FROM sqlite_master WHERE type='table'", conn)

# See column names and types for a table
pd.read_sql("PRAGMA table_info(passengers)", conn)
```

This is the database equivalent of `.info()` and `.columns` from pandas.

> **03b Task:** Convert Titanic CSV to SQLite, run first queries (use walkthrough)

---

<!-- _header: "Summary" -->

## The Big Picture

```
Lesson 01-02          Lesson 03              Lesson 04+
CSV File  ──→  pandas DataFrame  ──→  SQLite Database  ──→  SQL Queries
                                         titanic.db
```

| Concept | What you learned |
|---------|-----------------|
| Data vs Information | Raw facts vs organized, meaningful data |
| Database | Organized collection of related data |
| DBMS | Software that manages a database |
| SQLite | A file-based relational database |
| SQL | Language for querying databases |
| `to_sql()` | Pandas method to save data to a database |
| `read_sql()` | Pandas method to run SQL and get results |

> **03c:** Gimkit Review Game + complete dbApps03 DIY Task
