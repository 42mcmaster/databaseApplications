# Unit 3b Extension Walkthrough — Graph Networks in Gephi Lite

This extension builds on the graph database section at the end of `unit3b_Walkthrough.md`. There, you saw that a graph stores data as **nodes** (the things) and **edges** (the connections). Here, you load a real network into **Gephi Lite**, a free web tool, and use it to draw, measure, and explore that network.

## Contents

- [What the data is](#what-the-data-is)
- [Before you start: get the file](#before-you-start-get-the-file)
- [Step 1: Open the file](#step-1-open-the-file)
- [Step 2: Spread it out (Layout)](#step-2-spread-it-out-layout)
- [Step 3: Measure the network (Metrics)](#step-3-measure-the-network-metrics)
- [Step 4: Color and size (Appearance)](#step-4-color-and-size-appearance)
- [Step 5: Look at the numbers (Data tab)](#step-5-look-at-the-numbers-data-tab)
- [Step 6: Focus on one character (Filters)](#step-6-focus-on-one-character-filters)
- [Step 7: Save a picture](#step-7-save-a-picture)
- [If something goes wrong](#if-something-goes-wrong)
- [Questions to think about](#questions-to-think-about)

---

## What the data is

The dataset is a social network of the characters in the original Star Wars trilogy (Episodes IV, V, and VI).

- **Node** = one character (40 total).
- **Edge** = two characters spoke in the same scene at least once (125 total).
- **Weight** = how many scenes those two characters shared. Luke and Leia share many. Luke and Greedo share none.

The data comes from Evelina Gabasova's Star Wars social network project, which was built from the movie scripts: https://github.com/evelinag/StarWars-social-network. The three movies were combined into one file for this course.

The file is a **.gexf** file, a standard format for graph data. It lists the nodes and the edges, much like a table of records and a table of relationships.

**How this connects to 3b:** in a relational database, "Luke appeared with Leia" would need a junction table (a many-to-many). In a graph, that connection is stored directly as an edge.

---

## Before you start: get the file

The file is in this repository at [`../datasets/starwars_original_trilogy.gexf`](../datasets/starwars_original_trilogy.gexf).

1. Open that link on GitHub.
2. Click the **Download raw file** button (the download arrow near the top-right of the file view).
3. Save it somewhere you can find it, like your Downloads folder.

If you have the repository cloned on your computer, the file is already in the `datasets` folder.

---

## Step 1: Open the file

1. Go to **https://lite.gephi.org** in your browser. No account is needed.
2. A welcome box appears. Click **Open a local file**.
    - If no welcome box appears (someone used Gephi Lite on this computer before), click **Workspace** in the top-left corner, then **Open...**.
3. Click **Select a local file**, choose `starwars_original_trilogy.gexf`, then click **Open**.
4. Check the top-left panel. It should say **Nodes 40** and **Edges 125**.

The graph will look like a messy pile. That is normal. The next step fixes it.

**Moving around:** scroll to zoom in and out, and drag the background to move. The buttons in the bottom-right corner also zoom. The last button, **See the whole graph**, brings everything back into view. You will use it a lot.

Gephi Lite opens **.gexf**, **.graphml**, and Graphology **.json** files. It does not open CSV files.

---

## Step 2: Spread it out (Layout)

A layout moves the nodes so connected characters pull together and unconnected ones push apart. **ForceAtlas2** is the most common layout for social networks.

1. In the left panel, click **Layout**, then **ForceAtlas2**.
2. Click **Reset** at the bottom of the settings so you start from the default values.
3. Check the box **Strong gravity mode?** This keeps loosely connected characters from flying off the screen.
4. Change **Scaling ratio** to **50**. This spreads the nodes apart so they do not pile up.
5. Click **Start**. Watch the nodes move for about 5 seconds, then click **Stop**.
6. Click the **X** to close the settings, then click **See the whole graph** (bottom-right).

Do not click the magic-wand button next to Reset ("Generates settings that fit the current graph"). On this graph it can send the nodes off the screen.

---

## Step 3: Measure the network (Metrics)

Gephi Lite can calculate numbers for every character. Run these three. For each one: click **Metrics**, click the metric name, then click **Compute metric** at the bottom. Nothing changes on the screen yet. The numbers are saved for Steps 4 and 5.

| Metric | What it measures | Question it answers |
|---|---|---|
| **Degree** | How many other characters this one is connected to | Who talks to the most people? |
| **Betweenness centrality** | How often this character sits on the shortest path between two others | Who connects groups that would otherwise be apart? |
| **Louvain community detection** | Splits the network into groups that are tightly connected inside | Which characters form a "crowd"? |

Louvain saves its result as a column called **modularityClass**. Each group gets a number (0, 1, 2, and so on). The numbers are only names for the groups. A higher number does not mean anything.

---

## Step 4: Color and size (Appearance)

Now use the numbers from Step 3 to make the picture tell the story.

**Color the groups**

1. Click **Appearance**, then **Nodes**.
2. Under **Color**, open the **Set color from...** list and pick **modularityClass**. Each Louvain group gets its own color.

**Size by connections**

3. Under **Size**, open **Set size from...** and pick **degree**. The most connected characters become the biggest circles.
4. Close the panel with the **X**.

**Thin out the lines**

The lines are drawn thicker for pairs who share more scenes. Some are so thick they cover everything.

5. Click **Appearance**, then **Edges**.
6. Check **Interpolate between custom min and max values**.
7. Set **Min** to **1** and **Max** to **8**. Close the panel.

A key (legend) in the bottom-left corner now shows what the colors and sizes mean.

---

## Step 5: Look at the numbers (Data tab)

The picture shows the pattern. The table shows the exact numbers.

1. Click **Data** at the top center of the screen. A table lists every character, one row each.
2. The columns you computed are on the right: **degree**, **betweennessCentrality**, and **modularityClass**.
3. Click a column heading to sort by it. Click it again to flip the order (highest first).
4. Click **Graph** at the top to go back to the picture.

The **Edges** button at the top-left of the table switches to a list of every connection and its weight.

---

## Step 6: Focus on one character (Filters)

An **ego network** is one person plus everyone they are directly connected to. It answers the question "who is in this character's world?"

1. Click **Filters**, then **Add filter**.
2. Under **Topology**, click **Ego network**.
3. In the **Ego node** box, type a character's name (for example, Han) and press Enter.
4. The graph now shows only that character's network. The top-left panel shows how many are left, for example **17 of 40** nodes.
5. To see everyone again, click **Delete filter**.

---

## Step 7: Save a picture

1. Arrange the view the way you want it (zoom, filter, colors).
2. Click **Workspace** (top-left), then **Export image**.
3. Type a file name, for example `lastname_starwars.png`.
4. To save exactly what is on your screen, check **Preserve current camera position**. Leave it unchecked to save the whole graph.
5. Click **Save**. The picture goes to your Downloads folder.

---

## If something goes wrong

| Problem | Fix |
|---|---|
| The graph is gone or the screen is empty | Click **See the whole graph** (bottom-right). |
| Still empty, or the screen went blank after using the Data tab | Refresh the browser page. Gephi Lite remembers your graph and settings. |
| Nodes are piled into one big blob | Run ForceAtlas2 again with a higher **Scaling ratio**. |
| Nodes flew far apart or off the screen | **Layout** > **Random** > **Apply**, then redo Step 2. |
| The old graph shows up instead of the new file | **Workspace** > **Open...** and open the file again. |

---

## Questions to think about

Use the graph and the Data tab.

1. Which character has the highest **degree**? Is that who you expected? Why or why not?
2. Sort by **betweennessCentrality**. Find a character whose betweenness rank is much higher than their degree rank. What role does that character play between groups in the story?
3. How many groups did Louvain find? Pick two groups. Who is in each, and why might they be grouped together?
4. Use an **ego network** on a character of your choice. How many characters are in their network? Who surprised you by being in it, or by being missing?
5. Find a character with **0** or **1** connections. Why might the data show them as so isolated?
