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

🔑 **Primary Key = (student, game)** — a composite key (you need both to uniquely ID a row)

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

🔑 **Primary Key = (player, phone)** — both together make each row unique

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
| gamertag  | game     | score | email            | team       |
|-----------|----------|-------|------------------|------------|
| xDragon99 | Valorant | 1850  | xd99@email.com   | Fire Squad |
| xDragon99 | Fortnite | 950   | xd99@email.com   | Fire Squad | ← duplicated!
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

🔑 **PK = gamertag**

---

**Scores** (one row per game played)
```
| gamertag  | game     | score |
|-----------|----------|-------|
| xDragon99 | Valorant | 1850  |
| xDragon99 | Fortnite | 950   |
| koboKing  | Valorant | 2100  |
```

🔑 **PK = (gamertag, game)** — composite key
🔗 **FK:** `gamertag` → Players.gamertag

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

---

## 2NF — Pizza Fix

Split into two tables:

**Orders** (one row per order)
```
| order_id | customer_name | customer_phone |
|----------|---------------|----------------|
| 1001     | Agent 86      | 330-555-0186   |
```
🔑 **PK = order_id**

---

**OrderLines** (one row per pizza on the order)
```
| order_id | pizza     | qty |
|----------|-----------|-----|
| 1001     | Pepperoni | 2   |
| 1001     | Cheese    | 1   |
```

🔑 **PK = (order_id, pizza)** — composite key
🔗 **FK:** `order_id` → Orders.order_id

2NF is happy now. *(We'll come back to this — 3NF will push customer info even further into its own Customers table.)*

---

## 2NF in Plain English

> **"If your key is two columns, every other column better need BOTH of them. Otherwise, it belongs in a different table."**

---

## What a GOOD Composite Key Looks Like

Not every composite key is bad! Sometimes a table exists *specifically* to link two things, and every non-key column genuinely needs both parts.

**Example: Student course enrollments**

```
| student_id | course_id | grade |
|------------|-----------|-------|
| 1042       | MATH101   | A     |
| 1042       | ENG201    | B     |
| 1088       | MATH101   | C     |
| 1088       | ENG201    | A     |
```

🔑 **PK = (student_id, course_id)** — composite key
🔗 **FKs:** `student_id` → Students, `course_id` → Courses

---

## Why This Composite Key Passes 2NF

Ask the 2NF question about `grade`:

- Does it depend on just `student_id`? ❌ No — student 1042 has DIFFERENT grades in different courses.
- Does it depend on just `course_id`? ❌ No — MATH101 has DIFFERENT grades for different students.
- Does it need BOTH? ✅ **Yes!**

"What grade did 1042 get in MATH101?" requires both pieces to answer.

**This table is already in 2NF. ✨**

---

## The Pattern

Tables that record a **relationship between two things** usually have legit composite keys:

| Table | Composite Key | Non-key column |
|-------|---------------|----------------|
| Enrollments | (student, course) | grade |
| OrderLines | (order, product) | qty |
| Scores | (player, game) | score |
| ProjectAssignments | (employee, project) | hours_worked |

In each case, the non-key column literally makes no sense without BOTH halves of the key.

**These are called junction tables (or link tables).** They're normal and correct.

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
🔑 **PK = team**

---

**Players** (now much cleaner)
```
| gamertag  | email          | team       |
|-----------|----------------|------------|
| xDragon99 | xd99@email.com | Fire Squad |
| fireFly   | ff@email.com   | Fire Squad |
| iceCold   | ic@email.com   | Ice Crew   |
```

🔑 **PK = gamertag**
🔗 **FK:** `team` → Teams.team

---

## 3NF — Example 2 ❌

Employees table:

```
| emp_id | name        | dept_id | dept_name   | dept_location |
|--------|-------------|---------|-------------|---------------|
| 101    | Arnold      | D1      | Engineering | Building A    |
| 102    | Lebron      | D1      | Engineering | Building A    |
| 103    | Maxibillion | D2      | Marketing   | Building C    |
| 104    | Kobe        | D1      | Engineering | Building A    |
```

Key is `emp_id`. But `dept_name` and `dept_location` don't really depend on the employee — they depend on `dept_id`.

**Transitive:** emp_id → dept_id → dept_name, dept_location

---

## 3NF — Example 2 ✅

**Departments**
```
| dept_id | dept_name   | dept_location |
|---------|-------------|---------------|
| D1      | Engineering | Building A    |
| D2      | Marketing   | Building C    |
```
🔑 **PK = dept_id**

---

**Employees**
```
| emp_id | name        | dept_id |
|--------|-------------|---------|
| 101    | Arnold      | D1      |
| 102    | Lebron      | D1      |
| 103    | Maxibillion | D2      |
| 104    | Kobe        | D1      |
```
🔑 **PK = emp_id**
🔗 **FK:** `dept_id` → Departments.dept_id

**Why this is better:**
- "Engineering" and "Building A" are typed exactly ONCE — not on every engineer's row.
- If Engineering moves to Building D, you change ONE row instead of every engineer.
- No typos: nobody can accidentally type "Enginering" on one row and "Engineering" on another.
- Every employee in D1 is *guaranteed* to show the same department name and location.

---

## 3NF — Finishing the Pizza Example

Remember the Orders table from 2NF?

```
| order_id | customer_name | customer_phone |
|----------|---------------|----------------|
| 1001     | Agent 86      | 330-555-0186   |
| 1002     | Agent 86      | 330-555-0186   |  ← duplicate!
| 1003     | Lebron        | 330-555-0623   |
```

`customer_phone` depends on `customer_name`, not on `order_id`.
Transitive: **order_id → customer → customer_phone**

---

## 3NF — Pizza Fix

**Customers** (one row per customer)
```
| customer_id | name     | phone         |
|-------------|----------|---------------|
| 1           | Agent 86 | 330-555-0186  |
| 2           | Lebron   | 330-555-0623  |
```
🔑 **PK = customer_id**

**Orders** (points to the customer with a FK)
```
| order_id | customer_id |
|----------|-------------|
| 1001     | 1           |
| 1002     | 1           |
| 1003     | 2           |
```
🔑 **PK = order_id**
🔗 **FK:** `customer_id` → Customers.customer_id

Now Agent 86's phone lives in **one place**. Change it once, done.

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
