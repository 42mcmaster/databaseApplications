# Unit 2d Walkthrough — Counting and Summarizing

Read this, then open `unit2d_lastname.sql` and do today's work.

---

## Aggregate Functions

An **aggregate function** takes many rows and returns **one** value.

| Function | Returns |
|---|---|
| `COUNT(*)` | how many rows |
| `COUNT(column)` | how many rows where that column isn't NULL |
| `SUM(column)` | total |
| `AVG(column)` | average |
| `MIN(column)` / `MAX(column)` | smallest / largest |

---

## Teasing out information from the Data

```sql
SELECT COUNT(*) AS team_count FROM teams;
```

→ **30**. One row. One column.

```sql
SELECT MIN(year_founded) AS oldest_team,
       MAX(year_founded) AS newest_team 
FROM   teams;

```

→ **1946, 2002**. You've collapsed thirty rows of data into an informative summary.

---

## COUNT(*) vs COUNT(column)

```sql
SELECT COUNT(*)          FROM people;  -- 22844
SELECT COUNT(birth_year) FROM people;  -- 14397
```

`COUNT(*)` counts **rows**. `COUNT(column)` counts **non-NULL values** in that column.

In this example, the database/dataset has 22,844 total records, but only 14,397 persons have a recorded birth year.  The gap between them tells you how much data is missing — a genuinely useful trick.

Although, you could also directly count NULLs by using a filter (WHERE): 

```sql
SELECT COUNT(*)
FROM people
WHERE birth_year IS NULL;
```

---

## Today's Work

Open `unit2d_lastname.sql`. Six queries — `teams`, `players`, `team_game_stats`. Count teams. Count players. Find the oldest and newest franchises. Average the founding years. Total up every point scored in five seasons.