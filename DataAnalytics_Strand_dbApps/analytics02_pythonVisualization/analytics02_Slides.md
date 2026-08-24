---
marp: true
theme: default
paginate: true
---

# Analytics 02: Visualizing Data with Python
## Database Applications
### Medina County Career Center

*(the second of three "lenses" — same dataset in Excel, then Python, then Tableau)*

---

# Where This Fits

You already query and shape data with **SQL and pandas** (dbApps). In **Analytics 01** you explored
this same pizza-orders data in **Excel**. Now we do it in **Python / JupyterLab** — which scales to
big data, is fully **reproducible**, and makes richer charts.

**Same questions, new lens.** Watch how the *analysis* is identical; only the tool changes.

---

<!-- _header: "Sub-Lesson 02a — Describe the Data" -->

# The Analyst's First Move: Summarize

Before charts, get the shape of the data:

| Question | pandas |
|---|---|
| How many rows/columns? | `df.shape` |
| What do the numbers look like? | `df.describe()` |
| How many of each category? | `df["region"].value_counts()` |
| Total / average of a column | `df["line_total"].sum()`, `.mean()` |
| Group and total | `df.groupby("region")["line_total"].sum()` |

`groupby` is the pandas version of SQL's `GROUP BY` — the same skill, new syntax.

---

<!-- _header: "Sub-Lesson 02b — The Right Chart" -->

# Match the Chart to the Question

| Question | Chart | pandas/plot |
|---|---|---|
| Compare a total across categories | **bar** | `.plot(kind="bar")` |
| Distribution of one number | **histogram** | `.plot(kind="hist")` |
| Trend over time | **line** | `.plot(kind="line")` |
| Relationship of two numbers | **scatter** | `.plot(kind="scatter")` |

This is the **same chart-choice rule** from the Data Analytics cert — just drawn with code.

---

<!-- _header: "Sub-Lesson 02b — The Right Chart" -->

# Why Python (vs. Excel)?

| | Excel | Python / Jupyter |
|---|---|---|
| Small data, quick look | ✅ fast, familiar | ✅ |
| Thousands+ of rows | slows down | ✅ handles it |
| **Reproducible** (re-run on new data) | manual clicks | ✅ just re-run the cell |
| Custom / advanced charts | limited | ✅ matplotlib / seaborn |

**Rule of thumb:** Excel to *peek*, Python to *scale and repeat*.

---

# Key Takeaways

| Concept | What it means |
|---|---|
| `df.describe()` | quick numeric summary (count, mean, min, max) |
| `df.groupby(...)` | the pandas `GROUP BY` — totals per category |
| **bar / hist / line / scatter** | compare / distribution / trend / relationship |
| **Reproducible** | re-run the notebook to redo the whole analysis |

**Big idea:** the analysis workflow (ask → summarize → chart → conclude) is the same in every tool.

---
