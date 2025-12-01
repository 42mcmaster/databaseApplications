---
marp: true
theme: default
class: invert
paginate: true
---

# Lesson 01: Introduction to JupyterLab & Python Fundamentals

## Database Applications Development
### Software Engineering | Medina County Career Center

---

## Learning Objectives

By the end of this lesson, you will be able to:

- Navigate the JupyterLab interface
- Create and execute code cells
- Work with Python variables and data types
- Perform basic operations and calculations
- Use print statements and comments effectively
- Install and import Python libraries

---

## What is JupyterLab?

**JupyterLab** is an interactive development environment designed for data science and programming.

**Key Features:**
- Write and execute code in "cells"
- Mix code, text, and visualizations in one document
- See results immediately (interactive)
- Great for data analysis and learning
- Industry-standard tool for data scientists

**File Extension:** `.ipynb` (Interactive Python Notebook)

---

## Why JupyterLab for Database Work?

Notebooks are perfect for database applications because:

1. **Explore data interactively** - Run queries and see results immediately
2. **Document your work** - Add explanations alongside code
3. **Visualize results** - Create charts and graphs inline
4. **Share analysis** - Notebooks are easy to share and reproduce
5. **Industry standard** - Used by data analysts, scientists, and developers

We'll use notebooks to learn Python, SQL, and database concepts together.

---

## JupyterLab Interface Tour

**Main Components:**

1. **File Browser** (left sidebar) - Navigate your files
2. **Notebook Area** (center) - Where you write code
3. **Cells** - Individual blocks of code or text
4. **Toolbar** - Run, stop, and manage cells
5. **Kernel** - The Python engine running your code

**Getting Started:** File → New → Notebook → Select Python 3

---

## Understanding Cells

JupyterLab notebooks have two main cell types:

**Code Cells** (default)
- Write and execute Python code
- Results appear directly below
- Press `Shift + Enter` to run

**Markdown Cells**
- Write formatted text, headings, lists
- Great for documentation and explanations
- Change cell type: Menu → Cell → Cell Type → Markdown

---

## Your First Code Cell

Let's start simple:

```python
print("Hello, Database Applications!")
```

**To run this code:**
1. Click on the cell
2. Press `Shift + Enter` (or click the ▶ Run button)
3. The output appears below the cell

**Try it yourself:** Type the code above and run it.

---

## Python Variables

**Variables** store data that you can use later in your program.

```python
# Creating variables
student_name = "Ryan"
course_code = 145085
passing_grade = 70.0
is_enrolled = True
```

**Naming Rules:**
- Start with letter or underscore
- Use letters, numbers, underscores
- Case-sensitive (`name` ≠ `Name`)
- Use descriptive names (`student_count` not `sc`)

---

## Python Data Types

Python has several built-in data types:

| Type | Example | Description |
|------|---------|-------------|
| `str` | `"Hello"` | Text (string) |
| `int` | `42` | Whole number |
| `float` | `3.14` | Decimal number |
| `bool` | `True` or `False` | Boolean (true/false) |

```python
# Check a variable's type
name = "Alice"
print(type(name))  # Output: <class 'str'>
```

---

## Data Types in Action

```python
# String
passenger_name = "John Smith"

# Integer
passenger_class = 3

# Float
ticket_fare = 7.25

# Boolean
survived = True

# Print everything
print("Passenger:", passenger_name)
print("Class:", passenger_class)
print("Fare: $", ticket_fare)
print("Survived:", survived)
```

---

## Why Data Types Matter for Databases

Understanding data types is crucial for database work:

- **Databases require specific data types** for each column
- **SQL has similar data types:** VARCHAR (text), INTEGER, FLOAT, BOOLEAN
- **Type mismatches cause errors** - can't add text + number
- **Performance matters** - integers take less space than text
- **Data integrity** - enforcing correct types prevents bad data

We'll see this again when we create database tables!

---

## Basic Math Operations

Python can perform calculations just like a calculator:

```python
# Basic arithmetic
addition = 10 + 5          # 15
subtraction = 10 - 5       # 5
multiplication = 10 * 5    # 50
division = 10 / 5          # 2.0 (always returns float)
integer_division = 10 // 3 # 3 (returns integer)
modulus = 10 % 3           # 1 (remainder)
exponent = 2 ** 3          # 8 (2 to the power of 3)
```

---

## Operations with Variables

```python
# Calculate total fare for a family
adult_fare = 15.50
child_fare = 8.25
number_of_adults = 2
number_of_children = 3

total_fare = (adult_fare * number_of_adults) + (child_fare * number_of_children)

print("Total fare: $", total_fare)  # Output: Total fare: $ 55.75
```

**Key Concept:** Use descriptive variable names to make code readable!

---

## Order of Operations

Python follows standard mathematical order (PEMDAS):

1. **P**arentheses
2. **E**xponents
3. **M**ultiplication / **D**ivision (left to right)
4. **A**ddition / **S**ubtraction (left to right)

```python
result1 = 5 + 3 * 2      # 11 (multiply first)
result2 = (5 + 3) * 2    # 16 (parentheses first)
result3 = 10 / 2 + 3     # 8.0 (left to right)
```

---

## String Operations

Strings (text) have special operations:

```python
# Concatenation (joining strings)
first_name = "John"
last_name = "Smith"
full_name = first_name + " " + last_name
print(full_name)  # John Smith

# Repetition
line = "-" * 40
print(line)  # ----------------------------------------

# String length
name = "Elizabeth"
print(len(name))  # 9
```

---

## Print Statements

The `print()` function displays output:

```python
# Simple print
print("Hello World")

# Multiple items (separated by commas)
print("Name:", "Alice", "Age:", 25)

# Variables
score = 95
print("Your score is:", score)

# Formatted strings (f-strings)
name = "Bob"
grade = 88
print(f"{name} earned a grade of {grade}%")
```

---

## Comments: Documenting Your Code

**Comments** explain what your code does (ignored by Python):

```python
# This is a single-line comment

age = 25  # You can also put comments at the end of lines

"""
This is a multi-line comment.
Use it to explain complex logic
or document functions.
"""

# Good comments explain WHY, not just WHAT
survived_count = 0  # Track survivors for final statistics
```

**Best Practice:** Write comments that help others (or future you) understand your thinking.

---

## Installing and Importing Libraries

Python has thousands of libraries (pre-written code) we can use:

```python
# Import a library
import pandas as pd
import sqlite3

# Use library functions
# We'll use pandas to work with data
# We'll use sqlite3 to work with databases
```

**Key Libraries for Database Work:**
- `pandas` - Data analysis and manipulation
- `sqlite3` - Working with SQLite databases
- `matplotlib` - Creating charts and graphs

---

## Installing New Libraries

If a library isn't installed, use `pip`:

```python
# Run this in a code cell (only needed once)
!pip install pandas
```

**Note:** The `!` tells Jupyter to run a system command, not Python code.

Most common libraries (like pandas) are pre-installed in Jupyter environments.

---

## Pandas: Your Data Analysis Tool

**Pandas** is Python's most popular data analysis library:

```python
import pandas as pd

# Load a CSV file
data = pd.read_csv("Titanic_Dataset.csv")

# Look at first few rows
print(data.head())

# Get basic information
print(data.info())
```

We'll use pandas extensively to explore datasets before moving them into databases.


---

## Best Practices for Notebooks

1. **Use descriptive names** - `titanic_analysis.ipynb` not `notebook1.ipynb`
2. **Add markdown cells** - Explain what your code does
3. **Run cells in order** - Top to bottom
4. **Restart kernel if confused** - Kernel → Restart Kernel
5. **Save frequently** - Auto-save isn't always reliable
6. **Keep it organized** - One analysis per notebook

---

## GitHub Submission Workflow

For this course, you'll submit notebooks via GitHub:

1. **Create repository:** `databaseApplications`
2. **Work in JupyterLab** on your local machine
3. **Save your notebook** with naming convention: `taskXX_trackX.ipynb`
4. **Add, commit, push** to GitHub
5. **Verify** your file appears on GitHub

```bash
git add task01_trackA.ipynb
git commit -m "Complete Lesson 01 task"
git push origin main
```

---

## Connection to Database Applications

Everything we learned today builds toward database work:

- **Variables** → Store query results
- **Data types** → Match database column types
- **Math operations** → Calculate aggregations
- **Strings** → Build SQL queries dynamically
- **Pandas** → Load, clean, and analyze data before/after databases
- **Comments** → Document complex queries and logic

---

## Lesson 01 Task Overview

**What You'll Do:**

**Track A:** Practice Python basics with variables, data types, and simple operations. Load and explore the Titanic dataset.

**Track B:** Everything in Track A PLUS more advanced pandas operations and data analysis.

**Submission:**
- Complete `task01_trackA.ipynb` OR `task01_trackB.ipynb`
- Push to your `databaseApplications` repository on GitHub
- Due: Next class

---

## Key Takeaways

- ✅ JupyterLab is an interactive environment for data analysis and learning
- ✅ Python variables store data with specific types (str, int, float, bool)
- ✅ Data types in Python mirror database column types
- ✅ Use comments to explain your thinking
- ✅ Libraries like pandas extend Python's capabilities
- ✅ Notebooks combine code, results, and documentation

---

## Questions?

Before you start the task, let's clarify anything:

- JupyterLab interface unclear?
- Questions about data types?
- Confused about variables?
- GitHub submission process?

