# Unit 2g Walkthrough — Keeping the Unmatched Rows

Read this, then open `unit2g_lastname.sql` and do today's work.

---

## The Problem with INNER JOIN

997 players are in the database. Only 506 played in 2025-26.

```sql
FROM players p
JOIN player_season_stats s
  ON s.player_id = p.player_id AND s.season = '2025-26';
```

→ **506 rows.** The other 491 vanished.

Sometimes that's what you want. Sometimes those 491 are the whole point.

---

## LEFT JOIN Keeps Them

```sql
FROM players p
LEFT JOIN player_season_stats s
  ON s.player_id = p.player_id AND s.season = '2025-26';
```

→ **997 rows.**

Every player from the left table survives. Players with no 2025-26 season get **NULL** in every column that came from the right table.

**INNER JOIN asks "what matches?" LEFT JOIN asks "what do I have, and what matched?"**

---

## Finding What Didn't Match

That NULL is useful. Filter on it and you get exactly the non-matches:

```sql
SELECT p.full_name
FROM   players p
LEFT JOIN player_season_stats s
  ON s.player_id = p.player_id AND s.season = '2025-26'
WHERE  s.player_id IS NULL;
```

→ **491 players** who didn't play in 2025-26.

This pattern — LEFT JOIN, then `WHERE ... IS NULL` — answers "which ones are missing?"

---

## Getting Results Out

Once a query is right, DB Browser exports it: **Execute SQL → run your query → the "Save the Results" icon above the results grid → CSV.**

That CSV opens in Excel. It's how a query becomes a **report** somebody who doesn't know SQL can actually read.

---

## Today's Work

Open `unit2g_lastname.sql`. Six queries, both databases. Run the INNER and the LEFT version of the same join and **compare the row counts** — that difference is the entire lesson. Then find the missing rows, count NULLs in the movies data, and export one result to CSV.
