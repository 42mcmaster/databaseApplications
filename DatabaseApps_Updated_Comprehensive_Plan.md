# Database Applications Development
## UPDATED Comprehensive Curriculum Plan

**Course:** 145085 - Database Applications Development  
**Instructor:** Ryan McMaster
**Institution:** Medina County Career Center  
**Approach:** Pandas → SQL bridge using hands-on projects with real datasets

**Datasets Used:**
- **Titanic** (Lessons 1-4): Single table foundations
- **NBA Stats** (Lessons 5-6): Multi-table introduction, aggregations, normalization
- **IMDb** (Lessons 7+): Complex JOINs, many-to-many relationships

---

## ODE STANDARDS COVERAGE MATRIX

| Strand | Total Competencies | Covered | % Complete | Primary Lessons |
|--------|-------------------|---------|------------|-----------------|
| 1. Business Ops/21st Century | 8 | 8 | 100% | All lessons, esp. 1, 12-13, 16 |
| 2.8 Databases | 9 | 9 | 100% | 3-4, 6-7, 10-11 |
| 2.14 Artificial Intelligence | 2 | 2 | 100% | 5, 14 |
| 3.2 Security Compliance | 1 | 1 | 100% | 11 |
| 5.1 Programming Concepts | 8 | 8 | 100% | 1-2, 9 |
| 5.2 Computational Operations | 4 | 4 | 100% | 1-2 |
| 5.5 Programming Conventions | 7 | 7 | 100% | 8-9, 11 |
| 8.1 Data Modeling | 9 | 9 | 100% | 6-7, 12-13 |
| 8.2 Design and Creation | 3 | 3 | 100% | 6, 8, 12-13 |
| 8.3 Data Entry and Access | 3 | 3 | 100% | 8-9 |
| 8.4 Database Management | 6 | 6 | 100% | 9, 11, 14-15 |
| 8.5 Queries and Transactions | 4 | 4 | 100% | 4-5, 7-8 |
| 9.3 Application Security | 5 | 5 | 100% | 11 |
| **TOTAL** | **69** | **69** | **100%** | **Complete Coverage** |

---

## COURSE OVERVIEW & PACING

**Total Duration:** 16 weeks (one semester)

### Phase Breakdown:
- **Phase 1 (Weeks 1-2):** Python & Pandas Foundations - *Titanic Dataset*
- **Phase 2 (Weeks 3-4):** Database Concepts & SQL Basics - *Titanic Dataset*
- **Phase 3 (Weeks 5-7):** Advanced SQL & Multi-Table Operations - *NBA & IMDb*
- **Phase 4 (Weeks 8-9):** Data Manipulation & Management
- **Phase 5 (Weeks 10-13):** Professional Skills & Advanced Topics
- **Phase 6 (Weeks 14-16):** Review, Projects, & Presentations

---

## **PHASE 1: Python Foundations for Data Work** 
*Weeks 1-2 | Titanic Dataset*

### Lesson 01: JupyterLab & Python Fundamentals 
**State Alignment:** 5.1.1-5.1.2, 5.2.1-5.2.3


**Learning Objectives:**
- Navigate JupyterLab interface
- Create and execute code cells
- Work with Python variables and data types (str, int, float, bool)
- Perform basic operations and calculations
- Use print statements and comments effectively
- Install and import Python libraries (pandas)

**Key Concepts:**
- JupyterLab as interactive development environment
- Variables store data with specific types
- Data types in Python mirror database column types
- Libraries extend Python's capabilities

**Deliverables:**
- ✅ `dbApps01JupyterPythonBasics.md` (detailed lesson)
- ✅ `task01_trackA.ipynb` or `task01_trackB.ipynb`

**Dataset:** Titanic_Dataset.csv (initial exploration)

---

### Lesson 02: Working with DataFrames ✅
**State Alignment:** 8.5.3 (conceptual foundation - queries), 5.2.4

**Learning Objectives:**
- Select specific columns from a DataFrame
- Filter DataFrame rows using boolean conditions
- Sort data by one or more columns
- Calculate basic statistics on filtered data
- Understand how DataFrame operations map to SQL queries

**Key Concepts:**
- Column selection = SQL SELECT
- Boolean filtering = SQL WHERE
- Sorting = SQL ORDER BY
- Aggregations = SQL functions (COUNT, AVG, etc.)

**Deliverables:**
- ✅ `dbApps02WorkingWithDataFrames.md` (detailed lesson)
- ✅ `dbAppsTask02TrackA.ipynb` or `dbAppsTask02TrackB.ipynb`

**Dataset:** Titanic_Dataset.csv (manipulation practice)

---

## **PHASE 2: Database Concepts & SQL Fundamentals** ✅ COMPLETE
*Weeks 3-4 | Titanic Dataset*

### Lesson 03: Introduction to Databases & SQLite ✅
**State Alignment:** 2.8.1, 2.8.2, 2.8.3, 2.8.6, 2.8.7

**Learning Objectives:**
- Define what a database is and explain why we use them
- Differentiate between data and information
- Describe the role and advantages of a DBMS
- Identify different types of databases (relational, NoSQL, cloud, etc.)
- Create a SQLite database from a CSV file
- Write first SQL query
- Compare pandas operations to SQL equivalents

**Key Concepts:**
- Database = organized collection of related data
- DBMS = software that manages databases
- Advantages: reduced redundancy, improved data integrity, data sharing
- SQLite: serverless, file-based, perfect for learning
- Relational databases use tables with rows and columns

**Hands-On Activities:**
1. Convert Titanic DataFrame to SQLite database
2. First SQL query: `SELECT * FROM passengers`
3. Compare pandas `.head()` to SQL `SELECT * LIMIT 5`
4. Explore database structure with PRAGMA commands

**Deliverables:**
- ✅ `dbApps03IntroToDatabasePart1.md` (detailed lesson - concepts)
- ✅ `dbApps03IntroToDatabasePart2.md` (MARP slides)
- ✅ `dbApps03_Walkthrough.ipynb` (hands-on examples)

**Dataset:** Titanic_Dataset.csv → titanic.db

---

### Lesson 04: SQL Basics - SELECT, WHERE, ORDER BY ✅
**State Alignment:** 8.5.1, 8.5.3, 2.8.6

**Learning Objectives:**
- Write SELECT statements to retrieve specific columns
- Use WHERE clause to filter data
- Apply ORDER BY to sort results
- Use LIMIT to control result size
- Combine multiple SQL clauses in one query
- Translate pandas operations to SQL equivalents

**Key SQL Syntax:**
```sql
SELECT column1, column2
FROM table_name
WHERE condition
ORDER BY column ASC/DESC
LIMIT number;
```

**Comparison to Pandas:**
| Pandas | SQL |
|--------|-----|
| `df[['col1', 'col2']]` | `SELECT col1, col2` |
| `df[df['Age'] > 30]` | `WHERE Age > 30` |
| `df.sort_values('Age')` | `ORDER BY Age` |
| `df.head(10)` | `LIMIT 10` |

**Deliverables:**
- ✅ `dbApps04_SQLBasics.md` (detailed lesson)
- ✅ `SQL_Reference_Guide.md` (quick reference)
- ✅ `dbApps04_Walkthrough.ipynb` (examples)
- ✅ `dbApps04Tasks.ipynb` (Track A/B combined or separate)

**Dataset:** titanic.db (passengers table)

---

## **PHASE 3: Advanced SQL & Multi-Table Operations**
*Weeks 5-7*

### Lesson 05: SQL Aggregations, Grouping & AI Applications
**State Alignment:** 8.5.4, 2.14.1, 2.14.2
**Dataset:** NBA Stats Database (nba_5seasons.db)

**Learning Objectives:**
- Use aggregate functions: COUNT(), SUM(), AVG(), MIN(), MAX()
- Group data with GROUP BY clause
- Filter grouped data with HAVING clause
- Create calculated columns and summary statistics
- Compare to pandas `.groupby()` operations
- **NEW:** Understand how databases feed AI/ML systems
- **NEW:** Discuss ethical implications of data-driven AI

**Why Switch to NBA Dataset:**
- Multiple tables (teams, players, team_game_stats, player_season_stats)
- Numeric data perfect for aggregations
- Familiar domain for students
- Real-world relationships to explore

**Hands-On Activities:**
1. Calculate survival statistics by class and gender (Titanic review)
2. **NEW - NBA:** Calculate team season averages (points, rebounds, assists)
3. **NEW - NBA:** Compare player performance across multiple seasons
4. **NEW - NBA:** Analyze win/loss patterns and plus/minus statistics
5. Group by multiple columns (e.g., season + team)
6. Use HAVING to filter groups (e.g., teams with >50 wins)

**AI/ML Integration Module (20-30 minutes):**
```python
# Example: Simple prediction model using database query
import pandas as pd
from sklearn.linear_model import LinearRegression

# Query historical player data
query = """
SELECT pts, reb, ast, fg_pct, age
FROM player_season_stats
WHERE season IN ('2021-22', '2022-23')
"""
data = pd.read_sql(query, conn)

# Predict points based on other stats
X = data[['reb', 'ast', 'fg_pct']]
y = data['pts']
model = LinearRegression().fit(X, y)

# Discussion: How does data quality affect predictions?
# Ethics: Bias in training data, privacy concerns, responsible AI
```

**Key SQL Concepts:**
```sql
-- Aggregate functions
SELECT COUNT(*), AVG(pts), MAX(pts), MIN(pts)
FROM player_season_stats;

-- GROUP BY
SELECT team_id, AVG(pts) as avg_points
FROM team_game_stats
GROUP BY team_id;

-- HAVING (filter groups)
SELECT team_id, COUNT(*) as wins
FROM team_game_stats
WHERE wl = 'W'
GROUP BY team_id
HAVING COUNT(*) > 40;

-- Multiple aggregations
SELECT season, team_id,
       AVG(pts) as avg_pts,
       AVG(reb) as avg_reb,
       AVG(ast) as avg_ast
FROM team_game_stats
GROUP BY season, team_id
ORDER BY avg_pts DESC;
```

**Deliverables:**
- `dbApps05_AggregationsGrouping.md` (detailed lesson)
- `dbApps05_Slides.md` (MARP presentation)
- `dbApps05_Walkthrough.ipynb` (NBA examples + AI module)
- `dbApps05_Tasks_TrackA.ipynb` (10 aggregation queries)
- `dbApps05_Tasks_TrackB.ipynb` (15 queries + complex grouping + ML exploration)

**AI/Ethics Discussion Points:**
- How do sports analytics use databases to predict player performance?
- What biases might exist in sports data?
- Privacy concerns: player health data, performance tracking
- Responsible use of predictive models in hiring/drafting decisions

---

### Lesson 06: Database Design & Normalization
**State Alignment:** 2.8.4, 8.1.2, 8.1.3, 8.1.4, 8.1.5, 8.1.6, 8.1.7, 8.1.8
**Dataset:** NBA Stats Database (analysis) + Student design scenarios

**Learning Objectives:**
- Define entities, attributes, and relationships
- Understand tables, rows, columns, and keys (primary/foreign)
- Explain database normalization (1NF, 2NF, 3NF)
- Identify data redundancy problems
- Create entity-relationship diagrams
- Apply business rules to database design
- Analyze existing normalized database structure

**Why Continue with NBA:**
- Already normalized (4 tables with clear relationships)
- Students can analyze WHY it's designed this way
- Real-world example of dimension tables (teams, players) and fact tables (stats)

**Hands-On Activities:**
1. Analyze NBA database structure:
   - Why separate teams and players tables?
   - Why is team_game_stats not combined with team_game_stats?
   - Identify primary keys: `team_id`, `player_id`, composite keys
   - Trace foreign key relationships
   
2. Compare to denormalized version:
   - What if all data was in one table?
   - Calculate storage waste from redundancy
   - Identify update anomalies
   
3. Design scenarios (students practice):
   - School database (students, courses, teachers, enrollments)
   - Library system (books, authors, patrons, checkouts)
   - E-commerce (customers, products, orders, reviews)

4. Create ER diagrams using:
   - Hand-drawn (paper/whiteboard)
   - Online tools (draw.io, Lucidchart)
   - Text-based (Mermaid notation in markdown)

**Key Concepts:**
- **Entity:** Thing about which we store data (e.g., Team, Player, Game)
- **Attribute:** Characteristic of entity (e.g., team_name, player_height)
- **Relationship:** How entities connect (Team plays in Game, Player on Team)
- **Primary Key:** Unique identifier (team_id, player_id)
- **Foreign Key:** Links tables (team_game_stats.team_id → teams.team_id)

**Normalization Rules:**
- **1NF:** Atomic values, no repeating groups
  - Bad: genres = "Action, Comedy, Drama" (text list)
  - Good: Separate genres table with one row per genre
  
- **2NF:** No partial dependencies (full key determines all attributes)
  - Composite key (season, player_id, team_id)
  - All non-key columns must depend on entire key
  
- **3NF:** No transitive dependencies
  - Non-key columns depend only on the key, not on other non-key columns

**NBA Database Analysis Example:**
```sql
-- Examine NBA structure
PRAGMA table_info(teams);           -- See teams schema
PRAGMA table_info(player_season_stats);  -- See stats schema
PRAGMA foreign_key_list(player_season_stats);  -- See relationships

-- What if it WASN'T normalized? (bad design)
-- Imagine one huge table:
-- game_id, game_date, team_name, team_city, team_state, team_founded,
-- player_name, player_stats...
-- Every game would repeat team info!
-- Every stat line would repeat player info!

-- Benefits of current design:
-- 1. Team info stored once (teams table)
-- 2. Easy to update (change team name in one place)
-- 3. No redundancy
-- 4. Referential integrity (foreign keys prevent orphan records)
```

**Student Design Exercise - School Database:**
```
Entities:
- Students (student_id, name, grade_level, email)
- Teachers (teacher_id, name, subject, hire_date)
- Courses (course_id, course_name, credits, teacher_id)
- Enrollments (enrollment_id, student_id, course_id, grade, semester)

Relationships:
- Teacher teaches many Courses (1:M)
- Student enrolls in many Courses (M:M through Enrollments)
- Course has many Students (M:M through Enrollments)

ER Diagram:
[Students] ----< [Enrollments] >---- [Courses] >---- [Teachers]
```

**Deliverables:**
- `dbApps06_DatabaseDesign.md` (detailed lesson)
- `dbApps06_Slides.md` (MARP presentation)
- `dbApps06_Walkthrough.ipynb` (NBA analysis + design practice)
- `dbApps06_Tasks_TrackA.ipynb` (Design 2-3 table system, create ER diagram)
- `dbApps06_Tasks_TrackB.ipynb` (Design 4-5 table system with 3NF, business rules doc)

**Business Rules Examples:**
- A team must have at least 5 players to play a game
- A player can only be on one team per season
- A game must have exactly two teams
- Player stats must reference valid player_id and team_id

---

### Lesson 07: SQL JOINs - Combining Data from Multiple Tables
**State Alignment:** 8.5.3, 8.1.4
**Dataset:** IMDb Database (imdb_classroom.db)

**Learning Objectives:**
- Understand why JOINs are necessary
- Write INNER JOIN queries to combine related data
- Use LEFT JOIN for inclusive queries
- Apply FULL OUTER JOIN concepts (SQLite limitations)
- Join multiple tables in one query (3-4 tables)
- Handle many-to-many relationships
- Compare SQL JOINs to pandas merge operations

**Why Switch to IMDb:**
- More complex relationships than NBA
- Many-to-many relationships (titles ↔ people through title_principals)
- Multiple join paths available
- Text-based queries more challenging than numeric
- Real-world complexity: multiple directors, multiple actors per title

**IMDb Database Structure:**
```
title_basics (movies/TV shows)
├── title_ratings (1:1 relationship)
└── title_principals (M:M relationship with people)
    └── name_basics (actors, directors, writers)
    
title_crew_person (normalized director/writer links)
```

**Hands-On Activities:**

1. **Simple 2-Table JOINs:**
```sql
-- Get titles with their ratings
SELECT tb.primaryTitle, tr.averageRating, tr.numVotes
FROM title_basics tb
INNER JOIN title_ratings tr ON tb.tconst = tr.tconst
WHERE tr.numVotes > 100000
ORDER BY tr.averageRating DESC
LIMIT 10;
```

2. **3-Table JOINs:**
```sql
-- Find actors in highly-rated movies
SELECT 
    tb.primaryTitle,
    nb.primaryName,
    tp.category,
    tr.averageRating
FROM title_basics tb
INNER JOIN title_ratings tr ON tb.tconst = tr.tconst
INNER JOIN title_principals tp ON tb.tconst = tp.tconst
INNER JOIN name_basics nb ON tp.nconst = nb.nconst
WHERE tr.averageRating >= 8.0
  AND tp.category = 'actor'
ORDER BY tr.averageRating DESC
LIMIT 20;
```

3. **LEFT JOIN (Inclusive):**
```sql
-- All titles, even those without ratings
SELECT tb.primaryTitle, tb.startYear, tr.averageRating
FROM title_basics tb
LEFT JOIN title_ratings tr ON tb.tconst = tr.tconst
WHERE tb.startYear = 2020
ORDER BY tr.averageRating DESC NULLS LAST;
```

4. **Many-to-Many Analysis:**
```sql
-- Directors with multiple highly-rated films
SELECT 
    nb.primaryName as director_name,
    COUNT(DISTINCT tb.tconst) as num_films,
    AVG(tr.averageRating) as avg_rating
FROM name_basics nb
INNER JOIN title_crew_person tcp ON nb.nconst = tcp.nconst
INNER JOIN title_basics tb ON tcp.tconst = tb.tconst
INNER JOIN title_ratings tr ON tb.tconst = tr.tconst
WHERE tcp.role = 'director'
  AND tr.numVotes > 50000
GROUP BY nb.primaryName
HAVING COUNT(DISTINCT tb.tconst) >= 3
ORDER BY avg_rating DESC;
```

5. **Complex Query - Find Common Collaborations:**
```sql
-- Find actors who frequently work together
-- (This requires self-join concepts)
```

**Key SQL Concepts:**

**INNER JOIN:** Only matching records
```sql
SELECT * FROM table1
INNER JOIN table2 ON table1.key = table2.key;
```

**LEFT JOIN:** All from left table + matching from right
```sql
SELECT * FROM table1
LEFT JOIN table2 ON table1.key = table2.key;
```

**Table Aliases:** Improve readability
```sql
SELECT t.primaryTitle, r.averageRating
FROM title_basics t
INNER JOIN title_ratings r ON t.tconst = r.tconst;
```

**Multiple JOIN Paths:**
```
title_basics → title_principals → name_basics (actors/cast)
title_basics → title_crew_person → name_basics (directors/writers)
```

**Comparison to Pandas:**
```python
# Pandas merge
result = pd.merge(titles, ratings, on='tconst', how='inner')

# SQL equivalent
SELECT * FROM titles
INNER JOIN ratings ON titles.tconst = ratings.tconst;
```

**Common Patterns:**
1. **Get related data:** Title + Rating
2. **Lookup dimension info:** Game + Team details
3. **Traverse relationships:** Movie + Director + Director's other films
4. **Aggregate across joins:** Count of actors per genre

**Teaching Strategy:**
- Start with visual diagrams of table relationships
- Build queries incrementally (1 table → 2 tables → 3 tables)
- Show how JOINs can go wrong (Cartesian products)
- Practice reading queries from inside-out

**Deliverables:**
- `dbApps07_SQLJoins.md` (detailed lesson)
- `dbApps07_Slides.md` (MARP presentation)
- `dbApps07_Walkthrough.ipynb` (IMDb JOIN examples)
- `dbApps07_Tasks_TrackA.ipynb` (8 queries, 2-table JOINs)
- `dbApps07_Tasks_TrackB.ipynb` (12 queries, 3-4 table JOINs, complex analysis)
- `imdb_relationship_diagram.png` (visual reference)

**Challenge Questions for Track B:**
- Find all movies where Tom Hanks and Steven Spielberg collaborated
- List genres with highest average ratings
- Identify most prolific actor-director pairs
- Find actors who've worked in the most different genres

---

## **PHASE 4: Data Manipulation & Management**
*Weeks 8-9*

### Lesson 08: INSERT, UPDATE, DELETE & Transactions
**State Alignment:** 8.3.1, 8.5.2, 5.5.1
**Dataset:** Student-created databases

**Learning Objectives:**
- Add new records with INSERT INTO
- Modify existing data with UPDATE
- Remove data with DELETE FROM
- **NEW:** Understand transaction concepts (BEGIN, COMMIT, ROLLBACK)
- **NEW:** Implement multi-step transactions safely
- Use WHERE clause critically with UPDATE/DELETE
- Handle constraint violations and errors
- Compare to pandas data modification

**Why Create New Database:**
- Practice building from scratch
- Safe environment to make mistakes
- Full CRUD (Create, Read, Update, Delete) cycle
- Can use destructive operations without fear

**Hands-On Activities:**

1. **Build "Student Grades" Database:**
```sql
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE,
    grade_level INTEGER,
    enrollment_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE courses (
    course_id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_name TEXT NOT NULL,
    credits INTEGER,
    teacher_name TEXT
);

CREATE TABLE grades (
    grade_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER,
    course_id INTEGER,
    grade REAL,
    semester TEXT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
```

2. **INSERT Operations:**
```sql
-- Single record
INSERT INTO students (name, email, grade_level)
VALUES ('Alice Johnson', 'alice@school.edu', 11);

-- Multiple records
INSERT INTO students (name, email, grade_level) VALUES
('Bob Smith', 'bob@school.edu', 11),
('Carol White', 'carol@school.edu', 12),
('David Brown', 'david@school.edu', 10);

-- Insert with SELECT (copy data)
INSERT INTO honor_roll (student_id, semester)
SELECT student_id, semester
FROM grades
WHERE grade >= 90;
```

3. **UPDATE Operations:**
```sql
-- DANGEROUS: No WHERE clause!
-- UPDATE students SET grade_level = 12;  -- Updates ALL!

-- SAFE: With WHERE clause
UPDATE students
SET grade_level = 12
WHERE student_id = 101;

-- BEST PRACTICE: Test WHERE first
SELECT * FROM students WHERE student_id = 101;  -- Verify
UPDATE students SET grade_level = 12 WHERE student_id = 101;

-- Update multiple columns
UPDATE students
SET grade_level = 12, email = 'newemail@school.edu'
WHERE student_id = 101;

-- Update with calculation
UPDATE grades
SET grade = grade * 1.05  -- Curve: add 5%
WHERE course_id = 201 AND grade < 95;
```

4. **DELETE Operations:**
```sql
-- DANGEROUS: No WHERE clause!
-- DELETE FROM students;  -- Deletes ALL!

-- SAFE: With WHERE clause
DELETE FROM students
WHERE graduation_year < 2020;

-- BEST PRACTICE: Test WHERE first
SELECT * FROM students WHERE graduation_year < 2020;  -- Verify
DELETE FROM students WHERE graduation_year < 2020;
```

5. **NEW - TRANSACTION MANAGEMENT:**

**What is a Transaction?**
- Group of SQL statements that succeed or fail together
- Either ALL changes happen, or NONE do
- Ensures data integrity

**Example: Bank Transfer**
```sql
-- Without transactions (DANGEROUS!)
UPDATE accounts SET balance = balance - 100 WHERE account_id = 1;
-- What if error happens here? First account loses money but second doesn't gain!
UPDATE accounts SET balance = balance + 100 WHERE account_id = 2;

-- With transactions (SAFE!)
BEGIN TRANSACTION;
  UPDATE accounts SET balance = balance - 100 WHERE account_id = 1;
  UPDATE accounts SET balance = balance + 100 WHERE account_id = 2;
  
  -- Check if both succeeded
  -- If any error, we can ROLLBACK
COMMIT;  -- Make changes permanent

-- Or if error:
ROLLBACK;  -- Undo all changes since BEGIN
```

**Transaction Scenarios:**

**Scenario 1: Enrollment System**
```sql
BEGIN TRANSACTION;
  -- Add student to course
  INSERT INTO enrollments (student_id, course_id, semester)
  VALUES (12345, 301, 'Fall 2024');
  
  -- Update course capacity
  UPDATE courses
  SET enrolled_count = enrolled_count + 1
  WHERE course_id = 301;
  
  -- Check if course is full
  -- If full, ROLLBACK; otherwise COMMIT
COMMIT;
```

**Scenario 2: Grade Entry with Validation**
```python
# Python + SQLite transactions
import sqlite3

conn = sqlite3.connect('school.db')
try:
    conn.execute('BEGIN TRANSACTION')
    
    # Insert grade
    conn.execute("""
        INSERT INTO grades (student_id, course_id, grade)
        VALUES (?, ?, ?)
    """, (student_id, course_id, grade))
    
    # Update student GPA
    conn.execute("""
        UPDATE students
        SET gpa = (SELECT AVG(grade) FROM grades WHERE student_id = ?)
        WHERE student_id = ?
    """, (student_id, student_id))
    
    conn.commit()
    print("Grade entered successfully")
    
except Exception as e:
    conn.rollback()
    print(f"Error: {e}. All changes rolled back.")
finally:
    conn.close()
```

**Key Transaction Concepts:**
- **Atomicity:** All or nothing (can't partially complete)
- **Consistency:** Database goes from valid state to valid state
- **Isolation:** Transactions don't interfere with each other
- **Durability:** Committed changes are permanent (ACID properties)

**When to Use Transactions:**
- Multi-step operations that must succeed together
- Financial operations (transfers, purchases)
- Inventory management (reserve item + update stock)
- Any operation where partial completion would cause problems

**SQLite Transaction Notes:**
- Auto-commit mode by default
- `BEGIN` starts explicit transaction
- `COMMIT` saves changes
- `ROLLBACK` undoes changes
- Transactions are per-connection

**Deliverables:**
- `dbApps08_DataManipulation.md` (detailed lesson with transactions)
- `dbApps08_Slides.md` (MARP presentation)
- `dbApps08_Walkthrough.ipynb` (building student database + transactions)
- `dbApps08_Tasks_TrackA.ipynb` (Create DB, INSERT 20+ records, UPDATE/DELETE, simple transactions)
- `dbApps08_Tasks_TrackB.ipynb` (Complex DB, constraints, error handling, multi-step transactions)

**Safety Reminders (Critical!):**
- ⚠️ Always use WHERE with UPDATE/DELETE
- ✅ Test WHERE clause with SELECT first
- ✅ Backup database before destructive operations
- ✅ Use transactions for multi-step operations
- ✅ Practice on test data, not production

**Transaction Practice Exercises:**
- Bank transfer (money movement)
- Course enrollment (add student + update capacity)
- Order processing (create order + update inventory + log shipment)
- Grade posting (insert grade + update GPA + check eligibility)

---

### Lesson 09: Importing & Exporting Data - ETL Workflows
**State Alignment:** 8.3.2, 8.4.6, 5.5.6, 5.5.7
**Dataset:** Various CSV files + NBA/IMDb databases

**Learning Objectives:**
- Import CSV files into SQLite using Python
- Export query results to CSV
- Handle data type conversions and errors
- Clean data during import process
- Automate ETL (Extract, Transform, Load) workflows
- Deal with missing values and data quality issues
- Use pandas + sqlite3 for data pipelines

**Why This Matters:**
- Real-world databases get data from many sources
- CSV is universal exchange format
- ETL is critical skill for data engineers/analysts
- Automation saves time and reduces errors

**Hands-On Activities:**

1. **Basic Import: CSV → SQLite**
```python
import pandas as pd
import sqlite3

# Read CSV
df = pd.read_csv('new_data.csv')

# Quick exploration
print(df.shape)
print(df.info())
print(df.head())

# Connect to database
conn = sqlite3.connect('database.db')

# Write to database
df.to_sql('table_name', conn, if_exists='replace', index=False)

conn.close()
```

2. **Data Cleaning During Import:**
```python
import pandas as pd
import sqlite3

# Read CSV
df = pd.read_csv('messy_data.csv')

# TRANSFORM: Clean the data
# Handle missing values
df['age'] = df['age'].fillna(df['age'].median())
df['name'] = df['name'].fillna('Unknown')

# Remove invalid data
df = df[df['age'] > 0]  # Age must be positive
df = df[df['email'].str.contains('@')]  # Valid emails only

# Standardize text
df['name'] = df['name'].str.strip().str.title()
df['state'] = df['state'].str.upper()

# Convert types
df['date'] = pd.to_datetime(df['date'])
df['price'] = df['price'].astype(float)

# LOAD: Write to database
conn = sqlite3.connect('clean_data.db')
df.to_sql('customers', conn, if_exists='replace', index=False)
conn.close()
```

3. **Export: Database → CSV**
```python
import pandas as pd
import sqlite3

# Connect to database
conn = sqlite3.connect('database.db')

# Run query
query = """
SELECT t.team_name, AVG(g.pts) as avg_points, COUNT(*) as games_played
FROM teams t
INNER JOIN team_game_stats g ON t.team_id = g.team_id
WHERE g.season = '2023-24'
GROUP BY t.team_name
ORDER BY avg_points DESC
"""

# Execute and get results as DataFrame
result = pd.read_sql(query, conn)

# Export to CSV
result.to_csv('team_season_averages_2024.csv', index=False)

conn.close()
```

4. **Complete ETL Pipeline:**
```python
import pandas as pd
import sqlite3
from datetime import datetime

def etl_pipeline(csv_file, db_name, table_name):
    """
    Complete ETL pipeline:
    - Extract from CSV
    - Transform (clean and validate)
    - Load into SQLite database
    """
    
    # EXTRACT
    print(f"Extracting data from {csv_file}...")
    df = pd.read_csv(csv_file)
    print(f"Loaded {len(df)} rows")
    
    # TRANSFORM
    print("Transforming data...")
    
    # Log original count
    original_count = len(df)
    
    # Remove duplicates
    df = df.drop_duplicates()
    
    # Handle missing values
    for col in df.columns:
        if df[col].dtype == 'object':  # Text columns
            df[col] = df[col].fillna('Unknown')
        else:  # Numeric columns
            df[col] = df[col].fillna(df[col].median())
    
    # Add metadata columns
    df['import_date'] = datetime.now()
    df['source_file'] = csv_file
    
    # Log transformation
    print(f"Removed {original_count - len(df)} duplicates")
    print(f"Final record count: {len(df)}")
    
    # LOAD
    print(f"Loading into {db_name}.{table_name}...")
    conn = sqlite3.connect(db_name)
    df.to_sql(table_name, conn, if_exists='append', index=False)
    conn.close()
    
    print("ETL complete!")

# Run pipeline
etl_pipeline('sales_data_2024.csv', 'company.db', 'sales')
```

5. **Handling Errors:**
```python
import pandas as pd
import sqlite3

def safe_import(csv_file, db_name, table_name):
    """Import with error handling"""
    try:
        # Read CSV
        df = pd.read_csv(csv_file)
        
        # Validate required columns
        required_cols = ['id', 'name', 'date']
        missing_cols = [col for col in required_cols if col not in df.columns]
        if missing_cols:
            raise ValueError(f"Missing required columns: {missing_cols}")
        
        # Connect to database
        conn = sqlite3.connect(db_name)
        
        # Write data
        df.to_sql(table_name, conn, if_exists='append', index=False)
        
        print(f"Successfully imported {len(df)} rows")
        conn.close()
        return True
        
    except FileNotFoundError:
        print(f"Error: File '{csv_file}' not found")
        return False
    except ValueError as e:
        print(f"Data validation error: {e}")
        return False
    except sqlite3.Error as e:
        print(f"Database error: {e}")
        return False
    except Exception as e:
        print(f"Unexpected error: {e}")
        return False

# Use it
success = safe_import('data.csv', 'db.db', 'table')
```

6. **Batch Import Multiple Files:**
```python
import pandas as pd
import sqlite3
import glob

# Find all CSV files in directory
csv_files = glob.glob('data/*.csv')

conn = sqlite3.connect('combined_data.db')

for file in csv_files:
    print(f"Importing {file}...")
    df = pd.read_csv(file)
    
    # Add source filename as column
    df['source_file'] = file
    
    # Append to database
    df.to_sql('all_data', conn, if_exists='append', index=False)
    
conn.close()
print(f"Imported {len(csv_files)} files")
```

**Real-World Applications:**

1. **Daily Sales Import:**
   - Retail system exports sales.csv each night
   - ETL script imports to database
   - Cleans data (removes test transactions)
   - Updates summary tables

2. **Data Migration:**
   - Move from old system to new
   - Export from old (CSV)
   - Transform to new schema
   - Import to new database

3. **Report Generation:**
   - Run complex SQL query
   - Export to CSV
   - Email to stakeholders
   - Import to spreadsheet for further analysis

**Common Data Quality Issues:**

| Issue | Solution |
|-------|----------|
| Missing values | Fill with median/mode or "Unknown" |
| Duplicates | `df.drop_duplicates()` |
| Wrong data type | `df['col'].astype(int)` |
| Inconsistent formatting | `.str.strip().str.title()` |
| Invalid data | Filter out: `df = df[df['age'] > 0]` |
| Date formats | `pd.to_datetime()` |

**Performance Tips:**
- Use `chunksize` for very large CSV files
- Create indexes after import (faster than during)
- Use `if_exists='append'` for incremental loads
- Consider COPY/LOAD DATA for huge datasets (PostgreSQL/MySQL)

**Deliverables:**
- `dbApps09_ImportExport.md` (detailed lesson)
- `dbApps09_Slides.md` (MARP presentation)
- `dbApps09_Walkthrough.ipynb` (ETL examples)
- `dbApps09_Tasks_TrackA.ipynb` (Import 2 CSVs, export query results)
- `dbApps09_Tasks_TrackB.ipynb` (Complete ETL pipeline with validation and error handling)
- `sample_messy_data.csv` (for practice)

**Key Skills Developed:**
- Automate repetitive tasks
- Data cleaning and validation
- Error handling
- Documentation of data pipelines
- Quality assurance

---

## **PHASE 5: Professional Skills & Advanced Topics**
*Weeks 10-13*

### Lesson 10: Database Front-Ends & User Interfaces
**State Alignment:** 2.8.5, 2.8.9
**Dataset:** Student project databases

**NEW LESSON - Addresses Critical Standards Gap**

**Learning Objectives:**
- Describe front-end vs. back-end database architecture
- Use DB Browser for SQLite GUI tool
- Create forms for user-friendly data entry
- Build filtered views and reports
- Develop simple Python GUI with tkinter OR web interface with Flask
- Understand client-server model
- Compare GUI tools to code-based approaches

**Why This Lesson:**
- State standards explicitly require front-end/back-end differentiation (2.8.5, 2.8.9)
- Real-world databases need user interfaces
- GUI tools complement programming skills
- Career skill: most end-users don't write SQL

**Front-End vs. Back-End Explained:**

| Back-End (Database) | Front-End (Interface) |
|---------------------|----------------------|
| SQLite, MySQL, PostgreSQL | Forms, web pages, apps |
| Stores data | Displays data |
| SQL queries | Buttons, dropdowns |
| Data integrity rules | User-friendly input |
| Hidden from users | What users interact with |

**Analogy:** Restaurant
- Back-end = Kitchen (where food is made)
- Front-end = Dining room & menu (customer experience)
- Servers = API/connection layer

**Hands-On Activities:**

**Part 1: DB Browser for SQLite (30-45 minutes)**

1. **Install DB Browser:**
   - Download from sqlitebrowser.org
   - Cross-platform (Windows, Mac, Linux)
   - Free and open source

2. **Explore GUI Features:**
   - Open existing database (NBA, IMDb, or student project)
   - **Database Structure tab:** Visual schema
   - **Browse Data tab:** View tables like spreadsheet
   - **Execute SQL tab:** Write and test queries
   - **Edit Pragmas tab:** Database settings

3. **Create Table Using GUI:**
   - Database Structure → Create Table button
   - Add fields with visual editor
   - Set data types via dropdown
   - Define primary key with checkbox
   - Add constraints (NOT NULL, UNIQUE)

4. **Data Entry Through GUI:**
   - Browse Data tab → New Record button
   - Fill in fields in spreadsheet-like view
   - Edit existing records
   - Delete records (with confirmation)

5. **Create Filtered Views:**
   - Save common queries as "views"
   - Example: "High Rated Movies" view
   ```sql
   CREATE VIEW high_rated_movies AS
   SELECT title, year, rating
   FROM movies
   WHERE rating >= 8.0;
   ```

6. **Export Data:**
   - File → Export → CSV/JSON/SQL
   - Useful for sharing or backup

**Part 2: Python GUI with tkinter (Option A - 45-60 minutes)**

**Simple Database Form Example:**
```python
import tkinter as tk
from tkinter import ttk, messagebox
import sqlite3

class StudentDatabaseGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Student Database Manager")
        
        # Connect to database
        self.conn = sqlite3.connect('school.db')
        self.create_widgets()
        self.load_data()
    
    def create_widgets(self):
        # Form frame
        form_frame = ttk.Frame(self.root, padding="10")
        form_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # Labels and entries
        ttk.Label(form_frame, text="Name:").grid(row=0, column=0, sticky=tk.W)
        self.name_entry = ttk.Entry(form_frame, width=30)
        self.name_entry.grid(row=0, column=1)
        
        ttk.Label(form_frame, text="Email:").grid(row=1, column=0, sticky=tk.W)
        self.email_entry = ttk.Entry(form_frame, width=30)
        self.email_entry.grid(row=1, column=1)
        
        ttk.Label(form_frame, text="Grade Level:").grid(row=2, column=0, sticky=tk.W)
        self.grade_spinbox = ttk.Spinbox(form_frame, from_=9, to=12, width=28)
        self.grade_spinbox.grid(row=2, column=1)
        
        # Buttons
        button_frame = ttk.Frame(form_frame)
        button_frame.grid(row=3, column=0, columnspan=2, pady=10)
        
        ttk.Button(button_frame, text="Add Student", command=self.add_student).pack(side=tk.LEFT, padx=5)
        ttk.Button(button_frame, text="Clear", command=self.clear_form).pack(side=tk.LEFT, padx=5)
        
        # Treeview to display students
        self.tree = ttk.Treeview(self.root, columns=('ID', 'Name', 'Email', 'Grade'), show='headings')
        self.tree.heading('ID', text='ID')
        self.tree.heading('Name', text='Name')
        self.tree.heading('Email', text='Email')
        self.tree.heading('Grade', text='Grade')
        self.tree.grid(row=1, column=0, padx=10, pady=10)
    
    def add_student(self):
        name = self.name_entry.get()
        email = self.email_entry.get()
        grade = self.grade_spinbox.get()
        
        if not name or not email:
            messagebox.showerror("Error", "Name and Email are required")
            return
        
        try:
            cursor = self.conn.cursor()
            cursor.execute("""
                INSERT INTO students (name, email, grade_level)
                VALUES (?, ?, ?)
            """, (name, email, grade))
            self.conn.commit()
            messagebox.showinfo("Success", "Student added successfully")
            self.clear_form()
            self.load_data()
        except sqlite3.Error as e:
            messagebox.showerror("Database Error", str(e))
    
    def clear_form(self):
        self.name_entry.delete(0, tk.END)
        self.email_entry.delete(0, tk.END)
        self.grade_spinbox.set(9)
    
    def load_data(self):
        # Clear existing items
        for item in self.tree.get_children():
            self.tree.delete(item)
        
        # Load from database
        cursor = self.conn.cursor()
        cursor.execute("SELECT student_id, name, email, grade_level FROM students")
        for row in cursor.fetchall():
            self.tree.insert('', tk.END, values=row)

# Run application
root = tk.Tk()
app = StudentDatabaseGUI(root)
root.mainloop()
```

**Part 3: Web Interface with Flask (Option B - 45-60 minutes)**

**Simple Web Form Example:**

```python
# app.py
from flask import Flask, render_template, request, redirect
import sqlite3

app = Flask(__name__)

def get_db():
    conn = sqlite3.connect('school.db')
    conn.row_factory = sqlite3.Row
    return conn

@app.route('/')
def index():
    conn = get_db()
    students = conn.execute('SELECT * FROM students ORDER BY name').fetchall()
    conn.close()
    return render_template('index.html', students=students)

@app.route('/add', methods=['GET', 'POST'])
def add_student():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        grade = request.form['grade']
        
        conn = get_db()
        conn.execute("""
            INSERT INTO students (name, email, grade_level)
            VALUES (?, ?, ?)
        """, (name, email, grade))
        conn.commit()
        conn.close()
        
        return redirect('/')
    
    return render_template('add_student.html')

if __name__ == '__main__':
    app.run(debug=True)
```

```html
<!-- templates/index.html -->
<!DOCTYPE html>
<html>
<head>
    <title>Student Database</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid black; padding: 8px; text-align: left; }
        th { background-color: #4CAF50; color: white; }
    </style>
</head>
<body>
    <h1>Student Database</h1>
    <a href="/add">Add New Student</a>
    
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Grade</th>
        </tr>
        {% for student in students %}
        <tr>
            <td>{{ student.student_id }}</td>
            <td>{{ student.name }}</td>
            <td>{{ student.email }}</td>
            <td>{{ student.grade_level }}</td>
        </tr>
        {% endfor %}
    </table>
</body>
</html>
```

**Part 4: Create Reports and Filtered Views**

**SQL Views as "Saved Reports":**
```sql
-- Create view for honor roll
CREATE VIEW honor_roll AS
SELECT s.name, s.grade_level, AVG(g.grade) as gpa
FROM students s
INNER JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id
HAVING AVG(g.grade) >= 90
ORDER BY gpa DESC;

-- Use view like a table
SELECT * FROM honor_roll;

-- Create view for teacher dashboard
CREATE VIEW course_summary AS
SELECT 
    c.course_name,
    COUNT(DISTINCT g.student_id) as enrolled_students,
    AVG(g.grade) as average_grade,
    MIN(g.grade) as lowest_grade,
    MAX(g.grade) as highest_grade
FROM courses c
LEFT JOIN grades g ON c.course_id = g.course_id
GROUP BY c.course_id;
```

**Part 5: Client-Server Architecture Discussion**

**Diagram:**
```
User's Computer (Front-End)          Server (Back-End)
┌─────────────────────┐               ┌─────────────────┐
│  Web Browser        │    Request    │                 │
│  or Desktop App     │ ───────────> │  Web Server     │
│                     │               │  (Flask/Django) │
│  - HTML/CSS         │               │                 │
│  - JavaScript       │    Response   │       ↕         │
│  - Forms/UI         │ <─────────── │                 │
└─────────────────────┘               │  Database       │
                                      │  (SQLite/MySQL) │
                                      └─────────────────┘
```

**Separation of Concerns:**
- **Presentation Layer (Front-End):** What users see and interact with
- **Business Logic Layer:** Process requests, apply rules
- **Data Layer (Back-End):** Store and retrieve data

**Benefits:**
- Different teams can work on front-end and back-end
- Can change UI without changing database
- Can support multiple front-ends (web, mobile app, API)
- Security: users never directly access database

**Career Connections:**
- **Front-End Developer:** HTML/CSS/JavaScript, UI/UX
- **Back-End Developer:** Databases, APIs, server logic
- **Full-Stack Developer:** Both front and back
- **Database Administrator:** Focuses on back-end optimization

**Deliverables:**
- `dbApps10_DatabaseFrontEnds.md` (detailed lesson)
- `dbApps10_Slides.md` (MARP presentation)
- `dbApps10_Walkthrough.ipynb` (DB Browser tutorial + code examples)
- `dbApps10_Tasks_TrackA.ipynb` (Use DB Browser, create simple Python GUI)
- `dbApps10_Tasks_TrackB.ipynb` (Build web interface with Flask, create dashboard)
- `student_database_gui.py` (tkinter example)
- `flask_app/` folder (web interface example)

**Assessment:**
- Screenshots of DB Browser exploration
- Working GUI application (tkinter or Flask)
- Views created for common reports
- Written explanation of front-end vs. back-end architecture

---

### Lesson 11: Database Security, Integrity & Auditing
**State Alignment:** 2.8.8, 3.2.1, 9.3.1, 9.3.3, 9.3.4, 9.3.5, 9.3.8, 8.4.3
**Dataset:** Student databases + security examples

**Learning Objectives:**
- Explain importance of data security (CIA Triad)
- Define data integrity constraints
- Implement CHECK, NOT NULL, UNIQUE constraints
- Understand SQL injection attacks and prevention
- Use parameterized queries for security
- **NEW:** Implement database auditing and logging (8.4.3)
- **NEW:** Discuss application security configuration (9.3.4)
- **NEW:** Understand secure communication paths (9.3.8)
- Discuss user access control principles

**The CIA Triad (Information Security):**
- **Confidentiality:** Only authorized users access data
- **Integrity:** Data is accurate and hasn't been tampered with
- **Availability:** Data is accessible when needed

**Hands-On Activities:**

**Part 1: Data Integrity Constraints (20-30 minutes)**

```sql
-- Create table with constraints
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY AUTOINCREMENT,
    
    -- NOT NULL: Required fields
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    
    -- UNIQUE: No duplicates allowed
    email TEXT UNIQUE NOT NULL,
    
    -- CHECK: Validate data
    age INTEGER CHECK (age >= 18 AND age <= 120),
    salary REAL CHECK (salary > 0),
    department TEXT CHECK (department IN ('Sales', 'IT', 'HR', 'Finance')),
    
    -- DEFAULT: Provide default value
    hire_date DATE DEFAULT CURRENT_DATE,
    status TEXT DEFAULT 'Active' CHECK (status IN ('Active', 'On Leave', 'Terminated'))
);

-- These will FAIL due to constraints:
INSERT INTO employees (first_name, last_name, age, salary)
VALUES ('John', 'Doe', 15, 50000);  -- age < 18

INSERT INTO employees (first_name, last_name, email, age, salary, department)
VALUES ('Jane', 'Smith', 'jane@company.com', 25, -1000, 'Sales');  -- negative salary

-- This will SUCCEED:
INSERT INTO employees (first_name, last_name, email, age, salary, department)
VALUES ('Alice', 'Johnson', 'alice@company.com', 30, 65000, 'IT');
```

**Foreign Key Constraints:**
```sql
-- Enable foreign key enforcement (SQLite)
PRAGMA foreign_keys = ON;

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date DATE,
    
    -- Foreign key constraint
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
      ON DELETE RESTRICT   -- Can't delete customer with orders
      ON UPDATE CASCADE    -- If customer_id changes, update orders too
);

-- This will FAIL if customer 999 doesn't exist:
INSERT INTO orders (customer_id, order_date)
VALUES (999, '2024-01-15');
```

**Part 2: SQL Injection Attack & Prevention (30-40 minutes)**

**What is SQL Injection?**
- #1 web application vulnerability (OWASP Top 10)
- Attacker inserts malicious SQL into input fields
- Can steal, modify, or delete data
- Can bypass authentication

**Example Vulnerable Code:**
```python
# DANGEROUS - NEVER DO THIS!
username = input("Enter username: ")
password = input("Enter password: ")

# Building SQL query with string formatting
query = f"SELECT * FROM users WHERE username = '{username}' AND password = '{password}'"
result = conn.execute(query)

# What if user enters this as username?
# admin' OR '1'='1
# Query becomes:
# SELECT * FROM users WHERE username = 'admin' OR '1'='1' AND password = ''
# The OR '1'='1' makes condition always true!
```

**SQL Injection Attack Scenarios:**
```python
# Scenario 1: Bypass authentication
# User enters: admin' --
# Query becomes: SELECT * FROM users WHERE username = 'admin' --' AND password = ''
# The -- comments out the rest, so password check is skipped!

# Scenario 2: Steal all data
# User enters: ' OR '1'='1
# Query: SELECT * FROM users WHERE username = '' OR '1'='1' AND password = ''
# Returns ALL users!

# Scenario 3: Delete data
# User enters: '; DROP TABLE users; --
# Becomes multiple queries!
```

**SAFE: Parameterized Queries (Prepared Statements)**
```python
# CORRECT - Always use parameterized queries
username = input("Enter username: ")
password = input("Enter password: ")

# Use placeholders (?)
query = "SELECT * FROM users WHERE username = ? AND password = ?"
result = conn.execute(query, (username, password))

# Now user input is treated as DATA, not CODE
# Even if user enters: admin' OR '1'='1
# It looks for username literally equal to: "admin' OR '1'='1"
# Attack is neutralized!
```

**Demonstration Activity:**
1. Create vulnerable login system
2. Show successful SQL injection attack
3. Fix with parameterized queries
4. Attempt attack again (fails)

**Part 3: Database Auditing & Logging (NEW - 20-30 minutes)**
**Addresses Standard 8.4.3**

**Why Audit Logging?**
- Track who changed what when
- Compliance requirements (HIPAA, FERPA, GDPR)
- Investigate security incidents
- Detect suspicious activity

**Audit Log Table:**
```sql
CREATE TABLE audit_log (
    log_id INTEGER PRIMARY KEY AUTOINCREMENT,
    table_name TEXT NOT NULL,
    operation TEXT NOT NULL,  -- INSERT, UPDATE, DELETE
    record_id TEXT,
    user_name TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    old_value TEXT,  -- JSON of old data
    new_value TEXT   -- JSON of new data
);
```

**Manual Logging:**
```python
def update_student_grade(conn, student_id, course_id, new_grade, user):
    # Get old value first
    old_value = conn.execute("""
        SELECT grade FROM grades 
        WHERE student_id = ? AND course_id = ?
    """, (student_id, course_id)).fetchone()
    
    # Update grade
    conn.execute("""
        UPDATE grades 
        SET grade = ? 
        WHERE student_id = ? AND course_id = ?
    """, (new_grade, student_id, course_id))
    
    # Log the change
    conn.execute("""
        INSERT INTO audit_log (table_name, operation, record_id, user_name, old_value, new_value)
        VALUES (?, ?, ?, ?, ?, ?)
    """, ('grades', 'UPDATE', f"{student_id}-{course_id}", user, 
          str(old_value), str(new_grade)))
    
    conn.commit()
```

**Trigger-Based Logging (Automatic):**
```sql
-- Automatically log all student updates
CREATE TRIGGER log_student_updates
AFTER UPDATE ON students
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, operation, record_id, old_value, new_value)
    VALUES (
        'students',
        'UPDATE',
        NEW.student_id,
        json_object('name', OLD.name, 'email', OLD.email, 'grade', OLD.grade_level),
        json_object('name', NEW.name, 'email', NEW.email, 'grade', NEW.grade_level)
    );
END;

-- Automatically log deletions
CREATE TRIGGER log_student_deletes
BEFORE DELETE ON students
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, operation, record_id, old_value)
    VALUES (
        'students',
        'DELETE',
        OLD.student_id,
        json_object('name', OLD.name, 'email', OLD.email, 'grade', OLD.grade_level)
    );
END;
```

**Querying Audit Logs:**
```sql
-- Who changed student 12345 recently?
SELECT * FROM audit_log
WHERE table_name = 'students'
  AND record_id = '12345'
ORDER BY timestamp DESC;

-- All changes by specific user
SELECT * FROM audit_log
WHERE user_name = 'jsmith'
ORDER BY timestamp DESC;

-- Suspicious activity: multiple failed login attempts
SELECT user_name, COUNT(*) as failed_attempts
FROM audit_log
WHERE table_name = 'login_attempts'
  AND operation = 'FAILED'
  AND timestamp > datetime('now', '-1 hour')
GROUP BY user_name
HAVING COUNT(*) >= 5;
```

**Part 4: Application Security Configuration (NEW - 15-20 minutes)**
**Addresses Standard 9.3.4**

**Security Best Practices Checklist:**

**1. Database File Permissions:**
```bash
# Linux/Mac: Restrict database file access
chmod 600 database.db  # Only owner can read/write
chown dbuser:dbgroup database.db
```

**2. Connection Security:**
```python
# Don't hardcode credentials!
# BAD:
conn = sqlite3.connect('database.db')

# BETTER: Use environment variables
import os
db_path = os.getenv('DATABASE_PATH')
conn = sqlite3.connect(db_path)

# For remote databases (MySQL, PostgreSQL):
# Use SSL/TLS connections
import pymysql
conn = pymysql.connect(
    host='db.example.com',
    user=os.getenv('DB_USER'),
    password=os.getenv('DB_PASSWORD'),
    ssl={'ca': '/path/to/ca-cert.pem'}
)
```

**3. Principle of Least Privilege:**
```sql
-- Don't give all permissions to everyone!
-- Create read-only user for reports
GRANT SELECT ON students TO report_user;

-- Create limited user for web app
GRANT SELECT, INSERT, UPDATE ON students TO webapp_user;
-- Don't grant DELETE or DROP!

-- Only DBAs have full access
GRANT ALL PRIVILEGES ON DATABASE school TO admin_user;
```

**4. Input Validation:**
```python
def validate_email(email):
    """Validate email before database insert"""
    if not email or '@' not in email:
        raise ValueError("Invalid email format")
    if len(email) > 100:
        raise ValueError("Email too long")
    return email.lower().strip()

def add_student(name, email, grade):
    # Validate BEFORE hitting database
    if not name or len(name) < 2:
        raise ValueError("Name required")
    
    email = validate_email(email)
    
    if grade not in [9, 10, 11, 12]:
        raise ValueError("Invalid grade level")
    
    # Now safe to insert (also use parameterized query)
    conn.execute("""
        INSERT INTO students (name, email, grade_level)
        VALUES (?, ?, ?)
    """, (name, email, grade))
```

**5. Disable Unnecessary Features:**
```python
# SQLite: Disable extensions if not needed
conn = sqlite3.connect('db.db')
conn.enable_load_extension(False)  # Prevent loading malicious extensions

# MySQL: Disable remote root login
# PostgreSQL: Restrict connections to localhost only
```

**Part 5: Secure Communication Paths (NEW - 10-15 minutes)**
**Addresses Standard 9.3.8**

**Database Connection Security:**

**1. Local (SQLite) - File System Security:**
```python
# SQLite databases are files
# Security = file permissions + application access control
import os
import sqlite3

db_path = 'sensitive_data.db'

# Check file permissions
if os.path.exists(db_path):
    stats = os.stat(db_path)
    print(f"Permissions: {oct(stats.st_mode)}")

# Encrypt SQLite database (requires SQLCipher)
from pysqlcipher3 import dbapi2 as sqlcipher
conn = sqlcipher.connect('encrypted.db')
conn.execute("PRAGMA key='my-secret-password'")
```

**2. Remote (MySQL/PostgreSQL) - Encrypted Connections:**
```python
import pymysql

# INSECURE: Plain text connection
# conn = pymysql.connect(host='db.server.com', user='user', password='pass')

# SECURE: SSL/TLS encrypted connection
conn = pymysql.connect(
    host='db.server.com',
    user='user',
    password='pass',
    ssl={
        'ca': '/path/to/ca-cert.pem',
        'cert': '/path/to/client-cert.pem',
        'key': '/path/to/client-key.pem'
    },
    ssl_verify_cert=True
)
```

**3. Web Application Security:**
```
User's Browser (HTTPS) → Web Server → Database
     │                        │              │
     │    Encrypted (SSL)     │    Local     │
     └───────────────────────>└─────────────>│
```

**Security Layers:**
- **Layer 1:** HTTPS encrypts browser ↔ web server
- **Layer 2:** Web server ↔ database (localhost or VPN/SSL)
- **Layer 3:** Application-level authentication (user login)
- **Layer 4:** Database-level authentication (database user)

**Common Security Mistakes to Avoid:**
```python
# ❌ DON'T: Store passwords in plain text
INSERT INTO users (username, password) VALUES ('alice', 'password123');

# ✅ DO: Hash passwords
import hashlib
password_hash = hashlib.sha256(b'password123').hexdigest()
INSERT INTO users (username, password_hash) VALUES ('alice', password_hash);

# ❌ DON'T: Expose database errors to users
try:
    conn.execute(query)
except Exception as e:
    print(f"Database error: {e}")  # Shows internal details!

# ✅ DO: Log errors, show generic message
try:
    conn.execute(query)
except Exception as e:
    logging.error(f"Database error: {e}")  # Log for admins
    return "An error occurred. Please try again."  # Generic to user

# ❌ DON'T: Allow unlimited query results
SELECT * FROM huge_table;  # Could return millions of rows!

# ✅ DO: Always use LIMIT
SELECT * FROM huge_table LIMIT 100;

# ❌ DON'T: Trust client-side validation only
# JavaScript form validation can be bypassed
# Always validate on server/database too
```

**Compliance & Regulations:**
- **FERPA:** Protect student education records
- **HIPAA:** Protect health information
- **GDPR:** EU data protection (right to deletion, data portability)
- **CCPA:** California data privacy

**Deliverables:**
- `dbApps11_SecurityIntegrity.md` (detailed lesson)
- `dbApps11_Slides.md` (MARP presentation)
- `dbApps11_Walkthrough.ipynb` (demonstrations + auditing setup)
- `dbApps11_Tasks_TrackA.ipynb` (Add constraints, demonstrate SQL injection + fix, basic logging)
- `dbApps11_Tasks_TrackB.ipynb` (Complete audit system with triggers, security checklist, advanced configurations)

**Key Takeaways:**
- Security is not optional - it's a requirement
- Defense in depth: multiple layers of security
- ALWAYS use parameterized queries
- Log important changes for compliance and forensics
- Validate input, encrypt connections, limit privileges
- Stay informed about security best practices

---

### Lesson 12-13: Database Design Project (Multi-Week)
**State Alignment:** 8.1 (all), 8.2 (all), 8.3 (all), 8.5 (all), 1.2.5
**Weeks 11-12**

**Project Overview:**
Students apply all learned concepts to design and implement a complete database system from scratch. This is a capstone project demonstrating mastery of database fundamentals.

**Learning Objectives:**
- Apply data modeling principles to real-world scenario
- Design normalized database (3NF)
- Implement with proper constraints and relationships
- Populate with realistic data
- Write complex queries for business insights
- Build optional front-end interface
- Document design decisions
- Present project to class

**Project Options:**

**1. School Management System**
- **Entities:** Students, Teachers, Courses, Enrollments, Grades, Departments
- **Features:** Course catalog, grade tracking, GPA calculation, teacher assignments
- **Queries:** Honor roll, course popularity, teacher workload, student schedules

**2. E-Commerce Platform**
- **Entities:** Customers, Products, Categories, Orders, Order_Items, Reviews
- **Features:** Shopping cart, order history, inventory tracking, customer reviews
- **Queries:** Top sellers, customer loyalty, inventory alerts, revenue reports

**3. Library Management System**
- **Entities:** Books, Authors, Patrons, Checkouts, Reservations, Fines
- **Features:** Catalog search, checkout/return, overdue tracking, patron history
- **Queries:** Popular books, overdue items, patron statistics, collection analysis

**4. Sports League Management**
- **Entities:** Teams, Players, Games, Stats, Seasons, Coaches
- **Features:** Schedule management, player stats, standings, team rosters
- **Queries:** League leaders, team records, player performance, playoff scenarios

**5. Hospital/Clinic System (Track B)**
- **Entities:** Patients, Doctors, Appointments, Treatments, Medications, Insurance
- **Features:** Appointment scheduling, patient records, billing, prescription tracking
- **Queries:** Doctor availability, patient history, billing reports, medication inventory

**6. Custom Project (Pre-Approved)**
- Students can propose their own project
- Must meet complexity requirements
- Subject to instructor approval

**Project Requirements:**

**Week 1 Deliverables (Lesson 12):**

1. **Project Proposal (1 page)**
   - Project description
   - Real-world problem it solves
   - Target users

2. **Business Rules Documentation**
   - At least 10 business rules
   - Example: "A student cannot enroll in more than 8 courses per semester"
   - Example: "An order must have at least one item"

3. **Entity-Relationship Diagram**
   - Hand-drawn or digital (draw.io, Lucidchart, Mermaid)
   - Show all entities and relationships
   - Indicate cardinality (1:1, 1:M, M:M)
   - Identify primary keys

4. **Table Schemas**
   - SQL CREATE TABLE statements
   - All data types specified
   - Primary keys defined
   - Foreign keys with referential integrity
   - CHECK constraints where appropriate
   - Sample:
   ```sql
   CREATE TABLE students (
       student_id INTEGER PRIMARY KEY AUTOINCREMENT,
       first_name TEXT NOT NULL,
       last_name TEXT NOT NULL,
       email TEXT UNIQUE NOT NULL,
       grade_level INTEGER CHECK (grade_level BETWEEN 9 AND 12),
       gpa REAL CHECK (gpa BETWEEN 0.0 AND 4.0),
       enrollment_date DATE DEFAULT CURRENT_DATE
   );
   ```

5. **Sample Data**
   - At least 10 records per major table
   - Realistic and varied data
   - Demonstrates relationships

**Rubric (Week 1 - 40 points):**
- Project scope appropriate: 5 points
- Business rules clear and complete: 10 points
- ER diagram accurate and professional: 10 points
- Table schemas properly normalized: 10 points
- Sample data realistic: 5 points

---

**Week 2 Deliverables (Lesson 13):**

1. **Fully Populated Database**
   - Minimum 50+ records across all tables
   - Realistic data (use libraries like Faker if needed)
   - Demonstrate all relationships

2. **15 Meaningful SQL Queries** (Track A) / **20 Queries** (Track B)
   - At least 5 queries with JOINs (2+ tables)
   - At least 3 queries with aggregations (GROUP BY)
   - At least 2 queries with subqueries
   - At least 3 queries with complex WHERE (multiple conditions)
   - Each query must answer a business question
   - Example queries:
   ```sql
   -- Business question: Which teachers have the highest average student grades?
   SELECT t.name, AVG(g.grade) as avg_grade, COUNT(DISTINCT s.student_id) as num_students
   FROM teachers t
   INNER JOIN courses c ON t.teacher_id = c.teacher_id
   INNER JOIN enrollments e ON c.course_id = e.course_id
   INNER JOIN grades g ON e.enrollment_id = g.enrollment_id
   INNER JOIN students s ON e.student_id = s.student_id
   GROUP BY t.teacher_id
   HAVING COUNT(DISTINCT s.student_id) >= 10
   ORDER BY avg_grade DESC
   LIMIT 5;
   ```

3. **Python Data Entry Script** (with validation)
   ```python
   def add_student(name, email, grade_level):
       # Validation
       if not validate_email(email):
           raise ValueError("Invalid email")
       if grade_level not in [9, 10, 11, 12]:
           raise ValueError("Invalid grade level")
       
       # Insert with parameterized query
       conn.execute("""
           INSERT INTO students (name, email, grade_level)
           VALUES (?, ?, ?)
       """, (name, email, grade_level))
       conn.commit()
   ```

4. **Query Results as Reports**
   - Export key query results to CSV
   - Create summary report document
   - Include visualizations (optional but encouraged)

5. **Documentation**
   - README with setup instructions
   - Data dictionary (all tables and columns explained)
   - Query explanations (what each query does and why)

**Track B Additional Requirements:**
- Implement database views for common queries
- Create triggers for data validation or auditing
- Build simple front-end (Python GUI or Flask web app)
- Performance optimization (indexes on foreign keys)

**Rubric (Week 2 - 60 points):**
- Database fully populated with quality data: 10 points
- Required queries functional and meaningful: 20 points
- Python scripts work correctly: 10 points
- Reports generated and exported: 5 points
- Documentation complete and clear: 10 points
- Track B: Additional features: 5 points

---

**Presentation (10-minute, can be during Lesson 16):**

**Required Content:**
1. **Problem Statement** (1 min)
   - What real-world problem does this solve?
   - Who would use this system?

2. **Database Design** (3 min)
   - Show ER diagram
   - Explain entities and relationships
   - Discuss normalization decisions

3. **Live Demo** (4 min)
   - Show database structure (DB Browser or code)
   - Run 2-3 impressive queries
   - Demonstrate front-end if built
   - Show sample data

4. **Challenges & Solutions** (1 min)
   - What was hardest?
   - How did you solve problems?

5. **Lessons Learned** (1 min)
   - What would you do differently?
   - What are you proud of?

**Presentation Rubric (20 points):**
- Clear explanation of problem and design: 5 points
- Professional delivery: 5 points
- Working demo: 7 points
- Reflection on process: 3 points

**Total Project Grade: 120 points (40 + 60 + 20)**

**Support Materials:**
- Project planning template
- Sample ER diagrams from each project type
- Query challenge ideas
- Peer review rubric (students evaluate each other's designs)

**Timeline:**
- **Week 1 (Lesson 12):** Design phase, instructor reviews and provides feedback
- **Between weeks:** Work time (in class and homework)
- **Week 2 (Lesson 13):** Implementation phase, instructor helps debug
- **Week 3 (Lesson 16):** Presentations and peer feedback

**Instructor Role:**
- Review Week 1 designs and provide feedback before Week 2
- Hold checkpoint meetings with each student/team
- Provide debugging help during implementation
- Encourage peer collaboration (design reviews)

**Files to Create:**
- `dbApps12-13_ProjectGuide.md` (detailed requirements)
- `dbApps12-13_Slides.md` (kickoff presentation)
- `project_template.md` (structure for students to follow)
- `sample_project_school.ipynb` (complete example)
- `project_rubric.md` (grading criteria)

**This project demonstrates mastery of:**
- Data modeling (Strand 8.1)
- Database design and creation (Strand 8.2)
- Data entry and manipulation (Strand 8.3)
- Complex queries (Strand 8.5)
- Professional communication (Strand 1.2)

---

### Lesson 14: Database Performance & Optimization
**State Alignment:** 8.4.5, 2.14.1 (practical AI applications)

**Learning Objectives:**
- Understand database indexing concepts
- Create indexes to speed up queries
- Analyze query performance with EXPLAIN
- Identify and fix slow queries
- Balance performance vs. storage trade-offs
- Use AI/ML models with optimized database queries
- Apply performance best practices

**Why Performance Matters:**
- Slow queries frustrate users
- Can slow down entire application
- Costs money at scale (server resources)
- Poor performance loses customers

**Hands-On Activities:**

**Part 1: Measuring Query Performance**

```python
import sqlite3
import time

def time_query(conn, query, description):
    """Measure query execution time"""
    start = time.time()
    result = conn.execute(query).fetchall()
    end = time.time()
    elapsed = (end - start) * 1000  # Convert to milliseconds
    print(f"{description}: {elapsed:.2f}ms ({len(result)} rows)")
    return result

# Example
conn = sqlite3.connect('imdb.db')

# Query 1: Without index
time_query(conn, """
    SELECT * FROM title_basics
    WHERE startYear = 2020
""", "Without index")

# Create index
conn.execute("CREATE INDEX idx_year ON title_basics(startYear)")

# Query 2: With index
time_query(conn, """
    SELECT * FROM title_basics
    WHERE startYear = 2020
""", "With index")
```

**Part 2: Understanding Indexes**

**What is an Index?**
- Like an index in a book
- Helps database find data faster
- Trade-off: Faster SELECTs, slower INSERTs/UPDATEs

**When to Create Indexes:**
```sql
-- ✅ Index foreign keys (used in JOINs)
CREATE INDEX idx_team_id ON player_season_stats(team_id);
CREATE INDEX idx_player_id ON player_season_stats(player_id);

-- ✅ Index columns in WHERE clauses
CREATE INDEX idx_startYear ON title_basics(startYear);
CREATE INDEX idx_rating ON title_ratings(averageRating);

-- ✅ Composite indexes for multiple columns
CREATE INDEX idx_season_team ON team_game_stats(season, team_id);

-- ❌ Don't index everything (wastes space, slows INSERT/UPDATE)
-- ❌ Don't index columns with low cardinality (few unique values)
CREATE INDEX idx_wl ON team_game_stats(wl);  -- Only 2 values: W or L
```

**Part 3: EXPLAIN Query Plans**

```sql
-- See how SQLite will execute query
EXPLAIN QUERY PLAN
SELECT tb.primaryTitle, tr.averageRating
FROM title_basics tb
INNER JOIN title_ratings tr ON tb.tconst = tr.tconst
WHERE tr.averageRating > 8.0
ORDER BY tr.averageRating DESC;

-- Output shows:
-- SCAN vs SEARCH (SCAN = slow, SEARCH = uses index)
-- Which indexes are used
-- Join order
```

**Part 4: Optimization Techniques**

**1. Use Proper JOINs**
```sql
-- ❌ Slow: Subquery in SELECT
SELECT 
    name,
    (SELECT AVG(rating) FROM reviews WHERE product_id = p.id) as avg_rating
FROM products p;

-- ✅ Fast: JOIN
SELECT p.name, AVG(r.rating) as avg_rating
FROM products p
LEFT JOIN reviews r ON p.id = r.product_id
GROUP BY p.id;
```

**2. Limit Result Sets**
```sql
-- ❌ Slow: Return everything
SELECT * FROM huge_table;

-- ✅ Fast: Only what you need
SELECT name, email FROM huge_table LIMIT 100;
```

**3. Avoid SELECT ***
```sql
-- ❌ Slower: Get all columns
SELECT * FROM players;

-- ✅ Faster: Only needed columns
SELECT player_id, full_name FROM players;
```

**4. Use EXISTS Instead of IN for Subqueries**
```sql
-- ❌ Slower
SELECT * FROM teams
WHERE team_id IN (SELECT team_id FROM team_game_stats WHERE pts > 120);

-- ✅ Faster
SELECT * FROM teams t
WHERE EXISTS (
    SELECT 1 FROM team_game_stats g 
    WHERE g.team_id = t.team_id AND g.pts > 120
);
```

**Part 5: AI/ML Performance Optimization**

**Efficient Data Loading for Machine Learning:**

```python
import pandas as pd
import sqlite3
from sklearn.linear_model import LinearRegression
import time

# ❌ Inefficient: Load entire table
def slow_ml_pipeline():
    conn = sqlite3.connect('nba.db')
    # Loads everything into memory!
    df = pd.read_sql("SELECT * FROM player_season_stats", conn)
    
    # Only use these columns
    X = df[['reb', 'ast', 'fg_pct']]
    y = df['pts']
    
    model = LinearRegression().fit(X, y)
    conn.close()
    return model

# ✅ Efficient: Query only needed columns
def fast_ml_pipeline():
    conn = sqlite3.connect('nba.db')
    # Only load what we need
    df = pd.read_sql("""
        SELECT reb, ast, fg_pct, pts 
        FROM player_season_stats
        WHERE season IN ('2022-23', '2023-24')
          AND gp > 20
    """, conn)
    
    X = df[['reb', 'ast', 'fg_pct']]
    y = df['pts']
    
    model = LinearRegression().fit(X, y)
    conn.close()
    return model

# Compare performance
start = time.time()
model1 = slow_ml_pipeline()
slow_time = time.time() - start

start = time.time()
model2 = fast_ml_pipeline()
fast_time = time.time() - start

print(f"Slow method: {slow_time:.2f}s")
print(f"Fast method: {fast_time:.2f}s")
print(f"Speedup: {slow_time / fast_time:.1f}x faster")
```

**Batch Processing for Large Datasets:**

```python
# Process data in chunks to avoid memory issues
chunk_size = 10000
for chunk in pd.read_sql(query, conn, chunksize=chunk_size):
    # Process each chunk
    processed = clean_data(chunk)
    # Make predictions
    predictions = model.predict(processed)
    # Store results
    store_results(predictions)
```

**Caching Query Results:**

```python
# Cache expensive query results
import functools

@functools.lru_cache(maxsize=128)
def get_team_stats(team_id, season):
    """Cached database query"""
    conn = sqlite3.connect('nba.db')
    result = pd.read_sql("""
        SELECT AVG(pts), AVG(reb), AVG(ast)
        FROM team_game_stats
        WHERE team_id = ? AND season = ?
    """, conn, params=(team_id, season))
    conn.close()
    return result

# First call: queries database
stats = get_team_stats(1610612739, '2023-24')

# Second call: returns cached result (instant!)
stats = get_team_stats(1610612739, '2023-24')
```

**Part 6: Monitoring & Maintenance**

**Query Performance Checklist:**
- [ ] Add indexes on foreign keys
- [ ] Add indexes on columns in WHERE/ORDER BY
- [ ] Use EXPLAIN to check query plan
- [ ] Avoid SELECT * when possible
- [ ] Use LIMIT to control result size
- [ ] Consider denormalization for read-heavy workloads
- [ ] Archive old data if not needed
- [ ] Vacuum database periodically (SQLite)

**SQLite Maintenance:**
```sql
-- Rebuild database file (reclaim space, optimize)
VACUUM;

-- Analyze tables (update statistics for query optimizer)
ANALYZE;

-- Check integrity
PRAGMA integrity_check;
```

**Deliverables:**
- `dbApps14_Performance.md` (detailed lesson)
- `dbApps14_Slides.md` (MARP presentation)
- `dbApps14_Walkthrough.ipynb` (performance testing + ML optimization)
- `dbApps14_Tasks_TrackA.ipynb` (Add indexes, measure performance improvements)
- `dbApps14_Tasks_TrackB.ipynb` (Optimize complex queries, ML pipeline optimization)

**Performance Exercise:**
- Start with slow queries on large dataset
- Add indexes strategically
- Measure improvements
- Document findings

**Key Takeaways:**
- Indexes are powerful but have trade-offs
- Measure before optimizing (don't guess!)
- Query design matters as much as indexes
- AI/ML models benefit from optimized database queries

---

### Lesson 15: Database Administration & Management
**State Alignment:** 8.4.1, 8.4.2, 8.4.4

**Learning Objectives:**
- Perform database backup and recovery
- Understand database maintenance tasks
- Discuss user access control principles
- Monitor database health and size
- Plan for growth and scalability
- Explore cloud database options
- Understand DBA career role

**Why Database Administration Matters:**
- Data is valuable and must be protected
- Databases require regular maintenance
- Security and access control prevent breaches
- Planning prevents outages and data loss

**Hands-On Activities:**

**Part 1: Backup and Recovery (30-40 minutes)**

**SQLite Backup Methods:**

**Method 1: File Copy (Simplest)**
```python
import shutil
import os
from datetime import datetime

def backup_database(db_file):
    """Create timestamped backup of SQLite database"""
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    backup_file = f"{db_file}.backup_{timestamp}"
    
    shutil.copy2(db_file, backup_file)
    print(f"Backup created: {backup_file}")
    return backup_file

# Create backup
backup_file = backup_database('school.db')
```

**Method 2: SQL Dump (Portable)**
```python
import sqlite3

def dump_database(db_file, output_file):
    """Export database as SQL script"""
    conn = sqlite3.connect(db_file)
    
    with open(output_file, 'w') as f:
        for line in conn.iterdump():
            f.write(f"{line}\n")
    
    conn.close()
    print(f"Database dumped to {output_file}")

# Create SQL dump
dump_database('school.db', 'school_backup.sql')
```

**Method 3: Automated Backups**
```python
import schedule
import time

def daily_backup():
    """Backup database every day at 2 AM"""
    backup_database('production.db')

# Schedule daily backup
schedule.every().day.at("02:00").do(daily_backup)

# Run scheduler (in production, use system scheduler instead)
while True:
    schedule.run_pending()
    time.sleep(60)
```

**Recovery from Backup:**
```python
def restore_database(backup_file, target_file):
    """Restore database from backup"""
    # Safety check
    if os.path.exists(target_file):
        response = input(f"Overwrite {target_file}? (yes/no): ")
        if response.lower() != 'yes':
            print("Restore cancelled")
            return
    
    shutil.copy2(backup_file, target_file)
    print(f"Database restored from {backup_file}")

# Restore from backup
restore_database('school.db.backup_20240115_020000', 'school.db')
```

**Recovery from SQL Dump:**
```python
def restore_from_dump(dump_file, db_file):
    """Restore database from SQL dump"""
    conn = sqlite3.connect(db_file)
    
    with open(dump_file, 'r') as f:
        sql_script = f.read()
    
    conn.executescript(sql_script)
    conn.close()
    print(f"Database restored from {dump_file}")

restore_from_dump('school_backup.sql', 'school_restored.db')
```

**Part 2: User Access Control (20-30 minutes)**

**Principle of Least Privilege:**
- Users should only have permissions they need
- Reduces damage from compromised accounts
- Audit who has access to what

**SQLite Limitations:**
- No built-in user management (file-level security only)
- Use file permissions or application-level controls

**MySQL/PostgreSQL User Management (Concepts):**
```sql
-- Create read-only user
CREATE USER 'report_user'@'localhost' IDENTIFIED BY 'secure_password';
GRANT SELECT ON school.* TO 'report_user'@'localhost';

-- Create app user (limited permissions)
CREATE USER 'webapp'@'localhost' IDENTIFIED BY 'secure_password';
GRANT SELECT, INSERT, UPDATE ON school.students TO 'webapp'@'localhost';
GRANT SELECT, INSERT, UPDATE ON school.grades TO 'webapp'@'localhost';
-- No DELETE or DROP!

-- Create admin user
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'secure_password';
GRANT ALL PRIVILEGES ON school.* TO 'admin'@'localhost';

-- View permissions
SHOW GRANTS FOR 'webapp'@'localhost';

-- Revoke permissions
REVOKE INSERT ON school.students FROM 'webapp'@'localhost';

-- Remove user
DROP USER 'old_user'@'localhost';
```

**Application-Level Access Control (Python):**
```python
class DatabaseManager:
    def __init__(self, db_file, user_role):
        self.conn = sqlite3.connect(db_file)
        self.role = user_role
    
    def execute_query(self, query):
        """Execute query based on user role"""
        query_upper = query.upper().strip()
        
        # Read-only role
        if self.role == 'readonly':
            if not query_upper.startswith('SELECT'):
                raise PermissionError("Read-only users can only SELECT")
        
        # Standard role
        elif self.role == 'standard':
            if query_upper.startswith('DROP') or query_upper.startswith('ALTER'):
                raise PermissionError("Standard users cannot DROP or ALTER")
        
        # Admin can do anything
        elif self.role == 'admin':
            pass
        
        else:
            raise ValueError(f"Unknown role: {self.role}")
        
        return self.conn.execute(query)

# Usage
db = DatabaseManager('school.db', user_role='standard')
db.execute_query("SELECT * FROM students")  # OK
db.execute_query("DROP TABLE students")     # PermissionError!
```

**Part 3: Database Maintenance (20-30 minutes)**

**Monitor Database Size:**
```python
def get_database_size(db_file):
    """Get database file size in MB"""
    size_bytes = os.path.getsize(db_file)
    size_mb = size_bytes / (1024 * 1024)
    print(f"Database size: {size_mb:.2f} MB")
    return size_mb

def get_table_sizes(db_file):
    """Get size of each table"""
    conn = sqlite3.connect(db_file)
    
    # Get all tables
    tables = conn.execute("""
        SELECT name FROM sqlite_master 
        WHERE type='table'
    """).fetchall()
    
    for (table_name,) in tables:
        # Count rows
        count = conn.execute(f"SELECT COUNT(*) FROM {table_name}").fetchone()[0]
        print(f"{table_name}: {count} rows")
    
    conn.close()

get_database_size('school.db')
get_table_sizes('school.db')
```

**Optimize Database (SQLite):**
```python
def maintain_database(db_file):
    """Perform routine maintenance"""
    conn = sqlite3.connect(db_file)
    
    print("Running maintenance...")
    
    # Analyze tables (update statistics)
    conn.execute("ANALYZE")
    print("✓ Analyzed tables")
    
    # Vacuum (rebuild database file, reclaim space)
    conn.execute("VACUUM")
    print("✓ Vacuumed database")
    
    # Check integrity
    result = conn.execute("PRAGMA integrity_check").fetchone()
    if result[0] == 'ok':
        print("✓ Integrity check passed")
    else:
        print(f"⚠ Integrity issues: {result[0]}")
    
    conn.close()
    print("Maintenance complete")

maintain_database('school.db')
```

**Archive Old Data:**
```python
def archive_old_data(conn, table, date_column, archive_before):
    """Move old data to archive table"""
    # Create archive table if doesn't exist
    conn.execute(f"CREATE TABLE IF NOT EXISTS {table}_archive AS SELECT * FROM {table} LIMIT 0")
    
    # Copy old data to archive
    conn.execute(f"""
        INSERT INTO {table}_archive
        SELECT * FROM {table}
        WHERE {date_column} < ?
    """, (archive_before,))
    
    # Delete from main table
    conn.execute(f"DELETE FROM {table} WHERE {date_column} < ?", (archive_before,))
    
    conn.commit()
    print(f"Archived records older than {archive_before}")

# Archive grades older than 2 years
from datetime import datetime, timedelta
two_years_ago = datetime.now() - timedelta(days=730)
archive_old_data(conn, 'grades', 'date', two_years_ago)
```

**Part 4: Monitoring & Alerts**

```python
def health_check(db_file):
    """Check database health"""
    issues = []
    
    # Check file exists
    if not os.path.exists(db_file):
        issues.append("Database file not found!")
        return issues
    
    conn = sqlite3.connect(db_file)
    
    # Check size
    size_mb = os.path.getsize(db_file) / (1024 * 1024)
    if size_mb > 1000:  # Over 1 GB
        issues.append(f"Database very large: {size_mb:.0f} MB")
    
    # Check for missing indexes on foreign keys
    # (Simplified check)
    indexes = conn.execute("SELECT name FROM sqlite_master WHERE type='index'").fetchall()
    if len(indexes) < 3:
        issues.append("Few indexes defined - performance may be poor")
    
    # Check for tables with many rows and no indexes
    tables = conn.execute("SELECT name FROM sqlite_master WHERE type='table'").fetchall()
    for (table_name,) in tables:
        count = conn.execute(f"SELECT COUNT(*) FROM {table_name}").fetchone()[0]
        if count > 10000:
            # Check if table has indexes
            table_indexes = conn.execute(f"""
                SELECT name FROM sqlite_master 
                WHERE type='index' AND tbl_name=?
            """, (table_name,)).fetchall()
            if len(table_indexes) == 0:
                issues.append(f"Table {table_name} has {count} rows but no indexes")
    
    conn.close()
    
    if issues:
        print("⚠ Health Check Issues:")
        for issue in issues:
            print(f"  - {issue}")
    else:
        print("✓ Database health check passed")
    
    return issues

health_check('school.db')
```

**Part 5: Cloud Databases & Scalability (Discussion)**

**Cloud Database Options:**

**1. Database as a Service (DBaaS):**
- **AWS RDS:** Managed MySQL, PostgreSQL, SQL Server
- **Google Cloud SQL:** Managed databases
- **Azure Database:** Microsoft's managed offerings
- **Benefits:** Automatic backups, scaling, security patches

**2. Serverless Databases:**
- **AWS Aurora Serverless:** Auto-scales based on demand
- **Google Cloud Firestore:** NoSQL, serverless
- **Benefits:** Pay per use, no server management

**3. Platform-Specific:**
- **Heroku Postgres:** Easy deployment with web apps
- **MongoDB Atlas:** Managed MongoDB in cloud
- **Supabase:** Open-source Firebase alternative

**Scaling Strategies:**

**Vertical Scaling (Scale Up):**
- Bigger server (more RAM, CPU, disk)
- Simple but has limits
- Can be expensive

**Horizontal Scaling (Scale Out):**
- Multiple database servers
- **Read Replicas:** Copy of main database for read queries
- **Sharding:** Split data across multiple databases
- More complex but handles massive scale

**Replication:**
```
Primary Database (Write)
    ↓ replicate
Replica 1 (Read) → Load Balancer → Application
Replica 2 (Read) ↗
```

**Benefits:**
- Distribute read load across multiple servers
- High availability (if primary fails, promote replica)
- Geographic distribution (servers closer to users)

**Career Path: Database Administrator (DBA)**

**Responsibilities:**
- Install and configure databases
- Monitor performance and optimize
- Backup and recovery
- Security and access control
- Capacity planning
- Disaster recovery planning
- 24/7 on-call for critical issues

**Skills Needed:**
- SQL expertise
- System administration (Linux/Windows)
- Scripting (Python, Bash)
- Monitoring tools
- Cloud platforms
- Security best practices

**Salary:** $70,000 - $150,000+ (US, varies by experience and location)

**Deliverables:**
- `dbApps15_DatabaseAdmin.md` (detailed lesson)
- `dbApps15_Slides.md` (MARP presentation)
- `dbApps15_Walkthrough.ipynb` (backup, maintenance scripts)
- `dbApps15_Tasks_TrackA.ipynb` (Create backup procedures, document maintenance plan)
- `dbApps15_Tasks_TrackB.ipynb` (Automated backup system, monitoring dashboard, cloud research)

**Key Takeaways:**
- Backups are not optional - test restores regularly
- Maintenance prevents problems
- Access control protects data
- Cloud databases simplify administration
- DBA is a valuable and in-demand career

---

## **PHASE 6: Review, Projects, & Career Readiness**
*Weeks 14-16*

### Lesson 16: Final Project Presentations & Course Wrap-Up
**State Alignment:** 1.2.5, All previous outcomes

**Learning Objectives:**
- Present technical work professionally
- Explain design decisions and trade-offs
- Demonstrate working database application
- Reflect on learning and growth
- Discuss next steps in database learning path
- Prepare for industry certifications
- Connect coursework to career opportunities

**Week 16 Schedule:**

**Day 1-2: Presentation Prep & Practice**
- Review presentation requirements
- Practice with peers
- Get feedback
- Polish slides and demos

**Day 3-4: Student Presentations**
- 10 minutes per student/team
- Q&A from class and instructor
- Peer evaluation

**Day 5: Course Wrap-Up & Next Steps**
- Review key concepts
- Discuss career pathways
- Industry certifications
- Course evaluations

**Presentation Requirements (10 minutes):**

**Structure:**
1. **Introduction (1 minute)**
   - Project name and purpose
   - Problem it solves
   - Target audience

2. **Database Design (3 minutes)**
   - Show ER diagram
   - Explain entities and relationships
   - Discuss normalization decisions
   - Highlight interesting design challenges

3. **Live Demonstration (4 minutes)**
   - Show database structure (DB Browser or code)
   - Run 2-3 impressive queries with explanations
   - If built front-end, demonstrate it
   - Show sample data and results

4. **Technical Highlights (1 minute)**
   - Coolest query or feature
   - Performance optimizations
   - Security measures implemented

5. **Reflection (1 minute)**
   - Biggest challenge and how you solved it
   - What you learned
   - What you'd do differently
   - What you're proudest of

**Presentation Tips:**
- Practice timing (10 minutes goes fast!)
- Have backup plan if demo fails
- Speak clearly and make eye contact
- Use visuals (ER diagrams, screenshots)
- Explain WHY, not just WHAT

**Peer Evaluation:**
Students evaluate each other on:
- Clarity of explanation
- Database design quality
- Demo effectiveness
- Professionalism

**Post-Presentation Discussion:**

**Next Steps in Database Learning:**

1. **Advanced SQL:**
   - Window functions (OVER, PARTITION BY)
   - Common Table Expressions (WITH clause)
   - Stored procedures and functions
   - Triggers for automation

2. **Other Database Systems:**
   - **PostgreSQL:** Most advanced open-source
   - **MySQL:** Most popular web database
   - **MongoDB:** Leading NoSQL database
   - **Redis:** In-memory data store

3. **Database in Cloud:**
   - AWS RDS / Aurora
   - Google Cloud SQL
   - Azure SQL Database

4. **Advanced Topics:**
   - Database design patterns
   - Distributed databases
   - Data warehousing
   - Time-series databases

**Career Pathways:**

**1. Database Administrator (DBA)**
- Manage and maintain databases
- Ensure performance and security
- Backup and recovery
- **Salary:** $70,000 - $150,000+
- **Certifications:** Oracle DBA, Microsoft SQL Server

**2. Data Analyst**
- Query databases to extract insights
- Create reports and dashboards
- Support business decisions
- **Salary:** $60,000 - $100,000+
- **Skills:** SQL, Excel, Tableau, Python

**3. Data Engineer**
- Build data pipelines
- Design data warehouses
- ETL (Extract, Transform, Load)
- **Salary:** $90,000 - $150,000+
- **Skills:** SQL, Python, Spark, Cloud platforms

**4. Backend Developer**
- Build APIs that interact with databases
- Design application architecture
- Optimize database queries
- **Salary:** $80,000 - $140,000+
- **Skills:** SQL, Python/Java/Node.js, REST APIs

**5. Data Scientist**
- Use databases to train ML models
- Statistical analysis
- Predictive modeling
- **Salary:** $90,000 - $160,000+
- **Skills:** SQL, Python, Statistics, ML

**Industry Certifications:**

**Entry Level:**
- **Microsoft Technology Associate (MTA): Database Fundamentals**
- **Oracle Database SQL Certified Associate**
- **Certiport IT Specialist: Databases**

**Professional:**
- **Oracle Certified Professional (OCP)**
- **Microsoft Certified: Azure Database Administrator**
- **AWS Certified Database Specialty**
- **MongoDB Certified Developer**

**BPA Competition:**
- Database Design & Application
- Prepares for workplace skills competition

**Real-World Database Applications:**

**Examples to Explore:**
1. **Netflix:** Recommendations based on viewing history
2. **Amazon:** Product catalog and order management
3. **Spotify:** Music catalog and playlists
4. **Instagram:** Photo storage and social graphs
5. **Uber:** Real-time location and ride matching
6. **Healthcare:** Electronic health records (HIPAA compliance)
7. **Banking:** Transactions and fraud detection
8. **Government:** DMV records, tax databases

**Final Reflection Activity:**

**Write a 1-page reflection:**
- What did you know about databases at the start of the semester?
- What's the most valuable thing you learned?
- How will you use these skills in your career?
- What surprised you most?
- What was most challenging?
- What are you proud of accomplishing?

**Course Evaluation:**
Students provide feedback on:
- Course pacing and difficulty
- Most/least helpful lessons
- Project quality
- Suggestions for improvement

**Final Words:**

*"Congratulations on completing Database Applications Development! You've learned skills that are in high demand across every industry. Whether you become a DBA, data analyst, software developer, or pursue any technical career, understanding how data is stored and queried will serve you well. Keep building, keep learning, and remember: every great application is built on a well-designed database."*

**Final Checklist:**
- [ ] Project fully complete and submitted
- [ ] Presentation prepared and practiced
- [ ] Reflection written
- [ ] Course evaluation completed
- [ ] Portfolio updated (add projects to GitHub)
- [ ] Resume updated (add skills: SQL, Python, database design)
- [ ] Thank you notes to peer reviewers

**Deliverables:**
- `dbApps16_FinalPresentations.md` (guide)
- `dbApps16_Slides.md` (wrap-up presentation)
- `presentation_rubric.md` (grading criteria)
- `peer_evaluation_form.md`
- `career_pathways_handout.pdf`
- `certification_guide.pdf`

**Celebration:**
- Share best projects on school social media
- Display ER diagrams in classroom
- Invite guest speaker (local DBA or data professional)
- Pizza party for presentations!

---

## 📚 APPENDICES

### Appendix A: Software & Tools

**Required:**
- **JupyterLab:** Interactive Python environment
- **Python 3.9+:** Programming language
- **pandas:** Data manipulation library
- **sqlite3:** SQLite database (built into Python)

**Recommended:**
- **DB Browser for SQLite:** GUI database tool
- **Git/GitHub:** Version control and submission
- **VS Code:** Code editor (alternative to JupyterLab)
- **Draw.io or Lucidchart:** ER diagram creation

**Optional:**
- **Flask:** Web framework (for front-end lesson)
- **tkinter:** GUI library (for front-end lesson)
- **scikit-learn:** Machine learning (for AI lesson)

### Appendix B: Dataset Information

**Titanic Dataset (Lessons 1-4)**
- **Source:** Kaggle Titanic dataset
- **Size:** 1,309 passengers, 14 columns
- **Use:** Single-table SQL practice
- **Topics:** Historical disaster analysis

**NBA Stats Dataset (Lessons 5-6)**
- **Source:** NBA Stats API (nba_api Python package)
- **Scope:** 5 recent seasons (2021-22 through 2025-26)
- **Size:** 4 tables (teams, players, team_game_stats, player_season_stats)
- **Use:** Multi-table operations, aggregations, normalization
- **Topics:** Sports analytics

**IMDb Dataset (Lessons 7+)**
- **Source:** IMDb Open Datasets
- **Scope:** Movies and TV series (non-adult)
- **Size:** 5 tables (title_basics, title_ratings, name_basics, title_principals, title_crew_person)
- **Use:** Complex JOINs, many-to-many relationships
- **Topics:** Entertainment industry analysis

### Appendix C: Grading Breakdown

**Category Weights:**
- Lesson Tasks (Tracks A/B): 40%
- Database Design Project (Lessons 12-13): 30%
- Final Presentation: 10%
- Participation & Professionalism: 10%
- Final Exam (written + practical): 10%

**Grading Scale:**
- A: 90-100%
- B: 80-89%
- C: 70-79%
- D: 60-69%
- F: Below 60%

### Appendix D: Common SQL Reference

**Essential Commands:**
```sql
-- SELECT basics
SELECT column1, column2 FROM table;
SELECT * FROM table WHERE condition;
SELECT * FROM table ORDER BY column DESC;
SELECT * FROM table LIMIT 10;

-- Aggregations
SELECT COUNT(*), AVG(column), SUM(column) FROM table;
SELECT column, COUNT(*) FROM table GROUP BY column;

-- JOINs
SELECT * FROM table1 
INNER JOIN table2 ON table1.id = table2.id;

SELECT * FROM table1 
LEFT JOIN table2 ON table1.id = table2.id;

-- INSERT, UPDATE, DELETE
INSERT INTO table (col1, col2) VALUES (val1, val2);
UPDATE table SET column = value WHERE condition;
DELETE FROM table WHERE condition;

-- Transactions
BEGIN TRANSACTION;
-- multiple statements
COMMIT;  -- or ROLLBACK;

-- Create table
CREATE TABLE table_name (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE,
    age INTEGER CHECK (age > 0)
);

-- Constraints
PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL, CHECK, DEFAULT
```

### Appendix E: Troubleshooting Guide

**Common Issues:**

**Problem:** "No such table"
**Solution:** Check spelling, verify database file, ensure table was created

**Problem:** "No such column"
**Solution:** Use `PRAGMA table_info(tablename)` to see columns

**Problem:** SQL syntax error
**Solution:** Check clause order (SELECT → FROM → WHERE → ORDER BY → LIMIT)

**Problem:** Import fails (pandas)
**Solution:** Check file path, verify CSV format, check for special characters

**Problem:** Constraint violation
**Solution:** Check data meets constraints (NOT NULL, UNIQUE, CHECK)

**Problem:** Join returns too many rows
**Solution:** Check ON clause, may need DISTINCT

**Problem:** Query very slow
**Solution:** Add indexes, use EXPLAIN QUERY PLAN, limit results

### Appendix F: Additional Resources

**Documentation:**
- [SQLite Official Docs](https://www.sqlite.org/docs.html)
- [pandas Documentation](https://pandas.pydata.org/docs/)
- [DB Browser for SQLite](https://sqlitebrowser.org/)

**Practice:**
- [SQLZoo](https://sqlzoo.net/) - Interactive SQL practice
- [LeetCode Database Problems](https://leetcode.com/problemset/database/)
- [HackerRank SQL](https://www.hackerrank.com/domains/sql)

**Learning:**
- [W3Schools SQL](https://www.w3schools.com/sql/)
- [Mode Analytics SQL Tutorial](https://mode.com/sql-tutorial/)
- [SQL Murder Mystery](https://mystery.knightlab.com/) - Fun learning game

**Career:**
- [BPA Database Design Competition](https://www.bpa.org/)
- [Oracle Certification Paths](https://education.oracle.com/oracle-certification-path)
- [Microsoft Learn (SQL Server)](https://learn.microsoft.com/en-us/sql/)

---

## ✅ COMPLETE STANDARDS COVERAGE ACHIEVED

This updated comprehensive plan provides:
- ✅ **100% coverage** of Ohio Department of Education standards (145085)
- ✅ Progressive learning from **Titanic → NBA → IMDb** datasets
- ✅ **NEW Lesson 10:** Front-End Interfaces (addresses 2.8.5, 2.8.9)
- ✅ **Enhanced Lesson 8:** Transaction management (addresses 8.5.2)
- ✅ **Enhanced Lesson 11:** Auditing and advanced security (addresses 8.4.3, 9.3.4, 9.3.8)
- ✅ **AI/ML integration** in Lessons 5 and 14 (addresses 2.14.1, 2.14.2)
- ✅ Comprehensive project-based learning
- ✅ Career readiness focus throughout
- ✅ Differentiated instruction (Track A/B)

**Ready for implementation!**

---

**END OF COMPREHENSIVE PLAN**

*Document Version: 2.0*  
*Last Updated: January 2026*  
*Prepared by: Ryan McMaster, Software Engineering Instructor*  
*Medina County Career Center*
