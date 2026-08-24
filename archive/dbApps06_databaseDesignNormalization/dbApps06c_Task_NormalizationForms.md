# dbApps06c: Normalization Forms — Teacher-Led Walkthrough
## Guided Walkthrough: Normalize an Action Movie Database (1NF → 2NF → 3NF)

**Database Applications Development**
**Medina County Career Center | Instructor: Ryan McMaster**

> This lesson uses a **three-day whiteboard walkthrough** approach.
> Each day covers one normal form: the teacher draws tables on the whiteboard,
> drives discussion with the class, then students do the same process in Excel.
>
> **Whiteboard guides (teacher reference — do NOT distribute):**
> - `dbApps06c_Whiteboard_1NF.md` — Day 1: First Normal Form
> - `dbApps06c_Whiteboard_2NF.md` — Day 2: Second Normal Form
> - `dbApps06c_Whiteboard_3NF.md` — Day 3: Third Normal Form
>
> The slides (`dbApps06c_Slides_NormalizationForms.md`) are still available
> as a reference or review tool if needed.

---

## How This Works

This is a **teacher-led walkthrough** spread across three days. Each day follows the same pattern:

1. **Whiteboard** — You draw tables on the board, talk through the problem, and build the fix with the class
2. **Excel** — Students open `dbApps06c_NormalizationForms.xlsx` and do the same normalization step on their own

The whiteboard uses an **action movie character database** with four characters: Arnold, Agent 86, Mr. Secretary, and Bad Cop. They have experience levels, ratings, and special abilities with power levels.

**File:** `dbApps06c_NormalizationForms.xlsx`
**Sheets:** Flat_Table → 1NF → 2NF → 3NF

---

## Context for Students

Students have already seen normalization concepts in 06b (the pizza shop activity) — they just haven't been using the formal names (1NF, 2NF, 3NF) yet. This walkthrough puts the formal labels on what they've already been doing intuitively.

---

## Day 1: First Normal Form (1NF)

**Whiteboard guide:** `dbApps06c_Whiteboard_1NF.md`

**What happens:**
- Draw the flat table on the board (4 characters with comma-separated abilities)
- Discuss what's wrong — students should spot the comma-separated lists
- Introduce the 4 rules of 1NF
- Build the 1NF table together on the board (13 rows)
- Identify the composite primary key: (Character, Special_Ability)

**Then in Excel:** Students open the 1NF sheet and fill in the remaining rows (Arnold's 4 rows are pre-filled as an example).

**Whiteboard time:** ~23 min | **Excel time:** remainder of class

---

## Day 2: Second Normal Form (2NF)

**Whiteboard guide:** `dbApps06c_Whiteboard_2NF.md`

**What happens:**
- Quick recap of 1NF and the composite key
- Introduce the 2NF question: "Does every column need the WHOLE key?"
- Walk through the dependency check for each column
- Discuss the three anomalies (deletion, update, insertion)
- Split into two tables on the board: Character and Character_Abilities

**Then in Excel:** Students open the 2NF sheet, fill in the dependency check, then fill in both tables.

**Whiteboard time:** ~27 min | **Excel time:** remainder of class

---

## Day 3: Third Normal Form (3NF)

**Whiteboard guide:** `dbApps06c_Whiteboard_3NF.md`

**What happens:**
- Quick recap of 2NF and the two tables
- Introduce the rating scale (1-3 Newcomer, 4-6 Rising Star, 7-9 Blockbuster)
- Students discover the transitive dependency: Character → Experience_Level → Character_Rating
- Discuss why contradictions can occur
- Create the Experience_Ratings lookup table on the board
- Draw the complete 3NF schema with all three tables
- Wrap up with the golden rule: "the key, the whole key, and nothing but the key"

**Then in Excel:** Students open the 3NF sheet, create the lookup table, and update the Character table.

**Whiteboard time:** ~31 min | **Excel time:** remainder of class

---

## The Data

**Four characters:**

| Character | Experience_Level | Character_Rating | Special Abilities |
|---|---|---|---|
| Arnold | 9 | Blockbuster | one-liners (8), explosions (10), car chases (7), hand-to-hand (9) |
| Agent 86 | 5 | Rising Star | gadgets (6), disguises (4) |
| Mr. Secretary | 7 | Blockbuster | negotiations (8), hand-to-hand (7), explosions (5) |
| Bad Cop | 3 | Newcomer | interrogations (4), car chases (6), gadgets (3), one-liners (2) |

**Rating scale:**

| Experience Level | Rating |
|---|---|
| 1–3 | Newcomer |
| 4–6 | Rising Star |
| 7–9 | Blockbuster |

---

## Timing Summary (per day)

| Day | Whiteboard | Excel | Total |
|---|---|---|---|
| Day 1 — 1NF | ~23 min | remainder | full class |
| Day 2 — 2NF | ~27 min | remainder | full class |
| Day 3 — 3NF | ~31 min | remainder | full class |
