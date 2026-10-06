# Unit 3e Client Brief — Music Streaming App

**Client:** Encore, a small startup building a music app. *(The company is made up. The songs, albums, playlists, and numbers are real Spotify data from January 2020.)*

---

## What the client told us

> "We pulled our starting song library from Spotify. Each row is one song, and the last column lists every playlist the song is on.
>
> It works, but it's a mess. Ariana Grande's *Sweetener* is typed on every one of its songs, release date included, so when we found a typo in the date we had to hunt down every row. The playlist column is a list, so we can't easily ask 'what songs are on Hip Hop Controller?' We also found songs with the exact same name but different track IDs. Spotify gives the single and the album version of a song different IDs.
>
> We need a real database."

---

## What they keep track of

**Songs.** Spotify gives every track a `track_id`. Each song has a name, a popularity score (0–100), a length in milliseconds (`duration_ms`), and two audio scores from 0 to 1: `danceability` and `energy`. Each song belongs to one album and has one main artist.

**Albums.** Spotify gives every album an `album_id`. Each album has a name and a release date. Album names aren't unique. For example, there are two different albums called *Scorpion* (the explicit and the clean version), with different IDs.

**Artists.** 20 artists. The client added each artist's home country by hand. One artist has many songs.

**Playlists.** 9 real Spotify playlists. Each has a `playlist_id`, a name, and a genre. Spotify assigned the genres, and some may not match what you'd expect.

**Which songs are on which playlists.** A playlist has many songs. A song can be on more than one playlist.

---

## What the database needs to do

1. Change an album's release date **once** and have it be right for every song on the album.
2. Change an artist's country **once**.
3. Answer "what songs are on this playlist?" and "what playlists is this song on?"
4. Add a new playlist, or add a song to a playlist, without retyping the song's information.

---

## Your head start

Your design should end up with these **five tables**:

| Table | One row = |
|---|---|
| ARTISTS | one artist |
| ALBUMS | one album |
| SONGS | one song (one track_id) |
| PLAYLISTS | one playlist |
| PLAYLIST_SONGS | one song on one playlist |

**You decide:** which columns go in each table, what each table's primary key is, where the foreign keys go, and which relationships are one-to-many or many-to-many.

---

## Files

- **Spreadsheet:** `datasets/unit3e_Music.xlsx` — tabs `Client_Export`, `1NF`, then one tab per table
- **Turn-in:** `unit3e_Music_lastname.md`

*Data source: TidyTuesday, "Spotify Songs," January 21, 2020 (collected from the Spotify API).*
