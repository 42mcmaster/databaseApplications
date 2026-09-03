# Unit 3c Walkthrough — Normalization: 1NF, 2NF, 3NF

**Read this first. Then open `unit3_Normalization.xlsx` in Google Sheets and `unit3c_lastname.md`.**

---

## What you're doing today

In 3a you saw *why* to split tables. In 3b you learned the pieces. Today you learn the actual procedure. It has three steps with names — **first, second, and third normal form** — and each step fixes exactly one problem. You'll run a small table through all three in a spreadsheet, then paste the final result into your turn-in file.

*This lesson follows the approach in Decomplexify's video "Database Normalization — 1NF through 5NF." If you want to see it explained a second way, watch the first half.*

---

## The three rules

| Form | The rule it adds |
|---|---|
| **1NF** | One value per cell. Every column has one data type. Every table has a primary key. |
| **2NF** | Every non-key column depends on the **whole** primary key. |
| **3NF** | Every non-key column depends on **nothing but** the primary key. |

A table has to pass 1NF before it can be in 2NF, and 2NF before 3NF. The old line for remembering all three: **"the key, the whole key, and nothing but the key."**

---

## The example: action-movie characters

A film studio keeps a table of its stunt characters. Each character has an experience level (1–9), a rating that comes from that level, and a list of special abilities with a power score for each.

| Character | Experience_Level | Character_Rating | Special_Abilities |
|---|---|---|---|
| Arnold | 9 | Blockbuster | one-liners (8), explosions (10), car chases (7), hand-to-hand (9) |
| Agent 86 | 5 | Rising Star | gadgets (6), disguises (4) |
| Mr. Secretary | 7 | Blockbuster | negotiations (8), hand-to-hand (7), explosions (5) |
| Bad Cop | 3 | Newcomer | interrogations (4), car chases (6), gadgets (3), one-liners (2) |

Rating rule: 1–3 = Newcomer, 4–6 = Rising Star, 7–9 = Blockbuster.

Three things are wrong with this table. Each normal form finds one.

---

## 1NF — one value per cell

`Special_Abilities` holds a whole list in one cell. You can't ask "who has explosions above 7?" because the database sees one long string, not four abilities.

**Fix:** one ability per row.

| Character | Ability | Power | Experience_Level | Character_Rating |
|---|---|---|---|---|
| Arnold | one-liners | 8 | 9 | Blockbuster |
| Arnold | explosions | 10 | 9 | Blockbuster |
| Arnold | car chases | 7 | 9 | Blockbuster |
| Arnold | hand-to-hand | 9 | 9 | Blockbuster |

Now `Character` alone can't be the primary key — Arnold has four rows. The key is **(Character, Ability)**, a composite key. Each pair appears once.

Also part of 1NF: every column holds one data type (no "not sure" in a number column), and row order means nothing (if order matters, add a column for it).

Notice the table got *more* redundant, not less. Arnold's level and rating are now typed four times. That's expected — 1NF makes the redundancy visible so 2NF can remove it.

---

## 2NF — the whole key

Now ask, for each non-key column: **does it need both parts of the key, or just one?**

| Column | Depends on |
|---|---|
| Power | Character **and** Ability — Arnold's explosions score is different from Bad Cop's |
| Experience_Level | Character only — the ability doesn't change it |
| Character_Rating | Character only |

`Experience_Level` depends on only *part* of the key. That's a **partial dependency**, and it's what 2NF forbids.

**Fix:** move the columns that depend on only `Character` into their own table keyed by `Character`.

```
CHARACTERS                                    CHARACTER_ABILITIES
Character (PK)   Experience_Level   Rating    Character (PK, FK)   Ability (PK)   Power
Arnold           9                  Blockbuster   Arnold           one-liners     8
Agent 86         5                  Rising Star   Arnold           explosions     10
```

Arnold's level is now stored once. `CHARACTER_ABILITIES.Character` is a foreign key back to `CHARACTERS`.

---

## 3NF — nothing but the key

Look at `CHARACTERS`. Both columns depend on `Character`, so it passes 2NF. But `Character_Rating` doesn't really depend on *who the character is* — it depends on the **experience level**. Anyone at level 9 is a Blockbuster.

That's a **transitive dependency**: Character → Experience_Level → Character_Rating. The rating rides along on the level.

Why it matters: Bad Cop trains up from 3 to 4. Somebody updates the level and forgets the rating. Now the row says level 4, Newcomer — which the rule says is impossible. The table is lying.

**Fix:** move the rule into its own lookup table.

```
CHARACTERS                          RATINGS
Character (PK)   Experience_Level   Experience_Level (PK)   Character_Rating
Arnold           9                  1                       Newcomer
Agent 86         5                  2                       Newcomer
                                    3                       Newcomer
                                    4                       Rising Star
                                    ...
```

Now the rating rule is stored in exactly one place, and finding a character's rating is a join. Three tables total: `CHARACTERS`, `CHARACTER_ABILITIES`, `RATINGS`.

---

## When to stop, and when to break the rules

**Stop at 3NF.** There are higher forms (BCNF, 4NF, 5NF). For this class and both exams, 3NF is the target.

**Denormalization** is putting redundancy back **on purpose**. A game studio might put `Character_Rating` back into `CHARACTERS` so the roster screen doesn't need a join. It's a trade: faster reads, in exchange for accepting the update anomaly. Designers do this when the data is read constantly and changed almost never. Reporting databases and data warehouses do it all the time.

The difference between a badly designed table and a denormalized one is whether somebody *decided*.

---

## Now do the work

Open `unit3_Normalization.xlsx` in Google Sheets (File → Import). Four sheets, in order: **Flat_Table → 1NF → 2NF → 3NF**. Arnold is filled in on each sheet so you can see the shape; do the other three characters.

Then open `unit3c_lastname.md`, paste your final three 3NF tables as markdown tables, and answer the questions. Include a link to your Sheet (or export it as `.xlsx` and commit it next to your turn-in).
