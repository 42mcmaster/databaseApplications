# Unit 2a Walkthrough — Getting Data Out

Read this, then open `unit2a_lastname.sql` and do today's work. Keep `unit2_StudyGuide.md` open too, in case you get stuck later.

---

## The Shape of Every Query

```sql
SELECT  full_name, city
FROM    teams
WHERE   state = 'Ohio';
```

- **SELECT** — which columns you want back
- **FROM** — which table they live in
- **WHERE** — which rows to keep

That's the whole shape. Everything else in this unit is a variation on those three lines.

---

## Four Rules You'll Break Anyway

1. **Text goes in single quotes.** `'Ohio'` — not `"Ohio"`, not `Ohio`
2. **Numbers don't.** `year_founded < 1950`
3. **End with a semicolon.** `;`
4. **Column names must match exactly.** `full_name`, not `fullname` or `Full_Name`

SQL doesn't care about UPPERCASE keywords or line breaks. It cares intensely about spelling.

---

## Sorting and Limiting

```sql
SELECT   full_name, year_founded
FROM     teams
ORDER BY year_founded;          -- oldest first (default)

ORDER BY year_founded DESC;     -- newest first

ORDER BY year_founded DESC
LIMIT 5;                        -- just the top 5
```

`ASC` is ascending and it's the default, so nobody types it. `DESC` is descending.

---

## Renaming a Column with AS

```sql
SELECT full_name AS team,
       year_founded AS founded
FROM   teams;
```

The column header in your results changes. **The table itself doesn't.** `AS` is cosmetic — it makes output readable, and it matters more once you start calculating things in 2c.

---

## Today's Work

Open `unit2a_lastname.sql`. Six queries against the `teams` table.

Stuck on syntax? `unit2_StudyGuide.md` has worked examples for everything on this page.
