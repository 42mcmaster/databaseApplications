# Unit 4 Starting Design — Baseball Stats Website (real 2025 MLB data)

**Use this design for Unit 4**, even if your 3e design was different. Everyone in your client group builds the same tables, so the data files in 4b load without errors.

Compare it with your 3e design. If yours is different, figure out what changed and why.

## Tables

Table names and column names are written exactly as you should type them in SQL.

### divisions

One row = one division.

| Column | Key |
|---|---|
| `division` | PK |
| `league` |  |

### teams

One row = one MLB team.

| Column | Key |
|---|---|
| `team_id` | PK |
| `team_name` |  |
| `ballpark` |  |
| `division` | FK → divisions |

### players

One row = one player.

| Column | Key |
|---|---|
| `player_id` | PK |
| `player_name` |  |
| `bats` |  |
| `throws` |  |
| `birth_country` |  |
| `birth_year` |  |

### batting

One row = one player's 2025 stats for one team.

| Column | Key |
|---|---|
| `player_id` | PK, FK → players |
| `team_id` | PK, FK → teams |
| `games` |  |
| `at_bats` |  |
| `runs` |  |
| `hits` |  |
| `home_runs` |  |
| `rbi` |  |
| `stolen_bases` |  |

## Relationships

- divisions → teams: one-to-many
- players ↔ teams: many-to-many, through batting

## Create the tables in this order

Parent tables first, because a foreign key can only point at a table that already exists:

`divisions` → `teams` → `players` → `batting`

## Data files (for 4b)

In 4b you'll import these files from this unit's `datasets/` folder, in this order: `baseball_divisions.csv`, `baseball_teams.csv`, `baseball_players.csv`, `baseball_batting.csv`.
