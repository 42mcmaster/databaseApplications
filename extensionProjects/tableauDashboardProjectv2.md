# Data Dashboard Project — NBA or Movies (IMDb-style)
**Tool:** Tableau

**Deliverable:** One dashboard, 3 visuals minimum

**Choose ONE:**
- **Option A — NBA Teams** (`nba_5seasons.db`) — pick a team, build a 5-season profile
- **Option B — Movies** (`movies_small.db`) — pick a genre, an actor, or a director, build a profile using real IMDb-style ratings across a century of film

Both options follow the same shape: access the data (.db file) in DB Browser → export to CSV → connect in Tableau → build 3+ visuals → assemble into one dashboard. Everything below the "Shared" sections applies to whichever dataset you pick.

---

## The assignment overview

Pick a dataset. Pick a subject inside it (a team, a genre, an actor). Build one Tableau dashboard, **3 visuals minimum**, that tells a clear story about that subject — with a color palette and layout that looks intentional, not thrown together.

---

## Shared: key elements that make a dashboard good

- **One story, not a data dump (don't just display a bunch of data).** Someone should get it in 10 seconds. If a visual doesn't support the story you are trying to tell, don't use it.
- **Color means something.** Pick one accent color that matters (a team color, a genre color) and use grayscale or subdued colors for everything else. Don't use a different color per chart just because it's there.
- **Your visual titles should mean something.** "Average Rental Rate" is a label. "Action Movies Cost More to Rent" is a title. Describe your visual like you're telling a story with it.
- **White space/room is important.** Don't cram every chart edge-to-edge — whitespace is part of good design.
- **Big number(s), then detail.** Considser leading with one (or two) large "headline stat" tiles before the deeper charts.

## Some color palette tips

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

`team_game_stats` and `player_season_stats` are at two different levels of granularity — one row per team-per-game vs. one row per player-per-season. Don't join those two together directly: a player joined to their team's games would duplicate every game row once per player on the roster, which would wreck any SUM or AVG built off the result. Instead, flatten each fact table on its own (adding team/player names so nothing's just an ID number), export **two CSVs total**, and let Tableau's filter do the work of narrowing to one team — same "big table, filter in Tableau" idea as the movie option, just split across the two grains that actually exist in this data.

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

Export each once — no `WHERE` clause needed, since every team's data is in there and students filter to their own team inside Tableau.

### Layout example — "Header + KPI strip + 3 charts"

```
┌─────────────────────────────────────────────────────────┐
│ [team logo]     TEAM NAME: The Last Five Seasons        │
├─────────────────────────────────────────────────────────┤
│  [ Record ]      [ Avg PPG ]      [ Best Season ]       │
├───────────────────────────┬─────────────────────────────┤
│  Line: PPG trend          │  Bar: Wins/Losses by season │
├───────────────────────────┴─────────────────────────────┤
│  Bar: Top 5 scorers, most recent season                 │
└─────────────────────────────────────────────────────────┘
```
Logo top-left of the header banner. KPI tiles run left to right by importance. Add a Team filter to the dashboard so classmates can reuse the same two CSVs for a different team without re-querying.

**Title ideas:** *"[Team]: The Last Five Seasons"* · *"[Team] — Five-Year Report Card"* · *"Rebuilding or Retooling? [Team]'s Five-Year Arc"* · *"Home Court: [Team] Wins and Losses"*

### Ideas

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

**Dataset:** `movies_small.db` — 2,659 movies spanning 1921–2025, with real IMDb-style ratings

### What's in it

| Table | Holds | Key columns |
|---|---|---|
| `movies` | 2,659 movies | `movie_id`, `title`, `release_year`, `runtime_minutes`, `genres` (comma-separated list, e.g. `"Action,Comedy,Family"`) |
| `ratings` | One row per movie | `movie_id`, `avg_rating` (0–10 scale), `num_votes` |
| `people` | 22,844 people | `person_id`, `name`, `birth_year`, `death_year`, `profession` |
| `roles` | 59,285 movie-person appearances | `movie_id`, `person_id`, `role` (`actor`, `actress`, `director`, `writer`, `producer`, etc.), `character` |

**How they connect:**
```
movies (movie_id) ──> ratings.movie_id     (one rating per movie)
movies (movie_id) ──> roles.movie_id ──> people.person_id   (many people per movie, via roles)
```

Two things worth knowing before you query:
- **`genres` holds more than one value per movie** (comma-separated). To keep things simple, pull just the *first* listed genre as a single `primary_genre` column — same idea as the NBA data having one team per row (splitting out every genre a movie isn't something we're going to worry about in this project).
- **This dataset spans real years (1921–2025)** — unlike the old Sakila set, there's an actual multi-decade trend to chart if you want one.

### The approach: one big query, then filter in Tableau

Same idea as before: one query joining everything into a single flat table — one row per movie-person-role appearance — export that one CSV, and use Tableau filters to focus on one genre, one person, or one role at a time.

```sql
SELECT m.title,
       m.release_year,
       m.runtime_minutes,
       substr(m.genres, 1, instr(m.genres || ',', ',') - 1) AS primary_genre,
       -- Extracts the first genre from the comma-separated genres string
       r.avg_rating,
       r.num_votes,
       ro.role,
       p.name AS person_name
FROM movies m
JOIN ratings r ON r.movie_id = m.movie_id
JOIN roles ro ON ro.movie_id = m.movie_id
JOIN people p ON p.person_id = ro.person_id;
```

That's ~59,000 rows in one CSV — connect it in Tableau, then filter to a genre, a role (actor/director/etc.), or a specific person to drive the dashboard.

### Pick your angle: Genre, Actor, Director, or Decade Dashboard

**Genre Dashboard** — pick a genre: how many movies, what's the average rating, how does runtime vary, what are the highest-rated movies in it.

**Actor Dashboard** — filter `role = 'actor'` (or `'actress'`) and one person's name: their filmography, the average rating of their movies, which genres they show up in most.

**Director Dashboard** — filter `role = 'director'` and one person's name: same idea, director's-eye view.

**Decade Dashboard** (new option this data supports) — no person filter at all: how has average rating or runtime shifted decade over decade across all 2,659 movies. Genuinely different from anything the NBA or old movie option could show, since this is the only dataset with real multi-decade range.

All four run off the same one-CSV setup — the difference is just which field(s) drive your filter.

### Layout example — "Header + KPI strip + 3 charts" (Genre Dashboard)

```
┌───────────────────────────────────────────────────────────┐
│ [genre icon]   ACTION MOVIES: By the Numbers              │  
             ← header banner, genre-accent color
├───────────────────────────────────────────────────────────┤
│  [ # of Movies ]   [ Avg Rating ]   [ Avg Runtime ]       │
├───────────────────────────┬───────────────────────────────┤
│  Histogram: Rating        │  Line: Avg rating by decade   │
│  distribution             │                               │
├───────────────────────────┴───────────────────────────────┤
│  Horizontal bar: Top 5 highest-rated movies in this genre │
└───────────────────────────────────────────────────────────┘
```
No team logo will be used here (obviously) — but look for a simple genre icon (a film reel, a clapperboard, or a colored bar in the genre's accent color) in the same top-left spot instead. One consistent accent color across the dashboard does the same branding job a team crest would.

**Title ideas:** *"[Genre] Movies: By the Numbers"* · *"[Actor/Director Name]: A Career in Ratings"* · *"How [Genre] Has Changed Since [Decade]"* · *"[Genre]: A Century on Screen"*

### Idea menu

| Visual | Needs | Chart type |
|---|---|---|
| Avg rating by genre | avg `avg_rating` by `primary_genre` | Bar |
| Rating distribution within a genre | histogram of `avg_rating`, filtered to genre | Histogram |
| Highest-rated movies in a genre | top N `avg_rating`, filtered to genre | Horizontal bar or table |
| Rating trend by decade | avg `avg_rating` by decade (`(release_year/10)*10`) | Line |
| Runtime vs. rating relationship | `runtime_minutes` vs. `avg_rating`, colored by genre | Scatter |
| A person's filmography rating | `avg_rating` per movie, filtered to `person_name` | Bar |
| Popularity vs. quality | `avg_rating` vs. `num_votes` | Scatter |

---

