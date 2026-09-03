# Unit 3e Walkthrough — Design Your Own

**Read this first. Then open `unit3e_lastname.md` and do the work with your partner.**

---

## What you're doing today

Everything from 3a through 3d, applied once. With a partner, you pick a scenario and design a small database for it: entities, an ER diagram, a data dictionary, and constraints.

**This is the database you will build in Unit 4.** You'll write the `CREATE TABLE` statements for exactly what you turn in today. So: small and right beats big and impressive. Four or five tables.

---

## Work in pairs

Groups of two, or three if the numbers don't work. You turn in **one design** — both partners commit the same file.

You will disagree about something. That's normal and it's part of the grade: the turn-in file has a box for "something we disagreed on and how we settled it." Leave it empty and you lose the points. Typical disagreements: whether the advisor needs their own table, whether a game needs a season, whether to store a full name or first and last.

How to settle one: say what each option costs. "If the coach is just a text column, renaming a coach means editing every team row." That's an update anomaly, and now you both know which way to go.

---

## The three scenarios

Pick one.

**School club tracker.** Clubs, students, advisors (who are teachers), and meetings. A student can join many clubs; a club has many students. Each club has one advisor. Each meeting belongs to one club and has a date and a room.

**Small library.** Books, authors, members, and checkouts. A book can have more than one author, and an author can write more than one book. A checkout is one member taking one book on one date, with a due date and (once it's back) a return date.

**Youth sports league.** Teams, players, coaches, and games. A player is on one team. A team has one coach. A game is two teams on a date with a score for each. (Watch this one — a game points at the teams table *twice*, the same as `denormalized_demo.db` in 3a.)

---

## The steps

**1. List the entities.** What are the *things*? Usually they're the nouns in the scenario. Each one becomes a table. For each, say what one row is — "one row = one student."

**2. List the attributes.** What do you need to know about each thing? Keep it to what the scenario needs. Three to six columns per table is plenty.

**3. Pick a primary key for every table.** A surrogate ID (`club_id`, `book_id`) unless there's a good reason not to. Junction tables get a composite key of their two foreign keys.

**4. Work out the relationships.** For every pair of entities that connect, say which kind — one-to-one, one-to-many, many-to-many. One-to-many: the foreign key goes in the many side. Many-to-many: add a junction table. Every scenario above has at least one many-to-many or one double-foreign-key trap.

**5. Write the ER diagram in Mermaid.** Same syntax as 3b. Every entity, every key, every relationship line with the crow's foot on the many side. Preview it on mermaid.live before you push.

**6. Write the data dictionary.** One row per column, every table. Type, key, required or not, one-line description. This is what Unit 4 will be built from, so if it's not in the dictionary it doesn't get built.

**7. Add at least three constraints** beyond the primary keys. Say the rule in English and name the constraint. "A member's email can't repeat — UNIQUE." "A due date is required — NOT NULL." "A team can't play itself — CHECK (home_team_id <> away_team_id)."

---

## Check it before you commit

Run your design through this. Every box should be checked.

- Every table has a primary key
- Every many-to-many goes through a junction table
- No cell holds a list — no "Smith, Jones" in one author column
- No fact is stored in two places — the coach's name is in `coaches`, not typed into `teams`
- Every foreign key points at a primary key that exists in your diagram

Then say which normal form your design reaches. If all five boxes are checked, it's almost certainly 3NF — say why in one sentence.

---

## Swap

When you're done, trade with a **different** pair and run their design through the same checklist. Write one thing you'd change about theirs in the box at the end of your file. Be specific: "MEETINGS has no link to CLUBS" is useful; "looks good" is not.

---

## Now do the work

Open `unit3e_lastname.md`. Both names at the top. Pick the scenario, fill in the entity table, write the Mermaid diagram, fill in the data dictionary, add your constraints, run the checklist, swap.

Commit and push. This file is the starting point for Unit 4.
