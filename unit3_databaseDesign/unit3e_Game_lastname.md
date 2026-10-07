**Before you start:** rename this file to `unit3e_Game_lastname.md`, using your own last name. Read `unit3e_Walkthrough.md` and `unit3e_Game_Client.md` first. Commit and push this file **and** your Excel file when you're done.

**Name:**

**Partner(s):**

---

# Unit 3e — Design a Database for a Client: Game Studio

Both partners turn in the same design.

**Something we disagreed on, and how we settled it:**


**Our Excel file name (commit it to your repo next to this file, like `unit3e_Game_garcia.xlsx`):**


## 1. The client's spreadsheet

Look at the `Client_Export` tab.

**a.** Which column breaks 1NF? Which 1NF rule does it break?

**Answer:**


**b.** Player NightOwl_22 has three characters. How many times is their email typed in the client export? What has to happen if they change their email? What is that problem called?

**Answer:**


**c.** Can `character_name` be the primary key of a characters table? Why or why not? What should the key be instead?

**Answer:**


## 2. First normal form

Look at the `1NF` tab. Each row is one item that one character is carrying.

**d.** What is the primary key of the 1NF table? Why does it take more than one column?

**Answer:**


## 3. Second normal form — the whole key

For each column, check what it depends on: the character, the item, or both. Use your 1NF key from **d**.

| Column | Depends on the character? | Depends on the item? | Needs the whole key? |
|---|:-:|:-:|:-:|
| `level` | | | |
| `player_email` | | | |
| `item_rarity` | | | |
| `item_gold_value` | | | |
| `quantity` | | | |

**e.** Columns that depend on only part of the key have what problem? Which tables did you move them into?

**Answer:**


## 4. Third normal form — nothing but the key

**f.** `class_base_health` is in the characters data, but it doesn't really depend on the character. What does it depend on? What is that problem called?

**Answer:**


**g.** The player's email and country also depend on something other than the character. What?

**Answer:**


## 5. The client's mistakes

When you used Remove duplicates, two tables had one row too many. Find both mistakes.

| Table | What was wrong | What we kept |
|---|---|---|
| | | |
| | | |

**h.** Why would these mistakes be impossible in your finished design?

**Answer:**


## 6. Our tables

For each table, list every column and mark keys as `(PK)`, `(FK)`, or `(PK, FK)`. Give the number of rows your table has in the Sheet.

| Table | Columns | Rows |
|---|---|:-:|
| PLAYERS | | |
| CLASSES | | |
| CHARACTERS | | |
| ITEMS | | |
| INVENTORY | | |

**i.** Fill in the relationships. **Choose from:** one-to-one · one-to-many · many-to-many

| Relationship | Type | Where is the foreign key? |
|---|---|---|
| PLAYERS → CHARACTERS | | |
| CLASSES → CHARACTERS | | |
| CHARACTERS ↔ ITEMS | | |

**j.** Which table is the junction table? What is its primary key?

**Answer:**


## 7. ER diagram (AI writes the code)

Give your tables to AI and have it write the Mermaid code. Proof it and test it on mermaid.live. Then paste it here.

```mermaid
erDiagram
    %% replace this comment with your diagram

```

**Paste the prompt you gave the AI:**

```text

```

**k.** What did you have to fix in the AI's diagram? If nothing, what did you check?

**Answer:**


## 8. Check your design

- [ ] Every table has a primary key
- [ ] Every many-to-many goes through a junction table
- [ ] No cell holds a list
- [ ] No fact is stored in two places
- [ ] Every foreign key points at a primary key in another one of our tables

**Which normal form does your design reach, and how do you know?**

**Answer:**


## Swap

Trade with a **different** pair. Run their design through the checklist in Part 8. Write one specific thing you'd change about theirs.

**Their names:**

**Feedback for the other pair:**
