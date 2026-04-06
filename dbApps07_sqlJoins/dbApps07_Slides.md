---
marp: true
theme: default
class: invert
paginate: true
---

# SQL JOINs
## Connecting Data Across Tables

**Database Applications Development**
Software Engineering | Medina County Career Center

---

## Quick Recap

In Lesson 06, we learned **normalization** — splitting one big messy table into several clean tables.

That's great for storing data. But now there's a problem:

> "If my data is spread across multiple tables, how do I get it back together when I need it?"

**Answer:** JOINs.

---

## The Problem JOINs Solve

Imagine you have two small tables:

**Students**
```
| student_id | name    | dept_id |
|------------|---------|---------|
| 1          | Arnold  | D1      |
| 2          | Lebron  | D2      |
| 3          | Kobe    | D1      |
```

**Departments**
```
| dept_id | dept_name   |
|---------|-------------|
| D1      | Engineering |
| D2      | Art         |
```

If you ask *"Who studies Engineering?"* — neither table alone can answer it.
You need pieces from **both** tables.

---

## What a JOIN Does (Plain English)

A JOIN tells SQL:

> "Take rows from Table A, and **glue on** matching rows from Table B by looking at a column they share."

The shared column is almost always a **Foreign Key** pointing to a **Primary Key** — exactly the links we built during normalization.

---

## INNER JOIN — The Default

**INNER JOIN** = return only rows that have a match in BOTH tables.

```sql
SELECT s.name, d.dept_name
FROM students AS s
INNER JOIN departments AS d
  ON s.dept_id = d.dept_id;
```

**Result:**
```
| name   | dept_name   |
|--------|-------------|
| Arnold | Engineering |
| Lebron | Art         |
| Kobe   | Engineering |
```

Every student had a matching department, so every student shows up.

---

## Reading the JOIN Line-by-Line

```sql
SELECT s.name, d.dept_name          ← what columns to show
FROM students AS s                  ← start with students (alias: s)
INNER JOIN departments AS d         ← glue on departments (alias: d)
  ON s.dept_id = d.dept_id;         ← match rows using this link
```

The `ON` clause is the **match rule**. It says "a row in students connects to a row in departments when their dept_id values are the same."

---

## What Are Table Aliases?

```sql
FROM students AS s
INNER JOIN departments AS d ON s.dept_id = d.dept_id;
```

`s` and `d` are **short nicknames** for the tables. They save typing and make it obvious which column comes from which table.

Without aliases:
```sql
FROM students
INNER JOIN departments ON students.dept_id = departments.dept_id;
```

Still works! Just more to type. Most pros use aliases.

---

## When INNER JOIN "Drops" a Row

What if Kobe hasn't picked a department yet?

**Students**
```
| student_id | name    | dept_id |
|------------|---------|---------|
| 1          | Arnold  | D1      |
| 2          | Lebron  | D2      |
| 3          | Kobe    | NULL    |   ← no dept yet
```

With an INNER JOIN, **Kobe disappears from the result.**
There's no matching department, so he's skipped.

Sometimes that's what you want. Sometimes it isn't.

---

## LEFT JOIN — Keep Everybody

**LEFT JOIN** = keep ALL rows from the LEFT table, even if there's no match on the right. Missing right-side info becomes `NULL`.

```sql
SELECT s.name, d.dept_name
FROM students AS s
LEFT JOIN departments AS d
  ON s.dept_id = d.dept_id;
```

**Result:**
```
| name   | dept_name   |
|--------|-------------|
| Arnold | Engineering |
| Lebron | Art         |
| Kobe   | NULL        |   ← kept, even with no match
```

---

## INNER vs LEFT — The Picture

```
     INNER JOIN                    LEFT JOIN
   (only overlap)            (everything on left + overlap)

     Students  Depts           Students  Depts
       ┌─┐     ┌─┐                ┌─┐     ┌─┐
       │ │ ∩  │ │                 │ │  ⊃ │ │
       └─┘     └─┘                └─┘     └─┘
   keep matches only        keep ALL students
```

> **INNER JOIN:** "Only show me rows that match in both places."
> **LEFT JOIN:** "Show me everyone from the left side, even if they don't match."

---

## Which JOIN Do I Use?

Ask yourself: **"Do I want to keep rows that don't have a match?"**

| I want to find... | Use |
|-------------------|-----|
| Students who have a department | INNER JOIN |
| ALL students, even ones without a department | LEFT JOIN |
| Movies with ratings only | INNER JOIN |
| ALL movies, showing rating if available | LEFT JOIN |
| Customers who actually placed an order | INNER JOIN |
| ALL customers, including ones who never ordered | LEFT JOIN |

Rule of thumb: **INNER by default. Switch to LEFT when "even if no match" matters.**

---

## Now the Real Thing: JOINs in IMDb

IMDb splits movie info across several tables (just like we normalized in 06!).

- **title_basics** — tconst, primaryTitle, startYear, genres
- **title_ratings** — tconst, averageRating, numVotes

`tconst` is the shared key.

To see titles WITH their ratings, we have to JOIN them.

---

## IMDb INNER JOIN Example

```sql
SELECT tb.primaryTitle, tb.startYear, tr.averageRating
FROM title_basics AS tb
INNER JOIN title_ratings AS tr
  ON tb.tconst = tr.tconst
WHERE tb.startYear >= 2010
ORDER BY tr.averageRating DESC
LIMIT 10;
```

**What this does:** Finds the top 10 highest-rated titles from 2010 onward that have a rating in the ratings table.

*(Titles without ratings are skipped — that's INNER JOIN doing its thing.)*

---

## IMDb LEFT JOIN Example

```sql
SELECT tb.primaryTitle, tr.averageRating
FROM title_basics AS tb
LEFT JOIN title_ratings AS tr
  ON tb.tconst = tr.tconst
WHERE tb.startYear = 2024;
```

**What this does:** Lists EVERY 2024 title, showing its rating if one exists, or `NULL` if the title hasn't been rated yet.

This is how you find "movies we're missing ratings for."

---

## Joining More Than Two Tables

You can chain JOINs to pull data from 3, 4, even 5 tables.

Start with a simple mental picture: **employees → departments → buildings**

```sql
SELECT e.name, d.dept_name, b.building_name
FROM employees AS e
INNER JOIN departments AS d ON e.dept_id = d.dept_id
INNER JOIN buildings    AS b ON d.building_id = b.building_id;
```

Each JOIN adds one more table, connected by a shared key.

---

## Multi-Table JOIN in IMDb

Find directors and the movies they directed:

```sql
SELECT nb.primaryName, tb.primaryTitle, tr.averageRating
FROM title_basics AS tb
INNER JOIN title_ratings   AS tr ON tb.tconst = tr.tconst
INNER JOIN title_principals AS tp ON tb.tconst = tp.tconst
INNER JOIN name_basics      AS nb ON tp.nconst = nb.nconst
WHERE tp.category = 'director' AND tr.averageRating > 8.0
ORDER BY tr.averageRating DESC;
```

---

## Reading Multi-Table JOINs

```
title_basics  ──(tconst)──▶  title_ratings
      │
      └──(tconst)──▶  title_principals  ──(nconst)──▶  name_basics
```

Read it as a **chain**:
1. Start with titles.
2. Glue on ratings (shared key: tconst).
3. Glue on principals — the people credited (shared key: tconst).
4. Glue on names of those people (shared key: nconst).

Each JOIN adds more information to each row.

---

## JOINs + GROUP BY = Analytics

Once data is joined, you can aggregate it.

**Find the top 10 directors by average rating (at least 5 films):**

```sql
SELECT nb.primaryName,
       AVG(tr.averageRating) AS avg_rating,
       COUNT(*) AS total_films
FROM name_basics AS nb
INNER JOIN title_principals AS tp ON nb.nconst = tp.nconst
INNER JOIN title_basics     AS tb ON tp.tconst = tb.tconst
INNER JOIN title_ratings    AS tr ON tb.tconst = tr.tconst
WHERE tp.category = 'director'
GROUP BY nb.primaryName
HAVING COUNT(*) >= 5
ORDER BY avg_rating DESC
LIMIT 10;
```

JOINs bring data together. GROUP BY crunches it into insights.

---

## The Whole Recipe

1. **Figure out what tables hold the columns you want.**
2. **Find the shared key** between them (usually a FK → PK link).
3. **Start with the main table** in `FROM`.
4. **Add INNER JOIN** for each extra table — unless you need rows without matches, then use LEFT JOIN.
5. **Use aliases** to keep the query readable.
6. **Add WHERE / GROUP BY / ORDER BY** as usual.

---

## Key Takeaways

- JOINs reconnect data that normalization split apart.
- **INNER JOIN** = only matching rows. Fast default.
- **LEFT JOIN** = all rows from the left table; NULLs where no match.
- **Aliases** make queries readable.
- You can chain JOINs to pull data from 3+ tables.
- JOINs pair beautifully with GROUP BY for analytics.

---

## Syntax at a Glance

```sql
SELECT [columns]
FROM   table1 AS a
INNER JOIN table2 AS b ON a.key = b.key
LEFT  JOIN table3 AS c ON b.key = c.key
WHERE  [conditions]
GROUP BY [columns]
ORDER BY [columns];
```

**Next up:** Practice in the walkthrough, then tackle the tasks and DIY.
