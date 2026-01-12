# Excel Walkthrough 01: Gaming & Esports Statistics

## Database Applications Development
### Software Engineering | Medina County Career Center

---

## Overview

**Purpose:** Master Excel formulas and visualization using gaming and esports data.

**Skills Practiced:**
- SUM, AVERAGE, MIN, MAX, COUNT, COUNTIF
- IF statements and conditional logic
- Cell references (relative and absolute)
- Professional charts and graphs
- Data formatting

**Setup:** Create a new Excel workbook named "Gaming_Stats.xlsx". Each problem is a separate worksheet.

---

## Problem 1: Battle Royale Tournament Results

**Instructions:**
1. Create a new worksheet named "Battle_Royale"
2. Copy the data table below into cells A1:E11
3. Complete the formula exercises that follow

**Data Table:**

| Player_Name | Match1_Kills | Match2_Kills | Match3_Kills | Match4_Kills |
|-------------|--------------|--------------|--------------|--------------|
| ShadowNinja | 12           | 15           | 8            | 14           |
| ProGamer99  | 9            | 11           | 13           | 10           |
| SnipeKing   | 15           | 14           | 16           | 12           |
| GhostRider  | 7            | 9            | 11           | 8            |
| TitanFury   | 11           | 13           | 9            | 15           |
| VortexX     | 14           | 12           | 14           | 13           |
| BlazeFast   | 8            | 10           | 12           | 9            |
| ThunderBolt | 13           | 11           | 10           | 14           |
| NeonStrike  | 10           | 8            | 15           | 11           |
| IcePhoenix  | 16           | 17           | 13           | 16           |

### Formulas to Create:

**Column F - Total Kills:**
- Header in F1: `Total_Kills`
- Formula in F2: `=SUM(B2:E2)`
- Copy down to F11

**Column G - Average Kills Per Match:**
- Header in G1: `Avg_Kills`
- Formula in G2: `=AVERAGE(B2:E2)`
- Format to 1 decimal place
- Copy down to G11

**Column H - MVP Status (Average >= 12):**
- Header in H1: `MVP_Status`
- Formula in H2: `=IF(G2>=12,"MVP","Player")`
- Copy down to H11

**Summary Statistics (below your data):**
- Cell A13: `Tournament Leader`
- Cell B13: `=MAX(F2:F11)`
- Cell A14: `Lowest Total`
- Cell B14: `=MIN(F2:F11)`
- Cell A15: `Average Total Kills`
- Cell B15: `=AVERAGE(F2:F11)`
- Cell A16: `MVP Players`
- Cell B16: `=COUNTIF(H2:H11,"MVP")`

**Formatting:**
- Bold headers (row 1)
- Format Avg_Kills to 1 decimal place
- Apply conditional formatting: MVP = Green, Player = Yellow

**Chart Exercise:**
Create a **Column Chart** showing Total Kills by Player:
- Select Player_Name (A1:A11) and Total_Kills (F1:F11)
- Insert → Column Chart
- Title: "Tournament Total Kills"
- Add data labels

---

## Problem 2: Video Game Console Sales

**Instructions:**
1. Create a new worksheet named "Console_Sales"
2. Copy the data table below into cells A1:D7
3. Complete the formula exercises

**Data Table:**

| Quarter | PlayStation | Xbox  | Nintendo |
|---------|-------------|-------|----------|
| Q1      | 45000       | 38000 | 52000    |
| Q2      | 48000       | 41000 | 55000    |
| Q3      | 52000       | 43000 | 48000    |
| Q4      | 67000       | 56000 | 73000    |
| Q5      | 51000       | 44000 | 51000    |
| Q6      | 49000       | 42000 | 54000    |

### Formulas to Create:

**Column E - Quarterly Total:**
- Header in E1: `Quarterly_Total`
- Formula in E2: `=SUM(B2:D2)`
- Copy down to E7

**Row 8 - Console Totals:**
- Cell A8: `Console Total`
- Cell B8: `=SUM(B2:B7)`
- Copy across to D8

**Row 9 - Average Quarterly Sales:**
- Cell A9: `Avg Quarter`
- Cell B9: `=AVERAGE(B2:B7)`
- Copy across to D9
- Format to 0 decimal places

**Row 10 - Best Quarter:**
- Cell A10: `Peak Sales`
- Cell B10: `=MAX(B2:B7)`
- Copy across to D10

**Additional Calculations:**
- Cell A12: `Grand Total`
- Cell B12: `=SUM(E2:E7)`
- Cell A13: `Best Console`
- Cell B13: `=MAX(B8:D8)`

**Chart Exercise:**
Create a **Line Chart** showing sales trends:
- Select entire data range (A1:D7)
- Insert → Line Chart
- Title: "Console Sales by Quarter"
- Add legend

---

## Problem 3: Esports Tournament Prize Pool

**Instructions:**
1. Create a new worksheet named "Prize_Pool"
2. Copy the data table below
3. Complete formulas and apply absolute references

**Data Table:**

| Team_Name      | Tournament_Wins | Prize_Per_Win |
|----------------|-----------------|---------------|
| Team_Liquid    | 8               | 25000         |
| Cloud9         | 6               | 25000         |
| FaZe_Clan      | 12              | 25000         |
| G2_Esports     | 5               | 25000         |
| Fnatic         | 9               | 25000         |
| NaVi           | 11              | 25000         |
| OpTic_Gaming   | 7               | 25000         |
| TSM            | 4               | 25000         |

### Formulas to Create:

**Column D - Total Winnings:**
- Header in D1: `Total_Winnings`
- Formula in D2: `=B2*C2`
- Format as currency ($)
- Copy down to D9

**Column E - Bonus Eligible (Wins >= 8):**
- Header in E1: `Bonus_Status`
- Formula in E2: `=IF(B2>=8,"Eligible","Not Eligible")`
- Copy down to E9

**Summary Calculations:**
- Cell A11: `Total Prize Money`
- Cell B11: `=SUM(D2:D9)`
- Format as currency
- Cell A12: `Average Winnings`
- Cell B12: `=AVERAGE(D2:D9)`
- Format as currency
- Cell A13: `Top Earner`
- Cell B13: `=MAX(D2:D9)`
- Format as currency
- Cell A14: `Teams Eligible for Bonus`
- Cell B14: `=COUNTIF(E2:E9,"Eligible")`

**Chart Exercise:**
Create a **Bar Chart** of Total Winnings:
- Select Team_Name and Total_Winnings columns
- Insert → Bar Chart (horizontal)
- Title: "Esports Team Earnings"
- Format Y-axis as currency

---

## Problem 4: Gaming PC Performance Benchmarks

**Instructions:**
1. Create worksheet named "PC_Benchmarks"
2. Copy data and create formulas

**Data Table:**

| PC_Build        | FPS_Game1 | FPS_Game2 | FPS_Game3 | CPU_Temp | GPU_Temp |
|-----------------|-----------|-----------|-----------|----------|----------|
| Budget_Beast    | 85        | 92        | 78        | 68       | 72       |
| Mid_Tier_Gamer  | 110       | 118       | 105       | 65       | 70       |
| High_End_Rig    | 144       | 155       | 142       | 62       | 68       |
| Ultra_Build     | 165       | 178       | 160       | 58       | 64       |
| Streamer_Pro    | 120       | 128       | 115       | 66       | 71       |
| Esports_Ready   | 240       | 255       | 238       | 60       | 66       |

### Formulas to Create:

**Column G - Average FPS:**
- Header in G1: `Avg_FPS`
- Formula in G2: `=AVERAGE(B2:D2)`
- Format to 1 decimal place
- Copy down to G7

**Column H - Temperature Status (CPU temp <= 65 is "Good"):**
- Header in H1: `Temp_Status`
- Formula in H2: `=IF(E2<=65,"Good","Warm")`
- Copy down to H7

**Column I - Gaming Tier (Avg FPS >= 120 = "High", else "Standard"):**
- Header in I1: `Gaming_Tier`
- Formula in I2: `=IF(G2>=120,"High","Standard")`
- Copy down to I7

**Summary Statistics:**
- Cell A9: `Highest Avg FPS`
- Cell B9: `=MAX(G2:G7)`
- Cell A10: `Lowest Avg FPS`
- Cell B10: `=MIN(G2:G7)`
- Cell A11: `High Tier Systems`
- Cell B11: `=COUNTIF(I2:I7,"High")`
- Cell A12: `Good Cooling Systems`
- Cell B12: `=COUNTIF(H2:H7,"Good")`

**Formatting:**
- Format all FPS columns to 0 decimal places
- Format temperature columns to 0 decimal places
- Apply conditional formatting to Temp_Status: Green for "Good", Orange for "Warm"

**Chart Exercise:**
Create a **Column Chart** comparing Average FPS:
- Select PC_Build and Avg_FPS columns
- Insert → Column Chart
- Title: "Gaming PC Performance Comparison"
- Add data labels
- Format to show values with 1 decimal place

---

## Quiz Preparation Notes

**Key Calculations to Remember:**
- Total Kills for each player (Problem 1)
- Tournament statistics (MVP count, averages)
- Console sales totals and trends (Problem 2)
- Prize pool calculations (Problem 3)
- PC performance metrics (Problem 4)

**Important Formulas:**
- SUM for totals
- AVERAGE for means
- IF for conditional logic
- MIN/MAX for extremes
- COUNTIF for counting conditions

**Be Prepared to Answer:**
- Specific cell values after formulas
- Summary statistics
- Chart interpretations
- Formatting requirements

---

## MOS Certification Skills Covered

✓ Create and format worksheets
✓ Use SUM, AVERAGE, MIN, MAX functions
✓ Apply IF statements
✓ Use COUNTIF for conditional counting
✓ Format numbers and currency
✓ Create column, bar, and line charts
✓ Apply conditional formatting
✓ Work with cell references

**Next Steps:** Complete all formulas accurately, then take the corresponding quiz to verify your work!
