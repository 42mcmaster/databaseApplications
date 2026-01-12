---
marp: true
theme: default
class: invert
paginate: true
---

# Lesson 06: Database Design & Normalization
## Building Better Databases

## Database Applications Development
### Software Engineering | Medina County Career Center

---

## Learning Objectives

By the end of this lesson, you will be able to:

- Explain principles of good database design
- Apply normalization rules (1NF, 2NF, 3NF)
- Design databases with proper keys
- Create entity-relationship diagrams
- Recognize common relationship types
- Analyze the NBA database structure

**Today:** Learn to design databases that prevent problems!

---

## Where We Are

**Lessons 1-2:** Python & pandas ✅  
**Lessons 3-4:** SELECT, WHERE, ORDER BY ✅  
**Lesson 5:** Aggregations and grouping ✅  
**Today:** Database design - the foundation 🏗️  
**Next:** JOIN operations

**Key idea:** Good design prevents data problems before they happen.

---

## Why Database Design Matters

**Bad design leads to:**
- ❌ Data redundancy (same info stored multiple times)
- ❌ Update anomalies (change one place, miss others)
- ❌ Wasted storage space
- ❌ Slow, complex queries
- ❌ Data inconsistencies

**Good design gives you:**
- ✅ Each fact stored once
- ✅ Easy updates and maintenance
- ✅ Data integrity
- ✅ Fast, simple queries

---

## Bad Design Example

```
Student_Courses Table:
student_id | student_name | email        | course_id | course_name
1          | Alice Smith  | alice@...    | CS101     | Intro to CS
1          | Alice Smith  | alice@...    | MATH200   | Calculus
2          | Bob Jones    | bob@...      | CS101     | Intro to CS
```

**Problems:**
- Student info repeated for each course
- Course info repeated for each student
- If Alice changes email → update multiple rows
- Delete Bob's courses → lose Bob entirely!

---

## Database Design Fundamentals

**Entity:** A thing we store data about
- Examples: Student, Course, Team, Player
- Becomes a **table**

**Attribute:** A property of an entity
- Examples: name, email, city, position
- Becomes a **column**

**Instance:** Specific occurrence
- Examples: One student, one game
- Becomes a **row**

| Concept | Database Term |
|---------|---------------|
| Entity | Table |
| Attribute | Column |
| Instance | Row |

---

## Primary Keys

**Primary Key:** Uniquely identifies each row

**Requirements:**
1. **Unique** - No duplicates
2. **Not NULL** - Must have a value
3. **Stable** - Never changes
4. **Simple** - Prefer single column

**Examples:**
```sql
-- ✅ GOOD
CREATE TABLE players (
    player_id INTEGER PRIMARY KEY,  -- Unique ID
    full_name TEXT
);

-- ❌ BAD
CREATE TABLE students (
    email TEXT PRIMARY KEY  -- Emails can change!
);
```

---

## Natural vs. Surrogate Keys

**Natural Key:** Real-world identifier
- SSN, ISBN, license plate
- **Problem:** Can change, may not exist

**Surrogate Key:** Created just to be the key
- `student_id`, `player_id`, `team_id`
- **Better:** Never changes, always works

**Rule of thumb:** Use surrogate keys for primary keys.

---

## Foreign Keys

**Foreign Key:** Links one table to another

**Purpose:** Establishes relationships

```sql
CREATE TABLE teams (
    team_id INTEGER PRIMARY KEY,
    full_name TEXT
);

CREATE TABLE players (
    player_id INTEGER PRIMARY KEY,
    full_name TEXT,
    team_id INTEGER,  -- ← Foreign key
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);
```

**What this means:**
- Each player belongs to one team
- Can't add player with invalid team_id
- Keeps data consistent

---

## Relationships: One-to-Many (1:M)

**Most common relationship type**

**Definition:** One record in Table A → many records in Table B

**Examples:**
- One team → many players
- One customer → many orders  
- One teacher → many courses

**Implementation:**
- Foreign key in "many" table
- Points to primary key in "one" table

```
teams (1) ←──── (M) team_game_stats
   One team has many game stats
```

---

## Relationships: Many-to-Many (M:N)

**Definition:** Many in A → many in B

**Examples:**
- Students ↔ Courses
- Players ↔ Games
- Authors ↔ Books

**Problem:** Can't directly implement!

**Solution:** Junction table (bridge table)

```
Students ←── Enrollments ───→ Courses

students (1) ←──── (M) enrollments (M) ────→ (1) courses

Result: Students ↔ Courses (M:N)
```

---

## Junction Table Example

```sql
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE courses (
    course_id TEXT PRIMARY KEY,
    name TEXT
);

-- Junction table converts M:N to two 1:M
CREATE TABLE enrollments (
    student_id INTEGER,
    course_id TEXT,
    grade TEXT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
```

---

## Normalization Overview

**Normalization:** Process of organizing data to reduce redundancy

**Goal:** Each piece of information stored exactly once

**Levels:**
- **1NF** - First Normal Form
- **2NF** - Second Normal Form
- **3NF** - Third Normal Form
- (BCNF, 4NF, 5NF...)

**For this course:** Focus on 1NF, 2NF, 3NF
**Industry standard:** Most databases aim for 3NF

---

## First Normal Form (1NF)

**Rule:** Atomic values only. No repeating groups.

**Violations:**

```
-- ❌ Multiple values in one cell
player_id | positions
1         | SF, PF

-- ❌ Repeating columns
team_id | game1_pts | game2_pts | game3_pts
1       | 110       | 105       | 98
```

**Fixed:**

```
-- ✅ One value per cell
player_id | position
1         | SF
1         | PF

-- ✅ Each game is a row
team_id | game_id | pts
1       | 1       | 110
1       | 2       | 105
```

---

## 1NF Requirements

1. Each cell contains one atomic value
2. Each row is unique (has primary key)
3. No repeating column groups
4. Column values are same type

**Test:** Can you split cells further? If yes → not 1NF

---

## Second Normal Form (2NF)

**Rule:** 1NF + all attributes depend on ENTIRE primary key

**Only matters for composite keys!**

**Violation:**

```
Order_Items:
order_id | product_id | quantity | customer_name | product_price
1        | 101        | 2        | Alice         | 29.99

Primary Key: (order_id, product_id)
```

**Problem:**
- `customer_name` depends only on `order_id`
- `product_price` depends only on `product_id`
- **Partial dependency!**

---

## 2NF Fixed

```
Orders:
order_id | customer_name
1        | Alice

Products:
product_id | product_price
101        | 29.99

Order_Items:
order_id | product_id | quantity
1        | 101        | 2
```

**Now:** All attributes depend on entire primary key ✅

---

## Third Normal Form (3NF)

**Rule:** 2NF + no transitive dependencies

**Transitive:** Non-key depends on non-key

**Violation:**

```
Students:
student_id | name  | advisor_id | advisor_name | advisor_office
1          | Alice | 501        | Dr. Johnson  | Building A
2          | Bob   | 502        | Dr. Lee      | Building B
3          | Carol | 501        | Dr. Johnson  | Building A

Primary Key: student_id
```

**Problem:** `advisor_name` → depends on `advisor_id`, not `student_id`

---

## 3NF Fixed

```
Students:
student_id | name  | advisor_id
1          | Alice | 501
2          | Bob   | 502
3          | Carol | 501

Advisors:
advisor_id | advisor_name | advisor_office
501        | Dr. Johnson  | Building A
502        | Dr. Lee      | Building B
```

**Now:** All non-key attributes depend ONLY on primary key ✅

---

## Normalization Summary

**1NF:** Atomic values, no repeating groups

**2NF:** No partial dependencies (composite keys)

**3NF:** No transitive dependencies

**Benefits:**
- Less redundancy
- Easier updates
- Better data integrity

**Trade-off:**
- More tables
- More JOINs
- Potentially more complex queries

---

## Our NBA Database: teams

```sql
CREATE TABLE teams (
    team_id INTEGER PRIMARY KEY,
    full_name TEXT,
    city TEXT,
    state TEXT,
    conference TEXT
);
```

**Analysis:**
- Primary Key: `team_id` ✅
- All attributes depend on `team_id` ✅
- No repeating groups ✅
- No transitive dependencies ✅

**Normalization: 3NF** ✅

---

## Our NBA Database: team_game_stats

```sql
CREATE TABLE team_game_stats (
    game_id TEXT,
    team_id INTEGER,
    season TEXT,
    pts INTEGER,
    wl TEXT,
    PRIMARY KEY (game_id, team_id),
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);
```

**Composite Primary Key:** `(game_id, team_id)`
- Both needed - same game has 2 teams

**Foreign Key:** `team_id` → teams

**Normalization: 2NF/3NF** ✅

---

## Our NBA Database: players

```sql
CREATE TABLE players (
    player_id INTEGER PRIMARY KEY,
    full_name TEXT
);
```

**Question:** Why no `team_id` here?

**Answer:** Players change teams!
- Can't store in players table
- Would need to update constantly
- Historical data would be lost

**Solution:** Store team info in `player_season_stats` ✅

---

## Our NBA Database: player_season_stats

```sql
CREATE TABLE player_season_stats (
    player_id INTEGER,
    team_id INTEGER,
    season TEXT,
    gp INTEGER,
    pts REAL,
    PRIMARY KEY (player_id, team_id, season),
    FOREIGN KEY (player_id) REFERENCES players(player_id),
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);
```

**Composite Primary Key:** `(player_id, team_id, season)`
- Player can play for multiple teams in one season!

**Junction Table:** Links players ↔ teams (M:N)

---

## NBA Database Relationships

**teams ↔ team_game_stats (1:M)**
- One team → many game stats
- FK: `team_id`

**teams ↔ player_season_stats (1:M)**
- One team → many player-seasons
- FK: `team_id`

**players ↔ player_season_stats (1:M)**
- One player → many seasons
- FK: `player_id`

**players ↔ teams (M:N)**
- Through `player_season_stats` junction table
- One player plays for many teams (over career)
- One team has many players (over seasons)

---

## Entity-Relationship Diagram

```
┌─────────────┐              ┌──────────────────────┐
│   teams     │1            M│  team_game_stats     │
│─────────────│──────────────│──────────────────────│
│ team_id (PK)│              │ game_id (PK)         │
│ full_name   │              │ team_id (PK,FK)      │
└─────────────┘              └──────────────────────┘
       │1
       │
       │M
┌──────────────────────┐
│ player_season_stats  │
│──────────────────────│
│ player_id (PK,FK)    │M──┐
│ team_id (PK,FK)      │   │
│ season (PK)          │   │1
└──────────────────────┘   │
       │M              ┌─────────────┐
       │               │   teams     │
       │1              └─────────────┘
┌─────────────┐
│  players    │
└─────────────┘
```

---

## Common Design Patterns

**Pattern 1: Transactions**
- Orders → Order_Items (1:M)

**Pattern 2: Categories**
- Products ↔ Categories (M:N with junction)

**Pattern 3: Hierarchies**
- Employees → manager_id (self-reference)

**Pattern 4: Time-based**
- Player stats by season

**Pattern 5: Audit/History**
- Keep all versions of changes

---

## Design Best Practices

**1. Naming:**
- Tables: plural (`teams`, `orders`)
- Columns: descriptive (`full_name`, not `fn`)
- Keys: standard (`table_id`)

**2. Data Types:**
- INTEGER for IDs and counts
- REAL for measurements
- TEXT for strings

**3. Constraints:**
- PRIMARY KEY always
- FOREIGN KEY for relationships
- NOT NULL for required fields

---

## Design Process

1. **Identify entities** - What things are we tracking?
2. **Identify attributes** - What info about each?
3. **Identify relationships** - How do they connect?
4. **Draw ERD** - Visualize the structure
5. **Normalize** - Apply 1NF, 2NF, 3NF
6. **Refine** - Review and adjust
7. **Implement** - CREATE TABLE statements

---

## Common Design Mistakes

**Mistake 1:** Storing calculated values
```sql
-- ❌ Don't store total = subtotal + tax
-- ✅ Calculate when needed
```

**Mistake 2:** Wide tables instead of related tables
```sql
-- ❌ Don't put customer info in every order
-- ✅ Separate customers table with FK
```

**Mistake 3:** No foreign keys
```sql
-- ❌ Just storing IDs without constraints
-- ✅ FOREIGN KEY enforces relationships
```

---

## When to Denormalize?

**Normalize first** - It's the default

**Denormalize only if:**
- Performance is critical
- Data is mostly read-only
- For reporting/analytics
- Have a good reason!

**Document why** you denormalize
**Test before** and after

**Rule:** Normalize for integrity, denormalize for performance

---

## Today's Workflow

**Part 1: Analysis**
1. Analyze NBA database structure
2. Verify normalization
3. Identify relationships

**Part 2: Design Practice**
4. Normalize poorly designed tables
5. Design new databases from requirements
6. Create ERDs

**Part 3: Documentation**
7. Document design decisions
8. Create Excel diagrams

**You're learning professional database design!**

---

## Real-World Example: Library

**Entities:**
- Books
- Authors  
- Patrons
- Checkouts

**Relationships:**
- Books ↔ Authors (M:N via Book_Authors)
- Books ↔ Checkouts (1:M)
- Patrons ↔ Checkouts (1:M)

**Why this design?**
- Books can have multiple authors
- Track checkout history
- Patron info stored once

---

## Real-World Example: E-Commerce

**Entities:**
- Customers
- Products
- Orders
- Order_Items

**Relationships:**
- Customers → Orders (1:M)
- Orders → Order_Items (1:M)
- Products → Order_Items (1:M)

**Key decision:**
- Store price in Order_Items
- Why? Product prices change
- Keeps history of actual price paid

---

## Tools for Database Design

**Diagramming:**
- dbdiagram.io (recommended!)
- draw.io
- MySQL Workbench
- Lucidchart

**Documentation:**
- README files
- Comments in SQL
- Data dictionaries
- ER diagrams

---

## Practice Questions

1. What makes a good primary key?
2. When do you need a junction table?
3. What's the difference between 1NF and 3NF?
4. Why doesn't `players` table have `team_id`?
5. What's a transitive dependency?

**Discuss as you work on tasks!**

---

## Key Takeaways

✅ **Good design** prevents problems  
✅ **Primary keys** uniquely identify records  
✅ **Foreign keys** link tables  
✅ **1NF:** Atomic values  
✅ **2NF:** No partial dependencies  
✅ **3NF:** No transitive dependencies  
✅ **Relationships:** 1:M, M:N (junction), 1:1  
✅ **Normalize first**, denormalize only if needed  
✅ **ERDs** visualize structure

---

## Today's Tasks

**Part 1:**
- Analyze existing tables
- Identify normalization issues
- Fix bad designs

**Part 2:**
- Design new databases
- Create ERDs
- Document decisions

**Excel:**
- Visual ERD diagrams
- Database documentation

**Let's build better databases!**

---

## Questions?

Before we start the walkthrough:

- Entity vs. attribute clear?
- Primary vs. foreign keys?
- Normalization levels?
- Junction tables for M:N?
- Ready to design?

**Let's see it in action!**
