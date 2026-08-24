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

**Why is the IMDb database split into 5 tables instead of 1 big table?**

**Where we are:**
Lessons 1-2: Python & pandas | Lessons 3-5: SQL fundamentals
Yesterday: SQL refresh with IMDb data | **Today:** Database design

---

## Whiteboard: What's Wrong With This Table?

```
Student Name | Grade | Class             | Teacher        | Room
Agent 86     | 11    | Algebra 2         | Mr. Lasko      | 118
Agent 86     | 11    | English 12        | Mr. Fitzgerald | 204
Agent 86     | 11    | Software Eng.     | Mr. McMaster   | Lab 3
Mr. Secretary| 11    | Algebra 2         | Mr. Lasko      | 118
Mr. Secretary| 11    | English 12        | Mr. Fitzgerald | 204
Arnold S.    | 12    | Pre-Calculus      | Mrs. Fernholz  | 122
Arnold S.    | 12    | Software Eng.     | Mr. McMaster   | Lab 3
```

**1.** What data is repeated that doesn't need to be?
**2.** If Mr. Fitzgerald moves to Room 210, how many rows do you fix?
**3.** How would YOU split this into smaller tables? *(Draw it on the board!)*

---

## Bad Design: One Giant Table

Imagine cramming ALL IMDb data into a single table:

```
title      | year | rating | runtime | genre        | actor_name         | birth_year | category
Inception  | 2010 | 8.8    | 148     | Sci-Fi       | Leonardo DiCaprio  | 1974       | actor
Inception  | 2010 | 8.8    | 148     | Sci-Fi       | Joseph Gordon-Levitt| 1981      | actor
Inception  | 2010 | 8.8    | 148     | Sci-Fi       | Elliot Page        | 1987       | actor
Inception  | 2010 | 8.8    | 148     | Sci-Fi       | Tom Hardy          | 1977       | actor
Inception  | 2010 | 8.8    | 148     | Sci-Fi       | Ken Watanabe       | 1959       | actor
Inception  | 2010 | 8.8    | 148     | Sci-Fi       | Cillian Murphy     | 1976       | actor
Inception  | 2010 | 8.8    | 148     | Sci-Fi       | Marion Cotillard   | 1975       | actor
Inception  | 2010 | 8.8    | 148     | Sci-Fi       | Michael Caine      | 1933       | actor
Inception  | 2010 | 8.8    | 148     | Sci-Fi       | Christopher Nolan  | 1970       | director
Inception  | 2010 | 8.8    | 148     | Sci-Fi       | Lukas Haas         | 1976       | actor
```

"Inception" appears 10+ times. Its year and rating appear 10+ times.
With 10+ actors? **10+ copies of everything.** Across 19,000 titles? **Massive waste.**

---

## Why Redundancy Is the Enemy

**Redundancy = Storing the same fact over and over**

**Wasted Storage** — "Inception" stored 19 times instead of once

**Update Nightmares** — Title needs fixing? Update 19 rows. Miss one? Inconsistent data.

**Typo Risk** — Someone types "Incepton" in one row. Now searches break.

---

## Solution: Split Into Separate Tables

**Titles — Movies & TV Shows** (`title_basics`):
```
Title ID  | Title     | Release Year | Genre(s)
tt1375666 | Inception | 2010         | Action,Adventure,Sci-Fi
```

**Cast & Crew Credits** (`title_principals`):
```
Title ID  | Person ID | Role Type
tt1375666 | nm0000138 | actor        ← just references the Title ID
tt1375666 | nm1289434 | actor        ← same movie, different person
```

"Inception" stored **once**. Each credit just points to its ID.

---

## Our 5 Tables (with Friendly Names)

| Friendly Name | Table Name | What It Stores | Rows |
|---|---|---|---|
| **Titles — Movies & TV Shows** | `title_basics` | Title, year, genre, runtime | 19,462 |
| **Ratings — Audience Scores** | `title_ratings` | IMDb rating & vote count | 19,462 |
| **People — Actors, Directors & More** | `name_basics` | Names, birth years, professions | 182,015 |
| **Cast & Crew Credits** | `title_principals` | Who worked on what | 364,848 |
| **Directors & Writers** | `title_crew_person` | Directed-by / Written-by credits | 116,970 |

---

## Primary Keys — Unique IDs for Every Row

**Primary Key = The unique identifier for each row**
Like your student ID, a license plate, or a barcode.

**Rules:** Must be unique, never empty (NULL), and stable.

| Table (Friendly Name) | Primary Key | Example |
|---|---|---|
| Titles (`title_basics`) | `tconst` (Title ID) | tt1375666 = Inception |
| People (`name_basics`) | `nconst` (Person ID) | nm0000138 = Leonardo DiCaprio |

**Why IDs instead of names?** Two movies called "The Batman." Two actors named "Chris Evans." IDs never repeat!

---

## Quick Check

**Which is a better primary key for a students table?**

A) Student's full name
B) Student's email address
C) Student ID number (like 12345)

**Answer: C** — Never changes, guaranteed unique, short and simple.
Names can duplicate. Emails can change. IDs just work.

---

## Foreign Keys — Links Between Tables

**Foreign Key = A column that points to another table's primary key**

```
Titles — Movies & TV Shows (title_basics):
  Title ID  | Title
  tt1375666 | Inception

Cast & Crew Credits (title_principals):
  Title ID  | Person ID | Role Type
  tt1375666 | nm0000138 | actor      ← Title ID points to Titles table
  tt1375666 | nm1289434 | actor      ← Person ID points to People table
```

Store "Inception" **once**, reference it everywhere.
Both `Title ID` (tconst) and `Person ID` (nconst) are foreign keys here.

---

## How All 5 Tables Connect

```
Let's take a look at the imdb_schema_chart.md
```

---

## The Update Test

**Bad Design (one big table):**
```sql
UPDATE big_table SET title = 'The Shawshank Redemption'
WHERE title = 'Shawshank Redemption';
-- Update 15+ rows (one per actor/crew)!
```

**Good Design (separate tables):**
```sql
UPDATE title_basics SET primaryTitle = 'The Shawshank Redemption'
WHERE tconst = 'tt0111161';
-- Update 1 row!
```

We save **hundreds of thousands of duplicate entries** across the whole database.

---

## Three Keys to Good Design

**1. Primary Keys** — Every table needs a unique ID (Title ID, Person ID)

**2. Foreign Keys** — Connect tables with references, not copied data

**3. No Duplicates** — Store each fact exactly once



---

## What You'll Practice Today

**Walkthrough (~20 min):**
- Verify primary keys are unique
- Trace foreign key connections between tables
- Calculate the cost of redundancy

**Then: Your task notebook — prove you understand PKs, FKs, and redundancy!**

*Refer to the **Data Dictionary** and **Study Guide** for help and examples*
