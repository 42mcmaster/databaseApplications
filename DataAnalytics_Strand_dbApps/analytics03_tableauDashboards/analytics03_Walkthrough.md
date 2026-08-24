# Analytics 03 Walkthrough: Build a Tableau Dashboard

**Course**: Database Applications (CTE) | **Instructor**: Ryan McMaster — Medina County Career Center

**You will need:** Tableau (Desktop or the free **Tableau Public**) and `pizza_orders.csv`.

> Tableau is drag-and-drop — there is no code. If your school uses Tableau Public, you'll publish to the web;
> if Desktop, you'll save a `.twbx`. The steps are the same.

---

## Part A — Connect (5 minutes)
1. Open Tableau. On the start page: `Connect → To a File → Text file → pizza_orders.csv`.
2. On the Data Source tab, confirm the 8 columns loaded and the preview looks right.
3. Click **Sheet 1**. Notice the left panel splits fields into **Dimensions** (region, size, topping, dates)
   and **Measures** (unit_price, quantity, line_total). *Dimensions = categories; Measures = numbers.*

## Part B — Your first view: revenue by region (10 minutes)
1. Drag **Region** to the **Columns** shelf.
2. Drag **Line Total** to the **Rows** shelf. Tableau shows **SUM(Line Total)** — a bar per region.
3. Rename the sheet tab **"Revenue by Region."**

**Check:** the four bars total **$1,600**; **West** is tallest (~$499).

### Break it down
4. Drag **Size** onto the **Color** card. Each bar now shows its size mix. Drag Size off again to reset.

## Part C — Two more views (10 minutes)
5. **New sheet** → drag **Size** to Columns, **Line Total** to Rows → "Revenue by Size."
6. **New sheet** → drag **Order Date** to Columns (set to Week), **Line Total** to Rows → "Revenue Over Time" (a line chart).

## Part D — Assemble the dashboard (10 minutes)
1. Click the **New Dashboard** icon (bottom, next to the sheet tabs).
2. **Drag** each of your three sheets onto the canvas; arrange them.
3. Add a **Dashboard Title** ("Pizza Sales Overview").
4. On one view, click the drop-down → **Filters → Region** (or use *Use as Filter*). Now clicking a region
   filters the whole dashboard.

**Check:** click **"West"** on the region chart — the other views update to West only. That interactivity
is the whole point.

## Wrap-up
You've now analyzed the same pizza data in **three tools**: Excel (peek), Python (scale/repeat),
Tableau (communicate). Same workflow, three lenses.

**Deliverable:** a Tableau workbook (`.twbx`) or Tableau Public link with three views and one interactive
dashboard (titled, with a Region filter).
