# Python Worksheet 01: Basics
## Variables, Math, and f-strings

**Name:** ________________
**Date:** ________________
**Period:** ________________

---

## PART 1: PRINT AND VARIABLES

### Example 1.1: Basic Printing
Study this code:
```python
print("EV3 Robot Status Report")
print("Motor A is running")
print(75)
print(True)
```

**Expected Output:**
```
EV3 Robot Status Report
Motor A is running
75
True
```

**Questions:**
1. What does `print()` do?

   _______________________________________________

2. Can `print()` handle numbers and text? Explain.

   _______________________________________________

---

### Example 1.2: Creating Variables
Study this code:
```python
robot_name = "Zippy"
motor_speed = 80
wheel_diameter = 5.6
motors_running = True

print(robot_name)
print(motor_speed)
print(wheel_diameter)
print(motors_running)
```

**Expected Output:**
```
Zippy
80
5.6
True
```

**Questions:**
1. What is a variable?

   _______________________________________________

2. Name the variable types used above (hint: there are 4).

   _______________________________________________

3. Why would a robot program use variables?

   _______________________________________________

---

## PART 2: MATH AND F-STRINGS

### Example 2.1: Basic Math
Study this code:
```python
motor_a_speed = 75
motor_b_speed = 65
avg_speed = (motor_a_speed + motor_b_speed) / 2

distance_cm = 120.5
wheel_rotations = 3
total_distance = distance_cm * wheel_rotations

print("Average speed:", avg_speed)
print("Total distance:", total_distance)
```

**Expected Output:**
```
Average speed: 70.0
Total distance: 361.5
```

**Questions:**
1. What does the `/` operator do? What does `*` do?

   _______________________________________________

2. What would happen if you removed the parentheses in `(motor_a_speed + motor_b_speed) / 2`?

   _______________________________________________

---

### Example 2.2: f-strings
Study this code:
```python
robot_name = "Echo"
battery_percent = 87
motor_speed = 70
circumference = 17.6

print(f"Robot {robot_name} has {battery_percent}% battery")
print(f"Motor speed: {motor_speed} rpm")
print(f"Wheel circumference: {circumference:.1f} cm")
```

**Expected Output:**
```
Robot Echo has 87% battery
Motor speed: 70 rpm
Wheel circumference: 17.6 cm
```

**Questions:**
1. What does the `f` at the start of the string do?

   _______________________________________________

2. What does `:.1f` mean?

   _______________________________________________

3. Rewrite this line using `+` and `str()` instead of an f-string:

   `print(f"Speed is {motor_speed}")`

   _______________________________________________

---

## TASKS — Write and Test Your Code

**Task 1.1: Create a Robot Profile**

Write a Python program that defines variables for a robot (name, motor speed, battery level, wheel diameter) and prints them out. Use **f-strings** for at least 2 print statements.

**File to submit:** `ws01a_variables.py`

**Expected output (example):**
```
Robot Dash
Motor Speed: 75 rpm
Battery: 92%
Wheel Diameter: 5.6 cm
```

---

**Task 1.2: Robot Speed Calculation**

Write a Python program that:
1. Defines two motor speeds (integers)
2. Calculates the **average** of the two speeds
3. Defines a distance the robot needs to travel (float)
4. Calculates how far it can go if it runs for 5 rotations
5. Prints both results using f-strings with **2 decimal places**

**File to submit:** `ws01b_math.py`

**Example code structure:**
```python
motor_a_speed = 70
motor_b_speed = 85

# Your code here
```

**Expected output (example):**
```
Average speed: 77.50 rpm
Distance after 5 rotations: 440.00 cm
```

---

**Task 1.3: Combine It All**

Write a Python program for a "Robot Power-On Report" that:
1. Defines at least 5 variables (name, speeds, battery, distance goal, etc.)
2. Does some math (average, multiplication, etc.)
3. Uses **f-strings** for all output
4. Prints a formatted status report (use `"=" * 30` or `"-" * 30` to add lines)

**File to submit:** `ws01c_fstrings.py`

**Example output:**
```
==============================
Robot Status: Dash
==============================
Battery: 95%
Motor A: 75 rpm
Motor B: 80 rpm
Avg Speed: 77.50 rpm
Travel Distance: 250.0 cm
Ready to move: True
==============================
```

---

## SUBMISSION INSTRUCTIONS

1. **Create a folder** in your GitHub repo:
   ```
   python-worksheets/ws01_basics/
   ```

2. **Save your three Python files** in that folder:
   - `ws01a_variables.py`
   - `ws01b_math.py`
   - `ws01c_fstrings.py`

3. **Test each file** in VS Code terminal:
   ```bash
   python ws01a_variables.py
   python ws01b_math.py
   python ws01c_fstrings.py
   ```

4. **Push to GitHub:**
   ```bash
   git add python-worksheets/ws01_basics/
   git commit -m "Worksheet 01: Basics - variables, math, f-strings"
   git push
   ```

5. **Show Mr. M** the working code before you move on.

---

## COMPLETION CHECKLIST

- [ ] I created 3 Python files
- [ ] All files run without errors
- [ ] I used variables of at least 3 types (string, int, float, bool)
- [ ] I used math operators (+, -, *, /, or %)
- [ ] I used f-strings in my output
- [ ] I tested each file in the terminal
- [ ] I pushed to GitHub
- [ ] I showed Mr. M the output

---

## EXTRA CHALLENGE (Optional)

**Challenge 1:** Try using `%` (modulo) in Task 1.2. If motor speed is 75 rpm and the robot runs for 10 seconds, how many full rotations? How many leftover seconds?

**Challenge 2:** Add a boolean variable to your status report (e.g., `sensors_ready = True`). Include it in your f-string output.

**Challenge 3:** Create a variable for the robot's name and speed, then use `str()` to concatenate them with `+` operator. Compare it to an f-string version—which is cleaner?

---

**Due Date:** ________________

**Grading Rubric:**
- Code runs without errors: 2 pts
- Variables correctly defined: 2 pts
- Math operations used: 2 pts
- f-strings formatted correctly: 2 pts
- Output is clear and robot-themed: 1 pt
- Submitted to GitHub: 1 pt
