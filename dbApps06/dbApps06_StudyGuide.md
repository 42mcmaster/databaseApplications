# dbApps06: Database Design & Normalization — Study Guide

**Database Applications Development**
**Medina County Career Center | Instructor: Ryan McMaster**

---

## Vocabulary & Key Concepts

### Core Database Terms

1. **Entity** - A person, place, thing, or event that you want to store information about in a database. In database design, entities become tables.
   - *NBA Example:* Team, Player, Game

2. **Attribute** - A characteristic or property of an entity that you want to track. In a table, attributes become columns.
   - *NBA Example:* Team attributes include name, city, state, founded_year

3. **Table** - A structured collection of data organized in rows and columns (like a spreadsheet). Each table represents one entity type.
   - *NBA Example:* The "teams" table stores information about all 30 NBA teams

4. **Row** (also Record) - A single instance of an entity; one complete record in a table.
   - *NBA Example:* One row in the teams table = one NBA team

5. **Column** (also Field) - A named attribute that appears in every row; the vertical organization of data.
   - *NBA Example:* The "city" column in the teams table

6. **Primary Key (PK)** - A column (or set of columns) that uniquely identifies each row in a table. No two rows can have the same primary key value, and it can never be empty (NULL).
   - *NBA Example:* team_id in the teams table (e.g., 1610612747 for Lakers)

7. **Foreign Key (FK)** - A column in one table that references the primary key of another table. Foreign keys create relationships between tables.
   - *NBA Example:* team_id in the team_game_stats table references team_id in the teams table

8. **Composite Key** - A primary key made up of two or more columns combined. Used when no single column uniquely identifies a row.
   - *NBA Example:* In player_season_stats, (player_id, season) might be a composite key

9. **Relationship** - A connection between tables that allows you to link data across them. Relationships are defined by primary and foreign keys.
   - *NBA Example:* The relationship between teams and team_game_stats tables

10. **One-to-Many (1:M)** - A relationship where one row in Table A can be linked to many rows in Table B, but each row in Table B links to only one row in Table A.
    - *NBA Example:* One team has many games (1:M relationship between teams and team_game_stats)

11. **Many-to-Many (M:M)** - A relationship where rows in Table A can link to many rows in Table B, and vice versa. Requires a junction table.
    - *NBA Example:* A player can play for many teams, and a team can have many players

12. **Junction Table** - A linking table that connects two tables in a many-to-many relationship. Also called a "join table" or "bridge table."
    - *NBA Example:* If we needed to track which players were on which teams across seasons, we'd use a junction table with player_id and team_id columns

### Normalization & Data Quality Terms

13. **Redundancy** - Storing the same information multiple times unnecessarily in a database.
    - *Problem:* If team city is stored in every game row, "Cleveland" might appear 82 times
    - *Solution:* Store "Cleveland" once in the teams table, reference it with team_id

14. **Update Anomaly** - An inconsistency that occurs when updating data in a redundant database. When you update data in one place but forget to update it elsewhere.
    - *Example:* If Lakers change their name, but you only update 100 of the 1,200 game records mentioning them, you now have inconsistent data

15. **Insert Anomaly** - A problem where you cannot insert data into a table without redundant or incomplete information.
    - *Example:* Can't add a new team to a game record unless that team already exists and you include all team information

16. **Delete Anomaly** - A problem where deleting one piece of information unintentionally deletes related information.
    - *Example:* If you delete the last game record for a team, you might lose the team's information if it's all stored in one table

17. **Normalization** - The process of organizing database tables to reduce redundancy and improve data integrity. Follows a series of rules called "normal forms."

18. **First Normal Form (1NF)** - Each table has only one row type, columns contain only single values (no repeating groups), and every row is unique.
    - *Rule:* No columns like "coach1, coach2, coach3" — split them into separate rows if needed

19. **Second Normal Form (2NF)** - Must satisfy 1NF AND all non-key columns depend on the ENTIRE primary key (especially important for composite keys).
    - *Example:* If player_id and season are the composite key, don't store player_name (which depends only on player_id, not season)

20. **Third Normal Form (3NF)** - Must satisfy 2NF AND non-key columns depend ONLY on the primary key, not on other non-key columns.
    - *Rule:* If city depends on team_id, and team_id is the primary key, that's OK. But don't put team_id in multiple tables unless it's a foreign key!

21. **Denormalized** - A database that has been intentionally designed to violate normalization rules (usually for performance reasons). Data may be duplicated for faster queries.
    - *Trade-off:* Faster reads but slower updates, more storage, risk of inconsistency

22. **Data Integrity** - The accuracy, consistency, and reliability of data in a database. Good design maintains integrity; redundancy damages it.

### Design & Documentation Terms

23. **Entity-Relationship (ER) Diagram** - A visual representation of entities, their attributes, and the relationships between them. Used to plan database structure before building it.

24. **Schema** - The overall structure of a database, including all tables, columns, data types, keys, and relationships.

25. **Crow's Foot Notation** - A standard way of drawing relationships in ER diagrams. The "crow's foot" symbol (like branches) shows the "many" side of a 1:M relationship.

---

## NBA Database Structure Reference

### The Four Tables

The nba_5seasons.db database contains 4 tables that demonstrate good database design:

```
┌─────────────────────────────────────────────────────────────────────┐
│                           TABLES OVERVIEW                           │
└─────────────────────────────────────────────────────────────────────┘
```

#### 1. **teams** Table

| Column Name | Data Type | Key Type | Description |
|---|---|---|---|
| team_id | INTEGER | PRIMARY KEY | Unique identifier for each team |
| full_name | TEXT | | Official team name (e.g., "Los Angeles Lakers") |
| abbreviation | TEXT | | 3-letter team abbreviation (e.g., "LAL") |
| city | TEXT | | City where team is located |
| state | TEXT | | State (usually "CA", "NY", etc.) |
| founded_year | INTEGER | | Year the team was founded |

**Primary Key:** team_id
**Example Row:** (1610612747, "Los Angeles Lakers", "LAL", "Los Angeles", "CA", 1949)

---

#### 2. **players** Table

| Column Name | Data Type | Key Type | Description |
|---|---|---|---|
| player_id | INTEGER | PRIMARY KEY | Unique identifier for each player |
| full_name | TEXT | | Player's full name |
| position | TEXT | | Playing position (PG, SG, SF, PF, C) |
| height | REAL | | Height in inches |
| weight | REAL | | Weight in pounds |
| birth_date | TEXT | | Date of birth (YYYY-MM-DD format) |

**Primary Key:** player_id
**Example Row:** (2544, "LeBron James", "SF", 81.0, 250.0, "1984-12-30")

---

#### 3. **team_game_stats** Table

| Column Name | Data Type | Key Type | Description |
|---|---|---|---|
| game_id | TEXT | PRIMARY KEY (part 1) | Unique identifier for the game |
| season | INTEGER | PRIMARY KEY (part 2) | Season year (e.g., 2016, 2017) |
| team_id | INTEGER | FOREIGN KEY | References teams.team_id |
| points | INTEGER | | Points scored by the team in this game |
| field_goals_made | INTEGER | | Number of field goals made |
| field_goals_attempted | INTEGER | | Number of field goals attempted |
| three_pointers_made | INTEGER | | Number of 3-pointers made |
| three_pointers_attempted | INTEGER | | Number of 3-pointers attempted |
| free_throws_made | INTEGER | | Number of free throws made |
| free_throws_attempted | INTEGER | | Number of free throws attempted |
| rebounds | INTEGER | | Total rebounds |
| assists | INTEGER | | Total assists |
| turnovers | INTEGER | | Total turnovers |
| steals | INTEGER | | Total steals |
| blocks | INTEGER | | Total blocks |
| fouls | INTEGER | | Total fouls |

**Primary Key:** (game_id, season) — composite key
**Foreign Key:** team_id → teams.team_id
**Example Row:** ("0021600001", 2016, 1610612747, 110, 40, 81, 12, 35, 14, 19, 48, 28, 16, 6, 5, 20)

---

#### 4. **player_season_stats** Table

| Column Name | Data Type | Key Type | Description |
|---|---|---|---|
| player_id | INTEGER | PRIMARY KEY (part 1) | References players.player_id |
| season | INTEGER | PRIMARY KEY (part 2) | Season year (e.g., 2016, 2017) |
| team_id | INTEGER | FOREIGN KEY | References teams.team_id (which team player was on) |
| games_played | INTEGER | | Number of games played in the season |
| minutes | REAL | | Total minutes played |
| points | REAL | | Average points per game |
| field_goal_percentage | REAL | | Field goal % (0.0 to 1.0) |
| three_point_percentage | REAL | | 3-point % (0.0 to 1.0) |
| free_throw_percentage | REAL | | Free throw % (0.0 to 1.0) |
| rebounds | REAL | | Average rebounds per game |
| assists | REAL | | Average assists per game |
| turnovers | REAL | | Average turnovers per game |
| steals | REAL | | Average steals per game |
| blocks | REAL | | Average blocks per game |

**Primary Key:** (player_id, season) — composite key
**Foreign Keys:**
- player_id → players.player_id
- team_id → teams.team_id

**Example Row:** (2544, 2016, 1610612747, 79, 3068.0, 26.4, 0.521, 0.339, 0.735, 7.4, 6.2, 3.3, 1.3, 1.3)

---

### NBA Database Relationships

```
┌──────────────────────────────────────────────────────────────┐
│                   RELATIONSHIPS DIAGRAM                      │
└──────────────────────────────────────────────────────────────┘

teams (PK: team_id)
    ↓ ← Many games (1:M)
team_game_stats (FK: team_id)

teams (PK: team_id)
    ↓ ← Many player-seasons (1:M)
player_season_stats (FK: team_id)

players (PK: player_id)
    ↓ ← Many player-seasons (1:M)
player_season_stats (FK: player_id)
```

**Summary:**
- **teams → team_game_stats:** 1:M (One team plays many games)
- **teams → player_season_stats:** 1:M (One team has many player-seasons)
- **players → player_season_stats:** 1:M (One player has many season records)

---

## Normalization Quick Reference

### Why Normalize?

**Problems it prevents:**
- Redundancy (storing same data multiple times)
- Update anomalies (inconsistent changes)
- Insert anomalies (can't add data without duplicating other info)
- Delete anomalies (deleting one thing accidentally removes related data)
- Wasted storage space

**Benefits:**
- Reduced storage space
- Data consistency and integrity
- Easier updates and maintenance
- Better query performance (fewer duplicates)
- Logical organization

---

### The Three Normal Forms (Simplified)

#### First Normal Form (1NF)
**Goal:** Eliminate repeating groups. Each cell contains only ONE value, not a list.

**Rule:** Every column must be "atomic" (can't be broken down further)

**BAD:**
```
| team_id | full_name       | coaches           |
|---------|-----------------|-------------------|
| 1       | Lakers          | Head, Assistant 1, Assistant 2 |
```

**GOOD:**
```
| team_id | full_name | coach_name   |
|---------|-----------|--------------|
| 1       | Lakers    | Coach A      |
| 1       | Lakers    | Coach B      |
| 1       | Lakers    | Coach C      |
```

Or better yet, create a separate coaches table!

---

#### Second Normal Form (2NF)
**Goal:** After achieving 1NF, ensure that non-key columns depend on the ENTIRE primary key.

**Rule:** If you have a composite primary key (multiple columns), every non-key column must depend on the WHOLE key, not just part of it.

**BAD Example:**
```
Primary Key: (player_id, season)

| player_id | season | team_id | player_name | points |
|-----------|--------|---------|-------------|--------|
| 2544      | 2016   | 1610612747 | LeBron    | 26.4   |
```

Problem: `player_name` depends only on `player_id`, not on the entire composite key. It doesn't change based on the season!

**GOOD Solution:**
- Put player_name in the players table (with player_id as PK)
- Put points in player_season_stats (with composite key)

---

#### Third Normal Form (3NF)
**Goal:** After achieving 2NF, ensure non-key columns depend ONLY on the primary key, not on other non-key columns.

**BAD Example:**
```
| player_id | full_name | team_id | team_name | city       |
|-----------|-----------|---------|-----------|------------|
| 2544      | LeBron    | 1610612747 | Lakers    | Los Angeles|
```

Problem: `city` depends on `team_id`, not on `player_id`. If a player gets traded, we'd need to update multiple columns!

**GOOD Solution:**
- Store team information (team_name, city) in the teams table
- In the players table, just store player_id, full_name
- Reference team_id where needed via foreign key

---

### Quick Normalization Checklist

**Is your table in 1NF?**
- ✅ All columns contain single values (no lists or repeating groups)
- ✅ All rows are unique
- ✅ Table has a primary key

**Is your table in 2NF?**
- ✅ Satisfies 1NF
- ✅ No composite key, OR every non-key column depends on the entire composite key

**Is your table in 3NF?**
- ✅ Satisfies 2NF
- ✅ No non-key column depends on another non-key column
- ✅ If Column A depends on Column B (and B isn't the primary key), put them in separate tables

---

## ER Diagram Notation

### Basic Elements

#### Entities (Tables)
```
┌──────────────────────────┐
│         ENTITY           │
├──────────────────────────┤
│ Attribute 1              │
│ Attribute 2              │
│ Attribute 3              │
└──────────────────────────┘
```

**Example:**
```
┌──────────────────────────┐
│          TEAMS           │
├──────────────────────────┤
│ PK  team_id              │
│     full_name            │
│     city                 │
│     state                │
└──────────────────────────┘
```

**Notation:**
- **PK** = Primary Key
- **FK** = Foreign Key
- Attributes without PK/FK are regular columns

---

#### Relationships & Crow's Foot Notation

**One-to-Many (1:M)** — One entity relates to many of another

```
TEAMS ────────1 : M────────── TEAM_GAME_STATS
     "has many"
```

**Crow's Foot Symbols:**
- **━━━━━━** (line) = single connection (the "one" side)
- **┝╾┿╾┥** (crow's foot) = multiple connections (the "many" side)

**Full Example:**
```
┌──────────────────┐                    ┌────────────────────────┐
│      TEAMS       │                    │  TEAM_GAME_STATS       │
├──────────────────┤        1:M         ├────────────────────────┤
│ PK team_id       │─────────┼─────────┤ PK game_id             │
│   full_name      │    has  │ played  │ PK season              │
│   city           │         ├─────────┤ FK team_id             │
│   state          │         │         │    points              │
└──────────────────┘         │         │    rebounds            │
                             │         │    assists             │
                             │         └────────────────────────┘
                             └─── "Each team plays many games"
                                  "Each game belongs to one team"
```

---

**Many-to-Many (M:M)** — Multiple relationships via junction table

```
PLAYERS ──M:1── PLAYER_TEAM_JUNCTION ──1:M── TEAMS
```

(In our NBA database, player_season_stats acts like a junction table!)

---

#### Reading an ER Diagram

1. **Look at the boxes** - These are your entities (tables)
2. **Look at the attributes** - These become columns; PK is the identifier
3. **Look at the lines** - These show relationships
4. **Check the ends** - Single line = "one," crow's foot = "many"
5. **Read the relationship** - "A has many B" or "B belongs to A"

---

## ODE Competencies Addressed in dbApps06

This lesson covers the following Ohio Department of Education (ODE) competencies:

### Database Knowledge Competencies

**2.8.4 — Describe elements of a database**
- Tables, records, fields
- Relationships between entities
- Schema structure
- Normalization principles
- Primary keys and foreign keys

**8.1.2 — Understand levels of data abstraction**
- Why we model data at different levels of detail
- Conceptual design vs. physical implementation

**8.1.3 — Select data model based on specifications**
- Determining which structure (normalized vs. denormalized) fits your needs
- Choosing between different design approaches

**8.1.4 — Identify relationships**
- Primary keys and foreign keys
- One-to-many and many-to-many relationships
- How entities connect

**8.1.5 — Determine format for data storage**
- Choosing data types for columns
- Deciding what gets stored together vs. separately

**8.1.7 — Normalize the data model**
- Understanding 1NF, 2NF, 3NF
- Reducing redundancy and anomalies

**8.1.8 — Generate documentation**
- Creating ER diagrams
- Writing data dictionaries

**5.1.3 — Model solutions**
- Using ER diagrams to visualize database structure

---

## Sample Study Questions

1. **What is a primary key, and why do we need one?**
   - *Answer:* A primary key is a column that uniquely identifies each row. We need one to ensure data integrity and make sure each record is distinct.

2. **How does a foreign key create relationships between tables?**
   - *Answer:* A foreign key in one table references the primary key of another table, linking related data across tables.

3. **What problem does redundancy cause in databases?**
   - *Answer:* Redundancy wastes space, makes updates difficult (update anomalies), and increases the risk of inconsistent data.

4. **Why is 3NF better than storing everything in one table?**
   - *Answer:* 3NF eliminates redundancy, prevents update/insert/delete anomalies, saves storage, and keeps data organized logically.

5. **In the NBA database, why is team information in a separate table from game statistics?**
   - *Answer:* Team info (city, state, etc.) is the same for all games. Storing it separately eliminates redundancy — "Los Angeles" is stored once, not 82+ times.

6. **What is a composite key, and when would you use one?**
   - *Answer:* A composite key is two or more columns combined to form the primary key. Use it when no single column uniquely identifies a row (e.g., player_id + season).

7. **How would you represent a many-to-many relationship in a database?**
   - *Answer:* With a junction table that contains foreign keys to both entities, creating two one-to-many relationships.

---

## Key Takeaways

1. **Good database design is about organization and consistency.**
2. **Redundancy is the enemy** — each fact should be stored exactly once.
3. **Keys are connectors** — primary keys identify rows; foreign keys link tables.
4. **Normalization is a step-by-step process** from 1NF → 2NF → 3NF.
5. **ER diagrams visualize relationships** before you build the actual database.
6. **The NBA database exemplifies good design** — 4 focused tables with clear relationships.

---

**Next Steps:** Practice identifying redundancy, designing your own ER diagrams, and creating normalized tables!
