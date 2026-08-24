-- =====================================================================
-- Unit 2c — Making New Columns
-- Database Applications Development · MCCC
--
-- Database: nba_5seasons.db · Tables: teams, player_season_stats
--
-- Rename this file with your last name before you start.
-- Every calculated column needs a name. Use AS.
--
-- Read unit2c_Walkthrough.md first. Stuck on syntax? See unit2_StudyGuide.md.
-- =====================================================================


-- 1. Show each team's name and how many years old the franchise is.
--    Use 2026 as the current year. Call the column years_old.


-- 2. Show each team's name and a single column combining city and
--    state, like "Atlanta, Georgia". Call it location.


-- 3. Show every team's full name in all uppercase.


-- 4. From player_season_stats: show player_id, gp, pts, and points
--    per game (pts / gp). Only include players with more than 0 games.


-- 5. Same as query 4, but round points per game to one decimal place.


-- 6. From team_game_stats: show each distinct season and just its
--    starting year — "2021-22" becomes "2021". Use SUBSTR.


-- =====================================================================
-- CHECK YOUR WORK
-- =====================================================================

-- Compare your results from queries 4 and 5. What changed?


-- You were told to add WHERE gp > 0 before dividing. Write one more
-- query below to find out how many rows actually have gp = 0. How
-- many are there — and if the answer is what you found, why write
-- the filter at all?


-- =====================================================================
-- VOCABULARY — your words, not the reference sheet's
-- =====================================================================

-- Calculated column:


-- Concatenation (||):

