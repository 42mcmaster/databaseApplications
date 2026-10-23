-- =====================================================================
-- Unit 4b — Change, Delete, and Import Data
-- Client: Game
-- Database Applications Development · MCCC
--
-- Rename this file unit4b_lastname.sql before you start.
-- Work in your unit4_lastname.db from Unit 4.
--
-- Run ONE task at a time: highlight just that task's SQL, then press
-- Ctrl+Return (Cmd+Return on a Mac). Do NOT run this whole file at once.
--
-- Name:
-- =====================================================================


-- =====================================================================
-- PART 1 — IMPORT the new items (no SQL to write here)
-- =====================================================================
-- The client sent six new items in unit4b_Game_NewItems.csv.
-- Import them into your items table. Steps are in unit4b_Walkthrough.md.
-- Then click Write Changes.
--
-- Check it: you should see 10 items.

SELECT * FROM items;


-- =====================================================================
-- PART 2 — UPDATE (always with a WHERE)
-- =====================================================================

-- 1. The shop raised the price of Mana Potion to 15 gold.



-- 2. Lumi (character_id 3) gained a level. Add 1 to her level.
--    (Use level = level + 1, not a typed number.)



-- 3. Twin Daggers got an upgrade. Change its rarity to 'Rare'
--    AND its gold value to 200, in one UPDATE.



-- 4. Sale! Lower the gold value of every Common item by 5.
--    Before you run it, predict: how many rows will change?
--    Prediction:
--    Actual (DB Browser shows "rows affected"):



-- Check your work:
SELECT * FROM items;
SELECT * FROM characters;


-- =====================================================================
-- PART 3 — DELETE (always with a WHERE)
-- =====================================================================

-- 5. The game removed Phoenix Feather. Delete it from items.



-- 6. Try to delete Iron Sword from items.
--    This one SHOULD fail. Write the error message here:
--    Error:
--    Why did the database refuse?
--    Answer:



-- 7. Character 4 used up their Health Potions. Delete that row
--    from inventory. (The key is two columns, so the WHERE needs both.)



-- Check your work, then click Write Changes:
SELECT * FROM items;
SELECT * FROM inventory;


-- =====================================================================
-- PART 4 — TRANSACTIONS
-- =====================================================================

-- 8. A trade: character 1 gives their Iron Sword to character 2.
--    That's two steps: DELETE the row from character 1, then
--    INSERT a row for character 2 (quantity 1).
--    Both steps must happen, or neither.
--    Write both statements between the comment lines below.
--    Run them, check inventory, then click Write Changes.
--
-- BEGIN TRANSACTION;



-- COMMIT;
--
--    (BEGIN and COMMIT stay as comments. In DB Browser the
--    Write Changes button is your COMMIT.)

SELECT * FROM inventory;


-- 9. The disaster. Click Write Changes first. Then open a NEW
--    Execute SQL tab (Ctrl+T / Cmd+T) and run this there, not here:
--
--        UPDATE items SET item_rarity = 'Common';
--
--    Run SELECT * FROM items; and look. Then click Revert Changes.
--    Answer these:
--
--    a) How many rows did the UPDATE change?
--    Answer:
--
--    b) What was missing from the UPDATE?
--    Answer:
--
--    c) Revert Changes is DB Browser's version of which SQL command?
--    Answer:
--
--    d) Why did you click Write Changes BEFORE the disaster?
--    Answer:


-- =====================================================================
-- PART 5 — QUESTIONS
-- =====================================================================

-- 10. When the teacher imported the bad CSV in the demo, one row broke
--     a rule. How many rows got in? Why is that a good thing?
--     Answer:

-- 11. Name two other ways to load a lot of data into a database
--     besides a CSV file.
--     Answer:


-- Turn in: commit this file and your unit4_lastname.db.
