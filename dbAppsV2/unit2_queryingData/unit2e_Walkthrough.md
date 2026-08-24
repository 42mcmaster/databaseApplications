# Unit 2e Walkthrough — Grouping

Read this, then open `unit2e_lastname.sql` and do today's work.

---

## GROUP BY

Aggregates on their own summarize *everything*. `GROUP BY` summarizes **per category**.

```sql
SELECT   state, COUNT(*) AS team_count
FROM     teams
GROUP BY state;
```

Instead of one number for all 30 teams, you get one row per state.

---

## The Rule That Trips Everyone

> **Every column in `SELECT` that isn't inside an aggregate function must appear in `GROUP BY`.**

```sql
SELECT   state, city, COUNT(*)     -- city is not aggregated
FROM     teams
GROUP BY state;                    -- ...and not grouped. Wrong.
```

⚠️ **SQLite will run that anyway** and hand you an arbitrary city. Most other databases reject it outright. **SQLite is being permissive, not correct** — follow the rule regardless of what it lets you get away with.

---

## WHERE vs HAVING

```sql
SELECT   state, COUNT(*) AS team_count
FROM     teams
WHERE    year_founded < 1990       -- filters ROWS, before grouping
GROUP BY state
HAVING   COUNT(*) > 1;             -- filters GROUPS, after grouping
```

**`WHERE` filters rows before they're grouped. `HAVING` filters groups after.**

You cannot put an aggregate in `WHERE` — at that point the groups don't exist yet.

---

## Clause Order Is Fixed

```
SELECT     columns
FROM       table
WHERE      row filter
GROUP BY   grouping columns
HAVING     group filter
ORDER BY   sorting
LIMIT      cutoff
```

Out of order is a syntax error. Memorize the shape: **S — F — W — G — H — O**

---

## Today's Work

Open `unit2e_lastname.sql`. Six queries — `teams` and `team_game_stats`. Teams per state. Sorted. Only the states with more than one. Average points per season. Wins per team. Then only the teams with more than 200 wins.

That last pair is the `WHERE` / `HAVING` distinction in action — you need `WHERE wl = 'W'` **and** a `HAVING` on the count.
