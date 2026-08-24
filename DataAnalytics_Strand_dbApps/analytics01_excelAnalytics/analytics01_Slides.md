---
marp: true
theme: default
paginate: true
---

# Analytics 01: Data Analytics in Excel
## Database Applications
### Medina County Career Center

*(the first of three "lenses" — same dataset in Excel, then Python, then Tableau)*

---

# From "Just SQL" to Analysis

You can already **get** data (SQL) and **shape** it (pandas). Analytics is the next step:
turning data into an **insight** and **communicating** it. We start in **Excel** because it's fast,
visual, and you can see every number.

**The workflow (memorize it):** Ask → Get → Clean → **Analyze** → **Visualize** → Communicate.

---

# The Dataset

`pizza_orders.csv` — 63 pizza orders with: `region`, `size`, `topping`, `unit_price`,
`quantity`, `line_total`. We'll ask: **which region and size make the most money?**

*(You'll analyze this same file in Python and Tableau next — same questions, three tools.)*

---

<!-- _header: "01a — Descriptive Statistics" -->

# Summarize with Functions

Excel's stat functions answer "what does the data look like?"

| Question | Excel formula |
|---|---|
| How many orders? | `=COUNT(F2:F64)` |
| Total revenue | `=SUM(H2:H64)` |
| Average order | `=AVERAGE(H2:H64)` |
| Biggest / smallest order | `=MAX(H2:H64)`, `=MIN(H2:H64)` |
| Middle value | `=MEDIAN(H2:H64)` |

These five — count, sum, average, max/min, median — are the analyst's starter kit.

---

<!-- _header: "01b — PivotTables" -->

# The PivotTable: Group Without Formulas

A **PivotTable** answers "totals per category" with drag-and-drop — it's Excel's `GROUP BY`.

Example: revenue **per region**
- **Rows:** region
- **Values:** Sum of line_total

Drag `size` into Columns too, and you get a **cross-tab**: revenue for every region × size at once.

---

<!-- _header: "01c — Charts" -->

# Chart the Result

Match the chart to the question (same rule everywhere):

| Question | Chart |
|---|---|
| Compare regions | **Column/Bar** |
| Share of total by size | **Pie** |
| Spread of order totals | **Histogram** |
| Revenue trend by week | **Line** |

Insert a PivotChart straight from your PivotTable. **Always add a title and axis labels.**

---

# Key Takeaways

| Concept | Excel |
|---|---|
| Descriptive stats | `SUM`, `AVERAGE`, `MAX`, `MIN`, `MEDIAN`, `COUNT` |
| Group by category | **PivotTable** (Rows + Values) |
| Cross-tab | PivotTable Rows **and** Columns |
| Visualize | PivotChart; match chart to question |

**Big idea:** Excel is the fastest way to *peek* at data and get a first insight.

---
