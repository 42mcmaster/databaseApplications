# Unit 3 — drop-in layout

Copy into the `databaseApplications` repo like this:

```
databaseApplications/
├── unit3_databaseDesign/
│   ├── unit3_Packet.md                   read-only logistics
│   ├── unit3_Slides.md                   short kickoff deck, day one
│   ├── unit3a_Walkthrough.md … unit3e_Walkthrough.md   the five lessons (read on GitHub)
│   ├── unit3a_lastname.md … unit3e_lastname.md         the five turn-ins (one per lesson)
│   └── unit3_Normalization.xlsx      ← *.xlsx is gitignored; add an exception or post to Classroom
├── datasets/
│   └── denormalized_demo.db          ← *.db is gitignored; distribute like nba_5seasons.db
└── teacher/                          ← gitignored (teacher-only)
    ├── unit3_Packet_KEY.md
    ├── unit3_QuestionBank.csv
    └── tools/
        ├── build_denormalized_demo.py
        └── build_normalization_xlsx.py
```

Both build scripts are re-runnable (`python3 teacher/tools/<script>.py`) and write to the paths above.
