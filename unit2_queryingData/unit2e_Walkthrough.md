# Unit 2e Walkthrough — Grouping

Read this, then open `unit2e_lastname.sql` and do today's work.

---

## GROUP BY

`GROUP BY` summarizes **per category**.

```sql
SELECT   state, COUNT(*) AS team_count
FROM     teams
GROUP BY state;
```

Instead of one number for all 30 teams, you get one row per state.

---

## A Rule That Can Trip You Up

> **Every column in `SELECT` that isn't inside an aggregate function must appear in `GROUP BY`.**

```sql
SELECT   state, city, COUNT(*)     -- city is not aggregated
FROM     teams
GROUP BY state;                    -- ...and not grouped. Wrong.
```

⚠️ **SQLite will run that anyway** and hand you an arbitrary city. Most other databases reject it outright. **SQLite is being permissive, not correct** — follow the rule regardless of what it lets you get away with.

---

## Two Ways to Fix It — Pick Based on What You're Asking

The broken query above is ambiguous: do you want counts **per state**, or counts **per city**? The fix is different depending on the answer.

**Option A — you want one row per state.**
Then `city` doesn't belong in `SELECT` at all — there's no single correct city to show for a whole state, so drop it:

```sql
SELECT   state, COUNT(*) AS team_count
FROM     teams
GROUP BY state;
```

**Option B — you want one row per state+city combination.**
Then `city` is part of what you're grouping by, so add it to `GROUP BY` too:

```sql
SELECT   state, city, COUNT(*) AS team_count
FROM     teams
GROUP BY state, city;
```

Note this changes the result: a state with teams in 3 different cities now gives you 3 rows instead of 1. That's expected — you're grouping by a more specific category.

**The takeaway:** every column in `GROUP BY` becomes part of the "category" your rows represent. Decide what a row *should* mean first, then match your `SELECT` and `GROUP BY` to that.

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

---
