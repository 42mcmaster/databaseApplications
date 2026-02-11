# dbApps03 Study Guide: Introduction to Databases

**Course:** Database Applications Development (145085)
**Lesson:** 03 — Introduction to Databases
**Dataset:** Titanic Dataset.csv → titanic.db

---

## Learning Objectives

After completing this lesson, you should be able to:

1. Explain the difference between data and information
2. Define what a database is and why we use one instead of CSV files
3. Describe the role of a DBMS
4. Identify types of databases (relational, NoSQL, cloud)
5. Explain why we use SQLite in this course
6. Convert a CSV file to a SQLite database using pandas
7. Write a basic SELECT query to retrieve data
8. Use PRAGMA commands to inspect database structure
9. Describe the connection between pandas operations and SQL

---

## Key Vocabulary

| Term | Definition |
|------|-----------|
| **Data** | Raw facts without context (numbers, text, values) |
| **Information** | Data that has been organized and given meaning |
| **Database** | An organized collection of related data managed by software |
| **DBMS** | Database Management System — software that stores, organizes, secures, and retrieves data |
| **Relational Database** | A database that stores data in tables with rows and columns, linked by relationships |
| **Table** | A collection of related data organized in rows and columns (like a spreadsheet) |
| **Row (Record)** | A single entry in a table (one passenger, one student, one product) |
| **Column (Field)** | A single attribute in a table (name, age, fare) |
| **SQL** | Structured Query Language — the language used to communicate with relational databases |
| **SQLite** | A lightweight, file-based relational database — no server required |
| **NoSQL** | A category of databases that don't use traditional tables (documents, key-value stores) |
| **Cloud Database** | A database hosted online and accessed over the internet |
| **Query** | A request for data from a database, written in SQL |
| **SELECT** | SQL keyword that specifies which columns to retrieve |
| **FROM** | SQL keyword that specifies which table to query |
| **PRAGMA** | SQLite commands that inspect database structure (tables, columns, types) |
| **`sqlite3`** | Python's built-in library for working with SQLite databases |
| **Connection (`conn`)** | A Python object that represents an open link to a database file |
| **`to_sql()`** | pandas method that saves a DataFrame into a database table |
| **`read_sql()`** | pandas method that runs a SQL query and returns results as a DataFrame |
| **Data Redundancy** | The same data stored in multiple places — a problem databases solve |
| **Data Integrity** | Ensuring data is accurate, consistent, and follows rules |
| **Metadata** | Data about data — column names, data types, constraints |

---

## Concept Review

### Data vs Information

Data is raw and meaningless on its own: the number `17`, the text `"Alice"`, the value `3.75`. Information is what you get when data is organized and given context: "Alice is a 17-year-old student with a 3.75 GPA." Databases help turn data into information by organizing it into structured tables you can query.

### Why Databases Instead of CSV Files?

CSV files work fine for small, simple datasets. But as data grows, CSVs have serious problems: no rules to prevent bad data, no way to link related information, data gets duplicated across files, and only one person can edit at a time. Databases solve all of these problems with validation rules, relationships between tables, controlled access, and powerful querying through SQL.

### DBMS (Database Management System)

A DBMS is the software layer between you and the actual data. It handles storing data on disk, enforcing rules, managing security, and translating your SQL queries into operations. Examples include SQLite, MySQL, PostgreSQL, Microsoft SQL Server, and MongoDB. We use SQLite because it's simple (one file, no server), free, and built into Python.

### Types of Databases

Relational databases store data in tables linked by relationships — this is what we use. NoSQL databases store data differently (documents, key-value pairs) and are used for things like social media feeds and real-time apps. Cloud databases are hosted online and managed by companies like Amazon and Google. Most business applications still use relational databases.

### Converting CSV to SQLite

The bridge from pandas to databases uses two key methods: `to_sql()` saves a DataFrame into a database table, and `read_sql()` runs a SQL query and returns results as a DataFrame. The `sqlite3` library (built into Python) handles the connection.

### SQL Basics

SQL is how you ask questions of a database. The most basic query is `SELECT columns FROM table`. Use `*` to get all columns. In this course, we always run SQL through pandas using `pd.read_sql("query", conn)` so results come back as a familiar DataFrame.

### PRAGMA Commands

PRAGMA is specific to SQLite and lets you inspect your database structure. `SELECT name FROM sqlite_master WHERE type='table'` lists all tables. `PRAGMA table_info(tableName)` shows column names and data types — the database equivalent of `.info()`.

---

## Pandas → SQL Bridge (Updated)

| What you want | Pandas (Lessons 01-02) | SQL (Lesson 03+) |
|---------------|----------------------|-------------------|
| See all data | `titanic` | `SELECT * FROM passengers` |
| First 5 rows | `titanic.head()` | `SELECT * FROM passengers LIMIT 5` |
| Pick columns | `titanic[["name", "age"]]` | `SELECT name, age FROM passengers` |
| Column info | `titanic.info()` | `PRAGMA table_info(passengers)` |
| List tables | — | `SELECT name FROM sqlite_master WHERE type='table'` |

---

## Titanic Dataset — Data Dictionary

(Same dataset as Lessons 01-02, now stored as a SQLite table called `passengers`.)

| Column | Description | SQL Data Type |
|--------|-------------|---------------|
| **pclass** | Passenger class (1, 2, 3) | INTEGER |
| **survived** | 0 = No, 1 = Yes | INTEGER |
| **name** | Full name | TEXT |
| **sex** | "male" or "female" | TEXT |
| **age** | Age in years | REAL |
| **sibsp** | Siblings/spouses aboard | INTEGER |
| **parch** | Parents/children aboard | INTEGER |
| **ticket** | Ticket number | TEXT |
| **fare** | Ticket price | REAL |
| **cabin** | Cabin number | TEXT |
| **embarked** | Port: C, Q, or S | TEXT |
| **boat** | Lifeboat number | TEXT |
| **body** | Body ID (if recovered) | REAL |
| **home.dest** | Home/destination | TEXT |

---

## Quick Reference Card

### Converting CSV to SQLite
```python
import pandas as pd
import sqlite3

titanic = pd.read_csv("Titanic Dataset.csv")
conn = sqlite3.connect("titanic.db")
titanic.to_sql("passengers", conn, if_exists="replace", index=False)
```

### Running SQL Queries
```python
pd.read_sql("SELECT * FROM passengers", conn)
pd.read_sql("SELECT name, age FROM passengers LIMIT 10", conn)
```

### Inspecting the Database
```python
pd.read_sql("SELECT name FROM sqlite_master WHERE type='table'", conn)
pd.read_sql("PRAGMA table_info(passengers)", conn)
```

### Closing the Connection
```python
conn.close()
```

---

## ODE Competencies Covered

| Competency | Description |
|-----------|-------------|
| 2.8.1 | Identify types of databases (relational, NoSQL, cloud) |
| 2.8.2 | Describe use and purpose of DBMS |
| 2.8.3 | Compare database structures |
| 2.8.6 | Describe SQL |
| 2.8.7 | Describe how data is stored and extracted |
