# Excel Walkthrough 02: Extreme Sports Performance

## Database Applications Development
### Software Engineering | Medina County Career Center

---

## Overview

**Purpose:** Apply Excel skills to extreme sports data analysis and visualization.

**Skills Practiced:**
- Advanced SUM, AVERAGE, MIN, MAX functions
- Complex IF statements
- COUNTIF and conditional counting
- Absolute cell references
- Multi-criteria analysis
- Professional data visualization

**Setup:** Create a new Excel workbook named "Extreme_Sports.xlsx". Each problem is a separate worksheet.

---

## Problem 1: Skateboard Competition Scores

**Instructions:**
1. Create a new worksheet named "Skate_Comp"
2. Copy the data table below into cells A1:F11
3. Complete the formula exercises that follow

**Data Table:**

| Skater_Name  | Run1_Score | Run2_Score | Run3_Score | Best_Trick | Difficulty |
|--------------|------------|------------|------------|------------|------------|
| Tony_Hawk    | 88.5       | 92.0       | 89.5       | 95         | 9.2        |
| Nyjah_Huston | 91.0       | 89.5       | 93.5       | 97         | 9.5        |
| Ryan_Sheckler| 85.0       | 87.5       | 86.0       | 90         | 8.8        |
| Leticia_Bufoni| 89.5      | 91.0       | 90.5       | 93         | 9.0        |
| Shane_O'Neill| 92.5       | 90.0       | 94.0       | 96         | 9.3        |
| Lizzie_Armanto| 86.5      | 88.0       | 87.5       | 91         | 8.9        |
| Yuto_Horigome| 90.0       | 92.5       | 91.5       | 94         | 9.1        |
| Jagger_Eaton | 87.5       | 89.0       | 88.5       | 92         | 8.7        |
| Sky_Brown    | 84.0       | 86.5       | 85.5       | 89         | 8.5        |
| Zion_Wright  | 93.0       | 91.5       | 95.0       | 98         | 9.6        |

### Formulas to Create:

**Column G - Best Run Score:**
- Header in G1: `Best_Run`
- Formula in G2: `=MAX(B2:D2)`
- Format to 1 decimal place
- Copy down to G11

**Column H - Overall Score (Best Run + Best Trick):**
- Header in H1: `Overall_Score`
- Formula in H2: `=G2+E2`
- Format to 1 decimal place
- Copy down to H11

**Column I - Medal Status (Overall >= 185 = "Gold", >= 180 = "Silver", else "Bronze"):**
- Header in I1: `Medal`
- Formula in I2: `=IF(H2>=185,"Gold",IF(H2>=180,"Silver","Bronze"))`
- Copy down to I11

**Summary Statistics (below your data):**
- Cell A13: `Competition Winner`
- Cell B13: `=MAX(H2:H11)`
- Cell A14: `Lowest Overall`
- Cell B14: `=MIN(H2:H11)`
- Cell A15: `Average Overall`
- Cell B15: `=AVERAGE(H2:H11)`
- Format to 1 decimal place
- Cell A16: `Gold Medals`
- Cell B16: `=COUNTIF(I2:I11,"Gold")`
- Cell A17: `Average Difficulty`
- Cell B17: `=AVERAGE(F2:F11)`
- Format to 1 decimal place

**Formatting:**
- Bold headers (row 1)
- Format all score columns to 1 decimal place
- Apply conditional formatting to Medal column: Gold = Gold fill, Silver = Silver fill, Bronze = Bronze fill

**Chart Exercise:**
Create a **Column Chart** showing Overall Scores:
- Select Skater_Name (A1:A11) and Overall_Score (H1:H11)
- Insert → Column Chart
- Title: "Skateboard Competition Overall Scores"
- Add data labels showing values

---

## Problem 2: BMX Bike Stunt Performance

**Instructions:**
1. Create a new worksheet named "BMX_Performance"
2. Copy the data table below into cells A1:E9
3. Complete the formula exercises

**Data Table:**

| Rider_Name   | Backflips | Tailwhips | 360_Spins | No_Handers |
|--------------|-----------|-----------|-----------|------------|
| Mat_Hoffman  | 15        | 22        | 18        | 25         |
| Dave_Mirra   | 18        | 25        | 20        | 28         |
| Ryan_Nyquist | 12        | 19        | 15        | 21         |
| Dennis_Enarson| 20       | 27        | 22        | 30         |
| Chase_Hawk   | 14        | 20        | 17        | 24         |
| Scotty_Cranmer| 16       | 23        | 19        | 26         |
| Kevin_Robinson| 19       | 26        | 21        | 29         |
| Jamie_Bestwick| 17       | 24        | 18        | 27         |

### Formulas to Create:

**Column F - Total Tricks:**
- Header in F1: `Total_Tricks`
- Formula in F2: `=SUM(B2:E2)`
- Copy down to F9

**Column G - Average Tricks Per Type:**
- Header in G1: `Avg_Per_Type`
- Formula in G2: `=AVERAGE(B2:E2)`
- Format to 1 decimal place
- Copy down to G9

**Column H - Pro Status (Total >= 85 = "Pro", >= 75 = "Semi-Pro", else "Amateur"):**
- Header in H1: `Status`
- Formula in H2: `=IF(F2>=85,"Pro",IF(F2>=75,"Semi-Pro","Amateur"))`
- Copy down to H9

**Summary by Trick Type (Row 10):**
- Cell A10: `Total`
- Cell B10: `=SUM(B2:B9)` (Total Backflips)
- Copy across to E10

**Summary Statistics:**
- Cell A12: `Most Total Tricks`
- Cell B12: `=MAX(F2:F9)`
- Cell A13: `Least Total Tricks`
- Cell B13: `=MIN(F2:F9)`
- Cell A14: `Avg Total Tricks`
- Cell B14: `=AVERAGE(F2:F9)`
- Format to 1 decimal place
- Cell A15: `Pro Riders`
- Cell B15: `=COUNTIF(H2:H9,"Pro")`

**Chart Exercise:**
Create a **Stacked Column Chart** showing trick distribution:
- Select entire data range (A1:E9)
- Insert → Stacked Column Chart
- Title: "BMX Trick Distribution by Rider"
- Add legend showing trick types

---

## Problem 3: Surfing Wave Heights and Scores

**Instructions:**
1. Create a new worksheet named "Surf_Comp"
2. Copy the data table below
3. Use absolute references for bonus calculations

**Data Table:**

| Surfer_Name    | Wave1_Height | Wave2_Height | Wave3_Height | Style_Score |
|----------------|--------------|--------------|--------------|-------------|
| Kelly_Slater   | 12.5         | 15.0         | 13.5         | 9.2         |
| John_Florence  | 14.0         | 16.5         | 15.0         | 9.5         |
| Gabriel_Medina | 13.0         | 14.5         | 12.0         | 9.0         |
| Carissa_Moore  | 11.5         | 13.0         | 12.5         | 8.8         |
| Stephanie_Gilmore| 10.5       | 12.0         | 11.0         | 8.5         |
| Italo_Ferreira | 15.5         | 17.0         | 16.0         | 9.3         |
| Tyler_Wright   | 12.0         | 13.5         | 11.5         | 8.7         |
| Filipe_Toledo  | 14.5         | 15.5         | 14.0         | 9.1         |

**Additional Data (above table):**
- Cell G1: `Height_Multiplier`
- Cell H1: `0.5`

### Formulas to Create:

**Column F - Max Wave Height:**
- Header in F1: `Max_Wave`
- Formula in F2: `=MAX(B2:D2)`
- Format to 1 decimal place
- Copy down to F9

**Column G - Height Points (Max Wave × Multiplier):**
- Header in G1: `Height_Points`
- Formula in G2: `=F2*$H$1` (Note the absolute reference to H1)
- Format to 2 decimal places
- Copy down to G9

**Column H - Total Score (Height Points + Style Score × 10):**
- Header in H1: `Total_Score`
- Formula in H2: `=G2+(E2*10)`
- Format to 2 decimal places
- Copy down to H9

**Column I - Competition Rank (Total >= 100 = "Elite", >= 95 = "Advanced", else "Intermediate"):**
- Header in I1: `Rank`
- Formula in I2: `=IF(H2>=100,"Elite",IF(H2>=95,"Advanced","Intermediate"))`
- Copy down to I9

**Summary Statistics:**
- Cell A11: `Highest Total Score`
- Cell B11: `=MAX(H2:H9)`
- Format to 2 decimal places
- Cell A12: `Average Total Score`
- Cell B12: `=AVERAGE(H2:H9)`
- Format to 2 decimal places
- Cell A13: `Elite Surfers`
- Cell B13: `=COUNTIF(I2:I9,"Elite")`
- Cell A14: `Biggest Wave Ridden`
- Cell B14: `=MAX(F2:F9)`
- Format to 1 decimal place

**Chart Exercise:**
Create a **Bar Chart** showing Total Scores:
- Select Surfer_Name and Total_Score columns
- Insert → Bar Chart (horizontal)
- Title: "Surfing Competition Total Scores"
- Format Y-axis to show names clearly

---

## Problem 4: Rock Climbing Speed Records

**Instructions:**
1. Create worksheet named "Climbing_Records"
2. Copy data and create formulas

**Data Table:**

| Climber_Name    | Route_A_Time | Route_B_Time | Route_C_Time | Route_D_Time | Attempts |
|-----------------|--------------|--------------|--------------|--------------|----------|
| Alex_Honnold    | 45.2         | 52.8         | 48.5         | 50.1         | 8        |
| Adam_Ondra      | 42.5         | 49.3         | 46.0         | 47.8         | 7        |
| Tommy_Caldwell  | 47.0         | 54.2         | 50.5         | 52.3         | 9        |
| Chris_Sharma    | 44.8         | 51.5         | 47.8         | 49.6         | 8        |
| Ashima_Shiraishi| 48.5         | 55.8         | 51.2         | 53.0         | 10       |
| Janja_Garnbret  | 43.0         | 50.0         | 46.5         | 48.2         | 7        |
| Shauna_Coxsey   | 49.2         | 56.5         | 52.8         | 54.5         | 11       |
| Tomoa_Narasaki  | 41.8         | 48.5         | 45.2         | 47.0         | 6        |

### Formulas to Create:

**Column G - Best Time (Fastest/Lowest):**
- Header in G1: `Best_Time`
- Formula in G2: `=MIN(B2:E2)`
- Format to 1 decimal place
- Copy down to G9

**Column H - Average Time:**
- Header in H1: `Avg_Time`
- Formula in H2: `=AVERAGE(B2:E2)`
- Format to 1 decimal place
- Copy down to H9

**Column I - Efficiency Rating (Best Time / Attempts):**
- Header in I1: `Efficiency`
- Formula in I2: `=G2/F2`
- Format to 2 decimal places
- Copy down to I9

**Column J - Record Status (Best Time <= 45 = "Record", <= 48 = "Excellent", else "Good"):**
- Header in J1: `Status`
- Formula in J2: `=IF(G2<=45,"Record",IF(G2<=48,"Excellent","Good"))`
- Copy down to J9

**Summary Statistics:**
- Cell A11: `Fastest Climb`
- Cell B11: `=MIN(G2:G9)`
- Format to 1 decimal place
- Cell A12: `Slowest Best Time`
- Cell B12: `=MAX(G2:G9)`
- Format to 1 decimal place
- Cell A13: `Average Best Time`
- Cell B13: `=AVERAGE(G2:G9)`
- Format to 1 decimal place
- Cell A14: `Record Holders`
- Cell B14: `=COUNTIF(J2:J9,"Record")`
- Cell A15: `Total Attempts`
- Cell B15: `=SUM(F2:F9)`

**Formatting:**
- Format all time columns to 1 decimal place
- Format Efficiency to 2 decimal places
- Apply conditional formatting: Record = Green, Excellent = Yellow, Good = Orange

**Chart Exercise:**
Create a **Scatter Plot** showing Time vs Attempts:
- Select Attempts (F2:F9) as X values and Best_Time (G2:G9) as Y values
- Insert → Scatter Plot
- Title: "Climbing Time vs Number of Attempts"
- Add trendline to show relationship

---

## Advanced Challenge: Multi-Sport Athlete Analysis

**Create a summary worksheet that:**
1. Identifies top performers from each sport
2. Calculates cross-sport performance metrics
3. Creates a dashboard with multiple chart types
4. Uses advanced conditional formatting

**Skills to demonstrate:**
- Multiple IF statements (nested)
- Absolute and relative references
- COUNTIF with multiple criteria
- Professional chart formatting
- Color-coded performance tiers

---

## Quiz Preparation Checklist

**Problem 1 - Skateboarding:**
- [ ] Calculate Best Run for each skater
- [ ] Determine Overall Scores
- [ ] Identify medal winners
- [ ] Calculate competition statistics

**Problem 2 - BMX:**
- [ ] Sum total tricks for each rider
- [ ] Calculate averages per trick type
- [ ] Determine pro status rankings
- [ ] Analyze trick distribution

**Problem 3 - Surfing:**
- [ ] Find maximum wave heights
- [ ] Calculate height points (with absolute reference!)
- [ ] Determine total scores
- [ ] Identify elite surfers

**Problem 4 - Climbing:**
- [ ] Find best times for each climber
- [ ] Calculate efficiency ratings
- [ ] Determine record holders
- [ ] Analyze time-to-attempts relationship

---

## MOS Certification Skills Covered

✓ Complex IF statements (nested conditions)
✓ MIN/MAX functions for finding extremes
✓ Absolute cell references ($)
✓ COUNTIF with text criteria
✓ Multiple chart types (column, bar, scatter, stacked)
✓ Conditional formatting with multiple conditions
✓ Number formatting (decimals, consistency)
✓ Professional data visualization

**Complete all problems, then take Quiz 02 to verify your calculations!**
