# Unit 2 Study Guide — Querying Data

**This is the file to keep open while you work.** It's not the slides, and it's not something you turn in — it's where you look things up. Every example below was actually run against `nba_5seasons.db` or `movies_small.db`, so what you see is real output, not made-up numbers.

The examples here are similar to your tasks, but they are **not** your tasks — copying an example and changing one word isn't the same as answering the question in front of you. Use these to see the *shape* of a query, then write your own.

---

## Segment 2a — Getting Data Out

### SELECT and FROM

Every query starts by naming which columns you want and which table they're in.

```sql
SELECT nickname, abbreviation
FROM   teams
LIMIT  5;
```
```
nickname    abbreviation
Hawks       ATL
Celtics     BOS
Cavaliers   CLE
Pelicans    NOP
Bulls       CHI
```

### WHERE

Adds a condition. Only rows where it's true come back.

```sql
SELECT full_name, city, state
FROM   teams
WHERE  state = 'Michigan';
```
```
full_name          city      state
Detroit Pistons    Detroit   Michigan
```
→ 1 row. Only one NBA team calls Michigan home.

### ORDER BY

Sorts the results. Doesn't change the table — just the order you see it in.

```sql
SELECT   full_name, year_founded
FROM     teams
ORDER BY full_name
LIMIT    5;
```
```
full_name             year_founded
Atlanta Hawks         1949
Boston Celtics        1946
Brooklyn Nets         1976
Charlotte Hornets     1988
Chicago Bulls         1966
```
That's alphabetical, because `ORDER BY full_name` with no `DESC` sorts ascending — for text, that means A to Z.

### LIMIT

Cuts the results down to however many rows you ask for.

```sql
SELECT   full_name, year_founded
FROM     teams
ORDER BY year_founded ASC
LIMIT    3;
```
```
full_name              year_founded
Boston Celtics         1946
Golden State Warriors  1946
New York Knicks        1946
```
Three teams tie for oldest — all founded in 1946.

### AS

Renames a column, in the output only. The real column name in the table never changes.

```sql
SELECT full_name, abbreviation AS short_name
FROM   teams
LIMIT  3;
```
```
full_name              short_name
Atlanta Hawks          ATL
Boston Celtics         BOS
Cleveland Cavaliers    CLE
```

---

## Segment 2b — Filtering with Logic

### AND

Both sides have to be true.

```sql
SELECT full_name, state, year_founded
FROM   teams
WHERE  state = 'California' AND year_founded < 1960;
```
```
full_name                state        year_founded
Golden State Warriors    California   1946
Los Angeles Lakers       California   1948
Sacramento Kings         California   1948
```
Every California team, and only the ones old enough to fit.

### OR

Either side can be true.

```sql
SELECT full_name, nickname
FROM   teams
WHERE  nickname = 'Lakers' OR nickname = 'Celtics';
```
```
full_name              nickname
Boston Celtics         Celtics
Los Angeles Lakers     Lakers
```

### NOT

Flips whatever's inside the parentheses.

```sql
SELECT full_name, year_founded
FROM   teams
WHERE  NOT (year_founded < 1970);
```
→ 16 rows — every team founded in 1970 or later. `NOT (year_founded < 1970)` and `year_founded >= 1970` return the same thing; `NOT` is just a different way to say it.

### BETWEEN

Inclusive on both ends — the two boundary values count.

```sql
SELECT full_name, year_founded
FROM   teams
WHERE  year_founded BETWEEN 1990 AND 2010;
```
```
full_name              year_founded
New Orleans Pelicans   2002
Toronto Raptors        1995
Memphis Grizzlies      1995
```

### IN

A shorthand for a pile of `OR`s on the same column.

```sql
SELECT full_name, state
FROM   teams
WHERE  state IN ('Ohio', 'Michigan', 'Illinois');
```
```
full_name              state
Cleveland Cavaliers    Ohio
Chicago Bulls          Illinois
Detroit Pistons        Michigan
```

### LIKE and wildcards

```sql
SELECT full_name
FROM   teams
WHERE  full_name LIKE '%New%';
```
```
full_name
New Orleans Pelicans
New York Knicks
```
`%` matches any number of characters, including none, so `%New%` finds "New" anywhere in the name.

### IS NULL

`NULL` means no value was recorded — not zero, not blank text, nothing at all. You can't compare to it with `=`; you have to ask `IS NULL`.

```sql
SELECT name, birth_year
FROM   people
WHERE  birth_year IS NULL
LIMIT  5;
```
```
name                birth_year
Tia Carrere         NULL
Denise Crosby       NULL
Corey Feldman       NULL
Crispin Glover      NULL
Mark Hamill         NULL
```
→ 8,447 rows in `movies_small.db` have no birth year on file. `WHERE birth_year = NULL` would silently return **zero** rows — not an error, just wrong.

---

## Segment 2c — Making New Columns

Every calculated column needs a name. Use `AS` — a results header that just shows the raw expression tells nobody anything.

### Arithmetic

```sql
SELECT full_name, year_founded + 100 AS anniversary_year
FROM   teams
LIMIT  3;
```
```
full_name              anniversary_year
Atlanta Hawks          2049
Boston Celtics         2046
Cleveland Cavaliers    2070
```

### Concatenation (`||`)

Glues text together. You supply any separator yourself — SQL won't add spaces or punctuation for you.

```sql
SELECT nickname || ' (' || abbreviation || ')' AS label
FROM   teams
LIMIT  3;
```
```
label
Hawks (ATL)
Celtics (BOS)
Cavaliers (CLE)
```

### UPPER / LOWER

```sql
SELECT LOWER(nickname) AS lower_nick
FROM   teams
LIMIT  3;
```
```
lower_nick
hawks
celtics
cavaliers
```

### SUBSTR

`SUBSTR(text, start, how_many)` — counting starts at **1**, not 0.

```sql
SELECT full_name, SUBSTR(full_name, 1, 7) AS snippet
FROM   teams
LIMIT  3;
```
```
full_name              snippet
Atlanta Hawks          Atlanta
Boston Celtics         Boston
Cleveland Cavaliers    Clevela
```

### ROUND, and dividing two columns

```sql
SELECT   player_id, gp, ast,
         ROUND(ast / gp, 1) AS apg
FROM     player_season_stats
WHERE    gp > 0
ORDER BY apg DESC
LIMIT    3;
```
```
player_id    gp    ast     apg
1629027      76    880.0   11.6
203999       32    351.0   11.0
1630169      69    752.0   10.9
```
Same pattern as points-per-game, just with assists instead. The `WHERE gp > 0` guards against dividing by zero — even when you've checked and this dataset happens to be clean, write the guard anyway. The next database won't be as clean.

---

## Segment 2d — Counting and Summarizing

An **aggregate function** takes many rows and hands back one value.

### COUNT with a filter

```sql
SELECT COUNT(*)
FROM   teams
WHERE  year_founded > 2000;
```
```
COUNT(*)
1
```
Only one current NBA team was founded after 2000.

### MIN and MAX together

```sql
SELECT MIN(pts) AS lowest_game, MAX(pts) AS highest_game
FROM   team_game_stats;
```
```
lowest_game    highest_game
67             176
```
Across every game in five seasons, one team scored as low as 67 points, and another scored as high as 176.

### AVG with ROUND

```sql
SELECT ROUND(AVG(reb), 1) AS avg_rebounds
FROM   team_game_stats;
```
```
avg_rebounds
43.9
```
One number, summarizing 10,842 rows.

---

## Segment 2e — Grouping

`GROUP BY` turns "one number for everything" into "one number per category."

### GROUP BY with a filter first

```sql
SELECT   team_id, COUNT(*) AS losses
FROM     team_game_stats
WHERE    wl = 'L'
GROUP BY team_id
ORDER BY losses DESC
LIMIT    5;
```
```
team_id       losses
1610612764    249
1610612766    240
1610612765    239
1610612757    231
1610612759    225
```
Team IDs instead of names — not very readable yet. That's exactly the problem `JOIN` solves, next segment.

### GROUP BY on its own

```sql
SELECT   season, COUNT(*) AS games_played
FROM     team_game_stats
GROUP BY season;
```
```
season      games_played
2021-22     2460
2022-23     2460
2023-24     2460
2024-25     2460
2025-26     1002
```
Four full seasons, and a fifth that's still in progress — that's why it has fewer rows.

### WHERE and HAVING in the same query

```sql
SELECT   state, COUNT(*) AS team_count
FROM     teams
WHERE    year_founded < 1990
GROUP BY state
HAVING   COUNT(*) > 1;
```
```
state         team_count
California    4
Florida       2
New York      2
Texas         3
```
`WHERE year_founded < 1990` throws out rows **before** grouping. `HAVING COUNT(*) > 1` throws out whole groups **after** counting. You can't put `COUNT(*) > 1` in `WHERE` — at that point in the query, the groups don't exist yet.

### The SQLite trap — worth trying once, never worth doing on purpose

```sql
SELECT state, city, COUNT(*)
FROM   teams
GROUP BY state;
```
`city` is neither aggregated nor listed in `GROUP BY`. Most databases refuse to run this. **SQLite runs it anyway** and hands back an arbitrary city for each state — not an error, just a quietly wrong answer. The rule stands regardless of what SQLite lets you get away with: every non-aggregated column in `SELECT` belongs in `GROUP BY`.

---

## Segment 2f — Joining Two Tables

A `JOIN` follows a foreign key from one table into another so you can see both sides at once.

### The basic shape

```sql
SELECT   p.full_name, s.season, s.ast
FROM     player_season_stats s
JOIN     players p ON p.player_id = s.player_id
WHERE    s.season = '2023-24'
ORDER BY s.ast DESC
LIMIT    5;
```
```
full_name              season      ast
Tyrese Haliburton      2023-24     752.0
Nikola Jokić           2023-24     708.0
Luka Dončić            2023-24     686.0
Domantas Sabonis       2023-24     673.0
James Harden           2023-24     614.0
```
`s` and `p` are table aliases — short nicknames so you don't retype the full table name every time you reference a column. `ON` says how the two tables connect: the foreign key on one side matches the primary key on the other.

### A one-to-one join

```sql
SELECT   m.title, m.release_year, r.avg_rating
FROM     movies m
JOIN     ratings r ON r.movie_id = m.movie_id
WHERE    m.release_year = 2000
ORDER BY r.avg_rating DESC
LIMIT    5;
```
```
title                       release_year    avg_rating
Gladiator                   2000            8.5
Memento                     2000            8.4
Requiem for a Dream         2000            8.3
Snatch                      2000            8.2
In the Mood for Love        2000            8.0
```
Every movie has exactly one ratings row, so this join never creates duplicates or loses rows — a clean one-to-one relationship.

**When a join returns nothing:** check the `ON` clause first. Almost always, that's where the mistake is.

---

## Segment 2g — Keeping the Unmatched Rows

### INNER JOIN drops non-matches

```sql
SELECT COUNT(*) AS matched
FROM   players p
JOIN   player_season_stats s
       ON s.player_id = p.player_id AND s.season = '2021-22';
```
```
matched
605
```
605 of the 997 players in the database have a stat row for 2021-22. `JOIN` (which means `INNER JOIN`) silently throws away everyone else.

### LEFT JOIN keeps them

```sql
SELECT COUNT(*) AS all_rows
FROM   players p
LEFT JOIN player_season_stats s
       ON s.player_id = p.player_id AND s.season = '2021-22';
```
```
all_rows
997
```
Now every player is in the results — 997, not 605. The 392 who have no 2021-22 row still show up; every column that would have come from `player_season_stats` is just `NULL` for them.

### Finding exactly the unmatched rows

```sql
SELECT p.full_name
FROM   players p
LEFT JOIN player_season_stats s
       ON s.player_id = p.player_id AND s.season = '2021-22'
WHERE  s.player_id IS NULL
LIMIT  6;
```
```
full_name
John Wall
Kawhi Leonard
Meyers Leonard
Michael Carter-Williams
Matthew Dellavedova
T.J. Warren
```
→ 392 players total. `LEFT JOIN`, then `WHERE ... IS NULL` on a column from the right-hand table, is the standard pattern for "show me what's missing." Kawhi Leonard shows up here because he was hurt for the whole 2021-22 season — he's a real player in the `players` table, he just has no row in `player_season_stats` for that specific year.

---

## Quick-reference: every symbol in this unit

| You write | It means |
|---|---|
| `=` `<>` `>` `<` `>=` `<=` | comparisons — `<>` is "not equal" |
| `AND` `OR` `NOT` | combine or flip conditions |
| `BETWEEN x AND y` | inclusive range |
| `IN (...)` | matches anything in a list |
| `LIKE` with `%` `_` | pattern matching — `%` = any characters, `_` = exactly one |
| `IS NULL` / `IS NOT NULL` | test for "no value" — never `= NULL` |
| `+` `-` `*` `/` | arithmetic on numbers |
| `\|\|` | glue text together |
| `UPPER` `LOWER` `SUBSTR` `LENGTH` `REPLACE` `TRIM` | text functions |
| `ROUND(number, places)` | round off |
| `COUNT` `SUM` `AVG` `MIN` `MAX` | aggregate functions — one value out of many rows |
| `GROUP BY` | one result row per category |
| `HAVING` | filters groups, after they're formed |
| `JOIN ... ON` | combine two tables using a matching column |
| `LEFT JOIN` | keep unmatched left-side rows too |
| `AS` | rename a column in the output |
| `DISTINCT` | remove duplicate rows |
| `ORDER BY ... DESC` | sort, high to low |
| `LIMIT` | cut off the results |

Clause order, when you use more than one: **SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY → LIMIT.**
