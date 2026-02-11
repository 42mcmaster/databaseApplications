---
marp: true
theme: default
class: invert
paginate: true
---

# Lesson 01: Python & JupyterLab Fundamentals

## Database Applications Development
### Medina County Career Center

---

<!-- _header: "Sub-Lesson 01a — JupyterLab Tour" -->

## What is JupyterLab?

**JupyterLab** is a tool where you write and run code in a web browser.

- Files are called **notebooks** (`.ipynb`)
- Code runs in small chunks called **cells**
- You see results right below each cell
- Used by data analysts and developers in the real world

**To create a notebook:** File → New → Notebook → Python 3

---

<!-- _header: "Sub-Lesson 01a — JupyterLab Tour" -->

## Two Types of Cells

| Code Cell | Markdown Cell |
|-----------|--------------|
| Runs Python code | Displays formatted text |
| Has `[ ]:` on the left | No brackets |
| Press **Shift + Enter** to run | Press **Shift + Enter** to render |

```python
# This is a code cell
print("Hello!")
```

**Tip:** Use markdown cells for notes and explanations in your notebooks.

> **01a Task:** JupyterLab Scavenger Hunt

---

<!-- _header: "Sub-Lesson 01b — Variables, Types, print(), Comments" -->

## Variables & Data Types

A **variable** stores a value you can use later. Python has four basic types:

```python
studentName = "Alice"      # str   → text
studentAge = 17            # int   → whole number
studentGPA = 3.75          # float → decimal number
isEnrolled = True          # bool  → True or False
```

Check any type with `type()`:
```python
type(studentName)   # <class 'str'>
```

---

<!-- _header: "Sub-Lesson 01b — Variables, Types, print(), Comments" -->

## print() and Comments

**`print()`** displays output to the screen:
```python
print("Hello, Database Applications!")
print("Age:", studentAge)
```

**Comments** explain your code (Python ignores them):
```python
# This is a single-line comment
studentAge = 17   # You can also comment at the end
```

> **Rule:** Always comment your code so others (and future you) can understand it.

---

<!-- _header: "Sub-Lesson 01b — Variables, Types, print(), Comments" -->

## Naming Conventions

A **naming convention** is a rule for how you name variables, files, and functions.

| Convention | Example | Used In |
|-----------|---------|---------|
| **camelCase** | `studentName` | JavaScript, Java, our class |
| **snake_case** | `student_name` | Python community standard |
| **PascalCase** | `StudentName` | Class names |

**In this class we use camelCase** for variable names.

**Key rules:** Start with a letter, no spaces, be descriptive.
- `x = 17` ← Bad (what is x?)
- `studentAge = 17` ← Good (clear meaning)

> **01b Task:** Variable Practice Exercises (use walkthrough as reference)

---

<!-- _header: "Sub-Lesson 01c — pandas, Arithmetic, Loading Data" -->

## Basic Math in Python

Python works like a calculator:

| Operator | Meaning | Example | Result |
|----------|---------|---------|--------|
| `+` | Add | `5 + 3` | `8` |
| `-` | Subtract | `10 - 4` | `6` |
| `*` | Multiply | `3 * 7` | `21` |
| `/` | Divide | `15 / 4` | `3.75` |
| `**` | Power | `2 ** 3` | `8` |

```python
ticketPrice = 12.50
numTickets = 4
totalCost = ticketPrice * numTickets   # 50.0
```

---

<!-- _header: "Sub-Lesson 01c — pandas, Arithmetic, Loading Data" -->

## Importing Libraries & Loading Data

**pandas** is a library for working with data (tables, spreadsheets, CSVs):

```python
import pandas as pd
titanic = pd.read_csv("Titanic Dataset.csv")
```

**Explore your data:**
```python
titanic.head()       # First 5 rows
titanic.shape        # (rows, columns)
titanic.info()       # Column names, types, missing values
titanic.describe()   # Stats: mean, min, max, etc.
```

> **01c Task:** Complete the dbApps01 DIY Task

---

<!-- _header: "Sub-Lesson 01c — pandas, Arithmetic, Loading Data" -->

## Version Control & Git Basics

**Version control** tracks changes to your files over time.

**Git** is the tool. **GitHub** is where your files are stored online.

| Term | Meaning |
|------|---------|
| **Repository (repo)** | A project folder tracked by Git |
| **Commit** | A saved snapshot of your work |
| **Push** | Upload your commits to GitHub |
| **Pull** | Download changes from GitHub |

**Our workflow:** Save → Commit → Push to GitHub after every class.

> **01d:** Gimkit Review Game + finish any outstanding work
