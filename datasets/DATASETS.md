# Datasets — Database Applications Development v2

Everything the course uses lives in `dbAppsV2/datasets/`. Units reference these by relative path — no more copying database files into every unit folder.

| File | Size | Used in |
|---|---|---|
| `nba_5seasons.db` | 1.7 MB | Units 1–3 · the primary teaching database |
| `movies_small.db` | 4.6 MB | Unit 2 (joins) · Unit 3 (many-to-many) |
| `titanic.csv` | 115 KB | Unit 4 · CSV import practice (8.3.2) |
| `basicNbaDbOverview.pdf` | 4 KB | Reference handout |
| `starwars_all_movies.gexf` | 83 KB | Unit 3b extension · graph networks in Gephi Lite |
| `us_flight_routes_2014.gexf` | 307 KB | Unit 3b extension · airline hubs in Gephi Lite |

Two more get built when we reach their units: `denormalized_demo.db` (Unit 3) and, only if the optional Certiport block runs, `broken_queries.db` (Unit 7).

---

## nba_5seasons.db

Five NBA seasons, 2021-22 through 2025-26. Four tables — two simple, two with composite keys.

### teams — 30 rows

| Column | Type | Notes |
|---|---|---|
| `team_id` | INTEGER | **PK** |
| `full_name` | TEXT | "Cleveland Cavaliers" |
| `abbreviation` | TEXT | "CLE" |
| `nickname` | TEXT | "Cavaliers" |
| `city` | TEXT | "Cleveland" |
| `state` | TEXT | 23 distinct states |
| `year_founded` | INTEGER | |

### players — 997 rows

| Column | Type | Notes |
|---|---|---|
| `player_id` | INTEGER | **PK** |
| `full_name` | TEXT | |

> Only two columns — which is the point. It exists so a player's name is stored **once** instead of repeated across 2,791 stat rows. Unit 1's field report asks students why, and it's the setup for normalization in Unit 3.

### team_game_stats — 10,842 rows

**Composite PK: `season` + `game_id` + `team_id`.** One `game_id` covers *two* rows — one per team — so no single column identifies a row.

`season` `game_id` `team_id` `game_date` `matchup` `wl` `pts` `fgm` `fga` `fg3m` `fg3a` `ftm` `fta` `oreb` `dreb` `reb` `ast` `stl` `blk` `tov` `plus_minus`

All stat columns are INTEGER. FK: `team_id` → `teams`.

### player_season_stats — 2,791 rows

**Composite PK: `season` + `player_id` + `team_id`.** A player can appear twice in one season if traded mid-year.

`season` `player_id` `team_id` `gp` `min` `pts` `reb` `ast` `stl` `blk` `tov` `fg_pct` `fg3_pct` `ft_pct`

Stat columns are REAL. FKs: `team_id` → `teams`, `player_id` → `players`.

> ⚠️ **`pts`, `reb`, `ast` here are season TOTALS, not per-game averages** — a value like `1126.0` is a full season. Students assume averages. Worth saying out loud.

---

## movies_small.db

A classroom cut of the full 203 MB IMDb database, trimmed to **movies with at least 100,000 votes** — 2,659 films, everything from *The Shawshank Redemption* down to *Footloose*.

**Why votes and not country:** the source database has no country, region, or language column anywhere, so a geographic filter is impossible. Popularity does the same job by a different road — high-vote films skew to titles students actually recognize, which matters more in class than nationality does.

Rebuild at a different threshold any time:

```
python3 dbAppsV2/teacher/tools/build_movies_small.py \
        teacher/databasesDatasets/imdb_class.db \
        dbAppsV2/datasets/movies_small.db  100000
```

| Threshold | Movies | Rough size |
|---|---:|---:|
| 250,000 votes | 1,001 | ~2 MB |
| **100,000 votes** | **2,659** | **4.6 MB** |
| 50,000 votes | 4,508 | ~8 MB |

### movies — 2,659 rows

| Column | Type | Notes |
|---|---|---|
| `movie_id` | TEXT | **PK** — IMDb's tconst, e.g. `tt0111161` |
| `title` | TEXT | |
| `release_year` | INTEGER | 1920s–2020s, weighted toward 2000s+ |
| `runtime_minutes` | INTEGER | |
| `genres` | TEXT | Comma-separated — `"Drama,Crime"` |

### ratings — 2,659 rows

| Column | Type | Notes |
|---|---|---|
| `movie_id` | TEXT | **PK**, FK → `movies` |
| `avg_rating` | REAL | 1.0–10.0 |
| `num_votes` | INTEGER | ≥ 100,000 by construction |

> A clean one-to-one join. Good first JOIN target before the harder many-to-many.

### people — 22,844 rows

| Column | Type | Notes |
|---|---|---|
| `person_id` | TEXT | **PK** — IMDb's nconst |
| `name` | TEXT | |
| `birth_year` | INTEGER | often null |
| `death_year` | INTEGER | usually null |
| `profession` | TEXT | Comma-separated |

### roles — 59,285 rows

**The junction table** — this is where many-to-many lives. One movie has many people; one person is in many movies.

| Column | Type | Notes |
|---|---|---|
| `movie_id` | TEXT | FK → `movies` |
| `person_id` | TEXT | FK → `people` |
| `role` | TEXT | `actor` `actress` `director` `writer` `producer` `composer` `editor` `casting_director` |
| `character` | TEXT | Often null |

Top actors by film count: Samuel L. Jackson (43), Tom Hanks (42), Robert De Niro (42), Brad Pitt (39).

---

## starwars_all_movies.gexf

A social network of 112 Star Wars characters from Episodes I through VII, stored in GEXF (a standard graph file format). Used in `unit3b_GraphGephi_Walkthrough.md`.

- **Nodes:** 112 characters (`label` = character name).
- **Edges:** 449 undirected connections. Two characters are connected if they spoke in the same scene.
- **Edge `weight`:** number of scenes the two characters shared, summed across all seven movies.

Node attributes:

| Attribute | Values | Where it comes from |
|---|---|---|
| `trilogy` | Prequel, Original, Sequel, or combinations like Prequel + Original | Scripts |
| `firstMovie` | Episode I ... Episode VII | Scripts |
| `movies` | List like "IV, V, VI" | Scripts |
| `movieCount` | 1-7 | Scripts |
| `species` | Human, Alien, Droid | Hand-labeled |
| `side` | Light side, Dark side, Neither | Hand-labeled |
| `group` | Jedi, Sith, Galactic Republic, Naboo and Gungans, Separatists, Rebel Alliance, Galactic Empire, Resistance, First Order, Criminals and bounty hunters, Civilians | Hand-labeled |
| `gender` | Male, Female, None (droids) | Hand-labeled |

Source: Evelina Gabasova's Star Wars social network project, built from the movie scripts (https://github.com/evelinag/StarWars-social-network). It was made in 2016, so Episodes VIII and IX are not included. The hand-labeled columns are teacher judgment calls (for example, bounty hunters and Jabba are "Neither"; clone commanders are Galactic Republic / Light side). Anakin and Darth Vader are separate nodes because the scripts name them separately. Gold Five has no connections. Rebuild script with all the labels: `unit3_databaseDesign/teacher/tools/build_starwars_gexf.py`. This file replaced the earlier `starwars_original_trilogy.gexf`; filter by `trilogy` to get just the original movies.

---

## us_flight_routes_2014.gexf

Nonstop US airline routes between airports in the lower 48 states plus DC, stored in GEXF. Used in `unit3b_GraphFlights_Walkthrough.md`.

- **Nodes:** 407 airports (`label` = 3-letter airport code). Attributes: `name`, `city`, `state`, `region` (Census region), `latitude`, `longitude`.
- **Edges:** 2,500 undirected routes. Two airports are connected if at least one airline flew nonstop between them.
- **Edge `weight`:** number of airlines listed on the route, including partner airlines selling seats on another airline's flight (codeshares).

Sources: routes from OpenFlights (https://openflights.org/data.php, Open Database License). The route data stopped updating in **June 2014**, so it is historical. States and locations from OurAirports (https://github.com/davidmegginson/ourairports-data, public domain). Alaska and Hawaii are left out, and two tiny groups of airports that connect to nothing else were dropped. It counts routes, not passengers. Rebuild script: `unit3_databaseDesign/teacher/tools/build_flight_routes_gexf.py`.

---

## Notes

**Foreign keys are declared in both databases**, so students can find them in DB Browser's *Edit Table Definition* dialog. ⚠️ SQLite does **not enforce** them unless `PRAGMA foreign_keys = ON` is set — check DB Browser's *Edit Pragmas* tab on the lab image.

**The 203 MB `imdb_class.db` stays out of the v2 folder.** It's the source for rebuilds, nothing more. v1 had three copies of it plus a 62 MB variant — roughly 680 MB of database files in the repo. Add anything over 20 MB to `.gitignore`.
