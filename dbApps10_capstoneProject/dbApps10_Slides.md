---
marp: true
theme: default
class: invert
paginate: true
---

# Capstone Project
## Design, Build, Query, Present

Database Applications Development (145085)
Medina County Career Center
Instructor: Ryan McMaster

---

<!-- _header: "Sub-Lesson 10a — Project Kickoff" -->

# What You'll Build

Your own **SQLite database** from scratch.

Pick a **real-world topic** you care about.

Then **design it, populate it with data, and query it.**

---

# Topic Ideas

- Sports stats tracker
- Video game library
- Recipe collection
- School club manager
- Pet shelter database
- Music playlist organizer
- Small business inventory
- Workout/fitness log

**Or propose your own!**

---

# Project Requirements

- **3+ tables** with primary keys and foreign keys
- **20+ records** per main table (realistic data)
- **Constraints:** NOT NULL, UNIQUE, DEFAULT, CHECK, FOREIGN KEY
- **10+ queries** (JOINs, aggregations, GROUP BY, HAVING)
- **Parameterized queries** (prevent SQL injection)
- **At least 1 transaction** (BEGIN/COMMIT/ROLLBACK)
- **Data dictionary** (table & column descriptions)
- **ER diagram** (entity-relationship diagram)

---

<!-- _header: "Sub-Lesson 10b-10c — Design & Build" -->

# Design Phase

1. Identify your **entities** (tables)
2. List **attributes** (columns) for each
3. Determine **relationships** (1-to-many, many-to-many)
4. Draw your **ER diagram**
5. Write **CREATE TABLE** statements with constraints

**Build Phase**

1. Create the database
2. Run CREATE TABLE statements
3. Populate with 20+ realistic INSERT statements per main table

---

<!-- _header: "Sub-Lesson 10d — Queries" -->

# Query Phase

Write **10+ queries** that demonstrate course concepts:

- **SELECT with WHERE** — filtering data
- **INNER JOIN** — combining tables
- **LEFT JOIN** — including non-matches
- **GROUP BY with aggregates** — COUNT, SUM, AVG, MIN, MAX
- **HAVING** — filtering groups
- **ORDER BY** — sorting results
- **Subqueries or CTEs** — nested logic

Keep queries clean and well-commented.

---

<!-- _header: "Sub-Lesson 10e — Polish" -->

# Polish Phase

- **Data Dictionary:** Describe each table and column
- **Security:** Use parameterized queries everywhere
- **Transaction Demo:** Show one example of BEGIN/COMMIT/ROLLBACK
- **Comments:** Explain the logic in your SQL
- **Code Cleanup:** Remove debug code, test thoroughly

---

<!-- _header: "Sub-Lesson 10f — Presentations" -->

# Presentation (10 minutes)

1. **Introduce your topic** (30 sec) — what problem does it solve?
2. **Show your ER diagram** (1 min) — explain relationships
3. **Demo 3-4 best queries live** (5 min) — run them, show results
4. **Share one achievement** (2 min) — what are you proud of?
5. **Answer questions** (1 min)

*Keep it simple, confident, clear.*

---

# Rubric Overview

| Category | Points |
|----------|--------|
| **Design** (ER, tables, constraints) | 30 |
| **Build** (create, populate, clean) | 30 |
| **Queries** (10+, variety, correct) | 30 |
| **Documentation** (dictionary, comments) | 15 |
| **Presentation** (clarity, live demo) | 15 |
| **TOTAL** | 120 |

---

# Timeline & Tips

- Work through **10a–10f in order**
- **Ask questions early** — don't wait until the last day
- **Commit to GitHub often** — at least after each phase
- **Keep it simple** — quality over quantity
- **Test your queries** before presentation
- **Backup your work** regularly

*You've got this. Build something you're excited about.*
