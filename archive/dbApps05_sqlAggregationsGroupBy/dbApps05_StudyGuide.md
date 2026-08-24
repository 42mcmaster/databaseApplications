# dbApps05 Study Guide: SQL Aggregations, GROUP BY & Excel

**Course:** Database Applications Development (145085)
**Lesson:** 05 — SQL Aggregations, GROUP BY & Excel Integration
**Dataset:** nba_5seasons.db

---

## Learning Objectives

After completing this lesson, you should be able to:

1. Use aggregate functions: COUNT, SUM, AVG, MIN, MAX, ROUND
2. Use GROUP BY to calculate aggregates per category
3. Use AS to create readable column aliases
4. Explain the difference between WHERE and HAVING
5. Use HAVING to filter groups after aggregation
6. Combine all SQL clauses in the correct order
7. Export SQL query results to an Excel file using pandas
8. Add basic formulas and formatting to Excel with openpyxl

---

## Key Vocabulary

| Term | Definition |
|------|-----------|
| **Aggregate Function** | A function that calculates one value from many rows (COUNT, AVG, etc.) |
| **COUNT(*)** | Counts the number of rows |
| **COUNT(column)** | Counts non-null values in a column |
| **SUM(column)** | Adds up all values in a column |
| **AVG(column)** | Calculates the average (mean) of a column |
| **MAX(column)** | Returns the largest value |
| **MIN(column)** | Returns the smallest value |
| **ROUND(value, n)** | Rounds a number to n decimal places |
| **GROUP BY** | Splits data into groups and calculates aggregates per group |
| **AS** | Creates an alias (nickname) for a column in results |
| **HAVING** | Filters groups after GROUP BY (can use aggregate functions) |
| **WHERE vs HAVING** | WHERE filters individual rows before grouping; HAVING filters groups after |
| **openpyxl** | A Python library for reading and writing Excel files |
| **ExcelWriter** | A pandas tool for writing multiple sheets to one Excel file |
| **.to_excel()** | pandas method that saves a DataFrame to an .xlsx file |

---

## Concept Review

### Aggregate Functions

Aggregate functions collapse many rows into one summary value. COUNT(*) counts all rows. SUM, AVG, MIN, and MAX work on number columns. ROUND() wraps any value and rounds it to a specified number of decimals. Without GROUP BY, aggregates return a single row for the entire table.

### GROUP BY

GROUP BY tells SQL to split the data into groups based on a column's values, then calculate the aggregate for each group separately. `GROUP BY season` gives you one row per season. `GROUP BY team_id` gives one row per team. You can group by multiple columns: `GROUP BY team_id, season` gives one row per team-per-season.

### Column Aliases (AS)

AS renames a column in the output. Without it, calculated columns have ugly names like `ROUND(AVG(pts), 1)`. With AS, you get clean names like `avgPoints`. Aliases make results easier to read and are especially important when exporting to Excel.

### HAVING vs WHERE

WHERE filters individual rows before any grouping happens — it cannot use aggregate functions. HAVING filters after GROUP BY — it works on the grouped results and CAN use aggregates. Example: `WHERE season = '2023-24'` filters to one season's games. `HAVING AVG(pts) > 110` keeps only groups where the average exceeds 110.

### Full Clause Order

SQL requires clauses in this order: `SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY → LIMIT`. You don't need every clause, but those you use must follow this order.

### SQL to Excel

pandas can save any DataFrame to Excel with `.to_excel("filename.xlsx", index=False)`. For fancier output (formulas, formatting, multiple sheets), use the openpyxl library. The workflow is: run SQL → get DataFrame → save to Excel → optionally add formulas/formatting with openpyxl.

---

## NBA Database — Data Dictionary

### teams (30 rows)
| Column | Type | Description |
|--------|------|-------------|
| team_id | INTEGER | Unique team identifier |
| full_name | TEXT | Full team name (e.g., "Los Angeles Lakers") |
| abbreviation | TEXT | 3-letter code (e.g., "LAL") |
| nickname | TEXT | Team nickname (e.g., "Lakers") |
| city | TEXT | City name |
| state | TEXT | State name |
| year_founded | INTEGER | Year team was established |

### players (997 rows)
| Column | Type | Description |
|--------|------|-------------|
| player_id | INTEGER | Unique player identifier |
| full_name | TEXT | Player's full name |

### team_game_stats (10,842 rows)
| Column | Type | Description |
|--------|------|-------------|
| season | TEXT | Season (e.g., "2023-24") |
| game_id | TEXT | Unique game identifier |
| team_id | INTEGER | Team that played |
| game_date | TEXT | Date of the game |
| matchup | TEXT | Who played who (e.g., "LAL vs. BOS") |
| wl | TEXT | Win or Loss ("W" or "L") |
| pts | INTEGER | Points scored |
| fgm | INTEGER | Field goals made |
| fga | INTEGER | Field goals attempted |
| fg3m | INTEGER | 3-pointers made |
| fg3a | INTEGER | 3-pointers attempted |
| ftm | INTEGER | Free throws made |
| fta | INTEGER | Free throws attempted |
| oreb | INTEGER | Offensive rebounds |
| dreb | INTEGER | Defensive rebounds |
| reb | INTEGER | Total rebounds |
| ast | INTEGER | Assists |
| stl | INTEGER | Steals |
| blk | INTEGER | Blocks |
| tov | INTEGER | Turnovers |
| plus_minus | INTEGER | Point differential while on court |

### player_season_stats (2,791 rows)
| Column | Type | Description |
|--------|------|-------------|
| season | TEXT | Season |
| player_id | INTEGER | Player identifier |
| team_id | INTEGER | Team identifier |
| gp | INTEGER | Games played |
| min | REAL | Minutes per game |
| pts | REAL | Points per game |
| reb | REAL | Rebounds per game |
| ast | REAL | Assists per game |
| stl | REAL | Steals per game |
| blk | REAL | Blocks per game |
| tov | REAL | Turnovers per game |
| fg_pct | REAL | Field goal percentage |
| fg3_pct | REAL | 3-point percentage |
| ft_pct | REAL | Free throw percentage |

---

## SQL Quick Reference

### Aggregate Functions
```sql
SELECT COUNT(*) FROM team_game_stats
SELECT AVG(pts) FROM player_season_stats
SELECT SUM(pts) FROM team_game_stats
SELECT MAX(pts) FROM team_game_stats
SELECT MIN(pts) FROM team_game_stats
SELECT ROUND(AVG(pts), 1) FROM player_season_stats
```

### GROUP BY
```sql
SELECT season, ROUND(AVG(pts), 1) AS avgPoints
FROM player_season_stats
GROUP BY season

SELECT team_id, COUNT(*) AS totalGames, SUM(CASE WHEN wl='W' THEN 1 ELSE 0 END) AS wins
FROM team_game_stats
GROUP BY team_id
```

### HAVING
```sql
SELECT team_id, AVG(pts) AS avgPts
FROM team_game_stats
GROUP BY team_id
HAVING AVG(pts) > 110
```

### Full Template
```sql
SELECT column, AGG(column) AS alias
FROM table
WHERE condition
GROUP BY column
HAVING AGG(column) > value
ORDER BY alias DESC
LIMIT 10
```

### Excel Export
```python
result = pd.read_sql("SELECT ...", conn)
result.to_excel("output.xlsx", index=False)
```

---

## ODE Competencies Covered

| Competency | Description |
|-----------|-------------|
| 8.5.4 | Generate reports with calculated fields and functions |
| 5.1.2 | Explain algorithms and data structures |
| 5.5.6 | Format output (reports, data files) |
