# Python Worksheet 05: Functions
**Independent Practice — EV3 Robot Edition**

Name: ________________     Date: ________________

---

## **Part 1: Study These Examples**

### Example 1: Simple Function with Parameters

```python
def motor_report(motor_name, speed):
    print(f"Motor {motor_name}: {speed}%")

motor_report("A", 75)
motor_report("B", 100)
motor_report("C", 50)
```

**Output:**
```
Motor A: 75%
Motor B: 100%
Motor C: 50%
```

**Questions:**
1. What are the two parameters in this function?
   - _______________  and  _______________
2. When we call `motor_report("A", 75)`, what value does `motor_name` receive?
   - _______________
3. How many times does this function get called?
   - _______________

---

### Example 2: Function with Return Value

```python
def calculate_battery_percent(voltage, max_voltage):
    percent = (voltage / max_voltage) * 100
    return percent

battery_level = calculate_battery_percent(9, 12)
print(f"Battery: {battery_level}%")
```

**Output:**
```
Battery: 75.0%
```

**Questions:**
1. What does the `return` statement do?
   - _________________________________________________________________
2. What value is stored in `battery_level`?
   - _______________
3. Could you call this function and use the result in a print statement without storing it first? (Hint: yes or no, and why?)
   - _________________________________________________________________

---

### Example 3: Function with a Loop Inside

```python
def drive_and_count(num_moves, distance_per_move):
    total = 0
    for move in range(num_moves):
        total = total + distance_per_move
        print(f"Move {move+1}: +{distance_per_move} cm (total: {total} cm)")
    return total

final_distance = drive_and_count(3, 25)
print(f"Robot traveled {final_distance} cm total")
```

**Output:**
```
Move 1: +25 cm (total: 25 cm)
Move 2: +25 cm (total: 50 cm)
Move 3: +25 cm (total: 75 cm)
Robot traveled 75 cm total
```

**Questions:**
1. What is the **accumulator** variable in this function?
   - _______________
2. After the loop finishes, what does this function return?
   - _______________
3. How many times does the loop run?
   - _______________

---

## **Part 2: Your Tasks**

### **Task A: Simple Motor Report Function**
**File to submit:** `ws05a_motor_report.py`

Write a function called `report_wheel_status` that takes two parameters:
- `wheel` (a string, like "Front-Left")
- `rpm` (a number, like 60)

The function should print a status message. Then call it three times with different wheels and speeds.

**Expected Output:**
```
Wheel Front-Left: 60 RPM
Wheel Front-Right: 75 RPM
Wheel Back-Left: 55 RPM
```

**Hints:**
- Use an f-string to format the output
- Call the function three times with different arguments

**Your code here:**
```python

```

---

### **Task B: Distance Calculator Function with Return**
**File to submit:** `ws05b_distance_calc.py`

Write a function called `distance_from_time` that takes two parameters:
- `time_seconds` (how long the robot drove)
- `speed_cmps` (centimeters per second)

The function should **calculate and return** the distance traveled. Then call it twice with different values and print the results.

**Expected Output:**
```
In 10 seconds at 5 cm/s, the robot traveled 50 cm
In 8 seconds at 7 cm/s, the robot traveled 56 cm
```

**Hints:**
- Distance = Speed × Time
- Use `return` to send the calculated distance back
- Store the returned value in a variable, then print it with an f-string

**Your code here:**
```python

```

---

### **Task C: Patrol Function with Loop**
**File to submit:** `ws05c_patrol_function.py`

Write a function called `patrol_scan` that takes two parameters:
- `num_scans` (how many times to scan)
- `scan_interval` (centimeters between each scan)

The function should use a **for loop** to print a scan report for each position. Inside the loop, calculate the position: `position = scan_num * scan_interval` (where `scan_num` starts at 1). Then **return** the final position.

**Expected Output:**
```
Scan 1 at position 0 cm
Scan 2 at position 10 cm
Scan 3 at position 20 cm
Scan 4 at position 30 cm
Final position: 30 cm
```

**Hints:**
- Use `range(num_scans)` for the loop
- Use `i+1` to number the scans starting at 1
- Calculate position inside the loop using `i * scan_interval`
- Return the final position after the loop ends (but still inside the function)
- Store the returned value and print it after calling the function

**Your code here:**
```python

```

---

### **Task D: Sensor Response Function with Loop + If/Else**
**File to submit:** `ws05d_obstacle_patrol.py`

Write a function called `navigate_with_sensor` that takes three parameters:
- `num_attempts` (how many times to scan)
- `obstacle_threshold` (sensor value that means "obstacle detected")
- `obstacle_distance` (at which attempt the obstacle appears)

The function should:
- Use a **for loop** to simulate sensor scans
- Use an **if/else** to check if each simulated sensor reading is above the threshold
- If the reading is **above** the threshold AND it's the scan where the obstacle appears, print "OBSTACLE DETECTED — STOPPING" and use `break` to exit
- Otherwise print "Path clear, moving..."
- **Return** the scan number where it stopped (or the total scans if no obstacle)

**Expected Output (Example 1):**
```
Scan 1: Reading 40 — Path clear, moving...
Scan 2: Reading 45 — Path clear, moving...
Scan 3: Reading 70 — OBSTACLE DETECTED — STOPPING
Stopped at scan 3
```

**Hints:**
- Simulate a sensor reading that increases each scan: `sensor_reading = 35 + (i * 15)`
- Use `if` to check if the reading is above the threshold AND `i+1 == obstacle_distance`
- Use `break` to exit the loop early
- Return the scan number where you stopped (`i+1`), or `num_attempts` if you never hit the obstacle

**Your code here:**
```python

```

---

## **Submission Instructions**

1. Save each task as its own Python file (`.py`)
2. File names: `ws05a_motor_report.py`, `ws05b_distance_calc.py`, `ws05c_patrol_function.py`, `ws05d_obstacle_patrol.py`
3. Push to GitHub in the folder: `python-worksheets/`
4. Test your code — make sure it runs without errors and produces the expected output

---

## **Self-Check Checklist**

Before submitting, check each task:

- [ ] Task A: Function has two parameters, prints a message, called three times
- [ ] Task B: Function calculates distance, uses `return`, result is used in print
- [ ] Task C: Function has a `for` loop inside, calculates position, `return`s final value
- [ ] Task D: Function has a loop AND if/else, uses `break`, `return`s the stop point
- [ ] All files are named correctly
- [ ] All code runs without errors
- [ ] Output matches the expected output (or is correct for your test data)

