---
marp: true
theme: default
class: invert
paginate: true
---

# Lesson 05: SQL Aggregations, GROUP BY & Excel

## Database Applications Development
### Medina County Career Center

---

<!-- _header: "Sub-Lesson 05a — Aggregate Functions" -->

## New Dataset: NBA 5 Seasons

We're moving from Titanic to the **NBA database** — 4 tables, real basketball data.

| Table | Rows | What it holds |
|-------|------|---------------|
| `teams` | 30 | Team name, city, state, year founded |
| `players` | 997 | Player names |
| `team_game_stats` | 10,842 | Every game's box score |
| `player_season_stats` | 2,791 | Per-season averages per player |

```python
import pandas as pd, sqlite3
conn = sqlite3.connect("nba_5seasons.db")
```

---

<!-- _header: "Sub-Lesson 05a — Aggregate Functions" -->

## Aggregate Functions

An **aggregate function** calculates a single value from many rows.

```sql
SELECT COUNT(*) FROM team_game_stats             -- Total games
SELECT AVG(pts) FROM player_season_stats          -- Average points
SELECT SUM(pts) FROM team_game_stats              -- Total points scored
SELECT MAX(pts) FROM team_game_stats              -- Highest scoring game
SELECT MIN(pts) FROM team_game_stats              -- Lowest scoring game
SELECT ROUND(AVG(pts), 1) FROM player_season_stats -- Rounded average
```

| Function | What it does |
|----------|-------------|
| `COUNT(*)` | Counts rows |
| `AVG(col)` | Average |
| `SUM(col)` | Total |
| `MAX(col)` | Largest value |
| `MIN(col)` | Smallest value |
| `ROUND(val, n)` | Round to n decimals |

> **05a Task:** Basic aggregation queries on NBA data

---

<!-- _header: "Sub-Lesson 05b — GROUP BY and Aliases" -->

## GROUP BY

**GROUP BY** splits data into groups and calculates aggregates per group.

```sql
-- Average points per season
SELECT season, ROUND(AVG(pts), 1) AS avgPoints
FROM player_season_stats
GROUP BY season

-- Wins and losses per team
SELECT team_id, wl, COUNT(*) AS games
FROM team_game_stats
GROUP BY team_id, wl
```

Without GROUP BY you get one total. With GROUP BY you get **one row per group**.

---

<!-- _header: "Sub-Lesson 05b — GROUP BY and Aliases" -->

## Column Aliases (AS)

**AS** gives a column a readable name in the results:

```sql
SELECT team_id,
       COUNT(*) AS totalGames,
       ROUND(AVG(pts), 1) AS avgPoints
FROM team_game_stats
GROUP BY team_id
```

Without AS, columns are named `COUNT(*)` and `ROUND(AVG(pts), 1)` — messy.

> **05b Task:** Categorical analysis — group by team, season, state

---

<!-- _header: "Sub-Lesson 05c — HAVING vs WHERE" -->

## HAVING vs WHERE

Both filter rows, but at different stages:

| | WHERE | HAVING |
|--|-------|--------|
| **Filters** | Individual rows | Groups (after GROUP BY) |
| **Timing** | Before grouping | After grouping |
| **Can use aggregates?** | No | Yes |

```sql
-- WHERE filters rows BEFORE grouping
SELECT team_id, AVG(pts) AS avgPts
FROM team_game_stats
WHERE season = '2023-24'
GROUP BY team_id

-- HAVING filters groups AFTER grouping
SELECT team_id, AVG(pts) AS avgPts
FROM team_game_stats
GROUP BY team_id
HAVING AVG(pts) > 110
```

> **05c Task:** dbApps05 DIY Task Part 1 (aggregation queries)

---

<!-- _header: "Sub-Lesson 05d — SQL to Excel Export" -->

## Exporting SQL Results to Excel

Run a query, get a DataFrame, save to Excel — three steps:

```python
# Step 1: Run query
topScorers = pd.read_sql("""
    SELECT p.full_name, ps.pts, ps.season
    FROM player_season_stats ps
    JOIN players p ON ps.player_id = p.player_id
    ORDER BY ps.pts DESC LIMIT 20
""", conn)

# Step 2: Save to Excel
topScorers.to_excel("top_scorers.xlsx", index=False)
```

You can also add **multiple sheets** to one file using `ExcelWriter`.

---

<!-- _header: "Sub-Lesson 05d — SQL to Excel Export" -->

## Excel Formulas and Formatting with openpyxl

```python
from openpyxl import load_workbook

wb = load_workbook("top_scorers.xlsx")
ws = wb.active

# Add a formula in a new column
ws["D1"] = "Points Per Game Label"
ws["D2"] = "=IF(B2>25, \"Elite\", \"Good\")"

# Save
wb.save("top_scorers.xlsx")
```

**Key idea:** Python gets the data, Excel makes it presentable.

> **05d Task:** Export NBA queries to Excel, add formulas and formatting

---

<!-- _header: "Summary" -->

## Full Query Template

```sql
SELECT column, AGG(column) AS alias
FROM table
WHERE condition              -- filter rows first
GROUP BY column              -- split into groups
HAVING AGG(column) > value   -- filter groups
ORDER BY alias DESC          -- sort results
LIMIT 10                     -- limit output
```

**Clause order:** SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY → LIMIT

> **05e:** Complete DIY Task Part 2 (Excel workflow) → Gimkit → Unit 3 Quiz
