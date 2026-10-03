# Unit 3b Extension Walkthrough — Star Wars Character Network in Gephi Lite

This extension builds on the graph database section at the end of `unit3b_Walkthrough.md`. A graph stores data as **nodes** (the things) and **edges** (the connections between them). Here you load a real Star Wars network into **Gephi Lite**, a free web tool, color it, and use a little math to find the most important characters.

## Contents

- [What the data is](#what-the-data-is)
- [Step 1: Open the file](#step-1-open-the-file)
- [Step 2: Spread it out](#step-2-spread-it-out)
- [Step 3: Color the characters](#step-3-color-the-characters)
- [Step 4: Run the math (Metrics)](#step-4-run-the-math-metrics)
- [Step 5: Show the math](#step-5-show-the-math)
- [Step 6: Save a picture](#step-6-save-a-picture)
- [If something goes wrong](#if-something-goes-wrong)
- [Questions to think about](#questions-to-think-about)

---

## What the data is

The file is [`../datasets/starwars_all_movies.gexf`](../datasets/starwars_all_movies.gexf). To get it, open that link on GitHub and click the **Download raw file** button (the download arrow near the top-right).

- **Node** = one character (112 characters).
- **Edge** = two characters spoke in the same scene (449 connections).
- **Weight** = how many scenes those two shared, across all the movies.

It covers **Episodes I through VII**. Episodes VIII and IX are not included because the dataset was made in 2016.

Every character also has these **attributes** (extra columns of information). You can color the network by any of them.

| Attribute | What it means | Example values |
|---|---|---|
| `species` | What kind of being the character is | Human, Alien, Droid |
| `side` | Which side of the Force they are on | Light side, Dark side, Neither |
| `group` | Who they fight for or belong to | Jedi, Sith, Rebel Alliance, Galactic Empire, First Order... |
| `gender` | Male, female, or none (droids) | Male, Female, None |
| `trilogy` | Which trilogies they appear in | Prequel, Original, Sequel, Prequel + Original... |
| `firstMovie` | The first movie they appear in | Episode I, Episode IV... |
| `movies` | Every movie they appear in | I, II, III |
| `movieCount` | How many movies they appear in | 1 to 7 |

The connections and the movie columns come from the movie scripts, using Evelina Gabasova's Star Wars social network project ([GitHub repository](https://github.com/evelinag/StarWars-social-network)). The `species`, `side`, `group`, and `gender` columns were added by hand for this course. Some are judgment calls. Is a bounty hunter on the dark side? We called that "Neither."

**One thing to notice:** Anakin and Darth Vader are separate nodes, because the scripts use different names for them.

---

## Step 1: Open the file

1. Go to **https://lite.gephi.org**. No account is needed.
2. Click **Open a local file**. (If you don't see that, click **Workspace** in the top-left, then **Open...**.)
3. Click **Select a local file**, choose `starwars_all_movies.gexf`, then click **Open**.
4. The top-left should say **Nodes 112** and **Edges 449**.

It will look like a messy pile. That's normal.

**Moving around:** scroll to zoom, and drag the background to move. If you lose the graph, click **See the whole graph**, the bottom button in the lower-right corner.

---

## Step 2: Spread it out

A **layout** moves the dots so connected characters pull together and unconnected ones push apart.

1. In the left panel, click **Layout**, then **ForceAtlas2**.
2. Check **Strong gravity mode?** (This keeps loose characters from flying off the screen.)
3. Change **Scaling ratio** to **50**. (This spreads the dots apart.)
4. Click **Start**. Wait about 5 seconds, then click **Stop**.
5. Close the panel with the **X**, then click **See the whole graph**.

---

## Step 3: Color the characters

1. Click **Appearance**, then **Nodes**.
2. Under **Color**, click the **Set color from...** box and pick **side**.
3. Light side, Dark side, and Neither each get their own color. A key in the bottom-left shows which is which.

Now try the other options in the same box: **species**, **group**, **trilogy**, **firstMovie**. Each one tells a different story about the same network.

**Tip:** click a color square next to a value to change that color. For example, make Dark side red and Light side blue.

---

## Step 4: Run the math (Metrics)

Gephi Lite can calculate a number for every character. **The Metrics list is hidden until you click the word "Metrics"** in the left panel.

For each one below: click its name, then click **Compute metric** at the bottom of the panel. Nothing on screen changes yet. The answer is saved as a new column, which you use in Step 5.

| Metric | What it means in plain words | Saved as |
|---|---|---|
| **Degree** | How many different characters this one talks to. More connections = higher number. | `degree` |
| **Betweenness centrality** | How often this character is the "bridge" in the shortest path between two other characters. A high number means they connect groups that would otherwise be apart. | `betweennessCentrality` |
| **Louvain community detection** | The computer looks only at who talks to whom and splits the characters into groups (called communities) that talk mostly to each other. It knows nothing about the movies or sides. | `modularityClass` |

**About `modularityClass`:** it only appears in the color menu **after** you run Louvain. Each group gets a number (0, 1, 2...). The numbers are just names for the groups. A higher number doesn't mean anything.

**To see the actual numbers:** click **Data** at the top center. Click a column heading to sort it, and click again for highest first. Click **Graph** to go back.

---

## Step 5: Show the math

**Make important characters bigger**

1. **Appearance** > **Nodes**. Under **Size**, click **Set size from...** and pick **degree**.
2. Check **Interpolate between custom min and max values**. Set **Min** to **3** and **Max** to **25**.

The biggest dots are the characters with the most connections. Now switch the size to **betweennessCentrality** and watch who grows. Characters who connect different groups get bigger, even if they don't talk to many people.

**Color by the computer's groups**

3. Under **Color**, pick **modularityClass**. Compare it to coloring by **trilogy** or **side**. Did the computer find the same groups we labeled by hand?

**Thin out the lines**

4. **Appearance** > **Edges**. Check **Interpolate between custom min and max values**. Set **Min** to **0.5** and **Max** to **5**. Close the panel.

---

## Step 6: Save a picture

1. Click **Workspace** (top-left), then **Export image**.
2. Name it `lastname_starwars.png`.
3. Check **Preserve current camera position** to save exactly what is on your screen.
4. Click **Save**. It goes to your Downloads folder.

---

## If something goes wrong

| Problem | Fix |
|---|---|
| I can't find Louvain or Degree | Click the word **Metrics** in the left panel to open the list. Scroll down if needed. |
| `modularityClass` isn't in the color list | Run **Louvain community detection** first (Step 4). |
| The graph is gone or the screen is empty | Click **See the whole graph** (bottom-right). If that doesn't work, refresh the page. Gephi Lite remembers your work. |
| Everything is piled into one blob | Run ForceAtlas2 again with a bigger **Scaling ratio**. |
| The dots are all huge | In Step 5, check **Interpolate between custom min and max values** and set Min and Max. |

---

## Questions to think about

1. Size by **degree**. Who are the three biggest characters? Are they who you expected?
2. Size by **betweennessCentrality**. Poe is only 17th in connections but 8th in betweenness, and Darth Vader is 15th in connections but 6th in betweenness. Why might they act as "bridges" in the story?
3. Color by **trilogy**. Which characters connect the prequels to the original movies?
4. Color by **modularityClass**, then by **trilogy**. Do the computer's groups match the trilogies, or something else?
5. Color by **side**. Do Light side and Dark side characters stay in separate areas, or are they mixed together? Why might that be?
