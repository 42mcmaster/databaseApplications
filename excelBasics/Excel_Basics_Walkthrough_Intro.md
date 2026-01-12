# Excel Basics: Formulas and Visualization Walkthrough Introduction

## Database Applications Development
### Software Engineering | Medina County Career Center

---

## Overview

**Purpose:** Learn essential Excel skills for data analysis and presentation.

**What you'll practice:**
- Basic formulas (SUM, AVERAGE, MIN, MAX, COUNT, COUNTIF)
- Conditional logic (IF statements)
- Cell references (relative vs absolute)
- Creating professional charts
- Formatting for readability

**Setup:** Create a new Excel workbook. Each problem below will be a separate worksheet.

---

## Problem 1: Student Grades Analysis

**Instructions:**
1. Create a new worksheet named "Student_Grades"
2. Copy the data table below into cells A1:D11
3. Complete the formula exercises that follow

**Data Table:**

| Student_Name | Quiz1 | Quiz2 | Quiz3 |
|--------------|-------|-------|-------|
| Alice        | 85    | 92    | 88    |
| Bob          | 78    | 85    | 90    |
| Charlie      | 92    | 88    | 95    |
| Diana        | 88    | 91    | 87    |
| Ethan        | 75    | 80    | 78    |
| Fiona        | 95    | 98    | 93    |
| George       | 82    | 85    | 88    |
| Hannah       | 90    | 87    | 92    |
| Isaac        | 88    | 85    | 90    |
| Julia        | 91    | 94    | 89    |

### Formulas to Create:

**Column E - Average Score:**
- Header in E1: `Average`
- Formula in E2: `=AVERAGE(B2:D2)`
- Copy down to E11

**Column F - Pass/Fail (passing is 85+):**
- Header in F1: `Status`
- Formula in F2: `=IF(E2>=85,"Pass","Fail")`
- Copy down to F11

**Summary Statistics (in cells below your data):**
- Cell A13: `Class Average`
- Cell B13: `=AVERAGE(E2:E11)`
- Cell A14: `Highest Average`
- Cell B14: `=MAX(E2:E11)`
- Cell A15: `Lowest Average`
- Cell B15: `=MIN(E2:E11)`
- Cell A16: `Students Passing`
- Cell B16: `=COUNTIF(F2:F11,"Pass")`

**Formatting:**
- Make headers (row 1) bold
- Format average columns to 1 decimal place
- Apply conditional formatting to Status column: Green for "Pass", Red for "Fail"

---

## Problem 2: Monthly Sales Data

**Instructions:**
1. Create a new worksheet named "Sales_Data"
2. Copy the data table below into cells A1:E7
3. Complete the formula exercises that follow

**Data Table:**

| Month    | Product_A | Product_B | Product_C | Product_D |
|----------|-----------|-----------|-----------|-----------|
| January  | 2500      | 3200      | 1800      | 2900      |
| February | 2800      | 3500      | 2100      | 3200      |
| March    | 3100      | 3800      | 2400      | 3500      |
| April    | 2900      | 3600      | 2200      | 3300      |
| May      | 3300      | 4000      | 2600      | 3700      |
| June     | 3500      | 4200      | 2800      | 3900      |

### Formulas to Create:

**Column F - Monthly Total:**
- Header in F1: `Monthly_Total`
- Formula in F2: `=SUM(B2:E2)`
- Copy down to F7

**Row 8 - Product Totals:**
- Cell A8: `Product Total`
- Cell B8: `=SUM(B2:B7)`
- Copy across to E8

**Grand Total:**
- Cell F8: `=SUM(F2:F7)` or `=SUM(B8:E8)` (should be same!)

**Average Sales per Product (row 9):**
- Cell A9: `Average`
- Cell B9: `=AVERAGE(B2:B7)`
- Copy across to E9

**Best Month per Product (row 10):**
- Cell A10: `Best Month`
- Cell B10: `=MAX(B2:B7)`
- Copy across to E10

**Chart Exercise:**
Create a **Column Chart** showing total sales by month:
- Select cells A1:A7 and F1:F7 (use Ctrl to select non-adjacent ranges)
- Insert → Column Chart
- Title: "Monthly Sales Totals"
- Add data labels

---

## Problem 3: Basketball Team Statistics

**Instructions:**
1. Create a new worksheet named "Team_Stats"
2. Copy the data table below
3. Complete the formula exercises

**Data Table:**

| Player_Name | Points | Rebounds | Assists | Games_Played |
|-------------|--------|----------|---------|--------------|
| Jordan      | 245    | 156      | 89      | 12           |
| LeBron      | 312    | 198      | 134     | 15           |
| Curry       | 289    | 87       | 112     | 14           |
| Durant      | 298    | 145      | 98      | 13           |
| Giannis     | 276    | 189      | 76      | 15           |
| Jokic       | 267    | 223      | 167     | 14           |
| Embiid      | 301    | 198      | 65      | 13           |
| Tatum       | 254    | 134      | 89      | 15           |

### Formulas to Create:

**Column F - Points Per Game:**
- Header: `PPG`
- Formula: `=B2/E2`
- Format to 1 decimal place
- Copy down

**Column G - Rebounds Per Game:**
- Header: `RPG`
- Formula: `=C2/E2`
- Format to 1 decimal place
- Copy down

**Column H - Assists Per Game:**
- Header: `APG`
- Formula: `=D2/E2`
- Format to 1 decimal place
- Copy down

**Column I - All-Star Status (PPG >= 20):**
- Header: `All_Star`
- Formula: `=IF(F2>=20,"Yes","No")`
- Copy down

**Summary Statistics:**
- Team Average PPG
- Highest Scorer (use MAX function on PPG column)
- Total Points for Team
- Total Games Played

**Chart Exercise:**
Create a **Bar Chart** comparing Points Per Game:
- Select Player_Name and PPG columns
- Insert → Bar Chart
- Title: "Points Per Game Comparison"
- Sort bars from highest to lowest (manually reorder if needed)

---

## Problem 4: Product Inventory

**Instructions:**
1. Create worksheet named "Inventory"
2. Copy data and create formulas

**Data Table:**

| Product_ID | Product_Name    | Unit_Price | Stock_Quantity | Reorder_Level |
|------------|-----------------|------------|----------------|---------------|
| P001       | Laptop          | 899.99     | 45             | 20            |
| P002       | Monitor         | 249.99     | 67             | 30            |
| P003       | Keyboard        | 79.99      | 123            | 50            |
| P004       | Mouse           | 29.99      | 156            | 75            |
| P005       | Webcam          | 89.99      | 34             | 25            |
| P006       | Headphones      | 149.99     | 89             | 40            |
| P007       | USB_Cable       | 12.99      | 234            | 100           |
| P008       | External_Drive  | 129.99     | 56             | 30            |

### Formulas to Create:

**Column F - Inventory Value:**
- Header: `Inventory_Value`
- Formula: `=C2*D2` (Unit Price × Stock Quantity)
- Format as currency
- Copy down

**Column G - Reorder Status:**
- Header: `Status`
- Formula: `=IF(D2<=E2,"REORDER","OK")`
- Copy down
- Apply conditional formatting: Red fill for "REORDER", Green for "OK"

**Summary Calculations:**
- Total Inventory Value: `=SUM(F2:F9)`
- Items Needing Reorder: `=COUNTIF(G2:G9,"REORDER")`
- Average Unit Price: `=AVERAGE(C2:C9)`
- Total Units in Stock: `=SUM(D2:D9)`

**Chart Exercise:**
Create a **Pie Chart** showing inventory value distribution:
- Select Product_Name and Inventory_Value columns
- Insert → Pie Chart
- Title: "Inventory Value by Product"
- Show percentages on slices

---

## Problem 5: Absolute vs. Relative References

**Instructions:**
1. Create worksheet named "Tax_Calculator"
2. This demonstrates the difference between relative and absolute references

**Data Setup:**

| Description      | Value  |
|------------------|--------|
| Tax_Rate         | 0.065  |

*Leave a blank row*

| Item          | Price  | Tax    | Total  |
|---------------|--------|--------|--------|
| Laptop        | 899.99 |        |        |
| Printer       | 249.99 |        |        |
| Monitor       | 349.99 |        |        |
| Keyboard      | 79.99  |        |        |
| Mouse         | 39.99  |        |        |

### Formulas to Create:

**Tax Column (with absolute reference):**
- Formula in C5: `=B5*$B$2`
- The `$B$2` is an ABSOLUTE reference - won't change when copied
- Copy down to C9

**Total Column:**
- Formula in D5: `=B5+C5`
- Copy down to D9

**Try This Experiment:**
- Change the tax rate in B2 to 0.08
- Watch all tax calculations update automatically!
- This shows the power of absolute references

**Summary:**
- Subtotal: `=SUM(B5:B9)`
- Total Tax: `=SUM(C5:C9)`
- Grand Total: `=SUM(D5:D9)`

---

## Visualization Best Practices

### Chart Type Selection Guide:

**Use Column/Bar Charts for:**
- Comparing values across categories
- Example: Sales by month, scores by student

**Use Line Charts for:**
- Showing trends over time
- Example: Stock prices, temperature changes

**Use Pie Charts for:**
- Showing parts of a whole (percentages)
- Example: Market share, budget allocation
- **Limit to 5-7 slices maximum**

**Use Scatter Plots for:**
- Showing relationships between two variables
- Example: Study time vs. test scores

### Chart Formatting Tips:

1. **Always include a clear title**
2. **Label axes** (what does each axis represent?)
3. **Use consistent colors** within your workbook
4. **Add data labels** when they help clarity
5. **Remove unnecessary gridlines** for cleaner look
6. **Choose readable fonts** (avoid decorative fonts)

---

## Excel Keyboard Shortcuts

**Essential shortcuts to know:**

| Shortcut | Action |
|----------|--------|
| `Ctrl + C` | Copy |
| `Ctrl + V` | Paste |
| `Ctrl + Z` | Undo |
| `Ctrl + S` | Save |
| `Ctrl + Home` | Go to cell A1 |
| `Ctrl + Arrow` | Jump to edge of data |
| `Ctrl + Shift + Arrow` | Select to edge of data |
| `F2` | Edit active cell |
| `F4` | Toggle absolute reference ($) |
| `Alt + =` | AutoSum |

---

## Common Excel Errors and Fixes

| Error | Meaning | Fix |
|-------|---------|-----|
| `#DIV/0!` | Division by zero | Check denominator isn't zero |
| `#VALUE!` | Wrong data type | Check you're not adding text to numbers |
| `#REF!` | Invalid cell reference | Reference was deleted, fix the formula |
| `#NAME?` | Excel doesn't recognize text | Check function name spelling |
| `#N/A` | Value not available | Common in lookup functions |

---

## Practice Challenge: Combine Everything!

**Create a comprehensive sales dashboard:**

1. Use the Sales_Data from Problem 2
2. Add a column for "Target" (make each target 3000)
3. Add a column for "Performance" (Actual - Target)
4. Add a column for "Status" (IF target met, "Met", else "Missed")
5. Create summary statistics
6. Build at least 2 different chart types
7. Format professionally with:
   - Bold headers
   - Currency formatting for money
   - Conditional formatting for status
   - Consistent color scheme

---

## Next Steps

**You now know:**
- Basic Excel formulas (SUM, AVERAGE, COUNT, IF)
- Cell references (relative and absolute)
- Creating professional charts
- Formatting for readability

**Coming up in Lessons 5-6:**
- Export SQL query results to Excel
- Apply these Excel skills to NBA database data
- Create professional data analysis reports
- Combine SQL data processing with Excel presentation

**Keep this workbook!** You'll reference it when working with real database exports.
