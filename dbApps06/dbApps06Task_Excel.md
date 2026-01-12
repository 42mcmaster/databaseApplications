# Lesson 06 Excel Task: Database Design Documentation
## Database Applications Development

**Objective:** Create professional database documentation using Microsoft Excel, practicing skills for the MOS (Microsoft Office Specialist) Associate certification.

---

## Task Overview

You will create TWO Excel workbooks:
1. **Entity-Relationship Diagram (ERD)** using Excel shapes and SmartArt
2. **Data Dictionary** documenting the NBA database structure

These tasks practice MOS Excel skills while reinforcing database design concepts.

---

## Part 1: Create an ERD in Excel (25 points)

### Instructions

**Create a new Excel workbook named `YourLastName_NBA_ERD.xlsx`**

### Sheet 1: NBA Database ERD

1. **Create the ERD using Excel shapes:**
   - Use Insert → Shapes → Rectangle to create table boxes
   - Label each table with its name
   - List primary key columns (mark with "PK")
   - List other important columns
   - Use arrows/connectors to show relationships

2. **Tables to include:**
   - teams
   - players
   - team_game_stats
   - player_season_stats

3. **Show relationships:**
   - Draw arrows from foreign keys to primary keys
   - Label relationship types (1:M, M:N)
   - Use different colors for different relationship types

### Formatting Requirements (MOS Skills)

**Shapes:**
- Tables: Rectangle shapes with rounded corners
- Use Format Shape → Fill to color-code tables
  - **teams** → Light Blue
  - **players** → Light Green
  - **team_game_stats** → Light Yellow
  - **player_season_stats** → Light Orange

**Text:**
- Table names: Bold, 14pt
- Column names: Regular, 11pt
- Primary keys: Bold, marked "PK"
- Foreign keys: Italic, marked "FK"

**Connectors:**
- Use Insert → Shapes → Arrows
- 1:M relationships → Solid line
- M:N relationships → Dashed line
- Format Line → 2pt width

**Layout:**
- Center tables on page
- Even spacing between elements
- Group related shapes together

### MOS Skills Practiced
- ✅ Insert and format shapes
- ✅ Use connectors and arrows
- ✅ Apply consistent formatting
- ✅ Group and align objects
- ✅ Use color effectively

---

## Part 2: Create a Data Dictionary (25 points)

### Instructions

**Create a new Excel workbook named `YourLastName_Data_Dictionary.xlsx`**

### Sheet 1: Summary

Create an overview table:

| Database Name | NBA Statistics Database |
|---------------|------------------------|
| Purpose | Track NBA teams, players, and game statistics |
| Number of Tables | 4 |
| Created By | [Your Name] |
| Date Created | [Today's Date] |
| Last Updated | [Today's Date] |

**Format this as a professional table with:**
- Header row with bold, colored background
- Borders around all cells
- Freeze top row
- Auto-fit column widths

### Sheet 2: teams table

Document the teams table:

| Column Name | Data Type | Key Type | Nullable | Description |
|-------------|-----------|----------|----------|-------------|
| team_id | INTEGER | PK | No | Unique identifier for each team |
| full_name | TEXT | | No | Official team name (e.g., "Cleveland Cavaliers") |
| abbreviation | TEXT | | Yes | Three-letter team code (e.g., "CLE") |
| nickname | TEXT | | Yes | Team mascot name (e.g., "Cavaliers") |
| city | TEXT | | Yes | Team's home city |
| state | TEXT | | Yes | Team's home state |
| year_founded | INTEGER | | Yes | Year the franchise was founded |

**Formatting:**
- Convert to Excel Table (Ctrl+T)
- Apply Table Style Medium 2
- Filter buttons enabled
- Freeze header row
- Auto-fit columns

**Add below the table:**
- Number of rows: [Count from database]
- Relationships: "Referenced by team_game_stats.team_id and player_season_stats.team_id"

### Sheet 3: team_game_stats table

| Column Name | Data Type | Key Type | Nullable | Description |
|-------------|-----------|----------|----------|-------------|
| season | TEXT | PK (part) | No | Season label (e.g., "2021-22") |
| game_id | TEXT | PK (part) | No | Unique game identifier |
| team_id | INTEGER | PK (part), FK | No | Team ID → teams.team_id |
| game_date | TEXT | | Yes | Date game was played |
| matchup | TEXT | | Yes | Matchup description (e.g., "CLE vs. BOS") |
| wl | TEXT | | Yes | Win/Loss flag ("W" or "L") |
| pts | INTEGER | | Yes | Team points scored |
| reb | INTEGER | | Yes | Total rebounds |
| ast | INTEGER | | Yes | Total assists |

**Note:** This table has more columns (fgm, fga, fg3m, etc.) - include at least 10 total

**Formatting:**
- Same table formatting as Sheet 2
- Highlight composite primary key rows (light yellow)
- Highlight foreign key rows (light blue)

### Sheet 4: Relationships

Create a relationship documentation table:

| From Table | From Column | To Table | To Column | Relationship Type | Description |
|------------|-------------|----------|-----------|-------------------|-------------|
| team_game_stats | team_id | teams | team_id | Many-to-One | Each game belongs to one team |
| player_season_stats | player_id | players | player_id | Many-to-One | Each season stat belongs to one player |
| player_season_stats | team_id | teams | team_id | Many-to-One | Each season stat belongs to one team |

**Formatting:**
- Excel Table with Table Style Medium 6
- Conditional formatting:
  - "Many-to-One" → Green fill
  - "Many-to-Many" → Orange fill (if any)
  - "One-to-One" → Blue fill (if any)

### Sheet 5: Business Rules

Document important rules:

| Rule ID | Rule Description | Enforced By |
|---------|------------------|-------------|
| BR-01 | Team IDs must be unique | PRIMARY KEY constraint |
| BR-02 | Every game stat must reference a valid team | FOREIGN KEY constraint |
| BR-03 | Game combination (season, game_id, team_id) must be unique | COMPOSITE PRIMARY KEY |
| BR-04 | Points cannot be negative | CHECK constraint (if implemented) |
| BR-05 | Win/Loss must be 'W' or 'L' | CHECK constraint (if implemented) |

**Formatting:**
- Excel Table
- Auto-number Rule IDs using formulas
- Wrap text in descriptions

### MOS Skills Practiced
- ✅ Create and format Excel Tables
- ✅ Use Table Styles
- ✅ Apply conditional formatting
- ✅ Freeze panes
- ✅ Auto-fit columns
- ✅ Add borders and shading
- ✅ Use formulas for auto-numbering

---

## Bonus Challenges (+10 points)

### Challenge 1: Add Data Validation

On Sheet 2 (teams table documentation), add a sample data entry section below your documentation table with Data Validation:

| team_id | full_name | city | state |
|---------|-----------|------|-------|
| [Dropdown: 1610612739, 1610612738] | [Free text] | [Free text] | [Dropdown: CA, TX, OH, NY, FL] |

**MOS Skill:** Data → Data Validation

### Challenge 2: Create a Chart

Create a column chart showing "Number of Columns by Table":
- X-axis: Table names
- Y-axis: Column count
- Place on Summary sheet

**MOS Skill:** Insert → Charts

### Challenge 3: Add SmartArt

On the ERD sheet, add a SmartArt graphic (Process → Basic Block List) showing the normalization steps:
1. Identify entities
2. Define attributes
3. Establish relationships
4. Apply normal forms
5. Implement constraints

**MOS Skill:** Insert → SmartArt

---

## Submission Requirements

**Submit TWO Excel files via your GitHub repository:**
1. `YourLastName_NBA_ERD.xlsx`
2. `YourLastName_Data_Dictionary.xlsx`

### Grading Rubric

**ERD (25 points):**
- All 4 tables included and properly formatted (10 pts)
- Relationships clearly shown with arrows (8 pts)
- Professional formatting and layout (7 pts)

**Data Dictionary (25 points):**
- All required sheets completed (15 pts)
- Accurate information from database (5 pts)
- Professional formatting with Tables (5 pts)

**Bonus Challenges (10 pts):**
- Data validation implemented (3 pts)
- Chart created (4 pts)
- SmartArt added (3 pts)

**Total: 60 points possible (50 + 10 bonus)**

---

## MOS Certification Alignment

This task practices these MOS Excel Associate exam objectives:

**1. Manage Worksheets and Workbooks**
- 1.4.1 Modify page setup
- 1.4.4 Freeze worksheet rows and columns

**2. Manage Data Cells and Ranges**
- 2.1.1 Insert data in cells and ranges
- 2.1.5 Use AutoFill

**3. Manage Tables and Table Data**
- 3.1.1 Create Excel tables
- 3.1.2 Format tables
- 3.1.3 Add or remove table rows and columns

**4. Perform Operations by Using Formulas and Functions**
- 4.1.1 Reference cells in formulas

**5. Manage Charts**
- 5.1.1 Create charts
- 5.1.2 Modify charts

---

## Tips for Success

**Excel Best Practices:**
1. Save frequently (Ctrl+S)
2. Use keyboard shortcuts for efficiency
3. Keep formatting consistent across sheets
4. Test data validation rules
5. Review spelling (F7)

**Design Tips:**
1. Use white space effectively
2. Align elements properly
3. Choose readable fonts
4. Use color purposefully
5. Print preview before submitting

**Time Management:**
- ERD: ~45 minutes
- Data Dictionary: ~60 minutes
- Bonus challenges: ~30 minutes
- **Total:** ~2.5 hours

---

## Resources

**Excel Help:**
- Microsoft Excel Support: https://support.microsoft.com/excel
- MOS Certification Info: https://www.microsoft.com/en-us/learning/mos-certification.aspx

**Database Design:**
- Your completed walkthrough notebook
- SQL Reference Guide (Lesson 06)
- Class notes on ERD symbols

**Questions?**
Ask your instructor or classmates for help!

---

**Good luck! This project combines database knowledge with valuable Excel skills!** 📊✨
