# Unit 2 — Querying Data

**Database Applications Development · Medina County Career Center**

---

## How this unit works

This file is **read only** — objectives and the practice plan. You never type into it, and you never turn it in.

There are three other kinds of file you'll actually use, one set per segment:

- **`unit2a_Walkthrough.md`** (and 2b through 2g) — read this first, at the start of each segment. Explains that day's new SQL, with examples. Not turned in.
- **`unit2a_lastname.sql`** (and 2b through 2g) — where your actual work goes: your queries, your written answers, your vocabulary — all in one file per segment, using `--` comments for anything that isn't SQL. Download the blank version, rename it with your last name, and fill it in as you go. **This is what you turn in.**
- **`unit2_StudyGuide.md`** — one file, covers all seven segments. Worked examples of every SQL concept in this unit, run against the real data. Keep this open the whole time you're working, for whenever the walkthrough isn't enough.

Commit and push each `.sql` file when its segment is done — not all seven at once at the end.

**Seven segments. This is where you start writing SQL.**

Every query you write, you type yourself. There is no starter code in this unit. **The Study Guide is yours to use the entire time** — looking up syntax is not cheating, it's what professionals do. What you're learning is how to think about the question, not how to memorize `SUBSTR`.

---

## What You'll Be Able To Do

1. Retrieve specific columns and rows from a table
2. Filter with comparison operators, `AND`/`OR`/`NOT`, `BETWEEN`, `IN`, and `LIKE`
3. Handle `NULL` correctly
4. Sort and limit results
5. Build calculated columns with math, text functions, and `ROUND`
6. Summarize data with `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
7. Group results by category and filter groups with `HAVING`
8. Combine two or three tables with `INNER JOIN`
9. Keep unmatched rows with `LEFT JOIN` and find them with `IS NULL`
10. Export a result set as a report

*State competencies: 8.5.3, 8.5.4 · also 5.3.1–5.3.4*

---

## Practice Plan

| Segment | Est. | Topic | Database | Turn in |
|:-:|:-:|---|---|---|
| **2a** | ≈1 period | SELECT, FROM, WHERE, ORDER BY, LIMIT, AS | NBA | `unit2a_lastname.sql` |
| **2b** | ≈1 period | Boolean logic, NOT, LIKE, BETWEEN, IN, IS NULL, DISTINCT | NBA | `unit2b_lastname.sql` |
| **2c** | ≈1 period | Calculated columns, text functions, ROUND | NBA | `unit2c_lastname.sql` |
| **2d** | ≈1 period | COUNT, SUM, AVG, MIN, MAX | NBA | `unit2d_lastname.sql` |
| **2e** | ≈1 period | GROUP BY, HAVING, clause order | NBA | `unit2e_lastname.sql` |
| **2f** | ≈1 period | INNER JOIN, table aliases, three tables | Movies + NBA | `unit2f_lastname.sql` |
| **2g** | ≈1 period | LEFT JOIN, NULLs, exporting a report | NBA + Movies | `unit2g_lastname.sql` |

*Segments are chunks of content, not calendar days. A segment is finished when the work is finished.*

Each segment's `.sql` file has its task list at the top, "Check your work" questions near the bottom, and vocabulary at the very bottom — all as comments, right next to the queries they go with.

**Read that segment's walkthrough first.** For deeper syntax help or a different worked example, see `unit2_StudyGuide.md`.

---

## Unit 2 Self-Check

Closed file, closed reference sheet. Can you do all ten?

- [ ] Write a query with `SELECT`, `FROM`, and `WHERE` from memory
- [ ] Say the clause order out loud — all six
- [ ] Explain the difference between `AND` and `OR`
- [ ] Explain why `= NULL` never works
- [ ] Use `LIKE` with `%` to find text containing a word
- [ ] Name a calculated column with `AS`
- [ ] Explain what `COUNT(*)` returns versus `COUNT(column)`
- [ ] Explain `WHERE` versus `HAVING` in one sentence each
- [ ] Write a two-table `JOIN` with aliases and an `ON` clause
- [ ] Explain when you'd reach for `LEFT JOIN` instead of `JOIN`
