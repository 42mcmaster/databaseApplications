---
marp: true
theme: default
class: invert
paginate: true
---

# Lesson 03: Introduction to Databases & SQLite

## Database Applications Development
### Software Engineering | Medina County Career Center

---

## Learning Objectives

By the end of this lesson, you will be able to:

- Define what a database is and explain why we use them
- Differentiate between data and information
- Describe the role and advantages of a DBMS
- Identify different types of databases
- Create a SQLite database from a CSV file
- Write your first SQL query
- Compare pandas operations to SQL equivalents

---

## Where We've Been & Where We're Going

**Lessons 01-02: Python & Pandas** ✅
- You learned to manipulate data in DataFrames
- Select columns, filter rows, sort, aggregate

**Today - Lesson 03:**
- What is a database?
- Why use databases instead of CSV files?
- Convert your DataFrame → SQLite database
- Write SQL queries

**Next - Lesson 04:**
- Recreate all your pandas operations in SQL
- SELECT, WHERE, ORDER BY

---

## What is Data?

**Data** consists of raw facts.
- Not yet processed to reveal meaning
- Building blocks of information
- Example: `42, "Smith", 3.14, True`

**Information** is processed data that reveals meaning.
- Data that has been organized and given context
- Useful for decision making
- Example: "Student Smith scored 42 points on exam 3.14"

**Think about it:** Your phone stores millions of data points. When you ask "Who texted me?" it processes that data into useful information.

---

## What is a Database?

A **database** is a shared, integrated computer structure that stores:
- **End-user data:** raw facts of interest (names, ages, sales, etc.)
- **Metadata:** data about the data (descriptions, relationships, constraints)

**Simple definition:** An organized collection of related data.

**Examples:**
- Student records at MCCC
- Netflix's catalog of shows
- Your contacts on your phone
- Amazon's product inventory

---

## Why Not Just Use CSV Files?

**Problems with CSV files:**
- ❌ No data validation (can enter anything)
- ❌ No relationships between data
- ❌ Data redundancy (copying same info multiple times)
- ❌ Hard to query complex questions
- ❌ No security or access control
- ❌ Multiple people can't safely edit at once

**Example problem:** If you store student name in 10 different CSV files, and they change their name, you have to update 10 files!

---

## Databases Solve These Problems

**Advantages of databases:**
- ✅ Better data integrity (validation rules)
- ✅ Data independence (change structure without breaking apps)
- ✅ Reduced data redundancy (store once, use many times)
- ✅ Improved data sharing (multiple users, controlled access)
- ✅ Improved data security (passwords, permissions)
- ✅ Better backup and recovery
- ✅ Powerful querying (ask complex questions easily)

**Bottom line:** Databases are designed for managing data at scale.

---

## What is a DBMS?

**Database Management System (DBMS):**
An intermediary between users and the database.

**Think of it as:**
- A translator between you and the data
- A security guard protecting the data
- A librarian organizing the data

**Examples of DBMS:**
- SQLite (what we'll use)
- MySQL
- PostgreSQL
- Microsoft SQL Server
- Oracle Database
- MongoDB (NoSQL)

---

## Role of the DBMS

The DBMS handles:

**Data Storage Management**
- Stores data efficiently on disk
- Manages physical file structures

**Data Transformation**
- Translates your requests into operations
- Formats results for display

**Security Management**
- Controls who can access what data
- Enforces business rules

**Multi-user Access Control**
- Handles many people using data simultaneously
- Prevents conflicts

---

## Types of Databases (Overview)

**By Number of Users:**
- **Single-user:** One person at a time (desktop database)
- **Multi-user:** Many people simultaneously (most professional databases)

**By Location:**
- **Centralized:** All data in one place
- **Distributed:** Data spread across multiple locations

**By Structure:**
- **Relational:** Data in tables with relationships (what we'll focus on)
- **NoSQL:** Document-based, key-value, graph databases
- **Cloud:** Hosted online (AWS, Google Cloud)

---

## Relational Databases

**The most common type of database:**
- Data stored in **tables** (like spreadsheets)
- Tables have **rows** (records) and **columns** (fields)
- Tables can be **related** to each other
- Uses **SQL** (Structured Query Language) to interact

**Example:**
```
Students Table          |  Enrollments Table
------------------------|-------------------------
StudentID | Name | Age  |  StudentID | CourseID
1         | Alice | 17  |  1         | CS101
2         | Bob   | 18  |  1         | MATH200
                        |  2         | CS101
```

We'll dive deep into relationships in Lesson 07.

---

## Why SQLite for This Course?

**SQLite** is perfect for learning because:

✅ **Serverless** - no separate database server to set up
✅ **File-based** - database is just a file on your computer
✅ **Lightweight** - small and fast
✅ **Built into Python** - no installation needed
✅ **Real SQL** - same syntax as bigger databases
✅ **Widely used** - browsers, phones, apps use SQLite

**Important:** SQLite is a real, production-ready database used by Firefox, Android, iPhone apps, and more!

---

## SQLite vs. Other Databases

**SQLite:**
- Single file database
- Great for: embedded systems, mobile apps, small-medium projects
- Not great for: thousands of simultaneous users

**MySQL / PostgreSQL:**
- Server-based databases
- Great for: web applications, large organizations
- Requires: separate server setup

**MongoDB (NoSQL):**
- Document-based (JSON-like)
- Great for: flexible data structures
- Different query language

**For learning → SQLite is perfect!**

---

## How We'll Use SQLite

**Three ways to interact with SQLite:**

1. **Python code** (sqlite3 library)
   - Write scripts to create/query databases
   - Integrate with pandas

2. **Jupyter notebooks** (what we'll mainly use)
   - Mix SQL and Python
   - See results immediately

3. **DB Browser for SQLite** (visual tool)
   - GUI application to explore databases
   - Great for beginners to see structure

Today we'll use all three!

---

## The Big Picture: Our Workflow

```
CSV File                DataFrame              SQLite Database
(data.csv)              (pandas)               (database.db)
   │                        │                          │
   │                        │                          │
   ▼                        ▼                          ▼
Read with          Manipulate with          Query with SQL
pandas             Python methods           
                   (Lessons 1-2)            (Starting today!)
                          │
                          │
                          ▼
                   Convert to database
                   (Today's lesson!)
```

---

## Today's Hands-On Goal

**By the end of today, you will:**

1. Convert the Titanic CSV → SQLite database
2. Explore the database structure
3. Write your first SQL query: `SELECT * FROM passengers`
4. Compare it to the pandas equivalent: `titanic.head()`
5. Understand when to use databases vs. DataFrames

**Follow along in the notebook:** `dbApps03_Walkthrough.ipynb`

---

## Data vs. Information Review

Let's look at the Titanic dataset:

**Raw Data:**
- 891, male, 22, 1, 0, 7.25

**Information (with context):**
- Passenger 891 was a 22-year-old male in 1st class with no siblings/spouse aboard, who paid a fare of $7.25

**The database provides:**
- Column names (metadata)
- Data types (age is a number, sex is text)
- Relationships (passenger → ticket → cabin)

---

## Key Database Terminology

**Table** = A collection of related data (like a spreadsheet)
**Row / Record** = One entry in the table (one passenger)
**Column / Field / Attribute** = One piece of information (like "age")
**Primary Key** = Unique identifier for each row
**Schema** = The structure/design of the database

**Example:**
```
Table: passengers
Columns: PassengerID, Name, Age, Sex, Survived
Row: 1, "John Smith", 22, "male", 1
Primary Key: PassengerID
```

---

## SQL: Structured Query Language

**SQL** is the language we use to talk to relational databases.

**Four main categories of SQL commands:**

1. **DQL - Data Query Language**
   - `SELECT` - Retrieve data
   - (What we'll focus on first)

2. **DML - Data Manipulation Language**
   - `INSERT` - Add new data
   - `UPDATE` - Modify existing data
   - `DELETE` - Remove data

3. **DDL - Data Definition Language**
   - `CREATE TABLE` - Make new tables
   - `ALTER TABLE` - Change table structure

4. **DCL - Data Control Language**
   - `GRANT` - Give permissions
   - `REVOKE` - Remove permissions

---

## Your First SQL Query

**The simplest SQL query:**

```sql
SELECT * FROM passengers;
```

**Translation:**
- `SELECT` = "Show me"
- `*` = "everything" (all columns)
- `FROM passengers` = "from the passengers table"
- `;` = "end of command"

**Pandas equivalent:**
```python
titanic  # or titanic.head()
```

**Same result, different syntax!**

---

## SELECT Specific Columns

**SQL:**
```sql
SELECT Name, Age, Survived FROM passengers;
```

**Pandas equivalent:**
```python
titanic[['Name', 'Age', 'Survived']]
```

**You already know this concept!** You did it in Lesson 02 with DataFrames.

SQL is just a different way to say the same thing.

---

## Why Learn Both Pandas AND SQL?

**Pandas is great for:**
- Data analysis and exploration
- Data cleaning and transformation
- Quick visualizations
- Working with CSV files
- Scientific computing

**SQL is great for:**
- Large datasets (millions of rows)
- Multiple users accessing data
- Data integrity and validation
- Production applications
- Industry standard

**Best practice:** Use both! Load from database with SQL, analyze with pandas.

---

## Real-World Example

**Scenario:** You work for an e-commerce company.

**Daily workflow:**
1. **SQL** - Extract order data from company database
   ```sql
   SELECT * FROM orders WHERE order_date = '2024-12-02';
   ```

2. **Pandas** - Analyze and visualize in Python
   ```python
   df = pd.read_sql(query, connection)
   df.groupby('product')['revenue'].sum()
   ```

3. **SQL** - Save results back to database
   ```python
   df.to_sql('daily_summary', connection)
   ```

**You'll learn both tools!**

---

## Converting DataFrame → SQLite

**It's really easy with pandas:**

```python
import pandas as pd
import sqlite3

# Read CSV into DataFrame
df = pd.read_csv('Titanic Dataset.csv')

# Create database connection
conn = sqlite3.connect('titanic.db')

# Convert DataFrame to SQL table
df.to_sql('passengers', conn, if_exists='replace', index=False)

# Close connection
conn.close()
```

**That's it!** You now have a real database.

---

## Database File vs. CSV File

**What just happened?**

**Before:**
- `Titanic Dataset.csv` (text file, ~60KB)

**After:**
- `titanic.db` (SQLite database file, ~60KB)
- Contains the same data, but with:
  - Structured tables
  - Data type information
  - Faster querying
  - Ready for SQL

**You can open the .db file with DB Browser for SQLite to explore visually!**

---

## Exploring with DB Browser for SQLite

**DB Browser** is a free tool to visually explore SQLite databases.

**Features:**
- See table structure
- Browse data (like Excel)
- Write and test SQL queries
- Modify data
- Export results

**Download:** https://sqlitebrowser.org/

**Today:** We'll use it to confirm our database was created correctly.

---

## Writing Queries in Python

**Two ways to run SQL from Python:**

**Method 1: Using sqlite3 library**
```python
import sqlite3
conn = sqlite3.connect('titanic.db')
cursor = conn.execute("SELECT * FROM passengers LIMIT 5")
for row in cursor:
    print(row)
```

**Method 2: Using pandas (easier!)**
```python
import pandas as pd
import sqlite3
conn = sqlite3.connect('titanic.db')
df = pd.read_sql("SELECT * FROM passengers LIMIT 5", conn)
print(df)
```

**We'll use Method 2 mostly** - clean pandas DataFrame output!

---

## Your First Query Comparison

**Goal:** Show the first 5 passengers

**Pandas (Lesson 01):**
```python
titanic.head()
```

**SQL (Today):**
```sql
SELECT * FROM passengers LIMIT 5;
```

**In Python with pandas:**
```python
pd.read_sql("SELECT * FROM passengers LIMIT 5", conn)
```

**Same result, different approach!**

---

## Why This Matters

**You've now learned:**
- ✅ Pandas for data analysis (flexible, Pythonic)
- ✅ SQL for data retrieval (powerful, industry standard)

**In the real world:**
- Data analysts use both
- Backend developers use SQL
- Data scientists use both
- Database admins focus on SQL

**You're learning professional tools!**

---

## Common Student Questions

**Q: Why not just use Excel?**
A: Excel is limited to ~1 million rows, no data validation, hard to share, no security.

**Q: Do I need to memorize SQL syntax?**
A: No! Reference guides are always available. Focus on understanding concepts.

**Q: Is SQLite a "real" database?**
A: Yes! It's used in browsers, phones, and embedded systems. It's production-ready.

**Q: What if I prefer pandas?**
A: That's fine for analysis! But SQL is required for working with databases in industry.

---

## Data Integrity Example

**Problem with CSV:**
```csv
Name,Age,Sex
Alice,25,Female
Bob,thirty,Male      ← Age is text!
Charlie,-5,X         ← Negative age? Invalid sex?
```

**With a database:**
- Age column is defined as INTEGER
- Sex column has CHECK constraint (must be 'male' or 'female')
- Invalid data is rejected automatically

**This protects your data quality!**

---

## Looking Ahead: Lesson 04

**Next lesson you'll learn:**
- SELECT specific columns
- WHERE clause for filtering
- ORDER BY for sorting
- Recreate all your Lesson 02 pandas operations in SQL

**You already know the concepts!** You'll just learn the SQL syntax.

**Preview:**
```sql
SELECT Name, Age FROM passengers WHERE Age > 30 ORDER BY Age;
```

vs.

```python
titanic[titanic['Age'] > 30][['Name', 'Age']].sort_values('Age')
```

---

## Lesson 03 Walkthrough

**Now it's your turn!**

Open the notebook: **`dbApps03_Walkthrough.ipynb`**

**You will:**
1. Load the Titanic CSV
2. Create a SQLite database
3. Write your first SQL query
4. Compare SQL to pandas
5. Explore with DB Browser

**Follow along step-by-step** with code examples and explanations.

---

## Key Takeaways

✅ **Data** = raw facts | **Information** = processed data with meaning
✅ **Databases** provide structure, integrity, and efficient querying
✅ **DBMS** is the software that manages databases
✅ **SQLite** is perfect for learning - file-based, no server needed
✅ **SQL** is the language for querying relational databases
✅ **Pandas + SQL** = powerful combination for data work
✅ You can convert DataFrames ↔ SQL databases easily

**Next lesson:** Write SQL queries to SELECT, filter, and sort data!

---

## Before You Start the Walkthrough

**Make sure you have:**
- ✅ Titanic Dataset CSV file
- ✅ Jupyter notebook environment
- ✅ pandas and sqlite3 (already installed with Python)
- ✅ (Optional) DB Browser for SQLite installed

**If you need help:**
- Check the walkthrough notebook
- Review your Lesson 01-02 materials
- Ask for clarification

**Let's build your first database!** 🚀

---

## Questions?

Before we dive into the walkthrough:

- What is a database vs. a DBMS?
- Why use databases instead of CSV files?
- What is SQLite and why is it good for learning?
- What is SQL?
- Ready to write your first query?

**Open `dbApps03_Walkthrough.ipynb` and let's go!**
