---
marp: true
theme: default
class: invert
paginate: true
header: 'Unit 3 · Database Design'
---

# Unit 3
## Database Design

Database Applications Development
Medina County Career Center

**Five lessons, about five periods. Almost no SQL — this unit is about deciding what the tables should be.**

---

## Unit 2 vs. Unit 3

**Unit 2:** somebody else designed the tables. You pulled data out of them.

**Unit 3:** you design the tables.

**Unit 4:** you build what you designed here.

---

## How each lesson works

Same rhythm every day:

1. Read **`unit3X_Walkthrough.md`** on GitHub — the lesson
2. Download **`unit3X_lastname.md`**, rename it, do the work
3. Commit and push

Five lessons, five turn-in files. 

---

## The five lessons

| | Lesson | You'll produce |
|:-:|---|---|
| **3a** | Redundancy | A defect list from a badly designed database |
| **3b** | Keys and relationships | Your first ER diagram |
| **3c** | Normalization — 1NF, 2NF, 3NF | Three clean tables from one messy one |
| **3d** | Design vocabulary | Sort-and-match tasks, six practice items |
| **3e** | Design your own | The schema you build in Unit 4 |

---

## The problem this unit solves

`games_flat` in `denormalized_demo.db` — every team's city typed into every game:

```
game_date   home_team            home_city  home_state
2025-10-21  Cleveland Cavaliers  Cleveland  Ohio
2025-10-24  Cleveland Cavaliers  Cleveland  Ohio
2025-10-27  Cleveland Cavaliers  Cleveland  Ohio
```

"The Cavaliers play in Cleveland, Ohio" — typed **33 times**.

Two of those rows are already typed wrong. You'll find them in 3a.

---

## The fix has a name

Splitting tables so every fact is stored **once** is called **normalization**.

```
teams                            games
team_id  full_name   city        game_id  home_team_id  away_team_id
6        Cleveland   Cleveland   1        6             5
         Cavaliers
```

That's the whole unit. 3a shows why. 3b–3c show how. 3d covers the vocabulary. 3e you do it yourself.

---

## Diagrams are typed, not drawn

```
erDiagram
    TEAMS ||--o{ GAMES : "plays in"
```

GitHub turns that into a picture. **mermaid.live** previews it.

| Symbol | Means |
|---|---|
| `||` | exactly one |
| `o{` | zero or many |

"One team, many games." You can't type the line without deciding what kind of relationship it is.

---

## Two files to get before 3a and 3c

- **`datasets/denormalized_demo.db`** — open in DB Browser, same as `nba_5seasons.db`
- **`unit3_Normalization.xlsx`** — open in Google Sheets (File → Import)

Both are posted in Classroom.

---

## Today

Open **`unit3a_Walkthrough.md`** and read it. Then start **`unit3a_lastname.md`**.
