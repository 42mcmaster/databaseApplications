# Lesson 06: Database Design & Normalization
## Building Better Databases

**Database Applications Development**  
**Software Engineering | Medina County Career Center**

---

## Learning Objectives

By the end of this lesson, you will be able to:

- Explain why databases are split into multiple related tables
- Identify data redundancy and update anomalies
- Understand the three normal forms (1NF, 2NF, 3NF)
- Design entity-relationship diagrams (ERDs)
- Create multi-table database schemas
- Implement primary keys and foreign keys
- Decide when to normalize vs denormalize data
- Apply database design principles to real-world scenarios

**Ohio Standards Addressed:**
- 2.8.4 - Database elements (entities, attributes, records)
- 8.1.2 - Data abstraction
- 8.1.3 - Define and describe relationships between data
- 8.1.4 - Develop ERD diagrams

---

## Where We Are in the Course

**Lessons 1-2:** Python & pandas fundamentals ✅  
**Lessons 3-4:** Database basics, SELECT, WHERE, ORDER BY ✅  
**Lesson 5:** Aggregations and GROUP BY ✅  
**Today - Lesson 6:** Database design and normalization  
**Next - Lesson 7:** Data modeling and relationships

**Today's Big Question:** Why is the NBA database split into 4 separate tables instead of one big table?

---

## Introduction: Why Database Design Matters

In Lessons 1-5, you've been working with data in various forms:
- **Lessons 1-2:** CSV files with pandas
- **Lessons 3-4:** Converting DataFrames to SQLite, basic SQL queries
- **Lesson 5:** Aggregations and grouping with NBA data

The NBA database you've been using has this structure:
1. **teams** - Team information (30 teams)
2. **players** - Player information (500+ players)
3. **team_game_stats** - Game-by-game team statistics (2,460+ games)
4. **player_season_stats** - Player season averages (600+ player-seasons)

**Why split it into 4 tables?** Let's find out by exploring what happens when you DON'T split data properly.

---

## Part 1: The Problem with Single-Table Designs

### Example: NBA Data in One Giant Table

Imagine storing ALL NBA information in a single table:

```
| player_name  | team_name | city        | state      | game_date  | pts | reb | wl | team_wins | team_losses |
|--------------|-----------|-------------|------------|------------|-----|-----|----|-----------|-------------|
| LeBron James | Lakers    | Los Angeles | California | 2024-01-15 | 28  | 8   | W  | 35        | 10          |
| LeBron James | Lakers    | Los Angeles | California | 2024-01-17 | 32  | 7   | W  | 36        | 10          |
| Anthony Davis| Lakers    | Los Angeles | California | 2024-01-15 | 22  | 14  | W  | 35        | 10          |
| Anthony Davis| Lakers    | Los Angeles | California | 2024-01-17 | 25  | 12  | W  | 36        | 10          |
```

**This design has serious problems.** Let's explore them.

---

### Problem 1: Data Redundancy

**Redundancy** means storing the same information multiple times unnecessarily.

In the single-table example:
- "Los Angeles" appears 4 times (once per game per player)
- "California" appears 4 times
- Team name "Lakers" appears 4 times
- If the Lakers have 82 games and 15 players tracking stats, this info repeats **1,230 times**!

**Why is redundancy bad?**
- **Wastes storage space** - Storing "Los Angeles" 1,230 times vs. once
- **Increases database size** - Makes queries slower
- **Makes maintenance harder** - More places to update when data changes
- **Increases inconsistency risk** - One typo creates bad data

**Real Numbers from NBA Database:**
- 30 teams Ã— 82 games/season = 2,460 team game records
- If we stored city in every game record, "Cleveland" would appear 82 times
- By normalizing, "Cleveland" appears just **once** in the teams table

---

### Problem 2: Update Anomalies

**Update Anomaly:** What happens when information changes?

**Example:** The Lakers change their arena name.

**With single table:**
```sql
-- Would need to update potentially THOUSANDS of rows!
UPDATE nba_data 
SET arena = 'New Arena Name'
WHERE team_name = 'Lakers';
```

**Risks:**
1. Miss some rows → data becomes inconsistent
2. Update fails partway → some rows old, some new
3. Slow operation → locks table during update
4. More disk I/O → degrades performance

**With normalized tables:**
```sql
-- Update just ONE row!
UPDATE teams
SET arena = 'New Arena Name'
WHERE team_id = 1610612747;
```

**Much safer, faster, and cleaner!**

---

### Problem 3: Insertion Anomalies

**Insertion Anomaly:** Can't add certain data without adding unrelated data.

**Example:** NBA expands with a new Seattle team.

**With single table:**
- Can't add the team until they play a game
- Or must insert rows with NULL values for game stats
- Creates "fake" data just to store team information

```
| player_name | team_name | city    | game_date | pts  | reb  | wl   |
|-------------|-----------|---------|-----------|------|------|------|
| NULL        | Sonics    | Seattle | NULL      | NULL | NULL | NULL |
```

This is awkward and violates data integrity!

**With normalized tables:**
```sql
-- Just add the team!
INSERT INTO teams (team_id, full_name, city, state)
VALUES (1610612800, 'Seattle Sonics', 'Seattle', 'Washington');
```

Clean, simple, and makes sense!

---

### Problem 4: Deletion Anomalies

**Deletion Anomaly:** Deleting data unintentionally removes other important information.

**Example:** Last player from a team retires and we delete their records.

**With single table:**
- Deleting all player game records also deletes ALL team information
- Team name, city, state - all gone!
- Can't keep team information without keeping "dummy" player records

**With normalized tables:**
- Players stored in `players` table
- Teams stored in `teams` table  
- Can delete player records without losing team data
- Each entity independent and safe

---

## Part 2: The Solution - Database Normalization

**Database Normalization** is the process of organizing data to:
1. Minimize redundancy
2. Prevent update, insertion, and deletion anomalies
3. Improve data integrity
4. Create logical, flexible structures

### The NBA Database Solution

Instead of one giant table, our database has **4 related tables**:

**1. teams table**
- Stores team information once per team
- Columns: `team_id`, `full_name`, `abbreviation`, `nickname`, `city`, `state`, `year_founded`
- Primary key: `team_id`
- 30 rows (30 NBA teams)

**2. players table**
- Stores player information once per player
- Columns: `player_id`, `full_name`
- Primary key: `player_id`
- 500+ rows (all NBA players in database)

**3. team_game_stats table**
- Stores game-by-game team performance
- Columns: `season`, `game_id`, `team_id`, `game_date`, `matchup`, `wl`, `pts`, `fgm`, `fga`, etc.
- Composite primary key: (`season`, `game_id`, `team_id`)
- Foreign key: `team_id` → `teams.team_id`
- 2,460+ rows (30 teams Ã— 82 games)

**4. player_season_stats table**
- Stores player season averages
- Columns: `season`, `player_id`, `team_id`, `gp`, `min`, `pts`, `reb`, `ast`, etc.
- Composite primary key: (`season`, `player_id`, `team_id`)
- Foreign keys: `player_id` → `players.player_id`, `team_id` → `teams.team_id`
- 600+ rows (players who played that season)

**How tables connect:**
- `team_game_stats.team_id` → `teams.team_id`
- `player_season_stats.player_id` → `players.player_id`
- `player_season_stats.team_id` → `teams.team_id`

---

## Part 3: Primary Keys and Foreign Keys

### Primary Keys

**Primary Key:** A column (or combination of columns) that uniquely identifies each row in a table.

**Requirements for Primary Keys:**
1. **Unique** - No two rows can have the same primary key value
2. **Not NULL** - Must have a value (cannot be empty)
3. **Unchanging** - Should not change over time
4. **Simple** - Preferably a single column (though composite keys exist)

**Examples in NBA Database:**

```sql
-- teams table (single-column primary key)
CREATE TABLE teams (
    team_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    city TEXT,
    state TEXT
);

-- players table (single-column primary key)
CREATE TABLE players (
    player_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL
);

-- team_game_stats table (composite primary key)
CREATE TABLE team_game_stats (
    season TEXT,
    game_id TEXT,
    team_id INTEGER,
    pts INTEGER,
    -- ... other columns
    PRIMARY KEY (season, game_id, team_id)
);
```

**Why use team_id instead of full_name as primary key?**
- Team names can change (e.g., "Charlotte Hornets" became "Pelicans", then Charlotte got "Hornets" back)
- IDs are shorter and faster to search
- IDs are guaranteed unique
- Names might have typos or variations

**Why composite primary key in team_game_stats?**
- Need ALL three values to identify a unique game:
  - `season` = which season
  - `game_id` = which game
  - `team_id` = which team
- Same game_id appears twice (home team and away team)
- Same team_id appears 82 times (one per game)
- Combination is always unique

---

### Foreign Keys

**Foreign Key:** A column in one table that references the primary key of another table.

**Purpose:**
- Create relationships between tables
- Maintain referential integrity
- Enable JOIN operations

**Example from NBA Database:**

```sql
CREATE TABLE team_game_stats (
    season TEXT,
    game_id TEXT,
    team_id INTEGER,              -- Foreign key to teams table
    game_date TEXT,
    pts INTEGER,
    
    PRIMARY KEY (season, game_id, team_id),
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);
```

**What this means:**
- Each `team_id` in `team_game_stats` MUST exist in the `teams` table
- Cannot insert a game stat for team_id = 999 if that team doesn't exist
- Cannot delete a team if game stats still reference it (protects data)

**Enforcing Referential Integrity:**

```sql
-- ❌ This would fail (team_id 999999 doesn't exist)
INSERT INTO team_game_stats (season, game_id, team_id, pts)
VALUES ('2023-24', '0022300001', 999999, 110);
-- Error: FOREIGN KEY constraint failed

-- ✅ This works (team_id 1610612739 exists - Cleveland Cavaliers)
INSERT INTO team_game_stats (season, game_id, team_id, pts)
VALUES ('2023-24', '0022300001', 1610612739, 110);
```

**Real-world benefit:** Prevents "orphan records" - game stats for teams that don't exist!

---

## Part 4: The Three Normal Forms

**Normal Forms** are rules for organizing data to reduce redundancy and improve integrity.

**Important Note:** These examples use simplified column names for teaching. The actual NBA database uses `full_name` instead of `player_name` or `team_name`. The concepts remain the same!

---

### First Normal Form (1NF)

**Rule:** Each column must contain atomic (indivisible) values. No repeating groups or arrays in a single cell.

**❌ Violates 1NF - Multiple Values in One Cell:**

```
| player_id | player_name  | seasons_played              |
|-----------|--------------|----------------------------|
| 2544      | LeBron James | 2003-04, 2004-05, 2005-06  |
```

**Why bad?** The `seasons_played` column contains multiple values - you can't easily query "did LeBron play in 2004-05?"

**✅ Satisfies 1NF - Atomic Values:**

```
| player_id | player_name  | season  |
|-----------|--------------|---------|
| 2544      | LeBron James | 2003-04 |
| 2544      | LeBron James | 2004-05 |
| 2544      | LeBron James | 2005-06 |
```

**Now you can:** 
```sql
SELECT * FROM player_seasons 
WHERE player_id = 2544 AND season = '2004-05';
```

**Another 1NF Violation - Repeating Columns:**

```
| team_id | team_name | player1      | player2       | player3       |
|---------|-----------|--------------|---------------|---------------|
| 1610612739 | Cavaliers | Darius Garland | Donovan Mitchell | Evan Mobley |
```

**Why bad?** 
- Fixed number of player columns (what if team has 15 players?)
- Empty columns waste space
- Hard to query "all teams with player X"

**✅ Better Design:**

```
| team_id    | player_id | season  |
|------------|-----------|---------|
| 1610612739 | 203507    | 2023-24 |
| 1610612739 | 203506    | 2023-24 |
| 1610612739 | 203999    | 2023-24 |
```

**This is exactly what player_season_stats does!**

---

### Second Normal Form (2NF)

**Rule:** Must be in 1NF AND all non-key columns must depend on the ENTIRE primary key (not just part of it).

**Only applies to tables with composite primary keys.**

**❌ Violates 2NF:**

```sql
CREATE TABLE player_game_stats (
    player_id INTEGER,
    game_id TEXT,
    player_name TEXT,        -- Only depends on player_id!
    team_name TEXT,          -- Only depends on player's team!
    points INTEGER,
    rebounds INTEGER,
    PRIMARY KEY (player_id, game_id)
);
```

**The problem:**
- `player_name` only depends on `player_id` (not on `game_id`)
- Same player name repeated for every game
- If player changes name, must update all game records

**✅ Satisfies 2NF - Split into Separate Tables:**

```sql
-- Player names in players table
CREATE TABLE players (
    player_id INTEGER PRIMARY KEY,
    full_name TEXT
);

-- Game stats reference player_id
CREATE TABLE player_game_stats (
    player_id INTEGER,
    game_id TEXT,
    points INTEGER,
    rebounds INTEGER,
    PRIMARY KEY (player_id, game_id),
    FOREIGN KEY (player_id) REFERENCES players(player_id)
);
```

**Now:**
- Player name stored once
- Update in one place
- No redundancy

**This is how our NBA database works!**

---

### Third Normal Form (3NF)

**Rule:** Must be in 2NF AND no transitive dependencies (non-key columns shouldn't depend on other non-key columns).

**❌ Violates 3NF:**

```sql
CREATE TABLE teams (
    team_id INTEGER PRIMARY KEY,
    full_name TEXT,
    city TEXT,
    arena TEXT,
    arena_capacity INTEGER,    -- Depends on arena, not team_id!
    arena_year_built INTEGER   -- Depends on arena, not team_id!
);
```

**The problem:**
- `arena_capacity` depends on `arena`, not directly on `team_id`
- `arena_year_built` depends on `arena`, not directly on `team_id`
- If arena changes capacity, must update team record
- Multiple teams in same arena = duplicate arena data

**✅ Satisfies 3NF - Split into Separate Tables:**

```sql
CREATE TABLE teams (
    team_id INTEGER PRIMARY KEY,
    full_name TEXT,
    city TEXT,
    arena_id INTEGER,
    FOREIGN KEY (arena_id) REFERENCES arenas(arena_id)
);

CREATE TABLE arenas (
    arena_id INTEGER PRIMARY KEY,
    arena_name TEXT,
    capacity INTEGER,
    year_built INTEGER
);
```

**Benefits:**
- Arena info stored once
- Easy to update arena details
- Can track arena history
- Multiple teams can share arenas

**Real Example:** Staples Center (now Crypto.com Arena) hosts:
- Lakers
- Clippers
- With 3NF, arena data stored once, both teams reference it!

---

## Part 5: Composite Primary Keys

**Composite Primary Key:** Uses multiple columns combined to create uniqueness.

**Why needed?** Sometimes no single column is unique, but a combination is.

### Example: team_game_stats Table

```sql
CREATE TABLE team_game_stats (
    season TEXT,        -- Not unique (multiple teams per season)
    game_id TEXT,       -- Not unique (two teams per game)
    team_id INTEGER,    -- Not unique (team plays 82 games)
    pts INTEGER,
    
    PRIMARY KEY (season, game_id, team_id)  -- Combination IS unique!
);
```

**Why all three columns?**

```
| season  | game_id     | team_id    | pts |
|---------|-------------|------------|-----|
| 2021-22 | 0022100001  | 1610612739 | 105 | <- Cavaliers in this game
| 2021-22 | 0022100001  | 1610612738 | 102 | <- Celtics in this game
| 2021-22 | 0022100002  | 1610612739 | 110 | <- Cavaliers in different game
```

- Same `season` for all three rows
- Same `game_id` for rows 1 and 2 (same game, different teams)
- Same `team_id` for rows 1 and 3 (same team, different games)
- **Combination of all three is unique!**

**This pattern is very common in real databases:**
- Order details: (order_id, product_id)
- Course enrollments: (student_id, course_id, semester)
- Employee assignments: (employee_id, project_id, start_date)

---

### Example: player_season_stats Table

```sql
CREATE TABLE player_season_stats (
    season TEXT,
    player_id INTEGER,
    team_id INTEGER,    -- Players can change teams mid-season!
    gp INTEGER,
    pts REAL,
    
    PRIMARY KEY (season, player_id, team_id)
);
```

**Why team_id is part of the key:**
- Player might be traded mid-season
- Separate stats for each team they played for
- Example: Player X has stats for Lakers AND Nets in same season

```
| season  | player_id | team_id    | gp | pts  |
|---------|-----------|------------|----|----- |
| 2021-22 | 203507    | 1610612739 | 50 | 21.2 | <- First half with Cavaliers
| 2021-22 | 203507    | 1610612751 | 32 | 19.8 | <- After trade to Nets
```

**Without team_id in key:** Could only store one record per player per season!

---

## Part 6: Many-to-Many Relationships

**Many-to-Many (M:N):** Multiple records from Table A relate to multiple records from Table B.

**Example:** Players and Teams
- One player can play for multiple teams (over their career, or even in one season)
- One team has multiple players

**Can't directly connect with simple foreign key!**

**Solution: Junction Table (Association Table)**

Our database uses `player_season_stats` as a junction table:

```
players (1) ←→ (M) player_season_stats (M) ←→ (1) teams

PLAYERS                 PLAYER_SEASON_STATS           TEAMS
+-------------+         +-------------------+         +--------------+
| player_id PK|  ←---   | player_id FK      |         | team_id PK   |
| full_name   |         | team_id FK        |  ---→   | full_name    |
+-------------+         | season PK         |         | city         |
                        | gp, pts, reb, ast |         +--------------+
                        +-------------------+
```

**Allows querying:**

```sql
-- All teams LeBron James has played for
SELECT DISTINCT t.full_name
FROM player_season_stats ps
JOIN players p ON ps.player_id = p.player_id
JOIN teams t ON ps.team_id = t.team_id
WHERE p.full_name = 'LeBron James';

-- All players who played for Cavaliers in 2021-22
SELECT p.full_name
FROM player_season_stats ps
JOIN players p ON ps.player_id = p.player_id
WHERE ps.team_id = 1610612739
  AND ps.season = '2021-22';
```

**Other M:N examples:**
- Students ↔ Courses (junction: Enrollments)
- Movies ↔ Actors (junction: Cast)
- Orders ↔ Products (junction: Order_Items)

---

## Part 7: Entity-Relationship Diagrams (ERDs)

**ERD:** Visual representation of database structure showing entities, attributes, and relationships.

### NBA Database ERD

```
┌─────────────┐
│   players   │
│─────────────│
│ PK player_id│
│ full_name   │
└──────┬──────┘
       │
       │ FK: player_id
       │
┌──────▼─────────────────────────┐
│     player_season_stats        │
│────────────────────────────────│
│ PK season                      │
│ PK player_id  ─────────────────┼───► players.player_id
│ PK team_id    ─────────────────┼───► teams.team_id
│ gp, min, pts, reb, ast, ...    │
└───────────┬────────────────────┘
            │
            │ FK: team_id
            │
┌───────────▼──────────┐
│         teams        │
│──────────────────────│
│ PK team_id           │
│ full_name            │
│ abbreviation         │
│ city, state          │
└───────────┬──────────┘
            │
            │ FK: team_id
            │
┌───────────▼──────────────────────┐
│        team_game_stats           │
│──────────────────────────────────│
│ PK season                        │
│ PK game_id                       │
│ PK team_id ───────────────────────┼───► teams.team_id
│ game_date, matchup, wl           │
│ pts, fgm, fga, fg3m, fg3a, ...   │
└──────────────────────────────────┘
```

**Key symbols:**
- PK = Primary Key
- FK = Foreign Key  
- ─► = Relationship/reference

**Relationship Types:**
- **1:M (One-to-Many):** teams → team_game_stats (one team, many games)
- **1:M (One-to-Many):** players → player_season_stats (one player, many seasons)
- **M:N (Many-to-Many):** players ↔ teams (through player_season_stats junction table)

---

## Part 8: When to Normalize vs. Denormalize

**Normalization is not always the answer!** Sometimes denormalization (intentionally breaking normal form rules) makes sense.

### When to Normalize (Most of the Time)

**Normalize when:**
1. Data integrity is critical (financial, medical, legal)
2. Data changes frequently
3. Storage space is limited
4. You need to maintain history
5. Building a transaction system (OLTP)

**Benefits:**
- Reduced redundancy
- Easier updates
- Better data integrity
- Flexible structure

**Our NBA database is normalized** because:
- Team info changes (cities, names)
- Player rosters change constantly
- Need accurate historical records

### When to Denormalize

**Denormalize when:**
1. Read performance is critical
2. Data rarely changes
3. Complex joins hurt performance
4. Creating reports or analytics (OLAP)

**Example - Analytics Dashboard:**

```sql
-- Denormalized view for fast dashboard queries
CREATE VIEW team_performance_denormalized AS
SELECT 
    t.full_name AS team_name,
    t.city,
    t.state,
    tgs.season,
    tgs.game_date,
    tgs.pts,
    tgs.wl
FROM team_game_stats tgs
JOIN teams t ON tgs.team_id = t.team_id;
```

**Why denormalize here?**
- Dashboard queries run constantly
- JOIN operations slow them down
- Team names don't change often
- Read-only (doesn't need update integrity)

### Hybrid Approach: Materialized Views

**Best of both worlds:**
- Keep normalized tables for data integrity
- Create denormalized views for performance
- Views auto-update when base tables change

```sql
-- Normalized tables (source of truth)
-- teams table
-- team_game_stats table

-- Denormalized view (for performance)
CREATE VIEW quick_team_stats AS
SELECT 
    t.full_name,
    tgs.season,
    COUNT(*) as games_played,
    AVG(tgs.pts) as avg_points
FROM team_game_stats tgs
JOIN teams t ON tgs.team_id = t.team_id
GROUP BY t.team_id, t.full_name, tgs.season;

-- Query the view (appears like a table!)
SELECT * FROM quick_team_stats
WHERE season = '2021-22'
ORDER BY avg_points DESC;
```

---

## Part 9: Database Design Best Practices

### 1. Use Meaningful Names

**✅ Good:**
```sql
CREATE TABLE teams (
    team_id INTEGER PRIMARY KEY,
    full_name TEXT,
    city TEXT
);
```

**❌ Bad:**
```sql
CREATE TABLE t (
    id INTEGER PRIMARY KEY,
    n TEXT,
    c TEXT
);
```

**Naming conventions:**
- Tables: plural nouns (`teams`, `players`, `games`)
- Columns: descriptive (`full_name`, not `n`)
- Foreign keys: match referenced column (`team_id` matches `teams.team_id`)
- Primary keys: `table_name_id` (e.g., `team_id`, `player_id`)

---

### 2. Choose Appropriate Data Types

**✅ Good:**
```sql
CREATE TABLE players (
    player_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    height_inches INTEGER,        -- Whole number
    weight_pounds REAL,           -- Decimal possible
    birth_date TEXT,              -- ISO format: 'YYYY-MM-DD'
    is_active INTEGER             -- 0 or 1 (SQLite doesn't have BOOLEAN)
);
```

**❌ Bad:**
```sql
CREATE TABLE players (
    player_id TEXT PRIMARY KEY,   -- IDs should be integers
    full_name TEXT,
    height_inches TEXT,           -- Numbers stored as text!
    birth_date INTEGER            -- Date as number?
);
```

**SQLite Data Types:**
- **INTEGER:** Whole numbers (IDs, counts, years)
- **REAL:** Decimals (averages, percentages)
- **TEXT:** Strings (names, dates in ISO format)
- **BLOB:** Binary data (images, files)

---

### 3. Define Constraints

**Use constraints to enforce business rules:**

```sql
CREATE TABLE team_game_stats (
    season TEXT NOT NULL,
    game_id TEXT NOT NULL,
    team_id INTEGER NOT NULL,
    pts INTEGER CHECK (pts >= 0),        -- No negative scores
    reb INTEGER CHECK (reb >= 0),
    wl TEXT CHECK (wl IN ('W', 'L')),   -- Only W or L allowed
    
    PRIMARY KEY (season, game_id, team_id),
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);
```

**Common constraints:**
- `NOT NULL` - Field must have a value
- `UNIQUE` - No duplicate values allowed
- `CHECK` - Value must satisfy condition
- `DEFAULT` - Default value if none provided
- `PRIMARY KEY` - Unique identifier
- `FOREIGN KEY` - References another table

**Real benefit:** Database rejects bad data automatically!

```sql
-- ❌ This fails (negative points)
INSERT INTO team_game_stats (season, game_id, team_id, pts)
VALUES ('2023-24', '0022300001', 1610612739, -10);
-- Error: CHECK constraint failed

-- ❌ This fails (invalid wl value)
INSERT INTO team_game_stats (season, game_id, team_id, wl)
VALUES ('2023-24', '0022300001', 1610612739, 'X');
-- Error: CHECK constraint failed
```

---

### 4. Index Foreign Keys

**Foreign keys should be indexed for faster JOINs:**

```sql
-- Create indexes on foreign key columns
CREATE INDEX idx_team_game_stats_team_id 
ON team_game_stats(team_id);

CREATE INDEX idx_player_season_stats_player_id 
ON player_season_stats(player_id);

CREATE INDEX idx_player_season_stats_team_id 
ON player_season_stats(team_id);
```

**Benefits:**
- Faster JOIN operations
- Faster WHERE clauses on foreign keys
- Better overall query performance

**Without indexes:**
```sql
-- Might scan every row to find matching team_id
SELECT * FROM team_game_stats WHERE team_id = 1610612739;
```

**With indexes:**
```sql
-- Uses index to jump directly to matching rows
SELECT * FROM team_game_stats WHERE team_id = 1610612739;
-- Much faster!
```

---

### 5. Document Your Design

**Create a data dictionary:**

```
TABLE: teams
PURPOSE: Stores NBA team information
COLUMNS:
  - team_id (INTEGER, PK): Unique identifier for each team (NBA official team ID)
  - full_name (TEXT): Official team name (e.g., "Cleveland Cavaliers")
  - abbreviation (TEXT): Three-letter team code (e.g., "CLE")
  - city (TEXT): Team's home city
  - state (TEXT): Team's home state
  
RELATIONSHIPS:
  - team_id referenced by team_game_stats.team_id (1:M)
  - team_id referenced by player_season_stats.team_id (1:M)

BUSINESS RULES:
  - team_id must be unique
  - full_name cannot be null
  
NOTES:
  - team_id values come from NBA official API
  - Some historical teams no longer exist but data preserved
```

**Document:**
- Table purposes
- Column meanings
- Relationships
- Business rules
- Known quirks or limitations

**Why?**
- Helps teammates understand structure
- Reminds you of design decisions
- Essential for maintenance
- Required in professional environments

---

## Part 10: Real-World Database Design Process

### Step-by-Step Design Process

**1. Identify Entities**

What "things" does the system need to track?

**Example - E-Commerce:**
- Customers
- Products
- Orders
- Categories
- Suppliers

**Example - School:**
- Students
- Teachers
- Courses
- Enrollments
- Grades

**NBA Database:**
- Teams
- Players
- Games
- Seasons

---

**2. Identify Attributes**

What information do we need about each entity?

**Example - Teams:**
- team_id (PK)
- full_name
- abbreviation
- city
- state
- year_founded

**Example - Players:**
- player_id (PK)
- full_name

**Why so few player attributes?**
- Height, weight change over time
- Position changes based on team/season
- Store changing attributes in separate time-based tables

---

**3. Identify Relationships**

How do entities connect?

**Relationship Types:**
- **1:1 (One-to-One):** Person ↔ Social Security Number
- **1:M (One-to-Many):** Team → Players (on roster)
- **M:N (Many-to-Many):** Players ↔ Teams (over careers)

**NBA Database Relationships:**
- Teams → Team_Game_Stats (1:M) - One team, many games
- Players → Player_Season_Stats (1:M) - One player, many seasons
- Players ↔ Teams (M:N) - Junction table: player_season_stats

---

**4. Apply Normalization**

Check each table against normal forms:
- **1NF:** Atomic values only?
- **2NF:** No partial dependencies?
- **3NF:** No transitive dependencies?

**Fix violations:**
- Split tables that violate rules
- Create junction tables for M:N relationships
- Add foreign keys

---

**5. Define Keys and Constraints**

```sql
CREATE TABLE teams (
    team_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL UNIQUE,
    abbreviation TEXT NOT NULL,
    city TEXT,
    state TEXT,
    year_founded INTEGER CHECK (year_founded > 1900)
);

CREATE TABLE player_season_stats (
    season TEXT NOT NULL,
    player_id INTEGER NOT NULL,
    team_id INTEGER NOT NULL,
    gp INTEGER CHECK (gp > 0 AND gp <= 82),
    pts REAL CHECK (pts >= 0),
    
    PRIMARY KEY (season, player_id, team_id),
    FOREIGN KEY (player_id) REFERENCES players(player_id),
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);
```

---

**6. Create ERD**

Draw visual representation showing:
- Entities (tables)
- Attributes (columns)
- Relationships (foreign keys)
- Primary keys
- Cardinality (1:1, 1:M, M:N)

---

**7. Implement and Test**

```sql
-- Create tables
CREATE TABLE teams (...);
CREATE TABLE players (...);
CREATE TABLE player_season_stats (...);

-- Test constraints
INSERT INTO teams VALUES (...);  -- Should work
INSERT INTO teams VALUES (...);  -- Test duplicate detection
INSERT INTO player_season_stats VALUES (...);  -- Test foreign key

-- Test relationships
SELECT * FROM player_season_stats ps
JOIN players p ON ps.player_id = p.player_id
JOIN teams t ON ps.team_id = t.team_id;
```

---

## Part 11: Common Design Patterns

### Pattern 1: Lookup Tables

**Purpose:** Store code/description pairs for standardized values.

**Example:**
```sql
CREATE TABLE game_locations (
    location_code TEXT PRIMARY KEY,
    description TEXT
);

INSERT INTO game_locations VALUES
    ('HOME', 'Home game'),
    ('AWAY', 'Away game'),
    ('NEUTRAL', 'Neutral site');

-- Reference in main table
CREATE TABLE games (
    game_id TEXT PRIMARY KEY,
    location_code TEXT,
    FOREIGN KEY (location_code) REFERENCES game_locations(location_code)
);
```

**Benefits:**
- Standardizes values
- Prevents typos
- Easy to change descriptions
- Maintains data integrity

---

### Pattern 2: Audit/History Tables

**Purpose:** Track changes over time.

**Example:**
```sql
CREATE TABLE teams_history (
    history_id INTEGER PRIMARY KEY,
    team_id INTEGER,
    full_name TEXT,
    city TEXT,
    effective_date TEXT,
    end_date TEXT,
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);
```

**Tracks:**
- Name changes
- Location changes
- When changes occurred

---

### Pattern 3: Self-Referencing Tables

**Purpose:** Hierarchical relationships within same entity type.

**Example - Coaching Tree:**
```sql
CREATE TABLE coaches (
    coach_id INTEGER PRIMARY KEY,
    full_name TEXT,
    mentor_coach_id INTEGER,  -- References another coach
    FOREIGN KEY (mentor_coach_id) REFERENCES coaches(coach_id)
);
```

**Enables queries like:** "Who did this coach learn from?"

---

## Part 12: Real-World Applications

### E-Commerce Database Design

**Entities:**
- Customers (customer_id, name, email, address)
- Products (product_id, name, price, category_id)
- Orders (order_id, customer_id, order_date, total)
- Order_Items (order_id, product_id, quantity, price)
- Categories (category_id, name)

**Key Relationships:**
- Customers → Orders (1:M)
- Orders → Order_Items (1:M)
- Products ↔ Orders (M:N through Order_Items)
- Categories → Products (1:M)

**Why normalized?**
- Product prices change (store price at order time in Order_Items)
- Customer addresses change (maintain history)
- Categories can be reorganized

---

### Social Media Database Design

**Entities:**
- Users (user_id, username, email)
- Posts (post_id, user_id, content, timestamp)
- Comments (comment_id, post_id, user_id, content)
- Likes (user_id, post_id)
- Friendships (user1_id, user2_id, status)

**Key Relationships:**
- Users → Posts (1:M)
- Posts → Comments (1:M)
- Users ↔ Posts (M:N through Likes)
- Users ↔ Users (M:N through Friendships)

---

### School Database Design

**Entities:**
- Students (student_id, name, grade)
- Teachers (teacher_id, name, department)
- Courses (course_id, name, teacher_id)
- Enrollments (student_id, course_id, semester, grade)
- Assignments (assignment_id, course_id, title, due_date)

**Key Relationships:**
- Teachers → Courses (1:M)
- Students ↔ Courses (M:N through Enrollments)
- Courses → Assignments (1:M)

---

## Part 13: Design Anti-Patterns (What NOT to Do)

### Anti-Pattern 1: God Table

**Bad:** One table with hundreds of columns

```sql
CREATE TABLE everything (
    id INTEGER PRIMARY KEY,
    customer_name TEXT,
    customer_address TEXT,
    order_date TEXT,
    product_name TEXT,
    product_price REAL,
    shipping_address TEXT,
    payment_method TEXT,
    -- ... 100 more columns
);
```

**Why bad?**
- Massive redundancy
- Hard to maintain
- Poor performance
- Difficult to query

**Fix:** Normalize into multiple related tables!

---

### Anti-Pattern 2: Storing Lists in Text

**Bad:** Comma-separated values in one column

```sql
CREATE TABLE teams (
    team_id INTEGER PRIMARY KEY,
    team_name TEXT,
    player_ids TEXT  -- '2544,203507,201939,203999'
);
```

**Why bad?**
- Can't query individual players
- Can't enforce foreign keys
- Violates 1NF
- Parsing required every query

**Fix:** Use junction table!

---

### Anti-Pattern 3: Using Meaningful Keys

**Bad:** Using player name as primary key

```sql
CREATE TABLE players (
    full_name TEXT PRIMARY KEY,  -- BAD!
    position TEXT
);
```

**Why bad?**
- Names can change
- Names might not be unique
- Typos create duplicates
- Longer foreign keys

**Fix:** Use surrogate keys (team_id, player_id)

---

## Summary

### Key Concepts Learned

**Database Design Goals:**
1. Eliminate redundancy
2. Prevent data anomalies (update, insert, delete)
3. Maintain data integrity
4. Support efficient queries
5. Enable easy maintenance

**Normalization Rules:**
- **1NF:** Atomic values, no repeating groups
- **2NF:** No partial dependencies (in composite keys)
- **3NF:** No transitive dependencies

**Keys:**
- **Primary Key:** Unique identifier for records
- **Composite Primary Key:** Multiple columns combined for uniqueness
- **Foreign Key:** References primary key in another table

**ERDs:**
- Visual representation of database structure
- Shows entities, attributes, and relationships
- Essential for planning and documentation

**Design Process:**
1. Identify entities
2. Identify attributes
3. Identify relationships
4. Apply normalization
5. Define keys and constraints
6. Create ERD
7. Implement and test

### Skills Gained

By the end of this lesson, you can:

✅ Identify data redundancy problems  
✅ Explain update, insertion, and deletion anomalies  
✅ Apply normalization rules (1NF, 2NF, 3NF)  
✅ Create entity-relationship diagrams  
✅ Implement primary keys (single and composite)  
✅ Implement foreign keys and referential integrity  
✅ Design multi-table database schemas  
✅ Decide when to normalize vs. denormalize  
✅ Apply database design principles to real-world scenarios

---

## Looking Ahead

**Next Lesson:** Data Modeling & Relationships
- Deep dive into relationship types
- Advanced ERD techniques
- Business rules and constraints
- Complex database scenarios

**Future Topics:**
- JOIN operations (connecting your normalized tables!)
- Data manipulation (INSERT, UPDATE, DELETE)
- Transactions and data integrity
- Database performance optimization

**Career Connection:**
- **Database Designer:** Plan database structure for applications
- **Data Architect:** Design enterprise-scale database systems
- **Backend Developer:** Implement databases for web applications
- **Data Engineer:** Build and maintain data warehouses

---

## Practice Exercises

See the task files for hands-on practice with:
- Identifying normalization violations
- Redesigning poorly structured tables
- Creating ERDs for real-world scenarios
- Implementing multi-table databases with proper keys
- Writing queries that leverage normalized structure

Remember: Good database design saves countless hours of frustration later! Time spent planning your database structure is never wasted.

---

## Additional Resources

**Books:**
- *Database Design for Mere Mortals* by Michael J. Hernandez
- *SQL and Relational Theory* by C.J. Date

**Websites:**
- SQLite Tutorial - Database Design Basics
- Database Star - Normalization Explained
- Mode Analytics - SQL Tutorial

**Tools:**
- Draw.io (free ERD diagrams)
- DB Browser for SQLite (visualize structure)
- Lucidchart (professional diagramming)

**Questions to Consider:**
1. Why do we use numeric IDs instead of names as primary keys?
2. What problems occur when you store the same data in multiple places?
3. When might you intentionally denormalize a database?
4. How do composite primary keys differ from single-column keys?
5. What is a junction table and when do you need one?

**Keep exploring and practicing - database design is a skill that improves with experience!**
