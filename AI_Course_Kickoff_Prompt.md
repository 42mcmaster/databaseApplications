# AI CURRICULUM BUILD — KICKOFF PROMPT

Copy everything below the line and paste it as your first message in a new chat.

---

I'm Ryan McMaster, a CTE instructor at Medina County Career Center. I just finished building my Database Applications Development course (ODE 145085) with Claude and now I need to build out the remaining lessons for my **Artificial Intelligence** course using the exact same formatting standards and file structure.

## WHERE I AM

I've already taught through **ai05**. Topics covered so far include decision trees and random forest. I still need to build lessons covering **regression** and **neural networks**, plus any big-ticket ODE competencies I may have missed. I only have about **2 weeks of class time left**, so keep it tight — no filler, no extras, just what matters.

I'll give you access to my working folder so you can see my existing files and the ODE course PDF.

## FORMATTING STANDARDS (match these exactly)

These are the standards established across 10 lessons of my database course. Follow them precisely.

### General Style
- Simple, clean, minimal emojis
- **camelCase** for all Python variable names
- Heavy code comments in all notebooks
- No `Name: ____` or `Date: ____` fields (students push to personal GitHub)
- 20-30 minutes max instruction per sub-lesson, then hands-on
- Sub-lessons (e.g., 06a, 06b, 06c) are NOT tied to calendar days — teacher controls pacing

### File Naming Convention
All files use the pattern `ai##_FileName.ext`:
```
ai##_Slides.md              — MARP presentation (max 10 slides)
ai##_StudyGuide.md          — Vocabulary, quick reference, data dictionary
ai##_Walkthrough.ipynb      — Student walkthrough (Try This blanks)
ai##_Walkthrough_Solutions.ipynb — Instructor walkthrough (all filled + Instructor Notes)
ai##a_Task.ipynb            — Sub-lesson a task (student)
ai##a_Task_Solutions.ipynb  — Sub-lesson a task (instructor)
ai##b_Task.ipynb            — Sub-lesson b task (student)
ai##b_Task_Solutions.ipynb  — etc.
ai##_DIYTask.ipynb          — Independent task (student)
ai##_DIYTask_Solutions.ipynb — Independent task (instructor)
ai##_Gimkit.csv             — 25-30+ review questions
ai##_GoogleQuiz.csv         — 25-30+ quiz questions
Unit#_EndOfUnit_GoogleQuiz.csv — 35-40 questions (last lesson of each unit)
```

### MARP Slides Format
```markdown
---
marp: true
theme: default
class: invert
paginate: true
---

# Lesson ##: Topic Title

## Artificial Intelligence
### Medina County Career Center

---

<!-- _header: "Sub-Lesson ##a — Topic Name" -->

## Slide Content Here
```
- Max 10 slides per lesson
- Sub-lesson header comments mark which slides belong to which sub-lesson
- Concise bullet points, not paragraphs
- Use ASCII/text diagrams where helpful

### Gimkit CSV Format
```
Question,Correct Answer,Incorrect Answer 1,Incorrect Answer 2,Incorrect Answer 3
```
- 25-30+ questions per lesson
- Text containing commas must be wrapped in double quotes

### Google Quiz CSV Format
```
Question,Option A,Option B,Option C,Option D,Correct Answer,Points
```
- Correct Answer is the letter (A, B, C, or D)
- Points is always 1
- 25-30+ questions per lesson
- End-of-unit quizzes: 35-40 questions (~70% recent lesson + ~30% review)

### Jupyter Notebook Standards
- `nbformat: 4, nbformat_minor: 4`
- Student versions have blank code cells with `# Your code here` after each task
- Instructor solutions versions have:
  - Cell 0: `"# ai## Walkthrough — INSTRUCTOR SOLUTIONS\n**DO NOT DISTRIBUTE TO STUDENTS**"`
  - All code cells filled with solutions
  - "Instructor Note" markdown cells with teaching tips
- Walkthrough notebooks have sub-lesson section headers: `## Sub-Lesson ##a — Topic`
- All SQL/data queries use `pd.read_sql()` with triple-quoted strings
- camelCase for all variable names
- Heavy code comments explaining each step
- Setup cell: imports + data loading at the top

### Study Guide Format
1. Vocabulary section (~15-22 terms with definitions)
2. Data dictionary (if a dataset is used)
3. Quick reference / cheat sheet for the lesson's key syntax or concepts
4. ODE Competencies covered in the lesson

### Per-Lesson Deliverables
Every lesson needs ALL of these (unless it's a capstone/project lesson):
- [ ] Slides (.md, MARP format)
- [ ] Study Guide (.md)
- [ ] Student Walkthrough (.ipynb)
- [ ] Instructor Walkthrough Solutions (.ipynb)
- [ ] Sub-lesson Task notebooks (student + solutions for each sub-lesson)
- [ ] DIY Task notebook (student + solutions)
- [ ] Gimkit CSV (25-30+ questions)
- [ ] Google Quiz CSV (25-30+ questions)
- [ ] End-of-Unit Quiz CSV if last lesson in unit (35-40 questions)

## WHAT I NEED YOU TO DO

1. **Look at my existing ai01-ai05 files** to understand what I've already covered and my existing structure
2. **Find the ODE course competencies** for the AI course — check for a PDF in my teacher folder, or I can upload it
3. **Build a simple master plan** for the remaining lessons (regression, neural networks, and any must-cover ODE gaps) — keep it to 2 weeks of material max
4. **Build each lesson** following the exact file structure and formatting above
5. **Validate all files** (JSON-valid notebooks, clean CSVs, proper MARP headers)

Start by looking at what's in my folder and let's build the master plan first. Keep everything simple — I don't have time for extras.
