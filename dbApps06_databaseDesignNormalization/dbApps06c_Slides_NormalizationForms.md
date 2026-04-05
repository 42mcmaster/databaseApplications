---
marp: true
theme: default
class: invert
paginate: true
---

# Lesson 06c: Normalization Forms
## 1NF → 2NF → 3NF (the easy version)

**Database Applications Development**
Software Engineering | Medina County Career Center

---

## Quick Recap

- **06a:** We looked at IMDb — how real databases use PKs and FKs.
- **06b:** We took one messy table and split it into clean tables.
- **Today:** There's a simple 3-step recipe for doing that split.

The three steps are called **1NF, 2NF, and 3NF**.
Each step fixes ONE specific problem.

---

## Wait — Is Duplicate Data Always Bad?

**Nope.** In Excel, duplicate data is totally fine.

- Excel is for **humans looking at stuff**.
- A spreadsheet you print or share? Duplicates are fine.
- Small personal trackers? Duplicates are fine.

**Databases are different.** They're built for:
- Storing **millions** of rows
- Many people updating data at once
- Keeping info **consistent** (one fact stored in one place)

That's why we normalize — for **efficiency and scale**.

---

## Why Duplicates Hurt a Database

Imagine 10,000 orders all storing the customer's phone number.

Kobe changes his phone number. Now what?

- You have to update it in **10,000 rows**.
- If you miss one row → the data is wrong.
- Different rows disagree about the "truth."

**The fix:** Store Kobe's phone number in ONE place, and point to it.

That's what normalization is for.

---

## First Normal Form (1NF)
### The rule: one value per cell. No lists.

If a cell has a comma-separated list, you're breaking 1NF.

---

## 1NF — Example 1 ❌

```
| student    | favorite_games                    |
|------------|-----------------------------------|
| xDragon99  | Rocket League, Valorant, Fortnite |
| koboKing   | Madden, NBA 2K                    |
```

**Problem:** `favorite_games` is a LIST in one cell.

How would you search for "everyone who plays Valorant"?
You'd have to dig through strings. Gross.

---

## 1NF — Example 1 ✅

```
| student    | game          |
|------------|---------------|
| xDragon99  | Rocket League |
| xDragon99  | Valorant      |
| xDragon99  | Fortnite      |
| koboKing   | Madden        |
| koboKing   | NBA 2K        |
```

**One game per row.** Now "find all Valorant players" is easy.

---

## 1NF — Example 2 ❌

```
| player     | phones                    |
|------------|---------------------------|
| Arnold     | 330-555-0300, 216-555-11  |
| Lebron     | 330-555-0623              |
```

Two phone numbers jammed into one cell.

---

## 1NF — Example 2 ✅

```
| player     | phone         |
|------------|---------------|
| Arnold     | 330-555-0300  |
| Arnold     | 216-555-0011  |
| Lebron     | 330-555-0623  |
```

**One phone per row.** That's 1NF.

---

## 1NF in Plain English

> **"If you can see commas in a cell, you're probably breaking 1NF."**

Fix it by giving each item its own row.

---

## Second Normal Form (2NF)
### The rule: everything in the row must be about the WHOLE key.

2NF only matters when your key is made of **two columns** (a composite key).

If a column in the row only cares about ONE half of the key, it doesn't belong.

---

## 2NF — The Setup

Here's a tournament scores table.
To identify a row, you need **BOTH** gamertag AND game:

```
| gamertag  | game     | score | email            | team       |
|-----------|----------|-------|------------------|------------|
| xDragon99 | Valorant | 1850  | xd99@email.com   | Fire Squad |
| xDragon99 | Fortnite | 950   | xd99@email.com   | Fire Squad |
| koboKing  | Valorant | 2100  | kobo@email.com   | Ice Crew   |
```

**Key = (gamertag, game)**

---

## 2NF — Spot the Problem

Look at each column and ask:
**"Does this need BOTH parts of the key, or just one?"**

| Column | Depends on... |
|--------|---------------|
| score  | gamertag AND game ✅ |
| email  | just gamertag ❌ |
| team   | just gamertag ❌ |

`email` and `team` don't care what game you're playing.
They belong to the PLAYER, not the score.

---

## 2NF — Why It's a Problem

Look at the duplication:

```
xDragon99 | Valorant | 1850 | xd99@email.com | Fire Squad
xDragon99 | Fortnite |  950 | xd99@email.com | Fire Squad  ← duplicated!
```

xDragon99's email is stored twice.
If xDragon99 gets a new email, you have to fix it in every row.

**That's the 2NF smell: repeating data tied to just part of the key.**

---

## 2NF — The Fix

Split into two tables:

**Players** (one row per player)
```
| gamertag  | email          | team       |
|-----------|----------------|------------|
| xDragon99 | xd99@email.com | Fire Squad |
| koboKing  | kobo@email.com | Ice Crew   |
```

**Scores** (one row per game played)
```
| gamertag  | game     | score |
|-----------|----------|-------|
| xDragon99 | Valorant | 1850  |
| xDragon99 | Fortnite | 950   |
| koboKing  | Valorant | 2100  |
```

Now each fact lives in exactly **one place**. ✨

---

## 2NF — Another Example

Pizza order lines:

```
| order_id | pizza      | qty | customer_name | customer_phone |
|----------|------------|-----|---------------|----------------|
| 1001     | Pepperoni  | 2   | Agent 86      | 330-555-0186   |
| 1001     | Cheese     | 1   | Agent 86      | 330-555-0186   |
```

**Key = (order_id, pizza)**

- `qty` needs both (yes ✅)
- `customer_name` only needs `order_id` ❌
- `customer_phone` only needs `order_id` ❌

**Fix:** Move customer info to the Orders table. Leave only (order_id, pizza, qty) here.

---

## 2NF in Plain English

> **"If your key is two columns, every other column better need BOTH of them. Otherwise, it belongs in a different table."**

---

## Third Normal Form (3NF)
### The rule: non-key columns shouldn't depend on other non-key columns.

You fixed 2NF. Now look at what's left. Are any of those columns depending on **each other**?

---

## 3NF — Example 1 ❌

Players table after 2NF:

```
| gamertag  | email          | team       | coach      | coach_phone   |
|-----------|----------------|------------|------------|---------------|
| xDragon99 | xd99@email.com | Fire Squad | Mr. Torres | 330-555-0901  |
| fireFly   | ff@email.com   | Fire Squad | Mr. Torres | 330-555-0901  |
| iceCold   | ic@email.com   | Ice Crew   | Ms. Lee    | 330-555-0444  |
```

The key is `gamertag`. But look — `coach` and `coach_phone` really depend on `team`, not on the gamertag.

**This is called a transitive dependency:**
gamertag → team → coach

---

## 3NF — Why It's a Problem

Fire Squad's coach (Mr. Torres) is duplicated for every player on the team.

- Coach changes? Update every single player row.
- New player on Fire Squad? Type "Mr. Torres" again.
- Someone misspells it? Now data disagrees.

**Same old problem: one fact stored in many places.**

---

## 3NF — The Fix

Pull team info into its own table.

**Teams**
```
| team       | coach      | coach_phone   |
|------------|------------|---------------|
| Fire Squad | Mr. Torres | 330-555-0901  |
| Ice Crew   | Ms. Lee    | 330-555-0444  |
```

**Players** (now much cleaner)
```
| gamertag  | email          | team       |
|-----------|----------------|------------|
| xDragon99 | xd99@email.com | Fire Squad |
| fireFly   | ff@email.com   | Fire Squad |
| iceCold   | ic@email.com   | Ice Crew   |
```

`team` is now a **foreign key** pointing to the Teams table.

---

## 3NF — Example 2 ❌

Customers table:

```
| customer_id | name        | zip   | city     | state |
|-------------|-------------|-------|----------|-------|
| 1           | Arnold      | 44256 | Medina   | OH    |
| 2           | Lebron      | 44256 | Medina   | OH    |
| 3           | Maxibillion | 44133 | Cleveland| OH    |
```

Key is `customer_id`. But `city` and `state` actually depend on `zip`, not on the customer.

**Transitive:** customer_id → zip → city, state

---

## 3NF — Example 2 ✅

**Zipcodes**
```
| zip   | city      | state |
|-------|-----------|-------|
| 44256 | Medina    | OH    |
| 44133 | Cleveland | OH    |
```

**Customers**
```
| customer_id | name        | zip   |
|-------------|-------------|-------|
| 1           | Arnold      | 44256 |
| 2           | Lebron      | 44256 |
| 3           | Maxibillion | 44133 |
```

Now if a city name changes, you fix it in ONE place.

---

## 3NF in Plain English

> **"Every column should describe the key — and ONLY the key. If a column describes some OTHER column, it belongs in its own table."**

---

## The Whole Recipe

| Step | The Rule (plain English) | The Fix |
|------|--------------------------|---------|
| **1NF** | One value per cell. No lists. | Break lists into separate rows. |
| **2NF** | Every column must need the FULL key. | Move "partial" columns to their own table. |
| **3NF** | No column should depend on another non-key column. | Move those chains into their own table. |

Each step eliminates a type of **duplication**.

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

**Normalization is about making data TRUSTWORTHY at scale.**

---

## Your Task: Normalize a Gaming Tournament

Open `dbApps06c_NormalizationForms.xlsx`.

**You'll walk through the steps one at a time:**
1. **Sheet 2 → 1NF:** Fix the multi-value cells
2. **Sheet 3 → 2NF:** Remove partial dependencies
3. **Sheet 4 → 3NF:** Remove transitive dependencies

Each sheet builds on the one before it. Take it one step at a time.
