# IMDb Database Schema — Quick Reference Chart
**Database:** `imdb_class_2010plus.db` | ~19,000 titles from 2010+

```
┌─────────────────────────────────────────────┐      ┌──────────────────────────────────────┐
│  PEOPLE — Actors, Directors & More          │      │  RATINGS — Audience Scores           │
│  Table: name_basics  (182,015 rows)         │      │  Table: title_ratings  (19,462 rows) │
├─────────────────────────────────────────────┤      ├──────────────────────────────────────┤
│  PK  nconst            TEXT   Person ID     │      │  FK  tconst            TEXT  Title ID│
│      primaryName       TEXT   Full Name     │      │      averageRating     REAL  1.0-10.0│
│      birthYear         INT    Birth Year    │      │      numVotes          INT   # Votes │
│      deathYear         INT    Death Year    │      └──────────────┬───────────────────────┘
│      primaryProfession TEXT   Professions   │                     │ tconst (Title ID)
│      knownForTitles    TEXT   Famous For    │                     │
└──────────┬──────────────────────────────────┘                     │
           │ nconst (Person ID)                                     │
           │                                                        │
     ┌─────┴──────────────────┐                                     │
     │                        │                                     │
     ▼                        ▼                                     ▼
┌────────────────────────────────────────┐   ┌─────────────────────────────────────────────┐
│  CAST & CREW CREDITS                   │   │  TITLES — Movies & TV Shows                 │
│  Table: title_principals (364,848 rows)│   │  Table: title_basics  (19,462 rows)         │
├────────────────────────────────────────┤   ├─────────────────────────────────────────────┤
│  FK  tconst     TEXT   Title ID ───────┼──►│  PK  tconst          TEXT   Title ID        │
│      ordering   INT    Billing Order   │   │      titleType       TEXT   movie/tvSeries  │
│  FK  nconst     TEXT   Person ID ──┐   │   │      primaryTitle    TEXT   Title           │
│      category   TEXT   Role Type   │   │   │      originalTitle   TEXT   Original Title  │
│      job        TEXT   Specific Job│   │   │      isAdult         INT    Adult Flag (0)  │
│      characters TEXT   Character(s)│   │   │      startYear       INT    Release Year    │
└────────────────────────────────────┘   │   │      endYear         INT    End Year (TV)   │
     ▲  FK links to:                     │   │      runtimeMinutes  INT    Runtime (min)   │
     │   tconst → title_basics           │   │      genres          TEXT   Genre(s)        │
     │   nconst → name_basics            │   └─────────────────────────────────────────────┘
     │                                   │                    ▲
     │                                   │                    │
┌────┴───────────────────────────────┐   │                    │
│  DIRECTORS & WRITERS               │   │                    │
│  Table: title_crew_person          │   │                    │
│  (116,970 rows)                    │   └──► name_basics     │
├────────────────────────────────────┤                        │
│  FK  tconst   TEXT   Title ID ─────┼────────────────────────┘
│  FK  nconst   TEXT   Person ID ────┼──► name_basics
│      role     TEXT   director/writer│
└────────────────────────────────────┘

LEGEND:  PK = Primary Key (unique ID, no duplicates)
         FK = Foreign Key (points to another table's PK — this is how JOINs work)
```
