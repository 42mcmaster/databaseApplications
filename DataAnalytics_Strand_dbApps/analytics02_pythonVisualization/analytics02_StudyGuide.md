# Analytics 02: Visualizing Data with Python — Study Guide

**Course**: Database Applications (CTE) | **School**: Medina County Career Center
**Instructor**: Ryan McMaster | **Placement**: Junior year, dbApps analytics strand (lens 2 of 3)

> Uses the shared `pizza_orders.csv` dataset — the same one you explored in Excel (Analytics 01) and will
> dashboard in Tableau (Analytics 03). Builds on the pandas you already use in dbApps.

---

## 1. Summarize before you chart
| Task | pandas |
|---|---|
| Rows & columns | `df.shape` |
| Numeric summary | `df.describe()` |
| Category counts | `df["region"].value_counts()` |
| Total / average | `df["line_total"].sum()`, `df["quantity"].mean()` |
| Group and total (like SQL GROUP BY) | `df.groupby("region")["line_total"].sum()` |

## 2. Match the chart to the question
| Question | Chart | Code |
|---|---|---|
| Compare categories | **bar** | `series.plot(kind="bar")` |
| Distribution of a number | **histogram** | `df["col"].plot(kind="hist")` |
| Trend over time | **line** | `df.plot(x="date", y="val", kind="line")` |
| Relationship of two numbers | **scatter** | `df.plot(x="a", y="b", kind="scatter")` |

## 3. Why Python (vs. Excel)
Excel is great for a quick peek at small data. Python/Jupyter **scales** to large data, is **reproducible**
(re-run to redo the analysis on new data), and makes **richer charts** (matplotlib/seaborn). *Excel to peek,
Python to scale and repeat.*

## 4. The workflow is tool-independent
Ask → summarize → chart → conclude. You did it in Excel; you're doing it in Python; you'll do it in Tableau.
Only the buttons change.

---

## Quick Reference
```python
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("pizza_orders.csv")
df.shape                                   # (rows, cols)
df.describe()                              # numeric summary
df["region"].value_counts()               # category counts
df.groupby("region")["line_total"].sum()  # total per region

df.groupby("region")["line_total"].sum().plot(kind="bar")
plt.title("Revenue by Region"); plt.ylabel("Revenue ($)")
plt.show()
```

## Study Tips
1. `groupby` **is** SQL's `GROUP BY` — same idea, new syntax.
2. Match chart to question: **bar** compare, **hist** distribution, **line** trend, **scatter** relationship.
3. Always **label** your chart (title + axis labels) — same rule as the cert's visualization items.
4. Python's superpower is **reproducibility** — re-run to redo the analysis on new data.
