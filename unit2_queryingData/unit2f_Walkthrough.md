# Unit 2f Walkthrough — Joining Two Tables

Read this, then open `unit2f_lastname.sql` and do today's work.

---

## Why Joins Exist

`team_game_stats` stores `team_id = 1610612739`. Useless to a human.

`teams` stores that ID next to `Cleveland Cavaliers`.

A **JOIN** follows the foreign key and brings the two together:

```sql
SELECT g.game_date, t.full_name, g.pts
FROM   team_game_stats g
JOIN   teams t ON t.team_id = g.team_id;
```

This is the payoff for everything Unit 1 taught about keys.

---

## The Syntax

```sql
FROM  team_game_stats g
JOIN  teams t  ON t.team_id = g.team_id
```

- **`g`** and **`t`** are **table aliases** — short nicknames so you don't retype long names
- **`ON`** says *how the two tables connect* — almost always foreign key = primary key
- Once aliased, use `g.pts` and `t.full_name` to say which table a column came from

`JOIN` on its own means `INNER JOIN`: **keep only rows that match on both sides.**

---

## A Clean Example

```sql
SELECT   m.title, r.avg_rating, r.num_votes
FROM     movies m
JOIN     ratings r ON r.movie_id = m.movie_id
ORDER BY r.num_votes DESC
LIMIT    10;
```

Every movie has exactly one rating row, so this is a **one-to-one** join. 2,659 movies in, 2,659 rows out.

---

## Three Tables

```sql
SELECT   p.full_name, t.full_name AS team, s.pts
FROM     player_season_stats s
JOIN     players p ON p.player_id = s.player_id
JOIN     teams   t ON t.team_id   = s.team_id
WHERE    s.season = '2024-25'
ORDER BY s.pts DESC
LIMIT    10;
```

`player_season_stats` sits in the middle, holding two foreign keys. Each `JOIN` reaches out to one of them.

**Add one join at a time. Run it. Then add the next.**

---

## Today's Work

Open `unit2f_lastname.sql`. Six queries, **both databases** — `movies_small.db` first, then `nba_5seasons.db`. Start with the one-to-one movie/rating join, work up to a three-table NBA query.

When a join returns nothing, check your `ON` clause first. It's almost always the `ON` clause.
