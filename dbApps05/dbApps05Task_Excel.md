# Task 05 Excel - Track A: Excel Formulas and Visualizations

**Course:** Database Applications Development  
**Lesson:** 05 - Excel Integration with SQL Data  

---

## Overview

In this task, you will work with the Excel files you exported from your SQL queries. You'll practice Excel skills that align with the Microsoft Office Specialist (MOS) Excel Associate certification.

**Files you should have:**
1. `team_performance.xlsx`
2. `top_scorers.xlsx`
3. `win_loss_records.xlsx`
4. `high_scoring_games.xlsx`

**If you don't have these files, complete the SQL task first!**

---

## Skills Practiced (MOS Excel Associate Aligned)

- Create and modify formulas (SUM, AVERAGE, MAX, MIN, IF, COUNTIF)
- Format cells and ranges
- Create and format charts
- Sort and filter data
- Apply conditional formatting
- Use absolute and relative cell references

---

## Part 1: team_performance.xlsx - Formulas and Calculations

**Open:** `team_performance.xlsx`

### Task 1.1: Add Calculated Columns

**Add these new columns with formulas:**

**Column: Total Points (Season)**
- Formula location: Create new column after `avg_points`
- Formula: `=games_played * avg_points`
- Purpose: Calculate approximate total season points
- Format: Number, 0 decimals

**Column: Win Percentage**
- Formula location: Create new column after `losses`
- Formula: `=(wins / games_played) * 100`
- Purpose: Calculate win percentage
- Format: Number, 1 decimal place, add % symbol

**Column: Performance Rating**
- Formula location: Final column
- Formula: `=IF(win_pct > 60, "Excellent", IF(win_pct > 50, "Good", IF(win_pct > 40, "Average", "Below Average")))`
- Purpose: Categorize teams by performance
- Format: Text, center aligned

### Task 1.2: Add Summary Statistics

**At the bottom of your data, add these calculations:**

**Row: League Average**
- Label in first column: "League Average"
- Calculate: `=AVERAGE(range)` for games, wins, avg_points, etc.
- Format: Bold, fill with light gray

**Row: Best Team**
- Label: "Best Performance"
- Use: `=MAX(range)` for relevant columns
- Format: Bold, fill with light green

**Row: Worst Team**
- Label: "Needs Improvement"
- Use: `=MIN(range)` for relevant columns
- Format: Bold, fill with light red

### Task 1.3: Conditional Formatting

**Apply conditional formatting:**

1. **Wins column:** 
   - Color scale: Red (low) → Yellow (mid) → Green (high)
   
2. **Avg Points column:**
   - Data bars: Blue bars showing relative values
   
3. **Performance Rating column:**
   - Highlight rules:
     - "Excellent" = Green fill
     - "Good" = Yellow fill
     - "Average" = Orange fill
     - "Below Average" = Red fill

### Task 1.4: Create Charts

**Chart 1: Top 10 Teams by Wins**
- Type: Horizontal bar chart (bar chart rotated)
- Data: Top 10 teams sorted by wins
- X-axis: Team names
- Y-axis: Number of wins
- Title: "Top 10 Teams - Win Total (2021-22)"
- Position: Below your data table

**Chart 2: Win % Distribution**
- Type: Column chart
- Data: All teams, sorted by win percentage
- X-axis: Team names (or abbreviations if available)
- Y-axis: Win percentage
- Title: "NBA Team Win Percentage (2021-22)"
- Add: Horizontal line at 50% (=.500 mark)
- Position: New sheet or next to Chart 1

---

## Part 2: top_scorers.xlsx - Statistical Analysis

**Open:** `top_scorers.xlsx`

### Task 2.1: Add Statistical Formulas

**Add these columns:**

**Column: Points Per Game (verify)**
- Formula: `=total_points / games_played`
- Purpose: Double-check the ppg calculation
- Format: Number, 1 decimal
- Compare to existing PPG column (should match)

**Column: Scoring Tier**
- Formula: `=IF(ppg >= 25, "Elite", IF(ppg >= 20, "All-Star", IF(ppg >= 15, "Starter", "Role Player")))`
- Purpose: Categorize players by scoring output
- Format: Text, center

**Column: Games Percentage**
- Formula: `=(games_played / 82) * 100`
- Purpose: What % of season did they play?
- Format: Number, 0 decimals, % symbol
- Note: Full NBA season is 82 games

### Task 2.2: Count and Summary Functions

**Create a summary section:**

**Count by Tier:**
- Use `=COUNTIF(tier_range, "Elite")` for each tier
- Show count of Elite, All-Star, Starter, Role Player
- Format as a small table off to the side

**Top Performers:**
- Highest PPG: `=MAX(ppg_range)` and use `=INDEX(MATCH(...))` to find player name
- Lowest PPG (in top 50): `=MIN(ppg_range)`
- Average PPG: `=AVERAGE(ppg_range)`

### Task 2.3: Create Scoring Charts

**Chart 1: Top 15 Scorers**
- Type: Horizontal bar chart
- Data: Top 15 by PPG
- X-axis: Player names
- Y-axis: Points per game
- Title: "Top 15 Scorers - PPG (2021-22)"
- Color: Vary colors by tier if possible

**Chart 2: Scoring Tier Distribution**
- Type: Pie chart
- Data: Count of players in each tier
- Labels: Tier names with counts
- Title: "Player Distribution by Scoring Tier"
- Show percentages

---

## Part 3: win_loss_records.xlsx - Comparative Analysis

**Open:** `win_loss_records.xlsx`

### Task 3.1: Add Win/Loss Analysis

**Add columns:**

**Column: Games Behind Leader**
- Formula: `=MAX($wins_range) - wins`
- Purpose: How many wins behind the best team?
- Format: Number, 0 decimals
- Use: Absolute reference for MAX range

**Column: Winning Streak Potential**
- Formula: `=82 - games_played`
- Purpose: Games remaining (if season not complete)
- Format: Number, 0 decimals

**Column: Win Pace (82-game projection)**
- Formula: `=(wins / games_played) * 82`
- Purpose: Project wins over full season
- Format: Number, 1 decimal

### Task 3.2: Playoff Cutoff Analysis

**Create analysis section:**

**Calculate:**
- Playoff cutoff (typically 8th place in each conference)
- Use `=LARGE(wins_range, 8)` to find 8th most wins
- Show how many teams are "In the Hunt" (within 5 games)
- Formula: `=COUNTIF(games_behind_range, "<=5")`

### Task 3.3: Create Win/Loss Charts

**Chart 1: Win-Loss Records**
- Type: Stacked bar chart
- Data: All teams
- Series 1: Wins (green)
- Series 2: Losses (red)
- X-axis: Team names
- Title: "Win-Loss Records by Team"
- Sort by total wins

**Chart 2: Win Percentage Scatter**
- Type: Scatter plot
- X-axis: Games played
- Y-axis: Win percentage
- Title: "Win % by Games Played"
- Purpose: See consistency across teams

---

## Part 4: high_scoring_games.xlsx - Game Analysis

**Open:** `high_scoring_games.xlsx`

### Task 4.1: Game Analysis Formulas

**Add columns:**

**Column: Scoring Category**
- Formula: `=IF(points >= 140, "Historic", IF(points >= 130, "Exceptional", IF(points >= 120, "High", "Standard")))`
- Purpose: Categorize scoring levels
- Format: Text, center

**Column: Win/Loss Result**
- If not already included, show W or L from your data
- Format: Text, center
- Apply conditional formatting (W=Green, L=Red)

**Column: Month**
- Extract month from game_date
- Formula: `=TEXT(game_date, "mmmm")` or `=MONTH(game_date)`
- Purpose: See seasonal patterns
- Format: Text

### Task 4.2: Summary Statistics

**Calculate:**
- Total high-scoring games: `=COUNTA(points_range)`
- Average points in these games: `=AVERAGE(points_range)`
- Highest score: `=MAX(points_range)`
- Teams with most 120+ games: `=COUNTIF(team_range, team_name)`

**Create pivot summary:**
- Count games by team
- Count games by month
- Win/loss split

### Task 4.3: Create Trend Charts

**Chart 1: High Scoring Games Over Time**
- Type: Line chart or scatter
- X-axis: Game date
- Y-axis: Points scored
- Title: "High-Scoring Games Throughout Season"
- Add: Trendline to show if scoring increased

**Chart 2: Teams with Most 120+ Games**
- Type: Column chart
- Data: Count of games per team
- X-axis: Team names
- Y-axis: Number of 120+ point games
- Title: "Teams with Most High-Scoring Games"

---

## Formatting Requirements

**Professional presentation:**

1. **Headers:**
   - Bold, larger font (14pt)
   - Fill color (blue or team color)
   - White text
   - Centered

2. **Data:**
   - Consistent number formatting
   - Aligned appropriately (text left, numbers right)
   - Borders around cells for clarity

3. **Charts:**
   - Clear, descriptive titles
   - Axis labels
   - Legend when needed
   - Positioned neatly
   - Consistent color scheme

4. **Overall:**
   - No empty awkward spaces
   - Professional color scheme
   - Readable fonts (11-12pt for data)
   - Print-ready (fits on pages appropriately)

---

## Submission Checklist

Before submitting, verify:

- [ ] All 4 Excel files completed
- [ ] All required formulas added and working
- [ ] All charts created with proper formatting
- [ ] Conditional formatting applied
- [ ] Summary statistics calculated
- [ ] Professional formatting throughout
- [ ] Files saved with your updates
- [ ] All sheets named appropriately

**Submit:**
- All 4 completed Excel files
- Push to GitHub in your `databaseApplications` folder

---

## Rubric

| Category | Points | Criteria |
|----------|--------|----------|
| Formulas | 40 | All required formulas working correctly |
| Charts | 30 | All charts created, properly formatted |
| Formatting | 15 | Professional presentation, conditional formatting |
| Analysis | 10 | Summary statistics, insights calculated |
| Completeness | 5 | All tasks finished, files submitted |
| **Total** | **100** | |

---

## Tips for Success

1. **Use cell references**, not hard-coded values
2. **Test formulas** with different data
3. **Format as you go** - don't wait until the end
4. **Check your math** - do results make sense?
5. **Chart readability** - can someone else understand it?
6. **Save frequently** - Excel can crash!
7. **Ask for help** if stuck - don't struggle silently

**You're learning real-world analyst skills!** 📊

---

## Next Steps

After completing this task:
- You've practiced SQL aggregations
- You've exported data for analysis
- You've created Excel formulas and visualizations
- You're ready for database design (Lesson 6)!

**This is the complete data analysis workflow!** SQL for processing → Excel for presentation.
