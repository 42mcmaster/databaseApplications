---
marp: true
theme: default
class: invert
paginate: true
---

# Database Applications Development

## Software Engineering | Medina County Career Center

---

## Lesson 05: Aggregations & Grouping in SQL

In **Lesson 04**, you learned to SELECT and filter individual rows.

Now we're taking the next step: **summarizing data** — using SQL to calculate totals, averages, and breakdowns by category.

This is where SQL becomes powerful for **real analysis and reporting**.

---

## New Dataset: NBA 5 Seasons

We're moving from the Titanic dataset to the **NBA database** — real basketball statistics across 5 seasons.

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

## What Are Aggregate Functions?

An **aggregate function** takes many rows and calculates **one single value** from them.

Think of it like a calculator:
- **COUNT(*)** → How many rows are there?
- **SUM()** → Add them all up
- **AVG()** → What's the average?
- **MAX()** → What's the biggest?
- **MIN()** → What's the smallest?

---

## Common Aggregate Functions

```sql
SELECT COUNT(*) FROM team_game_stats
  -- Result: 10842 (total games played)

SELECT AVG(pts) FROM player_season_stats
  -- Result: 8.2 (average points per player per season)

SELECT SUM(pts) FROM team_game_stats
  -- Result: 8934201 (total points in all games)

SELECT MAX(pts) FROM team_game_stats
  -- Result: 156 (highest-scoring game)
```

---

## Rounding Results

Real data is messy. The `ROUND()` function cleans it up:

```sql
SELECT ROUND(AVG(pts), 1) FROM player_season_stats
  -- Result: 8.2 (rounded to 1 decimal place)

SELECT ROUND(AVG(pts), 0) FROM player_season_stats
  -- Result: 8 (rounded to the nearest whole number)
```

> **Summary:** Aggregate functions collapse many rows into one calculation. Use them to answer questions like "How many?", "What's the total?", or "What's the average?"

---

## Introduction to GROUP BY

What if you don't want **one total** — you want totals **per team** or **per season**?

That's what **GROUP BY** does. It splits your data into groups and calculates an aggregate **for each group**.

**Without GROUP BY:**
```sql
SELECT COUNT(*) FROM team_game_stats
  -- Result: 10842 (one big number)
```

**With GROUP BY:**
```sql
SELECT team_id, COUNT(*) FROM team_game_stats
GROUP BY team_id
  -- Result: 30 rows (one count per team)
```

---

## GROUP BY Example: Games Per Team

```sql
SELECT team_id, COUNT(*) AS games
FROM team_game_stats
GROUP BY team_id
```

| team_id | games |
|---------|-------|
| BOS     | 362   |
| LAL     | 361   |
| MIA     | 358   |
| ...     | ...   |

The result has **one row per team** with a count for each.

---

## GROUP BY with Multiple Columns

You can group by more than one column:

```sql
SELECT team_id, season, COUNT(*) AS games
FROM team_game_stats
GROUP BY team_id, season
```

Now you get **one row per team-season combination** — breakdowns by both team AND year.

---

## Making Results Readable with Aliases (AS)

When you use aggregate functions, column names get ugly:

```sql
SELECT team_id, COUNT(*), ROUND(AVG(pts), 1)
FROM team_game_stats
GROUP BY team_id
```

Result columns are named: `team_id`, `COUNT(*)`, `ROUND(AVG(pts), 1)` — not helpful.

Use **AS** to rename them:

```sql
SELECT team_id,
       COUNT(*) AS totalGames,
       ROUND(AVG(pts), 1) AS avgPointsPerGame
FROM team_game_stats
GROUP BY team_id
```

Now the columns are clear and readable.

---

## WHERE vs HAVING: Know the Difference

Both filter data, but at different times:

| | WHERE | HAVING |
|--|-------|--------|
| **Filters** | Individual rows | Groups (after GROUP BY) |
| **Timing** | Before grouping | After grouping |
| **Can use aggregates?** | No | Yes |

---

## WHERE: Filter Rows Before Grouping

```sql
SELECT team_id, AVG(pts) AS avgPts
FROM team_game_stats
WHERE season = '2023-24'    -- Only 2023-24 games
GROUP BY team_id
```

WHERE narrows down the raw data **first**, then GROUP BY summarizes the smaller dataset.

---

## HAVING: Filter Groups After Grouping

```sql
SELECT team_id, COUNT(*) AS games, AVG(pts) AS avgPts
FROM team_game_stats
GROUP BY team_id
HAVING AVG(pts) > 110       -- Only teams that averaged > 110 points
```

HAVING works **after** grouping — it filters the summary rows, not the raw data.

> **Summary:** Use WHERE for raw data. Use HAVING for summary results.

---

## Complete Query Order

When you write a query, clauses must appear in this exact order:

```sql
SELECT column, AGG(column) AS alias
FROM table
WHERE condition              -- filter rows first
GROUP BY column              -- split into groups
HAVING AGG(column) > value   -- filter groups
ORDER BY alias DESC          -- sort results
LIMIT 10                     -- limit output
```

**Remember:** SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY → LIMIT

---

## Exporting Query Results to Excel

Running queries is great, but sometimes you need to **share results in Excel**.

```python
import pandas as pd, sqlite3

# Step 1: Connect and run your query
conn = sqlite3.connect("nba_5seasons.db")
topScorers = pd.read_sql("""
    SELECT full_name, pts, season
    FROM player_season_stats
    ORDER BY pts DESC
    LIMIT 20
""", conn)

# Step 2: Save to Excel
topScorers.to_excel("top_scorers.xlsx", index=False)
```

That's it — your SQL results are now in Excel.

---

## Multiple Sheets in One Excel File

If you have multiple queries, put them in the same workbook:

```python
with pd.ExcelWriter("nba_summary.xlsx") as writer:
    topScorers.to_excel(writer, sheet_name="Top Scorers", index=False)
    teamStats.to_excel(writer, sheet_name="Team Stats", index=False)
    playersPerTeam.to_excel(writer, sheet_name="Roster Sizes", index=False)
```

One file with three organized sheets — professional and clean.

---

## Adding Formulas in Excel

After exporting, you can add Excel formulas using Python:

```python
from openpyxl import load_workbook

wb = load_workbook("top_scorers.xlsx")
ws = wb.active

# Add a new column header
ws["C1"] = "Performance Level"

# Add a formula that checks each player's points
ws["C2"] = '=IF(B2>25, "Elite", "Good")'

# Copy the formula down
for row in range(3, ws.max_row + 1):
    ws[f"C{row}"] = f'=IF(B{row}>25, "Elite", "Good")'

wb.save("top_scorers.xlsx")
```

Now Excel does the calculation — Python handles the data, Excel handles the presentation.

---

## Key Takeaways

1. **Aggregate functions** (COUNT, AVG, SUM, MAX, MIN) calculate summaries from many rows
2. **GROUP BY** splits data into groups and calculates one summary per group
3. **Aliases (AS)** make result column names clear and readable
4. **WHERE** filters raw rows; **HAVING** filters summarized groups
5. **Clause order matters:** SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY → LIMIT
6. **Export to Excel** with pandas and add formulas with openpyxl for professional reports

---

## Next Steps

Complete the **DIY Task** — you'll write GROUP BY queries, use HAVING to filter results, and export your findings to Excel.

Then move on to **Unit 3 Quiz** to solidify these concepts.

You're building real database skills — the kind data analysts use every day!
