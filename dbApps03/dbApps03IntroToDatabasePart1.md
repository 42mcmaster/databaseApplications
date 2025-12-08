---
marp: true
theme: default
class: invert
paginate: true
---

# Lesson 03 Part 1: Introduction to Databases & SQLite

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
- We introduced how to manipulate data in DataFrames
- Select columns, filter rows, sort, aggregate

**Today - Lesson 03:**
- What is a database?
- Why use databases instead of CSV files?
- Convert your DataFrame → SQLite database
- Write SQL queries

---

## What is Data?

**Data** consists of raw facts.
- Not yet processed to reveal meaning
- Building blocks of information
- Example: `12, "Kobe Bryant", 3.1, True`


---
### **What is Information?**

**Information** is <i><u>**processed data**</u></i> that reveals meaning.
- Data that has been organized and given context
- Useful for decision making
- Example: "Student Kobe Bryant scored 12 points on quiz 3.1"


---
### **Think about it in terms of your phone:** 
Your phone stores millions of data points. When you ask: <br>"<u>Siri, who just texted me</u>?"<br> it processes that data into useful information.
<br>

### **How this ties into our lesson:**
Phones store a lot of their information—like messages, contacts, and notes—in SQLite databases, which are just organized tables, so the system can quickly search them and give you the answer you asked for.

---

## Activity: Database Detective

**Grab your phone!**

Find at least **3 apps** that you think use a database.

**For each app, write down:**
1. The app name
2. What kind of data it stores (messages? photos? contacts? songs?)
3. How many people do you think use this app's data at the same time?

**You have 5 minutes. Go!**

---
### **What is a Database?**

**Simple definition:** An organized collection of related data.

**Examples:**
- Student records at MCCC
- Netflix's catalog of shows
- Your contacts on your phone
- Amazon's product inventory

---

**More detailed definition of a database:**
<br>

A **database** is a shared, integrated computer structure that stores:
- **End-user data:** raw facts of interest (names, ages, sales, etc.)
- **Metadata:** data about the data (descriptions, relationships, constraints)

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

---

**Examples of DBMS:**
- SQLite (what we'll use to start)
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

## **Relational Databases**

* <u>**School database (SQL)**</u> — *used by nearly all school SIS systems like PowerSchool and Infinite Campus.*
* <u>**Online store (SQL)**</u> — *Amazon, Walmart, and Target use relational databases for orders and inventory.*
* <u>**Movie database (SQL)**</u> — *Netflix stores movie info in SQL tables so the system knows what to recommend.*

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