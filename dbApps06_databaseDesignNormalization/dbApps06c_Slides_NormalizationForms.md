---
marp: true
theme: default
class: invert
paginate: true
---

# Lesson 06c: Normalization Forms
## 1NF → 2NF → 3NF

**Database Applications Development**
Software Engineering | Medina County Career Center

---

## Recap: What We've Done So Far

In **06a**, we explored the IMDb schema — PKs, FKs, and why tables exist.

In **06b**, we took a messy flat table and split it into 3 normalized entity tables.

**Today:** There's actually a formal, step-by-step process for normalization.
It has three levels called **Normal Forms**: 1NF, 2NF, and 3NF.

Each form fixes a specific type of problem.

---

## First Normal Form (1NF)

**Rule: Every cell contains exactly ONE value. No lists, no comma-separated stuff.**

❌ Violates 1NF:
```
| gamertag   | games_played                    | scores      |
|------------|---------------------------------|-------------|
| xDragon99  | Rocket League, Valorant, Fortnite | 2100, 1850, 950 |
```

✅ Fixed (1NF):
```
| gamertag   | game_name      | score |
|------------|----------------|-------|
| xDragon99  | Rocket League  | 2100  |
| xDragon99  | Valorant       | 1850  |
| xDragon99  | Fortnite       |  950  |
```

**One value per cell. One fact per row.**

---

## Second Normal Form (2NF)

**Rule: Every non-key attribute must depend on the WHOLE key, not just part of it.**

This matters when your table has a **composite key** (two+ columns that together identify a row).

In our 1NF table, the key is **(gamertag, game_name)** — you need both to find a specific score.

```
| gamertag  | email            | team       | game_name | score |
|-----------|------------------|------------|-----------|-------|
| xDragon99 | xd99@email.com   | Fire Squad | Valorant  | 1850  |
```

`email` and `team` depend only on **gamertag** — they don't care about `game_name`.
That's a **partial dependency** → violates 2NF.

**Fix: Pull those attributes into their own entity table.**

---

## Third Normal Form (3NF)

**Rule: No attribute should depend on another non-key attribute.**

After 2NF, we have a Players table:
```
| gamertag  | email          | team       | coach      | coach_phone  |
|-----------|----------------|------------|------------|--------------|
| xDragon99 | xd99@email.com | Fire Squad | Mr. Torres | 330-555-0901 |
```

`coach` and `coach_phone` depend on **team**, not on **gamertag**.
That's a **transitive dependency**: gamertag → team → coach

**Fix: Pull team info into its own entity table. Use a FK to connect.**

---

## The Progression

```
UNNORMALIZED        →   1NF              →   2NF           →   3NF
Multi-value cells       One value/cell       No partial         No transitive
Lists in columns        One fact/row         dependencies       dependencies
```

| Form | What It Fixes | The Rule |
|------|---------------|----------|
| 1NF  | Repeating groups / lists in cells | Every cell = one value |
| 2NF  | Attributes that only depend on PART of the key | Every attribute depends on the WHOLE key |
| 3NF  | Attributes that depend on OTHER non-key attributes | Every attribute depends on the key and NOTHING ELSE |

---

## Your Task: Normalize a Gaming Tournament

You'll get a spreadsheet with one messy flat table of esports tournament data.

**You'll work through it step by step:**
1. **Sheet 2 → 1NF:** Fix the multi-value cells
2. **Sheet 3 → 2NF:** Find and remove partial dependencies
3. **Sheet 4 → 3NF:** Find and remove transitive dependencies

Each worksheet builds on the one before it.

*Open `dbApps06c_NormalizationForms.xlsx` — start with the Flat Table sheet.*
