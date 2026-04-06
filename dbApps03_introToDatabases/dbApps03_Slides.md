---
marp: true
theme: default
class: invert
paginate: true
---

# Database Applications Development

## Software Engineering | Medina County Career Center

---

## What We're Building

In Lessons 01–02, you loaded data from CSV files and explored it with pandas. **Today, we level up**: instead of CSV files, we'll store data in a real **database** — the same technology that powers Instagram, Spotify, and your bank.

Why? Because databases are:
- **Faster** at finding information
- **Safer** for protecting data
- **Smarter** at handling complex questions

By the end of today, you'll have a working SQLite database and know how to ask it questions in SQL.

---

## Data vs Information

**Data** = raw facts with no context
```
17, "Alice", 3.75, True
```

**Information** = data that has been organized and given meaning
```
"Student Alice is 17 years old with a 3.75 GPA and is currently enrolled."
```

> When raw facts are put in context, they become useful information.

Your phone stores millions of data points. When you ask Siri or Google a question, it processes data into information — often using a SQLite database behind the scenes.

---

## What is a Database?

A **database** is an organized collection of related data managed by software.

Think of it like this:
- **CSV file** = a messy pile of paper with numbers
- **Database** = those numbers neatly organized in a filing cabinet, with rules about what goes where

```
CSV: numbers.csv
Database: customers.db (a file on your computer)
```

---

## Why Use a Database Instead of CSV?

| Problem with CSV | How a Database Solves It |
|---|---|
| Anyone can enter bad data | Rules enforce correct data |
| Same data repeated across files | Store once, use everywhere |
| Hard to ask complex questions | SQL makes complex queries easy |
| Only one person can use it at a time | Multiple users safely at once |
| No protection for sensitive data | Built-in access control |

---

## Types of Databases

There are many kinds of databases. Here are the main ones:

| Type | How it works | Examples |
|---|---|---|
| **Relational** | Data in tables (rows & columns) | SQLite, MySQL, PostgreSQL |
| **NoSQL** | Data as documents or key-value pairs | MongoDB, Firebase |
| **Cloud** | Hosted online, pay-per-use | AWS RDS, Google BigQuery |

> **We use SQLite** — it's free, file-based (one `.db` file), and requires no server. Perfect for learning.

---

## What is a DBMS?

**DBMS** stands for **Database Management System**.

It's the software that:
- Stores your data safely
- Organizes it in tables
- Protects it with access rules
- Retrieves it when you ask questions

SQLite **is** a DBMS. When you create `titanic.db`, you're creating a SQLite database.

```python
import sqlite3

# Create and connect to a database
conn = sqlite3.connect("titanic.db")
# SQLite is now managing your data!
```

---

## From CSV to Database

Remember Lesson 02? You did this:

```python
import pandas as pd

titanic = pd.read_csv("Titanic Dataset.csv")
titanic.head()
```

Now let's save that same data to a database:

```python
import pandas as pd
import sqlite3

# Load CSV (you already know this)
titanic = pd.read_csv("Titanic Dataset.csv")

# Save it to a database (new!)
conn = sqlite3.connect("titanic.db")
titanic.to_sql("passengers", conn, if_exists="replace", index=False)
```

That's it. You now have a file called `titanic.db` with a table called `passengers`.

---

## Meet SQL

**SQL** (Structured Query Language) is how you talk to a database.

It's a language, just like Python. But instead of doing things, SQL **asks questions** about data.

In Lesson 02, you asked pandas questions:
```python
titanic.head()
titanic[["name", "age"]]
```

In Lesson 03, you'll ask a database the same questions using SQL:
```sql
SELECT * FROM passengers LIMIT 5
SELECT name, age FROM passengers
```

---

## Your First SQL Query

Let's run a SQL query in Python:

```python
import pandas as pd
import sqlite3

# Connect to the database
conn = sqlite3.connect("titanic.db")

# Ask the database a question using SQL
result = pd.read_sql("SELECT * FROM passengers LIMIT 5", conn)
print(result)
```

`pd.read_sql()` runs a SQL query and returns the results as a pandas DataFrame. Same as before — but now the data comes from a database!

---

## SQL: SELECT and FROM

Every SQL query has this basic structure:

```sql
SELECT what FROM where
```

**SELECT** = which columns you want
**FROM** = which table they're in

Simple example:
```sql
SELECT name, age FROM passengers
```

Translation: "Get me the `name` and `age` columns from the `passengers` table."

---

## Selecting All Columns

Sometimes you want all columns at once. Use `*` (the "wildcard"):

```sql
SELECT * FROM passengers
```

Translation: "Give me every column from the `passengers` table."

This is the same as `titanic.head()` from pandas — it just grabs everything.

---

## Practice: Building Queries

Try these in Python:

```python
# All columns, first 5 rows
pd.read_sql("SELECT * FROM passengers LIMIT 5", conn)

# Just name, age, survived
pd.read_sql("SELECT name, age, survived FROM passengers", conn)

# Just name
pd.read_sql("SELECT name FROM passengers", conn)
```

Notice: The results come back as a pandas DataFrame. You already know how to work with those!

> **SQL SELECT queries always start with what columns you want and what table they come from.**

---

## Exploring Your Database Structure

Before you write queries, you need to know:
- What tables exist?
- What columns are in each table?
- What type of data is in each column?

SQLite has a built-in way to check:

```python
# See all tables in your database
pd.read_sql("SELECT name FROM sqlite_master WHERE type='table'", conn)

# See column names and types for the passengers table
pd.read_sql("PRAGMA table_info(passengers)", conn)
```

This is like `.info()` and `.columns` in pandas — but it works on the database itself.

---

## The Big Picture

Here's how it all connects:

```
Lesson 01–02          Lesson 03+
CSV File
    ↓
pandas DataFrame
    ↓
SQLite Database (titanic.db)
    ↓
SQL Queries
```

You're taking the same data, but storing it smarter and accessing it faster.

---

## Key Concepts So Far

| Concept | What it means |
|---------|---|
| **Data** | Raw facts with no context |
| **Information** | Data organized and given meaning |
| **Database** | An organized collection of related data |
| **DBMS** | Software that manages and protects a database |
| **SQLite** | A simple, file-based database |
| **SQL** | Language for asking questions about data |
| **`.to_sql()`** | Pandas method to save a DataFrame to a database |
| **`.read_sql()`** | Pandas method to run SQL and get a DataFrame back |

---

## Key Takeaways

1. **Databases organize data better than CSV files** — validation, no duplication, safe multi-user access

2. **SQLite is a real database** — you can create one with a single Python command

3. **SQL is a query language** — like pandas, but for databases; you ask questions with SELECT and FROM

4. **Pandas and SQL work together** — write SQL in `.read_sql()`, get results as a DataFrame

---

## What's Next

**Activity:** Convert your own CSV dataset to SQLite, then write SQL queries to explore it.

In the next lesson, we'll learn to **filter** (WHERE), **sort** (ORDER BY), and **combine tables** (JOIN) — making SQL queries do real work.

---
