# Analytics 03: Dashboards in Tableau — Study Guide

**Course**: Database Applications (CTE) | **Instructor**: Ryan McMaster — Medina County Career Center
**Placement**: Junior year, dbApps analytics strand (lens 3 of 3)

---

## What Tableau is for
The **communicate** step: an **interactive dashboard** a decision-maker can explore. Excel = peek,
Python = scale/repeat, **Tableau = communicate**.

## Connecting
- To a **file** (CSV/Excel) or directly to a **SQL database** (the ones you built in dbApps).
- Tableau splits fields into **Dimensions** (categories — like GROUP BY columns) and **Measures**
  (numbers — the values you SUM/AVG).

## Building a view (no code)
- Drag a **Dimension** to **Columns**, a **Measure** to **Rows** → Tableau aggregates (usually SUM) and picks a chart.
- Drag a field to **Color / Size / Label** to add another dimension.
- Change the question by dragging different fields — that's the whole skill.

## Dashboards
- Combine 2–3 **sheets (views)** onto one canvas.
- Add a **title**.
- Add a **filter** (e.g., Region) to make it **interactive** — clicking updates every view.

## Design tips (same as the cert's viz rules)
- Give every view a clear title and labeled axes.
- Use color to highlight, not to decorate; avoid 12 near-identical shades.
- One dashboard = one main message.

## Study tips
1. **Dimensions = categories, Measures = numbers** (GROUP BY vs. SUM).
2. Build a view by **dragging fields** to Rows/Columns; add Color for a breakdown.
3. A **dashboard** = several views + a title + a **filter** for interactivity.
4. Tableau can read your **SQL database** directly — analytics on the data you already model.
