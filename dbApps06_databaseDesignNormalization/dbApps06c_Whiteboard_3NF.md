# dbApps06c: Whiteboard Guide — Third Normal Form (3NF)
## Day 3: Removing Transitive Dependencies

**Database Applications Development**
**Medina County Career Center | Instructor: Ryan McMaster**

> **Teacher reference doc** — use this at the whiteboard. Students don't get this file.
> After the whiteboard walkthrough, students will do the same process in Excel.

---

## Recap from Day 2 (2 min)

**Say:**

> "Day 1 we fixed the flat table — got rid of comma-separated lists, that was 1NF. Day 2 we split the table so every column depends on the WHOLE key, that was 2NF. We ended up with two tables."

Write on the board:

```
CHARACTER table:  PK = Character
CHARACTER_ABILITIES table:  PK = (Character, Special_Ability)
```

> "Today we're looking at the Character table one more time. I said yesterday something still isn't quite right. Let's figure out what."

---

## Draw the Character Table (2 min)

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

**Say:**

> "PK is just Character — one column, not composite. Both Character_Rating and Experience_Level depend on it. Looks clean for 2NF. But there's a hidden problem."

---

## Introduce the Rating Scale (2 min)

Write the rating scale on the board:

```
EXPERIENCE → RATING
====================
1-3  →  Newcomer
4-6  →  Rising Star
7-9  →  Blockbuster
```

**Ask:**

> "In this system, if I tell you someone's experience level is 5, do you even need to know WHO they are to figure out their rating?"

No. Experience level 5 always means Rising Star, no matter which character it is.

> "So Character_Rating doesn't REALLY depend on Character. It depends on Experience_Level. And Experience_Level is NOT the primary key — it's just another column."

---

## The Transitive Dependency (5 min)

**Draw the dependency chain on the board:**

```
Character  →  Experience_Level  →  Character_Rating
  (key)          (non-key)            (depends on non-key!)
```

**Say:**

> "This is called a transitive dependency. Character_Rating depends on Experience_Level, which depends on Character. It gets to the key eventually, but it goes THROUGH another non-key column first. Third Normal Form says that's not allowed."

**Write:**

```
THIRD NORMAL FORM (3NF)
========================
No non-key column should depend on another non-key column.
Every column depends on "nothing but the key."
```

---

## Why This Is a Problem (4 min)

**Ask the class to think about this scenario:**

> "Bad Cop trains hard and levels up from experience 3 to experience 4. What SHOULD happen to his rating?"

It should change from Newcomer to Rising Star (because 4-6 = Rising Star).

> "But what if whoever updates the database only changes the Experience_Level to 4 and forgets to change the Character_Rating? Now the data says Bad Cop is a Newcomer with experience level 4. That contradicts the rules. Experience 4 should be Rising Star."

Write the broken row on the board:

```
| Bad Cop | Newcomer | 4 |    ← CONTRADICTION! 4 should be Rising Star!
```

> "This happens because the same fact — 'experience 4 = Rising Star' — is being stored indirectly in two different ways. The experience level says one thing, the rating says another. We need to store that fact in exactly ONE place."

**Also point out:**

> "What if the studio decides to change the scale — now 1-4 is Newcomer instead of 1-3? We'd have to go update EVERY character row that's affected. But if the rating is stored in its own table, we change it in one place."

---

## The Fix: Create a Lookup Table (8 min)

**Say:**

> "The fix is: remove Character_Rating from the Character table entirely. Instead, create a lookup table that maps each experience level to a rating."

### Updated CHARACTER Table

Draw it:

```
CHARACTER
=========
| Character     | Experience_Level |
|---------------|------------------|
| Arnold        | 9                |
| Agent 86      | 5                |
| Mr. Secretary | 7                |
| Bad Cop       | 3                |

PK = Character
FK: Experience_Level → Experience_Ratings.Experience_Level
```

> "No more Character_Rating column. If you need to know Arnold's rating, you look up his experience level (9) in the other table."

### New EXPERIENCE_RATINGS Lookup Table

> "This table stores the relationship between experience levels and ratings. One source of truth."

```
EXPERIENCE_RATINGS
===================
| Experience_Level | Character_Rating |
|------------------|------------------|
| 1                | Newcomer         |
| 2                | Newcomer         |
| 3                | Newcomer         |
| 4                | Rising Star      |
| 5                | Rising Star      |
| 6                | Rising Star      |
| 7                | Blockbuster      |
| 8                | Blockbuster      |
| 9                | Blockbuster      |

PK = Experience_Level
```

**Ask:**

> "Why do we need all 9 rows? Why not just 3 rows — one for Newcomer, one for Rising Star, one for Blockbuster?"

Because the PK is Experience_Level, not the rating. Each experience level maps to exactly one rating, and we need a row for each possible experience level so we can look it up.

(Students sometimes want to only put 3 rows — one per rating. If a student suggests this, it's actually a fine instinct, but explain that with skill level as the PK, each distinct value needs its own row.)

---

## The Complete 3NF Schema (3 min)

**Draw all three tables on the board with their relationships:**

```
CHARACTER                    EXPERIENCE_RATINGS
===========                  ===================
| Character (PK)       |    | Experience_Level (PK) |
| Experience_Level (FK)| →  | Character_Rating      |
                             
         ↓ Character (FK)
         
CHARACTER_ABILITIES
====================
| Character (PK, FK)     |
| Special_Ability (PK)   |
| Power_Level             |
```

**Say:**

> "Three tables. Started with one ugly flat table, ended with three clean ones. Each fact is stored in exactly one place. No contradictions possible."

**Count the wins:**

> "The studio changes the rating ranges? Update the lookup table — one place."
>
> "A character levels up? Update Experience_Level on their row — the rating auto-updates because it's derived from the lookup."
>
> "A character has no abilities yet? Fine — they still exist in the Character table."
>
> "A character leaves the franchise? Delete from Character — their abilities cascade out but the rating system is unaffected."

---

## The Golden Rule (3 min)

**Write this in big letters on the board:**

```
"Every attribute depends on THE KEY,
 the WHOLE key,
 and NOTHING BUT the key."
```

**Connect each part:**

> "**The key** — that's 1NF. Make rows atomic so a primary key can even exist."
>
> "**The whole key** — that's 2NF. Every column needs the full composite key, not just part of it."
>
> "**Nothing but the key** — that's 3NF. No column depends on another non-key column."

**Say:**

> "If you remember this one sentence, you can normalize any table. You've been doing this intuitively since 06b when we split up the pizza database. Now you know the formal names for the steps."

---

## Quick Knowledge Check (2 min)

Rapid-fire questions to the class:

> "How many tables did we start with?" → One (the flat table)
>
> "How many did we end up with?" → Three (Character, Experience_Ratings, Character_Abilities)
>
> "What does 1NF fix?" → Repeating groups / comma-separated lists
>
> "What does 2NF fix?" → Partial dependencies (columns that only need part of the key)
>
> "What does 3NF fix?" → Transitive dependencies (non-key columns depending on other non-key columns)
>
> "What's the golden rule?" → The key, the whole key, and nothing but the key

---

## Transition to Excel

> "Now open `dbApps06c_NormalizationForms.xlsx` and go to the 3NF sheet. Create the lookup table and update the Character table just like we did on the board."

---

## Timing Summary

| Section | Time |
|---|---|
| Recap from Day 2 | 2 min |
| Draw Character table | 2 min |
| Introduce rating scale | 2 min |
| Transitive dependency explanation | 5 min |
| Why it's a problem | 4 min |
| Fix: create lookup table | 8 min |
| Complete 3NF schema | 3 min |
| Golden rule | 3 min |
| Knowledge check | 2 min |
| **Total whiteboard time** | **~31 min** |

Remaining class time: students do 3NF in Excel.
