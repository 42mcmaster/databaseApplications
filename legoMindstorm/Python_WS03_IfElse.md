# Python Worksheet 03: If/Else Statements
## Independent Practice — EV3 Edition

---

## Study Example 1: Basic Comparisons and If Statements

```python
# Example: Check if motor is running
motor_speed = 65  # rpm

if motor_speed > 0:
    print("Motor is on")

if motor_speed > 100:
    print("Motor is speeding!")

if motor_speed <= 50:
    print("Motor is going slow")
```

**Output:**
```
Motor is on
Motor is going slow
```

### Questions:
1. Why is "Motor is speeding!" NOT printed?
2. What value would `motor_speed` need to be for all three messages to print?

---

## Study Example 2: if/else Decision Making

```python
# Example: Obstacle detection
ultrasonic_distance = 17  # cm from object

if ultrasonic_distance < 20:
    print("ALERT: Obstacle too close!")
    print("Stopping motors")
else:
    print("Path is clear")
    print("Continuing forward")

print("Scan complete")
```

**Output:**
```
ALERT: Obstacle too close!
Stopping motors
Scan complete
```

### Questions:
1. What would the output be if `ultrasonic_distance = 25`?
2. Does "Scan complete" always print? Why?

---

## Study Example 3: if/elif/else with Battery Status

```python
# Example: Determine robot action based on battery
battery_level = 55  # percent

if battery_level >= 80:
    print("Battery excellent")
    print("Go on extended mission")
elif battery_level >= 50:
    print("Battery good")
    print("Proceed with caution")
elif battery_level >= 25:
    print("Battery low")
    print("Returning to base")
else:
    print("Battery critical!")
    print("STOP immediately")

print("Battery check complete")
```

**Output:**
```
Battery good
Proceed with caution
Battery check complete
```

### Questions:
1. Change `battery_level` to 18. What is the new output?
2. Why does only ONE message pair print (not multiple)?

---

## Task 1: Speed Check (`ws03a_speed_check.py`)

Write a program that takes a motor speed value and prints a message about its range.

**Requirements:**
- Create a variable `wheel_speed` and set it to 42
- Use `if/elif/else` to categorize the speed:
  - 0 = "Motor stopped"
  - 1–40 = "Motor moving slowly"
  - 41–70 = "Motor moving at normal speed"
  - 71–100 = "Motor moving fast"
  - Above 100 = "WARNING: Speed too high!"

**Expected Output (with wheel_speed = 42):**
```
Motor moving at normal speed
```

**Submit:** `python-worksheets/ws03a_speed_check.py`

---

## Task 2: Sensor Alert (`ws03b_sensor_alert.py`)

Write a program that checks multiple sensor conditions and decides if the robot should move.

**Requirements:**
- Create two variables: `distance` (set to 35) and `obstacle_ahead` (set to False)
- Use `and`/`or` logic:
  - If distance > 30 AND NOT obstacle_ahead: print "Path is safe, moving forward"
  - Otherwise: print "Cannot move safely"

**Expected Output (with given values):**
```
Path is safe, moving forward
```

**Challenge:** Change `obstacle_ahead` to True. What prints now?

**Submit:** `python-worksheets/ws03b_sensor_alert.py`

---

## Task 3: Color Action Mapping (`ws03c_color_actions.py`)

Write a program that simulates a color sensor reading and triggers an action.

**Requirements:**
- Color codes: 0=black, 1=blue, 2=green, 3=yellow, 4=red, 5=white
- Create a variable `detected_color` and set it to 2
- Use `if/elif/else` to print:
  - 0 → "Off the mat!"
  - 1 or 2 → "On the playing area"
  - 3 → "Marker detected"
  - 4 → "Danger zone!"
  - 5 → "Wall ahead"

**Expected Output (with detected_color = 2):**
```
On the playing area
```

**Hint:** For multiple matching values (1 and 2), use `or`: `if detected_color == 1 or detected_color == 2:`

**Submit:** `python-worksheets/ws03c_color_actions.py`

---

## Task 4: Patrol Decision Loop (`ws03d_patrol_check.py`)

Write a program that loops through sensor readings and flags dangers.

**Requirements:**
- Create a list of distances: `patrol_readings = [50, 22, 18, 60, 15, 45]`
- Loop through each reading
- For each reading:
  - If < 20: print "DANGER: X cm"
  - If 20–40: print "CAUTION: X cm"
  - If > 40: print "SAFE: X cm"
- At the end, print how many readings were "DANGER"

**Expected Output:**
```
SAFE: 50 cm
CAUTION: 22 cm
DANGER: 18 cm
SAFE: 60 cm
DANGER: 15 cm
SAFE: 45 cm
Total danger readings: 2
```

**Submit:** `python-worksheets/ws03d_patrol_check.py`

---

## Submission Checklist

- [ ] All four Python files created in `python-worksheets/` folder
- [ ] File names match exactly (ws03a, ws03b, ws03c, ws03d)
- [ ] Code runs without errors
- [ ] Output matches expected output
- [ ] Comments explain what each if/elif/else does
- [ ] Pushed to GitHub

---

