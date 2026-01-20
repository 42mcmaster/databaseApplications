# SQL Reference Guide - Lesson 06: Database Design Basics
**Database Applications Development | Medina County Career Center**

This guide shows you the SQL patterns you need for today's tasks. All examples use the NBA database.

---

## Quick Reference

**What you'll need today:**
1. View table structure → `PRAGMA table_info(table_name)`
2. Check for duplicates → `COUNT(*) vs COUNT(DISTINCT column)`
3. Join tables → `JOIN table ON key = key`
4. Filter and count → `WHERE` + `COUNT(*)`

---

## 1. Viewing Table Structure

### See what tables exist
```sql
SELECT name 
FROM sqlite_master 
WHERE type = 'table';
```

**Returns:** List of all tables in the database

**Example Result:**
```
name
teams
players
team_game_stats
player_season_stats
```

---

### View table columns and primary key
```sql
PRAGMA table_info(teams);
```

**Returns:** Column details including which is the primary key

**Example Result:**
```
cid | name      | type    | notnull | pk
0   | team_id   | INTEGER | 0       | 1   ← Primary key!
1   | full_name | TEXT    | 0       | 0
2   | city      | TEXT    | 0       | 0
```

**Look for:** `pk = 1` means that column is the primary key

**Try it with other tables:**
```sql
PRAGMA table_info(players);
PRAGMA table_info(team_game_stats);
PRAGMA table_info(player_season_stats);
```

---

## 2. Checking for Duplicates

### Verify a primary key is unique
```sql
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT team_id) AS unique_ids
FROM teams;
```

**What this does:**
- `COUNT(*)` = total number of rows
- `COUNT(DISTINCT team_id)` = number of unique team_ids
- If they match → every team_id is unique! ✅

**Example Result:**
```
total_rows | unique_ids
30         | 30
```
**Good!** Both are 30, so team_id has no duplicates.

---

### Find duplicate values (if any)
```sql
SELECT team_id, COUNT(*) AS occurrences
FROM teams
GROUP BY team_id
HAVING COUNT(*) > 1;
```

**What this does:**
- Groups rows by team_id
- Counts how many times each appears
- Shows only IDs that appear more than once

**Good result:** Empty (no rows) = no duplicates!

---

## 3. Joining Tables

### Basic JOIN to get team names
```sql
SELECT 
    t.full_name AS team,
    tgs.pts AS points,
    tgs.reb AS rebounds
FROM team_game_stats tgs
JOIN teams t ON tgs.team_id = t.team_id
WHERE tgs.season = '2021-22'
LIMIT 10;
```

**What this does:**
- Starts with `team_game_stats` (has team_id but not team name)
- JOINs to `teams` (has team name)
- Matches using `team_id` (the foreign key!)

**Example Result:**
```
team                  | points | rebounds
Cleveland Cavaliers   | 107    | 44
Golden State Warriors | 110    | 50
```

**The pattern:**
```sql
FROM table_with_foreign_key alias1
JOIN table_with_primary_key alias2 
    ON alias1.foreign_key = alias2.primary_key
```

---

### Count records per team (GROUP BY with JOIN)
```sql
SELECT 
    t.full_name AS team,
    COUNT(*) AS game_count
FROM team_game_stats tgs
JOIN teams t ON tgs.team_id = t.team_id
WHERE tgs.season = '2021-22'
GROUP BY t.team_id, t.full_name
ORDER BY game_count DESC;
```

**What this does:**
- JOINs team names to game stats
- Groups by team
- Counts games per team

**Example Result:**
```
team                  | game_count
Cleveland Cavaliers   | 82
Golden State Warriors | 82
```

---

## 4. Counting with Filters

### Count specific team's games
```sql
SELECT COUNT(*) AS cavaliers_games
FROM team_game_stats tgs
JOIN teams t ON tgs.team_id = t.team_id
WHERE t.full_name = 'Cleveland Cavaliers'
    AND tgs.season = '2021-22';
```

**Result:** How many games the Cavaliers played in 2021-22

---

### Count all games in a season
```sql
SELECT COUNT(*) AS total_games
FROM team_game_stats
WHERE season = '2021-22';
```

**Result:** Total game records for that season

---

### Compare good vs bad design storage
```sql
-- Good design: Team names stored once
SELECT COUNT(*) AS team_names_stored
FROM teams;

-- Bad design: Would store team name per game
SELECT COUNT(*) AS team_names_if_duplicated
FROM team_game_stats
WHERE season = '2021-22';
```

**Shows:** How many duplicates we avoid with good design!

---

## 5. Finding Related Data

### Find players who changed teams
```sql
SELECT 
    p.full_name AS player,
    COUNT(DISTINCT pss.team_id) AS num_teams
FROM player_season_stats pss
JOIN players p ON pss.player_id = p.player_id
GROUP BY p.player_id, p.full_name
HAVING COUNT(DISTINCT pss.team_id) > 1
ORDER BY num_teams DESC
LIMIT 10;
```

**What this does:**
- JOINs players to their season stats
- Groups by player
- Counts how many different teams they played for
- Shows only players with multiple teams

---

## Common Patterns

### Pattern: Basic table lookup
```sql
SELECT column1, column2
FROM table_name
WHERE condition
LIMIT number;
```

### Pattern: JOIN two tables
```sql
SELECT 
    t1.column,
    t2.column
FROM table1 t1
JOIN table2 t2 ON t1.key = t2.key
WHERE condition;
```

### Pattern: Count with grouping
```sql
SELECT 
    column,
    COUNT(*) AS count
FROM table
GROUP BY column
ORDER BY count DESC;
```

### Pattern: Verify uniqueness
```sql
SELECT 
    COUNT(*) AS total,
    COUNT(DISTINCT key_column) AS unique
FROM table;
-- If total = unique, the key is valid!
```

---

## Tips for Today's Tasks

**When checking primary keys:**
- Use `PRAGMA table_info()` to find which column is PK
- Use `COUNT(*)` vs `COUNT(DISTINCT)` to verify uniqueness

**When using JOINs:**
- Match foreign key in one table to primary key in another
- Use aliases (like `t` and `tgs`) to keep queries short

**When counting:**
- Use `WHERE` to filter to specific data
- Use `GROUP BY` to count per category
- Use `HAVING` to filter groups

**When in doubt:**
- Check the reference examples
- Start simple, then add complexity
- Test each part of your query separately

---

## Quick Troubleshooting

**Error: "no such table"**
- Check spelling of table name
- Use `SELECT name FROM sqlite_master WHERE type='table'` to see all tables

**Error: "no such column"**
- Use `PRAGMA table_info(table_name)` to see column names
- Check spelling carefully (remember: case matters!)

**Error: "ambiguous column"**
- When joining, specify which table: `t.team_id` not just `team_id`
- Use table aliases to make this easier

**Result is empty but shouldn't be:**
- Check your WHERE conditions
- Make sure you're looking at the right season/team/etc.

---

## Remember the Key Concepts

**Primary Key:**
- Unique identifier for each row
- Found with `PRAGMA table_info()` (look for pk=1)
- Verify with `COUNT(*)` vs `COUNT(DISTINCT)`

**Foreign Key:**
- Points to primary key in another table
- Used in JOIN conditions
- Connects tables together

**Good Design:**
- Store each fact once
- Use foreign keys to reference data
- Saves space and makes updates easy!

---

**You've got this!** Use these patterns for today's tasks. When you need help, come back to this guide! 🚀
