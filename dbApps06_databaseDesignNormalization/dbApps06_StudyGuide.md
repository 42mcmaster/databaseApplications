# dbApps06: Database Design & Normalization — Study Guide
## Primary Keys, Foreign Keys, Redundancy & Normal Forms

**Database Applications Development**
**Medina County Career Center | Instructor: Ryan McMaster**

---

## Vocabulary & Key Concepts

### Core Database Terms

1. **Entity** — A person, place, thing, or event you want to store data about. Entities become tables.

2. **Attribute** — A property of an entity. Attributes become columns in a table.

3. **Table** — A structured collection of data organized in rows and columns. Each table represents one entity.

4. **Row (Record)** — One instance of an entity; one complete record in a table.

5. **Column (Field)** — A named attribute that appears in every row.

6. **Primary Key (PK)** — A column (or set of columns) that uniquely identifies each row. PKs cannot be NULL and cannot repeat.

7. **Foreign Key (FK)** — A column that references the primary key of another table. FKs create relationships between tables.

8. **Composite Key** — A primary key made of two or more columns combined. Used when no single column is unique on its own.

9. **Relationship** — A link between tables, defined by primary and foreign keys.

10. **One-to-Many (1:M)** — One row in Table A links to many rows in Table B, but each B row links to only one A row. (Example: one customer → many orders.)

11. **Many-to-Many (M:M)** — Rows in both tables can link to many rows in the other. Requires a junction table. (Example: students ↔ classes.)

12. **Junction Table** — A linking table that connects two tables in an M:M relationship. Holds FKs to both.

### Data Quality Terms

13. **Redundancy** — Storing the same information multiple times. Wastes space and creates update problems.

14. **Update Anomaly** — Inconsistent data caused by updating one copy of a value and forgetting the others.

15. **Insert Anomaly** — Can't add new data without also duplicating other information.

16. **Delete Anomaly** — Deleting one piece of data accidentally wipes out related data.

17. **Data Integrity** — The accuracy and consistency of data in a database. Good design protects it; redundancy breaks it.

---

## Database Structure Basics

### What a Well-Designed Database Looks Like

A good database has:

- **Multiple focused tables**, each representing one entity
- **A primary key on every table** (a unique ID column works best — not a name)
- **Foreign keys** connecting related tables
- **No repeated data** — each fact is stored exactly once

### Why IDs Make Better Primary Keys Than Names

Names repeat. Two students can be named "John Smith." Two movies can share the same title. Two pizzas can be called "The Special." IDs are guaranteed unique, so they make reliable primary keys.

### How Foreign Keys Connect Tables

```
customers                         orders
---------                         ------
customer_id (PK)  ◄──────┐       order_id (PK)
name                     └─── customer_id (FK)
phone                         order_date
                              total
```

The FK `customer_id` in `orders` points to the PK `customer_id` in `customers`. This is how you answer "which customer placed this order?" without copying the customer's name and phone into every order row.

### Relationship Types at a Glance

| Type | Example | How It's Built |
|---|---|---|
| 1:1 | person ↔ passport | FK on either side |
| 1:M | customer → orders | FK on the "many" side |
| M:M | students ↔ classes | Junction table with two FKs |

---

## SQL Examples

These are the SQL patterns you need to know for this unit.

### SELECT — Pulling data from one table

```sql
SELECT primaryTitle, startYear
FROM title_basics
WHERE startYear = 2024;
```

### WHERE with AND / OR

```sql
SELECT *
FROM title_basics
WHERE titleType = 'movie'
  AND startYear >= 2020;
```

### LIKE with Wildcards

The `%` wildcard means "any characters."

```sql
WHERE primaryTitle LIKE '%Avengers%'   -- contains "Avengers"
WHERE primaryTitle LIKE 'The%'         -- starts with "The"
```

### IN — Shortcut for multiple OR conditions

```sql
WHERE category IN ('actor', 'actress')
-- same as: WHERE category = 'actor' OR category = 'actress'
```

### IS NULL / IS NOT NULL

Filter rows where a value is (or isn't) missing. You **must** use `IS NULL`, never `= NULL`.

```sql
WHERE runtimeMinutes IS NOT NULL
```

### JOIN — Combining two tables

```sql
SELECT b.primaryTitle, r.averageRating
FROM title_basics b
JOIN title_ratings r ON b.tconst = r.tconst
WHERE r.averageRating >= 8.0;
```

The `ON` clause tells SQL which columns to match. `b` and `r` are table aliases — shortcuts so you don't retype the full table name.

### JOIN Across Three Tables

```sql
SELECT b.primaryTitle, n.primaryName, p.category
FROM title_basics b
JOIN title_principals p ON b.tconst = p.tconst
JOIN name_basics n ON p.nconst = n.nconst
WHERE b.primaryTitle = 'Inception';
```

### Aggregates — COUNT, AVG, SUM, MIN, MAX

```sql
SELECT COUNT(*) FROM title_basics;
SELECT AVG(averageRating) FROM title_ratings;
SELECT MAX(startYear) FROM title_basics;
```

### COUNT(DISTINCT column)

Counts unique values only.

```sql
SELECT COUNT(DISTINCT tconst) FROM title_principals;
```

### GROUP BY

Group rows that share a value and aggregate each group.

```sql
SELECT startYear, COUNT(*) AS movie_count
FROM title_basics
WHERE titleType = 'movie'
GROUP BY startYear
ORDER BY startYear DESC;
```

### ROUND(value, decimals)

```sql
SELECT ROUND(AVG(averageRating), 2) FROM title_ratings;
```

### ORDER BY and LIMIT

```sql
SELECT primaryTitle, averageRating
FROM title_basics b
JOIN title_ratings r ON b.tconst = r.tconst
ORDER BY r.averageRating DESC
LIMIT 10;
```

### PRAGMA table_info() — Inspect a Table's Structure

SQLite-specific. Shows columns, types, and which columns are primary keys.

```sql
PRAGMA table_info(title_basics);
```

The `pk` column in the result is `0` for non-keys and `1+` for PK columns.

---

## Normalization: The Formal Rules

Splitting a messy flat table into smaller, cleaner tables is called **normalization**. It has three main steps, called **normal forms**.

### "The key, the whole key, and nothing but the key"

18. **First Normal Form (1NF) — "The key"**
    Every cell holds a single value. No lists, no comma-separated data, no multi-value columns.
    - *Violation:* A Players table with a `games_played` cell containing `"Rocket League, Valorant, Fortnite"`.
    - *Fix:* Break the list into multiple rows so each row has exactly one game.

19. **Second Normal Form (2NF) — "The whole key"**
    Must be in 1NF, AND every non-key column depends on the **entire** primary key (not just part of a composite key). This fixes **partial dependencies**.
    - *Violation:* A table keyed by (gamertag, game_name) where `player_email` depends only on `gamertag`.
    - *Fix:* Move `player_email` into its own Players table keyed by `gamertag`.

20. **Third Normal Form (3NF) — "Nothing but the key"**
    Must be in 2NF, AND every non-key column depends **only** on the primary key — not on another non-key column. This fixes **transitive dependencies**.
    - *Violation:* A Players table where `coach_name` depends on `team_name`, and `team_name` depends on `gamertag`.
    - *Fix:* Pull `team_name` and `coach_name` into a Teams table; leave `team_name` in Players as an FK.

### Dependency Terms

21. **Functional Dependency** — One column's value determines another column's value. "If I know `gamertag`, I know `player_email`."

22. **Partial Dependency** — A non-key column depends on only part of a composite PK. Fixed by 2NF.

23. **Transitive Dependency** — A non-key column depends on another non-key column, not directly on the PK. Fixed by 3NF.

### The Normalization Process (Short Version)

1. Start with a messy flat table.
2. **1NF:** Split multi-value cells.
3. **2NF:** Remove partial dependencies.
4. **3NF:** Remove transitive dependencies.
5. Connect the resulting tables with primary and foreign keys.

---

## Sample Study Questions

1. **What is a primary key and why do we need one?**
   A column that uniquely identifies each row. Without one, you can't reliably tell records apart or reference them from other tables.

2. **Why are names usually bad primary keys?**
   Names repeat. Two people (or movies, or products) can share the same name. A unique ID never does.

3. **How does a foreign key create a relationship between tables?**
   An FK in one table holds a value that matches a PK in another table, linking the two rows together.

4. **What's the difference between a 1:M and an M:M relationship?**
   1:M uses a single FK on the "many" side. M:M needs a junction table with two FKs.

5. **What problems does redundancy cause?**
   Wasted space, update anomalies (you miss some copies), insert anomalies (can't add partial data), and delete anomalies (you lose data you didn't mean to).

6. **What is a composite key and when would you use one?**
   A PK made of two or more columns. Use it when no single column is unique on its own (common in junction tables).

7. **What's the difference between a partial dependency and a transitive dependency?**
   Partial = depends on only part of a composite key (fixed by 2NF). Transitive = depends on another non-key column (fixed by 3NF).

8. **How would you check whether a foreign key is valid?**
   Write a query that looks for orphaned rows:
   ```sql
   SELECT COUNT(*) FROM orders
   WHERE customer_id NOT IN (SELECT customer_id FROM customers);
   ```
   It should return 0.

---

## Key Takeaways

1. Good database design is about organization and consistency.
2. Redundancy is the enemy — each fact should be stored exactly once.
3. Primary keys identify rows; foreign keys link tables.
4. Names make bad primary keys — use unique IDs.
5. Normalization (1NF → 2NF → 3NF) is the formal process for getting there.
