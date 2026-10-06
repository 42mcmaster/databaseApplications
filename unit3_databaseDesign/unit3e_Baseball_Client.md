# Unit 3e Client Brief — Baseball Stats Website

**Client:** Dugout Data, a small website that posts MLB hitting stats. *(The company is made up. The players, teams, and stats are real data from the 2025 MLB season.)*

---

## What the client told us

> "We keep our 2025 hitting stats in one spreadsheet. It has every hitter with at least 200 at-bats. Each row is one player's stats for one team. If a player was traded during the season, he gets a row for each team he played for.
>
> The problem is that every row repeats the team's name, ballpark, division, and league. There are 358 rows and only 30 teams. We've already caught a typo in a team name. We also crammed bats and throws into one column like `L/R`, so we can't easily ask 'who are the switch hitters?'
>
> And there are two different players named Max Muncy.
>
> We need a real database."

---

## What they keep track of

**Players.** Each player has an ID from the Lahman Baseball Database (like `ramirjo01`), a name, a birth country, a birth year, which side he bats from, and which hand he throws with. In `bats_throws`, `L` = left, `R` = right, and `B` = both (a switch hitter).

**Teams.** 30 MLB teams. Each has a team ID (like `CLE`), a name, a ballpark, and a division.

**Divisions.** 6 divisions (AL East, AL Central, AL West, NL East, NL Central, NL West). Each division is in one league: the American League or the National League.

**Batting stats.** For each player on each team: games, at-bats, runs, hits, home runs, runs batted in (RBI), and stolen bases. A traded player has a separate stat line for each team.

---

## What the database needs to do

1. Change a team's name or ballpark **once** and have it be right for every player on the team.
2. Store a traded player's information **once**, with a separate stat line for each team.
3. Answer questions like "who are the switch hitters?" and "which players played for more than one team?"
4. Tell the two Max Muncys apart.

---

## Your head start

Your design should end up with these **four tables**:

| Table | One row = |
|---|---|
| PLAYERS | one player |
| TEAMS | one MLB team |
| DIVISIONS | one division |
| BATTING | one player's 2025 stats for one team |

**You decide:** which columns go in each table, what each table's primary key is, where the foreign keys go, and which relationships are one-to-many or many-to-many.

**One difference from the other clients:** you fix the 1NF problem yourself. On the `1NF` tab, split the `bats_throws` column into two columns using **Data → Split text to columns**. The Read_Me tab in the spreadsheet shows how.

---

## Files

- **Spreadsheet:** `datasets/unit3e_Baseball.xlsx` — tabs `Client_Export`, `1NF`, then one tab per table
- **Turn-in:** `unit3e_Baseball_lastname.md`

*Data source: Lahman Baseball Database, 2025 season.*
