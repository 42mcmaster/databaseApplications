# Unit 3b Extension Walkthrough — Finding Airline Hubs in Gephi Lite

**Do the Star Wars walkthrough (`unit3b_GraphGephi_Walkthrough.md`) first.** This one uses the same tool and the same basic steps on a bigger, real-world network: US airline routes. Then open `unit3b_GraphFlights_lastname.md` and answer the questions.

## Contents

- [What the data is](#what-the-data-is)
- [What makes an airport a hub](#what-makes-an-airport-a-hub)
- [Before you start: get the file](#before-you-start-get-the-file)
- [Step 1: Open the file](#step-1-open-the-file)
- [Step 2: Put the airports on a map (Custom layout)](#step-2-put-the-airports-on-a-map-custom-layout)
- [Step 3: Measure the network (Metrics)](#step-3-measure-the-network-metrics)
- [Step 4: Color and size (Appearance)](#step-4-color-and-size-appearance)
- [Step 5: Rank the airports (Data tab)](#step-5-rank-the-airports-data-tab)
- [Step 6: Look at one state or one airport (Filters)](#step-6-look-at-one-state-or-one-airport-filters)
- [Step 7: Save a picture](#step-7-save-a-picture)
- [If something goes wrong](#if-something-goes-wrong)

---

## What the data is

A network of nonstop US airline routes in the lower 48 states (Alaska and Hawaii are left out).

- **Node** = one airport (413 total). Each node is labeled with its 3-letter airport code, like `CLE` for Cleveland.
- **Edge** = at least one airline flew nonstop between those two airports (2,505 total).
- **Weight** = how many airlines sold tickets on that nonstop route. This includes partner airlines that sell seats on another airline's flight.

Each airport also has these attributes:

| Attribute | What it holds | Example (CLE) |
|---|---|---|
| `name`, `city`, `state` | Where the airport is | Cleveland Hopkins International Airport, Cleveland, OH |
| `region` | US Census region: Northeast, Midwest, South, or West | Midwest |
| `airportSize` | Large, Medium, or Small, as listed by OurAirports | Large |
| `international` | `Yes` if the airport had at least one nonstop route to another country | Yes |
| `intlDestinations` | How many foreign airports it flew to nonstop | 3 |
| `mainAirline` | The US airline that sold tickets on the most routes at that airport | United Airlines |
| `latitude`, `longitude` | Location on the map | 41.41, -81.85 |

`region`, `airportSize`, `international`, and `mainAirline` are **grouping attributes**. Each one sorts the airports into a few groups, so you can color by it and see a pattern. This is where Gephi is most useful.

**Two limits to keep in mind:**

1. **The data is from 2014.** That is when the route data stopped being updated. The big hubs have not changed much, but some smaller routes have, and some airlines in the data no longer exist. In 2014 US Airways was merging into American, so many of its routes are listed under American.
2. **It counts routes, not passengers.** It tells you a flight exists, not how many people are on it.

Sources: route and airline data from [OpenFlights](https://openflights.org/data.php) (Open Database License). Airport states, sizes, and locations from [OurAirports](https://github.com/davidmegginson/ourairports-data) (public domain).

---

## What makes an airport a hub

Airlines do not fly every city to every other city. Instead, they fly lots of routes into a few big airports, and passengers change planes there. Those airports are **hubs**. A trip from Akron to Phoenix might go Akron → Atlanta → Phoenix.

In network terms, you can measure "hub" three ways:

| Measure | What it counts | Question it answers |
|---|---|---|
| **Degree** | Number of airports you can fly to nonstop | Which airport connects to the most places? |
| **Weighted degree** | Degree, but each route counts once per airline | Which airport has the most airline service? |
| **Betweenness centrality** | How often the airport is the stop in the middle of the shortest trip between two other airports | Which airports do trips have to pass through? |

---

## Before you start: get the file

The file is in this repository at [`us_flight_routes_2014.gexf`](us_flight_routes_2014.gexf), in this same folder.

1. Open that link on GitHub.
2. Click the **Download raw file** button (the download arrow near the top-right of the file view).
3. Save it somewhere you can find it.

---

## Step 1: Open the file

1. Go to **https://lite.gephi.org**.
2. Click **Open a local file** (or **Workspace** > **Open...** if the welcome box does not appear).
3. Click **Select a local file**, choose `us_flight_routes_2014.gexf`, then click **Open**.
4. Check the top-left panel: **Nodes 413** and **Edges 2,505**.

---

## Step 2: Put the airports on a map (Custom layout)

In the Star Wars network, ForceAtlas2 decided where each node went. Airports have real locations, so here you place each one by its latitude and longitude with a few lines of JavaScript.

1. Click **Layout**, then **Custom layout**.
2. Click **Open code editor**. You will see a function called `nodeCoordinates`. Gephi Lite runs it once for every airport and uses what it returns as that airport's x and y position.
3. Find this line:

    ```javascript
    return { x: Math.random() * 1000, y: Math.random() * 1000 };
    ```

4. Replace it with this line:

    ```javascript
    // longitude = east/west position, latitude = north/south position
    return { x: attributes.longitude * 16, y: attributes.latitude * 20 };
    ```

    - `attributes` holds that airport's data, so `attributes.longitude` is its longitude.
    - Longitude becomes **x** (left to right). Latitude becomes **y** (bottom to top).
    - Multiplying spreads the points out so they are not crammed together. Longitude uses a smaller number because a degree of longitude covers less ground than a degree of latitude across most of the US.

5. Click **Save and run**, close the panel, and click **See the whole graph** (bottom-right).

The airports now form the shape of the United States. Florida is at the bottom right and Washington state is at the top left.

---

## Step 3: Measure the network (Metrics)

You will run Degree twice: once normally, and once using the edge weights.

**Degree**

1. Click **Metrics**, then **Degree**. Click **Compute metric**.

**Weighted degree**

2. Still in the Degree panel, change **Degree attribute name** to `weightedDegree`.
3. Open the **Edge weight attribute** list and pick **weight**.
4. Click **Compute metric**. This saves a second column, so you keep both.

**Betweenness centrality**

5. Click **Betweenness centrality**, then **Compute metric**. This one takes a few seconds on 413 airports.

---

## Step 4: Color and size (Appearance)

**Color by region**

1. Click **Appearance**, then **Nodes**.
2. Under **Color**, open **Set color from...** and pick **region**.

**Size by number of destinations**

3. Under **Size**, open **Set size from...** and pick **degree**.
4. Make sure **Interpolate between custom min and max values** is checked. Set **Min** to **2** and **Max** to **20**. Small airports become dots, and hubs become big circles.
5. Close the panel.

**Thin out the lines**

6. Click **Appearance**, then **Edges**.
7. Check **Interpolate between custom min and max values**. Set **Min** to **0.3** and **Max** to **3**. Close the panel.

The biggest circles are the hubs. Try sizing by **weightedDegree** or **betweennessCentrality** instead, and watch which circles grow or shrink.

**Try the other groups**

8. Go back to **Appearance** > **Nodes** > **Color**, and set the color from **mainAirline**. Each airline gets its own color. Look for areas of the map where one color takes over, and find each big airline's hub (its biggest circle).
9. Set the color from **international**. Are the `Yes` airports mostly big circles or small ones?
10. Set the color from **airportSize**. Compare it with the circle sizes: does "Large" always mean a high degree?

---

## Step 5: Rank the airports (Data tab)

1. Click **Data** at the top center.
2. Click a column heading (**degree**, **weightedDegree**, **betweennessCentrality**) to sort by it. Click again to put the highest first.
3. Use the **city** and **state** columns to find out where each airport code is.
4. Click **Graph** to go back to the map.

---

## Step 6: Look at one state or one airport (Filters)

**One state**

1. Click **Filters**, then **Add filter**.
2. Under **Nodes attributes**, click **state**.
3. In the **Select...** box, type a state code (like `OH`) and press Enter.

This shows only that state's airports and the routes **between** them. Routes to other states are hidden, because their other end is outside the filter. Click **Delete filter** when you are done.

**One airport and everywhere it flies**

1. **Add filter** > **Ego network**.
2. In the **Ego node** box, type an airport code (like `CLE`) and press Enter.
3. The map shows that airport plus every airport it flies to nonstop. The top-left panel shows how many airports are left.
4. Click **Delete filter** to see everything again.

---

## Step 7: Save a picture

1. Arrange the view the way you want it.
2. Click **Workspace** > **Export image**.
3. Name the file `lastname_flights.png` (with your last name).
4. Check **Preserve current camera position** to save exactly what is on your screen.
5. Click **Save**. The picture goes to your Downloads folder.

---

## If something goes wrong

| Problem | Fix |
|---|---|
| The graph is gone or the screen is empty | Click **See the whole graph** (bottom-right). |
| Still empty, or the screen went blank after using the Data tab | Refresh the browser page. Gephi Lite remembers your graph and settings. |
| The map looks random after Step 2 | Check the code: `attributes.longitude` and `attributes.latitude` must be spelled exactly like that. Click **Save and run** again. |
| The map is upside down or sideways | Longitude goes with `x` and latitude goes with `y`. Make sure they are not swapped. |
| The circles are all huge | In Step 4, check **Interpolate between custom min and max values** and set Min and Max. |
| The old graph shows up instead of the new file | **Workspace** > **Open...** and open the file again. |
