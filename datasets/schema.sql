CREATE TABLE teams (
      team_id INTEGER PRIMARY KEY,
      full_name TEXT,
      abbreviation TEXT,
      nickname TEXT,
      city TEXT,
      state TEXT,
      year_founded INTEGER
    );
CREATE TABLE players (
      player_id INTEGER PRIMARY KEY,
      full_name TEXT
    );
CREATE TABLE team_game_stats (
      season TEXT,
      game_id TEXT,
      team_id INTEGER,
      game_date TEXT,
      matchup TEXT,
      wl TEXT,
      pts INTEGER,
      fgm INTEGER,
      fga INTEGER,
      fg3m INTEGER,
      fg3a INTEGER,
      ftm INTEGER,
      fta INTEGER,
      oreb INTEGER,
      dreb INTEGER,
      reb INTEGER,
      ast INTEGER,
      stl INTEGER,
      blk INTEGER,
      tov INTEGER,
      plus_minus INTEGER,
      PRIMARY KEY (season, game_id, team_id),
      FOREIGN KEY (team_id) REFERENCES teams(team_id)
    );
CREATE TABLE player_season_stats (
      season TEXT,
      player_id INTEGER,
      team_id INTEGER,
      gp INTEGER,
      min REAL,
      pts REAL,
      reb REAL,
      ast REAL,
      stl REAL,
      blk REAL,
      tov REAL,
      fg_pct REAL,
      fg3_pct REAL,
      ft_pct REAL,
      PRIMARY KEY (season, player_id, team_id),
      FOREIGN KEY (player_id) REFERENCES players(player_id),
      FOREIGN KEY (team_id) REFERENCES teams(team_id)
    );
