# Unit 4 Starting Design — Music Streaming App (real Spotify data)

**Use this design for Unit 4**, even if your 3e design was different. Everyone in your client group builds the same tables, so the data files in 4b load without errors.

Compare it with your 3e design. If yours is different, figure out what changed and why.

## Tables

Table names and column names are written exactly as you should type them in SQL.

### artists

One row = one artist.

| Column | Key |
|---|---|
| `artist_name` | PK |
| `artist_country` |  |

### albums

One row = one album.

| Column | Key |
|---|---|
| `album_id` | PK |
| `album_name` |  |
| `album_release_date` |  |

### playlists

One row = one playlist.

| Column | Key |
|---|---|
| `playlist_id` | PK |
| `playlist_name` |  |
| `playlist_genre` |  |

### songs

One row = one song (one track_id).

| Column | Key |
|---|---|
| `track_id` | PK |
| `song_name` |  |
| `popularity` |  |
| `duration_ms` |  |
| `danceability` |  |
| `energy` |  |
| `artist_name` | FK → artists |
| `album_id` | FK → albums |

### playlist_songs

One row = one song on one playlist.

| Column | Key |
|---|---|
| `playlist_id` | PK, FK → playlists |
| `track_id` | PK, FK → songs |

## Relationships

- artists → songs: one-to-many
- albums → songs: one-to-many
- songs ↔ playlists: many-to-many, through playlist_songs

## Create the tables in this order

Parent tables first, because a foreign key can only point at a table that already exists:

`artists` → `albums` → `playlists` → `songs` → `playlist_songs`

## Data files (for 4b)

In 4b you'll import these files from this unit's `datasets/` folder, in this order: `music_artists.csv`, `music_albums.csv`, `music_playlists.csv`, `music_songs.csv`, `music_playlist_songs.csv`.
