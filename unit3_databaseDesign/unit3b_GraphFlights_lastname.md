**Before you start:** rename this file to `unit3b_GraphFlights_lastname.md`, using your own last name. Read `unit3b_GraphFlights_Walkthrough.md` first and follow its steps in Gephi Lite. Commit and push when you're done.

**Name:**

---

# Unit 3b Extension — Finding Airline Hubs

## 1. The biggest hubs

Sort the Data tab by **degree** (highest first). Fill in the top 5.

| Rank | Airport code | City | State | Degree |
|:-:|---|---|:-:|:-:|
| 1 | | | | |
| 2 | | | | |
| 3 | | | | |
| 4 | | | | |
| 5 | | | | |

**a.** In your own words, what does an airport's degree number mean in this network?

**Answer:**


## 2. Degree vs. weighted degree

Now sort by **weightedDegree** (highest first).

**b.** List the top 5 airport codes by weighted degree.

**Answer:**


**c.** Did the order change from your degree list? Name one airport that moved up or down, and explain what weighted degree counts that plain degree does not.

**Answer:**


## 3. Betweenness

Sort by **betweennessCentrality** (highest first).

**d.** Which airport is #1 for betweenness? Is it also #1 for degree?

**Answer:**


**e.** Look at where that airport sits on the map. Why might so many shortest trips pass through it? (Hint: think about trips from one side of the country to the other.)

**Answer:**


## 4. Ohio

**f.** Use the **state** filter with `OH`. How many Ohio airports are in the network? Which one has the highest degree?

**Answer:**


**g.** Delete the state filter. Use an **ego network** on `CLE` (Cleveland). How many airports are in Cleveland's ego network, counting Cleveland itself? Name three hubs from your top-5 list that Cleveland flies to nonstop.

**Answer:**


**h.** Someone in Medina wants to fly to a small airport that Cleveland does not fly to nonstop. Based on this network, what would their trip probably look like?

**Answer:**


## 5. The map

**i.** Look at the map with nodes sized by degree. Describe where the biggest hubs are located. Are they spread evenly across the country?

**Answer:**


## 6. What this data can't tell you

**j.** This data is from 2014 and counts routes, not passengers. Name one question about airports that this network **cannot** answer, and what data you would need to answer it.

**Answer:**


## 7. Your map

Export your finished map from Gephi Lite (Workspace > Export image) as `lastname_flights.png`. Put the picture in the same folder as this file, then replace `lastname_flights.png` below with your file's name so it shows on GitHub.

![My flight network](lastname_flights.png)
