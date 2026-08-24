---
marp: true
theme: default
class: invert
paginate: true
header: 'Unit 2 · Querying Data'
---

# Unit 2
## Querying Data

Database Applications Development
Medina County Career Center

**Seven segments. This is where you start writing SQL.**

---

## The Shape of Every Query

```sql
SELECT  full_name, city
FROM    teams
WHERE   state = 'Ohio';
```

- **SELECT** — which columns you want
- **FROM** — which table they're in
- **WHERE** — which rows to keep

That's it. Every query this unit is a variation on those three lines.

---

## Four Rules You'll Break Anyway

1. **Text goes in single quotes.** `'Ohio'` — not `"Ohio"`, not `Ohio`
2. **Numbers don't.** `year_founded < 1950`
3. **End with a semicolon.** `;`
4. **Column names must match exactly.** `full_name`, not `fullname`

SQL doesn't care about UPPERCASE keywords or line breaks. It cares intensely about spelling.

---

## How This Unit Works

Each segment (2a, 2b, … 2g) has three pieces:

- **A walkthrough** (`unit2a_Walkthrough.md`, etc.) — read this first. Explains the day's new SQL, with examples.
- **Your task file** (`unit2a_lastname.sql`) — where you write your own answers and turn them in.
- **The Study Guide** (`unit2_StudyGuide.md`) — a comprehensive reference, all seven segments, for whenever you're stuck.

Today we set up the tool. Starting next segment, you're reading the walkthrough on your own and writing SQL.

---

<!-- _class: invert lead -->

# DB Browser for SQLite
## A Tour

---

## Opening a Database

Launch **DB Browser for SQLite**.

**File → Open Database** — navigate to `nba_5seasons.db` in the `datasets` folder.

Once it's open, you'll see four tabs across the top:

**Database Structure · Browse Data · Edit Pragmas · Execute SQL**

We'll visit each one.

---

## Tab 1 — Database Structure

Lists every table. Click the arrow next to a table name to expand it and see its columns, along with the type declared for each one.

**Primary key columns show a small key icon** next to the column name.

If a table needs *more than one* column to uniquely identify a row — a composite key — you'll see the key icon on more than one column in that table.

---

## Finding Foreign Keys

Still on **Database Structure**: right-click any table, and choose something like **Modify Table** or **Edit Table Definition**.

That dialog shows the table's declared **foreign keys** — which column points at which other table.

This is how you'll trace the connections between tables in Unit 1 and Unit 3.

---

## Tab 2 — Browse Data

Pick a table from the dropdown at the top, and you're looking at its actual rows — like a read-only spreadsheet view.

Good for a quick look before you write a query. You're not typing SQL here.

---

## Tab 3 — Execute SQL

**This is where you'll spend most of your time.**

A blank editor box, top to bottom. No starter code, nothing filled in. You type your query here.

**To run it:** click the **▶** (play) button above the editor, or press **Ctrl+Return**.

Your results appear in a grid below the editor.

---

## Reading an Error

Type something wrong on purpose — misspell a column name — and run it.

SQLite tells you what's wrong in **one line**, right below where your results would be. Something like:

```
no such column: playerName
```

That's the whole error. Read it, fix the spelling, run it again.

---

## Saving and Exporting Your Work

**Saving your query:** File → Save, or Ctrl+S — saves the editor's contents as a `.sql` file. You can also **open** an existing `.sql` file the same way, which is how you'll pick up a segment's starter file.

**Exporting results:** once a query has run, look for the **Save the Results** icon above the results grid. It gives you the choice of CSV, JSON, or saving the query as a view.

---

## Tab 4 — Edit Pragmas

One setting matters for later units: **Foreign Keys**. Find the checkbox and make sure it's checked — it's what makes foreign key rules actually get enforced. Not needed yet for Unit 2, but you'll come back to this tab in Unit 4.

---

## Today's Work

Open `nba_5seasons.db`. Click through all four tabs. Find a table with a composite key. Run a query on purpose, then break one on purpose, and read the error.

**Then:** open `unit2a_Walkthrough.md` and start segment 2a.

---

<!-- _class: invert lead -->

# Unit 2 — What You'll Build Toward

`SELECT` `FROM` `WHERE` `ORDER BY` `LIMIT` `AS` `DISTINCT`
`AND` `OR` `NOT` `BETWEEN` `IN` `LIKE` `IS NULL`
Calculated columns · `COUNT` `SUM` `AVG` `MIN` `MAX`
`GROUP BY` `HAVING` · `JOIN` · `LEFT JOIN`

**Next: `unit2a_Walkthrough.md` — Getting Data Out.**
