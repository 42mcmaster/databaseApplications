-- =====================================================================
-- Unit 4b — Change, Delete, and Import Data
-- Client: Music
-- Database Applications Development · MCCC
--
-- Rename this file unit4b_lastname.sql before you start.
-- Work in your unit4_lastname.db from Unit 4.
--
-- Run ONE task at a time: highlight just that task's SQL, then press
-- Ctrl+Return (Cmd+Return on a Mac). Do NOT run this whole file at once.
--
-- The IDs are long. Copy them from unit4_Music_Data.xlsx or from a
-- SELECT result instead of typing them.
--
-- Name:
-- =====================================================================


-- =====================================================================
-- PART 1 — IMPORT the new artists (no SQL to write here)
-- =====================================================================
-- The client sent six new artists in unit4b_Music_NewArtists.csv.
-- Import them into your artists table. Steps are in unit4b_Walkthrough.md.
-- Then click Write Changes.
--
-- Check it: you should see 10 artists.

SELECT * FROM artists;


-- =====================================================================
-- PART 2 — UPDATE (always with a WHERE)
-- =====================================================================

-- 1. "bad guy" got more streams. Change its popularity to 97.



-- 2. "God's Plan" went up 2 points. Add 2 to its popularity.
--    (Use popularity = popularity + 2, not a typed number.)
--    Remember the apostrophe rule from Unit 4: 'God''s Plan'



-- 3. The "Hip pop" playlist got a makeover. Change its name to
--    'Hip Pop Hits' AND its genre to 'rap', in one UPDATE.



-- 4. The client wants countries spelled out. Change every artist
--    whose country is 'USA' to 'United States'.
--    Before you run it, predict: how many rows will change?
--    Prediction:
--    Actual (DB Browser shows "rows affected"):



-- Check your work:
SELECT * FROM artists;
SELECT * FROM songs;
SELECT * FROM playlists;


-- =====================================================================
-- PART 3 — DELETE (always with a WHERE)
-- =====================================================================

-- 5. The client dropped Bad Bunny from the app. Delete him from artists.



-- 6. Try to delete Drake from artists.
--    This one SHOULD fail. Write the error message here:
--    Error:
--    Why did the database refuse?
--    Answer:



-- 7. Take "bad guy" off the "Permanent Wave" playlist. Delete that row
--    from playlist_songs. (The key is two columns, so the WHERE needs both.)
--    Permanent Wave playlist_id: 5Go0Jsxj1UnsU7Om841BEo
--    bad guy track_id:           2Fxmhks0bxGSBdJ92vM42m



-- Check your work, then click Write Changes:
SELECT * FROM artists;
SELECT * FROM playlist_songs;


-- =====================================================================
-- PART 4 — TRANSACTIONS
-- =====================================================================

-- 8. Move a song: "New Rules" moves from the "Today's Hits (Clean)"
--    playlist to the "Post pop teen" playlist.
--    That's two steps: DELETE the old playlist_songs row, then
--    INSERT a new one. Both steps must happen, or neither.
--    Write both statements between the comment lines below.
--    Run them, check playlist_songs, then click Write Changes.
--
--    New Rules track_id:             2ekn2ttSfGqwhhate0LSR0
--    Today's Hits (Clean) playlist:  7ENISpOJhocpMJVcGb0qcT
--    Post pop teen playlist:         222nc9tKxKhfZ2GBrOpwH3
--
-- BEGIN TRANSACTION;



-- COMMIT;
--
--    (BEGIN and COMMIT stay as comments. In DB Browser the
--    Write Changes button is your COMMIT.)

SELECT * FROM playlist_songs;


-- 9. The disaster. Click Write Changes first. Then open a NEW
--    Execute SQL tab (Ctrl+T / Cmd+T) and run this there, not here:
--
--        UPDATE songs SET popularity = 50;
--
--    Run SELECT * FROM songs; and look. Then click Revert Changes.
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
