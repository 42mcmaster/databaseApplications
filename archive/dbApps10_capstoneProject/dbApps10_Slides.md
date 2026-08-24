---
marp: true
theme: default
class: invert
paginate: true
---

# Capstone Project
## Design, Build, Query, Present

**Database Applications Development**
Software Engineering | Medina County Career Center

---

## The Big Idea

You're going to build **your own database from scratch** on a topic you actually care about.

Then you'll:
- Design it
- Fill it with real data
- Query it like a pro
- Present it to the class

This is where everything from the semester comes together.

---

## Pick a Topic You Actually Like

The best projects come from topics you genuinely enjoy. A few ideas:

- Sports stats tracker (NBA, NFL, your own fantasy league)
- Video game library / achievements
- Recipe collection
- Pet shelter or kennel
- Music playlist organizer
- Small business inventory
- Workout / fitness log
- School club or team manager

**Or propose your own.** If you're into it, you'll build it better.

---

## What You Have to Include

Every project needs:

- **3+ tables** with primary keys and foreign keys
- **20+ rows** in each main table (realistic data)
- **Constraints:** NOT NULL, UNIQUE, DEFAULT, CHECK, FOREIGN KEY
- **10+ SQL queries** (including JOINs and aggregates)
- **Parameterized queries** (no SQL injection!)
- **At least 1 transaction** (BEGIN / COMMIT / ROLLBACK)
- **Data dictionary** (plain-English table/column descriptions)
- **ER diagram** (shows your tables and their relationships)

---

## The Four Phases

| Phase | What happens |
|-------|--------------|
| **1. Design** | Plan your tables, keys, and relationships |
| **2. Build** | Create the tables and insert the data |
| **3. Query** | Write the 10+ queries that prove it works |
| **4. Present** | Demo your project to the class |

We'll walk through each phase on the next few slides.

---

## Phase 1: Design

Before you write any SQL, you plan.

1. **List your entities** — what "things" does your database track? (Each one becomes a table.)
2. **List attributes** — what facts do you store about each entity? (Those are columns.)
3. **Find the relationships** — which tables connect, and how?
4. **Draw an ER diagram** — boxes for tables, lines for relationships.
5. **Write your `CREATE TABLE` statements** with PKs, FKs, and constraints.

---

## Design Example: Pet Shelter

**Entities (tables):**
- Animals
- Adopters
- Adoptions

**Relationships:**
- One adopter can adopt many animals
- Each adoption links one animal to one adopter

**ER diagram sketch:**
```
[Adopters] ───1..*─── [Adoptions] ───*..1─── [Animals]
```

That's it — plan first, code second.

---

## Phase 2: Build

Once the design is locked in:

1. Create the database file.
2. Run your `CREATE TABLE` statements (with constraints!).
3. Insert **20+ realistic rows** into each main table.
4. Spot-check with `SELECT *` to make sure it looks right.

**Tip:** Use realistic data. "Cat 1, Cat 2, Cat 3" is boring and makes querying pointless. Give your rows real names, dates, and details.

---

## Phase 3: Query

Write **10+ queries** that show off what you can do:

- `SELECT ... WHERE` — basic filtering
- `INNER JOIN` — connect two tables
- `LEFT JOIN` — keep rows that don't match
- `GROUP BY` + `COUNT / SUM / AVG / MIN / MAX`
- `HAVING` — filter groups
- `ORDER BY` — sort results
- A **subquery or CTE** for bonus points

Make each query answer a real question about your topic.

---

## Phase 3: Query Examples (Pet Shelter)

```sql
-- 1. Every dog currently available for adoption
SELECT name, breed, age FROM animals
WHERE species = 'Dog' AND available = 1;

-- 2. How many animals each adopter has taken home
SELECT a.name, COUNT(*) AS total_adopted
FROM adopters AS a
INNER JOIN adoptions AS ad ON a.adopter_id = ad.adopter_id
GROUP BY a.name
ORDER BY total_adopted DESC;
```

Good queries tell a story about your data.

---

## Phase 4: Polish & Protect

Before presenting, clean it up:

- **Data dictionary** — a short doc explaining every table and column in plain English.
- **Parameterized queries everywhere** — no string concatenation.
- **Show one transaction** — BEGIN / COMMIT (or ROLLBACK) demonstrating an all-or-nothing operation.
- **Comment your SQL** — explain *why*, not just *what*.
- **Test everything** — run each query one more time before demo day.

---

## Phase 4: The Presentation (10 minutes)

1. **Your topic** (30 sec) — what does this database track, and why?
2. **Your ER diagram** (1 min) — walk us through the tables and links.
3. **Live demo of 3–4 best queries** (5 min) — run them, show the results.
4. **One thing you're proud of** (2 min) — toughest challenge, coolest query, favorite feature.
5. **Questions** (1 min)

Keep it **simple, confident, and clear**. Don't read slides — talk about your work.

---

## Rubric at a Glance

| Category | Points |
|----------|--------|
| Design (ER diagram, tables, constraints) | 30 |
| Build (CREATE, populate, clean data) | 30 |
| Queries (10+, variety, correctness) | 30 |
| Documentation (data dictionary, comments) | 15 |
| Presentation (clarity, live demo) | 15 |
| **TOTAL** | **120** |

Full rubric is in `dbApps10_Rubric.md`.

---

## Timeline & Survival Tips

- Work through the phases **in order** — don't start writing INSERTs before your design is done.
- **Commit to GitHub often** — at least after each phase.
- **Ask questions EARLY.** Don't silently struggle until demo day.
- **Keep it simple.** A clean, working project beats a fancy broken one every time.
- **Back up your work.**
- **Pick something you genuinely like** — it shows.

---

## Final Thought

This is the project you'll be able to point at for the rest of your life and say:

> "I designed, built, and shipped a real database."

That's a big deal. Take it seriously, have fun with it, and build something you're proud of.

**Let's go.** 🚀
