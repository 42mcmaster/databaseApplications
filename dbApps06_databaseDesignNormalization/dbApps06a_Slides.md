---
marp: true
theme: default
class: invert
paginate: true
---

# Lesson 06a: Why Good Database Design Matters
## Primary Keys, Foreign Keys & Redundancy

**Database Applications Development**
Software Engineering | Medina County Career Center

---

## Today's Big Question

**Why is the NBA database split into 4 tables instead of 1 big table?**

By the end of class, you'll understand:
- What makes a good database design
- How tables connect to each other
- Why we avoid storing duplicate data

---

## Where We Are in the Course

**Lessons 1-2:** Python & pandas ✅
**Lessons 3-4:** SELECT, WHERE, ORDER BY ✅
**Lesson 5:** GROUP BY and aggregations ✅
**Today:** Database design - the foundation 🏗️

---

## Bad Design Example

Imagine ONE table with all NBA data:

```
player_name  | team_name | city        | state | game_date  | pts
LeBron James | Lakers    | Los Angeles | CA    | 2024-01-15 | 28
LeBron James | Lakers    | Los Angeles | CA    | 2024-01-17 | 32
Anthony Davis| Lakers    | Los Angeles | CA    | 2024-01-15 | 22
Anthony Davis| Lakers    | Los Angeles | CA    | 2024-01-17 | 25
```

**See any problems?**

---

## Problem: Data Redundancy

**Redundancy = Storing the same thing over and over**

- "Los Angeles" appears 4 times
- "Lakers" appears 4 times
- "California" appears 4 times

If the Lakers have 82 games x 15 players = **1,230 duplicates!**

**This wastes space and causes real problems.**

---

## Why Redundancy Is Bad

**1. Wasted Storage**
- "Cleveland" stored 82 times instead of once

**2. Update Nightmares**
- Team changes name? Update thousands of rows!
- Miss one? Now your data is wrong!

**3. Typo Risk**
- One person types "Cleaveland" → bad data

---

## Solution: Split Into Tables

```
teams table:
team_id | full_name | city        | state
1       | Lakers    | Los Angeles | CA

team_game_stats table:
game_id | team_id | pts
101     | 1       | 110
102     | 1       | 105
```

Now "Los Angeles" is stored **once** ✅

---

## Primary Keys

**Primary Key = The unique identifier for each row**

Think of it like:
- Your student ID number
- A Social Security Number
- A license plate number

**Why IDs instead of names?**
- Names can be the same (two "John Smith")
- Names can change
- IDs never change!

---

## Primary Key Rules

Every table needs a primary key that is:

1. **Unique** - No duplicates allowed
2. **Never NULL** - Must have a value
3. **Stable** - Doesn't change

```sql
teams:    team_id (PRIMARY KEY) ✅
players:  player_id (PRIMARY KEY) ✅
```

---

## Quick Check

**Which is a better primary key for a students table?**

A) Student's full name
B) Student's email address
C) Student ID number (like 12345)

---

## Answer: C) Student ID number ✅

- Never changes (you keep it all 4 years)
- Guaranteed unique
- Short and simple

---

## Foreign Keys

**Foreign Key = A column that points to another table's primary key**

Think of it as a **link** between tables.

```sql
teams:              team_id (PK)
                       ↑
team_game_stats:    team_id (FK) — points to teams
```

The FK says: "Go look up this team in the teams table!"

---

## Foreign Key Example

```sql
teams table:
team_id | full_name
1       | Cleveland Cavaliers
2       | Golden State Warriors

team_game_stats table:
game_id | team_id | pts
101     | 1       | 110  ← team_id points to teams
102     | 2       | 105
```

Store "Cleveland Cavaliers" **once**, reference it everywhere.

---

## How Tables Connect

**One team → Many games** (most common relationship)

```
teams (30 teams)
  ↓ team_id
team_game_stats (2,460 games)
```

**Storage savings:**
- Bad design: 12,300 team names stored
- Good design: 30 team names stored
- **We save 12,270 duplicates!**

---

## The Update Test

**Scenario:** Lakers change their name

**Bad Design:**
```sql
UPDATE big_table SET team_name = 'LA Lakers'
WHERE team_name = 'Los Angeles Lakers';
-- Update 6,150 rows! ❌
```

**Good Design:**
```sql
UPDATE teams SET full_name = 'LA Lakers'
WHERE team_id = 1610612747;
-- Update 1 row! ✅
```

---

## Three Keys to Good Design

**1. Primary Keys** — Every table needs a unique ID

**2. Foreign Keys** — Connect tables with references

**3. No Duplicates** — Store each fact once

**That's it! These simple rules prevent most problems.**

---

## What You'll Practice Today

**Task (dbApps06a):**
1. Spot redundancy in the NBA database
2. Count how bad it is
3. Find all the primary keys
4. Prove the foreign key connections
5. Map the full relationship structure

**Open your Jupyter notebook and let's go!**
