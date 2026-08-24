# Analytics 01: Data Analytics in Excel — Study Guide

**Course**: Database Applications (CTE) | **Instructor**: Ryan McMaster — Medina County Career Center
**Placement**: Junior year, dbApps analytics strand (lens 1 of 3)

---

## The analytics workflow
**Ask → Get → Clean → Analyze → Visualize → Communicate.** Excel is where we do the last three quickly.

## Descriptive-statistics functions
| Function | Gives |
|---|---|
| `=COUNT(range)` | how many numbers |
| `=SUM(range)` | total |
| `=AVERAGE(range)` | mean |
| `=MAX` / `=MIN(range)` | largest / smallest |
| `=MEDIAN(range)` | middle value (resists outliers) |

## PivotTables = Excel's GROUP BY
- **Rows** = the category to group by (e.g., region)
- **Values** = the number to summarize (e.g., Sum of line_total)
- Add a **Columns** field to make a **cross-tab** (region × size at once)
- Change Sum/Count/Average via **Value Field Settings**

## Charts — match the chart to the question
| Question | Chart |
|---|---|
| Compare categories | Column / Bar |
| Share of a whole | Pie |
| Distribution of a number | Histogram |
| Trend over time | Line |

Always add a **title** and **axis labels** — an unlabeled chart can't be interpreted.

## When to use Excel
Fast, visual, great for a **quick peek** at small/medium data. For big data or a **repeatable** pipeline,
you'll switch to Python (Analytics 02). For interactive dashboards, Tableau (Analytics 03).

## Study tips
1. Summarize **before** charting — count/sum/average/median.
2. **PivotTable = GROUP BY**: Rows (category) + Values (number).
3. **Cross-tab** = Rows *and* Columns.
4. Match the chart to the question; always label it.
