---
marp: true
theme: default
class: invert
paginate: true
---

# Lesson 06b: Normalization & ER Diagrams
## The Rules for Organizing Tables

**Database Applications Development**
Software Engineering | Medina County Career Center

---

## Quick Review from Yesterday

**Three keys to good design:**
1. **Primary Keys** — unique ID for each row
2. **Foreign Keys** — link tables together
3. **No Duplicates** — store each fact once

**Today:** The formal rules that tell us *when* to split tables apart.

---

## What Is Normalization?

**Normalization = The process of organizing tables to reduce redundancy**

Three steps called **Normal Forms**:

| Step | Rule |
|------|------|
| **1NF** | Each cell has only one value |
| **2NF** | Non-key columns depend on the *entire* key |
| **3NF** | Non-key columns depend *only* on the key |

Each step makes the database cleaner!

---

## Let's Watch a Quick Video

https://www.youtube.com/watch?v=27VeGN1h0Pw

*(~5 minutes)*

---

## First Normal Form (1NF)

**Rule: No repeating groups. Each cell holds ONE value.**

**BAD — Violates 1NF:**
```
team_id | full_name | coaches
1       | Lakers    | Coach A, Coach B, Coach C
```

**GOOD — Satisfies 1NF:**
```
team_id | full_name | coach_name
1       | Lakers    | Coach A
1       | Lakers    | Coach B
1       | Lakers    | Coach C
```

---

## Second Normal Form (2NF)

**Rule: Every non-key column depends on the ENTIRE primary key.**

Only matters when you have a **composite key** (two+ columns as PK).

**BAD — Violates 2NF:**
```
PK: (team_id, coach_name)
team_id | coach_name | full_name | city
```
"city" depends on team_id alone, not on the full key.

**Fix:** Move team info to its own table.

---

## Third Normal Form (3NF)

**Rule: Non-key columns depend ONLY on the primary key.**

**BAD — Violates 3NF:**
```
player_id | player_name | team_id | team_city
```
"team_city" depends on team_id, not on player_id.

**Fix:** Keep team_city in the teams table only.

**Simple test:** *Can I figure out this column without knowing the PK?*
If yes → it probably belongs in another table.

---

## Normalization Summary

```
UNF (Unnormalized)
  ↓ Remove repeating groups
1NF (each cell = one value)
  ↓ Remove partial dependencies
2NF (non-key depends on FULL key)
  ↓ Remove transitive dependencies
3NF (non-key depends ONLY on key)
```

**Most real databases aim for 3NF.**

---

## Entity-Relationship (ER) Diagrams

**ER Diagram = Visual map of your database design**

Shows three things:
1. **Entities** (boxes) = Your tables
2. **Attributes** (inside boxes) = Your columns
3. **Relationships** (lines) = How tables connect

---

## ER Diagram Format

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
**FK = Foreign Key**

---

## Relationships in ER Diagrams

**One-to-Many (1:M):**

```
TEAMS ────1 : M──── TEAM_GAME_STATS
          "has many"
```

**Reading it:** One team has many games. Each game belongs to one team.

**The FK is always on the "many" side.**

---

## Full NBA ER Diagram

```
┌──────────────┐        ┌──────────────────┐
│    TEAMS     │  1:M   │ TEAM_GAME_STATS  │
├──────────────┤────────├──────────────────┤
│ PK team_id   │        │ PK game_id       │
│    full_name │        │ PK season        │
│    city      │        │ FK team_id       │
│    state     │        │    points        │
└──────────────┘        └──────────────────┘

┌──────────────┐        ┌───────────────────┐
│   PLAYERS    │  1:M   │PLAYER_SEASON_STATS│
├──────────────┤────────├───────────────────┤
│ PK player_id │        │ PK player_id      │
│    full_name │        │ PK season         │
│    position  │        │ FK team_id        │
│    height    │        │ FK player_id      │
└──────────────┘        └───────────────────┘
```

---

## What You'll Practice Today

**Task (dbApps06b):**
1. Look at a flat movie rental table — spot the problems
2. Identify the three entities hiding in it
3. Normalize it into three clean tables (with code)
4. Check if it satisfies 1NF / 2NF / 3NF
5. Draw the ER diagram

**Then: Start your DIY Task — design your own database!**
