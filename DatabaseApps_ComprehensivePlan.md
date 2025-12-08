# Database Applications Development
## Comprehensive Curriculum Plan

**Course:** 145085 - Database Applications Development  
**Instructor:** Ryan  
**Approach:** Pandas → SQL bridge using hands-on projects with real datasets

---

## **PHASE 1: Python Foundations for Data Work** 
*Weeks 1-2 

### Lesson 01: JupyterLab & Python Fundamentals ✅
**State Alignment:** 5.1 (Programming Concepts), 5.2 (Computational Operations)

**Completed Content:**
- JupyterLab interface and workflow
- Variables and data types (str, int, float, bool)
- Basic operations and calculations
- Print statements and comments
- Installing/importing libraries (pandas)

**Skills Developed:**
- Navigate JupyterLab
- Work with Python data types
- Understand connection between Python types and database column types

**Assignment:** task01_trackA/B.ipynb using Titanic dataset

---

### Lesson 02: Working with DataFrames ✅
**State Alignment:** 8.5 (Queries - conceptual foundation)

**Completed Content:**
- Select columns (single and multiple)
- Filter rows with boolean conditions
- Sort data (single and multiple columns)
- Calculate statistics on data
- Mapping pandas operations to SQL concepts

**Skills Developed:**
- DataFrame manipulation (SELECT equivalent)
- Boolean filtering (WHERE equivalent)
- Sorting (ORDER BY equivalent)
- Aggregations (COUNT, AVG equivalent)

**Assignment:** dbAppsTask02TrackA/B.ipynb

---

## **PHASE 2: Database Concepts & Theory**
*Weeks 3-4*

### Lesson 03: Introduction to Databases & SQLite
**State Alignment:** 2.8.1, 2.8.2, 2.8.3 (Database fundamentals)  
**Textbook:** Chapter 1 (slides 1-15)

**Learning Objectives:**
- Define data vs. information
- Explain what a database is and why we use them
- Describe DBMS purpose and advantages
- Identify types of databases (relational, NoSQL, cloud, etc.)
- Compare flat files vs. relational databases
- Introduce SQLite as our learning DBMS

**Hands-On Activities:**
1. Convert Titanic DataFrame to SQLite database
2. First SQL query: `SELECT * FROM passengers`
3. Compare pandas vs. SQL for the same operation
4. Explore database structure with Python queries

**Key Concepts:**
- Data vs. Information
- Database vs. DBMS
- Advantages: reduced redundancy, improved data integrity, data sharing
- SQLite: serverless, file-based, perfect for learning

**Deliverable:** 
- Completed walkthrough notebook with basic SELECT queries
- Students stay in JupyterLab environment

---

### Lesson 04: SQL Basics - SELECT, WHERE, ORDER BY
**State Alignment:** 8.5.1, 8.5.3 (Queries), 2.8.6 (SQL description)  
**Builds on:** Lesson 02 (pandas operations)

**Learning Objectives:**
- Write SELECT statements to retrieve specific columns
- Use WHERE clause for filtering
- Apply ORDER BY for sorting
- Compare SQL syntax to equivalent pandas operations
- Use LIMIT to control result size

**Hands-On Activities:**
1. Recreate all Lesson 02 pandas operations in SQL
2. Query challenges: "Find all female survivors", "Show oldest passengers"
3. Speed comparison: pandas vs. SQL for large datasets

**SQL Syntax Covered:**
```sql
SELECT column1, column2 FROM table_name;
SELECT * FROM table_name WHERE condition;
SELECT * FROM table_name ORDER BY column ASC/DESC;
SELECT * FROM table_name LIMIT n;
```

**Key Teaching Strategy:**
- Show pandas code, then equivalent SQL side-by-side
- Students already know the concept from Lesson 02
- Now they're learning new syntax for familiar operations

**Deliverable:**
- **Track A:** 10 SQL queries (selecting, filtering, sorting)
- **Track B:** 15 SQL queries + multi-condition WHERE statements

---

### Lesson 05: Database Design Fundamentals
**State Alignment:** 2.8.4 (Database elements), 8.1.2 (Data abstraction)  
**Textbook:** Chapter 2 (slides 1-20)

**Learning Objectives:**
- Define entities, attributes, and records
- Understand tables, rows (records), and columns (fields)
- Explain primary keys and their importance
- Identify relationships between tables
- Create entity-relationship diagrams (basic)

**Hands-On Activities:**
1. Analyze Titanic dataset structure: What entities? What attributes?
2. Redesign Titanic data with proper normalization
3. Sketch simple ER diagram for a school database
4. Create tables with PRIMARY KEY constraints

**Key Concepts:**
- Entity: thing about which we store data
- Attribute: characteristic of an entity
- Table = Entity | Row = Record/Instance | Column = Attribute/Field
- Primary Key: unique identifier for each record
- Why normalization matters

**Deliverable:**
- **Track A:** Define entities and attributes for a given scenario, create simple ER diagram
- **Track B:** Design a multi-table database with relationships, implement in SQLite

---

### Lesson 5.5: DB Browser for SQLite (Mini-Lesson)
**State Alignment:** 2.8.9 (Differentiate front-end and back-end)  
**Duration:** 30-45 minutes

**Learning Objectives:**
- Install and navigate DB Browser for SQLite
- Visually explore database structure and data
- Use GUI tools alongside JupyterLab workflow
- Write and test queries in Execute SQL tab
- Understand when to use GUI vs. code-based tools

**Hands-On Activities:**
1. Install DB Browser for SQLite
2. Open existing titanic.db database
3. Explore Database Structure tab (see table schemas)
4. Browse Data tab (view records like Excel)
5. Write queries in Execute SQL tab
6. Export query results to CSV

**Key Concepts:**
- GUI tools complement code-based workflows
- Visualization aids understanding
- Different tools for different tasks (exploration vs. automation)
- DB Browser = "training wheels" for seeing what SQL does

**Deliverable:**
- **Track A:** Open database in DB Browser, screenshot 3 explorations (structure, browse, query)
- **Track B:** Use DB Browser to verify database design from Lesson 05, document findings

**Teaching Note:** This is a transition lesson - students can now choose JupyterLab OR DB Browser for exploration tasks. Emphasize DB Browser is great for visual learners and quick exploration, but code (JupyterLab) is better for reproducible work.

---

## 🔄 **PHASE 3: Multi-Table Operations & Relationships**
*Weeks 5-6*

### Lesson 06: SQL Aggregations & Grouping
**State Alignment:** 8.5.4 (Generate reports with calculated fields)

**Learning Objectives:**
- Use aggregate functions: COUNT, SUM, AVG, MIN, MAX
- Group data with GROUP BY
- Filter groups with HAVING
- Create calculated columns
- Map to pandas groupby operations

**Hands-On Activities:**
1. Answer questions: "How many passengers in each class?"
2. Calculate survival rate by gender and class
3. Find average fare by passenger class
4. Build summary reports

**SQL Syntax Covered:**
```sql
SELECT COUNT(*), AVG(column) FROM table;
SELECT column, COUNT(*) FROM table GROUP BY column;
SELECT column, AVG(value) FROM table 
  GROUP BY column HAVING AVG(value) > n;
```

**Deliverable:**
- **Track A:** 8 aggregate queries answering analytical questions
- **Track B:** 12 queries + complex grouping with multiple conditions

---

### Lesson 07: Data Modeling & Relationships
**State Alignment:** 8.1.3, 8.1.4 (Data models, relationships)  
**Textbook:** Chapter 2 (slides 21-41)

**Learning Objectives:**
- Understand one-to-many relationships
- Create foreign keys to link tables
- Design multi-table databases
- Apply business rules to database design
- Practice normalization (1NF, 2NF, 3NF basics)

**Hands-On Activities:**
1. Design a "Library" database (Books, Authors, Patrons, Checkouts)
2. Implement the design in SQLite with proper keys
3. Document business rules
4. Create ER diagram with relationships shown

**Key Concepts:**
- Primary Key vs. Foreign Key
- Referential integrity
- Business rules drive design
- Normalization eliminates redundancy

**Real-World Connection:**
- Companies need related data (customers, orders, products)
- Poor design = data anomalies and errors

**Deliverable:**
- **Track A:** Design 2-table database with relationship, implement with keys
- **Track B:** Design 4-table normalized database, document business rules, create ER diagram

---

### Lesson 08: JOIN Operations
**State Alignment:** 8.5.3 (Retrieve, filter, sort data - multi-table)

**Learning Objectives:**
- Understand why JOINs are necessary
- Write INNER JOIN queries
- Use LEFT JOIN for inclusive queries
- Query across multiple related tables
- Compare SQL JOINs to pandas merge operations

**Hands-On Activities:**
1. Create a multi-table Titanic dataset (split into passengers, tickets, cabins)
2. Write JOINs to reconstruct full information
3. Answer questions requiring data from multiple tables

**SQL Syntax Covered:**
```sql
SELECT * FROM table1 
  INNER JOIN table2 ON table1.key = table2.key;
  
SELECT * FROM table1 
  LEFT JOIN table2 ON table1.key = table2.key;
```

**Deliverable:**
- **Track A:** 6 JOIN queries combining two tables
- **Track B:** 10 JOIN queries including 3-table joins and aggregations

---

## 💾 **PHASE 4: Data Manipulation & Management**
*Weeks 7-8*

### Lesson 09: INSERT, UPDATE, DELETE
**State Alignment:** 8.3.1 (Collect and maintain data)

**Learning Objectives:**
- Add new records with INSERT
- Modify existing data with UPDATE
- Remove data with DELETE
- Understand transaction safety
- Use WHERE with UPDATE/DELETE (critical!)

**Hands-On Activities:**
1. Build a "Student Roster" database from scratch
2. Add students (INSERT)
3. Update grades (UPDATE)
4. Remove withdrawn students (DELETE)
5. Practice with constraints and error handling

**SQL Syntax Covered:**
```sql
INSERT INTO table (col1, col2) VALUES (val1, val2);
UPDATE table SET column = value WHERE condition;
DELETE FROM table WHERE condition;
```

**Safety Focus:**
- Always test WHERE clause with SELECT first
- Understand consequences of UPDATE/DELETE without WHERE
- Transaction concept introduction

**Deliverable:**
- **Track A:** Create and populate a simple database with 20+ records, perform updates
- **Track B:** Build complex database, demonstrate INSERT/UPDATE/DELETE with error handling

---

### Lesson 10: Importing & Exporting Data
**State Alignment:** 8.3.2 (Import large datasets), 8.4.6 (Data migration)

**Learning Objectives:**
- Import CSV files into SQLite
- Export query results to CSV
- Handle data type conversions
- Clean data during import
- Automate data pipeline with Python + SQL

**Hands-On Activities:**
1. Write Python script to import CSV → SQLite
2. Export SQL query results → CSV for analysis
3. Handle missing data and type errors
4. Create ETL (Extract, Transform, Load) workflow

**Code Integration:**
```python
import pandas as pd
import sqlite3

# Import CSV to SQLite
df = pd.read_csv('data.csv')
conn = sqlite3.connect('database.db')
df.to_sql('table_name', conn, if_exists='replace')

# Export SQL query to CSV
query = "SELECT * FROM table WHERE condition"
result = pd.read_sql(query, conn)
result.to_csv('output.csv', index=False)
```

**Deliverable:**
- **Track A:** Import 2 CSV files, export query results
- **Track B:** Build complete ETL pipeline with data validation

---

## 🔐 **PHASE 5: Advanced Topics & Real-World Applications**
*Weeks 9-11*

### Lesson 11: Database Security & Data Integrity
**State Alignment:** 2.8.8, 3.2.1, 9.3.1, 9.3.5 (Security, vulnerabilities)

**Learning Objectives:**
- Explain importance of data security
- Define data integrity constraints
- Implement CHECK, NOT NULL, UNIQUE constraints
- Understand SQL injection attacks and prevention
- Discuss user access control

**Hands-On Activities:**
1. Add constraints to existing tables
2. Demonstrate SQL injection vulnerability
3. Implement parameterized queries (protection)
4. Create sample user roles and permissions

**Security Concepts:**
- Confidentiality, Integrity, Availability (CIA Triad)
- SQL Injection: #1 web application vulnerability
- Always use parameterized queries
- Principle of least privilege

**Code Examples:**
```python
# DANGEROUS - vulnerable to SQL injection
user_input = request.form['username']
query = f"SELECT * FROM users WHERE username = '{user_input}'"

# SAFE - parameterized query
query = "SELECT * FROM users WHERE username = ?"
cursor.execute(query, (user_input,))
```

**Deliverable:**
- **Track A:** Add constraints to database, demonstrate SQL injection risk
- **Track B:** Implement secure database with constraints, write secure Python queries

---

### Lesson 12: Database Design Project (Part 1)
**State Alignment:** 8.1 (Data Modeling), 8.2 (Design and Creation)

**Multi-Week Project Begins**

**Learning Objectives:**
- Apply all learned concepts to real-world scenario
- Design normalized database from requirements
- Document business rules
- Create comprehensive ER diagrams
- Implement database with proper constraints

**Project Options:**
1. **School Management System:** Students, Teachers, Courses, Grades
2. **E-Commerce Platform:** Products, Customers, Orders, Reviews
3. **Library System:** Books, Members, Checkouts, Reservations
4. **Sports League:** Teams, Players, Games, Statistics
5. **Custom (pre-approved)**

**Week 1 Deliverables:**
- Project proposal and scope
- Business rules documentation
- Entity-Relationship Diagram
- Table schemas with data types
- Sample data (at least 10 records per table)

**Rubric Focus:**
- Proper normalization (3NF)
- Correct use of primary/foreign keys
- Constraints for data integrity
- Clear documentation

---

### Lesson 13: Database Design Project (Part 2)
**State Alignment:** 8.3, 8.5 (Data entry, queries)

**Continued Multi-Week Project**

**Learning Objectives:**
- Populate database with realistic data
- Write complex queries for business insights
- Create useful reports and summaries
- Demonstrate JOIN operations across all tables
- Build Python interface for database interaction

**Week 2 Deliverables:**
- Fully populated database (50+ records across tables)
- 15 meaningful SQL queries including:
  - Multi-table JOINs
  - Aggregations and grouping
  - Subqueries
  - Complex WHERE conditions
- Python script for data entry (INSERT) with validation
- Query results exported as reports

**Bonus Challenges (Track B):**
- Create database views for common queries
- Implement stored procedures (if using MySQL/PostgreSQL)
- Build simple web interface (Flask) for database

---

### Lesson 14: Performance & Optimization
**State Alignment:** 8.4.5 (Optimize database for best performance)

**Learning Objectives:**
- Understand database indexing
- Create indexes to speed up queries
- Analyze query performance
- Identify and fix slow queries
- Balance performance vs. storage

**Hands-On Activities:**
1. Compare query times with/without indexes
2. Use EXPLAIN to analyze query execution
3. Create indexes on frequently queried columns
4. Measure performance improvements

**SQL Syntax Covered:**
```sql
CREATE INDEX index_name ON table(column);
EXPLAIN QUERY PLAN SELECT ...;
```

**Key Concepts:**
- Indexes speed up SELECT, slow down INSERT/UPDATE
- Index primary keys and foreign keys
- Don't over-index
- Monitor query performance

**Deliverable:**
- **Track A:** Add indexes to project database, measure performance
- **Track B:** Optimize complex queries, document performance gains

---

## 🎯 **PHASE 6: Professional Skills & Career Readiness**
*Weeks 12-13*

### Lesson 15: Database Administration Basics
**State Alignment:** 8.4 (Database Management)

**Learning Objectives:**
- Perform database backup and recovery
- Understand database maintenance tasks
- Monitor database health
- Plan for growth and scalability
- Discuss cloud database options

**Hands-On Activities:**
1. Backup SQLite database (file copy and SQL dump)
2. Restore from backup
3. Simulate data loss and recovery
4. Explore cloud database options (AWS RDS, Google Cloud SQL)

**Career Connection:**
- Database Administrator (DBA) role
- DevOps and database management
- Cloud database services

**Deliverable:**
- **Track A:** Create backup/recovery procedures
- **Track B:** Document database maintenance plan for project database

---

### Lesson 16: Final Project Presentations & Course Wrap-Up
**State Alignment:** 1.2.5 (Communication), All previous outcomes

**Learning Objectives:**
- Present technical work professionally
- Explain design decisions and trade-offs
- Demonstrate working database application
- Reflect on learning and growth
- Discuss next steps in database learning path

**Final Project Requirements:**
- 10-minute presentation covering:
  - Problem statement and business requirements
  - Database design (ER diagram)
  - Implementation details
  - Query demonstrations
  - Challenges and solutions
  - Lessons learned
- Live demo of working database
- Comprehensive documentation

**Assessment Criteria:**
- Database design quality (40%)
- Implementation correctness (30%)
- Query complexity and usefulness (15%)
- Presentation and documentation (15%)

**Next Steps Discussion:**
- Advanced topics (stored procedures, triggers, transactions)
- Other database systems (PostgreSQL, MongoDB, MySQL)
- Career pathways (DBA, Data Analyst, Backend Developer)
- Industry certifications

---

## 📚 **SUPPLEMENTARY MATERIALS**

### Recommended Resources

**Documentation:**
- SQLite Official Documentation
- W3Schools SQL Tutorial
- Python sqlite3 library docs

**Practice Platforms:**
- SQLZoo (interactive SQL practice)
- LeetCode Database problems
- HackerRank SQL challenges

**Career Resources:**
- BPA Database Design & Application competition prep
- Industry certifications: Oracle SQL, Microsoft SQL Server
- Job shadowing opportunities with local IT departments

---

## 🎓 **STATE STANDARD ALIGNMENT MATRIX**

| Lesson | Strand 2.8 | Strand 8 | Strand 9.3 | Strand 5 |
|--------|-----------|----------|------------|----------|
| 01 | - | - | - | 5.1, 5.2 |
| 02 | - | 8.5 (concept) | - | 5.2 |
| 03 | 2.8.1-2.8.3 | - | - | - |
| 04 | 2.8.6, 2.8.7 | 8.5.1, 8.5.3 | - | - |
| 05 | 2.8.4 | 8.1.2 | - | - |
| 06 | - | 8.5.4 | - | - |
| 07 | 2.8.4 | 8.1.3, 8.1.4, 8.1.7 | - | - |
| 08 | - | 8.5.3 | - | - |
| 09 | - | 8.3.1 | - | 5.5 |
| 10 | - | 8.3.2, 8.4.6 | - | 5.5.7 |
| 11 | 2.8.8 | 8.2.3 | 9.3.1, 9.3.3, 9.3.5 | - |
| 12-13 | All 2.8 | 8.1, 8.2, 8.3, 8.5 | 9.3 | 5.5 |
| 14 | - | 8.4.5 | - | - |
| 15 | 2.8.9 | 8.4.1-8.4.4 | - | - |
| 16 | All | All | - | 1.2.5 |

**Complete Coverage Achieved** ✅

---

## 🛠️ **ASSESSMENT STRATEGY**

### Formative Assessment (Ongoing)
- Jupyter notebooks with embedded questions
- Code reviews and peer feedback
- Class discussions and whiteboard work
- Quick checks at end of each lesson

### Summative Assessment (Graded)
- Task assignments after each lesson (Track A/B differentiation)
- Mid-term project (Lessons 7-8)
- Final project (Lessons 12-13)
- Written exam on database concepts
- Practical SQL exam (timed query challenges)

### Differentiation
- **Track A:** Foundational skills, guided practice, step-by-step instructions
- **Track B:** Advanced challenges, open-ended problems, research components

### Industry Certification Prep
- Lessons align with Certiport IT Specialist Database exam
- Practice problems mirror certification format
- Optional: students can attempt certification

---

## 📅 **PACING GUIDE**

**Total:** 16 weeks (one semester)

- **Weeks 1-2:** Python/Pandas foundations (COMPLETE)
- **Weeks 3-4:** Database concepts and basic SQL
- **Weeks 5-6:** Multi-table operations
- **Weeks 7-8:** Data manipulation
- **Weeks 9-11:** Advanced topics and projects
- **Weeks 12-13:** Professional skills
- **Week 14:** Review and exam prep
- **Week 15:** Final exams and certifications
- **Week 16:** Presentations and course wrap-up

**Flexibility:** Can compress or expand based on student needs and school calendar

---

## 🎯 **SUCCESS METRICS**

Students who complete this course will be able to:

✅ Design normalized relational databases  
✅ Write complex SQL queries (SELECT, JOIN, aggregations)  
✅ Implement databases with proper constraints  
✅ Import/export data programmatically  
✅ Understand database security principles  
✅ Create professional database documentation  
✅ Use Python to interact with databases  
✅ Apply database skills to real-world problems  
✅ Prepare for industry certifications  
✅ Communicate technical concepts effectively  

---

## 📝 **NOTES FOR INSTRUCTOR**

### Teaching Tips
1. **Bridge from Pandas:** Always show pandas equivalent when teaching SQL
2. **Real Data:** Use datasets students find interesting (not just Titanic)
3. **Common Errors:** Build library of common mistakes and solutions
4. **Visual Tools:** Use DB Browser for SQLite for visual understanding
5. **Code Review:** Regular peer code reviews build collaboration

### Classroom Management
- Extended lab periods allow for differentiated work time
- Use GitHub for all submissions (version control practice)
- Pair programming for complex topics
- Guest speakers from industry (DBAs, data analysts)

### Materials Needed
- Jupyter with SQLite and pandas
- DB Browser for SQLite (free)
- Sample datasets (Titanic, library, school, etc.)
- Textbook PowerPoints (Coronel Database Systems 13e)

### Accommodation Strategies
- Visual learners: ER diagrams, database schema diagrams
- Kinesthetic learners: hands-on SQL challenges
- Reading/writing learners: comprehensive notes, documentation practice
- Auditory learners: think-pair-share discussions

---

**END OF PLAN**

*This comprehensive plan bridges Python/pandas to SQL/databases, covers all state standards, and prepares students for both college and career pathways in IT.*
