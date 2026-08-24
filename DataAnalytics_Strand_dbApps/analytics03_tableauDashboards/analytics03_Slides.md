---
marp: true
theme: default
paginate: true
---

# Analytics 03: Dashboards in Tableau
## Database Applications
### Medina County Career Center

*(the third "lens" — same pizza data, now an interactive dashboard)*

---

# The Communicate Step

Excel let you *peek*; Python let you *scale*. **Tableau** is for the last workflow step —
**communicating** to a decision-maker with an **interactive dashboard** they can explore themselves.

Same data, same questions — now the answer is something a manager can click through.

---

<!-- _header: "03a — Connect & Understand" -->

# Connect to Data

Tableau connects straight to your data:
- **A file** — `Connect → Text file → pizza_orders.csv`
- **A database** — Tableau can connect to the very SQL databases you built in dbApps

Tableau then splits fields into **Dimensions** (categories: region, size, topping) and
**Measures** (numbers: unit_price, quantity, line_total). Sound familiar? Dimensions ≈ GROUP BY columns,
Measures ≈ the values you SUM.

---

<!-- _header: "03b — Build a View" -->

# Build a View (drag, don't code)

To chart **revenue by region**:
1. Drag **Region** to **Columns**
2. Drag **Line Total** to **Rows** (Tableau auto-**SUM**s it)
3. Tableau picks a bar chart — done.

Change the question by dragging a different field. Add **Size** to **Color** to break each bar down by size —
instantly.

---

<!-- _header: "03c — Assemble a Dashboard" -->

# From Views to a Dashboard

1. Build **2–3 views** on separate sheets (e.g., revenue by region, revenue by size, orders over time).
2. Click **New Dashboard** and **drag each sheet** onto the canvas.
3. Add a **title**, and turn one field into a **filter** (e.g., a Region filter) so viewers can explore.

A **filter** makes it interactive: click "West" and every view updates. That's the payoff Excel can't match.

---

# Key Takeaways

| Concept | Tableau |
|---|---|
| Connect | to a CSV **or** your SQL database |
| Dimensions vs. Measures | categories vs. numbers (GROUP BY vs. SUM) |
| Build a view | drag fields to Rows/Columns/Color |
| Dashboard | combine views + a title + a filter |
| Filter | makes the dashboard **interactive** |

**Big idea:** Tableau is the *communicate* tool — it turns your analysis into something others can explore.

---
