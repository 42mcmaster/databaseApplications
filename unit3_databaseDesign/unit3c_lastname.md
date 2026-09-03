**Before you start:** rename this file to `unit3c_lastname.md`, using your own last name. Read `unit3c_Walkthrough.md` first. Commit and push when you're done.

**Name:**

---

# Unit 3c — Normalization

Open **`unit3_Normalization.xlsx`** in Google Sheets. Work through the four sheets in order: **Flat_Table → 1NF → 2NF → 3NF**. The first character (Arnold) is filled in on each sheet so you can see the shape. Do the rest.

When you're done, paste your **final 3NF tables** here as markdown tables, and answer the questions.

**Link to my spreadsheet (or file name if you committed it):**


## 1. First normal form — one value per cell

**a.** What was wrong with the `Special_Abilities` column in the flat table? Which 1NF rule does it break?

**Answer:**


**b.** After fixing it, one character = many rows. What is the primary key of the 1NF table? Why does it take two columns?

**Answer:**


## 2. Second normal form — the whole key

**c.** `Experience_Level` depends on only *part* of the composite key. Which part? What is that problem called?

**Answer:**


**d.** You split the 1NF table into two. Name them and give each one's primary key.

**Answer:**


## 3. Third normal form — nothing but the key

**e.** `Character_Rating` (Newcomer / Rising Star / Blockbuster) depends on `Experience_Level`, not directly on the character. What is that problem called? What happens if a character's experience goes from 3 to 4 and only one of the two columns gets updated?

**Answer:**


**f.** What table did you add to fix it?

**Answer:**


## 4. Your final 3NF tables

Paste them here. Mark the PK and FK columns in the header, like `character_id (PK)`.

**Table 1:**

| | | |
|---|---|---|
| | | |

**Table 2:**

| | | |
|---|---|---|
| | | |

**Table 3:**

| | | |
|---|---|---|
| | | |

## 5. When to break the rules

Your 3NF design needs a join every time someone wants to see a character's rating. A game studio might decide to put `Character_Rating` back into the character table on purpose.

**g.** What is that called, and give one reason they would do it.

**Answer:**


## Closing 3c — Vocabulary

| Term | Your definition |
|---|---|
| 1NF | |
| 2NF | |
| 3NF | |
| Partial dependency | |
| Transitive dependency | |
| Denormalization | |

**Partner check:** trade files. Say the golden rule ("the key, the whole key, and nothing but the key") and point at which of your partner's three tables proves each part.
