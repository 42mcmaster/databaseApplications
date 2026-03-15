# dbApps06: Database Design — Study Guide
## Primary Keys, Foreign Keys & Redundancy

**Database Applications Development**
**Medina County Career Center | Instructor: Ryan McMaster**

---

## Vocabulary & Key Concepts

### Core Database Terms

1. **Entity** - A person, place, thing, or event that you want to store information about in a database. In database design, entities become tables.
   - *IMDb Example:* Title (movie/show), Person (actor/director), Credit (who worked on what)

2. **Attribute** - A characteristic or property of an entity that you want to track. In a table, attributes become columns.
   - *IMDb Example:* Title attributes include primaryTitle, startYear, genres, runtimeMinutes

3. **Table** - A structured collection of data organized in rows and columns (like a spreadsheet). Each table represents one entity type.
   - *IMDb Example:* The `title_basics` table stores information about all 19,462 movies and TV series

4. **Row** (also Record) - A single instance of an entity; one complete record in a table.
   - *IMDb Example:* One row in title_basics = one movie or TV series

5. **Column** (also Field) - A named attribute that appears in every row; the vertical organization of data.
   - *IMDb Example:* The `primaryTitle` column in the title_basics table

6. **Primary Key (PK)** - A column (or set of columns) that uniquely identifies each row in a table. No two rows can have the same primary key value, and it can never be empty (NULL).
   - *IMDb Example:* `tconst` in title_basics (e.g., "tt1375666" for Inception)

7. **Foreign Key (FK)** - A column in one table that references the primary key of another table. Foreign keys create relationships between tables.
   - *IMDb Example:* `tconst` in title_principals references `tconst` in title_basics

8. **Composite Key** - A primary key made up of two or more columns combined. Used when no single column uniquely identifies a row.
   - *IMDb Example:* In title_principals, (tconst, ordering) together form a composite key — one movie can have many credits, and the ordering number distinguishes them

9. **Relationship** - A connection between tables that allows you to link data across them. Relationships are defined by primary and foreign keys.
   - *IMDb Example:* The relationship between title_basics and title_principals tables

10. **One-to-Many (1:M)** - A relationship where one row in Table A can be linked to many rows in Table B, but each row in Table B links to only one row in Table A.
    - *IMDb Example:* One title has many credits (1:M relationship between title_basics and title_principals)

11. **Many-to-Many (M:M)** - A relationship where rows in Table A can link to many rows in Table B, and vice versa. Requires a junction table.
    - *IMDb Example:* An actor can appear in many movies, and a movie can have many actors

12. **Junction Table** - A linking table that connects two tables in a many-to-many relationship. Also called a "join table" or "bridge table."
    - *IMDb Example:* `title_principals` acts as a junction table connecting title_basics and name_basics — it has foreign keys to both

### Data Quality Terms

13. **Redundancy** - Storing the same information multiple times unnecessarily in a database.
    - *Problem:* If movie title, year, and genre were stored in every credit row, "Inception" would appear 19 times (once per actor/crew member)
    - *Solution:* Store "Inception" once in title_basics, reference it with tconst

14. **Update Anomaly** - An inconsistency that occurs when updating data in a redundant database. When you update data in one place but forget to update it elsewhere.
    - *Example:* If a movie title needs correcting, but it's stored in 19 credit rows, you'd need to update all 19 — miss one and your data is inconsistent

15. **Insert Anomaly** - A problem where you cannot insert data without redundant or incomplete information.
    - *Example:* Can't add a new actor credit without also duplicating the entire movie title, year, and genre info

16. **Delete Anomaly** - A problem where deleting one piece of information unintentionally deletes related information.
    - *Example:* If you delete all credit rows for a movie, you'd lose the movie's title and rating info too if it were all in one table

17. **Data Integrity** - The accuracy, consistency, and reliability of data in a database. Good design maintains integrity; redundancy damages it.

---

## IMDb Database Structure Reference

### The Five Tables

The imdb_class_2010plus.db database contains 5 tables that demonstrate good database design:

#### 1. **title_basics** Table

| Column Name | Data Type | Key Type | Description |
|---|---|---|---|
| tconst | TEXT | PRIMARY KEY | Unique identifier for each title (e.g., "tt1375666") |
| titleType | TEXT | | "movie" or "tvSeries" |
| primaryTitle | TEXT | | The title you'd recognize (e.g., "Inception") |
| originalTitle | TEXT | | Original language title |
| isAdult | INTEGER | | 0 = no, 1 = yes |
| startYear | INTEGER | | Release year |
| endYear | INTEGER | | End year (for TV series) |
| runtimeMinutes | INTEGER | | Length in minutes |
| genres | TEXT | | Comma-separated genres (e.g., "Action,Adventure,Sci-Fi") |

**Primary Key:** tconst
**Row Count:** 19,462
**Why tconst and not primaryTitle?** Multiple movies share the same title (e.g., several films called "Home" or "Alone"). tconst is guaranteed unique.

---

#### 2. **title_ratings** Table

| Column Name | Data Type | Key Type | Description |
|---|---|---|---|
| tconst | TEXT | PRIMARY KEY / FK | References title_basics.tconst |
| averageRating | REAL | | IMDb score (1.0 to 10.0) |
| numVotes | INTEGER | | Number of people who rated it |

**Primary Key:** tconst
**Foreign Key:** tconst → title_basics.tconst
**Row Count:** 19,462

---

#### 3. **name_basics** Table

| Column Name | Data Type | Key Type | Description |
|---|---|---|---|
| nconst | TEXT | PRIMARY KEY | Unique identifier for each person (e.g., "nm0000138") |
| primaryName | TEXT | | Person's name (e.g., "Leonardo DiCaprio") |
| birthYear | INTEGER | | Year born |
| deathYear | INTEGER | | Year died (NULL if alive) |
| primaryProfession | TEXT | | What they're known for |
| knownForTitles | TEXT | | Comma-separated list of famous tconst IDs |

**Primary Key:** nconst
**Row Count:** 182,015
**Why nconst and not primaryName?** Multiple people share the same name (e.g., many "David Smith" entries). nconst is guaranteed unique.

---

#### 4. **title_principals** Table

| Column Name | Data Type | Key Type | Description |
|---|---|---|---|
| tconst | TEXT | FK | References title_basics.tconst |
| ordering | INTEGER | | Credit order (1st billed, 2nd billed, etc.) |
| nconst | TEXT | FK | References name_basics.nconst |
| category | TEXT | | Role type: "actor", "actress", "director", etc. |
| job | TEXT | | Specific job description |
| characters | TEXT | | Character name(s) played |

**Primary Key:** (tconst, ordering) — composite key
**Foreign Keys:**
- tconst → title_basics.tconst
- nconst → name_basics.nconst
**Row Count:** 364,848

This is the **junction table** that connects titles to people. It answers: "Who worked on what?"

---

#### 5. **title_crew_person** Table

| Column Name | Data Type | Key Type | Description |
|---|---|---|---|
| tconst | TEXT | FK | References title_basics.tconst |
| nconst | TEXT | FK | References name_basics.nconst |
| role | TEXT | | "director" or "writer" |

**Primary Key:** (tconst, nconst, role) — composite key
**Foreign Keys:**
- tconst → title_basics.tconst
- nconst → name_basics.nconst
**Row Count:** 116,970

---

### IMDb Database Relationships

```
title_basics (PK: tconst)
    ↓ ← One rating per title (1:1)
title_ratings (FK: tconst)

title_basics (PK: tconst)
    ↓ ← Many credits per title (1:M)
title_principals (FK: tconst, FK: nconst)
    ↑ ← Many credits per person (1:M)
name_basics (PK: nconst)

title_basics (PK: tconst)
    ↓ ← Many crew per title (1:M)
title_crew_person (FK: tconst, FK: nconst)
    ↑ ← Many crew roles per person (1:M)
name_basics (PK: nconst)
```

**Summary of all foreign key relationships:**

| FK Column | In This Table | Points To | Relationship |
|-----------|--------------|-----------|--------------|
| tconst | title_ratings | title_basics | 1 title : 1 rating |
| tconst | title_principals | title_basics | 1 title : Many credits |
| nconst | title_principals | name_basics | 1 person : Many credits |
| tconst | title_crew_person | title_basics | 1 title : Many crew |
| nconst | title_crew_person | name_basics | 1 person : Many crew roles |

---

## Redundancy: The Numbers

**Bad Design (one big table):**
If we crammed all data into one table, every credit row would duplicate the movie title, year, genre, rating, and all actor info.

- Total credits: 364,848
- Unique titles: 19,462
- **Wasted copies of title info: 345,386**

For a single movie like Inception with 19 credits, the title, year, and genre would be stored 19 times instead of once.

**Good Design (our 5 tables):**
- "Inception" is stored once in title_basics
- "Leonardo DiCaprio" is stored once in name_basics
- Credits just reference the IDs — no duplication

**The Update Test:** If a title needs correcting:
- Bad design: Update 19+ rows (one per credit)
- Good design: Update 1 row in title_basics

---

## SQL Concepts Used in This Lesson

### LIKE with Wildcards
Searches for partial text matches. The `%` wildcard means "any characters."
```sql
WHERE primaryTitle LIKE '%Avengers%'   -- contains "Avengers" anywhere
WHERE primaryTitle LIKE 'The%'         -- starts with "The"
```

### JOIN with ON
Combines rows from two tables where a column matches.
```sql
FROM title_basics b
JOIN title_ratings r ON b.tconst = r.tconst
```
This links each movie to its rating using the shared `tconst` column.

### Table Aliases
Shortcuts so you don't type the full table name every time.
```sql
FROM title_basics b       -- "b" = title_basics
JOIN title_ratings r      -- "r" = title_ratings
WHERE b.startYear = 2024  -- use the alias with a dot
```

### IS NOT NULL
Filters out rows where a value is missing (blank).
```sql
WHERE runtimeMinutes IS NOT NULL
```
You **must** use `IS NULL` or `IS NOT NULL` — you can't use `= NULL`.

### IN (value1, value2, ...)
A shortcut for multiple OR conditions.
```sql
WHERE category IN ('actor', 'actress')
-- Same as: WHERE category = 'actor' OR category = 'actress'
```

### COUNT(DISTINCT column)
Counts only unique values, ignoring duplicates.
```sql
COUNT(DISTINCT tconst)  -- counts each movie only once
```

### ROUND(value, decimals)
Rounds a number to a specified number of decimal places.
```sql
ROUND(AVG(averageRating), 2)  -- gives 5.87 instead of 5.873291...
```

### PRAGMA table_info()
SQLite-specific command that shows a table's column structure.
```sql
PRAGMA table_info(title_basics)
```
The `pk` column in the output tells you which columns are primary keys (0 = no, 1+ = yes).

---

## Sample Study Questions

1. **What is a primary key, and why do we need one?**
   - A primary key is a column that uniquely identifies each row. We need one so every record is distinct and can be referenced by other tables.

2. **Why can't we use the movie title as a primary key?**
   - Multiple movies share the same title (e.g., several films called "Home"). Titles are not unique. That's why IMDb uses `tconst` — it's guaranteed unique.

3. **How does a foreign key create relationships between tables?**
   - A foreign key in one table references the primary key of another table. For example, `tconst` in title_principals points to `tconst` in title_basics, linking each credit to its movie.

4. **What problem does redundancy cause in databases?**
   - Redundancy wastes space, makes updates difficult (you might miss some rows), and increases the risk of inconsistent data (typos in some copies but not others).

5. **In the IMDb database, why is actor information in a separate table from movie credits?**
   - "Leonardo DiCaprio" appears in 45+ movies. Storing his name, birth year, and profession in every credit row would duplicate that info 45 times. By storing it once in name_basics and referencing his nconst, we eliminate all that redundancy.

6. **What is a composite key, and when would you use one?**
   - A composite key is two or more columns combined to form the primary key. Use it when no single column uniquely identifies a row. In title_principals, (tconst, ordering) is the composite key because one movie has many credits.

7. **How does the title_principals table function as a junction table?**
   - It connects title_basics (movies) and name_basics (people) in a many-to-many relationship. One movie has many actors, and one actor appears in many movies. title_principals has foreign keys to both tables.

8. **How would you prove that a foreign key relationship is valid using SQL?**
   - Write a JOIN query connecting the two tables on the FK column. If every row matches, the FK is valid. You can also check for orphaned rows: `SELECT COUNT(*) FROM title_principals WHERE tconst NOT IN (SELECT tconst FROM title_basics)` — this should return 0.

---

## Key Takeaways

1. **Good database design is about organization and consistency.**
2. **Redundancy is the enemy** — each fact should be stored exactly once.
3. **Keys are connectors** — primary keys identify rows; foreign keys link tables.
4. **Names make bad primary keys** — use unique IDs like tconst and nconst instead.
5. **The IMDb database exemplifies good design** — 5 focused tables with clear relationships, eliminating over 345,000 duplicate entries.

---

**Next Steps:** Learn the formal rules of normalization (1NF, 2NF, 3NF) and practice drawing ER diagrams to visualize database designs!
