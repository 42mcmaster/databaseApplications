# Unit 2b Walkthrough — Filtering with Logic

Read this, then open `unit2b_lastname.sql` and do today's work.

---

## Boolean Logic — Evaluating what is T or F

Every `WHERE` clause is **Boolean logic**: each row gets tested, and the answer is either true or false.

| A | B | A **AND** B | A **OR** B |
|---|---|---|---|
| T | T | T | T |
| T | F | F | T |
| F | T | F | T |
| F | F | F | F |

**NOT** flips it. `NOT (state = 'Ohio')` keeps everything except Ohio.

---

## Using NOT in a WHERE clause

```sql
SELECT full_name, state
FROM   teams
WHERE  NOT (state = 'California');
```

You can also write: 

 ```sql 
 WHERE state <> 'California'
 ```
The "<>" operator stands for NOT

It is perhaps more useful when the condition is bigger than one comparison:

```sql
WHERE NOT (state = 'California' OR state = 'Texas')
-- keeps every team that is in NEITHER state

WHERE NOT (year_founded BETWEEN 1960 AND 1980)
-- keeps every team founded OUTSIDE that range
```

SQL also lets you write `NOT BETWEEN` or `NOT IN` directly, no outer parentheses needed.  For example in a student database where you don't want to include middle school grades but do want all others: 

```sql
SELECT *
FROM students
WHERE grade NOT BETWEEN 6 AND 8;
```

---

## Parentheses Change the Answer

```sql
-- Ohio teams AND California teams founded before 1970
WHERE (state = 'Ohio' OR state = 'California')
  AND year_founded < 1970

-- Ohio teams (any year), plus old California teams
WHERE state = 'Ohio'
   OR (state = 'California' AND year_founded < 1970)
```

Same four pieces. Different results. **When in doubt, parenthesize.**

---

## Shortcuts: BETWEEN and IN

```sql
WHERE year_founded BETWEEN 1960 AND 1980   -- inclusive, both ends
WHERE state IN ('Texas', 'Florida', 'New York')
```

`BETWEEN` takes **exactly two** values. `IN` takes a list — it's shorthand for a pile of `OR`s.

---

## Pattern Matching: LIKE

```sql
WHERE nickname LIKE 'C%'        -- starts with C
WHERE full_name LIKE '%James%'  -- contains James
WHERE abbreviation LIKE 'C_E'   -- C, any one character, E
```

| Wildcard | Matches |
|---|---|
| `%` | any number of characters, including none |
| `_` | exactly one character |

⚠️ **Wildcards only work with `LIKE`.** `WHERE nickname = 'C%'` looks for a nickname that is literally the two characters `C%`.

---

## Nothing Equals NULL

`NULL` means *no value recorded*. It is not zero and not an empty string.

```sql
WHERE birth_year IS NULL       -- correct
WHERE birth_year IS NOT NULL   -- correct
WHERE birth_year = NULL        -- ❌ does not work; use IS NULL instead
```

Reminder from earlier: **`<>` is "not equal"** in standard SQL. `!=` works in some systems, but `<>` is the one to know.

---

## DISTINCT

Goes right after `SELECT`, and removes duplicate rows from your results.

```sql
SELECT DISTINCT state FROM teams;
```

---

## Today's Work

Open `unit2b_lastname.sql`. Seven queries — `teams` and `players`. You'll need `OR`, `NOT`, `BETWEEN`, `IN`, `LIKE`, and `DISTINCT`.
