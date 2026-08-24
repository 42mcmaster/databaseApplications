# Data Analytics Strand — Junior Database Applications

A three-lesson analytics strand that fixes the "dbApps is basically just SQL" problem by adding a
**structured analysis workflow** and a **tool progression**. Decided placement: **junior year, inside
Database Applications** (the seniors' AI arc then references it: "you *described* data as juniors —
now you *predict*").

## The through-line: one dataset, three lenses
All three lessons analyze the **same** `pizza_orders.csv` (63 orders) and ask the **same** questions
(which region/size earns most?). Students see that the *analysis is identical* — only the tool changes.

| Lesson | Tool | Sweet spot | Format |
|---|---|---|---|
| **analytics01** | **Excel** | fast, visual peek; PivotTables + charts | performance (Marp slides + step walkthrough + task) |
| **analytics02** | **Python / JupyterLab** | scale + reproducibility + richer charts | runnable notebook (validated) |
| **analytics03** | **Tableau** | interactive dashboards to communicate | performance (slides + step walkthrough + task) |

The workflow taught in all three: **Ask → Get → Clean → Analyze → Visualize → Communicate.**

## Where it slots into dbApps
After the SQL/joins/aggregation lessons (≈ `dbApps07–08`), before the capstone. ~3 lessons + the reframed
capstone (`ANALYTICS_Capstone_brief.md`). Fits the "1–2 days/week" dbApps cadence.

## Maps to the ITS Data Analytics cert (program 533)
- **Excel + Python** cover Domains 1–3 (data fundamentals, prepare, analyze).
- **Tableau + all three** cover Domain 4 (visualize & report).
- Responsible-data/bias (Domain 5) is a short add-on discussion (or borrow from the AI `ai11` module).
See `claude/DataAnalytics_Integration_Plan.md` §5b for the full mapping. The **DA cert-prep drill pack**
rehearses the exam formats.

## Each lesson folder
- `*_Slides.md` (Marp), `*_Walkthrough(.md/.ipynb)`, `*_StudyGuide.md`, `*a_Task(.md/.ipynb)`,
  `teacher/` solutions + `Gimkit.csv` + `GoogleQuiz.csv` (25 rows each).
- `dataset/pizza_orders.csv` — the shared dataset (put a copy in each lesson folder for students).

## Verified
`analytics02` (Python) notebooks execute clean; all `# Should print` outputs match the dataset
(total revenue $1600, West top region $499). Excel/Tableau lessons are GUI-performance based (step
walkthroughs + answer keys), like your MOS modules.

## Follow-ups / notes
- Swap in a **richer dataset** (NBA/IMDB already in dbApps, or a civic dataset) for the capstone if you want more weight.
- One GoogleForms quiz (analytics02) has answer positions skewed to "A" — shuffle on import if desired.
