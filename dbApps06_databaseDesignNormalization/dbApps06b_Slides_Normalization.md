---
marp: true
theme: default
class: invert
paginate: true
---

# Lesson 06b: Normalization
## From One Messy Table to a Smart Database

**Database Applications Development**
Software Engineering | Medina County Career Center

---

## Quick Recap: What We Learned in 06a

**Primary Key (PK)** — Unique ID for each row (like `tconst` or `nconst`)

**Foreign Key (FK)** — Points to another table's PK (connects tables)

**Redundancy** — Storing the same fact over and over (we don't want this!)

We saw *why* the IMDb database uses 5 tables instead of 1.
**Today:** How do you actually *design* a database like that from scratch?

---

## That Process Has a Name: Normalization

**Normalization = Taking one big messy table and splitting it into smaller, smarter tables**

It's the process the IMDb designers went through to get from this...

```
title     | year | rating | actor_name        | birth_year | category
Inception | 2010 | 8.8    | Leonardo DiCaprio | 1974       | actor
Inception | 2010 | 8.8    | Tom Hardy         | 1977       | actor
Inception | 2010 | 8.8    | Cillian Murphy    | 1976       | actor
```

...to 5 clean tables with PKs and FKs.

**You're going to do the same thing today — with a brand new dataset.**

---

## The Normalization Question

Look at any row of repeated data and ask:

**"What entity does this data belong to?"**

```
Inception | 2010 | 8.8 | Leonardo DiCaprio | 1974 | actor
```

- `Inception, 2010, 8.8` — These are **attributes** of the **Movie** entity
- `Leonardo DiCaprio, 1974` — These are **attributes** of the **Person** entity
- `actor` — That describes the **relationship** between them

**Different entities → different tables. Each entity gets its own attributes.**

---

## Let's Trace How IMDb Did It

```
┌─────────────────────┐     ┌─────────────────────┐
│  PEOPLE              │     │  TITLES              │
│  PK: nconst          │     │  PK: tconst          │
│  primaryName         │     │  primaryTitle         │
│  birthYear           │     │  startYear            │
└──────────┬───────────┘     │  genres               │
           │                 └──────────┬────────────┘
           │ FK: nconst                 │ FK: tconst
           ▼                            ▼
     ┌───────────────────────────────────────┐
     │  CAST & CREW (title_principals)       │
     │  FK: tconst  → TITLES                 │
     │  FK: nconst  → PEOPLE                 │
     │  category, characters                 │
     └───────────────────────────────────────┘
```

The bridge table **only stores the relationship** — no duplicated names or titles.

---

## The 3 Steps (Keep It Simple)

**Step 1: Find the repeating groups**
What data gets copied over and over in the flat table?

**Step 2: Identify the distinct entities**
What are the different *things* (people, products, events) this data is really about?

**Step 3: Create a table for each entity**
Each entity gets its own table with its own attributes. Add a PK. Use FKs to connect them.

That's normalization. Let's practice.

---

## Your Task: Normalize a Pizza Shop

You'll get a spreadsheet with one big messy table of pizza orders.

**Your job:**
1. Study the flat table — spot the redundancy
2. On paper, sketch 3 normalized tables with PKs and FKs
3. In Excel, create a clean schema diagram showing your design

**The goal:** Each entity's attributes stored exactly **once**.
No repeated customer info. No repeated menu info.

*Open `dbApps06b_NormalizationActivity.xlsx` — the flat table is on the first sheet.*
