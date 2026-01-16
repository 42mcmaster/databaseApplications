---
marp: true
theme: default
class: invert
paginate: true
---

# Lesson 05: SQL Aggregations & GROUP BY
## Analyzing Data with Summary Statistics

## Database Applications Development
### Software Engineering | Medina County Career Center

---

## Learning Objectives

By the end of this lesson, you will be able to:

- Use SQL aggregate functions (COUNT, SUM, AVG, MIN, MAX)
- Group data with GROUP BY to analyze categories
- Filter groups with HAVING clause
- Export query results to Excel for analysis

**Today:** Learn to ask summary questions of your data!

---

## Where We Are

**Lessons 1-2:** Python & pandas  
**Lessons 3-4:** SELECT, WHERE, ORDER BY  
**Today:** Aggregations - SQL's main purpose
**Next:** Database design

**Moving from row-level to summary-level analysis**

---

## What Are Aggregate Functions?

**Aggregate = Calculate across multiple rows, return ONE result**

**Think:**
- Individual students → Class average
- Daily sales → Monthly total
- All games → Season high score

---

**The Big 5:**
- `COUNT()` - How many?
- `SUM()` - Total?
- `AVG()` - Average?
- `MIN()` - Smallest?
- `MAX()` - Largest?

---

## Basic Aggregation Examples

```sql
-- How many teams?
SELECT COUNT(*) as total_teams
FROM teams;

-- Total points scored by a team
SELECT SUM(pts) as total_points
FROM team_game_stats
WHERE team_id = 1610612747;

-- Average points per game
SELECT AVG(pts) as avg_points
FROM team_game_stats
WHERE team_id = 1610612744;
```

---

## Combining Aggregates

```sql
-- Complete statistics in one query
SELECT 
    COUNT(*) as total_games,
    SUM(pts) as total_points,
    AVG(pts) as avg_points,
    MIN(pts) as lowest,
    MAX(pts) as highest
FROM team_game_stats
WHERE season = '2021-22';
```

**Result:** One row with multiple summary statistics

---

## GROUP BY: The Game Changer

**Problem:** We want stats for EACH team, not all combined.

**Solution:** GROUP BY

```sql
-- Average points PER TEAM
SELECT 
    team_id,
    AVG(pts) as avg_points
FROM team_game_stats
WHERE season = '2021-22'
GROUP BY team_id
ORDER BY avg_points DESC;
```

**Result:** One row per team with their statistics

---

## GROUP BY Rules

**Critical rule:** Every non-aggregated column in SELECT must be in GROUP BY

```sql
-- ❌ WRONG - missing season in GROUP BY
SELECT team_id, season, AVG(pts)
FROM team_game_stats
GROUP BY team_id;

-- ✅ RIGHT
SELECT team_id, season, AVG(pts)
FROM team_game_stats
GROUP BY team_id, season;
```

---

## WHERE vs. HAVING

**WHERE:** Filters BEFORE grouping  
**HAVING:** Filters AFTER grouping

```sql
-- WHERE: Filter individual rows
SELECT team_id, AVG(pts)
FROM team_game_stats
WHERE pts > 100
GROUP BY team_id;

-- HAVING: Filter groups
SELECT team_id, AVG(pts)
FROM team_game_stats
GROUP BY team_id
HAVING AVG(pts) > 110;
```

---

## Query Execution Order

**Write in this order:**
```sql
SELECT columns/aggregates
FROM table
WHERE row_filter
GROUP BY columns
HAVING group_filter
ORDER BY columns
LIMIT n;
```

**SQL executes:** FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT

---

## Exporting to Excel

```python
import pandas as pd
import sqlite3

# Run query
conn = sqlite3.connect('nba_database.db')
query = "SELECT team_id, AVG(pts) FROM team_game_stats GROUP BY team_id"
result = pd.read_sql(query, conn)

# Export to Excel
result.to_excel('team_stats.xlsx', index=False)
```

**Why?** Further analysis, charts, sharing with stakeholders

---

## Today's Workflow

**SQL Tasks:**
1. Write aggregation queries
2. Export results to Excel

**Excel Tasks:**
3. Create formulas and calculations
4. Build charts and visualizations

**This is real-world data analyst workflow!**

---

## Common Patterns

```sql
-- Pattern 1: Summary stats
SELECT COUNT(*), AVG(col), MIN(col), MAX(col)
FROM table;

-- Pattern 2: Group and count
SELECT category, COUNT(*)
FROM table
GROUP BY category;

-- Pattern 3: Filter groups
SELECT category, AVG(value)
FROM table
GROUP BY category
HAVING AVG(value) > 100;
```

---

## Key Takeaways

✅ **Aggregate functions** summarize data (COUNT, SUM, AVG, MIN, MAX)  
✅ **GROUP BY** creates categories for separate aggregation  
✅ **WHERE** filters before grouping, **HAVING** filters after  
✅ **AS** creates readable column names  
✅ **SQL → Excel** workflow enables powerful analysis

---

## Questions?

Before we start the walkthrough...

### Let's look at the data dictionary
