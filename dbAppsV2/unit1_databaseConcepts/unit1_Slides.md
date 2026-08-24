---
marp: true
theme: default
class: invert
paginate: true
header: 'Unit 1 · Database Concepts'
---

# Unit 1
## Database Concepts

Database Applications Development
Medina County Career Center

**Three segments, about three periods. No SQL yet — first we learn what we're looking at.**

---

<!-- _class: invert lead -->

# Unit 1a
## What Is a Database?

---

## Data vs. Information

**Data** = raw facts. No meaning on its own.

```
121   104   114   1610612739   2024-11-08   W
```

**Information** = data with context and structure.

> The Cavaliers beat the Bucks 121–104 on November 8th.

Same numbers. One of them is useful.

**A database's whole job is turning the first thing into the second.**

---

## Why Not Just Use a Spreadsheet?

Put every NBA game in one giant sheet and watch it break:

- "Cleveland Cavaliers" typed **10,000 times** — one typo and a search misses games
- Two people edit it at once — somebody's work vanishes
- Everyone who opens it can see *and change* everything
- Find every Ohio team's road losses in 2023? Good luck.

Spreadsheets are for **looking at** data. Databases are for **managing** it.

---

## What a DBMS Does

A **DBMS** — Database Management System — sits between you and the stored data.

| It handles | So you don't |
|---|---|
| Storage and retrieval | Write file-reading code |
| Multiple users at once | Overwrite each other |
| Permissions | Let everyone see everything |
| Rules and validation | Store "Ohoi" as a state |
| Backup and recovery | Lose it all to a dead drive |

SQLite, MySQL, PostgreSQL, Oracle, SQL Server, MongoDB.

---

## Nine Kinds of Database

| Type | Built for |
|---|---|
| **Relational** | Tables linked by keys — the default |
| **Document (NoSQL)** | Flexible records without a fixed shape |
| **Graph** | Connections — friends, routes, followers |
| **Data warehouse** | Years of history, for analysis |
| **Artificial intelligence** | Feeding and training models |
| *Object-oriented* | Storing program objects directly |
| *Distributed* | One database, many machines |
| *Cloud* | Hosted and managed by someone else |
| *Open source* | Free source code — MySQL, PostgreSQL, SQLite |

**Today you work with the top five.** The bottom four you should recognize by name — that's enough for now.

---

## How Data Gets Structured

**The three you'll compare today:**

- **Flat file** — one table, no relationships. A CSV.
- **Hierarchical** — parent/child tree. Folders on your laptop.
- **Relational** — many tables joined by keys.

**Also on the list, for recognition:** data lake (raw, sorted out later) · object-oriented · cloud · multi-modal.

*Type and structure overlap. Most real systems can be described more than one way — that's why we only argue about one of them today.*

---

## Today's Work

**Part A** — match eight systems to one of five types.

**Part B** — two structure comparisons. What can a relational gradebook do that a flat CSV can't?

**Part C** — one system we argue about as a class. No right answer.

Then your first three vocabulary terms, and a partner check.

**Turn in:** `unit1_lastname.md`, committed through 1a.

---

<!-- _class: invert lead -->

# Unit 1b
## Anatomy of a Database

---

## The Parts

```
DATABASE
   └── TABLE ................ one subject (teams, players)
          ├── COLUMN ........ one kind of fact (city, points)
          └── ROW ........... one instance (the Cavaliers)
                 └── FIELD .. one cell — one column, one row
```

Column = **field name**. Row = **record**. Field = the cell where they cross.

Different sources use different words for the same things. Know all of them.

---

## Keys

A **key** is how you tell one row from another.

- **Primary key** — uniquely identifies a row. Never empty. One per table.
  `team_id = 1610612739` is the Cavaliers. Always.
- **Foreign key** — a column pointing at another table's primary key. This is what *links* tables.
- **Composite key** — when it takes **two or more columns together** to be unique.

*You'll see all three in the real database today.*

---

## Schema

The **schema** is the blueprint: what tables exist, what columns they hold, what type each column is, what the rules are, how tables connect.

Not the data — the *shape* of the data.

A **transaction** is a unit of work that either completely finishes or completely undoes itself. Transferring money is two steps; you never want just one of them to happen.

**Normalization** — splitting data so nothing is stored twice. That's most of Unit 3.

---

## SQL

**S**tructured **Q**uery **L**anguage. The language for talking to a relational database.

```sql
SELECT city, nickname
FROM   teams
WHERE  state = 'Ohio';
```

It reads almost like English, and that's deliberate — SQL was designed in the 1970s so non-programmers could ask questions of data.

Nearly every relational database speaks it. Details vary; the core doesn't.

**Unit 2 is where you start writing it.**

---

## In and Out

**Getting data in:** typed by a person, submitted through a form, imported in bulk from a CSV, or written automatically by another program.

**Getting data out:** a query. You describe *what you want*, not *how to find it* — the DBMS figures out the how.

You never open the file and read it yourself. You ask; the DBMS answers.

---

## Integrity and Security

**Integrity** = the data is correct and consistent.
No game assigned to a team that doesn't exist. No player born in 1823. No half-finished transfers.

**Security** = only the right people can see and change it.
A teacher can see their own students' grades. Not everyone's. Not the payroll.

They aren't the same problem. Integrity is about *accuracy*; security is about *access*. Unit 5 covers both properly.

---

## Today's Work: Field Report

Open `nba_5seasons.db` in **DB Browser for SQLite**. Do not write any SQL.

Using the **Database Structure** tab, document:

- Every table, and what one row of it represents
- Every column and its declared type
- Which columns are **primary keys** — and which tables need more than one
- Which columns **point at another table**

Then ten vocabulary terms — defined from what's on your screen.

**Turn in:** `unit1_lastname.md`, committed through 1b.

---

<!-- _class: invert lead -->

# Unit 1c
## Front, Back, and What's Next

---

## Front-End vs. Back-End

**Back-end** — the database itself. Tables, rows, keys. Users never see it.

**Front-end** — what people actually touch. Buttons, boxes, screens.

When you check your grades:
the **front-end** is the page you log into.
The **back-end** is a database holding every grade for every student in the building.

The front-end is a *window*. The data isn't in there.

---

## Forms, Filters, Reports

Three front-end tools that hide the database from the user:

- **Form** — a screen for entering or editing one record. Ordering food, registering for a class.
- **Filter** — narrows what's displayed. "Only show my classes."
- **Report** — formatted output, usually to read or print. A grade card, a receipt, a season summary.

Behind each one is a query the user never sees.

---

## AI Is a Database Problem

Every AI system is built on stored data — that's why "artificial intelligence" is on the list of database types.

A **decision tree** follows rules a human wrote:

```
Is height > 6'10"?  →  Yes: likely center
                    →  No: check speed...
```

You can read it. You can point at the exact rule that decided.

---

## Neural Networks Are Different

A **neural network** isn't given rules — it's given **examples**, and it adjusts millions of internal weights until its guesses get good.

| Decision tree | Neural network |
|---|---|
| Rules written by a human | Patterns learned from data |
| You can read why | Mostly you can't |
| Works with few examples | Needs enormous amounts |
| Predictable | Surprising — good and bad |

**Machine learning** is the umbrella: systems that improve from data rather than from new instructions.

---

## The Part That Matters

If a model learns from data, it learns **whatever is in the data** — including our mistakes.

- Hiring tools trained on past hires repeat past bias
- Face recognition trained mostly on light-skinned faces works worse on dark-skinned faces
- "The algorithm decided" is not an answer when nobody can explain the decision

Ask three questions of any AI system:
**Where did the data come from? Who does it work badly for? Who is accountable?**

---

## Who Does This For a Living

| Role | Does | Typical entry |
|---|---|---|
| **Database Administrator** | Keeps it running, secure, backed up | Associate/bachelor's + certs |
| **Data Analyst** | Answers questions with queries | Bachelor's; certs open doors |
| **Database Developer** | Designs and builds schemas | Bachelor's, or a strong portfolio |
| **Data Engineer** | Builds the pipelines that move data | Bachelor's + experience |

**In this room:** the Ohio Database Applications exam in the spring, and — optional, in May — the **Certiport IT Specialist: Databases** certification.

---

## Today's Work: Teardown + Autopsy

**Part 1 — Teardown.** Pick an app you use. Map what's front-end and what's back-end. Identify one form, one filter, one report. Name the tables that must be behind it.

**Part 2 — Autopsy.** Eight practice questions. Answer each — then write **one sentence per wrong answer explaining why it's wrong.**

Our certification study guide calls that the single most powerful study habit for this material. If you can kill the distractors, the right answer takes care of itself.

---

<!-- _class: invert lead -->

# Unit 1 Vocabulary Check

Data · Information · DBMS · Table · Row / Record · Column / Field
Primary key · Foreign key · Composite key · Schema · Transaction
Normalization · SQL · Query · Front-end · Back-end
Form · Filter · Report · Integrity · Security
Machine learning · Neural network · Decision tree

**Next: Unit 2 — you start writing SQL.**
