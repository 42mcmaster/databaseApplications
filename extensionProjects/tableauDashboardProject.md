# Data Dashboard Project — Choose Your Dataset

**Tool:** Tableau

**Deliverable:** One dashboard, 3 visuals minimum

**Choose ONE:**
- **Option A — NBA Teams** (`nba_5seasons.db`) — pick a team, build a 5-season profile
- **Option B — Movies** (`sakila_master.db`) — pick a genre or an actor, build a profile from the movie catalog

Both options follow the same shape: query the data in DB Browser → export to CSV → connect in Tableau → build 3+ visuals → assemble into one dashboard. Everything below the "Shared" sections applies to whichever dataset you pick.

---

## The assignment overview

Pick a dataset. Pick a subject inside it (a team, a genre, an actor). Build one Tableau dashboard, **3 visuals minimum**, that tells a clear story about that subject — with a color palette and layout that looks intentional, not thrown together.

---

## Shared: key elements that make a dashboard good

- **One story, not a data dump.** Someone should get it in 10 seconds. If a visual doesn't support your story, cut it.
- **Color means something.** Pick one accent color that matters (a team color, a genre color) and use grayscale or subdued colors for everything else. Don't use a different color per chart just because it's there.
- **Your visual titles should mean something.** "Average Rental Rate" is a label. "Action Movies Cost More to Rent" is a title. Describe your visual like you're telling a story with it.
- **White space/room is important.** Don't cram every chart edge-to-edge — whitespace is part of good design.
- **Big number(s), then detail.** Considser leading with one (or two) large "headline stat" tiles before the deeper charts.

## Shared: color palette tips

- Pick one accent color tied to your subject (team colors; a color you associate with the genre) and pair it with a neutral gray for everything else.
- Use the accent color to draw the eye to what matters most — don't spread 5 bright colors across the dashboard.
- Avoid relying on red/green alone as your only signal — pair color with a label or shape too.

---

# Option A — NBA Team Dashboard

**Dataset:** `nba_5seasons.db` — 5 seasons, 2021-22 through 2025-26

### What's in it

| Table | Holds | Key columns |
|---|---|---|
| `teams` | 30 teams | `team_id`, `full_name`, `abbreviation`, `city`, `state`, `year_founded` |
| `team_game_stats` | Every game, per team (12,300 rows) | `season`, `team_id`, `matchup`, `wl`, `pts`, shooting stats, `reb`, `ast`, `stl`, `blk`, `tov`, `plus_minus` |
| `player_season_stats` | Player season averages (2,945 rows) | `season`, `player_id`, `team_id`, `gp`, `pts`, `reb`, `ast`, shooting %s |
| `players` | 1,029 players, name only | `player_id`, `full_name` |

**How they connect:**
```
teams (team_id) ──┬──> team_game_stats.team_id
                   └──> player_season_stats.team_id
players (player_id) ──> player_season_stats.player_id
```
`team_game_stats` and `player_season_stats` don't link to each other directly — both link back through `teams`. `matchup` looks like `"MIL vs. BKN"` (home) or `"BKN @ MIL"` (away) — that's how you tell home vs. away.

### The approach: two flat files (one per fact table), then filter in Tableau

`team_game_stats` and `player_season_stats` are at two different grains — one row per team-per-game vs. one row per player-per-season. Don't join those two together directly: a player joined to their team's games would duplicate every game row once per player on the roster, which would wreck any SUM or AVG built off the result. Instead, flatten each fact table on its own (adding team/player names so nothing's just an ID number), export **two CSVs total**, and let Tableau's filter do the work of narrowing to one team — same "big table, filter in Tableau" idea as the movie option, just split across the two grains that actually exist in this data.

```sql
-- Flat file 1: every team, every game, all 5 seasons (12,300 rows)
SELECT t.full_name AS team_name,
       t.abbreviation,
       tg.season, tg.game_date, tg.matchup, tg.wl, tg.pts,
       tg.fgm, tg.fga, tg.fg3m, tg.fg3a, tg.ftm, tg.fta,
       tg.oreb, tg.dreb, tg.reb, tg.ast, tg.stl, tg.blk, tg.tov, tg.plus_minus
FROM team_game_stats tg
JOIN teams t ON t.team_id = tg.team_id;
```

```sql
-- Flat file 2: every player, every season, all 5 seasons (2,945 rows)
SELECT t.full_name AS team_name,
       t.abbreviation,
       p.full_name AS player_name,
       ps.season, ps.gp, ps.min, ps.pts, ps.reb, ps.ast, ps.stl, ps.blk, ps.tov,
       ps.fg_pct, ps.fg3_pct, ps.ft_pct
FROM player_season_stats ps
JOIN players p ON p.player_id = ps.player_id
JOIN teams t ON t.team_id = ps.team_id;
```

Export each once — no `WHERE` clause needed, since every team's data is in there and students filter to their own team inside Tableau. Connect both CSVs in Tableau; you don't need to relate them to each other (they answer different questions — team performance vs. individual player performance).

### Layout example — "Header + KPI strip + 3 charts"

```
┌─────────────────────────────────────────────────────────┐
│ [team logo]     TEAM NAME: The Last Five Seasons         │
├─────────────────────────────────────────────────────────┤
│  [ Record ]      [ Avg PPG ]      [ Best Season ]         │
├───────────────────────────┬───────────────────────────────┤
│  Line: PPG trend           │  Bar: Wins/Losses by season    │
├───────────────────────────┴───────────────────────────────┤
│  Bar: Top 5 scorers, most recent season                    │
└─────────────────────────────────────────────────────────┘
```
Logo top-left of the header banner. KPI tiles run left to right by importance. Add a Team filter to the dashboard so classmates can reuse the same two CSVs for a different team without re-querying.

**Title ideas:** *"[Team]: The Last Five Seasons"* · *"[Team] — Five-Year Report Card"* · *"Rebuilding or Retooling? [Team]'s Five-Year Arc"* · *"Home Court: [Team] Wins and Losses"*

### Idea menu

| Visual | Needs | Chart type |
|---|---|---|
| Scoring trend across 5 seasons | avg `pts` by `season` | Line |
| Win/loss record by season | `wl` count by `season` | Stacked bar |
| Home vs. away performance | split on `matchup` | Grouped bar |
| Shooting efficiency over time | `fgm`/`fga`, `fg3m`/`fg3a`, `ftm`/`fta` → % | Line or bar |
| Top scorers on the roster | `player_season_stats` + `players` | Horizontal bar |
| Blowouts vs. close games | distribution of `plus_minus` | Histogram |

---

# Option B — Movie Dashboard

**Dataset:** `sakila_master.db` (using just the film/actor/genre subset — ignore rentals, customers, staff, stores)

### What's in it

| Table | Holds | Key columns |
|---|---|---|
| `film` | 1,000 movies (all released 2006) | `film_id`, `title`, `length` (minutes), `rental_rate`, `rating` (G/PG/PG-13/R/NC-17), `special_features` |
| `actor` | 200 actors | `actor_id`, `first_name`, `last_name` |
| `film_actor` | Which actors are in which films (5,462 rows) | `film_id`, `actor_id` |
| `category` | 16 genres (Action, Comedy, Sci-Fi, Sports, etc.) | `category_id`, `name` |
| `film_category` | Which genre each film belongs to | `film_id`, `category_id` |

**How they connect:**
```
film (film_id) ──┬──> film_category.film_id ──> category.category_id
                  └──> film_actor.film_id ──> actor.actor_id
```
One important difference from the NBA data: **every movie here is from 2006** — there's no multi-year trend to chart. Instead, the interesting comparisons are *across genres*, *across actors*, or *by rating/length/price*.

### The approach: one big query, then filter in Tableau

Rather than writing a separate query per chart, write **one query that joins everything into a single flat table** — one row per film-actor-genre combination — export that one CSV, and use Tableau filters (or a parameter) to let the dashboard focus on one genre or one actor at a time. This is genuinely a good match for how Tableau Public works, and it's fine that the table is "wide" (~5,400 rows) — that's what the filters are for.

```sql
SELECT f.film_id,
       f.title,
       f.rating,
       f.length,
       f.rental_rate,
       c.name AS genre,
       a.first_name || ' ' || a.last_name AS actor_name
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
JOIN film_actor fa ON fa.film_id = f.film_id
JOIN actor a ON a.actor_id = fa.actor_id;
```

Export that as one CSV → connect it in Tableau → build a genre filter (or parameter) that drives every chart on the dashboard.

### Pick your angle: Genre Dashboard or Actor Dashboard

**Genre Dashboard** — pick a genre (or let the viewer filter to one): how many films, how long are they on average, what do they rate, what does it cost to rent, who are the most-featured actors in that genre.

**Actor Dashboard** — pick an actor: how many films are they in, which genres do they show up in most, what's the average length/rating of their films, list of titles.

Either works with the same one-CSV setup — the difference is just which field drives your filter.

### Layout example — "Header + KPI strip + 3 charts" (Genre Dashboard)

```
┌─────────────────────────────────────────────────────────┐
│ [genre icon]   ACTION MOVIES: By the Numbers              │  ← header banner, genre-accent color
├─────────────────────────────────────────────────────────┤
│  [ # of Films ]   [ Avg Length ]   [ Avg Rental Rate ]     │
├───────────────────────────┬───────────────────────────────┤
│  Bar: Rating breakdown     │  Histogram: Film length         │
│  (G/PG/PG-13/R/NC-17)      │  distribution                   │
├───────────────────────────┴───────────────────────────────┤
│  Horizontal bar: Most-featured actors in this genre         │
└─────────────────────────────────────────────────────────┘
```
No team logo here — use a simple genre icon (a film reel, a clapperboard, or just a colored bar in the genre's accent color) in the same top-left spot instead. Since there's no real "team crest" for a genre, consistent use of one accent color across the whole dashboard does the same branding job.

**Title ideas:** *"[Genre] Movies: By the Numbers"* · *"What Makes a [Genre] Film?"* · *"[Genre]: A Rental Snapshot"* · *"[Actor Name]: A Filmography Breakdown"*

### Idea menu

| Visual | Needs | Chart type |
|---|---|---|
| Films per genre | `COUNT` of films by `genre` | Bar |
| Rating breakdown within a genre | count of `rating` for the filtered genre | Bar or pie |
| Film length distribution | `length`, filtered to genre or actor | Histogram |
| Rental rate by genre | avg `rental_rate` by `genre` | Bar |
| Most-featured actors in a genre | count of films per `actor_name`, filtered to genre | Horizontal bar |
| An actor's genre spread | count of films per `genre`, filtered to actor | Bar |
| Price vs. length relationship | `rental_rate` vs. `length`, colored by `genre` | Scatter |

*A quick real-data preview so you know what to expect:* Sports, Foreign, and Family are the most common genres (70+ films each); genres run G through NC-17 pretty evenly; film length spans about 46 to 185 minutes.

---

## Notes for both options

- This mirrors the same **Ask → Acquire → Clean → Analyze → Visualize → Communicate** workflow — you're just doing it end-to-end in one sitting rather than across several sessions.
- Ungraded enrichment. Still worth taking seriously — a working interactive dashboard is a genuinely resume-worthy artifact.
- If you finish one dataset with time to spare, the other option is right there.
