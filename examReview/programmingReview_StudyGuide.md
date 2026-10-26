# Programming Review Study Guide — WebXam Strand 5

**This guide covers the programming part of the Database Applications WebXam (145085).** About 13 of the 45 questions on the test come from these topics. You have seen most of this before. This is a review, not a new unit.

Every code example is in **Python**, and every example was actually run, so the output shown is real. The WebXam may show code in a different language or in pseudocode (plain-English code). The ideas are the same in every language: if you can read the Python here, you can read the exam's version.

Most exam questions in this strand look like one of these:

- "What does this code print?"
- "How many times does this loop run?"
- "What is the result of this expression?"
- "Which term describes ___?"

So the goal is to **read and trace** code, not to write big programs.

---

## Contents

1. [What programs are for](#1-what-programs-are-for)
2. [Compilers and interpreters](#2-compilers-and-interpreters)
3. [Styles of programming](#3-styles-of-programming)
4. [Planning a program before you code](#4-planning-a-program-before-you-code)
5. [Data types](#5-data-types)
6. [Variables, constants, lists, and scope](#6-variables-constants-lists-and-scope)
7. [Arithmetic operators](#7-arithmetic-operators)
8. [String operations](#8-string-operations)
9. [Boolean logic and truth tables](#9-boolean-logic-and-truth-tables)
10. [Relational operators and compound conditions](#10-relational-operators-and-compound-conditions)
11. [if, elif, and else](#11-if-elif-and-else)
12. [Loops: for and while](#12-loops-for-and-while)
13. [Selection: match and case (switch)](#13-selection-match-and-case-switch)
14. [Nested structures and recursion](#14-nested-structures-and-recursion)
15. [Functions](#15-functions)
16. [Error handling: try and except](#16-error-handling-try-and-except)
17. [Classes, objects, and methods](#17-classes-objects-and-methods)
18. [Reading data from a database with code](#18-reading-data-from-a-database-with-code)
19. [Testing and debugging](#19-testing-and-debugging)
20. [Programming conventions and secure coding](#20-programming-conventions-and-secure-coding)
21. [Version control and the software development life cycle](#21-version-control-and-the-software-development-life-cycle)
22. [Practice questions](#22-practice-questions)
23. [Vocabulary](#23-vocabulary)

---

## 1. What programs are for

A **program** is a set of instructions a computer follows to solve a problem. A **script** is a short program that usually automates one task, like renaming 500 files or loading a CSV into a database.

Programs run in many places:

| Where it runs | Example |
|---|---|
| Desktop | Excel, DB Browser for SQLite |
| Mobile | A banking app on a phone |
| Enterprise | A school's student-information system used by every building |
| Cloud | Google Docs, running on Google's servers |
| AI | A chatbot or a model that predicts which students need help |

**Algorithm:** a step-by-step set of instructions for solving a problem. A recipe is an algorithm.

**Data structure:** a way of organizing data so a program can use it. A list, a table, and a dictionary are all data structures.

An algorithm works **on** a data structure. Example: "sort this list of scores from high to low" is an algorithm (sorting) working on a data structure (a list).

---

## 2. Compilers and interpreters

Computers only understand **machine code** (1s and 0s). People write **source code** (Python, Java, C++). Something has to translate it.

| | Compiler | Interpreter |
|---|---|---|
| How it translates | The **whole program at once**, before it runs | **One line at a time**, while it runs |
| What it makes | A separate executable file (like an `.exe`) | No separate file |
| Speed when running | Faster | Slower |
| When you see errors | All at once, before the program runs | When the program reaches the bad line |
| Languages | C, C++, Java (compiles to bytecode) | Python, JavaScript |

**Easy way to remember:** a compiler is like translating a whole book before anyone reads it. An interpreter is like a live translator at a speech, translating sentence by sentence.

---

## 3. Styles of programming

A programming style (also called a **paradigm**) is a way of organizing code.

| Style | The idea | Example |
|---|---|---|
| **Procedural** | A list of steps run from top to bottom, often broken into procedures (functions) | A script that reads a file, cleans it, then saves it |
| **Structured** | Procedural code that uses only clear structures (sequence, decisions, loops) instead of jumping around | Almost all modern code |
| **Object-oriented (OO)** | Code is built from **objects** that hold their own data and methods | A `Student` object with a name, a grade, and a `print_report()` method |
| **Event-driven** | Code waits and runs when something **happens** (a click, a key press, a sensor reading) | A button's "on click" code in a web page or game |

**Choosing a language:** no language is best at everything.

| Language | Strong at | Weaker at |
|---|---|---|
| Python | Data, AI, scripts; easy to read | Slower than compiled languages |
| JavaScript | Web pages and web apps | Not used much for data science |
| SQL | Getting data out of databases | Not a general-purpose language |
| C++ | Speed (games, hardware) | Harder to learn; easier to make memory mistakes |
| Java | Large enterprise apps, Android | More code to write for simple things |

---

## 4. Planning a program before you code

You plan the solution first, then write the code. These tools help.

**Flowchart:** a diagram of the steps. Each shape means something:

| Shape | Means |
|---|---|
| Oval | Start or end |
| Rectangle | A process (a step, like a calculation) |
| Diamond | A decision (yes/no question) |
| Parallelogram | Input or output |
| Arrow | The direction the steps go |

**Pseudocode:** plain-English steps that look like code but are not any real language.

```
GET score
IF score >= 70 THEN
    DISPLAY "Pass"
ELSE
    DISPLAY "Fail"
END IF
```

**IPO chart:** three columns: **Input**, **Process**, **Output**.

| Input | Process | Output |
|---|---|---|
| Price, quantity | Multiply price by quantity | Total cost |

**Other planning tools:**

- **UML** (Unified Modeling Language): diagrams for software, such as class diagrams that show each class and its data and methods.
- **Decision tree:** a branching diagram of yes/no questions that leads to an answer.
- **Logic table / truth table:** shows every possible combination of True and False (see [section 9](#9-boolean-logic-and-truth-tables)).
- **AI:** tools like ChatGPT or Gemini can help draft pseudocode or a flowchart, but a person still has to check it.

---

## 5. Data types

Every value has a **data type**. The type decides what you can do with it.

| Type | Holds | Examples | Python name |
|---|---|---|---|
| **Integer** | Whole numbers | `7`, `-3`, `2026` | `int` |
| **Float** | Numbers with a decimal point | `3.5`, `0.25`, `98.6` | `float` |
| **Boolean** | Only True or False | `True`, `False` | `bool` |
| **String** | Text, inside quotes | `"Medina"`, `"42"` | `str` |

**Numeric types** are integer and float. **Nonnumeric types** are Boolean and string.

**Watch out:** `"42"` in quotes is a **string**, not a number. You can't do math with it until you convert it.

```python
print(type(7))        # <class 'int'>
print(type(7.0))      # <class 'float'>
print(type(True))     # <class 'bool'>
print(type("7"))      # <class 'str'>

age = "16"            # a string, maybe typed in by a user
age = int(age)        # convert the string to an integer
print(age + 1)        # 17
```

These match the database types from Unit 4: integer = `INTEGER`, float = `REAL`, string = `TEXT`.

---

## 6. Variables, constants, lists, and scope

**Variable:** a named place to store a value. The value can change.

```python
score = 80       # store 80 in score
score = 95       # change it; score is now 95
```

**Constant:** a value that should **not** change while the program runs. Python doesn't lock constants, so programmers write the name in ALL CAPS as a signal.

```python
TAX_RATE = 0.0725    # constant: all caps means "don't change this"
```

**Array / list:** one variable that holds many values in order. Each value has a position number called an **index**. **Indexes start at 0.**

```python
teams = ["Cavs", "Browns", "Guardians"]
print(teams[0])      # Cavs       (first item is index 0)
print(teams[2])      # Guardians  (third item is index 2)
print(len(teams))    # 3          (how many items)
```

**Scope:** where in the program a variable can be used.

- **Global** variable: made outside any function. It can be used anywhere.
- **Local** variable: made inside a function. It only exists inside that function.

```python
school = "MCCC"              # global

def show():
    room = "B120"            # local: only exists inside show()
    print(school, room)

show()                       # MCCC B120
print(school)                # MCCC
# print(room)                # ERROR: room doesn't exist out here
```

---

## 7. Arithmetic operators

| Operator | Does | Example | Result |
|---|---|---|---|
| `+` | Add | `7 + 2` | `9` |
| `-` | Subtract | `7 - 2` | `5` |
| `*` | Multiply | `7 * 2` | `14` |
| `/` | Divide (always gives a float) | `7 / 2` | `3.5` |
| `//` | Integer division (drops the decimal) | `7 // 2` | `3` |
| `%` | Modulus: the **remainder** | `7 % 2` | `1` |
| `**` | Exponent (power) | `2 ** 3` | `8` |

**Modulus (`%`) shows up on tests a lot.** It gives what is left over after dividing.

- `10 % 3` is `1` (3 goes into 10 three times, with 1 left over)
- `20 % 5` is `0` (no remainder)
- A number is **even** if `number % 2` is `0`.

**Order of operations** works like math class (PEMDAS):

1. Parentheses `( )`
2. Exponents `**`
3. Multiply and divide `*` `/` `//` `%` (left to right)
4. Add and subtract `+` `-` (left to right)

```python
print(4 + 6 * 2)       # 16   (multiply first: 6 * 2 = 12, then 4 + 12)
print((4 + 6) * 2)     # 20   (parentheses first)
print(10 - 4 / 2)      # 8.0  (divide first; / always gives a float)

count = 5
count = count + 1      # take the old value, add 1, store it back
count += 1             # shortcut for the same thing
print(count)           # 7
```

---

## 8. String operations

**Concatenation:** joining strings with `+`. It does **not** add a space for you.

```python
first = "Ryan"
last = "Smith"
print(first + last)          # RyanSmith
print(first + " " + last)    # Ryan Smith
```

**You can't concatenate a string and a number** without converting the number first.

```python
age = 17
# print("Age: " + age)       # ERROR: can't add str and int
print("Age: " + str(age))    # Age: 17
```

**Substring:** part of a string. In Python you **slice** with `[start:stop]`. The stop position is **not** included. Positions start at 0.

```python
word = "DATABASE"
print(word[0])        # D      (first character)
print(word[0:4])      # DATA   (positions 0, 1, 2, 3)
print(word[4:])       # BASE   (position 4 to the end)
print(len(word))      # 8      (number of characters)
```

**Other common string operations:**

```python
name = "medina county"
print(name.upper())             # MEDINA COUNTY
print(name.title())             # Medina County
print(name.replace("county", "career center"))   # medina career center
print("ina" in name)            # True   (pattern matching: is "ina" inside?)
print(name.startswith("med"))   # True
```

These match the SQL from Unit 2: `||` concatenates, `SUBSTR()` takes a substring, `UPPER()` changes case, and `LIKE` does pattern matching.

---

## 9. Boolean logic and truth tables

**Boolean logic** works with only two values: **True** and **False**. Every decision a program makes comes down to a True/False question.

There are three logical operators:

- **and**: True only if **both** sides are True
- **or**: True if **at least one** side is True
- **not**: flips the value (True becomes False, False becomes True)

A **truth table** lists every combination of inputs and the result.

**AND**

| A | B | A and B |
|---|---|---|
| True | True | **True** |
| True | False | False |
| False | True | False |
| False | False | False |

**OR**

| A | B | A or B |
|---|---|---|
| True | True | True |
| True | False | True |
| False | True | True |
| False | False | **False** |

**NOT**

| A | not A |
|---|---|
| True | False |
| False | True |

**Shortcuts to remember:**

- AND is only True in **one** row: when both are True.
- OR is only False in **one** row: when both are False.

**Solving a bigger truth table:** work it one piece at a time. Example: `(A or B) and not C` with A = False, B = True, C = False:

1. `A or B` → `False or True` → **True**
2. `not C` → `not False` → **True**
3. `True and True` → **True**

---

## 10. Relational operators and compound conditions

**Relational operators** compare two values. The answer is always True or False.

| Operator | Means | Example (x = 10) | Result |
|---|---|---|---|
| `==` | Equal to | `x == 10` | True |
| `!=` | Not equal to | `x != 10` | False |
| `>` | Greater than | `x > 5` | True |
| `<` | Less than | `x < 5` | False |
| `>=` | Greater than or equal to | `x >= 10` | True |
| `<=` | Less than or equal to | `x <= 9` | False |

**Don't mix up `=` and `==`.** One equals sign **stores** a value. Two equals signs **compares** values.

```python
x = 10        # store 10 in x
x == 10       # ask "is x equal to 10?" -> True
```

**Compound condition:** two or more comparisons joined with `and`, `or`, or `not`.

```python
age = 16
has_permit = True

print(age >= 16 and has_permit)    # True   (both are True)
print(age > 18 or has_permit)      # True   (one is True)
print(not (age >= 16))             # False  (age >= 16 is True; not flips it)

grade = 85
print(grade >= 80 and grade < 90)  # True   (grade is in the 80s)
```

These are the same `AND`, `OR`, and `NOT` you used in SQL `WHERE` clauses in Unit 2.

---

## 11. if, elif, and else

A **conditional** (also called a decision or branch) runs code only when a condition is True.

```python
temp = 45

if temp > 80:
    print("Hot")
elif temp > 50:
    print("Nice")
else:
    print("Cold")
# prints: Cold
```

How Python reads it:

1. Check the `if`. If it's True, run that block and **skip the rest**.
2. If not, check each `elif` ("else if") in order.
3. If nothing was True, run the `else`.

**Only one block runs**, even if more than one condition would be True.

```python
score = 95
if score > 60:
    print("D or better")
elif score > 90:
    print("A")
# prints: D or better   (the first True condition wins; the elif is never checked)
```

**Indentation matters in Python.** The indented lines belong to the `if` above them. Other languages use curly braces `{ }` instead.

The same idea in pseudocode, which the exam might use:

```
IF temp > 80 THEN
    DISPLAY "Hot"
ELSE IF temp > 50 THEN
    DISPLAY "Nice"
ELSE
    DISPLAY "Cold"
END IF
```

---

## 12. Loops: for and while

A loop repeats code. This is called **repetition** or **iteration**.

### for loops: when you know how many times

```python
for i in range(4):
    print(i)
# prints 0, 1, 2, 3   (four times, starting at 0, stopping BEFORE 4)
```

**`range()` rules:**

| Code | Numbers it gives |
|---|---|
| `range(5)` | 0, 1, 2, 3, 4 |
| `range(1, 5)` | 1, 2, 3, 4 |
| `range(0, 10, 2)` | 0, 2, 4, 6, 8 (count by 2) |

The stop number is **never** included.

**Looping through a list:**

```python
teams = ["Cavs", "Browns", "Guardians"]
for team in teams:
    print("Go " + team)
# Go Cavs
# Go Browns
# Go Guardians
```

**Adding up with a loop (an accumulator):**

```python
total = 0
for n in range(1, 5):     # n is 1, 2, 3, 4
    total = total + n
print(total)              # 10
```

### while loops: repeat as long as something is True

```python
count = 1
while count <= 3:
    print("Count is", count)
    count = count + 1
# Count is 1
# Count is 2
# Count is 3
```

**How to count how many times a loop runs:** make a small table and trace it.

```python
x = 0
while x < 10:
    x = x + 3
print(x)
```

| Pass | x before | x < 10? | x after |
|---|---|---|---|
| 1 | 0 | True | 3 |
| 2 | 3 | True | 6 |
| 3 | 6 | True | 9 |
| 4 | 9 | True | 12 |
| — | 12 | **False**, stop | — |

The loop runs **4 times** and prints `12`.

**Infinite loop:** a loop whose condition never becomes False, so it never stops. This happens if you forget to change the variable (for example, leaving out `count = count + 1`).

| Use a `for` loop when | Use a `while` loop when |
|---|---|
| You know how many times, or you're going through a list | You repeat until something happens (the user types "quit", a value gets big enough) |

---

## 13. Selection: match and case (switch)

A **switch** or **case** statement picks one block out of many based on a single value. It's a cleaner way to write a long chain of `elif`s. Python calls it `match` and `case` (Python 3.10 and newer). Other languages call it `switch`.

```python
day = "Sat"

match day:
    case "Sat" | "Sun":
        print("Weekend")
    case "Fri":
        print("BPA prep")
    case _:
        print("School day")
# prints: Weekend
```

- Each `case` is one possible value.
- `|` means "or" inside a case.
- `case _:` is the **default**. It runs when nothing else matched (like `else`).

In other languages:

```
switch (day) {
    case "Fri":  print("BPA prep"); break;
    default:     print("School day");
}
```

SQL has the same idea with `CASE WHEN ... THEN ... ELSE ... END`.

---

## 14. Nested structures and recursion

**Nested** means one structure inside another, such as an `if` inside a loop or a loop inside a loop.

```python
for n in range(1, 6):
    if n % 2 == 0:
        print(n, "is even")
# 2 is even
# 4 is even
```

**Nested loops:** the inner loop runs all the way through **each time** the outer loop runs once.

```python
for row in range(2):          # outer: 2 times
    for col in range(3):      # inner: 3 times for EACH row
        print(row, col)
# prints 6 lines: 0 0, 0 1, 0 2, 1 0, 1 1, 1 2
```

Total passes = outer × inner = 2 × 3 = **6**.

**Recursion:** a function that **calls itself**. Every recursive function needs a **base case**, a point where it stops calling itself. Without one, it runs forever and crashes.

```python
def countdown(n):
    if n == 0:              # base case: stop here
        print("Liftoff!")
    else:
        print(n)
        countdown(n - 1)    # the function calls itself with a smaller number

countdown(3)
# 3
# 2
# 1
# Liftoff!
```

A classic example is **factorial**: 4! = 4 × 3 × 2 × 1 = 24.

```python
def factorial(n):
    if n == 1:                       # base case
        return 1
    return n * factorial(n - 1)      # 4 * 3 * 2 * 1

print(factorial(4))                  # 24
```

---

## 15. Functions

A **function** is a named block of code you can run (call) whenever you need it. Functions keep you from writing the same code over and over.

```python
def area(length, width):      # define the function; length and width are parameters
    return length * width     # send the answer back

result = area(4, 5)           # call the function with arguments 4 and 5
print(result)                 # 20
print(area(3, 3))             # 9
```

| Word | Means | In the example |
|---|---|---|
| **Define** | Create the function | `def area(...)` |
| **Call** | Run the function | `area(4, 5)` |
| **Parameter** | The placeholder name in the definition | `length`, `width` |
| **Argument** | The actual value you pass in | `4`, `5` |
| **Return value** | The answer the function sends back | `20` |

**`return` vs. `print`:** `print` only shows a value on the screen. `return` hands the value back so the program can keep using it.

```python
def add_tax(price):
    return price * 1.07

total = add_tax(100) + 5     # you can use the returned value in more math
print(round(total, 2))       # 112.0
```

Built-in functions you already know: `print()`, `len()`, `int()`, `str()`, `round()`, `range()`. In SQL, `COUNT()`, `AVG()`, and `UPPER()` are functions too.

---

## 16. Error handling: try and except

Some errors only happen while the program runs, like a user typing letters when you asked for a number. **Error handling** catches the error so the program doesn't crash. Python uses `try` and `except`. Other languages call it `try` and `catch`.

```python
text = "abc"

try:
    number = int(text)            # this line fails: "abc" isn't a number
    print("You typed", number)
except ValueError:
    print("Please type a number.")
# prints: Please type a number.
```

How it works:

1. Python tries the code in the `try` block.
2. If an error happens, it jumps to the matching `except` block instead of crashing.
3. If no error happens, the `except` block is skipped.

You can add `finally:` for code that runs **no matter what**, such as closing a file or a database connection.

```python
try:
    result = 10 / 0
except ZeroDivisionError:
    print("Can't divide by zero.")
finally:
    print("Done.")
# Can't divide by zero.
# Done.
```

**Security note:** good error handling also means not showing users the raw error message. A raw database error can tell an attacker your table names.

---

## 17. Classes, objects, and methods

In **object-oriented programming**, you design a **class** and then make **objects** from it.

- **Class:** a blueprint. It describes what data and actions something has.
- **Object:** one actual thing made from the class. Also called an **instance**.
- **Attribute:** a piece of data the object holds (like a name).
- **Method:** a function that belongs to the class (an action the object can do).

Think of a class as a cookie cutter and objects as the cookies.

```python
class Student:
    def __init__(self, name, grade):      # runs when a new Student is made
        self.name = name                  # attribute
        self.grade = grade                # attribute

    def report(self):                     # method
        return self.name + " is in grade " + str(self.grade)

s1 = Student("Maya", 11)      # make an object (an instance of Student)
s2 = Student("Leo", 12)       # another object from the same class

print(s1.report())            # Maya is in grade 11
print(s2.name)                # Leo
```

- `__init__` is the **constructor**. It sets up a new object's attributes.
- `self` means "this object."
- Each object keeps its **own** data: `s1` and `s2` are both Students, but with different names.

This connects to databases: a **class** is like a **table design**, and each **object** is like one **row**.

---

## 18. Reading data from a database with code

Programs often get their data from a database. Python has a built-in library called `sqlite3` that runs SQL on the same `.db` files you made in DB Browser.

```python
import sqlite3                                  # use the built-in sqlite3 library

conn = sqlite3.connect("school.db")             # open the database file
cursor = conn.cursor()

cursor.execute("SELECT name, grade FROM students WHERE grade = 12")
rows = cursor.fetchall()                        # get all matching rows as a list

for row in rows:
    print(row[0], "-", row[1])                  # row[0] = name, row[1] = grade

conn.close()                                    # always close the connection
```

The steps are the same in every language:

1. **Connect** to the database.
2. **Run** a SQL query.
3. **Fetch** the results.
4. **Use** them (usually with a loop).
5. **Close** the connection.

Programs can **read input** from many places: a user typing, a data file (CSV), a sensor, a database, or an **API** (a web service that sends data, like a weather service). Programs can **format output** for a screen, a report, or a data file.

---

## 19. Testing and debugging

An **IDE** (Integrated Development Environment) is one program that has everything for writing code: an editor, a way to run the code, and a debugger. VS Code, PyCharm, and Visual Studio are IDEs. You can **configure** an IDE by changing settings, themes, and extensions.

### The three kinds of errors

| Error | What it is | When you find out | Example |
|---|---|---|---|
| **Syntax error** | Breaks the rules of the language (a typo in the code's grammar) | Before or as soon as it runs; the program won't start | Missing a `:` or a closing `)` |
| **Runtime error** | The code is written correctly but crashes while running | While it runs | Dividing by zero; `int("abc")` |
| **Logic error** | The program runs with no crash but gives the **wrong answer** | Only by checking the output | Using `+` when you meant `*` |

**Logic errors are the hardest to find**, because nothing tells you something is wrong.

```python
# Logic error: this is supposed to average two scores
a = 80
b = 90
avg = a + b / 2      # runs fine, but gives 125.0 (it divides b first)
avg = (a + b) / 2    # fixed: 85.0
```

### Test cases

A **test case** is an input plus the output you **expect**. You run the program and compare.

Example for a program that decides pass/fail (pass is 70 or above):

| Test | Input | Expected output | Why test it |
|---|---|---|---|
| 1 | 85 | Pass | Normal passing score |
| 2 | 40 | Fail | Normal failing score |
| 3 | 70 | Pass | **Boundary**: right on the line |
| 4 | 69 | Fail | **Boundary**: just under the line |
| 5 | -5 | Error message | **Bad input** |

Good testing always includes the **boundaries** (the exact cut-off values) and **bad input**.

**Debugging** means finding and fixing errors. Common ways: read the error message and line number, add `print()` lines to see variable values, or use the IDE's debugger to pause the code and step through it one line at a time (a **breakpoint** is where it pauses).

---

## 20. Programming conventions and secure coding

### Naming and comments

- Use names that say what the thing is: `total_price`, not `tp` or `x`.
- Python uses **snake_case** for variables and functions (`student_name`). Classes use **PascalCase** (`Student`). JavaScript often uses **camelCase** (`studentName`).
- Constants are ALL CAPS (`MAX_SCORE`).
- **Comments** explain **why** code does something. In Python they start with `#`. In SQL they start with `--`.

```python
MAX_SCORE = 100          # constant
student_name = "Maya"    # snake_case variable

# Round down so partial points don't count
final = int(87.9)
```

### Libraries and calling other programs

- A **library** (or module) is code someone else already wrote that you can **reuse**. `import math`, `import sqlite3`, and `import random` load libraries. Reusing tested code saves time and avoids bugs.
- An **operating system call** asks the operating system to do something, like list files in a folder or get the date. Python's `os` library does this.
- A program can **call another program**, such as a script that runs a backup tool.

```python
import math
import os

print(math.sqrt(49))        # 7.0   (reuse a library function)
print(os.getcwd())          # prints the current folder (an operating system call)
```

### Data validation

**Data validation** checks input before the program uses it. It's the same idea as `CHECK` in Unit 4.

| Check | Tests | Example |
|---|---|---|
| **Range check** | The value is between a low and high limit | Grade is 9 to 12 |
| **Length check** | The value has the right number of characters | A state code is 2 letters |
| **Format check** | The value has the right pattern | An email has an `@` |
| **Type check** | The value is the right data type | Age is a number, not letters |
| **Presence check** | The value isn't empty | Name was filled in |

```python
grade = 14
if grade < 9 or grade > 12:          # range check
    print("Grade must be 9 to 12.")
```

### Secure coding

Never trust user input. Validating it blocks common attacks:

- **SQL injection:** an attacker types SQL code into an input box so it becomes part of your query. The fix is a **parameterized query**, which keeps the user's input as plain data.
- **Cross-site scripting (XSS):** an attacker puts script code into a web page that other users then run.
- **Bounds checking:** making sure a program never reads or writes past the end of a list or memory space. Skipping it can cause a **buffer overflow**.

```python
user_input = "Maya"

# UNSAFE: user input is glued into the SQL string
# cursor.execute("SELECT * FROM students WHERE name = '" + user_input + "'")

# SAFE: parameterized query; the ? is filled in as data only
cursor.execute("SELECT * FROM students WHERE name = ?", (user_input,))
```

---

## 21. Version control and the software development life cycle

### Version control

**Version control** tracks every change to code over time. **Git** is a version control system, and **GitHub** is a website that stores Git projects. You use them every time you push your work.

Why it matters:

- You can go back to an earlier version if something breaks.
- You can see who changed what and when.
- Several people can work on the same project without overwriting each other.

| Term | Means |
|---|---|
| **Repository (repo)** | The project folder and its whole history |
| **Commit** | A saved snapshot of changes, with a message |
| **Push** | Send commits to GitHub |
| **Pull** | Get the newest changes from GitHub |
| **Branch** | A separate copy for working on something without changing the main code |
| **Merge** | Combine a branch back into the main code |

**Documentation** (comments, README files, user guides) explains how code works and how to use it. It matters so other people, or you six months from now, can understand and maintain the code.

### Software development life cycle (SDLC)

The **SDLC** is the set of phases a software project goes through. The order:

1. **Planning / requirements:** figure out what the software must do (like meeting with the client in Unit 3e)
2. **Design:** plan how it will work (flowcharts, ER diagrams, UML)
3. **Development:** write the code
4. **Testing:** check that it works using test cases
5. **Deployment:** release it to users
6. **Maintenance:** fix bugs and make updates after release

### Configuration management

**Configuration management** means keeping track of every version of the software and its settings, and controlling changes.

- **Baseline:** an approved version that everyone agrees on. Future changes are measured against it. Example: "version 1.0 as delivered to the client."
- **Version management:** numbering and tracking releases (1.0, 1.1, 2.0).
- **Interface control:** making sure the parts of a system that connect to each other (like an app and its database) still fit together after a change.
- **Change impact analysis:** before changing something, figure out what else it could break. Example: renaming a database column breaks every query that uses the old name.

---

## 22. Practice questions

Try each one before you look at the answer.

**1.** What is the result of `19 % 4`?

<details><summary>Answer</summary>

`3`. 4 goes into 19 four times (16), with 3 left over.
</details>

**2.** What is the result of `10 + 2 * 3`?

<details><summary>Answer</summary>

`16`. Multiply first: 2 × 3 = 6, then 10 + 6.
</details>

**3.** What data type is `"98.6"`?

<details><summary>Answer</summary>

String. It's in quotes, so it's text, even though it looks like a number.
</details>

**4.** What is the result of `False or True`?

<details><summary>Answer</summary>

`True`. OR is True if at least one side is True.
</details>

**5.** `x = 3`. Is `x > 1 and x > 5` True or False?

<details><summary>Answer</summary>

False. `x > 1` is True, but `x > 5` is False, and AND needs both.
</details>

**6.** What does this print?

```python
for i in range(2, 5):
    print(i)
```

<details><summary>Answer</summary>

`2`, `3`, `4`. It starts at 2 and stops before 5.
</details>

**7.** How many times does this loop run?

```python
n = 1
while n < 20:
    n = n * 2
```

<details><summary>Answer</summary>

5 times. n goes 1 → 2 → 4 → 8 → 16 → 32. At 32 the condition `n < 20` is False.
</details>

**8.** What does `triple(4)` return?

```python
def triple(n):
    return n * 3
```

<details><summary>Answer</summary>

`12`.
</details>

**9.** What does this print?

```python
word = "PYTHON"
print(word[0:3])
```

<details><summary>Answer</summary>

`PYT`. Positions 0, 1, and 2. The stop position (3) is not included.
</details>

**10.** A program that averages test scores runs without crashing, but every average is too high. What kind of error is this?

<details><summary>Answer</summary>

A logic error. The code runs but gives the wrong answer.
</details>

**11.** Which translates a program one line at a time while it runs: a compiler or an interpreter?

<details><summary>Answer</summary>

An interpreter.
</details>

**12.** What is the base case in a recursive function?

<details><summary>Answer</summary>

The condition where the function stops calling itself. Without it, the function never ends.
</details>

**13.** What is the difference between a class and an object?

<details><summary>Answer</summary>

A class is the blueprint. An object is one actual thing (an instance) made from that blueprint.
</details>

**14.** A game's code runs every time the player presses the space bar. What style of programming is this?

<details><summary>Answer</summary>

Event-driven.
</details>

**15.** Which SDLC phase comes right after development?

<details><summary>Answer</summary>

Testing.
</details>

**16.** How many lines does this print?

```python
for a in range(3):
    for b in range(4):
        print(a, b)
```

<details><summary>Answer</summary>

12. The outer loop runs 3 times, and the inner loop runs 4 times for each one: 3 × 4 = 12.
</details>

---

## 23. Vocabulary

| Term | Meaning |
|---|---|
| Algorithm | Step-by-step instructions for solving a problem |
| API | A web service a program can get data from |
| Argument | The actual value passed into a function when you call it |
| Array / list | One variable holding many values in order |
| Base case | The point where a recursive function stops |
| Baseline | An approved version that future changes are compared to |
| Boolean | A data type that is only True or False |
| Boundary test | A test right at a cut-off value |
| Class | A blueprint for making objects |
| Comment | A note in code that the computer ignores |
| Compiler | Translates the whole program before it runs |
| Compound condition | Two or more comparisons joined with and/or/not |
| Concatenation | Joining strings together |
| Constant | A value that does not change while the program runs |
| Data structure | A way of organizing data (list, table, dictionary) |
| Data validation | Checking input before using it |
| Debugging | Finding and fixing errors |
| Event-driven | Code that runs when something happens (click, key press) |
| Float | A number with a decimal point |
| Flowchart | A diagram of a program's steps |
| Function | A named, reusable block of code |
| Global variable | A variable that can be used anywhere in the program |
| IDE | A program for writing, running, and debugging code |
| Index | A position number in a list or string (starts at 0) |
| Infinite loop | A loop that never stops |
| Integer | A whole number |
| Interpreter | Translates and runs code one line at a time |
| IPO chart | Input, Process, Output planning chart |
| Library | Reusable code someone already wrote |
| Local variable | A variable that only exists inside its function |
| Logic error | Code runs but gives the wrong answer |
| Method | A function that belongs to a class |
| Modulus (`%`) | The remainder after dividing |
| Object | One instance made from a class |
| Object-oriented | Code built from objects that hold data and methods |
| Parameter | The placeholder name in a function definition |
| Parameterized query | A SQL query that keeps user input as data only, which blocks SQL injection |
| Procedural | Code written as steps that run in order |
| Pseudocode | Plain-English steps written like code |
| Recursion | A function that calls itself |
| Relational operator | Compares two values: `==` `!=` `>` `<` `>=` `<=` |
| Return value | The answer a function sends back |
| Runtime error | Code crashes while running |
| Scope | Where in a program a variable can be used |
| SDLC | Software development life cycle: plan, design, develop, test, deploy, maintain |
| String | Text, inside quotes |
| Substring | Part of a string |
| Switch / case | Picks one block of code based on one value |
| Syntax error | Code breaks the language's grammar rules |
| Test case | An input plus the output you expect |
| Truth table | Every combination of True/False inputs and the result |
| Version control | Tracking every change to code over time (Git) |
