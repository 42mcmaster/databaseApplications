# Unit 2c Walkthrough — Making New Columns

Read this, then open `unit2c_lastname.sql` and do today's work.

---

## Math in the SELECT List

You can calculate columns that don't exist in the table:

```sql
SELECT full_name,
       2026 - year_founded AS years_old
FROM   teams;
```

`years_old` isn't stored anywhere. SQL computes it for each row as the results come out. **The table is unchanged.** Use `+` `-` `*` `/` normally.

Try this version with ORDER BY to make it more useful as an output:

```sql
SELECT full_name,
       2026 - year_founded AS years_old
FROM   teams
ORDER BY years_old DESC;
```

---

## Gluing Text Together

```sql
SELECT full_name,
       city || ', ' || state AS location
FROM   teams;
```

→ `Atlanta, Georgia`

`||` is the **concatenation operator** — it joins text end to end. Note the `', '` in the middle: you have to supply your own comma and space. SQL won't add one for you.

---

## Text Functions

```sql
UPPER(full_name)          -- ATLANTA HAWKS
LOWER(abbreviation)       -- atl
LENGTH(nickname)          -- 5
SUBSTR(season, 1, 4)      -- '2021' from '2021-22' **start at char 1 and take 4 chars**
REPLACE(matchup,'@','at') -- swap text
TRIM(city)                -- strip outer spaces
```

`SUBSTR(text, start, how_many)` — **start counting at 1**, not 0.

---

## Rounding

```sql
SELECT pts / gp AS ppg              -- 15.013333333333334
SELECT ROUND(pts / gp, 1) AS ppg    -- 15.0
SELECT ROUND(pts / gp) AS ppg       -- 15.0
```

`ROUND(number, decimal_places)`. Leave the second argument off and you get whole numbers.

⚠️ **Watch for division by zero** — if a player has `gp = 0`, filter them out with `WHERE gp > 0`.

---

## Today's Work

Open `unit2c_lastname.sql`. Six queries — `teams` and `player_season_stats`. You'll calculate a team's age, glue city and state together, shout a name in uppercase, compute points per game, round it, and pull the year out of a season string like `'2021-22'`.

**Name every calculated column with `AS`.** A results header that says `2026 - year_founded` helps nobody.
