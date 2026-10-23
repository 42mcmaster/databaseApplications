-- =====================================================================
-- Unit 4b — Change, Delete, and Import Data
-- Client: Baseball
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
-- PART 1 — IMPORT the new players (no SQL to write here)
-- =====================================================================
-- The client sent six new players in unit4b_Baseball_NewPlayers.csv.
-- Import them into your players table. Steps are in unit4b_Walkthrough.md.
-- Then click Write Changes.
--
-- Check it: you should see 10 players.

SELECT * FROM players;


-- =====================================================================
-- PART 2 — UPDATE (always with a WHERE)
-- =====================================================================

-- 1. The client wants Elly De La Cruz's birth_country spelled out.
--    Change it to 'Dominican Republic'. (His player_id is delacel01.)



-- 2. Aaron Judge's games were one short. Add 1 to his games.
--    (Use games = games + 1, not a typed number.)



-- 3. The scorer fixed Jose Ramirez's stats. Change his home_runs
--    to 31 AND his rbi to 86, in one UPDATE.



-- 4. The client wants countries spelled out. Change every player
--    whose birth_country is 'USA' to 'United States'.
--    Before you run it, predict: how many rows will change?
--    Prediction:
--    Actual (DB Browser shows "rows affected"):



-- Check your work:
SELECT * FROM players;
SELECT * FROM batting;


-- =====================================================================
-- PART 3 — DELETE (always with a WHERE)
-- =====================================================================

-- 5. Josh Naylor was added by mistake. Delete him from players.



-- 6. Try to delete the Cleveland Guardians (team_id 'CLE') from teams.
--    This one SHOULD fail. Write the error message here:
--    Error:
--    Why did the database refuse?
--    Answer:



-- 7. The client wants Shohei Ohtani's Dodgers stats taken off the site.
--    Delete that row from batting. (The key is two columns, so the
--    WHERE needs both.)



-- Check your work, then click Write Changes:
SELECT * FROM players;
SELECT * FROM batting;


-- =====================================================================
-- PART 4 — TRANSACTIONS
-- =====================================================================

-- 8. A fix: Elly De La Cruz's stats were entered under the wrong team.
--    Move them from 'CIN' to 'LAD'.
--    That's two steps: DELETE his CIN row from batting, then INSERT a
--    LAD row with the same stats:
--    games 162, at_bats 629, runs 102, hits 166, home_runs 22,
--    rbi 86, stolen_bases 37.
--    Both steps must happen, or neither.
--    Write both statements between the comment lines below.
--    Run them, check batting, then click Write Changes.
--
-- BEGIN TRANSACTION;



-- COMMIT;
--
--    (BEGIN and COMMIT stay as comments. In DB Browser the
--    Write Changes button is your COMMIT.)

SELECT * FROM batting;


-- 9. The disaster. Click Write Changes first. Then open a NEW
--    Execute SQL tab (Ctrl+T / Cmd+T) and run this there, not here:
--
--        UPDATE players SET bats = 'R';
--
--    Run SELECT * FROM players; and look. Then click Revert Changes.
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
