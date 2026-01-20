# Lesson 06 Complete Package Summary
## Database Applications Development

---

## What You Now Have

### 📊 **Student-Facing Materials (Simplified)**

**1. Slides (for teaching in class)**
- `dbApps06_Slides_Simplified.md` (28 slides, ~15-20 min)
- Focuses on: Primary keys, foreign keys, no duplicates
- Uses NBA database examples throughout
- NO complex theory (1NF, 2NF, 3NF)
- Matches what students will practice

**2. Walkthrough (do together in class)**
- `dbApps06_Walkthrough.ipynb` (student version with fill-in-blanks)
- `dbApps06_Walkthrough_Solutions.ipynb` (your version with answers)
- 5 simple parts, ~30-35 minutes
- Hands-on practice with basic concepts

**3. Reference Guide (for student reference)**
- `dbApps06_SQL_Reference_Guide_Simplified.md`
- Just the SQL patterns they need for tasks
- Examples mirror the task questions
- Quick troubleshooting tips

**4. Tasks Part 1 (40 points)**
- `dbApps06Tasks_part1_starter.ipynb` (student version)
- `dbApps06Tasks_part1_solutions.ipynb` (your version)
- 4 tasks + bonus
- Primary keys, foreign keys, redundancy
- ~30-40 minutes

**5. Tasks Part 2 (40 points)**
- `dbApps06Tasks_part2_starter.ipynb` (student version)
- `dbApps06Tasks_part2_solutions.ipynb` (your version)
- 3 tasks + bonus
- Analyzing database design (no designing from scratch!)
- ~35-45 minutes

---

### 📚 **Teacher Reference Materials (Comprehensive)**

**Keep these for your own reference:**
- `dbApps06_DatabaseDesign.md` (1,412 lines - full lesson content)
- `dbApps06_Slides.md` (760 lines - detailed slides with all theory)
- `dbApps06_SQL_Reference_Guide.md` (443 lines - advanced patterns)

**These have all the theory (1NF, 2NF, 3NF, etc.) but DON'T use them with students.**
They're for your background knowledge and future advanced lessons.

---

## Recommended Class Flow (2.5 hour block)

### Before Class
- [ ] Pre-test walkthrough solutions in JupyterLab
- [ ] Pre-test both task solution files
- [ ] Make sure students have access to nba_5seasons.db

### During Class (150 minutes)

**1. Teach Slides (20 min)**
- Use `dbApps06_Slides_Simplified.md`
- Focus on: Why split data? Primary keys, foreign keys, no duplicates
- Show real NBA examples

**2. Walkthrough Together (30-35 min)**
- Students open `dbApps06_Walkthrough.ipynb`
- They fill in blanks as you guide them
- You have solutions in `dbApps06_Walkthrough_Solutions.ipynb`
- Go at their pace, answer questions

**3. Break (5 min)**
- Quick stretch, bathroom break

**4. Part 1 Tasks (30-40 min)**
- Students work on `dbApps06Tasks_part1_starter.ipynb`
- Reference guide available: `dbApps06_SQL_Reference_Guide_Simplified.md`
- You circulate and help
- You have solutions for reference

**5. Part 2 Tasks (35-45 min)**
- Students work on `dbApps06Tasks_part2_starter.ipynb`
- Same reference guide available
- Students who finish early can work on bonus questions

**6. Wrap-up (5-10 min)**
- Quick review of key concepts
- Remind about GitHub submission

---

## Key Changes Made

### ✂️ **What We Simplified**

**Original Materials:**
- ❌ 6 tasks in Part 1 → Now 4 tasks + bonus
- ❌ "Design databases from scratch" in Part 2 → Now "analyze existing designs"
- ❌ ERD drawing exercises → Removed
- ❌ Detailed 1NF/2NF/3NF theory → Simplified to "avoid duplicates"
- ❌ Composite keys, partial dependencies, transitive dependencies → Removed
- ❌ 760 line slides → Now 28 slides
- ❌ 870 line walkthrough → Now ~350 lines

**Why This Works Better:**
- Matches junior high reading/attention levels
- Focuses on practical skills over theory
- Students practice what they learn (no disconnect)
- Reasonable time commitments
- Clear, achievable goals

---

## What Students Will Learn

By the end of this lesson, students can:

✅ Explain why databases are split into multiple tables
✅ Identify primary keys in a table
✅ Identify foreign keys in a table
✅ Use JOINs to connect tables
✅ Calculate how much storage good design saves
✅ Recognize good vs bad database design

**They DON'T need to:**
- Memorize 1NF/2NF/3NF definitions
- Design complex databases from scratch
- Draw formal ERDs
- Understand partial/transitive dependencies

**That advanced stuff can come later (or not at all for CTE students).**

---

## File Organization

```
Student Files (use these in class):
├── dbApps06_Slides_Simplified.md
├── dbApps06_Walkthrough.ipynb
├── dbApps06_SQL_Reference_Guide_Simplified.md
├── dbApps06Tasks_part1_starter.ipynb
└── dbApps06Tasks_part2_starter.ipynb

Your Solution Files (for reference):
├── dbApps06_Walkthrough_Solutions.ipynb
├── dbApps06Tasks_part1_solutions.ipynb
└── dbApps06Tasks_part2_solutions.ipynb

Teacher Reference (background knowledge):
├── dbApps06_DatabaseDesign.md
├── dbApps06_Slides.md
└── dbApps06_SQL_Reference_Guide.md
```

---

## Grading

**Part 1: 40 points**
- Task 1: 10 points (primary keys)
- Task 2: 10 points (foreign keys)
- Task 3: 10 points (redundancy)
- Task 4: 10 points (relationships)
- Bonus: +5 points

**Part 2: 40 points**
- Task 1: 15 points (mapping database)
- Task 2: 15 points (spotting bad design)
- Task 3: 10 points (adding data correctly)
- Bonus: +5 points

**Total: 80 points (+ 10 bonus = 90 possible)**

---

## Pre-Teaching Checklist

**Materials Ready:**
- [ ] All student files in class folder
- [ ] Solutions files in your teacher folder
- [ ] NBA database file accessible to students
- [ ] Slides ready to present

**You've Tested:**
- [ ] Walkthrough solutions run without errors
- [ ] Part 1 solutions run without errors
- [ ] Part 2 solutions run without errors
- [ ] All queries return expected results

**You're Prepared to:**
- [ ] Explain primary keys with simple examples
- [ ] Explain foreign keys with simple examples
- [ ] Show JOINs connecting tables
- [ ] Help with SQL syntax errors
- [ ] Guide students who get stuck

---

## Common Student Questions (Be Ready!)

**"Why can't we just use team names instead of team_id?"**
Answer: Names can change, can have typos, take more space. IDs are short, stable, and guaranteed unique.

**"What if I forget which column is the foreign key?"**
Answer: Look at the PRAGMA table_info() result, or check the reference guide examples.

**"This JOIN isn't working, what's wrong?"**
Answer: Check that you're matching the right columns. Foreign key in one table should match primary key in the other.

**"How do I know which table to start FROM?"**
Answer: Usually start with the table that has the foreign key, then JOIN to the table with the info you want.

---

## Success Indicators

**Students are getting it if they can:**
- Look at PRAGMA output and identify the primary key
- Explain why team_id is better than team_name for a primary key
- Write a simple JOIN between two tables
- Calculate storage savings from good design
- Identify redundancy problems in a bad table design

**Students are struggling if:**
- They can't identify which column is the primary key
- They don't understand what a foreign key does
- They can't write the JOIN syntax
- They don't see why duplicates are bad

**If struggling:** Go back to slides, use more examples, do extra walkthrough together.

---

## Next Lesson Preview

**Lesson 07 will likely cover:**
- More complex JOINs
- Multiple table joins
- LEFT JOIN vs INNER JOIN
- Using joins for data analysis

**This lesson (06) sets the foundation by:**
- Teaching what primary/foreign keys are
- Practicing basic JOINs
- Understanding why tables connect

**Students need to master this before moving on!**

---

**You're all set!** The simplified approach focuses on practical skills students can actually use. Save the theory for later (or never, if they don't need it). Good luck with the lesson! 🚀
