# dbApps01 Study Guide: Python & JupyterLab Fundamentals

**Course:** Database Applications Development (145085)
**Lesson:** 01 — Python & JupyterLab Fundamentals
**Dataset:** Titanic Dataset.csv

---

## Learning Objectives

After completing this lesson, you should be able to:

1. Open JupyterLab and create a new notebook
2. Explain the difference between code cells and markdown cells
3. Create variables using the four basic Python data types
4. Use `print()` to display output and `type()` to check data types
5. Write comments to explain your code
6. Perform basic arithmetic operations in Python
7. Import the pandas library and load a CSV file
8. Use `.head()`, `.shape`, `.info()`, `.describe()`, and `.columns` to explore data
9. Apply proper naming conventions (camelCase)
10. Explain what version control is and define key Git terms

---

## Key Vocabulary

| Term | Definition |
|------|-----------|
| **JupyterLab** | An interactive development environment for writing and running Python code in a web browser |
| **Notebook** | A JupyterLab file (`.ipynb`) that contains code cells and markdown cells |
| **Code Cell** | A cell that runs Python code and shows the result below |
| **Markdown Cell** | A cell that displays formatted text (headings, bold, lists, etc.) |
| **Variable** | A named container that stores a value |
| **Data Type** | The kind of data a variable holds (str, int, float, bool) |
| **String (str)** | Text data, always in quotes — `"hello"` |
| **Integer (int)** | A whole number with no decimal — `17` |
| **Float (float)** | A number with a decimal point — `3.75` |
| **Boolean (bool)** | A True or False value — `True` |
| **Comment** | Text in code that Python ignores, starts with `#` |
| **Library** | Pre-built code you can import and use (e.g., pandas) |
| **pandas** | A Python library for working with tabular data |
| **DataFrame** | A pandas object that holds data in rows and columns (like a spreadsheet) |
| **CSV** | Comma-Separated Values — a common file format for storing tabular data |
| **Naming Convention** | A standard rule for how to name variables and other things in code |
| **camelCase** | A naming convention where the first word is lowercase and each additional word starts uppercase: `studentName` |
| **snake_case** | A naming convention using lowercase with underscores between words: `student_name` |
| **PascalCase** | A naming convention where every word starts uppercase: `StudentName` |
| **Version Control** | A system that tracks changes to files over time |
| **Git** | A version control tool that tracks your code changes locally |
| **GitHub** | A website that hosts Git repositories online |
| **Repository (repo)** | A project folder that is tracked by Git |
| **Commit** | A saved snapshot of your work at a point in time |
| **Push** | Uploading your local commits to GitHub |
| **Pull** | Downloading changes from GitHub to your computer |

---

## Concept Review

### JupyterLab Basics

JupyterLab is where we write all our code in this course. Notebooks let you mix code and text in the same file. You run code cells by pressing **Shift + Enter**. Results appear directly below the cell. Markdown cells let you write formatted notes — headings, bold, lists, tables — to document your work.

### Variables and Data Types

Variables are how you store information in Python. You create one by choosing a name and assigning a value with `=`. Python automatically figures out the data type based on what you assign. The four basic types you need to know:

- **str** — text, always wrapped in quotes: `"Alice"`
- **int** — whole numbers without decimals: `17`
- **float** — numbers with a decimal point: `3.75`
- **bool** — either `True` or `False` (capitalized)

Use `type(variableName)` to check what type a variable is.

### print() and Comments

`print()` displays values to the screen. You can print text, variables, or a mix:

```python
print("Hello!")
print("Age:", studentAge)
print(f"My name is {studentName}")
```

Comments start with `#`. Python skips them entirely. Use comments to explain **why** your code does something, not just **what** it does. This is especially important when someone else needs to read your code.

### Naming Conventions

In this class we use **camelCase** for variable names: the first word is lowercase and each additional word starts with a capital letter. Examples: `studentName`, `ticketPrice`, `numTickets`, `isEnrolled`.

Naming rules in Python: variable names must start with a letter (or underscore), cannot contain spaces, and are case-sensitive (`studentAge` and `studentage` are different variables). Always pick descriptive names — `x` is bad, `studentAge` is good.

### Basic Arithmetic

Python supports standard math operators: `+` (add), `-` (subtract), `*` (multiply), `/` (divide), `**` (exponent). Python follows the normal order of operations (PEMDAS). Use parentheses to control the order if needed.

### pandas and DataFrames

pandas is a Python library that makes it easy to work with tabular data (rows and columns). You import it with `import pandas as pd`. A **DataFrame** is the main pandas data structure — think of it as a spreadsheet loaded into Python. You load a CSV file with `pd.read_csv("filename.csv")`.

### Exploring Data

Once data is loaded into a DataFrame, use these methods to explore it:

| Method | What it does |
|--------|-------------|
| `.head()` | Shows the first 5 rows (or pass a number for more) |
| `.tail()` | Shows the last 5 rows |
| `.shape` | Returns (number of rows, number of columns) |
| `.info()` | Shows column names, data types, and missing value counts |
| `.describe()` | Shows statistics (mean, min, max, etc.) for number columns |
| `.columns` | Lists all column names |

### Version Control

Version control is a system that records changes to files over time so you can go back to earlier versions if needed. **Git** is the most popular version control tool. **GitHub** is a website that stores your Git projects online.

Our class workflow is: do your work → save the file → **commit** (take a snapshot) → **push** (upload to GitHub). A **repository** is just a folder that Git is tracking. Every time you commit, Git saves a record of what changed, when, and who made the change.

---

## Titanic Dataset — Data Dictionary

This is the dataset we use in Lessons 01–04. Here is every column and what it means:

| Column | Description | Data Type | Example Values |
|--------|-------------|-----------|----------------|
| **pclass** | Passenger class (ticket class) | int | 1 = First, 2 = Second, 3 = Third |
| **survived** | Whether the passenger survived | int | 0 = No, 1 = Yes |
| **name** | Full name | str | "Braund, Mr. Owen Harris" |
| **sex** | Gender | str | "male" or "female" |
| **age** | Age in years | float | 22.0, 38.0, 26.0 |
| **sibsp** | Siblings/spouses aboard | int | 0, 1, 2 |
| **parch** | Parents/children aboard | int | 0, 1, 2 |
| **ticket** | Ticket number | str | "A/5 21171" |
| **fare** | Ticket price in British pounds | float | 7.25, 71.28 |
| **cabin** | Cabin number | str | "C85", "E46" |
| **embarked** | Port of embarkation | str | C = Cherbourg, Q = Queenstown, S = Southampton |
| **boat** | Lifeboat number (if survived) | str | "13", "4" |
| **body** | Body ID number (if recovered) | float | 135.0 |
| **home.dest** | Home/destination | str | "New York, NY" |

**Note:** Some columns have missing values (`NaN` = Not a Number). This is normal in real-world data.

---

## Quick Reference Card

### Creating Variables
```python
studentName = "Alice"      # str
studentAge = 17            # int
studentGPA = 3.75          # float
isEnrolled = True          # bool
```

### Printing Output
```python
print("Hello!")
print("Name:", studentName)
print(f"Age is {studentAge}")
```

### Checking Data Types
```python
type(studentName)   # <class 'str'>
type(studentAge)    # <class 'int'>
```

### Math Operators
```
+   Addition         5 + 3    → 8
-   Subtraction      10 - 4   → 6
*   Multiplication   3 * 7    → 21
/   Division         15 / 4   → 3.75
**  Exponent         2 ** 3   → 8
```

### Loading and Exploring Data
```python
import pandas as pd
titanic = pd.read_csv("Titanic Dataset.csv")
titanic.head()
titanic.shape
titanic.info()
titanic.describe()
titanic.columns
```

### Git Workflow
```
Save file → git add filename → git commit -m "message" → git push
```

---

## ODE Competencies Covered

| Competency | Description |
|-----------|-------------|
| 5.1.1 | Describe how programs solve problems |
| 5.1.8 | Version control and documentation |
| 5.2.1 | Primitive data types (int, float, bool, str) |
| 5.2.2 | Scope of data (variables, constants) |
| 5.2.3 | Arithmetic operations |
| 5.4.1 | Configure IDE options (JupyterLab) |
| 5.4.2 | Write and edit code in IDE |
| 5.5.2 | Reuse libraries (pandas) |
| 5.5.5 | Naming conventions and comments |
