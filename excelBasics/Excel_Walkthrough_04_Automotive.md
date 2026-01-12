# Excel Walkthrough 04: Automotive Performance & Racing

## Database Applications Development
### Software Engineering | Medina County Career Center

---

## Overview

**Purpose:** Master Excel data analysis using car performance and racing statistics.

**Skills Practiced:**
- Complex calculations and unit conversions
- Performance metrics and ratios
- Multi-level conditional logic
- Statistical analysis
- Professional automotive data visualization

**Setup:** Create a new Excel workbook named "Auto_Performance.xlsx". Each problem is a separate worksheet.

---

## Problem 1: Sports Car Performance Specifications

**Instructions:**
1. Create a new worksheet named "Sports_Cars"
2. Copy the data table below into cells A1:F11
3. Complete the formula exercises that follow

**Data Table:**

| Car_Model           | Zero_to_60_sec | Top_Speed_mph | Horsepower | Weight_lbs | Price_USD |
|---------------------|----------------|---------------|------------|------------|-----------|
| Porsche_911_Turbo   | 2.6            | 205           | 640        | 3640       | 175000    |
| Ferrari_488_GTB     | 3.0            | 205           | 661        | 3252       | 252000    |
| Lamborghini_Huracan | 2.5            | 202           | 631        | 3135       | 210000    |
| McLaren_720S        | 2.8            | 212           | 710        | 2828       | 285000    |
| Corvette_Z06        | 2.95           | 198           | 670        | 3560       | 85000     |
| Audi_R8_V10        | 3.2            | 205           | 602        | 3516       | 170000    |
| Nissan_GT-R        | 2.7            | 196           | 565        | 3865       | 115000    |
| BMW_M5_Competition | 3.1            | 189           | 617        | 4370       | 110000    |
| Mercedes_AMG_GT    | 3.5            | 198           | 523        | 3594       | 118000    |
| Dodge_Viper        | 3.4            | 206           | 645        | 3354       | 95000     |

### Formulas to Create:

**Column G - Power to Weight Ratio (HP / Weight × 1000):**
- Header in G1: `Power_to_Weight`
- Formula in G2: `=D2/E2*1000`
- Format to 2 decimal places
- Copy down to G11

**Column H - Performance Score (Top Speed / Zero to 60):**
- Header in H1: `Performance_Score`
- Formula in H2: `=C2/B2`
- Format to 2 decimal places
- Copy down to H11

**Column I - Value Rating (Horsepower / Price × 10000):**
- Header in I1: `Value_Rating`
- Formula in I2: `=D2/F2*10000`
- Format to 2 decimal places
- Copy down to I11

**Column J - Performance Class (Performance Score >= 75 = "Elite", >= 65 = "High Performance", >= 55 = "Performance", else "Sport"):**
- Header in J1: `Performance_Class`
- Formula in J2: `=IF(H2>=75,"Elite",IF(H2>=65,"High Performance",IF(H2>=55,"Performance","Sport")))`
- Copy down to J11

**Summary Statistics (below your data):**
- Cell A13: `Fastest Car`
- Cell B13: `=MAX(C2:C11)`
- Cell A14: `Most Powerful`
- Cell B14: `=MAX(D2:D11)`
- Cell A15: `Best Power to Weight`
- Cell B15: `=MAX(G2:G11)`
- Format to 2 decimal places
- Cell A16: `Avg Performance Score`
- Cell B16: `=AVERAGE(H2:H11)`
- Format to 2 decimal places
- Cell A17: `Elite Class Count`
- Cell B17: `=COUNTIF(J2:J11,"Elite")`
- Cell A18: `Avg Price`
- Cell B18: `=AVERAGE(F2:F11)`
- Format as currency

**Formatting:**
- Format Price as currency with $ symbol
- Format all ratio columns to 2 decimal places
- Apply conditional formatting to Performance_Class:
  - Elite = Gold
  - High Performance = Silver
  - Performance = Bronze
  - Sport = White

**Chart Exercise:**
Create a **Scatter Plot** showing Horsepower vs 0-60 Time:
- X-axis: Horsepower (D2:D11)
- Y-axis: Zero_to_60_sec (B2:B11)
- Insert → Scatter Plot
- Title: "Acceleration vs Horsepower"
- Add trendline
- Note: Lower 0-60 time = better acceleration

---

## Problem 2: NASCAR Race Results

**Instructions:**
1. Create a new worksheet named "NASCAR_Race"
2. Copy the data table below into cells A1:F16
3. Complete the formula exercises

**Data Table:**

| Driver_Name      | Laps_Led | Position_Finish | Points_Earned | Bonus_Points | Penalties |
|------------------|----------|-----------------|---------------|--------------|-----------|
| Chase_Elliott    | 87       | 1               | 40            | 5            | 0         |
| Kyle_Larson      | 52       | 2               | 35            | 3            | 0         |
| Denny_Hamlin     | 34       | 3               | 34            | 2            | 0         |
| Martin_Truex     | 18       | 4               | 33            | 1            | 0         |
| Kevin_Harvick    | 9        | 5               | 32            | 0            | 0         |
| Kyle_Busch       | 0        | 6               | 31            | 0            | 0         |
| Joey_Logano      | 15       | 7               | 30            | 1            | 0         |
| Brad_Keselowski  | 0        | 8               | 29            | 0            | 0         |
| Ryan_Blaney      | 23       | 9               | 28            | 1            | 5         |
| William_Byron    | 0        | 10              | 27            | 0            | 0         |
| Alex_Bowman      | 0        | 11              | 26            | 0            | 0         |
| Tyler_Reddick    | 12       | 12              | 25            | 1            | 0         |
| Christopher_Bell | 0        | 13              | 24            | 0            | 3         |
| Ross_Chastain    | 0        | 14              | 23            | 0            | 0         |
| Bubba_Wallace    | 0        | 15              | 22            | 0            | 0         |

### Formulas to Create:

**Column G - Total Points (Points Earned + Bonus Points - Penalties):**
- Header in G1: `Total_Points`
- Formula in G2: `=D2+E2-F2`
- Copy down to G16

**Column H - Led Most Laps Bonus (Laps Led >= 30 = 5 bonus, >= 15 = 3 bonus, >= 10 = 1 bonus, else 0):**
- Header in H1: `Laps_Bonus`
- Formula in H2: `=IF(B2>=30,5,IF(B2>=15,3,IF(B2>=10,1,0)))`
- Copy down to H16

**Column I - Final Score (Total Points + Laps Bonus):**
- Header in I1: `Final_Score`
- Formula in I2: `=G2+H2`
- Copy down to I16

**Column J - Championship Standing (Final Score >= 45 = "Title Contender", >= 35 = "Playoff Position", >= 25 = "Bubble", else "Outside"):**
- Header in J1: `Standing`
- Formula in J2: `=IF(I2>=45,"Title Contender",IF(I2>=35,"Playoff Position",IF(I2>=25,"Bubble","Outside")))`
- Copy down to J16

**Summary Statistics:**
- Cell A18: `Race Winner Points`
- Cell B18: `=MAX(I2:I16)`
- Cell A19: `Total Laps Led`
- Cell B19: `=SUM(B2:B16)`
- Cell A20: `Avg Final Score`
- Cell B20: `=AVERAGE(I2:I16)`
- Format to 1 decimal place
- Cell A21: `Title Contenders`
- Cell B21: `=COUNTIF(J2:J16,"Title Contender")`
- Cell A22: `Drivers Penalized`
- Cell B22: `=COUNTIF(F2:F16,">0")`

**Chart Exercise:**
Create a **Column Chart** showing Final Scores:
- Select Driver_Name (A1:A16) and Final_Score (I1:I16)
- Insert → Column Chart
- Title: "NASCAR Race Final Scores"
- Add data labels
- Color bars by Standing category

---

## Problem 3: Drag Racing Quarter Mile Times

**Instructions:**
1. Create a new worksheet named "Drag_Racing"
2. Copy the data table below
3. Use formulas to calculate performance metrics

**Data Table:**

| Racer_Name       | Quarter_Mile_sec | Trap_Speed_mph | Reaction_Time | Engine_HP | Modifications_USD |
|------------------|------------------|----------------|---------------|-----------|-------------------|
| Speed_Demon      | 8.92             | 156.3          | 0.045         | 1250      | 75000             |
| Thunder_Road     | 9.15             | 152.8          | 0.038         | 1180      | 68000             |
| Nitro_Express    | 8.67             | 161.2          | 0.052         | 1420      | 95000             |
| Velocity_King    | 9.34             | 148.9          | 0.041         | 1095      | 62000             |
| Turbo_Beast      | 8.88             | 157.6          | 0.049         | 1310      | 82000             |
| Rocket_Runner    | 9.05             | 154.1          | 0.036         | 1205      | 71000             |
| Lightning_Bolt   | 8.71             | 159.8          | 0.044         | 1385      | 88000             |
| Storm_Chaser     | 9.28             | 150.2          | 0.047         | 1125      | 65000             |

**Additional Data (above table):**
- Cell H1: `Speed_Multiplier`
- Cell I1: `0.5`

### Formulas to Create:

**Column G - Total Time (Quarter Mile + Reaction Time):**
- Header in G1: `Total_Time`
- Formula in G2: `=B2+D2`
- Format to 3 decimal places
- Copy down to G9

**Column H - Speed Index (Trap Speed × Multiplier):**
- Header in H1: `Speed_Index`
- Formula in H2: `=C2*$I$1` (Note absolute reference)
- Format to 2 decimal places
- Copy down to H9

**Column I - Horsepower per Dollar (HP / Modifications × 100):**
- Header in I1: `HP_per_Dollar`
- Formula in I2: `=E2/F2*100`
- Format to 3 decimal places
- Copy down to I9

**Column J - Performance Tier (Quarter Mile <= 8.75 = "Pro", <= 9.00 = "Advanced", <= 9.25 = "Intermediate", else "Novice"):**
- Header in J1: `Performance_Tier`
- Formula in J2: `=IF(B2<=8.75,"Pro",IF(B2<=9.00,"Advanced",IF(B2<=9.25,"Intermediate","Novice")))`
- Copy down to J9

**Summary Statistics:**
- Cell A11: `Fastest Quarter Mile`
- Cell B11: `=MIN(B2:B9)` (Lower is faster!)
- Format to 2 decimal places
- Cell A12: `Highest Trap Speed`
- Cell B12: `=MAX(C2:C9)`
- Format to 1 decimal place
- Cell A13: `Best Reaction Time`
- Cell B13: `=MIN(D2:D9)` (Lower is better!)
- Format to 3 decimal places
- Cell A14: `Avg Total Time`
- Cell B14: `=AVERAGE(G2:G9)`
- Format to 3 decimal places
- Cell A15: `Pro Tier Racers`
- Cell B15: `=COUNTIF(J2:J9,"Pro")`

**Chart Exercise:**
Create a **Bar Chart** showing Total Time by Racer:
- Select Racer_Name and Total_Time columns
- Insert → Bar Chart (horizontal)
- Title: "Drag Racing Total Times (Lower is Better)"
- Sort bars from lowest to highest time

---

## Problem 4: Formula 1 Season Standings

**Instructions:**
1. Create worksheet named "F1_Standings"
2. Copy data and create championship formulas

**Data Table:**

| Driver_Name       | Races_Won | Podiums | Fastest_Laps | DNF_Count | Points_Current |
|-------------------|-----------|---------|--------------|-----------|----------------|
| Max_Verstappen    | 15        | 19      | 8            | 1         | 454            |
| Sergio_Perez      | 2         | 13      | 3            | 2         | 285            |
| Lewis_Hamilton    | 1         | 10      | 5            | 3         | 240            |
| Fernando_Alonso   | 0         | 8       | 1            | 2         | 200            |
| Carlos_Sainz      | 1         | 7       | 2            | 4         | 175            |
| Charles_Leclerc   | 0         | 6       | 4            | 5         | 165            |
| George_Russell    | 0         | 5       | 1            | 3         | 150            |
| Lando_Norris      | 0         | 4       | 0            | 2         | 115            |
| Oscar_Piastri     | 0         | 3       | 0            | 1         | 95             |
| Pierre_Gasly      | 0         | 2       | 0            | 4         | 72             |

### Formulas to Create:

**Column G - Win Bonus (Races Won × 25):**
- Header in G1: `Win_Bonus`
- Formula in G2: `=B2*25`
- Copy down to G11

**Column H - Consistency Rating (Podiums - DNF Count):**
- Header in H1: `Consistency`
- Formula in H2: `=C2-E2`
- Copy down to G11

**Column I - Championship Points (Points Current + Win Bonus):**
- Header in I1: `Championship_Pts`
- Formula in I2: `=F2+G2`
- Copy down to I11

**Column J - Title Status (Championship Pts >= 650 = "Champion Favorite", >= 450 = "Contender", >= 250 = "Competitive", else "Mid-Pack"):**
- Header in J1: `Title_Status`
- Formula in J2: `=IF(I2>=650,"Champion Favorite",IF(I2>=450,"Contender",IF(I2>=250,"Competitive","Mid-Pack")))`
- Copy down to J11

**Summary Statistics:**
- Cell A13: `Championship Leader Pts`
- Cell B13: `=MAX(I2:I11)`
- Cell A14: `Total Race Wins`
- Cell B14: `=SUM(B2:B11)`
- Cell A15: `Avg Points Per Driver`
- Cell B15: `=AVERAGE(F2:F11)`
- Format to 1 decimal place
- Cell A16: `Champion Favorites`
- Cell B16: `=COUNTIF(J2:J11,"Champion Favorite")`
- Cell A17: `Most Consistent`
- Cell B17: `=MAX(H2:H11)`
- Cell A18: `Total DNFs`
- Cell B18: `=SUM(E2:E11)`

**Formatting:**
- Format all points columns with comma separator
- Apply conditional formatting to Title_Status:
  - Champion Favorite = Gold fill
  - Contender = Silver fill
  - Competitive = Bronze fill
  - Mid-Pack = White fill

**Chart Exercise:**
Create a **Column Chart** showing Championship Points:
- Select Driver_Name and Championship_Pts columns
- Insert → Column Chart
- Title: "F1 Championship Standings"
- Add data labels
- Sort from highest to lowest

---

## Advanced Challenge: Auto Performance Dashboard

**Create a multi-sheet analysis that:**
1. Finds the fastest vehicle across all categories
2. Calculates cost-per-performance metrics
3. Identifies best value vehicles
4. Creates comparative visualizations
5. Uses multi-sheet formulas like `=MAX(Sports_Cars!B2:B11)`

**Example Advanced Formula:**
```
=IF(Sports_Cars!B2<Drag_Racing!B2,"Sports Car Faster","Drag Racer Faster")
```

---

## Quiz Preparation Checklist

**Problem 1 - Sports Cars:**
- [ ] Calculate Power to Weight ratios
- [ ] Determine Performance Scores
- [ ] Calculate Value Ratings
- [ ] Classify Performance Classes
- [ ] Identify fastest/most powerful cars

**Problem 2 - NASCAR:**
- [ ] Calculate Total Points (with penalties)
- [ ] Determine Laps Bonuses (nested IF!)
- [ ] Calculate Final Scores
- [ ] Classify Championship Standings
- [ ] Count Title Contenders

**Problem 3 - Drag Racing:**
- [ ] Calculate Total Times
- [ ] Calculate Speed Index (absolute reference!)
- [ ] Determine HP per Dollar efficiency
- [ ] Classify Performance Tiers
- [ ] Identify fastest times (MIN function!)

**Problem 4 - Formula 1:**
- [ ] Calculate Win Bonuses
- [ ] Determine Consistency Ratings
- [ ] Calculate Championship Points
- [ ] Classify Title Status
- [ ] Analyze season statistics

---

## MOS Certification Skills Covered

✓ Complex ratio calculations
✓ Multi-level nested IF statements (4+ levels)
✓ Absolute and relative references ($)
✓ MIN and MAX for finding extremes
✓ Statistical analysis (SUM, AVERAGE, COUNT, COUNTIF)
✓ Currency and decimal formatting
✓ Multiple chart types (scatter, column, bar)
✓ Conditional formatting with color schemes
✓ Multi-sheet formulas (advanced)

**Complete all calculations, verify accuracy, then take Quiz 04!**
