# dbApps06c: Normalization Forms — Teacher-Led Walkthrough
## Guided Walkthrough: Normalize a Multiplayer Game Database (1NF → 2NF → 3NF)

**Database Applications Development**
**Medina County Career Center | Instructor: Ryan McMaster**

> This lesson follows the approach from the Decomplexify video:
> **"Database Normalization — 1NF through 5NF"** by Decomplexify
> https://www.youtube.com/watch?v=GFQaEYEc8_8
> (We cover 1NF through 3NF only.)

---

## How This Works

This is a **teacher-led walkthrough**, not a solo activity. You (the teacher) have the Excel file open on the projector. Students have the same file open on their machines. You talk through each step, they follow along and fill in their copy as you go.

**File:** `dbApps06c_NormalizationForms.xlsx`
**Sheets:** Flat_Table → 1NF → 2NF → 3NF

---

## Before You Start (2 min)

Open the file. Have students open it too. Everyone should be looking at the **Flat_Table** sheet.

**Say something like:**

> "We just watched the Decomplexify video on normalization. Now we're going to do it ourselves — same idea, same steps. I'll walk you through it and you'll fill in your workbook as we go."
>
> "We've got a multiplayer game. Players have skill levels, ratings, and inventories full of items. Right now it's all jammed into one ugly flat table. We're going to clean it up in three steps."

---

## Step 0: Look at the Flat Table (3 min)

**Sheet: Flat_Table**

The table looks like this:

| Player | Player_Rating | Player_Skill_Level | Item_Types | Item_Quantities |
|---|---|---|---|---|
| blaze42 | Advanced | 9 | swords, potions, gold coins, gems | 5, 12, 50, 3 |
| coco_nut | Intermediate | 6 | swords, gold coins | 2, 8 |
| rekt99 | Beginner | 2 | potions | 3 |
| starX | Advanced | 7 | swords, potions, gold coins | 7, 4, 30 |
| zippy11 | Intermediate | 4 | potions, gold coins, gems, swords | 6, 15, 1, 3 |

**Ask the class:**

> "What's wrong with this table? What problems do you see?"

Let them call things out. You're looking for:
- **Item_Types and Item_Quantities are comma-separated lists** — that's a repeating group (1NF violation)
- **Player_Rating and Player_Skill_Level don't have anything to do with items** — they'll become partial dependencies once we fix 1NF
- **Player_Rating is determined by Player_Skill_Level** — that's a transitive dependency (3NF problem)

Don't worry if they don't catch all three yet. Just get them to see the comma-separated lists — that's the obvious one.

**Say:**

> "Those comma-separated lists are the first thing we need to fix. That's a 1NF violation — repeating groups. Remember from the video: one value per cell, one fact per row."

---

## Step 1: First Normal Form (8 min)

**Switch to Sheet: 1NF**

The first 4 rows are already filled in as an example (blaze42's 4 items). Walk through them:

**Say:**

> "Look at blaze42. In the flat table, she had 'swords, potions, gold coins, gems' all crammed into one cell. Now each item gets its own row. blaze42 appears four times — once per item she owns."
>
> "Notice we repeat Player_Rating and Player_Skill_Level on every row. That feels wasteful, right? We'll fix that in the next step. For now, we're just getting rid of the comma-separated lists."

**Now fill in the rest together.** Talk through each player:

> "coco_nut had 'swords, gold coins' with quantities '2, 8'. So that's two rows..."

Have students type along with you. The complete 1NF table should be:

| Player | Player_Rating | Player_Skill_Level | Item_Type | Item_Quantity |
|---|---|---|---|---|
| blaze42 | Advanced | 9 | swords | 5 |
| blaze42 | Advanced | 9 | potions | 12 |
| blaze42 | Advanced | 9 | gold coins | 50 |
| blaze42 | Advanced | 9 | gems | 3 |
| coco_nut | Intermediate | 6 | swords | 2 |
| coco_nut | Intermediate | 6 | gold coins | 8 |
| rekt99 | Beginner | 2 | potions | 3 |
| starX | Advanced | 7 | swords | 7 |
| starX | Advanced | 7 | potions | 4 |
| starX | Advanced | 7 | gold coins | 30 |
| zippy11 | Intermediate | 4 | potions | 6 |
| zippy11 | Intermediate | 4 | gold coins | 15 |
| zippy11 | Intermediate | 4 | gems | 1 |
| zippy11 | Intermediate | 4 | swords | 3 |

**14 rows total.**

**Once it's filled in, ask:**

> "What's the primary key? Can 'Player' alone be the key?"

No — blaze42 appears 4 times. You need **both Player AND Item_Type** to uniquely identify a row. That's a composite key.

> "So PK = (Player, Item_Type). Every cell has one value. We have a primary key. No repeating groups. That's 1NF."

**Quick check — hit the 1NF rules from the video:**
1. No row order conveying meaning ✅
2. No mixed data types ✅
3. Has a primary key ✅
4. No repeating groups ✅

---

## Step 2: Second Normal Form (8 min)

**Switch to Sheet: 2NF**

**Say:**

> "Now look at our 1NF table. The key is (Player, Item_Type). For 2NF, we ask: does every non-key column need BOTH parts of the key?"

**Walk through the dependency check table together.** For each attribute, ask the class:

> "Item_Quantity — do you need to know the Player AND the Item_Type to figure this out?"

Yes. blaze42's sword quantity is different from blaze42's potion quantity. **Depends on both.** ✅

> "Player_Rating — do you need to know what item type it is to know blaze42's rating?"

No. blaze42 is Advanced no matter what item you're looking at. **Depends on Player alone.** ❌

> "Player_Skill_Level — same question."

Same answer. Skill level 9 doesn't change based on the item. **Depends on Player alone.** ❌

**Fill in the dependency check:**

| Attribute | Depends on Player only? | Depends on (Player + Item_Type)? | Goes in which table? |
|---|---|---|---|
| Player_Rating | Yes | No | Player |
| Player_Skill_Level | Yes | No | Player |
| Item_Quantity | No | Yes | Player_Inventory |

**Say:**

> "Remember the video — this is exactly what happened when they added Player_Rating to the inventory table. It caused deletion anomalies, update anomalies, and insertion anomalies. Let's see those here."

**Walk through the anomalies** (point at the 1NF table as you talk):

> "**Deletion anomaly:** rekt99 only has one item — potions. If she loses her potions and we delete that row, we've also lost the fact that she's a Beginner with skill level 2. The database just forgets she exists."
>
> "**Update anomaly:** blaze42 has 4 rows. If her rating changes, we have to update all 4. Miss one and the data says she's both Advanced and something else."
>
> "**Insertion anomaly:** Say a new player luna55 joins as a Beginner but hasn't gotten any items yet. We can't add her because there's no Item_Type to put in the key."

**Now fill in the two tables together:**

> "The fix is simple — split it. Player stuff goes in a Player table. Inventory stuff stays in a Player_Inventory table."

**PLAYER table** (fill in together):

| Player | Player_Rating | Player_Skill_Level |
|---|---|---|
| blaze42 | Advanced | 9 |
| coco_nut | Intermediate | 6 |
| rekt99 | Beginner | 2 |
| starX | Advanced | 7 |
| zippy11 | Intermediate | 4 |

PK = Player

**PLAYER_INVENTORY table** (fill in together):

| Player | Item_Type | Item_Quantity |
|---|---|---|
| blaze42 | swords | 5 |
| blaze42 | potions | 12 |
| blaze42 | gold coins | 50 |
| blaze42 | gems | 3 |
| coco_nut | swords | 2 |
| coco_nut | gold coins | 8 |
| rekt99 | potions | 3 |
| starX | swords | 7 |
| starX | potions | 4 |
| starX | gold coins | 30 |
| zippy11 | potions | 6 |
| zippy11 | gold coins | 15 |
| zippy11 | gems | 1 |
| zippy11 | swords | 3 |

PK = (Player, Item_Type), FK: Player → Player.Player

**Say:**

> "Now every attribute depends on the whole key. Player_Rating depends on Player — and Player IS the whole key in the Player table. Item_Quantity depends on (Player, Item_Type) — and that IS the whole key in the Inventory table. That's 2NF."

---

## Step 3: Third Normal Form (8 min)

**Switch to Sheet: 3NF**

**Say:**

> "Look at the Player table. PK is just Player. Both Player_Rating and Player_Skill_Level depend on it. Looks clean, right? But look closer..."

**Ask:**

> "In this game, what determines your rating? Skill 1–3 is Beginner, 4–6 is Intermediate, 7–9 is Advanced. So if I tell you someone's skill level is 6, do you even need to know who they are to figure out their rating?"

No. Skill level alone tells you the rating. That means:

> "Player_Rating doesn't really depend on Player. It depends on Player_Skill_Level. And Player_Skill_Level is NOT the key — it's just another column. That's a transitive dependency."

**Draw it on the board:**

```
Player → Player_Skill_Level → Player_Rating
(key)       (non-key)            (depends on non-key!)
```

**Say:**

> "Remember the video — this is the exact same problem they had. If coco_nut's skill goes from 6 to 7, her rating should change from Intermediate to Advanced. But if we only update the skill level and forget the rating, now the data contradicts itself."

**The fix — fill in together:**

> "We remove Player_Rating from the Player table and create a lookup table that maps each skill level to a rating."

**PLAYER table** (fill in together):

| Player | Player_Skill_Level |
|---|---|
| blaze42 | 9 |
| coco_nut | 6 |
| rekt99 | 2 |
| starX | 7 |
| zippy11 | 4 |

PK = Player, FK: Player_Skill_Level → Player_Skill_Levels.Skill_Level

**PLAYER_SKILL_LEVELS lookup table** (fill in together):

| Skill_Level | Player_Rating |
|---|---|
| 1 | Beginner |
| 2 | Beginner |
| 3 | Beginner |
| 4 | Intermediate |
| 5 | Intermediate |
| 6 | Intermediate |
| 7 | Advanced |
| 8 | Advanced |
| 9 | Advanced |

PK = Skill_Level

**PLAYER_INVENTORY** — unchanged from 2NF. Just note the FK relationship.

**Say:**

> "Now if the game redefines the ranges — say Beginner becomes 1–4 instead of 1–3 — we change ONE row in the lookup table. Not every player. And it's impossible for a player's data to contradict itself, because the rating isn't stored on the player at all."

---

## Wrap-Up (3 min)

**Say:**

> "That's the whole recipe. Three steps. The video summed it up perfectly:"

Write on board or show slide:

> **"Every attribute depends on the key, the whole key, and nothing but the key."**

> - **1NF = "the key"** → make rows atomic so a key can even exist
> - **2NF = "the whole key"** → no partial dependencies
> - **3NF = "nothing but the key"** → no transitive dependencies

**Ask:**

> "How many tables did we end up with?" (Three: Player, Player_Skill_Levels, Player_Inventory)
>
> "How many did we start with?" (One messy flat table)
>
> "Was it worth the split?" (Yes — each fact lives in one place, anomalies are gone, and it's easy to extend)

---

## Timing Summary

| Section | Time |
|---|---|
| Setup + open file | 2 min |
| Step 0: Look at flat table | 3 min |
| Step 1: 1NF | 8 min |
| Step 2: 2NF | 8 min |
| Step 3: 3NF | 8 min |
| Wrap-up | 3 min |
| **Total** | **~32 min** |

This leaves time for the Beatles intro video and the Decomplexify video segments (through 3NF) before the walkthrough.
