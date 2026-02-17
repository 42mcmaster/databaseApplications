---
marp: true
theme: default
class: invert
paginate: true
---

# Lesson 06: Database Design & Normalization
## Building Better Databases

**Database Applications Development**
Software Engineering | Medina County Career Center

---

## Today's Big Question

**Why is the NBA database split into 4 tables instead of 1 big table?**

By the end of class, you'll understand:
- What makes a good database design
- How tables connect to each other
- Why we avoid storing duplicate data

**Let's find out!**

---

## Where We Are in the Course

**Lessons 1-2:** Python & pandas ✅  
**Lessons 3-4:** SELECT, WHERE, ORDER BY ✅  
**Lesson 5:** GROUP BY and aggregations ✅  
**Today:** Database design - the foundation 🏗️  

**Key Idea:** Good design makes EVERYTHING easier!

---

## The NBA Database Structure

We have **4 tables** in our database:

1. **teams** - Team information (30 teams)
2. **players** - Player names (500+ players)
3. **team_game_stats** - Game-by-game team stats
4. **player_season_stats** - Player stats per season

**Question:** Why not put everything in one giant table?

---

## Bad Design Example

Imagine ONE table with all NBA data:

```
player_name  | team_name | city      | state | game_date  | pts
LeBron James | Lakers    | Los Angeles | CA  | 2024-01-15 | 28
LeBron James | Lakers    | Los Angeles | CA  | 2024-01-17 | 32
Anthony Davis| Lakers    | Los Angeles | CA  | 2024-01-15 | 22
Anthony Davis| Lakers    | Los Angeles | CA  | 2024-01-17 | 25
```

**See any problems?** 🤔

---

## Problem: Data Redundancy

**Redundancy = Storing the same thing over and over**

In that bad design:
- "Los Angeles" appears 4 times
- "Lakers" appears 4 times
- "California" appears 4 times

If the Lakers have 82 games × 15 players = **1,230 duplicates!**

**This wastes space and causes problems.**

---

## Problems with Redundancy

**1. Wasted Storage Space**
- "Cleveland" stored 82 times instead of once
- Multiply by 30 teams × 5 seasons = thousands of duplicates!

**2. Update Nightmares**
- Team changes name? Update thousands of rows!
- Miss one? Now you have inconsistent data!

**3. Risk of Typos**
- One person types "Cleaveland"
- Now your data is wrong!

---

## Solution: Split Into Tables

**Good Design:**

```
teams table:
team_id | full_name | city      | state
1       | Lakers    | Los Angeles | CA

team_game_stats table:
game_id | team_id | pts
101     | 1       | 110
102     | 1       | 105
```

**Now:** "Los Angeles" stored **once** ✅

---

## Part 1: Primary Keys

**Primary Key = The unique identifier for each row**

**Think of it like:**
- Student ID number (not your name!)
- Social Security Number
- License plate number

**Why use IDs instead of names?**
- Names can be the same (two "John Smith" students)
- Names can change (marriage, etc.)
- IDs never change!

---

## Primary Key Rules

Every table needs a primary key that is:

1. **Unique** - No duplicates allowed
2. **Never NULL** - Must have a value
3. **Stable** - Never changes

**Examples:**
```sql
teams table:
  team_id (PRIMARY KEY) ✅
  
players table:
  player_id (PRIMARY KEY) ✅
```

---

**NOT good primary keys:**
- Names (can duplicate, can change)
- Emails (can change)
- Addresses (definitely change!)

---

## Check Your Understanding

**Question:** Which would be a better primary key for a students table?

A) Student's full name  
B) Student's email address  
C) Student ID number (like 12345)

**Think:** What if a student changes their email? What if two students have the same name?

---

## Answer

**C) Student ID number** ✅

**Why?**
- Never changes (you keep your ID number all 4 years)
- Guaranteed unique (no two students have same ID)
- Short and simple

**Real world:** Your student ID is 8 digits. Your name might be 50 characters!

---

## Part 2: Foreign Keys

**Foreign Key = A column that points to another table's primary key**

**Think of it like:**
- A link
- A reference
- "Go look in that other table"

**Purpose:** Connects tables together!

---

## Foreign Key Example

```sql
teams table:
team_id | full_name
1       | Cleveland Cavaliers
2       | Golden State Warriors

team_game_stats table:
game_id | team_id | pts
101     | 1       | 110  ← This team_id points to teams table
102     | 2       | 105
```

**The team_id in team_game_stats is a FOREIGN KEY**

It says: "Go look up team #1 in the teams table to see the full name!"

---

## Why Use Foreign Keys?

**Instead of:**
```
game_id | team_name             | pts
101     | Cleveland Cavaliers   | 110
102     | Cleveland Cavaliers   | 95
```

**We do:**
```
game_id | team_id | pts
101     | 1       | 110
102     | 1       | 95
```

---

**Benefits:**
- Store "Cleveland Cavaliers" once instead of 82 times
- Update in one place if name changes
- No risk of typos!

---

## Part 3: How Tables Connect

**Our NBA database connections:**

```
teams (30 teams)
  ↓
  team_id used by...
  ↓
team_game_stats (2,460 games)
```

**One team → Many games**

This is the most common relationship!

---

## Real Numbers: Storage Savings

**Bad Design (everything in one table):**
- "Cleveland Cavaliers" stored 82 times per season
- × 5 seasons = 410 times
- × 30 teams = 12,300 team names stored!

**Good Design (separate tables):**
- "Cleveland Cavaliers" stored 1 time
- Referenced by team_id in games

**We save 12,299 duplicates!** 💾

---

## Part 4: Update Example

**Scenario:** The Lakers change their name to "LA Lakers"

**Bad Design:**
```sql
UPDATE big_table 
SET team_name = 'LA Lakers'
WHERE team_name = 'Los Angeles Lakers';
```
**Result:** Update 6,150 rows! ❌

**Good Design:**
```sql
UPDATE teams
SET full_name = 'LA Lakers'
WHERE team_id = 1610612747;
```
**Result:** Update 1 row! ✅

---

## Why This Matters to You

**Good database design makes your job easier:**

✅ Queries run faster (less data to search)
✅ Updates are simple (change one row)
✅ Data stays consistent (no typos)
✅ Less storage needed (no duplicates)

**Bad database design causes headaches:**

❌ Slow queries (searching through duplicates)
❌ Update nightmares (miss one row → bad data)
❌ Wasted space (storing same thing 1000x)

---

## Part 5: Normalization Intro

Let's watch this video: https://www.youtube.com/watch?v=27VeGN1h0Pw

**Normalization = The process of organizing tables to reduce redundancy**

Three steps (Normal Forms):

**1NF - First Normal Form**
- No repeating groups
- Each cell has only one value

---

**2NF - Second Normal Form**
- Satisfies 1NF
- Non-key columns depend on the ENTIRE primary key
<br>

**3NF - Third Normal Form**
- Satisfies 2NF
- Non-key columns depend ONLY on the primary key

**Each step makes the database cleaner!**

---

## Normalization Example

**BAD - Not Normalized:**
```
coach_table: team_id | full_name | coach1 | coach2 | coach3
            1       | Lakers    | Coach A| Coach B| Coach C
```

Problem: Multiple values in one column

**BETTER - 1NF:**
```
coach_table: team_id | full_name | coach_name
            1       | Lakers    | Coach A
            1       | Lakers    | Coach B
            1       | Lakers    | Coach C
```

---

**BEST - Separate tables (3NF):**
```
teams:  team_id | full_name
        1       | Lakers

coaches: coach_id | coach_name | team_id
         101     | Coach A    | 1
         102     | Coach B    | 1
```

---

## Part 6: Entity-Relationship (ER) Diagrams

**ER Diagram = Visual representation of your database design**

**Shows three things:**
1. **Entities** (boxes) = Your tables
2. **Attributes** (inside boxes) = Your columns
3. **Relationships** (lines) = How tables connect

---

**Example Box:**
```
┌────────────────────┐
│      TEAMS         │
├────────────────────┤
│ PK  team_id        │
│     full_name      │
│     city           │
│     state          │
└────────────────────┘
```

**PK = Primary Key**

---

## Reading Relationships

**One-to-Many (1:M) notation:**

```
TEAMS ────1 : M──── TEAM_GAME_STATS
         "has many"
```

**Left (━━):** Single line = "one"
**Right (┝╾┿╾┥):** Crow's foot = "many"

**Translation:**
- One team has many games
- Each game belongs to one team

**Foreign Key:** team_id in TEAM_GAME_STATS points to TEAMS

---

## NBA Database as ER Diagram

```
┌──────────────┐        ┌──────────────────┐
│    TEAMS     │1:M     │ TEAM_GAME_STATS  │
├──────────────┤────────┤──────────────────┤
│ PK team_id   │        │ PK game_id       │
│    full_name │        │ PK season        │
│    city      │        │ FK team_id ──┐   │
│    state     │        │    points     │   │
└──────────────┘        └──────────────────┘
        ▲
        │ 1:M
┌──────────────┐        ┌──────────────────┐
│   PLAYERS    │1:M     │PLAYER_SEASON_STATS│
├──────────────┤────────┤──────────────────┤
│ PK player_id │        │ PK player_id     │
│    full_name │        │ PK season        │
│    position  │        │ FK team_id       │
│    height    │        │ FK player_id ──┐ │
└──────────────┘        └──────────────────┘
```

---

## The Three Keys to Good Design

**1. Primary Keys**
- Every table needs a unique identifier
- Use ID numbers, not names

**2. Foreign Keys**
- Connect tables together
- Reference the primary key in another table

**3. No Duplicates**
- Store each fact exactly once
- Reference it with foreign keys

**That's it! These simple rules prevent most problems.**

---

## Real-World Example

**Bad:** 
```
Every student record includes full teacher info
(name, email, office, phone)
```
**Problem:** Teacher changes office → update 150 student records!

**Good:**
```
Students table has teacher_id (foreign key)
Teachers table has all teacher info
```
**Now:** Teacher changes office → update 1 teacher record!

---

## NBA Database Summary

**Our 4 tables work together:**

1. **teams** - Team info (stored once per team)
2. **players** - Player info (stored once per player)
3. **team_game_stats** - Uses team_id to reference teams
4. **player_season_stats** - Uses player_id and team_id

**Each fact stored once. Connected with foreign keys.**

**This is good database design!** 🎯

---

## What We'll Practice Today

**Walkthrough:**
- Examine table structures
- Verify primary keys are unique
- Use foreign keys in JOINs
- Calculate storage savings

**Tasks:**
- Part 1: Primary keys, foreign keys, redundancy
- Part 2: Analyze database design decisions

**Let's get started!** 🚀

---

## Questions?

**Remember the key concepts:**
- Primary key = unique ID for each row
- Foreign key = points to another table
- Good design = no duplicate data

**These simple ideas make databases work well!**

Ready for the walkthrough? Let's go! 💪
