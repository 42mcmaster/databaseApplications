# Lesson 05: SQL Aggregations & GROUP BY
## Analyzing Data with Summary Statistics

**Database Applications Development**  
**Software Engineering | Medina County Career Center**

---

## Learning Objectives

By the end of this lesson, you will be able to:

- Use SQL aggregate functions to calculate summary statistics (COUNT, SUM, AVG, MIN, MAX)
- Group data using GROUP BY to analyze categories
- Filter grouped data with HAVING clause
- Export query results to Excel for further analysis
- Create Excel formulas and visualizations from SQL data
- Understand when to use aggregations vs. row-level queries
- Map pandas groupby operations to SQL GROUP BY

**Ohio Standards Addressed:**
- 8.5.3 - Retrieve, filter, sort, and parse data
- 8.5.4 - Generate reports with calculated fields and functions
- 5.1.2 - Explain how algorithms and data structures are used in information processing

---

## Where We Are in the Course

**Lessons 1-2:** Python & pandas fundamentals ✅  
**Lessons 3-4:** Database basics, SELECT, WHERE, ORDER BY ✅  
**Today - Lesson 5:** Aggregations and grouping (SQL's power!)  
**Next - Lesson 6:** Database design and normalization

**Real-world application:** Every business dashboard, report, and analytics tool uses aggregations. You're learning the foundation of data analysis!

---

## What Are Aggregate Functions?

**Aggregate functions** perform calculations across multiple rows and return a single result.

**Think of it like this:**
- Individual rows = individual students
- Aggregate = class average, total enrollment, highest score

**SQL Aggregate Functions:**
| Function | What it does | Example |
|----------|--------------|---------|
| `COUNT()` | Counts rows | How many players on the Lakers? |
| `SUM()` | Adds up values | Total points scored this season? |
| `AVG()` | Calculates average | Average points per game? |
| `MIN()` | Finds minimum | Lowest score in a game? |
| `MAX()` | Finds maximum | Highest-paid player? |

**Key concept:** These work on COLUMNS, not individual cells.

---

## COUNT: Counting Rows

**Most common aggregate function** - counts how many rows match your criteria.

### COUNT(*) - Count All Rows

```sql
-- How many teams are in the NBA?
SELECT COUNT(*) as total_teams
FROM teams;
```

**Result:** Single number (e.g., 30)

**What it does:** Counts EVERY row in the table, including NULLs.

### COUNT(column) - Count Non-NULL Values

```sql
-- How many players have recorded stats?
SELECT COUNT(player_id) as total_players
FROM player_season_stats
WHERE season = '2021-22';
```

**Difference from COUNT(*):**
- `COUNT(*)` counts all rows
- `COUNT(column)` only counts rows where that column is NOT NULL

**Use case:** Finding completeness - "How many games have attendance recorded?"

---

## SUM: Adding Values

**SUM()** adds up all values in a numeric column.

```sql
-- Total points scored by Lakers in 2021-22 season
SELECT SUM(pts) as total_points
FROM team_game_stats
WHERE team_id = 1610612747  -- Lakers team_id
  AND season = '2021-22';
```

**Important notes:**
- Only works on numeric columns (INT, REAL, FLOAT)
- Ignores NULL values
- Returns NULL if no rows match (not 0!)

**Common mistake:**
```sql
-- ❌ WRONG - Can't sum text
SELECT SUM(full_name) FROM players;  -- Error!

-- ✅ RIGHT - Sum numeric data
SELECT SUM(pts) FROM team_game_stats;
```

---

## AVG: Calculating Averages

**AVG()** calculates the mean (average) value.

```sql
-- Average points per game for Warriors in 2021-22
SELECT AVG(pts) as avg_points_per_game
FROM team_game_stats
WHERE team_id = 1610612744  -- Warriors team_id
  AND season = '2021-22';
```

**Formula:** AVG = SUM(values) / COUNT(values)

**Handles NULLs automatically:**
- NULLs are excluded from both sum and count
- If all values are NULL, returns NULL

**Precision:**
- Returns REAL (decimal) number
- Use ROUND() to limit decimal places: `ROUND(AVG(pts), 2)`

---

## MIN and MAX: Finding Extremes

**MIN()** finds the smallest value.  
**MAX()** finds the largest value.

```sql
-- Lowest and highest points in a single game (2021-22 season)
SELECT 
    MIN(pts) as lowest_score,
    MAX(pts) as highest_score
FROM team_game_stats
WHERE season = '2021-22';
```

**Works on:**
- Numbers: finds smallest/largest numerically
- Text: finds first/last alphabetically
- Dates: finds earliest/latest

**Example - Text:**
```sql
-- First team alphabetically
SELECT MIN(full_name) FROM teams;
-- Result: "Atlanta Hawks"
```

---

## Combining Multiple Aggregates

You can use multiple aggregate functions in one query!

```sql
-- Complete statistical summary of 2021-22 season
SELECT 
    COUNT(*) as total_games,
    SUM(pts) as total_points,
    AVG(pts) as avg_points,
    MIN(pts) as lowest_score,
    MAX(pts) as highest_score
FROM team_game_stats
WHERE season = '2021-22';
```

**Result:** Single row with 5 columns of statistics.

**Use case:** Executive summary reports, dashboard widgets, scorecards.

---

## AS: Aliasing Results

**AS** gives your result columns readable names.

```sql
-- Without AS (ugly column names)
SELECT COUNT(*), AVG(pts), MAX(pts)
FROM team_game_stats;
-- Columns: COUNT(*), AVG(pts), MAX(pts)

-- With AS (readable column names)
SELECT 
    COUNT(*) as total_games,
    AVG(pts) as average_score,
    MAX(pts) as highest_score
FROM team_game_stats;
-- Columns: total_games, average_score, highest_score
```

**Best practice:** ALWAYS use AS with aggregate functions for clarity.

**Especially important when exporting to Excel** - your column headers will be meaningful!

---

## GROUP BY: The Game Changer

**GROUP BY** is where aggregations become powerful.

**Without GROUP BY:**
- Aggregates work on ALL matching rows
- Get ONE result

**With GROUP BY:**
- Split data into groups
- Aggregate EACH group separately
- Get one result PER GROUP

**Think of it like:**
- Calculating class average (no GROUP BY)
- vs.
- Calculating average for each grade level (GROUP BY grade)

---

## GROUP BY Syntax

```sql
SELECT 
    column_to_group_by,
    aggregate_function(column)
FROM table_name
WHERE condition  -- Optional: filter BEFORE grouping
GROUP BY column_to_group_by
ORDER BY something;  -- Optional: sort results
```

**Critical rule:** Every non-aggregated column in SELECT must be in GROUP BY.

```sql
-- ❌ WRONG
SELECT team_id, full_name, AVG(pts)
FROM teams
JOIN team_game_stats USING (team_id)
GROUP BY team_id;
-- Error: full_name not in GROUP BY

-- ✅ RIGHT
SELECT team_id, AVG(pts)
FROM team_game_stats
GROUP BY team_id;
```

---

## GROUP BY Example: Team Statistics

```sql
-- Average points per game for each team in 2021-22
SELECT 
    t.full_name as team_name,
    COUNT(*) as games_played,
    AVG(tgs.pts) as avg_points,
    MAX(tgs.pts) as best_game
FROM teams t
JOIN team_game_stats tgs ON t.team_id = tgs.team_id
WHERE tgs.season = '2021-22'
GROUP BY t.full_name
ORDER BY avg_points DESC;
```

**What this does:**
1. Join teams with their game stats
2. Filter to 2021-22 season only
3. **Group by team name** - create separate group for each team
4. Calculate stats FOR EACH TEAM
5. Sort by average points (highest first)

**Result:** One row per team with their statistics.

---

## GROUP BY Multiple Columns

You can group by multiple columns to create more specific categories.

```sql
-- Win/loss record for each team by season
SELECT 
    team_id,
    season,
    SUM(CASE WHEN wl = 'W' THEN 1 ELSE 0 END) as wins,
    SUM(CASE WHEN wl = 'L' THEN 1 ELSE 0 END) as losses
FROM team_game_stats
GROUP BY team_id, season
ORDER BY team_id, season;
```

**What this does:**
- Groups by BOTH team_id AND season
- Each unique combination gets its own row
- Example: Lakers 2021-22, Lakers 2022-23, Warriors 2021-22, etc.

**Ordering matters for readability** - ORDER BY the same columns you grouped by.

---

## WHERE vs. HAVING

**WHERE:** Filters BEFORE grouping (filters individual rows)  
**HAVING:** Filters AFTER grouping (filters groups)

```sql
-- WHERE: Filter individual games before grouping
SELECT 
    team_id,
    AVG(pts) as avg_points
FROM team_game_stats
WHERE pts > 100  -- Only include games where team scored 100+
GROUP BY team_id;

-- HAVING: Filter groups after aggregating
SELECT 
    team_id,
    AVG(pts) as avg_points
FROM team_game_stats
GROUP BY team_id
HAVING AVG(pts) > 110;  -- Only show teams averaging 110+
```

**Key difference:**
- WHERE filters rows (before grouping)
- HAVING filters groups (after aggregating)

**Can use both:**
```sql
SELECT 
    team_id,
    COUNT(*) as games_won
FROM team_game_stats
WHERE wl = 'W'  -- Only count wins
GROUP BY team_id
HAVING COUNT(*) > 40;  -- Only teams with 40+ wins
```

---

## HAVING Clause Rules

**HAVING** can use:
- ✅ Aggregate functions: `HAVING AVG(pts) > 100`
- ✅ Columns in GROUP BY: `HAVING team_id > 1000`
- ❌ Columns NOT in GROUP BY or aggregated: `HAVING game_date = '2021-10-19'`

**Best practice:** If you CAN use WHERE, use WHERE.
- WHERE is faster (filters before aggregating)
- HAVING is for when you need to filter aggregated results

```sql
-- ❌ INEFFICIENT
SELECT team_id, AVG(pts)
FROM team_game_stats
GROUP BY team_id
HAVING season = '2021-22';  -- Should be WHERE

-- ✅ EFFICIENT
SELECT team_id, AVG(pts)
FROM team_game_stats
WHERE season = '2021-22'  -- Filter first
GROUP BY team_id;
```

---

## Complete Query Order

**SQL is written in this order:**
```sql
SELECT columns/aggregates     -- 1. What to show
FROM table                    -- 2. From where
WHERE row_conditions          -- 3. Filter individual rows
GROUP BY columns              -- 4. Create groups
HAVING group_conditions       -- 5. Filter groups
ORDER BY columns              -- 6. Sort results
LIMIT n;                      -- 7. Limit output
```

**SQL EXECUTES in this order:**
1. FROM - Get the table
2. WHERE - Filter rows
3. GROUP BY - Create groups
4. HAVING - Filter groups
5. SELECT - Choose columns/calculate aggregates
6. ORDER BY - Sort
7. LIMIT - Restrict output

**Understanding execution order prevents errors!**

---

## Pandas vs. SQL Aggregations

**You've done this in pandas!** Now you're learning SQL syntax.

| Operation | pandas | SQL |
|-----------|--------|-----|
| Count all | `len(df)` | `SELECT COUNT(*) FROM table` |
| Sum column | `df['col'].sum()` | `SELECT SUM(col) FROM table` |
| Average | `df['col'].mean()` | `SELECT AVG(col) FROM table` |
| Min/Max | `df['col'].min()` | `SELECT MIN(col) FROM table` |
| Group & count | `df.groupby('col').size()` | `SELECT col, COUNT(*) FROM table GROUP BY col` |
| Group & average | `df.groupby('col')['val'].mean()` | `SELECT col, AVG(val) FROM table GROUP BY col` |
| Filter groups | `df.groupby('col').filter(lambda x: len(x) > 5)` | `SELECT col, COUNT(*) FROM table GROUP BY col HAVING COUNT(*) > 5` |

**Same concepts, different syntax!**

---

## Exporting Query Results to Excel

**Why export to Excel?**
1. Further analysis with Excel formulas
2. Create visualizations (charts/graphs)
3. Share with non-technical stakeholders
4. Formatting and presentation
5. Quick pivot tables and filtering

**The workflow:**
```
SQL Query → pandas DataFrame → Excel file
```

**Code pattern:**
```python
import pandas as pd
import sqlite3

# Run query
conn = sqlite3.connect('nba_database.db')
query = "SELECT team_id, AVG(pts) FROM team_game_stats GROUP BY team_id"
result = pd.read_sql(query, conn)

# Export to Excel
result.to_excel('team_stats.xlsx', index=False, sheet_name='Team Statistics')
```

**Excel filename best practices:**
- Descriptive: `team_performance_2021.xlsx` not `data.xlsx`
- No spaces: Use underscores `team_stats.xlsx`
- Include date if relevant: `top_scorers_2024_01_03.xlsx`

---

## Excel Export with Multiple Sheets

You can create multiple worksheets in one Excel file:

```python
# Create an Excel writer object
with pd.ExcelWriter('nba_analysis.xlsx', engine='openpyxl') as writer:
    
    # Sheet 1: Team stats
    team_stats.to_excel(writer, sheet_name='Team Stats', index=False)
    
    # Sheet 2: Player stats
    player_stats.to_excel(writer, sheet_name='Player Stats', index=False)
    
    # Sheet 3: Game results
    game_results.to_excel(writer, sheet_name='Game Results', index=False)

print("✅ Excel file created with 3 worksheets!")
```

**Use case:** One analysis project = one Excel file with multiple data tables.

---

## Excel Integration: The Complete Workflow

**Step 1: SQL Query** (calculate in database)
```sql
SELECT 
    t.full_name,
    COUNT(*) as games,
    AVG(tgs.pts) as avg_pts
FROM teams t
JOIN team_game_stats tgs ON t.team_id = tgs.team_id
GROUP BY t.full_name;
```

**Step 2: Export to Excel** (Python)
```python
result.to_excel('team_performance.xlsx', index=False)
```

**Step 3: Excel Analysis** (you or stakeholders)
- Add calculated columns (points per game × 82 games)
- Create conditional formatting (highlight top performers)
- Build charts (bar chart of average points)
- Add filters and sorting
- Create pivot tables

**Why this workflow?**
- SQL: Heavy data processing (fast, efficient)
- Excel: Presentation and interactive analysis (user-friendly)

---

## Common Aggregation Patterns

### Pattern 1: Summary Statistics
```sql
-- Get overview of entire dataset
SELECT 
    COUNT(*) as total_records,
    AVG(column) as average,
    MIN(column) as minimum,
    MAX(column) as maximum
FROM table;
```

### Pattern 2: Group and Count
```sql
-- How many items in each category?
SELECT 
    category_column,
    COUNT(*) as count
FROM table
GROUP BY category_column
ORDER BY count DESC;
```

### Pattern 3: Top N by Group
```sql
-- Best performer in each category
SELECT 
    category,
    MAX(value) as best_performance
FROM table
GROUP BY category
ORDER BY best_performance DESC
LIMIT 10;
```

### Pattern 4: Percentage Calculation
```sql
-- Win percentage by team
SELECT 
    team_id,
    SUM(CASE WHEN wl = 'W' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) as win_pct
FROM team_game_stats
GROUP BY team_id;
```

---

## Practical Examples: NBA Database

### Example 1: Team Performance Summary
```sql
-- Full season statistics for each team
SELECT 
    t.full_name as team,
    t.city,
    COUNT(tgs.game_id) as games_played,
    SUM(CASE WHEN tgs.wl = 'W' THEN 1 ELSE 0 END) as wins,
    SUM(CASE WHEN tgs.wl = 'L' THEN 1 ELSE 0 END) as losses,
    AVG(tgs.pts) as avg_points_scored,
    MAX(tgs.pts) as season_high
FROM teams t
LEFT JOIN team_game_stats tgs ON t.team_id = tgs.team_id
WHERE tgs.season = '2021-22'
GROUP BY t.team_id, t.full_name, t.city
ORDER BY wins DESC;
```

**Export this to:** `team_season_summary.xlsx`

### Example 2: High-Scoring Teams
```sql
-- Teams averaging over 110 points per game
SELECT 
    t.full_name,
    AVG(tgs.pts) as avg_points
FROM teams t
JOIN team_game_stats tgs ON t.team_id = tgs.team_id
WHERE tgs.season = '2021-22'
GROUP BY t.full_name
HAVING AVG(tgs.pts) > 110
ORDER BY avg_points DESC;
```

**Export this to:** `high_scoring_teams.xlsx`

### Example 3: Player Season Totals
```sql
-- Total points scored by each player in 2021-22
SELECT 
    p.full_name,
    t.full_name as team,
    ps.gp as games_played,
    ps.pts as total_points,
    ROUND(ps.pts / ps.gp, 1) as points_per_game
FROM players p
JOIN player_season_stats ps ON p.player_id = ps.player_id
JOIN teams t ON ps.team_id = t.team_id
WHERE ps.season = '2021-22'
  AND ps.gp > 20  -- At least 20 games played
ORDER BY total_points DESC
LIMIT 50;
```

**Export this to:** `top_scorers.xlsx`

---

## Common Errors and Solutions

### Error 1: Using aggregate without GROUP BY
```sql
-- ❌ WRONG
SELECT team_id, COUNT(*)
FROM team_game_stats;
-- Error: team_id not in GROUP BY

-- ✅ RIGHT
SELECT team_id, COUNT(*)
FROM team_game_stats
GROUP BY team_id;
```

### Error 2: Using WHERE with aggregate function
```sql
-- ❌ WRONG
SELECT team_id, AVG(pts)
FROM team_game_stats
WHERE AVG(pts) > 100  -- Can't use aggregate in WHERE
GROUP BY team_id;

-- ✅ RIGHT
SELECT team_id, AVG(pts)
FROM team_game_stats
GROUP BY team_id
HAVING AVG(pts) > 100;  -- Use HAVING for aggregates
```

### Error 3: Forgetting column in GROUP BY
```sql
-- ❌ WRONG
SELECT team_id, season, AVG(pts)
FROM team_game_stats
GROUP BY team_id;  -- Missing season!

-- ✅ RIGHT
SELECT team_id, season, AVG(pts)
FROM team_game_stats
GROUP BY team_id, season;  -- Include all non-aggregated columns
```

---

## Tips for Success

**1. Start simple, build complexity**
```sql
-- Start with basic aggregate
SELECT AVG(pts) FROM team_game_stats;

-- Add GROUP BY
SELECT team_id, AVG(pts) FROM team_game_stats GROUP BY team_id;

-- Add WHERE filter
SELECT team_id, AVG(pts) 
FROM team_game_stats 
WHERE season = '2021-22'
GROUP BY team_id;

-- Add HAVING filter
SELECT team_id, AVG(pts) 
FROM team_game_stats 
WHERE season = '2021-22'
GROUP BY team_id
HAVING AVG(pts) > 100;
```

**2. Use meaningful aliases**
- `COUNT(*) as total_games` not just `COUNT(*)`
- Helps when exporting to Excel
- Makes results self-documenting

**3. Test aggregates**
```sql
-- Verify your aggregates make sense
SELECT 
    team_id,
    COUNT(*) as game_count,  -- Should be ~82 per team
    AVG(pts) as avg_points   -- Should be 90-120 range
FROM team_game_stats
WHERE season = '2021-22'
GROUP BY team_id;
```

**4. Use LIMIT while developing**
```sql
-- Test on small sample first
SELECT team_id, AVG(pts)
FROM team_game_stats
GROUP BY team_id
LIMIT 5;  -- Check logic on 5 teams first
```

---

## Real-World Applications

**Business Intelligence:**
- Sales by region
- Revenue by product category
- Customer counts by demographic

**Sports Analytics:**
- Player performance metrics
- Team statistics and rankings
- Season-over-season comparisons

**Web Analytics:**
- Page views by day
- Unique visitors by source
- Conversion rates by channel

**Healthcare:**
- Patient counts by diagnosis
- Average length of stay by department
- Medication usage by facility

**Every industry uses aggregations for reporting and decision-making!**

---

## Today's Learning Path

**You will:**

1. **Walkthrough:** See aggregations in action with NBA data
2. **SQL Task:** Write queries with COUNT, SUM, AVG, GROUP BY, HAVING
3. **SQL Task:** Export 3-4 query results to Excel files
4. **Excel Task:** Open exported files and create formulas/charts

**Deliverables:**
- SQL task notebook (with export code)
- Excel files with your analysis and visualizations

**This mirrors real-world data analyst workflow!**

---

## Key Takeaways

✅ **Aggregate functions** summarize multiple rows into single values  
✅ **COUNT, SUM, AVG, MIN, MAX** are the core aggregate functions  
✅ **GROUP BY** splits data into categories for separate aggregation  
✅ **HAVING** filters groups (use after GROUP BY)  
✅ **WHERE** filters rows (use before GROUP BY)  
✅ **AS** creates meaningful column names  
✅ **SQL → pandas → Excel** is a powerful workflow  
✅ **Aggregations are fundamental** to data analysis and reporting

**Next lesson:** Database design and normalization - building better databases!

---

## Questions to Consider

1. When would you use COUNT(*) vs. COUNT(column)?
2. Why do we use GROUP BY with team_id instead of team name?
3. What's the difference between WHERE and HAVING?
4. When should you export to Excel vs. keep working in SQL?
5. How does AVG() handle NULL values?

**Discuss these as you work through the tasks!**

---

## Additional Resources

**SQL Tutorial Sites:**
- W3Schools SQL Aggregate Functions
- SQLite.org Documentation
- Mode Analytics SQL Tutorial

**Excel Integration:**
- pandas.to_excel() documentation
- openpyxl library guide
- Excel formula reference (Microsoft)

**Practice Datasets:**
- NBA Stats API
- Kaggle sports datasets
- Data.gov public data

**Keep learning and experimenting!**
