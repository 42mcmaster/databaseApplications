# Unit 3e Walkthrough — Design a Database for a Client

**Read this first. Then open your client's brief, the client's spreadsheet, and your turn-in file.**

---

## What you're doing

A client has been keeping all their data in one big spreadsheet. It's full of repeated information and mistakes, and it's getting hard to use. They've hired you and a partner to turn it into a relational database.

You'll use everything from 3a through 3d:

- **3a** — find the repeated data and the mistakes it causes
- **3b** — pick primary keys and foreign keys, and find the one-to-many and many-to-many relationships
- **3c** — take the data through 1NF, 2NF, and 3NF in Google Sheets
- **3b again** — have AI turn your finished tables into a Mermaid ER diagram

**This is the database you will build in Unit 4.** You'll write `CREATE TABLE` statements for the tables you design here.

This assignment takes about two class periods.

---

## Work in pairs

Groups of two, or three if the numbers don't work. You turn in **one design**, and both partners commit the same turn-in file.

You will disagree about something. Write it down. The turn-in file has a box for "something we disagreed on and how we settled it," and it's part of the grade. Common ones: whether a column belongs in one table or another, whether to use a name or an ID number as the key.

How to settle it: say what each choice costs. "If the class's base health stays in the characters table, changing it means editing every Warrior row instead of one row." That's an update anomaly, and now you both know which way to go.

---

## Pick a client

| Client | What they do | Files |
|---|---|---|
| **Game studio** | An online fantasy game. Players, their characters, character classes, and the items each character carries. | `unit3e_Game_Client.md`, `datasets/unit3e_Game.xlsx`, `unit3e_Game_lastname.md` |
| **Music streaming app** | Real Spotify data from 2020: artists, albums, songs, and playlists. | `unit3e_Music_Client.md`, `datasets/unit3e_Music.xlsx`, `unit3e_Music_lastname.md` |
| **Baseball stats website** | Real 2025 MLB data: players, teams, divisions, and each player's hitting stats. | `unit3e_Baseball_Client.md`, `datasets/unit3e_Baseball.xlsx`, `unit3e_Baseball_lastname.md` |

The game data is made up. The music and baseball data are real.

Each client gives you three things:

1. **A client brief** — who they are, what data they keep, and what they want the database to do.
2. **A spreadsheet** — their data exactly as they keep it today, plus a 1NF tab. For game and music we already split it for you. For baseball you do one quick split yourself.
3. **A list of the tables you should end up with.** This is your head start. You decide which columns go in each table, what the keys are, and how the tables connect.

---

## The rule about AI

**The design is yours.** Don't use AI to decide your tables, columns, or keys, or to answer the questions.

**AI can type the Mermaid code.** Once your tables are done, you give them to AI and it writes the ER diagram code, just like in 3b. You paste the prompt you used into your turn-in. Your prompt should already contain your finished tables. That's how we know the design came first.

---

## The steps

### Step 1 — Read the brief and the client's spreadsheet

Open the `Client_Export` tab. Before you change anything, find the problems:

- Which column has more than one value in a cell? (That breaks 1NF.)
- Which facts are typed over and over? (That's redundancy, and it leads to update anomalies.)

### Step 2 — Look at the 1NF tab

For game and music, we split the list column so each cell has one value. This is the same step you did by hand in 3c. For baseball, you split the `bats_throws` column yourself; the spreadsheet's Read_Me tab shows how. Now figure out the **primary key** of the 1NF table. One column isn't enough. Which columns together make each row unique?

### Step 3 — Find the partial dependencies (2NF)

For each non-key column, ask: **does it depend on the whole key, or just part of it?** Columns that depend on only part of the key move to their own table.

### Step 4 — Find the transitive dependencies (3NF)

Look at what's left. Is any column really about **another non-key column** instead of the key? (In 3c, the rating came from the experience level, not from the character.) Those move to their own table too.

### Step 5 — Build your tables in Google Sheets

Import the xlsx into Google Sheets (File → Import → Upload) and share it with your partner. There's a tab for each table you should end up with.

For each table:

1. On the 1NF tab, select the columns that belong in that table. Hold **Ctrl** (or **Cmd** on a Mac) and click the column letters to select more than one.
2. Copy them and paste them onto the table's tab, under the header row.
3. Select the data and use **Data → Data cleanup → Remove duplicates**. Check "Data has header row."
4. Put the column names in the blue header row, and mark the keys, like `item_name (PK)` or `character_id (FK)`.

The 1NF tab has hundreds of rows, but some of your tables end up with only a handful (5 classes, 9 playlists, 6 divisions). That's normalization: each fact is stored once.

### Step 6 — Fix the client's mistakes

The client's data has a couple of mistakes in it. You'll find them in Step 5 when Remove duplicates leaves **more rows than it should**. When the same thing is spelled two different ways, Remove duplicates can't tell they're the same, so you get an extra row. Find each mistake, decide which version is right, and delete the wrong row. Write down what you found. These are the update anomalies from 3a.

### Step 7 — Paste your design into the turn-in file

You don't paste every row. For each table, list the columns, mark the keys, and give the row count. The turn-in file shows you the format.

### Step 8 — Have AI write the ER diagram

Same as 3b:

1. **Prompt it.** Paste in your tables with their columns and keys, and say how the tables relate ("one player has many characters"). Ask for a Mermaid `erDiagram` with attributes written as `type name`.
2. **Proof it.** Every table has a PK. Foreign keys are marked `FK` and sit in the "many" table. The crow's foot (`{`) is on the "many" end. The junction table connects to both of its tables. AI didn't add or remove any columns.
3. **Test it.** Preview it on **mermaid.live** or in VS Code. Fix anything that's wrong.

Paste the diagram and your prompt into the turn-in file.

---

## Check it before you commit

- Every table has a primary key
- Every many-to-many goes through a junction table
- No cell holds a list
- No fact is stored in two places
- Every foreign key points at a primary key in another one of your tables

If all five are checked, your design is in 3NF.

---

## Swap

When you're done, trade with a **different** pair. If you can, pick a pair with a different client. Run their design through the same checklist and write one specific thing you'd change. "INVENTORY has no key marked" is useful. "Looks good" is not.

---

## Now do the work

Open your client's brief first, then the spreadsheet, then the turn-in file. Both names go at the top. Commit and push when you're done.
