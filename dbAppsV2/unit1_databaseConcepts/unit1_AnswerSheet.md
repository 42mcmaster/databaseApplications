# Unit 1 Answer Sheet

**Before you start:** rename this file to `unit1_lastname.md`, using your own last name. Commit and push after each segment.

**Name:**

---

# Unit 1a

## Part A — Match the type

Eight systems. Match each to the type that fits it best.

**Choose from:** Relational · Document (NoSQL) · Graph · Data warehouse · Artificial intelligence

> There are nine types on the slide. You only need these five today — the other four you should be able to *recognize*, not classify with.

| # | System | Type |
|:-:|---|---|
| 1 | The school gradebook — students, courses and grades in linked tables | |
| 2 | Instagram's record of who follows whom | |
| 3 | Walmart's last ten years of sales, kept for analysis | |
| 4 | The data used to train ChatGPT | |
| 5 | Google Maps finding a route through intersections | |
| 6 | A hospital's patient records | |
| 7 | An online store where every product has completely different attributes | |
| 8 | Your phone's Contacts app | |

## Part B — Compare two structures

**B1.** A CSV file of football stats is a **flat file**. The school gradebook is **relational**.

What can the gradebook do that the CSV can't?

**Answer:**


**B2.** The folders on your laptop are **hierarchical**. The gradebook is **relational**.

How is finding a file in folders different from finding one student's grade in the gradebook?

**Answer:**


## Part C — The one we argue about

**Netflix's recommendation system.** Is it a graph database, a data warehouse, or an AI database?

This one has no single right answer — we're discussing it as a class. Write down where you landed and one reason.

**Where I landed:**


**Why:**


## Closing 1a — Vocabulary

Three terms. Your words, not the slide's.

| Term | Your definition |
|---|---|
| Data | |
| Information | |
| DBMS | |

**Partner check:** trade files. Can your partner tell data from information using only what you wrote?

---

# Unit 1b — Field Report

Open **`nba_5seasons.db`** in **DB Browser for SQLite**. Click the **Database Structure** tab and expand each table.

> **Write no SQL today.** You're reading the blueprints, not moving in.

## 1. Inventory

| Table name | How many columns? | What is one row of this table? |
|---|:-:|---|
| | | |
| | | |
| | | |
| | | |

## 2. Column detail

Pick the **two tables with the most columns**. List every column and its declared type.

**Table:**

| Column | Declared type |
|---|---|
| | |
| | |
| | |
| | |
| | |

**Table:**

| Column | Declared type |
|---|---|
| | |
| | |
| | |
| | |
| | |

## 3. Keys

In DB Browser, primary-key columns show a small **key icon**.

| Table | Primary key column(s) | One column, or several? |
|---|---|:-:|
| | | |
| | | |
| | | |
| | | |

**Two of these tables need more than one column to identify a row.** Which two, and why isn't one column enough?

**Answer:**


## 4. Connections

Some columns appear in more than one table. Those are the links.

Fill in one row per link you find.

| This column | is the primary key of | and also appears in | so it links them |
|---|---|---|:-:|
| | | | |
| | | | |
| | | | |

**Which tables does nothing point at?**

**Answer:**


## 5. Two questions to think about

**a.** One table has only two columns. Why would anyone bother making that its own table instead of just putting the name everywhere it's needed?

**Answer:**


**b.** Some number columns are declared `INTEGER` and others `REAL`. Find one of each and explain why the designer chose differently.

**Answer:**


## Closing 1b — Vocabulary

**Most of these are on your screen right now.** Define them from what you're actually looking at, not from memory.

| Term | Your definition |
|---|---|
| Table | |
| Row (record) | |
| Column (field) | |
| Field | |
| Primary key | |
| Foreign key | |
| Composite key | |
| Schema | |
| SQL | |
| Query | |

> **Two terms you'll meet later, not now:** *normalization* (Unit 3) and *transaction* (Unit 4). You'll hear them mentioned — you're not expected to define them yet.

**Partner check:** trade files. Point at something in `nba_5seasons.db` that matches your partner's first four definitions.

---

# Unit 1c — Part 1: Teardown

Pick an app or website you actually use. **Not** one from the slides.

**App:**


## What the user sees vs. what's stored

| Front-end (what you touch) | Back-end (what's stored) |
|---|---|
| | |
| | |
| | |

## Find one of each

**A form** — where does this app let you enter or edit information?

**Answer:**


**A filter** — where can you narrow down what's displayed?

**Answer:**


**A report** — where does it show you formatted, summarized output?

**Answer:**


## Guess the tables

If you had to build the back-end, what tables would you need? Name at least three.

| Table | One row = | Columns you'd need |
|---|---|---|
| | | |
| | | |
| | | |

**One question:** name a piece of data this app stores about you that you'd be uncomfortable having leaked. Is that an *integrity* problem or a *security* problem?

**Answer:**


---

# Unit 1c — Part 2: Distractor Autopsy

Answer each question. **Then, for every wrong option, write one sentence explaining why it's wrong.**

That second step is the whole point. Anyone can guess; the skill is knowing what makes the other three answers false.

---

**1.** Which term describes the structural blueprint of a database — its tables, columns, types, and relationships?

A) Schema  B) Record  C) Field  D) Report

**My answer:**
**Why B is wrong:**
**Why C is wrong:**
**Why D is wrong:**

---

**2.** A relational database organizes data into:

A) Folders and files  B) Tables linked by keys  C) Free-form documents  D) Spreadsheet workbooks

**My answer:**
**Why the others are wrong:**

---

**3.** Which is the best example of *information* rather than *data*?

A) `1610612739`  B) `W`  C) "The Cavaliers won 121–104 on Nov 8"  D) `121`

**My answer:**
**Why the others are wrong:**

---

**4.** A single cell — one column's value in one row — is called a:

A) Record  B) Table  C) Field  D) Schema

**My answer:**
**Why the others are wrong:**

---

**5.** Which database type is built specifically to store *connections* between things, like who follows whom?

A) Data warehouse  B) Graph  C) Flat file  D) Document

**My answer:**
**Why the others are wrong:**

---

**6.** Which best describes a primary key?

A) Any column containing unique values
B) A column or set of columns that uniquely identifies each row and cannot be empty
C) A column that references another table
D) A rule that allows duplicate values

**My answer:**
**Why the others are wrong:**

---

**7.** A student logs into a school portal and sees their grades. The grades themselves live in:

A) The front-end  B) The back-end  C) The form  D) The report

**My answer:**
**Why the others are wrong:**

---

**8.** How does a neural network differ from a decision tree?

A) It runs faster
B) It learns patterns from examples rather than following rules a human wrote
C) It stores data in tables
D) It requires less data

**My answer:**
**Why the others are wrong:**

---

## Closing 1c — Vocabulary

Last ten. The first five you just found in a real app during the teardown.

| Term | Your definition |
|---|---|
| Front-end | |
| Back-end | |
| Form | |
| Filter | |
| Report | |
| Data integrity | |
| Data security | |
| Machine learning | |
| Neural network | |
| Decision tree | |

**Partner check:** trade files. Using only your partner's definitions of *form*, *filter* and *report*, can you label three things in the app they tore down?
