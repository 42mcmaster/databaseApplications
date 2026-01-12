# Excel Walkthrough 03: Wildlife & Apex Predators

## Database Applications Development
### Software Engineering | Medina County Career Center

---

## Overview

**Purpose:** Apply Excel data analysis skills to wildlife and predator statistics.

**Skills Practiced:**
- Statistical functions (SUM, AVERAGE, MIN, MAX, COUNT)
- Advanced conditional logic (nested IF statements)
- Mathematical calculations and ratios
- Data comparison and ranking
- Scientific data visualization

**Setup:** Create a new Excel workbook named "Wildlife_Data.xlsx". Each problem is a separate worksheet.

---

## Problem 1: Apex Predator Statistics

**Instructions:**
1. Create a new worksheet named "Apex_Predators"
2. Copy the data table below into cells A1:F11
3. Complete the formula exercises that follow

**Data Table:**

| Species          | Max_Speed_mph | Weight_lbs | Hunt_Success_% | Bite_Force_psi | Pack_Size |
|------------------|---------------|------------|----------------|----------------|-----------|
| African_Lion     | 50            | 420        | 25             | 650            | 15        |
| Bengal_Tiger     | 40            | 550        | 52             | 1050           | 1         |
| Grizzly_Bear     | 35            | 790        | 38             | 1160           | 1         |
| Gray_Wolf        | 40            | 95         | 14             | 400            | 8         |
| Saltwater_Croc   | 18            | 2200       | 75             | 3700           | 1         |
| Great_White      | 35            | 4400       | 55             | 4000           | 1         |
| Jaguar           | 50            | 250        | 85             | 2000           | 1         |
| Polar_Bear       | 25            | 1500       | 49             | 1200           | 1         |
| Orca             | 35            | 12000      | 90             | 19000          | 6         |
| Komodo_Dragon    | 13            | 200        | 60             | 1000           | 1         |

### Formulas to Create:

**Column G - Power Rating (Weight × Bite Force / 1000):**
- Header in G1: `Power_Rating`
- Formula in G2: `=B2*E2/1000`
- Format to 0 decimal places
- Copy down to G11

**Column H - Hunting Efficiency (Hunt Success % × Max Speed):**
- Header in H1: `Hunt_Efficiency`
- Formula in H2: `=D2*A2`
- Format to 0 decimal places
- Copy down to H11

**Column I - Threat Level (Hunt Success >= 70 = "Extreme", >= 50 = "High", >= 30 = "Moderate", else "Low"):**
- Header in I1: `Threat_Level`
- Formula in I2: `=IF(D2>=70,"Extreme",IF(D2>=50,"High",IF(D2>=30,"Moderate","Low")))`
- Copy down to I11

**Summary Statistics (below your data):**
- Cell A13: `Heaviest Predator`
- Cell B13: `=MAX(B2:B11)`
- Cell A14: `Fastest Predator`
- Cell B14: `=MAX(A2:A11)`
- Cell A15: `Strongest Bite`
- Cell B15: `=MAX(E2:E11)`
- Cell A16: `Avg Hunt Success`
- Cell B16: `=AVERAGE(D2:D11)`
- Format to 1 decimal place
- Cell A17: `Extreme Threats`
- Cell B17: `=COUNTIF(I2:I11,"Extreme")`
- Cell A18: `Avg Power Rating`
- Cell B18: `=AVERAGE(G2:G11)`
- Format to 0 decimal places

**Formatting:**
- Bold headers (row 1)
- Format Hunt_Success_% with % symbol
- Apply conditional formatting to Threat_Level: 
  - Extreme = Dark Red
  - High = Orange
  - Moderate = Yellow
  - Low = Green

**Chart Exercise:**
Create a **Scatter Plot** showing Speed vs Hunt Success:
- X-axis: Max_Speed_mph (A2:A11)
- Y-axis: Hunt_Success_% (D2:D11)
- Insert → Scatter Plot
- Title: "Predator Speed vs Hunting Success Rate"
- Add trendline

---

## Problem 2: Endangered Species Population Tracking

**Instructions:**
1. Create a new worksheet named "Endangered_Species"
2. Copy the data table below into cells A1:E9
3. Complete the formula exercises

**Data Table:**

| Species           | Year_2020 | Year_2021 | Year_2022 | Year_2023 |
|-------------------|-----------|-----------|-----------|-----------|
| Mountain_Gorilla  | 1063      | 1095      | 1128      | 1160      |
| Giant_Panda       | 1864      | 1920      | 1975      | 2030      |
| Snow_Leopard      | 4080      | 4120      | 4165      | 4210      |
| Black_Rhino       | 5630      | 5690      | 5755      | 5820      |
| Amur_Leopard      | 103       | 110       | 118       | 126       |
| Vaquita_Porpoise  | 10        | 9         | 8         | 8         |
| Javan_Rhino       | 68        | 72        | 74        | 76        |
| Sumatran_Tiger    | 400       | 415       | 428       | 441       |

### Formulas to Create:

**Column F - Total Change (2023 - 2020):**
- Header in F1: `Total_Change`
- Formula in F2: `=E2-B2`
- Copy down to F9

**Column G - Percent Change ((2023-2020)/2020 × 100):**
- Header in G1: `Percent_Change`
- Formula in G2: `=(E2-B2)/B2*100`
- Format to 2 decimal places
- Copy down to G9

**Column H - Average Population (all years):**
- Header in H1: `Avg_Population`
- Formula in H2: `=AVERAGE(B2:E2)`
- Format to 0 decimal places
- Copy down to H9

**Column I - Status (Population 2023 >= 1000 = "Stable", >= 100 = "Critical", else "Severely Endangered"):**
- Header in I1: `Conservation_Status`
- Formula in I2: `=IF(E2>=1000,"Stable",IF(E2>=100,"Critical","Severely Endangered"))`
- Copy down to I9

**Summary Statistics:**
- Cell A11: `Largest Population`
- Cell B11: `=MAX(E2:E9)`
- Cell A12: `Smallest Population`
- Cell B12: `=MIN(E2:E9)`
- Cell A13: `Total 2023 Population`
- Cell B13: `=SUM(E2:E9)`
- Cell A14: `Avg Percent Change`
- Cell B14: `=AVERAGE(G2:G9)`
- Format to 2 decimal places
- Cell A15: `Severely Endangered Count`
- Cell B15: `=COUNTIF(I2:I9,"Severely Endangered")`

**Chart Exercise:**
Create a **Line Chart** showing population trends:
- Select entire data range (A1:E9)
- Insert → Line Chart with markers
- Title: "Endangered Species Population Trends (2020-2023)"
- Add legend
- Label Y-axis as "Population"

---

## Problem 3: Venomous Snake Danger Assessment

**Instructions:**
1. Create a new worksheet named "Venomous_Snakes"
2. Copy the data table below
3. Use formulas to calculate danger scores

**Data Table:**

| Snake_Species      | Length_ft | Venom_LD50_mg | Aggressiveness | Strike_Speed_mph | Habitat_Proximity |
|--------------------|-----------|---------------|----------------|------------------|-------------------|
| Inland_Taipan      | 6.0       | 0.025         | 3              | 8.7              | 2                 |
| Eastern_Brown      | 7.0       | 0.053         | 9              | 12.4             | 8                 |
| Black_Mamba        | 14.0      | 0.280         | 10             | 12.5             | 7                 |
| King_Cobra         | 18.0      | 1.500         | 8              | 10.2             | 6                 |
| Coastal_Taipan     | 6.5       | 0.106         | 7              | 9.1              | 5                 |
| Tiger_Snake        | 4.5       | 0.038         | 6              | 8.9              | 7                 |
| Gaboon_Viper       | 6.0       | 5.000         | 2              | 6.5              | 3                 |
| Saw_Scaled_Viper   | 2.5       | 2.300         | 9              | 7.8              | 9                 |

**Additional Data (above table):**
- Cell H1: `Danger_Multiplier`
- Cell I1: `10`

### Formulas to Create:

**Column G - Lethality Score (1000 / Venom_LD50):**
- Header in G1: `Lethality_Score`
- Formula in G2: `=1000/C2`
- Format to 0 decimal places
- Copy down to G9
- Note: Lower LD50 = more toxic = higher lethality score

**Column H - Threat Score (Aggressiveness × Strike Speed):**
- Header in H1: `Threat_Score`
- Formula in H2: `=D2*E2`
- Format to 1 decimal place
- Copy down to H9

**Column I - Danger Index ((Lethality × Habitat) / Multiplier):**
- Header in I1: `Danger_Index`
- Formula in I2: `=(G2*F2)/$I$1` (Note absolute reference)
- Format to 0 decimal places
- Copy down to I9

**Column J - Risk Category (Danger Index >= 5000 = "Extreme Risk", >= 2000 = "High Risk", >= 500 = "Moderate Risk", else "Low Risk"):**
- Header in J1: `Risk_Category`
- Formula in J2: `=IF(I2>=5000,"Extreme Risk",IF(I2>=2000,"High Risk",IF(I2>=500,"Moderate Risk","Low Risk")))`
- Copy down to J9

**Summary Statistics:**
- Cell A11: `Most Lethal`
- Cell B11: `=MAX(G2:G9)`
- Format to 0 decimal places
- Cell A12: `Highest Threat Score`
- Cell B12: `=MAX(H2:H9)`
- Format to 1 decimal place
- Cell A13: `Avg Danger Index`
- Cell B13: `=AVERAGE(I2:I9)`
- Format to 0 decimal places
- Cell A14: `Extreme Risk Snakes`
- Cell B14: `=COUNTIF(J2:J9,"Extreme Risk")`

**Chart Exercise:**
Create a **Bar Chart** showing Danger Index:
- Select Snake_Species and Danger_Index columns
- Insert → Bar Chart (horizontal)
- Title: "Venomous Snake Danger Index Comparison"
- Color bars by Risk Category

---

## Problem 4: Marine Predator Dive Depths

**Instructions:**
1. Create worksheet named "Marine_Predators"
2. Copy data and create formulas

**Data Table:**

| Marine_Species   | Max_Dive_ft | Avg_Dive_ft | Dive_Duration_min | Dives_Per_Day | Body_Weight_lbs |
|------------------|-------------|-------------|-------------------|---------------|-----------------|
| Sperm_Whale      | 7380        | 3280        | 90                | 6             | 90000           |
| Elephant_Seal    | 7835        | 2133        | 120               | 8             | 8800            |
| Leatherback_Turtle| 4200       | 1640        | 86                | 12            | 2000            |
| Orca             | 3280        | 328         | 15                | 25            | 12000           |
| Great_White      | 3900        | 820         | 22                | 18            | 4400            |
| Blue_Whale       | 1640        | 492         | 33                | 10            | 300000          |
| Humpback_Whale   | 600         | 230         | 30                | 12            | 66000           |

### Formulas to Create:

**Column G - Dive Range (Max Dive - Avg Dive):**
- Header in G1: `Dive_Range`
- Formula in G2: `=B2-C2`
- Format to 0 decimal places
- Copy down to G8

**Column H - Daily Dive Time (Duration × Dives Per Day):**
- Header in H1: `Daily_Dive_Time`
- Formula in H2: `=D2*E2`
- Format to 0 decimal places
- Copy down to G8

**Column I - Depth per Pound (Max Dive / Weight):**
- Header in I1: `Depth_Per_Pound`
- Formula in I2: `=B2/F2`
- Format to 4 decimal places
- Copy down to I8

**Column J - Dive Category (Max Dive >= 5000 = "Deep Diver", >= 2000 = "Moderate Diver", else "Shallow Diver"):**
- Header in J1: `Dive_Category`
- Formula in J2: `=IF(B2>=5000,"Deep Diver",IF(B2>=2000,"Moderate Diver","Shallow Diver"))`
- Copy down to J8

**Summary Statistics:**
- Cell A10: `Deepest Diver`
- Cell B10: `=MAX(B2:B8)`
- Cell A11: `Longest Single Dive`
- Cell B11: `=MAX(D2:D8)`
- Cell A12: `Most Daily Dives`
- Cell B12: `=MAX(E2:E8)`
- Cell A13: `Avg Daily Dive Time`
- Cell B13: `=AVERAGE(H2:H8)`
- Format to 1 decimal place
- Cell A14: `Deep Divers`
- Cell B14: `=COUNTIF(J2:J8,"Deep Diver")`
- Cell A15: `Heaviest Predator`
- Cell B15: `=MAX(F2:F8)`

**Formatting:**
- Format dive depths with comma separator (7,380)
- Format weights with comma separator (90,000)
- Apply conditional formatting to Dive_Category

**Chart Exercise:**
Create a **Column Chart** comparing Max Dive Depths:
- Select Marine_Species and Max_Dive_ft columns
- Insert → Column Chart
- Title: "Maximum Dive Depths by Marine Species"
- Format Y-axis with comma separator
- Add data labels

---

## Advanced Analysis Challenge

**Create a "Wildlife Champions" summary worksheet that:**
1. Identifies the #1 performer in each category across all worksheets
2. Creates formulas that reference data from multiple sheets
3. Builds a comprehensive dashboard with summary statistics
4. Uses nested IF statements for complex categorization

**Example multi-sheet formula:**
```
=MAX(Apex_Predators!A2:A11)
```

---

## Quiz Preparation Checklist

**Problem 1 - Apex Predators:**
- [ ] Calculate Power Ratings for each predator
- [ ] Determine Hunting Efficiency scores
- [ ] Classify Threat Levels
- [ ] Identify statistical extremes (max, min, averages)

**Problem 2 - Endangered Species:**
- [ ] Calculate population changes
- [ ] Determine percent changes
- [ ] Classify conservation status
- [ ] Analyze population trends

**Problem 3 - Venomous Snakes:**
- [ ] Calculate Lethality Scores (inverse relationship!)
- [ ] Determine Threat Scores
- [ ] Calculate Danger Index (with absolute reference!)
- [ ] Classify Risk Categories

**Problem 4 - Marine Predators:**
- [ ] Calculate dive ranges
- [ ] Determine daily dive times
- [ ] Calculate efficiency ratios
- [ ] Classify dive categories

---

## MOS Certification Skills Covered

✓ Complex mathematical formulas (ratios, percentages)
✓ Nested IF statements (3+ levels)
✓ Absolute and relative references
✓ Statistical functions (MAX, MIN, AVERAGE, COUNT, COUNTIF)
✓ Number formatting (decimals, percentages, commas)
✓ Multiple chart types (scatter, line, bar, column)
✓ Conditional formatting with multiple conditions
✓ Multi-sheet formulas (advanced)

**Complete all calculations accurately, then take Quiz 03 to verify your work!**
