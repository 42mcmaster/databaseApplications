# Unit 3d Walkthrough — Types of Databases

**Watch the video, read this page, then open `unit3d_lastname.md` and answer the questions.**

---

## What you're doing today

Every database we've used in this course is **relational**: tables with rows and columns, linked by keys. But relational is not the only kind. Today you'll see the other main types, what each one is good at, and how to pick the right one for a job.

No SQL today.

---

## The video

**[7 Database Paradigms – Fireship](https://www.youtube.com/watch?v=W2Z7fbCLSTw)** (about 10 minutes)

"Paradigm" just means *type* or *style*. He talks fast and names a lot of real products. Pause and rewind as much as you need. Have `unit3d_lastname.md` open while you watch. The first question is a table you fill in during the video.

---

## The seven types in plain words

| Type | How the data is stored | Think of it like | Good for |
|---|---|---|---|
| **Key-value** | One key points to one value. Kept in memory. | A dictionary: look up a word, get its meaning | Very fast lookups: logins, caching, game leaderboards |
| **Wide-column** | Like key-value, but each key holds a whole row of columns. No fixed layout. | A giant spreadsheet spread across many computers | Huge amounts of incoming data, like readings from sensors over time |
| **Document** | Each record is a self-contained document (like JSON). Records can have different fields. | A folder of forms where every form can be different | Records that don't all look the same: products, game saves, blog posts |
| **Relational** | Tables with rows and columns, linked by primary and foreign keys | Our NBA database: `teams` and `games` linked by `team_id` | Data that must always match up: grades, banking, orders |
| **Graph** | Nodes (things) connected by edges (relationships) | A map of who is friends with whom | When the connections are the point: friend suggestions, fraud detection |
| **Full-text search** | An index of every word, like the index at the back of a book | Google search on your own data | Search boxes that find text fast, even with typos |
| **Multi-model** | Several types in one database | A toolbox with more than one tool | Apps that need more than one type |

---

## How to pick one

When a client describes what they need, listen for these clues:

| If the client says… | Pick |
|---|---|
| "Everything has to match up. Nothing can be out of sync." | Relational |
| "Every item has different information." | Document |
| "We care about who is connected to whom." | Graph |
| "We look up one thing by its ID, millions of times a second." | Key-value |
| "People need to search through lots of text." | Full-text search |
| "We collect a nonstop flood of data, like sensor readings." | Wide-column |

Most real apps start with **relational**. It's the most common type, and it's what this course teaches. The others are for special jobs.

---

## Why our NBA database is relational

In 3a you saw two ways to store the same games:

- `games_flat` repeated each team's name and city in every game row. That caused typos and anomalies.
- `teams` + `games` stored each team **once** and linked games to teams with `team_id`.

Linking tables with keys so every fact is stored once is exactly what relational databases are built for.

---

## Now do the work

Open `unit3d_lastname.md`, rename it with your last name, and answer the questions.
