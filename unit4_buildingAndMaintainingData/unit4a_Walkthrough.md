# Unit 4a Walkthrough — Create Your Tables

**Your teacher will lead `unit4a_FollowAlong.md` first. There, the class builds a small school database together in DB Browser. Then use this page as your reference while you build your client's database.**

---

## What you're doing today

In 3e you designed a database for a client. Today you build it: the tables, the keys, and the rules that keep bad data out. The tables will be **empty** at the end of today. In 4b you fill them with the client's data.

- **Same partner, same client** as 3e.
- **Use your client's starting design**, not your own 3e file: `unit4_StartingDesign_Game.md`, `unit4_StartingDesign_Music.md`, or `unit4_StartingDesign_Baseball.md` in this folder. Everyone with the same client builds the same tables, so the data loads cleanly in 4b.

**Today's four steps, and the file each one makes:**

| Step | You do | You make |
|:-:|---|---|
| 1 | Fill in your schema in Excel: one row for each column, with its type, key, and rules | `unit4a_lastname.xlsx` |
| 2 | Paste the schema into AI and get a Mermaid ER diagram | `unit4a_lastname.md` |
| 3 | Write the `CREATE TABLE` script from your schema | `unit4a_lastname.sql` |
| 4 | Run the script in DB Browser | `unit4_client_lastname.db` |

Everything below explains what goes in the schema and the script. The steps themselves are at the end.

---

## Two kinds of SQL

| Kind | Stands for | What it does | Commands |
|---|---|---|---|
| **DDL** | Data Definition Language | Builds and changes the **structure** — the tables themselves | `CREATE`, `ALTER`, `DROP` |
| **DML** | Data Manipulation Language | Works with the **rows** inside the tables | `INSERT`, `UPDATE`, `DELETE`, `SELECT` |

Today is all DDL. 4b is DML.

---

## CREATE TABLE

Here are two tables from the follow-along's school database. This isn't your client, so you can't copy it, but your script follows the same pattern.

```sql
CREATE TABLE teachers (
    teacher_id    INTEGER PRIMARY KEY,
    teacher_name  TEXT    NOT NULL,
    email         TEXT    NOT NULL UNIQUE CHECK (email LIKE '%_@_%._%'),
    room          TEXT    CHECK (length(room) = 3)
);

CREATE TABLE courses (
    course_id     INTEGER PRIMARY KEY,
    title         TEXT    NOT NULL,
    credits       REAL    NOT NULL DEFAULT 1.0 CHECK (credits BETWEEN 0.5 AND 2),
    teacher_id    INTEGER NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teachers (teacher_id)
);
```

Read it top to bottom:

- `CREATE TABLE teachers ( … );` — make a table. Columns go inside the parentheses, separated by commas. **No comma after the last line** before the `)`.
- Each column is **name, then type, then rules**: `email TEXT NOT NULL UNIQUE`.
- `FOREIGN KEY (teacher_id) REFERENCES teachers (teacher_id)` — this column must hold a `teacher_id` that exists in `teachers`. That's referential integrity from 3b, enforced.

---

## Data types

Every column gets a type. SQLite keeps it simple:

| SQLite type | Holds | Example |
|---|---|---|
| `INTEGER` | Whole numbers | `level`, `home_runs`, `character_id` |
| `REAL` | Decimals | `danceability` (0.602) |
| `TEXT` | Words, codes, dates | `team_name`, `track_id`, `'2024-03-14'` |

Other database systems (SQL Server, MySQL, Oracle) have more types, and **the exam uses their names**. Know these:

| You'll see on the exam | What it is | SQLite equivalent |
|---|---|---|
| `INT` | Whole number | `INTEGER` |
| `DECIMAL(5,2)`, `FLOAT` | Decimal number. `DECIMAL(5,2)` = 5 digits total, 2 after the decimal point | `REAL` |
| `VARCHAR(50)` | Text up to 50 characters | `TEXT` |
| `CHAR(3)` | Text of exactly 3 characters (shorter values get padded with spaces) | `TEXT` |
| `DATE`, `DATETIME` | A date, or a date and time | `TEXT` in `YYYY-MM-DD` format |
| `BOOLEAN` / `BIT` | True or false | `INTEGER` (1 or 0) |

**SQLite won't stop you.** If you write `VARCHAR(20)`, SQLite accepts it and then stores a 30-character value anyway. That's why, in SQLite, a length rule has to be a `CHECK` (see below).

---

## Naming conventions

Good names mean nobody has to guess. The rules this class follows:

- **lowercase with underscores** (called snake_case): `player_email`, not `PlayerEmail` or `Player Email`
- **No spaces and no special characters.** A space in a name means quotes around it in every query, forever.
- **Table names are plural** (`players`), **column names are singular** (`player_email`).
- **IDs end in `_id`**: `character_id`, `team_id`.
- **A foreign key uses the same name as the key it points at** when it can: `characters.player_username` → `players.player_username`.
- **Don't use SQL keywords as names.** A column named `order`, `group`, or `table` will break your queries.
- **Be consistent.** Pick a pattern and use it everywhere.

Your starting design already follows these rules. Type the names exactly as they appear there.

---

## Constraints — the rules

A **constraint** is a rule the database enforces on every row. If a row breaks the rule, the database refuses it.

| Constraint | Means | Example |
|---|---|---|
| `PRIMARY KEY` | Identifies each row. Can't repeat, can't be empty. | `team_id TEXT PRIMARY KEY` |
| Composite `PRIMARY KEY` | Two columns together identify the row. Written on its own line after the columns. | `PRIMARY KEY (player_id, team_id)` |
| `FOREIGN KEY … REFERENCES` | Value must exist in the other table. | `FOREIGN KEY (album_id) REFERENCES albums (album_id)` |
| `NOT NULL` | Must have a value. | `song_name TEXT NOT NULL` |
| `UNIQUE` | No two rows can have the same value. | `player_email TEXT NOT NULL UNIQUE` |
| `CHECK` | Value must pass a test. | `CHECK (quantity > 0)` |
| `DEFAULT` | Value to use if none is given. | `level INTEGER DEFAULT 1` |

⚠️ **Be careful with UNIQUE.** Only use it on things that really can't repeat. Remember 3e: two characters named Shadow, two albums named *Scorpion*, two players named Max Muncy. Put `UNIQUE` on a name column and the real data won't load in 4b.

---

## Data validation with CHECK

**Data validation** means stopping bad data at the door instead of cleaning it up later. Most validation is done with `CHECK`. These are the kinds the exam names:

| Kind of check | Asks | SQL |
|---|---|---|
| **Range check** | Is the number between a low and a high? | `CHECK (popularity BETWEEN 0 AND 100)` |
| **Length check** | Is the text the right length? | `CHECK (length(team_id) = 3)` |
| **Format check** | Does it look right? | `CHECK (player_email LIKE '%_@_%._%')` — something, @, something, a dot, something |
| **List check** | Is it one of the allowed values? | `CHECK (bats IN ('L', 'R', 'B'))` |

A `CHECK` can also compare two columns. Write it on its own line after the columns: `CHECK (hits <= at_bats)`.

**CHECK ideas for your client.** Use some of these, or write your own:

| Game | Music | Baseball |
|---|---|---|
| `level` between 1 and 60 | `popularity` between 0 and 100 | `bats` is L, R, or B |
| `quantity` greater than 0 | `danceability` and `energy` between 0 and 1 | `team_id` is exactly 3 characters |
| `item_rarity` is Common, Uncommon, Rare, or Epic | `track_id` is exactly 22 characters | `games` between 1 and 162 |
| `player_email` looks like an email | `duration_ms` greater than 0 | `hits` can't be more than `at_bats` |

Every rule you write has to be **true for the real data**, or 4b's import will fail. For example, if you say `level` must be under 40, the level-44 character won't load. Check the client's spreadsheet before you pick a limit.

---

## Order matters

A foreign key can only point at a table that already exists. So:

1. **Create parent tables first.** In the game: `players`, `classes`, `items`, then `characters`, then `inventory`. Your starting design lists the order.
2. **Drop child tables first.** Put this at the top of your script, in reverse order:

```sql
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS characters;
-- …and so on, ending with the parent tables
```

`DROP TABLE` deletes a table and all its data. `IF EXISTS` means "only if it's there," so the script works the first time too. With these lines at the top, you can run your whole script again after fixing a mistake, and it rebuilds everything from scratch.

---

## Comments

`--` starts a comment. SQL ignores everything after it on that line. Your script should have a comment above each table saying what one row is:

```sql
-- characters: one row = one character
CREATE TABLE characters (
```

---

## The four steps

### Step 1 — Fill in the schema in Excel

Copy `unit4a_Schema.xlsx` from this folder into your repo and rename it `unit4a_lastname.xlsx`. Open it in Excel.

- The **Example** tab shows two school tables filled in. Copy that pattern.
- On the **Schema** tab, add **one row for each column** in your client's database, using the starting design for the names.
- For each column, fill in the data type, the key, whether it's `NOT NULL` or `UNIQUE`, any `CHECK` rule, and any default.

Your schema needs:

- [ ] Every column from the starting design
- [ ] Every primary key and foreign key, including both halves of the composite key on the junction table
- [ ] At least **one `UNIQUE`** (only where it's really true) and at least **one default**
- [ ] At least **three `CHECK` rules**, including one range check and one length or format check

This sheet is a **data dictionary**: a document that describes every column in a database. Designers write one before they build.

### Step 2 — Get the ER diagram from AI

Copy `unit4a_lastname.md` from this folder into your repo. Then:

1. Copy the rows of your Schema tab and paste them into AI. Ask for a **Mermaid `erDiagram`**, with attributes written as `type name`, keys marked `PK`, `FK`, or `UK` (`UK` means unique), and each `CHECK` rule as a comment in quotes. Example of one line: `int level "CHECK 1 to 60"`.
2. **Proof it**, the same way as in 3b and 3e. Every table and column is there, the keys are marked, and the crow's foot is on the "many" side.
3. Preview it on **mermaid.live**, then paste the code and your prompt into the `.md` file.

### Step 3 — Write the CREATE TABLE script

Copy `unit4a_lastname.sql` from this folder into your repo. Write the script **from your schema**: each row of the schema becomes one line of a `CREATE TABLE`.

- `DROP TABLE IF EXISTS` for every table first, children first
- Then `CREATE TABLE` for every table, parents first
- A comment above each table: `-- players: one row = one player account`

### Step 4 — Run it in DB Browser

1. **New Database.** File → New Database. Save it in your repo as `unit4_client_lastname.db` (for example, `unit4_music_garcia.db`).
2. A window pops up asking you to define a table. Click **Cancel**. You're writing SQL instead.
3. **Turn foreign keys on.** Go to the **Edit Pragmas** tab and make sure **Foreign Keys** is checked. Click Save. If this is off, foreign key rules silently do nothing.
4. Go to the **Execute SQL** tab. Paste in your script.
5. **Run all of it**: click ▶ (Execute all), or press **Ctrl+Return** (**Cmd+Return** on a Mac).
6. **Write Changes** (Ctrl+S / Cmd+S). DB Browser doesn't save until you do this.
7. Open the **Database Structure** tab. Every table should be there. Click the arrow next to a table to see its columns.
8. **Run the script a second time.** It should work again with no errors. That proves your `DROP TABLE` lines are right.

**If you get an error,** the message usually names the problem. The common ones:

| Error says | Usual cause |
|---|---|
| `near ")": syntax error` | A comma after the last column, right before `)` |
| `near "…": syntax error` | A missing comma between two columns |
| `table … already exists` | You ran it twice without the `DROP TABLE IF EXISTS` lines at the top |
| `no such table` | A foreign key points at a table you haven't created yet. Check the order. |

If you change your mind about a rule while writing SQL, change the schema sheet too, so they match.

---

## Turn in

Commit and push all four files to your repo:

- `unit4a_lastname.xlsx` — your schema
- `unit4a_lastname.md` — ER diagram, AI prompt, and three questions
- `unit4a_lastname.sql` — your script
- `unit4_client_lastname.db` — your database (you'll keep using it in 4b)
