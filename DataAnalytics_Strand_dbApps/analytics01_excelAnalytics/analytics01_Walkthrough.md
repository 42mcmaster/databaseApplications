# Analytics 01 Walkthrough: Data Analytics in Excel

**Course**: Database Applications (CTE) | **Instructor**: Ryan McMaster — Medina County Career Center

**You will need:** `pizza_orders.csv` (in the dataset folder). Open Excel and import it:
`Data → From Text/CSV → pizza_orders.csv → Load`. Your data lands in columns **A–H** with headers in row 1
(63 data rows: 2–64).

---

## Part A — Descriptive statistics (5 minutes)

In an empty area (say cell **K1**), type these labels and formulas:

| Cell | Label (K) | Formula (L) |
|---|---|---|
| row 1 | Orders | `=COUNT(F2:F64)` |
| row 2 | Total revenue | `=SUM(H2:H64)` |
| row 3 | Average order | `=AVERAGE(H2:H64)` |
| row 4 | Biggest order | `=MAX(H2:H64)` |
| row 5 | Smallest order | `=MIN(H2:H64)` |
| row 6 | Median order | `=MEDIAN(H2:H64)` |

**Check:** Total revenue should be **$1600.00** and there should be **63** orders.

> These six numbers are your first "shape of the data." An analyst always summarizes before charting.

---

## Part B — PivotTable: revenue by region (10 minutes)

1. Click any cell in the data. `Insert → PivotTable → New Worksheet → OK`.
2. In the PivotTable Fields pane:
   - Drag **region** to the **Rows** box.
   - Drag **line_total** to the **Values** box. It should read *Sum of line_total* (if it says *Count*, click it → Value Field Settings → Sum).
3. You now have total revenue for each region.

**Check:** the four regions total **$1600.00**. Note which region is largest.

### Make it a cross-tab
4. Also drag **size** to the **Columns** box. Now every cell is revenue for one region × size — a **cross-tab** in three drags. This would take many SQL queries; the PivotTable does it live.

---

## Part C — Chart it (10 minutes)

1. Click inside your region PivotTable. `PivotTable Analyze → PivotChart → Clustered Column → OK`.
2. Add a **chart title** ("Revenue by Region") and turn on **axis titles** (`Chart Design → Add Chart Element`).
3. Make a second chart: a PivotTable of **Sum of line_total by size**, charted as a **Pie** to show each size's *share* of revenue.

> Match the chart to the question: **column** to compare regions, **pie** for share of a whole.

---

## Wrap-up

You just ran the full analytics workflow — **summarize → group (PivotTable) → visualize** — in Excel.
Next lesson you'll get the *exact same answers* in Python, and see why you'd reach for each tool.

**Deliverable:** one workbook with your stats block, both PivotTables, and both labeled charts.
