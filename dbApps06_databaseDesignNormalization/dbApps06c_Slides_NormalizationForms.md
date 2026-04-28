---
marp: true
theme: default
class: invert
paginate: true
---

# Lesson 06c: Normalization Forms
## 1NF, 2NF, 3NF — following the Decomplexify approach

**Database Applications Development**
Software Engineering | Medina County Career Center

---

## Credit Where It's Due

Today's lesson follows the excellent video by **Decomplexify**:
**"Database Normalization — 1NF through 5NF"**
https://www.youtube.com/watch?v=GFQaEYEc8_8

We're covering **1NF through 3NF** (that's all you need for this class).
Watch the video to see the full walkthrough — we'll use the same examples here.

---

## Quick Recap

- **06a:** We looked at IMDb — how real databases use PKs and FKs.
- **06b:** We took one messy table and split it into clean tables.
- **Today:** There's a formal 3-step recipe for doing that split.

The three steps are called **1NF, 2NF, and 3NF**.
Each step fixes ONE specific problem.

---

## What Is Normalization?

When you normalize a database table, you structure it so that it **can't express redundant information**.

Example: a normalized table wouldn't let you give Customer 1001 **two dates of birth** even if you wanted to. The table can only express **one version of the truth**.

Normalized tables are:
- Easier to understand
- Easier to enhance and extend
- Protected from **insertion, update, and deletion anomalies**

---

## The Normal Forms Are Like Safety Levels

Think of it like a bridge safety assessment:

| Level | Bridge | Database |
|-------|--------|----------|
| Level 1 | Safe for pedestrians | **1NF** — bare minimum |
| Level 2 | Safe for cars | **2NF** — better |
| Level 3 | Safe for trucks | **3NF** — solid for real use |

Each level is stricter. A table must pass **all lower levels** to qualify for a higher one.

---

## First Normal Form (1NF)
### Four rules your table has to follow

---

## 1NF Rule 1: No Using Row Order to Convey Info

**Who were the members of the Beatles?**
- You might say: "John, Paul, George, Ringo"
- I might say: "Paul, John, Ringo, George"

Both answers are the same — the order doesn't matter.

In a relational database, rows have **no guaranteed order**. If you need to communicate or display an attribute like height, **add a column for it** — don't rely on which row comes first.

---

## 1NF Rule 1 — Example

**Bad:** Relying on row order to mean "tallest to shortest"

```
| Beatle  |
|---------|
| Paul    |   ← tallest?
| John    |
| Ringo   |
| George  |   ← shortest?
```

**Good:** Be explicit with a column

```
| Beatle  | Height_In_Cm |
|---------|--------------|
| Paul    | 180          |
| John    | 179          |
| Ringo   | 170          |
| George  | 177          |
```

---

## 1NF Rule 2: No Mixing Data Types in a Column

In a spreadsheet, you can put a number in one cell and text in the next — same column. Databases don't allow that.

If `Height_In_Cm` is defined as an integer column, **every value must be an integer**. No strings, no timestamps.

```
| Beatle  | Height_In_Cm |
|---------|--------------|
| Paul    | 180          |   ← integer, good
| John    | 179          |   ← integer, good
| Ringo   | not sure     |   ← string! NOT ALLOWED
| George  | 177          |
```

The database platform won't even let you do this — so it's basically enforced for you.

---

## 1NF Rule 3: Every Table Needs a Primary Key

A **primary key** uniquely identifies each row. Without one, you could end up with duplicate rows that contradict each other.

```
| Beatle  | Height_In_Cm |
|---------|--------------|
| Paul    | 180          |
| Paul    | 175          |   ← which is it??
```

With `Beatle` as the PK, the database **prevents** this. One row per Beatle, guaranteed.

A table without a primary key is **not in 1NF**.

---

## 1NF Rule 4: Don't store multiple values in one column

This is the big one. Imagine an online multiplayer game where players have inventories.

**Bad:** Cramming all inventory items into one row

```
| Player  | Inventory                              |
|---------|----------------------------------------|
| trev73  | 3 arrows, 2 shields, 18 copper coins   |
| jdog21  | 5 arrows, 2 amulets                    |
```

There's no easy way to query "who has more than 10 copper coins?"

---

## 1NF Rule 4 — Still Bad

What about making separate columns for each item type?

```
| Player  | Item_1_Type | Item_1_Qty | Item_2_Type | Item_2_Qty | ...
|---------|-------------|------------|-------------|------------|----
| trev73  | arrows      | 3          | shields     | 2          | ...
| jdog21  | arrows      | 5          | amulets     | 2          | ...
```

With hundreds of possible item types, you'd need hundreds of columns. Still terrible to query.

---

## 1NF Rule 4 — The Fix

**Give each item its own row:**

```
| Player  | Item_Type     | Item_Quantity |
|---------|---------------|---------------|
| trev73  | arrows        | 3             |
| trev73  | shields       | 2             |
| trev73  | copper coins  | 18            |
| jdog21  | arrows        | 5             |
| jdog21  | amulets       | 2             |
```

Each row = one player owning one item type.

🔑 **Primary Key = (Player, Item_Type)** — a composite key

Now "who has more than 10 copper coins?" is a simple query.

---

## 1NF — Summary

1. **No using row order** to convey information
2. **No mixing data types** within the same column
3. **Every table must have a primary key**
4. **No repeating groups** — one fact per row

---

## Second Normal Form (2NF)
### Every non-key attribute must depend on the ENTIRE primary key

2NF matters when your key is **composite** (made of two or more columns).

---

## 2NF — The Setup

Our Player_Inventory table is in 1NF. Now suppose we add **Player_Rating** (Beginner, Intermediate, Advanced):

```
| Player  | Item_Type     | Item_Quantity | Player_Rating |
|---------|---------------|---------------|---------------|
| trev73  | arrows        | 3             | Advanced      |
| trev73  | shields       | 2             | Advanced      |
| trev73  | copper coins  | 18            | Advanced      |
| jdog21  | arrows        | 5             | Intermediate  |
| jdog21  | amulets       | 2             | Intermediate  |
| gila19  | copper coins  | 7             | Beginner      |
```

PK = **(Player, Item_Type)**

---

## 2NF — Spot the Problem

Ask: "Does each non-key column need the WHOLE key?"

| Column | Depends on... |
|--------|---------------|
| Item_Quantity | Player AND Item_Type ✅ |
| Player_Rating | just Player ❌ |

`Player_Rating` doesn't care what items you own. It's a property of the **Player alone** — not the full composite key.

That's a **partial dependency**, and it violates 2NF.

---

## 2NF — Why It Causes Real Problems

**Deletion anomaly:** gila19 loses all her copper coins. Her only row is deleted. Now we've lost her Player_Rating entirely — the database doesn't know she's a Beginner anymore.

**Update anomaly:** trev73 gets promoted from Advanced to... wait, we have to update 3 rows. If we miss one, the data says trev73 is both Advanced and something else at the same time.

**Insertion anomaly:** New player tina42 joins as a Beginner but has no inventory yet. We can't insert her rating because there's no Item_Type to put in the key.

---

## 2NF — The Fix

Split into two tables:

**Player** (one row per player)
```
| Player  | Player_Rating |
|---------|---------------|
| trev73  | Advanced      |
| jdog21  | Intermediate  |
| gila19  | Beginner      |
```
🔑 **PK = Player**

---

**Player_Inventory** (one row per player per item)
```
| Player  | Item_Type     | Item_Quantity |
|---------|---------------|---------------|
| trev73  | arrows        | 3             |
| trev73  | shields       | 2             |
| trev73  | copper coins  | 18            |
| jdog21  | arrows        | 5             |
| jdog21  | amulets       | 2             |
| gila19  | copper coins  | 7             |
```
🔑 **PK = (Player, Item_Type)**
🔗 **FK:** `Player` → Player.Player

Every attribute depends on **the whole key**. That's 2NF.

---

## 2NF in Plain English

> **"If your key is two columns, every other column better need BOTH of them. Otherwise, it belongs in a different table."**

---

## Third Normal Form (3NF)
### No non-key attribute should depend on another non-key attribute

---

## 3NF — The Setup

Let's enhance our Player table. The game has a 9-point skill scale:

| Rating | Skill Level |
|--------|-------------|
| Beginner | 1–3 |
| Intermediate | 4–6 |
| Advanced | 7–9 |

We add Player_Skill_Level to the Player table:

```
| Player  | Player_Rating  | Player_Skill_Level |
|---------|----------------|--------------------|
| trev73  | Advanced       | 8                  |
| jdog21  | Intermediate   | 5                  |
| gila19  | Beginner       | 3                  |
```

🔑 **PK = Player**

---

## 3NF — Spot the Problem

Both `Player_Rating` and `Player_Skill_Level` depend on the key (`Player`). Looks fine for 2NF.

But look closer:
- Player_Skill_Level depends on Player ✅
- Player_Rating depends on Player_Skill_Level ❌ (not directly on the key!)

**This is a transitive dependency:**
`Player → Player_Skill_Level → Player_Rating`

If gila19's skill goes from 3 to 4, her rating should change from Beginner to Intermediate. But if the update only changes the skill level and misses the rating — **now the data contradicts itself**.

---

## 3NF — The Fix

Remove Player_Rating from the Player table:

**Player**
```
| Player  | Player_Skill_Level |
|---------|--------------------|
| trev73  | 8                  |
| jdog21  | 5                  |
| gila19  | 3                  |
```
🔑 **PK = Player**

---

**Player_Skill_Levels** (a lookup table)
```
| Skill_Level | Player_Rating  |
|-------------|----------------|
| 1           | Beginner       |
| 2           | Beginner       |
| 3           | Beginner       |
| 4           | Intermediate   |
| 5           | Intermediate   |
| 6           | Intermediate   |
| 7           | Advanced       |
| 8           | Advanced       |
| 9           | Advanced       |
```
🔑 **PK = Skill_Level**

Now each fact lives in exactly one place. If we ever need the rating, we join to the lookup table.

---

## 3NF — The Golden Rule

> **"Every attribute in a table should depend on the key, the whole key, and nothing but the key."**

Commit that to memory. If you follow it while designing a database, you'll get normalized tables 99% of the time.

(There's also a slightly stronger version called **Boyce-Codd Normal Form** — practically the same thing for our purposes.)

---

## The Whole Recipe

| Step | The Rule | What It Fixes |
|------|----------|---------------|
| **1NF** | Atomic values, PKs, no repeating groups | Tables that can't even be queried |
| **2NF** | Every column depends on the WHOLE key | Partial dependencies (when key is composite) |
| **3NF** | Every column depends on NOTHING BUT the key | Transitive dependencies (column → column → key) |

Each step eliminates a type of **redundancy** and protects against **anomalies**.

---

## Excel vs. Database — One More Time

**Excel (flat tables):**
- Duplicates = fine
- Easy to read at a glance
- Great for small, human-facing data

**Database (normalized):**
- Duplicates = bad
- Each fact stored once
- Scales to millions of rows, many users, and consistent updates

**Normalization is about making data TRUSTWORTHY, CLEAN, and EFFICIENT at scale.**

---

## Your Task: Normalize a Multiplayer Game Database

Open `dbApps06c_NormalizationForms.xlsx`.

**You'll walk through the steps one at a time:**
1. **Flat_Table →** Look at the mess and identify the problems
2. **1NF sheet →** Fix the repeating groups
3. **2NF sheet →** Remove partial dependencies
4. **3NF sheet →** Remove transitive dependencies

Each sheet builds on the one before it. Take it one step at a time.
