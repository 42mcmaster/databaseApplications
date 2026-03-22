# dbApps06c: Normalization Forms Task
## Normalize a Gaming Tournament Database (1NF → 2NF → 3NF)

**Database Applications Development**
**Medina County Career Center | Instructor: Ryan McMaster**

---

## Background

The Medina Esports League tracks tournament results in one giant spreadsheet. Every time a player competes, someone dumps all the info into a single row — the player's gamertag, email, team, coach info, and even multiple game scores crammed into the same cell. It's a mess.

You're going to clean it up using the three **Normal Forms** — step by step.

Open `dbApps06c_NormalizationForms.xlsx` and look at the **Flat_Table** sheet.

---

## Part 1: Identify the Problems

Before you start fixing things, look at the flat table and answer these questions on paper:

1. Which columns have **multiple values crammed into one cell**? (This is a 1NF violation.)
2. The composite key for this table is **(gamertag, game_name)** — you need both to identify a specific score. Which attributes depend only on **gamertag** and don't care about the game? (These are partial dependencies — a 2NF violation.)
3. Which attributes depend on **team_name** rather than on **gamertag**? (These are transitive dependencies — a 3NF violation.)

---

## Part 2: First Normal Form (1NF)

**Rule: Every cell must contain exactly one value. No lists, no commas.**

Go to the **1NF** sheet. The flat table has rows where `games_played` and `scores` contain comma-separated lists. Your job:

1. Break each multi-value row into **separate rows** — one row per player per game
2. Each cell should have exactly **one value**
3. Keep all the other columns (email, team, coach, etc.) — just repeat them for each row

When you're done, every row should represent **one player playing one game** with **one score**.

**Check:** Does every cell in your table contain a single value? If yes, you've achieved 1NF.

---

## Part 3: Second Normal Form (2NF)

**Rule: Every non-key attribute must depend on the WHOLE composite key, not just part of it.**

Go to the **2NF** sheet. Look at your 1NF table — the composite key is **(gamertag, game_name)**.

Ask yourself for each attribute: "Do I need to know BOTH the gamertag AND the game to determine this value?"

- `score` → Yes, depends on both (which player AND which game) ✅
- `email` → Only depends on gamertag (partial dependency) ❌
- `team_name` → Only depends on gamertag (partial dependency) ❌
- `coach_name`, `coach_phone` → Only depend on gamertag (partial dependency) ❌

**Your job:** Split the 1NF table into **two tables** that fix the partial dependencies:

- **Players** — attributes that depend only on **gamertag**
- **Scores** — attributes that depend on the full composite key **(gamertag, game_name)**

For each table, identify the **PK** and any **FK** relationships.

**Check:** In each table, does every attribute depend on the entire primary key? If yes, you've achieved 2NF.

---

## Part 4: Third Normal Form (3NF)

**Rule: No non-key attribute should depend on another non-key attribute.**

Go to the **3NF** sheet. Look at your Players table from 2NF:

```
gamertag | email | team_name | coach_name | coach_phone
```

Ask yourself: "Does `coach_name` depend directly on `gamertag`... or does it really depend on `team_name`?"

- `coach_name` depends on **team_name** (transitive dependency) ❌
- `coach_phone` depends on **team_name** (transitive dependency) ❌

**Your job:** Split the Players table into **two tables** to remove the transitive dependencies:

- **Players** — player-specific attributes + a FK to the team
- **Teams** — team-specific attributes

You should now have **3 total entity tables**. For each one, identify **PK** and **FK**.

**Check:** In every table, does each attribute depend on the key, the whole key, and nothing but the key? If yes, you've achieved 3NF.

---

## Summary of Your Final 3NF Schema

When you're done, fill in the schema diagram on the **3NF** sheet. You should have:

| Entity Table | PK | Key Attributes |
|---|---|---|
| **Players** | gamertag | email, team_name (FK) |
| **Teams** | team_name | coach_name, coach_phone |
| **Scores** | (gamertag FK, game_name) | score, match_date |

Draw arrows showing how the FKs connect to PKs — just like the IMDb schema and your pizza shop schema.

---

## Think About It

1. A common way to remember 3NF: *"Every attribute depends on the key, the whole key, and nothing but the key."* How does each normal form address one part of that sentence?
2. How does this 3-step process compare to what you did intuitively in 06b with the pizza shop?
3. If the league adds a new team, how many tables need to be updated in your 3NF design vs. the original flat table?
