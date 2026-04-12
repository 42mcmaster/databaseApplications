# dbApps06c: Whiteboard Guide — Second Normal Form (2NF)
## Day 2: Removing Partial Dependencies

**Database Applications Development**
**Medina County Career Center | Instructor: Ryan McMaster**

> **Teacher reference doc** — use this at the whiteboard. Students don't get this file.
> After the whiteboard walkthrough, students will do the same process in Excel.

---

## Recap from Day 1 (2 min)

The 1NF table should still be on the board or redraw it quickly. If you need to redraw, just put up the first few rows and the key info.

**Say:**

> "Yesterday we took our flat table and put it in First Normal Form — one value per cell, a primary key, no repeating groups. We ended up with 13 rows and a composite primary key."

Write the key on the board:

```
PK = (Character, Special_Ability)
```

> "Today we're asking a new question: does every column NEED both parts of that key?"

---

## Draw the 1NF Table (or reference what's on the board) (2 min)

You need at least these columns visible:

```
| Character     | Character_Rating | Experience_Level | Special_Ability  | Power_Level |
|---------------|------------------|------------------|------------------|-------------|
| Arnold        | Blockbuster      | 9                | one-liners       | 8           |
| Arnold        | Blockbuster      | 9                | explosions       | 10          |
| Arnold        | Blockbuster      | 9                | car chases       | 7           |
| Arnold        | Blockbuster      | 9                | hand-to-hand     | 9           |
| Agent 86      | Rising Star      | 5                | gadgets          | 6           |
| Agent 86      | Rising Star      | 5                | disguises        | 4           |
| Mr. Secretary | Blockbuster      | 7                | negotiations     | 8           |
| ...           | ...              | ...              | ...              | ...         |
```

---

## The 2NF Question (5 min)

**Write on the board:**

```
SECOND NORMAL FORM (2NF)
=========================
Every non-key column must depend on the ENTIRE primary key.
(Only matters when the key is composite.)
```

**Say:**

> "Our key is two columns: Character and Special_Ability. For 2NF, we check each non-key column and ask: do you need BOTH parts of the key to determine this value?"

**Walk through each column with the class.** Draw a dependency check table:

```
| Column           | Need Character? | Need Special_Ability? | Need BOTH? |
|------------------|-----------------|----------------------|------------|
| Power_Level      |                 |                      |            |
| Character_Rating |                 |                      |            |
| Experience_Level |                 |                      |            |
```

**Power_Level:**

> "Arnold's power level for one-liners is 8. Arnold's power level for explosions is 10. Are those different?"

Yes. You need to know WHICH ability to know the power level.

> "So Power_Level depends on both Character AND Special_Ability. ✅"

Fill in: Yes | Yes | **Yes ✅**

**Character_Rating:**

> "Arnold's rating is Blockbuster. Does that change depending on which ability we're looking at?"

No. Arnold is Blockbuster whether we're looking at his one-liners row or his explosions row.

> "So Character_Rating only depends on Character. It doesn't need Special_Ability at all. ❌"

Fill in: Yes | No | **No ❌ — partial dependency!**

**Experience_Level:**

> "Same question. Is Arnold's experience level 9 no matter what ability we look at?"

Yes. Same thing — only depends on Character.

Fill in: Yes | No | **No ❌ — partial dependency!**

**Write:**

```
Character_Rating  → depends on Character ONLY (partial dependency)
Experience_Level  → depends on Character ONLY (partial dependency)
Power_Level       → depends on (Character + Special_Ability) (full dependency) ✅
```

---

## Why This Is a Problem: Anomalies (5 min)

**Say:**

> "When a column only depends on PART of the key, it causes three specific problems. Let me show you."

**Deletion anomaly:**

> "Agent 86 only has two abilities — gadgets and disguises. Say the studio drops both of those from his next movie. We delete both rows. Now the database has completely forgotten that Agent 86 exists, that he's a Rising Star with experience level 5. Gone."

**Update anomaly:**

> "Arnold has four rows. Say he gets promoted from Blockbuster to... Legend, or whatever the next level is. We have to update FOUR rows. If we miss one, the database says Arnold is both Blockbuster AND Legend at the same time. Which is it?"

**Insertion anomaly:**

> "A new character joins the franchise — let's call them Sidekick Sam. They're a Newcomer with experience level 1, but they haven't been assigned any special abilities yet. Can we add them to this table?"

No — we can't fill in Special_Ability, which is part of the primary key. We literally can't insert the row.

**Say:**

> "All three of these problems happen because we're storing character info (rating, experience) in a table that's really about abilities. The fix is simple: split them apart."

---

## The Fix: Split Into Two Tables (8 min)

**Draw two new tables on the board.**

**Say:**

> "Character stuff goes in a Character table. Ability stuff stays in an Abilities table."

### CHARACTER Table

> "What goes here? The columns that depend on Character alone."

Draw it and fill it in with the class:

```
CHARACTER
=========
| Character     | Character_Rating | Experience_Level |
|---------------|------------------|------------------|
| Arnold        | Blockbuster      | 9                |
| Agent 86      | Rising Star      | 5                |
| Mr. Secretary | Blockbuster      | 7                |
| Bad Cop       | Newcomer         | 3                |

PK = Character
```

> "Four characters, four rows. Each character appears exactly once. No duplication."

### CHARACTER_ABILITIES Table

> "What goes here? The columns that need the full composite key."

```
CHARACTER_ABILITIES
====================
| Character     | Special_Ability  | Power_Level |
|---------------|------------------|-------------|
| Arnold        | one-liners       | 8           |
| Arnold        | explosions       | 10          |
| Arnold        | car chases       | 7           |
| Arnold        | hand-to-hand     | 9           |
| Agent 86      | gadgets          | 6           |
| Agent 86      | disguises        | 4           |
| Mr. Secretary | negotiations     | 8           |
| Mr. Secretary | hand-to-hand     | 7           |
| Mr. Secretary | explosions       | 5           |
| Bad Cop       | interrogations   | 4           |
| Bad Cop       | car chases       | 6           |
| Bad Cop       | gadgets          | 3           |
| Bad Cop       | one-liners       | 2           |

PK = (Character, Special_Ability)
FK: Character → Character.Character
```

---

## Check the Anomalies Again (3 min)

**Say:**

> "Let's check those three problems again."

**Deletion:** "If Agent 86 loses all his abilities, we delete his rows from Character_Abilities. But his row in the Character table is untouched — we still know he's a Rising Star with experience 5. ✅"

**Update:** "Arnold gets promoted? One update in the Character table. Done. No chance of conflicting data. ✅"

**Insertion:** "Sidekick Sam joins with no abilities? Add them to the Character table. No problem — that table doesn't require a Special_Ability. ✅"

---

## 2NF Summary (2 min)

**Write on the board:**

```
2NF = "the WHOLE key"

Every non-key column depends on the ENTIRE primary key.
If it only depends on PART of the key → it belongs in a different table.
```

**Say:**

> "Here's an easy way to remember it. There's a phrase: 'Every attribute depends on the key, the whole key, and nothing but the key.' 1NF was about 'the key' — making sure a key can even exist. 2NF is about 'the whole key' — no partial dependencies."

> "Tomorrow we'll tackle 'nothing but the key' — that's Third Normal Form. Take a look at the Character table... something's still not quite right in there. See if you can spot it before tomorrow."

(This plants the seed for 3NF — the transitive dependency between Experience_Level and Character_Rating.)

---

## Transition to Excel

> "Now open up `dbApps06c_NormalizationForms.xlsx` and go to the 2NF sheet. You'll do the same split we just did on the board. Fill in the dependency check, then fill in both tables."

---

## Timing Summary

| Section | Time |
|---|---|
| Recap from Day 1 | 2 min |
| Draw/reference 1NF table | 2 min |
| 2NF question + dependency check | 5 min |
| Anomalies discussion | 5 min |
| Split into two tables | 8 min |
| Check anomalies again | 3 min |
| 2NF summary | 2 min |
| **Total whiteboard time** | **~27 min** |

Remaining class time: students do 2NF in Excel.
