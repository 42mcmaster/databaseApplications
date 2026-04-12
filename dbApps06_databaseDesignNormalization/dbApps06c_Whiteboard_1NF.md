# dbApps06c: Whiteboard Guide — First Normal Form (1NF)
## Day 1: From One Messy Table to Atomic Rows

**Database Applications Development**
**Medina County Career Center | Instructor: Ryan McMaster**

> **Teacher reference doc** — use this at the whiteboard. Students don't get this file.
> After the whiteboard walkthrough, students will do the same process in Excel.

---

## Setup (1 min)

Grab a marker. You're going to draw a table on the board and have the class help you fix it.

**Context for the students:**

> "We've been doing normalization all along — splitting messy tables into cleaner ones. Today we're going to learn the *formal* names for the steps. There are three levels: First Normal Form, Second Normal Form, and Third Normal Form. We're starting with 1NF."

---

## Draw the Flat Table (3 min)

Draw this table on the board. Tell them it's a movie studio database tracking action movie characters, their experience, and their special abilities.

```
| Character     | Character_Rating | Experience_Level | Special_Abilities                                     | Power_Levels     |
|---------------|------------------|------------------|-------------------------------------------------------|------------------|
| Arnold        | Blockbuster      | 9                | one-liners, explosions, car chases, hand-to-hand      | 8, 10, 7, 9     |
| Agent 86      | Rising Star      | 5                | gadgets, disguises                                    | 6, 4            |
| Mr. Secretary | Blockbuster      | 7                | negotiations, hand-to-hand, explosions                | 8, 7, 5         |
| Bad Cop       | Newcomer         | 3                | interrogations, car chases, gadgets, one-liners       | 4, 6, 3, 2      |
```

**Say:**

> "This is one table that tracks everything about our action movie characters — who they are, how experienced they are, and all the special abilities they bring to their movies. Look at it for a second. What's wrong with it?"

---

## Discussion: What's Wrong? (3 min)

Let them call things out. You're listening for:

1. **Special_Abilities and Power_Levels are comma-separated lists** — that's the big one. Multiple values crammed into single cells.
2. **Character_Rating and Experience_Level don't have anything to do with abilities** — they'll notice these feel out of place. (This becomes the 2NF problem later, but don't name it yet.)
3. **Character_Rating seems connected to Experience_Level** — some sharp students may notice the pattern. (This is the 3NF problem — save it for Day 3.)

If they only spot #1, that's fine. That's what 1NF fixes.

**Say:**

> "Those comma-separated lists are the problem we're fixing today. In a database, you can't search, sort, or filter on a value buried inside a comma-separated string. Try answering 'which characters have explosions with a power level above 6?' — you can't do it easily with this table."

---

## Introduce the 1NF Rules (3 min)

Write these four rules on the board:

```
FIRST NORMAL FORM (1NF)
========================
1. No using row order to convey information
2. No mixing data types in a column
3. Every table must have a primary key
4. No repeating groups — one value per cell
```

Walk through each briefly:

**Rule 1 — Row order:**
> "If I rearranged the rows — put Bad Cop first and Arnold last — does the data change? No. Rows in a database have no guaranteed order. If order matters, you need a column for it."

**Rule 2 — Data types:**
> "Every value in a column has to be the same type. You can't have a number in one row and text in the next for the same column. Databases enforce this for you."

**Rule 3 — Primary key:**
> "Every table needs a way to uniquely identify each row. No PK means you could have two identical rows that contradict each other."

**Rule 4 — No repeating groups:**
> "This is the big one. Look at Arnold's row — 'one-liners, explosions, car chases, hand-to-hand' all shoved into one cell. That's a repeating group. Each ability needs its own row."

---

## Fix It Together: Draw the 1NF Table (8 min)

Erase or draw a new table next to the flat table. Work through it character by character with the class.

**Say:**

> "Let's fix this. Arnold has four abilities. In 1NF, each ability gets its own row. So Arnold will appear four times."

Draw Arnold's rows first:

```
| Character | Character_Rating | Experience_Level | Special_Ability  | Power_Level |
|-----------|------------------|------------------|------------------|-------------|
| Arnold    | Blockbuster      | 9                | one-liners       | 8           |
| Arnold    | Blockbuster      | 9                | explosions       | 10          |
| Arnold    | Blockbuster      | 9                | car chases       | 7           |
| Arnold    | Blockbuster      | 9                | hand-to-hand     | 9           |
```

**Ask:**

> "See how we repeat Blockbuster and 9 on every row? That feels wasteful, right?"

Let them agree. Then say:

> "It IS wasteful. We'll fix that tomorrow. For now, we're just getting rid of the comma-separated lists."

**Now do Agent 86 together:**

> "Agent 86 had 'gadgets, disguises' with power levels '6, 4'. That's two rows..."

```
| Agent 86  | Rising Star      | 5                | gadgets          | 6           |
| Agent 86  | Rising Star      | 5                | disguises        | 4           |
```

**Then Mr. Secretary** (have a student tell you the rows):

```
| Mr. Secretary | Blockbuster  | 7                | negotiations     | 8           |
| Mr. Secretary | Blockbuster  | 7                | hand-to-hand     | 7           |
| Mr. Secretary | Blockbuster  | 7                | explosions       | 5           |
```

**Then Bad Cop** (have another student tell you):

```
| Bad Cop   | Newcomer         | 3                | interrogations   | 4           |
| Bad Cop   | Newcomer         | 3                | car chases       | 6           |
| Bad Cop   | Newcomer         | 3                | gadgets          | 3           |
| Bad Cop   | Newcomer         | 3                | one-liners       | 2           |
```

**Total: 13 rows** (4 + 2 + 3 + 4)

---

## Identify the Primary Key (3 min)

**Ask:**

> "What's the primary key? Can Character alone be the key?"

No — Arnold appears 4 times. Character alone doesn't uniquely identify a row.

> "What if we use Character AND Special_Ability together?"

Yes! Each character only has each ability once. Arnold + one-liners = unique. Arnold + explosions = unique.

**Write on the board:**

```
PK = (Character, Special_Ability)    ← composite key
```

**Say:**

> "A composite key just means the primary key is made of two columns. You need BOTH to find a specific row."

---

## 1NF Checklist (2 min)

Go back to the four rules and check them off:

> "Row order conveying info? No — we can sort these however we want. ✅"
>
> "Mixed data types? No — each column is consistent. ✅"
>
> "Primary key? Yes — (Character, Special_Ability). ✅"
>
> "Repeating groups? Gone — one ability per row, one value per cell. ✅"

**Say:**

> "That's First Normal Form. We turned a 4-row mess into a 13-row table where every cell has exactly one value and we can actually query the data. Tomorrow we'll look at all that repeated data — the Blockbusters and the experience levels showing up over and over — and fix that with Second Normal Form."

---

## Transition to Excel

> "Now open up `dbApps06c_NormalizationForms.xlsx`. You'll see a Flat_Table sheet that looks just like what we had on the board. Go to the 1NF sheet and fill it in the same way we just did. I'll walk around."

---

## Timing Summary

| Section | Time |
|---|---|
| Setup + context | 1 min |
| Draw flat table | 3 min |
| Discussion: what's wrong? | 3 min |
| 1NF rules | 3 min |
| Draw 1NF table together | 8 min |
| Identify primary key | 3 min |
| 1NF checklist | 2 min |
| **Total whiteboard time** | **~23 min** |

Remaining class time: students do 1NF in Excel.
