# dbApps06b: Normalization Task
## Normalize a Pizza Shop Database

**Database Applications Development**
**Medina County Career Center | Instructor: Ryan McMaster**

---

## Background

Right now, Sal's Pizza tracks all their orders in one big spreadsheet. Every time a customer places an order, an employee types the customer's name, phone number, email, the item they ordered, the item's price, and the quantity — all into one row. If a customer orders three items, that's three rows with the same customer info copied each time.

Open `dbApps06b_NormalizationActivity.xlsx` and look at the **Flat_Table_Orders** sheet to see what this looks like.

---

## Part 1: Spot the Problem

Look at the flat table and answer these questions (write your answers on paper or discuss with your group):

1. How many times does Maria Santos's phone number appear in the table?
2. How many times is the Pepperoni Pizza price ($12.99) stored?
3. If Maria changes her email address, how many rows would you have to update?
4. What happens if you make a typo updating one row but not the others?

---

## Part 2: Identify the Entities

The flat table mixes together attributes from three different **entities** (remember — an entity is a person, place, thing, or event you want to store information about). Your job is to figure out what those entities are.

Ask yourself: **"What entity does each attribute belong to?"**

For each column (attribute) in the flat table, decide which entity it belongs to:

| Attribute (Column) | Which entity does this belong to? |
|---|---|
| order_date | ? |
| customer_name | ? |
| customer_phone | ? |
| customer_email | ? |
| item_name | ? |
| item_category | ? |
| item_price | ? |
| quantity | ? |

You should end up with **3 distinct entities**. Each entity will become its own table, and each column becomes an **attribute** of that entity.

---

## Part 3: Design Your Schema (On Paper)

Grab a blank sheet of paper. For each of your 3 entities:

1. **Name the entity/table** — Pick a clear, descriptive name
2. **List the attributes** — Which attributes from the flat table belong to this entity?
3. **Add a Primary Key (PK)** — Create a unique ID attribute for each entity (this won't exist in the flat table — you're creating it)
4. **Identify Foreign Keys (FK)** — Which entity connects the other two? What FKs does it need?

Draw your 3 entities as boxes with the attributes listed inside. Draw arrows from each FK to the PK it points to.

**Remember:**
- A **Primary Key (PK)** uniquely identifies each row — no duplicates allowed
- A **Foreign Key (FK)** is a column that points to another table's PK — it's how tables connect
- The goal: each fact is stored exactly **once**

---

## Part 4: Build It in Excel

Switch to the **Your_Schema** sheet in the Excel file. Transfer your paper sketch into the 3 table templates:

- Fill in the **table name** for each table
- For each column, fill in:
  - **Key?** — Write `PK` or `FK` if applicable, leave blank otherwise
  - **Column Name** — The name of the column
  - **Data Type** — `INT` (whole numbers), `TEXT` (words), or `REAL` (decimals/money)
  - **Description** — A short note about what this column stores
- At the bottom, fill in the **Relationships** section describing how your FKs connect to PKs

---

## How You Know You Got It Right

Check your design against these rules:

- [ ] You have exactly **3 tables**
- [ ] Each table has a **Primary Key** that uniquely identifies every row
- [ ] Each entity's attributes are only in that entity's table (no customer info in the menu table)
- [ ] One table acts as a **bridge** connecting the other two using Foreign Keys
- [ ] If a customer changes their phone number, you only update **one row** in the customer entity's table
- [ ] If a menu item's price changes, you only update **one row** in the menu item entity's table

---

