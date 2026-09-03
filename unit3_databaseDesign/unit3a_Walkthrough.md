# Unit 3a Walkthrough — Redundancy

**Read this first. Then open `unit3a_lastname.md` and do the work.**

---

## What you're doing today

Unit 2 was about getting data *out* of tables somebody else designed. Unit 3 is about deciding what the tables should be in the first place. Today you look at a database that was designed badly on purpose, find what's wrong with it, and see the fixed version.

**Files:** `datasets/denormalized_demo.db` in DB Browser for SQLite. No new SQL today — everything you need is from Unit 2.

---

## One table, everything in it

Open `denormalized_demo.db` and look at the **Browse Data** tab for the table `games_flat`. Every row is one game, and every row has the home team's name, city, state, conference, and division typed in — and then the away team's too.

```
game_date   home_team            home_city  home_state  away_team      away_city
2025-10-21  Cleveland Cavaliers  Cleveland  Ohio        Chicago Bulls  Chicago
2025-10-24  Cleveland Cavaliers  Cleveland  Ohio        Miami Heat     Miami
2025-10-27  Boston Celtics       Boston     Massachusetts  Cleveland Cavaliers  Cleveland
```

The fact "the Cavaliers play in Cleveland, Ohio" is typed into this table **over thirty times**. That is **redundancy** — the same fact stored in more than one place.

The 30 teams, their cities, states, conferences, and divisions are real. The games and scores are made up.

---

## Why redundancy hurts — three anomalies

An **anomaly** is something that goes wrong because of how the table is designed. There are three, and you need to know them by name.

**Update anomaly** — a fact changes, so you have to change it everywhere it's stored. If the Cavaliers moved to a new city, every one of those thirty-plus rows needs editing. Miss one, and the table now disagrees with itself.

**Insert anomaly** — you want to store a fact but there's nowhere to put it. A brand-new expansion team has a city and a state, but `games_flat` only has rows for *games*. Until the team plays, its city can't be stored anywhere.

**Delete anomaly** — you delete one thing and lose another by accident. Delete every game a team played, and the team's city, state, conference, and division are gone too. Nobody meant to delete the team.

---

## Two rows are already wrong

Somebody typed the Cavaliers' name wrong in one row, and typed the state as `OH` instead of `Ohio` in another. Run this in the **Execute SQL** tab:

```sql
SELECT COUNT(*)
FROM   games_flat
WHERE  home_team = 'Cleveland Cavaliers'
   OR  away_team = 'Cleveland Cavaliers';
```

Now count the games where `home_city` or `away_city` is `'Cleveland'`. The two numbers are different. The database didn't complain — it just gave a wrong answer.

That is what redundancy does over time. The more places a fact is typed, the more places it can be typed wrong.

`SELECT DISTINCT` is the fastest way to find typos like this:

```sql
SELECT DISTINCT home_team FROM games_flat ORDER BY home_team;
```

Thirty teams should give thirty names. If you get thirty-one, one of them is a misspelling.

---

## The fix: store each fact once

The same database has two more tables, `teams` and `games`. Look at them in Browse Data.

```
teams                                    games
team_id  full_name            city       game_id  game_date   home_team_id  away_team_id  home_pts  away_pts
6        Cleveland Cavaliers  Cleveland  1        2025-10-21  6             5             112       104
```

The city is in **one row** of `teams`. Each game just points at the team by number — `home_team_id` and `away_team_id` are **foreign keys** to `teams.team_id`, exactly like the ones you joined on in Unit 2f.

Now moving the Cavaliers is a one-row edit. A new team can be added before it plays. Deleting games can't delete a team.

Splitting tables so every fact lives in exactly one place is called **normalization**. That's what the rest of this unit is about.

---

## One new thing: joining the same table twice

To show both team *names* for a game, you need `teams` twice — once for the home side, once for the away side. Give each copy its own alias:

```sql
SELECT g.game_date, h.full_name AS home, a.full_name AS away
FROM   games g
JOIN   teams h ON h.team_id = g.home_team_id
JOIN   teams a ON a.team_id = g.away_team_id
LIMIT  5;
```

`h` and `a` are the same table, joined on different columns. This is the last question in today's task.

---

## Now do the work

Open `unit3a_lastname.md`. Count the repeats, find the two mistakes, explain the three anomalies using this table, then compare to the fixed version. Commit and push when you're done.
