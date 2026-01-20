# SQL Reference Guide - Lesson 06: Database Design
**Database Applications Development | Medina County Career Center**

This reference guide provides SQL patterns for analyzing database structure, checking normalization, and verifying data integrity - all essential for database design work.

---

## Table of Contents
1. [Viewing Database Structure](#viewing-database-structure)
2. [Checking Primary Keys](#checking-primary-keys)
3. [Verifying Foreign Keys](#verifying-foreign-keys)
4. [Testing for Duplicates](#testing-for-duplicates)
5. [Finding Normalization Violations](#finding-normalization-violations)
6. [Checking Referential Integrity](#checking-referential-integrity)
7. [Analyzing Relationships](#analyzing-relationships)
8. [Creating Tables with Constraints](#creating-tables-with-constraints)

---

## Viewing Database Structure

### See all tables in database
```sql
SELECT name FROM sqlite_master 
WHERE type='table' 
ORDER BY name;
```

### View table structure (columns, types, keys)
```sql
PRAGMA table_info(teams);
```

**Result shows:**
- Column names
- Data types
- NULL constraints
- Primary key (pk=1)

### View CREATE statement for a table
```sql
SELECT sql FROM sqlite_master 
WHERE type='table' AND name='teams';
```

**Use this to see:**
- Complete table definition
- All constraints
- Foreign key definitions

---

## Checking Primary Keys

### Verify primary key uniqueness
```sql
SELECT 
    COUNT(*) as total_rows,
    COUNT(DISTINCT team_id) as unique_ids
FROM teams;
```

**If total_rows = unique_ids, the primary key is valid!**

### Find duplicate values (should return 0 for good PK)
```sql
SELECT team_id, COUNT(*) as occurrences
FROM teams
GROUP BY team_id
HAVING COUNT(*) > 1;
```

**Empty result = no duplicates = valid primary key**

### Check composite primary key uniqueness
```sql
SELECT 
    COUNT(*) as total_rows,
    COUNT(DISTINCT season || game_id || team_id) as unique_combos
FROM team_game_stats;
```

**Concatenate all PK columns to check uniqueness**

---

## Verifying Foreign Keys

### List all foreign key relationships
```sql
PRAGMA foreign_key_list(team_game_stats);
```

**Shows which columns reference which tables**

### Check if foreign key values exist in parent table
```sql
-- Find valid references
SELECT COUNT(*) as valid_references
FROM team_game_stats tgs
INNER JOIN teams t ON tgs.team_id = t.team_id;

-- Find invalid references (orphans)
SELECT COUNT(*) as orphan_records
FROM team_game_stats tgs
LEFT JOIN teams t ON tgs.team_id = t.team_id
WHERE t.team_id IS NULL;
```

**Orphan_records should be 0!**

### Find all records that reference a specific parent
```sql
-- How many games does team 1610612739 have?
SELECT COUNT(*) as game_count
FROM team_game_stats
WHERE team_id = 1610612739;
```

---

## Testing for Duplicates

### Find duplicate team names
```sql
SELECT full_name, COUNT(*) as occurrences
FROM teams
GROUP BY full_name
HAVING COUNT(*) > 1;
```

**Use this pattern to check ANY column for duplicates**

### Find duplicate composite keys
```sql
SELECT season, game_id, team_id, COUNT(*) as occurrences
FROM team_game_stats
GROUP BY season, game_id, team_id
HAVING COUNT(*) > 1;
```

---

## Finding Normalization Violations

### Check for NULL values (should have NOT NULL constraint)
```sql
SELECT COUNT(*) as null_count
FROM teams
WHERE full_name IS NULL;
```

**Critical columns should have 0 NULLs**

### Find repeating data (redundancy check)
```sql
-- How many times is each city stored?
SELECT city, COUNT(*) as team_count
FROM teams
GROUP BY city
ORDER BY team_count DESC;
```

**High counts might indicate denormalized design**

### Check for non-atomic values (1NF violation)
```sql
-- Find values with commas (might be lists)
SELECT full_name
FROM teams
WHERE full_name LIKE '%,%';
```

**Should return empty - no lists in columns!**

---

## Checking Referential Integrity

### Verify all foreign keys have valid references
```sql
-- Check team_game_stats → teams
SELECT 
    'team_game_stats' as table_name,
    COUNT(CASE WHEN t.team_id IS NULL THEN 1 END) as orphans
FROM team_game_stats tgs
LEFT JOIN teams t ON tgs.team_id = t.team_id;
```

### Find references to non-existent records
```sql
SELECT tgs.team_id, COUNT(*) as invalid_games
FROM team_game_stats tgs
LEFT JOIN teams t ON tgs.team_id = t.team_id
WHERE t.team_id IS NULL
GROUP BY tgs.team_id;
```

---

## Analyzing Relationships

### Count child records per parent (1:M relationship)
```sql
SELECT 
    t.full_name as team_name,
    COUNT(tgs.game_id) as games_played
FROM teams t
LEFT JOIN team_game_stats tgs ON t.team_id = tgs.team_id
WHERE tgs.season = '2021-22' OR tgs.season IS NULL
GROUP BY t.team_id, t.full_name
ORDER BY games_played DESC;
```

### Find many-to-many relationships through junction table
```sql
-- Players who played for multiple teams
SELECT 
    p.full_name,
    COUNT(DISTINCT ps.team_id) as teams_count
FROM player_season_stats ps
JOIN players p ON ps.player_id = p.player_id
WHERE ps.season = '2021-22'
GROUP BY p.player_id, p.full_name
HAVING COUNT(DISTINCT ps.team_id) > 1;
```

### Verify junction table structure
```sql
-- Check that junction table has FKs to both tables
SELECT 
    COUNT(DISTINCT ps.player_id) as unique_players,
    COUNT(DISTINCT ps.team_id) as unique_teams
FROM player_season_stats ps;
```

---

## Creating Tables with Constraints

### Basic table with single primary key
```sql
CREATE TABLE teams (
    team_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    city TEXT,
    state TEXT
);
```

### Table with composite primary key
```sql
CREATE TABLE team_game_stats (
    season TEXT NOT NULL,
    game_id TEXT NOT NULL,
    team_id INTEGER NOT NULL,
    pts INTEGER,
    
    PRIMARY KEY (season, game_id, team_id)
);
```

### Table with foreign key
```sql
CREATE TABLE team_game_stats (
    season TEXT NOT NULL,
    game_id TEXT NOT NULL,
    team_id INTEGER NOT NULL,
    pts INTEGER,
    
    PRIMARY KEY (season, game_id, team_id),
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);
```

### Table with CHECK constraints
```sql
CREATE TABLE team_game_stats (
    season TEXT NOT NULL,
    game_id TEXT NOT NULL,
    team_id INTEGER NOT NULL,
    pts INTEGER CHECK (pts >= 0),
    wl TEXT CHECK (wl IN ('W', 'L')),
    
    PRIMARY KEY (season, game_id, team_id),
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);
```

### Table with UNIQUE constraint
```sql
CREATE TABLE players (
    player_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT UNIQUE  -- No two players same email
);
```

### Table with DEFAULT values
```sql
CREATE TABLE books (
    book_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    copies_available INTEGER DEFAULT 1,
    added_date TEXT DEFAULT (date('now'))
);
```

---

## Design Verification Queries

### Check if table satisfies 1NF
```sql
-- All columns should have atomic values
-- Check for comma-separated lists
SELECT * FROM teams 
WHERE full_name LIKE '%,%' 
   OR city LIKE '%,%';
```

**Should return 0 rows**

### Verify 2NF compliance (no partial dependencies)
```sql
-- In table with composite key (season, player_id, team_id)
-- Non-key columns should depend on ALL key columns
-- Example: player name should NOT be in player_season_stats
SELECT sql FROM sqlite_master 
WHERE type='table' AND name='player_season_stats';
```

**Check that non-key columns aren't dependent on just part of key**

### Check 3NF compliance (no transitive dependencies)
```sql
-- Find columns that might depend on other non-key columns
-- Example: If teams had arena_capacity, it depends on arena_name
PRAGMA table_info(teams);
```

**Look for columns that depend on each other**

---

## Common Patterns

### Pattern: Find missing relationships
```sql
-- Teams with no games in 2021-22
SELECT t.full_name
FROM teams t
LEFT JOIN team_game_stats tgs ON t.team_id = tgs.team_id 
  AND tgs.season = '2021-22'
WHERE tgs.team_id IS NULL;
```

### Pattern: Count records in each table
```sql
SELECT 
    'teams' as table_name, 
    COUNT(*) as record_count 
FROM teams
UNION ALL
SELECT 
    'team_game_stats', 
    COUNT(*) 
FROM team_game_stats
UNION ALL
SELECT 
    'players', 
    COUNT(*) 
FROM players;
```

### Pattern: Data quality check
```sql
SELECT 
    COUNT(*) as total_games,
    COUNT(DISTINCT season) as seasons,
    COUNT(DISTINCT team_id) as teams,
    MIN(pts) as min_points,
    MAX(pts) as max_points,
    AVG(pts) as avg_points
FROM team_game_stats;
```

**Look for anomalies (negative points, unrealistic values)**

---

## Troubleshooting

### Error: "FOREIGN KEY constraint failed"
**Meaning:** Trying to insert a child record with FK value that doesn't exist in parent table

**Fix:** Insert parent record first, or use valid FK value

### Error: "UNIQUE constraint failed"
**Meaning:** Trying to insert duplicate value in UNIQUE or PRIMARY KEY column

**Fix:** Check for existing records, use different value

### Error: "NOT NULL constraint failed"
**Meaning:** Trying to insert NULL into NOT NULL column

**Fix:** Provide a value for that column

### Error: "CHECK constraint failed"
**Meaning:** Value violates CHECK condition

**Fix:** Use value that satisfies CHECK constraint

---

## Quick Reference Card

```text
VIEWING STRUCTURE:
  PRAGMA table_info(table_name);          - See columns
  SELECT sql FROM sqlite_master...        - See CREATE statement

CHECKING KEYS:
  COUNT(*) vs COUNT(DISTINCT key)         - Verify uniqueness
  GROUP BY ... HAVING COUNT(*) > 1        - Find duplicates

REFERENTIAL INTEGRITY:
  LEFT JOIN ... WHERE parent.id IS NULL   - Find orphans
  COUNT(child) / COUNT(parent)            - Verify relationships

CONSTRAINTS:
  PRIMARY KEY                             - Unique identifier
  FOREIGN KEY ... REFERENCES ...          - Link tables
  NOT NULL                                - Required field
  UNIQUE                                  - No duplicates
  CHECK (condition)                       - Validate values
  DEFAULT value                           - Auto-fill if not provided
```

---

**Remember:** Good database design prevents problems before they happen. Use these queries to verify your design decisions and ensure data integrity!
