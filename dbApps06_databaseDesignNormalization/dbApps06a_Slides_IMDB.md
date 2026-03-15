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

By the end of class, you'll understand:
- What makes a good database design
- How tables connect to each other
- Why we avoid storing duplicate data

---

## Where We Are in the Course

**Lessons 1-2:** Python & pandas
**Lessons 3-5:** SELECT, WHERE, GROUP BY, JOINs
**Yesterday:** SQL refresh with IMDb data
**Today:** Database design — the foundation

---

## Bad Design Example

Imagine ONE table with all IMDb data:

```
title          | year | rating | actor_name    | birth_year | category
Inception      | 2010 | 8.8    | Leonardo DiCaprio | 1974   | actor
Inception      | 2010 | 8.8    | Tom Hardy         | 1977   | actor
Inception      | 2010 | 8.8    | Elliot Page       | 1987   | actor
Interstellar   | 2014 | 8.7    | Matthew McConaughey| 1969  | actor
Interstellar   | 2014 | 8.7    | Anne Hathaway     | 1982  | actress
```

**See any problems?**

---

## Problem: Data Redundancy

**Redundancy = Storing the same thing over and over**

In that bad design:
- "Inception" appears 3 times (once per actor)
- "2010" appears 3 times
- The rating "8.8" appears 3 times

One popular movie with 10 actors = **10 copies of everything!**

Across 19,000 titles × ~19 credits each = **massive waste.**

---

## Why Redundancy Is Bad

**1. Wasted Storage**
- "Inception" stored 10 times instead of once

**2. Update Nightmares**
- Movie title needs fixing? Update hundreds of rows!
- Miss one? Now your data is inconsistent!

**3. Typo Risk**
- Someone types "Incepton" in one row
- Now you have two different titles for the same movie

---

## Solution: Split Into Tables

```
title_basics:
tconst    | primaryTitle | startYear | genres
tt1375666 | Inception    | 2010      | Action,Adventure,Sci-Fi

title_principals:
tconst    | nconst    | category
tt1375666 | nm0000138 | actor
tt1375666 | nm1289434 | actor
```

Now "Inception" is stored **once**.
Each actor just references the movie's ID.

---

## Primary Keys

**Primary Key = The unique identifier for each row**

Think of it like:
- Your student ID number
- A license plate number
- A barcode on a product

**IMDb uses:**
- `tconst` for titles (like "tt1375666")
- `nconst` for people (like "nm0000138")

---

## Primary Key Rules

Every primary key must be:

1. **Unique** — No duplicates allowed
2. **Never NULL** — Must have a value
3. **Stable** — Doesn't change

```
title_basics:   tconst (PRIMARY KEY)
name_basics:    nconst (PRIMARY KEY)
```

**Why IDs instead of names?**
Two movies called "The Batman." Two actors named "Chris Evans."
IDs never repeat!

---

## Quick Check

**Which is a better primary key for a students table?**

A) Student's full name
B) Student's email address
C) Student ID number (like 12345)

---

## Answer: C) Student ID number

- Never changes (you keep it all 4 years)
- Guaranteed unique
- Short and simple

Names can duplicate. Emails can change.
IDs just work.

---

## Foreign Keys

**Foreign Key = A column that points to another table's primary key**

Think of it as a **link** between tables.

```
title_basics:       tconst (PK)
                       ↑
title_principals:   tconst (FK) — points to title_basics
```

The FK says: "Go look up this title in the title_basics table!"

---

## Foreign Key Example

```
title_basics:
tconst    | primaryTitle
tt1375666 | Inception

title_principals:
tconst    | nconst    | category
tt1375666 | nm0000138 | actor      ← tconst points to title_basics
tt1375666 | nm1289434 | actor      ← same tconst, different person
```

Store "Inception" **once**, reference it everywhere.
The `nconst` is ALSO a foreign key — it points to `name_basics`.

---

## How Tables Connect

**Our IMDb database connections:**

```
title_basics (19,462 titles)
  ↓ tconst
title_principals (364,848 credits)
  ↑ nconst
name_basics (182,015 people)
```

**One title → Many credits** (most common relationship)

This is called a **One-to-Many** relationship.

---

## The Update Test

**Scenario:** A movie title needs to be corrected

**Bad Design (one big table):**
```sql
UPDATE big_table SET title = 'The Shawshank Redemption'
WHERE title = 'Shawshank Redemption';
-- Update 15 rows (one per actor/crew)!
```

**Good Design (separate tables):**
```sql
UPDATE title_basics SET primaryTitle = 'The Shawshank Redemption'
WHERE tconst = 'tt0111161';
-- Update 1 row!
```

---

## Real Numbers: Storage Savings

**Bad Design (everything in one table):**
- "Inception" stored 19 times (once per credit)
- × 19,462 titles = millions of duplicated strings!

**Good Design (our 5 tables):**
- "Inception" stored 1 time
- Referenced by tconst wherever needed

**We eliminate hundreds of thousands of duplicates!**

---

## Three Keys to Good Design

**1. Primary Keys** — Every table needs a unique ID

**2. Foreign Keys** — Connect tables with references

**3. No Duplicates** — Store each fact once

**That's it! These simple rules prevent most problems.**

---

## What You'll Practice Today

**Walkthrough:**
- Examine the IMDb table structures
- Verify primary keys are unique
- Use foreign keys in JOINs
- Calculate storage savings

**Then: Your task notebook — prove you understand PKs, FKs, and redundancy!**
