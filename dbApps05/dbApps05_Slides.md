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
- Create Excel formulas and charts from SQL data
- Map pandas groupby to SQL GROUP BY

**Today:** Learn to ask summary questions of your data!

---

## Where We Are

**Lessons 1-2:** Python & pandas ✅  
**Lessons 3-4:** SELECT, WHERE, ORDER BY ✅  
**Today:** Aggregations - SQL's superpower! 💪  
**Next:** Database design

**Key idea:** Move from row-level to summary-level analysis.

---

## What Are Aggregate Functions?

**Aggregate = Calculate across multiple rows, return ONE result**

**Think:**
- Individual students → Class average
- Daily sales → Monthly total
- All games → Season high score

**The Big 5:**
- `COUNT()` - How many?
- `SUM()` - Total?
- `AVG()` - Average?
- `MIN()` - Smallest?
- `MAX()` - Largest?

---

## COUNT: How Many?

```sql
-- How many teams in NBA?
SELECT COUNT(*) as total_teams
FROM teams;
```

**COUNT(*) vs. COUNT(column):**
- `COUNT(*)` = all rows (including NULLs)
- `COUNT(column)` = only non-NULL values

**Use case:** "How many customers?", "How many orders?"

---

## SUM: Add Them Up

```sql
-- Total points scored by Lakers this season
SELECT SUM(pts) as total_points
FROM team_game_stats
WHERE team_id = 1610612747  -- Lakers
  AND season = '2021-22';
```

**Remember:**
- Only numeric columns
- Ignores NULLs
- Returns NULL if no rows (not 0!)

---

## AVG: Find the Average

```sql
-- Average points per game for Warriors
SELECT AVG(pts) as avg_points
FROM team_game_stats
WHERE team_id = 1610612744  -- Warriors
  AND season = '2021-22';
```

**Formula:** AVG = SUM(values) / COUNT(values)

**Pro tip:** Use ROUND() for clean decimals:
```sql
SELECT ROUND(AVG(pts), 1) as avg_points
```

---

## MIN and MAX: Find Extremes

```sql
-- Lowest and highest scores this season
SELECT 
    MIN(pts) as lowest_score,
    MAX(pts) as highest_score
FROM team_game_stats
WHERE season = '2021-22';
```

**Works on:**
- Numbers (smallest/largest value)
- Text (alphabetically first/last)
- Dates (earliest/latest)

---

## Combining Aggregates

**You can use multiple in one query!**

```sql
-- Complete game statistics summary
SELECT 
    COUNT(*) as total_games,
    SUM(pts) as total_points,
    AVG(pts) as avg_points,
    MIN(pts) as lowest,
    MAX(pts) as highest
FROM team_game_stats
WHERE season = '2021-22';
```

**Result:** One row with 5 summary statistics.

**Real-world:** Executive dashboards, KPI reports

---

## AS: Name Your Results

**AS = Alias** (gives columns readable names)

```sql
-- ❌ Ugly
SELECT COUNT(*), AVG(pts), MAX(pts)
FROM team_game_stats;

-- ✅ Clean
SELECT 
    COUNT(*) as total_games,
    AVG(pts) as average_score,
    MAX(pts) as season_high
FROM team_game_stats;
```

**Especially important for Excel exports!**

---

## GROUP BY: The Game Changer

**Problem:** We want stats for EACH team, not all teams combined.

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

**What it does:** Splits data into groups, aggregates each separately.

---

## How GROUP BY Works

**Without GROUP BY:**
```
All 2,460 games → One average
```

**With GROUP BY team_id:**
```
Lakers games → Lakers average
Warriors games → Warriors average
Celtics games → Celtics average
... (30 teams total)
```

**Result:** One row PER TEAM with their statistics.

---

## GROUP BY Rules

**Critical rule:** Every non-aggregated column in SELECT must be in GROUP BY

```sql
-- ❌ WRONG
SELECT team_id, season, AVG(pts)
FROM team_game_stats
GROUP BY team_id;  -- Missing season!

-- ✅ RIGHT
SELECT team_id, season, AVG(pts)
FROM team_game_stats
GROUP BY team_id, season;
```

**Think:** What am I categorizing by? → Those go in GROUP BY

---

## GROUP BY Multiple Columns

```sql
-- Stats for each team in each season
SELECT 
    team_id,
    season,
    COUNT(*) as games,
    AVG(pts) as avg_points
FROM team_game_stats
GROUP BY team_id, season
ORDER BY team_id, season;
```

**Creates sub-groups:**
- Lakers 2020-21
- Lakers 2021-22
- Lakers 2022-23
- Warriors 2020-21
- ...

---

## WHERE vs. HAVING

**WHERE:** Filters BEFORE grouping  
**HAVING:** Filters AFTER grouping

```sql
-- WHERE: Filter individual games
SELECT team_id, AVG(pts)
FROM team_game_stats
WHERE pts > 100  -- Only games with 100+ points
GROUP BY team_id;

-- HAVING: Filter groups
SELECT team_id, AVG(pts)
FROM team_game_stats
GROUP BY team_id
HAVING AVG(pts) > 110;  -- Only teams averaging 110+
```

---

## WHERE vs. HAVING Comparison

| Aspect | WHERE | HAVING |
|--------|-------|--------|
| **When** | Before grouping | After grouping |
| **Filters** | Individual rows | Groups |
| **Can use** | Column values | Aggregate results |
| **Example** | `WHERE pts > 100` | `HAVING AVG(pts) > 100` |

**Rule of thumb:** Use WHERE when possible (faster!)

---

## Complete Query Order

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

**SQL executes in this order:**
FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT

**Understanding execution order prevents errors!**

---

## Pandas vs. SQL Aggregations

**You know this already!** Just different syntax.

| pandas | SQL |
|--------|-----|
| `len(df)` | `COUNT(*)` |
| `df['col'].sum()` | `SUM(col)` |
| `df['col'].mean()` | `AVG(col)` |
| `df.groupby('cat').size()` | `GROUP BY cat` with `COUNT(*)` |
| `df.groupby('cat')['val'].mean()` | `GROUP BY cat` with `AVG(val)` |

**Same concepts, SQL syntax!**

---

## Exporting to Excel

**The workflow:** SQL → pandas → Excel

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

**Why?**
- Further analysis in Excel
- Charts and visualizations
- Share with stakeholders

---

## Multiple Excel Sheets

```python
# One file, multiple worksheets
with pd.ExcelWriter('nba_analysis.xlsx') as writer:
    team_stats.to_excel(writer, sheet_name='Teams', index=False)
    player_stats.to_excel(writer, sheet_name='Players', index=False)
    game_results.to_excel(writer, sheet_name='Games', index=False)
```

**Organized analysis:** One project = One Excel file with related data

---

## Today's Workflow

**Part 1: SQL Tasks**
1. Write aggregation queries
2. Export 3-4 result sets to Excel
3. Submit SQL notebook

**Part 2: Excel Tasks**
4. Open exported files
5. Create formulas (SUM, AVERAGE, IF, etc.)
6. Build visualizations (charts)
7. Submit Excel files

**This is real-world data analyst workflow!**

---

## Common Patterns

**Pattern 1: Summary stats**
```sql
SELECT COUNT(*), AVG(col), MIN(col), MAX(col)
FROM table;
```

**Pattern 2: Group and count**
```sql
SELECT category, COUNT(*)
FROM table
GROUP BY category;
```

**Pattern 3: Filter groups**
```sql
SELECT category, AVG(value)
FROM table
GROUP BY category
HAVING AVG(value) > 100;
```

---

## Common Errors

**Error 1: Missing GROUP BY**
```sql
-- ❌ WRONG
SELECT team_id, COUNT(*)
FROM team_game_stats;

-- ✅ RIGHT
SELECT team_id, COUNT(*)
FROM team_game_stats
GROUP BY team_id;
```

---

## Common Errors (continued)

**Error 2: Aggregate in WHERE**
```sql
-- ❌ WRONG
WHERE AVG(pts) > 100

-- ✅ RIGHT
HAVING AVG(pts) > 100
```

**Error 3: Non-grouped column in SELECT**
```sql
-- ❌ WRONG
SELECT team_id, season, AVG(pts)
GROUP BY team_id;

-- ✅ RIGHT
SELECT team_id, season, AVG(pts)
GROUP BY team_id, season;
```

---

## Real-World Applications

**Business:**
- Sales by region
- Revenue by product
- Customer lifetime value

**Sports:**
- Player stats
- Team performance
- Season comparisons

**Healthcare:**
- Patients by diagnosis
- Average length of stay
- Treatment outcomes

**Every industry needs aggregations!**

---

## Practice Example

```sql
-- Win-loss record by team
SELECT 
    t.full_name as team,
    COUNT(*) as games_played,
    SUM(CASE WHEN tgs.wl = 'W' THEN 1 ELSE 0 END) as wins,
    SUM(CASE WHEN tgs.wl = 'L' THEN 1 ELSE 0 END) as losses,
    AVG(tgs.pts) as avg_points
FROM teams t
JOIN team_game_stats tgs ON t.team_id = tgs.team_id
WHERE tgs.season = '2021-22'
GROUP BY t.full_name
ORDER BY wins DESC;
```

**This gets exported to Excel for further analysis!**

---

## Tips for Success

1. **Start simple** - Test aggregates without GROUP BY first
2. **Use aliases** - Makes Excel exports cleaner
3. **Verify results** - Do the numbers make sense?
4. **Test with LIMIT** - Check logic on small sample
5. **Build incrementally** - Add one clause at a time

**Debug as you go!**

---

## Key Takeaways

✅ **Aggregate functions** summarize data (COUNT, SUM, AVG, MIN, MAX)  
✅ **GROUP BY** creates categories for separate aggregation  
✅ **WHERE** filters before grouping, **HAVING** filters after  
✅ **AS** creates readable column names  
✅ **SQL → Excel** workflow enables powerful analysis  
✅ **Aggregations** are fundamental to data analysis

---

## Today's Tasks

**Track A:**
- Basic aggregations
- Simple GROUP BY queries
- Export to Excel
- Basic Excel formulas and charts

**Track B:**
- Advanced aggregations
- Complex GROUP BY with HAVING
- Multi-sheet Excel exports
- Advanced Excel analysis

**Let's dive in!**

---

## Questions?

Before we start the walkthrough:

- Aggregation concepts clear?
- GROUP BY vs. no GROUP BY?
- WHERE vs. HAVING?
- Excel export process?
- Ready to analyze NBA data?

**Let's see it in action!**
