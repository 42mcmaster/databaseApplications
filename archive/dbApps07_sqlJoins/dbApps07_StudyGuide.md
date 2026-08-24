# SQL JOINs — Study Guide

**Unit 4, Lesson 2: Understanding Relationships Between Data**

Database Applications Development (145085)
Medina County Career Center
Instructor: Ryan McMaster

---

## 1. Vocabulary

Essential terms for understanding JOINs and relational databases:

| Term | Definition |
|------|-----------|
| **JOIN** | A SQL operation that combines rows from two or more tables based on a related column. |
| **INNER JOIN** | Returns only rows that have matching values in both tables. |
| **LEFT JOIN** | Returns all rows from the left table, plus matching rows from the right table. Non-matching rows from the right table show NULL. |
| **RIGHT JOIN** | Returns all rows from the right table, plus matching rows from the left table. (Note: SQLite does not support RIGHT JOIN directly; use LEFT JOIN with tables reversed.) |
| **FULL OUTER JOIN** | Returns all rows from both tables, with NULL for non-matches. (Note: SQLite does not support FULL OUTER JOIN; use UNION of LEFT and RIGHT JOINs as a workaround.) |
| **ON clause** | Specifies the condition(s) that determine how tables are matched during a JOIN. Example: `ON table1.id = table2.id` |
| **Table alias** | A shortened name assigned to a table using the AS keyword, making queries more readable. Example: `FROM users AS u` |
| **Matching rows** | Rows from two tables that share the same value in the JOIN condition. |
| **Non-matching rows** | Rows that do not find a partner in the other table; handled differently by INNER JOIN (excluded) vs LEFT JOIN (included with NULL). |
| **NULL** | A placeholder representing "no value" or "unknown." Appears in LEFT JOINs when a row from the left table has no match in the right table. |
| **Cartesian product** | The result of joining tables WITHOUT an ON clause; produces all possible combinations of rows (usually undesired and very large). Example: 1000 rows × 500 rows = 500,000 rows. |
| **Foreign key** | A column in one table that references the primary key of another table, establishing a relationship between tables. |
| **Primary key** | A unique identifier for each row in a table; often used as the anchor in JOIN conditions. |
| **ON condition** | The logical expression that determines which rows are matched in a JOIN. Often compares a foreign key to a primary key. |
| **Cross join** | A join with no ON clause that produces a Cartesian product. Rarely intentional. |

---

## 2. IMDb Database Data Dictionary

**Database:** `imdb_class.db`

### Table: title_basics
Fundamental information about titles (movies, TV shows, etc.).

| Column | Data Type | Description |
|--------|-----------|-------------|
| `tconst` | TEXT (PK) | Unique identifier for the title (IMDb standard format: "tt" + 7-10 digits). |
| `titleType` | TEXT | Type of title (movie, tvSeries, short, etc.). |
| `primaryTitle` | TEXT | The title used by IMDb for display. |
| `originalTitle` | TEXT | The original title in its native language. |
| `isAdult` | INTEGER | Boolean: 0 = not adult content, 1 = adult content. |
| `startYear` | INTEGER | Release year (or start year for TV series). Null for unknown. |
| `endYear` | INTEGER | End year for TV series. Null for movies or ongoing series. |
| `runtimeMinutes` | INTEGER | Duration in minutes. Null if unknown. |
| `genres` | TEXT | Comma-separated list of up to 3 genres (drama, comedy, action, etc.). |

**Row Count:** 57,198

---

### Table: title_ratings
Aggregated ratings and vote counts for titles.

| Column | Data Type | Description |
|--------|-----------|-------------|
| `tconst` | TEXT (PK, FK) | Foreign key to `title_basics(tconst)`. Unique identifier for the title. |
| `averageRating` | REAL | Weighted average of user ratings (0.0 to 10.0). |
| `numVotes` | INTEGER | Number of user ratings that contribute to the average. |

**Row Count:** 57,198
**Relationship:** One-to-one with `title_basics`. Every title has exactly one rating record.

---

### Table: name_basics
Information about people (actors, directors, writers, etc.).

| Column | Data Type | Description |
|--------|-----------|-------------|
| `nconst` | TEXT (PK) | Unique identifier for the person (IMDb standard format: "nm" + 7-10 digits). |
| `primaryName` | TEXT | The name used by IMDb for display. |
| `birthYear` | INTEGER | Year of birth. Null if unknown. |
| `deathYear` | INTEGER | Year of death. Null if still living. |
| `primaryProfession` | TEXT | Comma-separated list of up to 3 professions (actor, director, writer, etc.). |
| `knownForTitles` | TEXT | Comma-separated list of up to 4 titles the person is known for (tconst values). |

**Row Count:** 400,017

---

### Table: title_principals
Credits for people involved in titles (actors, directors, writers, producers, etc.).

| Column | Data Type | Description |
|--------|-----------|-------------|
| `tconst` | TEXT (FK) | Foreign key to `title_basics(tconst)`. Identifies the title. |
| `ordering` | INTEGER | Order of appearance/importance for the title (1, 2, 3, ...). |
| `nconst` | TEXT (FK) | Foreign key to `name_basics(nconst)`. Identifies the person. |
| `category` | TEXT | Role category (actor, actress, director, writer, producer, composer, cinematographer, etc.). |
| `job` | TEXT | Specific job (e.g., "Director," "Screenplay," "Original Music Composer"). Often null. |
| `characters` | TEXT | JSON-formatted list of character names (for actors). |

**Row Count:** 1,084,764
**Relationship:** Many-to-many between `title_basics` and `name_basics`. A title has many credits; a person appears in many titles.

---

### Table: title_crew_person
Alternative structure for credit information (directorship and writing credits).

| Column | Data Type | Description |
|--------|-----------|-------------|
| `tconst` | TEXT (FK) | Foreign key to `title_basics(tconst)`. Identifies the title. |
| `nconst` | TEXT (FK) | Foreign key to `name_basics(nconst)`. Identifies the person. |
| `role` | TEXT | Role type (director or writer). |

**Row Count:** 354,189
**Note:** This is a simplified alternative to `title_principals`. Use `title_principals` for more detailed information.

---

## 3. NBA Database Data Dictionary

**Database:** `nba_5seasons.db`

### Table: teams
NBA team information.

| Column | Data Type | Description |
|--------|-----------|-------------|
| `team_id` | INTEGER (PK) | Unique identifier for the team. |
| `full_name` | TEXT | Full team name (e.g., "Los Angeles Lakers"). |
| `abbreviation` | TEXT | Three-letter team code (e.g., "LAL"). |
| `nickname` | TEXT | Team nickname (e.g., "Lakers"). |
| `city` | TEXT | Home city. |
| `state` | TEXT | Home state. |
| `year_founded` | INTEGER | Year the team was established in the NBA. |

**Row Count:** 30

---

### Table: players
NBA player information.

| Column | Data Type | Description |
|--------|-----------|-------------|
| `player_id` | INTEGER (PK) | Unique identifier for the player. |
| `full_name` | TEXT | Player's full name. |

**Row Count:** 997

---

### Table: team_game_stats
Game-by-game team statistics.

| Column | Data Type | Description |
|--------|-----------|-------------|
| `season` | INTEGER | NBA season (e.g., 2014 for 2014-15 season). |
| `game_id` | INTEGER | Unique identifier for the game. |
| `team_id` | INTEGER (FK) | Foreign key to `teams(team_id)`. |
| `game_date` | TEXT | Date of the game (YYYY-MM-DD). |
| `matchup` | TEXT | Opponent info (e.g., "LAL vs. GSW"). |
| `wl` | TEXT | Game result: "W" for win, "L" for loss. |
| `pts` | INTEGER | Points scored by the team. |
| `fgm`, `fga` | INTEGER | Field goals made and attempted. |
| `fg3m`, `fg3a` | INTEGER | Three-pointers made and attempted. |
| `ftm`, `fta` | INTEGER | Free throws made and attempted. |
| `oreb`, `dreb` | INTEGER | Offensive and defensive rebounds. |
| `reb` | INTEGER | Total rebounds. |
| `ast` | INTEGER | Assists. |
| `stl` | INTEGER | Steals. |
| `blk` | INTEGER | Blocks. |
| `tov` | INTEGER | Turnovers. |
| `plus_minus` | INTEGER | Point differential (team points - opponent points). |

**Row Count:** 10,842
**Relationship:** Many-to-one with `teams`. Multiple games per team per season.

---

### Table: player_season_stats
Player season-level statistics.

| Column | Data Type | Description |
|--------|-----------|-------------|
| `season` | INTEGER | NBA season (e.g., 2014 for 2014-15 season). |
| `player_id` | INTEGER (FK) | Foreign key to `players(player_id)`. |
| `team_id` | INTEGER (FK) | Foreign key to `teams(team_id)`. |
| `gp` | INTEGER | Games played. |
| `min` | REAL | Minutes played per game average. |
| `pts` | REAL | Points per game average. |
| `reb` | REAL | Rebounds per game average. |
| `ast` | REAL | Assists per game average. |
| `stl` | REAL | Steals per game average. |
| `blk` | REAL | Blocks per game average. |
| `tov` | REAL | Turnovers per game average. |
| `fg_pct` | REAL | Field goal percentage (0.0 to 1.0). |
| `fg3_pct` | REAL | Three-point percentage (0.0 to 1.0). |
| `ft_pct` | REAL | Free throw percentage (0.0 to 1.0). |

**Row Count:** 2,791
**Relationship:** Many-to-many between `players` and `teams`. Players move between teams; teams have many players.

---

## 4. JOIN Syntax Quick Reference

### INNER JOIN

Returns only rows that match in BOTH tables.

**Syntax:**
```sql
SELECT [columns]
FROM table1 AS alias1
INNER JOIN table2 AS alias2
  ON alias1.key = alias2.key;
```

**Example (IMDb):**
```sql
SELECT tb.primaryTitle, tb.startYear, tr.averageRating, tr.numVotes
FROM title_basics AS tb
INNER JOIN title_ratings AS tr
  ON tb.tconst = tr.tconst
WHERE tr.averageRating > 8.0
ORDER BY tr.averageRating DESC
LIMIT 10;
```

**Example (NBA):**
```sql
SELECT p.full_name, t.full_name AS team_name, pss.season, pss.pts
FROM players AS p
INNER JOIN player_season_stats AS pss ON p.player_id = pss.player_id
INNER JOIN teams AS t ON pss.team_id = t.team_id
WHERE pss.season = 2018
ORDER BY pss.pts DESC
LIMIT 5;
```

---

### LEFT JOIN

Returns all rows from the left table, plus matching rows from the right table. Non-matching rows show NULL.

**Syntax:**
```sql
SELECT [columns]
FROM table1 AS alias1
LEFT JOIN table2 AS alias2
  ON alias1.key = alias2.key;
```

**Example (IMDb):**
```sql
SELECT tb.primaryTitle, tb.startYear, tr.averageRating
FROM title_basics AS tb
LEFT JOIN title_ratings AS tr
  ON tb.tconst = tr.tconst
WHERE tb.startYear IS NOT NULL
ORDER BY tb.startYear DESC
LIMIT 20;
```

**Example (NBA):**
```sql
SELECT t.full_name, t.year_founded, COUNT(pss.player_id) AS player_count
FROM teams AS t
LEFT JOIN player_season_stats AS pss ON t.team_id = pss.team_id
GROUP BY t.team_id
ORDER BY player_count DESC;
```

---

## 5. Common JOIN Patterns

### JOIN + WHERE Clause

Filter results after joining:

```sql
SELECT tb.primaryTitle, nb.primaryName, tr.averageRating
FROM title_basics AS tb
INNER JOIN title_principals AS tp ON tb.tconst = tp.tconst
INNER JOIN name_basics AS nb ON tp.nconst = nb.nconst
INNER JOIN title_ratings AS tr ON tb.tconst = tr.tconst
WHERE tp.category = 'director' AND tr.averageRating > 7.5 AND tb.startYear >= 2000;
```

**Order of execution:** JOINs happen first, then WHERE filters the results.

---

### JOIN + GROUP BY

Aggregate data after joining:

```sql
SELECT nb.primaryName, COUNT(*) AS movie_count, AVG(tr.averageRating) AS avg_rating
FROM name_basics AS nb
INNER JOIN title_principals AS tp ON nb.nconst = tp.nconst
INNER JOIN title_ratings AS tr ON tp.tconst = tr.tconst
WHERE tp.category = 'actor'
GROUP BY nb.nconst, nb.primaryName
HAVING COUNT(*) >= 5
ORDER BY avg_rating DESC;
```

**Order of execution:** JOINs → WHERE → GROUP BY → HAVING → ORDER BY.

---

### JOIN + ORDER BY

Sort results after joining:

```sql
SELECT t.full_name AS team_name, p.full_name AS player_name, pss.pts
FROM teams AS t
INNER JOIN player_season_stats AS pss ON t.team_id = pss.team_id
INNER JOIN players AS p ON pss.player_id = p.player_id
WHERE pss.season = 2019
ORDER BY pss.pts DESC, t.full_name ASC;
```

**Tip:** Use aliases and column positions to clarify sorting when joining multiple tables.

---

### Multiple JOINs (3+ tables)

Chain JOINs to connect many tables:

```sql
SELECT tb.primaryTitle, nb.primaryName, tp.category, tr.averageRating
FROM title_basics AS tb
INNER JOIN title_ratings AS tr ON tb.tconst = tr.tconst
INNER JOIN title_principals AS tp ON tb.tconst = tp.tconst
INNER JOIN name_basics AS nb ON tp.nconst = nb.nconst
WHERE tb.titleType = 'movie' AND tp.category IN ('director', 'writer')
ORDER BY tr.averageRating DESC;
```

**Key Point:** Each JOIN connects to the previous table(s) via the ON clause. Build from left to right.

---

### Handling NULL Values in Joins

When using LEFT JOIN, check for NULL to understand which rows had no match:

```sql
SELECT tb.primaryTitle, COALESCE(tr.averageRating, 'No rating') AS rating
FROM title_basics AS tb
LEFT JOIN title_ratings AS tr ON tb.tconst = tr.tconst
WHERE tr.tconst IS NULL;  -- This finds titles WITHOUT ratings
```

**COALESCE function:** Replaces NULL with a default value.

---

## 6. ODE Competencies Covered

This lesson aligns with the following **Ohio Department of Education** competencies for Database Applications Development:

- **Data Retrieval & Querying:** Write and execute SQL queries that retrieve data from multiple related tables.
- **Database Design & Relationships:** Understand and apply foreign key relationships and JOIN operations.
- **Relational Algebra:** Apply relational operators (especially the JOIN operator) to combine data logically.
- **SQL Syntax Mastery:** Master INNER JOIN, LEFT JOIN, and multi-table JOIN syntax and execution.
- **Analytical Thinking:** Use JOINs combined with WHERE, GROUP BY, and ORDER BY to answer complex data questions.
- **Problem Solving:** Identify appropriate JOIN types for specific data retrieval scenarios.

---

## 7. Additional Resources

- **SQLite Documentation:** [sqlite.org/join.html](https://www.sqlite.org/join.html)
- **W3Schools SQL JOINs:** Interactive examples and practice problems.
- **Khan Academy — Databases:** Introduction to relational database concepts.
- **Instructor Office Hours:** Bring questions about JOIN logic and multi-table queries.

---

**Next Steps:**
1. Review the syntax reference above.
2. Work through live examples with your instructor (07a, 07b, 07c).
3. Complete the DIY task in dbApps07d.
4. Study this guide before the Unit 4 Quiz.

