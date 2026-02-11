---
marp: true
theme: default
class: invert
paginate: true
---

# SQL JOINs — Connecting Tables

**Unit 4, Lesson 2: Understanding Relationships Between Data**

Database Applications Development (145085)
Medina County Career Center
Instructor: Ryan McMaster

---

## Why Do We Need JOINs?

Your data lives in **separate tables** for a reason:
- Avoid redundancy
- Maintain data integrity
- Follow normalization rules

But queries often need data **from multiple tables**.

**Example:** You want the title AND its rating. But they're in different tables!
- `title_basics` has: tconst, primaryTitle, genres, startYear
- `title_ratings` has: tconst, averageRating, numVotes

**JOINs let us reconnect the data temporarily** without restructuring our database.

---

## Sub-Lesson 07a: INNER JOIN Syntax

**INNER JOIN** = Return ONLY rows that match in BOTH tables.

```sql
SELECT tb.primaryTitle, tb.startYear, tr.averageRating, tr.numVotes
FROM title_basics AS tb
INNER JOIN title_ratings AS tr
  ON tb.tconst = tr.tconst
WHERE tb.startYear >= 2010
ORDER BY tr.averageRating DESC;
```

**The Diagram:**
```
Table A     Table B
[1,2,3] --> [2,3,4]
      [2,3]  <-- INNER JOIN result
```

**What it does:** Matches rows by the `ON` clause (`tb.tconst = tr.tconst`).
Only rows with a match appear in results.

---

## Table Aliases — Cleaner Code

**Aliases** make queries easier to read when using multiple tables:

```sql
SELECT tb.primaryTitle, tr.averageRating
FROM title_basics AS tb
INNER JOIN title_ratings AS tr ON tb.tconst = tr.tconst;
```

Common aliases for our databases:
- IMDb: `tb` (title_basics), `tr` (title_ratings), `nb` (name_basics), `tp` (title_principals)
- NBA: `t` (teams), `p` (players), `tgs` (team_game_stats), `pss` (player_season_stats)

Aliases make it clear which table each column comes from and save typing!

---

## Sub-Lesson 07b: LEFT JOIN vs INNER JOIN

**LEFT JOIN** = Keep ALL rows from the LEFT table. Add matching data from the right table. If no match, use NULL.

```sql
SELECT tb.primaryTitle, tb.startYear, tr.averageRating
FROM title_basics AS tb
LEFT JOIN title_ratings AS tr
  ON tb.tconst = tr.tconst;
```

---

**The Diagram:**
```
Table A (LEFT)    Table B
[1,2,3] --------> [2,3,4]
[1,2,3] + [NULL for 1]  <-- LEFT JOIN result
```

**Key Difference:**
- **INNER JOIN:** Only matching rows
- **LEFT JOIN:** All rows from left table; NULL where no match

---

## When to Use INNER vs LEFT?

| Scenario | Use |
|----------|-----|
| "Find movies WITH ratings" | INNER JOIN |
| "Find all movies, show rating if available" | LEFT JOIN |
| "Find directors who directed multiple films" | INNER JOIN |
| "Find all people, show movies they're known for (if any)" | LEFT JOIN |
| Only care about complete data pairs | INNER JOIN |
| Want to see what's incomplete/missing | LEFT JOIN |

**Default choice?** Start with INNER when you want matches; use LEFT when you want to keep everything from your main table.

---

## Sub-Lesson 07c: Multi-Table JOINs

Chain multiple JOINs together to connect 3+ tables:

```sql
SELECT tb.primaryTitle, tr.averageRating, nb.primaryName, tp.category
FROM title_basics AS tb
INNER JOIN title_ratings AS tr ON tb.tconst = tr.tconst
INNER JOIN title_principals AS tp ON tb.tconst = tp.tconst
INNER JOIN name_basics AS nb ON tp.nconst = nb.nconst
WHERE tp.category = 'director' AND tr.averageRating > 8.0
ORDER BY tr.averageRating DESC;
```

**Read it step-by-step:**
1. Start with `title_basics` (tb)
2. Join `title_ratings` (tr) — connect by tconst
3. Join `title_principals` (tp) — connect by tconst
4. Join `name_basics` (nb) — connect by nconst

Each JOIN adds another dimension of data!

---

## Combining JOINs with GROUP BY

**The power combo:** JOINs + GROUP BY for analytics:

```sql
SELECT nb.primaryName, AVG(tr.averageRating) AS avg_rating, COUNT(*) AS total_titles
FROM name_basics AS nb
INNER JOIN title_principals AS tp ON nb.nconst = tp.nconst
INNER JOIN title_basics AS tb ON tp.tconst = tb.tconst
INNER JOIN title_ratings AS tr ON tb.tconst = tr.tconst
WHERE tp.category = 'director'
GROUP BY nb.primaryName
HAVING COUNT(*) >= 5
ORDER BY avg_rating DESC
LIMIT 10;
```

This finds the **top 10 directors by average rating** (who directed at least 5 movies).

JOINs bring the data together. GROUP BY organizes and aggregates it.

---

## Key Takeaways & Syntax Reference

**What you learned:**
- JOINs reconnect data split across tables
- INNER JOIN: Only matches
- LEFT JOIN: Keep all from left table
- Table aliases make code cleaner
- Chain multiple JOINs for complex queries
- Combine JOINs + GROUP BY for powerful analytics

---

**Syntax at a glance:**
```sql
SELECT [columns]
FROM table1 AS alias1
INNER/LEFT JOIN table2 AS alias2 ON alias1.key = alias2.key
INNER/LEFT JOIN table3 AS alias3 ON alias2.key = alias3.key
WHERE [conditions]
GROUP BY [columns]
ORDER BY [columns];
```

**Next: Practice with dbApps07_StudyGuide & DIY tasks!**

