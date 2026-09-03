**Before you start:** rename this file to `unit3a_lastname.md`, using your own last name. Read `unit3a_Walkthrough.md` first. Commit and push when you're done.

**Name:**

---

# Unit 3a — Redundancy

Open **`denormalized_demo.db`** in DB Browser for SQLite. Look at the table **`games_flat`** first. The 30 teams, cities, states, conferences, and divisions are real. The games and scores are made up.

## 1. Count the repeats

Use the **Execute SQL** tab. You know enough SQL from Unit 2 for all of these.

**a.** How many rows are in `games_flat`?

**Answer:**


**b.** How many rows have `home_city = 'Cleveland'`? How many have `away_city = 'Cleveland'`?

**Answer:**


**c.** So how many times is the fact "the Cavaliers play in Cleveland, Ohio" typed into this table?

**Answer:**


## 2. Find the mistakes

Two rows in `games_flat` were typed wrong on purpose. Find them.

**Hint:** `SELECT DISTINCT home_team FROM games_flat ORDER BY home_team;` — then try the same for the state columns.

| Mistake | Which column | What it says | What it should say |
|---|---|---|---|
| 1 | | | |
| 2 | | | |

**d.** Write a query that counts every Cavaliers game (home or away). Then compare your count to the number of rows where `home_city` or `away_city` is Cleveland. Why are they different?

**Answer:**


## 3. The three anomalies

Answer in plain words, using this table.

**Update anomaly** — The Cavaliers move to a new city. How many rows do you have to change, and what happens if you miss one?

**Answer:**


**Insert anomaly** — A brand-new expansion team joins the league but hasn't played a game yet. Can you store that team's city and state in `games_flat`? Why or why not?

**Answer:**


**Delete anomaly** — Every game a team played gets deleted from the table. What else did you just lose?

**Answer:**


## 4. The fixed version

Now look at the tables **`teams`** and **`games`** in the same database.

**e.** In the fixed version, how many rows would you change to move the Cavaliers to a new city?

**Answer:**


**f.** How does the `games` table know which team played, if the team name isn't in it?

**Answer:**


**g.** Write one query that shows game date, home team name, and away team name using `teams` and `games`. (Hint: you need to join `teams` twice, once for home and once for away. Give each a different alias.)

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

**Partner check:** trade files. Using only your partner's definitions, can they tell which anomaly each of your three answers in Part 3 describes?
