---
marp: true
theme: default
class: invert
paginate: true
---

# Database Applications Development

## Software Engineering | Medina County Career Center

---

## Why Learn Python & Data Tools?

Programmers use Python to **read, organize, and make sense of data** every day.

- Build web apps that store user information
- Analyze sales trends for businesses
- Process millions of records automatically
- Create tools that save companies millions of dollars

**Your goal:** Learn to write code that handles real data like a professional developer.

---

## What is JupyterLab?

**JupyterLab** is a tool where you write and run code in a web browser.

- Files are called **notebooks** (`.ipynb`)
- Code runs in small chunks called **cells**
- You see results right below each cell
- Used by data analysts and developers in the real world

**To create a notebook:** File → New → Notebook → Python 3

---

## Two Types of Cells

When you open a notebook, you'll work with two kinds of cells:

**Code Cell** — Runs Python code
- Has `[ ]:` on the left
- Press **Shift + Enter** to run

**Markdown Cell** — Displays formatted text and notes
- No brackets
- Press **Shift + Enter** to render

```python
# This is a code cell
print("Hello!")
```

**Tip:** Use markdown cells for notes and explanations in your notebooks.

---

## What is a Variable?

A **variable** is a box that stores a value you can use later.

```python
studentName = "Alice"
```

Think of it like naming a drawer in a filing cabinet. You put something in, give it a label, and get it back anytime you need it.

---

## Four Basic Data Types

Python has four main types of data you'll use:

```python
studentName = "Alice"      # str   → text
studentAge = 17            # int   → whole number
studentGPA = 3.75          # float → decimal number
isEnrolled = True          # bool  → True or False
```

**Check the type of anything:**
```python
type(studentName)   # <class 'str'>
type(studentAge)    # <class 'int'>
```

> **Key idea:** Every value in Python is one of these four types. Know your types!

---

## Using print() to See Your Work

The **`print()`** function displays output to the screen.

```python
print("Hello, Database Applications!")
```

You can print multiple things:
```python
print("Name:", studentName)
print("Age:", studentAge)
```

This is how you see what your code is doing.

---

## Comments: Talk to Future You

**Comments** are notes in your code that Python ignores.

```python
# This is a single-line comment
studentAge = 17   # You can also comment at the end of a line
```

> **The Golden Rule:** Write comments to explain *why* you're doing something, not just *what* you're doing.

---

## How to Name Variables Well

A **naming convention** is a rule for how you name variables.

| Convention | Example | When We Use It |
|-----------|---------|---------|
| **camelCase** | `studentName` | Variables (this class) |
| **snake_case** | `student_name` | Python community standard |
| **PascalCase** | `StudentName` | Class names |

**In this class, use camelCase for variables.**

**Key rules:**
- Start with a letter
- No spaces allowed
- Be descriptive

```python
x = 17              # Bad — what is x?
studentAge = 17     # Good — clear meaning
```

---

## Math in Python

Python works like a calculator. Here are the basic operations:

| Operator | Meaning | Example |
|----------|---------|---------|
| `+` | Add | `5 + 3` → `8` |
| `-` | Subtract | `10 - 4` → `6` |
| `*` | Multiply | `3 * 7` → `21` |
| `/` | Divide | `15 / 4` → `3.75` |
| `**` | Power | `2 ** 3` → `8` |

---

## Real-World Math Example

Let's calculate the total cost of tickets:

```python
ticketPrice = 12.50
numTickets = 4
totalCost = ticketPrice * numTickets
print(totalCost)    # Prints: 50.0
```

Python evaluates right-to-left, stores the answer in `totalCost`, and you can use it later.

---

## What is pandas?

**pandas** is a library for working with data in tables (like Excel spreadsheets).

When you load a CSV file into pandas, it becomes a **DataFrame** — a fancy table you can analyze.

```python
import pandas as pd
titanic = pd.read_csv("Titanic Dataset.csv")
```

> **pandas = Professional Data Tool**

---

## Exploring Data with pandas

Once you load data, you can explore it with simple commands:

```python
titanic.head()       # Show first 5 rows
titanic.shape        # How many rows and columns?
titanic.info()       # Column names and data types
titanic.describe()   # Statistics: mean, min, max
```

These commands help you understand what data you have before you analyze it.

---

## What is Version Control?

**Version control** tracks every change you make to your files over time.

Think of it like:
- Google Docs showing edit history
- But for all your code and files
- With a clear record of who changed what and when

**Git** is the tool. **GitHub** is where your files are stored online.

---

## Key Version Control Terms

| Term | Meaning |
|------|---------|
| **Repository (repo)** | Your project folder, tracked by Git |
| **Commit** | A saved snapshot of your work |
| **Push** | Upload your commits to GitHub |
| **Pull** | Download changes from GitHub |

**Our workflow in this class:**

1. Write code in your notebook
2. Save your file
3. Commit with a message ("Fixed bug" or "Added new feature")
4. Push to GitHub

Do this after every class session.

---

## Key Takeaways

- **JupyterLab** is where you write and run Python code interactively
- **Variables** store values; use **camelCase** names
- **Four data types:** strings, integers, floats, and booleans
- **pandas** lets you load and explore real data
- **Git & GitHub** track your work and keep it safe online

Next up: Write your first Python programs and practice these fundamentals!
