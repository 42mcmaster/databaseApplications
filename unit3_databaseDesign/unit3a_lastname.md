**Before you start:** rename this file to `unit3a_lastname.md`, using your own last name. Read `unit3a_Walkthrough.md` first. Commit and push when you're done.

**Name:**

---

# Unit 3a — Redundancy

Open **`denormalized_demo.db`** in DB Browser for SQLite. The walkthrough used the **Cleveland Cavaliers**. In this task you do the same work for the **Chicago Bulls**.

The 30 teams, cities, states, conferences, and divisions are real. The games and scores are made up.

## 1. Count the repeats

Use the **Execute SQL** tab. You know enough SQL from Unit 2 for all of these. Paste each query you run into the code block under the question.

**a.** How many rows are in `games_flat`?

```sql

```

**Answer:**


**b.** How many rows have `home_city = 'Chicago'`? How many have `away_city = 'Chicago'`?

```sql

```

**Answer:**


**c.** So how many times is the fact any team "plays in Chicago, Illinois" typed into this table?

**Answer:**


## 2. Find the mistakes

There are **8** mistakes planted in `games_flat`. Two of them are the Cavaliers mistakes from the walkthrough. Find all 8.

Run `SELECT DISTINCT` on each of these six columns: `home_team`, `away_team`, `home_city`, `away_city`, `home_state`, `away_state`. Add `ORDER BY` so the list is sorted.

What each list should have if nothing is wrong:

- **Team names:** 30.
- **Cities:** 29. The Clippers and the Lakers both play in Los Angeles.
- **States:** 23. Toronto is in Ontario, and Washington is in District of Columbia, so those count too.

If a list has more than that, something in it is wrong. Once you find a wrong value, use `WHERE` to get its `game_id`.

| # | game_id | Which column | What it says | What it should say |
|---|---|---|---|---|
| 1 | | | | |
| 2 | | | | |
| 3 | | | | |
| 4 | | | | |
| 5 | | | | |
| 6 | | | | |
| 7 | | | | |
| 8 | | | | |

**d.** Write a query that counts every Bulls game by **team name** (home or away). Compare your count to your city count from **b**. Which count is right, and why are they different?

```sql

```

**Answer:**


## 3. Spot the anomalies in a new table

A school keeps its class schedule in one table, `class_schedule`:

| student | course | period | teacher | room |
|---|---|---|---|---|
| Ava Brooks | Web Design | 1 | Mr. Grant | 214 |
| Ava Brooks | Algebra II | 2 | Ms. Ortiz | 108 |
| Liam Chen | Web Design | 1 | Mr. Grant | 214 |
| Liam Chen | Chemistry | 3 | Mrs. Hall | 122 |
| Noah Diaz | Web Design | 1 | Mr. Grant | 214 |
| Noah Diaz | Algebra II | 2 | Ms. Ortiz | 108 |
| Emma Fox | Art I | 4 | Mr. Kerr | 301 |

For each scenario, name the anomaly (**update**, **insert**, or **delete**) and explain what goes wrong.

**Scenario A** — Emma Fox drops Art I, so her Art I row is deleted.

**Which anomaly:**

**What goes wrong:**


**Scenario B** — The school hires a new teacher, Ms. Reyes, who will use Room 205. She has no students yet.

**Which anomaly:**

**What goes wrong:**


**Scenario C** — Mr. Grant moves from Room 214 to Room 220. How many rows have to change, and what happens if you miss one?

**Which anomaly:**

**What goes wrong:**


**e.** In `denormalized_demo.db`, team facts (city, state, conference, division) were moved into their own table, `teams`. Which facts in `class_schedule` should be moved into their own table the same way?

**Answer:**


## 4. The fixed version

Now look at the tables **`teams`** and **`games`** in the same database.

**f.** In the fixed version, how many rows would you change to move the Bulls to a new city? Which table is that row in?

**Answer:**


**g.** Look up the Bulls' `team_id` in `teams`. Then write a query on **`games`** (not `games_flat`) that counts every Bulls game using that number. Which count from Part 1 or 2 does it match? Why can't the `games` table have the kind of mistake you found in Part 2?

```sql

```

**Answer:**


**h.** Write one query that shows the game date, home team name, away team name, home points, and away points for **Bulls games only**, sorted by date. Start from the walkthrough's query. You will need to add columns and a `WHERE`.

```sql

```

## Closing 3a — Vocabulary

Your words, not the slide's.

| Term | Your definition |
|---|---|
| Redundancy | |
| Update anomaly | |
| Insert anomaly | |
| Delete anomaly | |
| Normalization | |

