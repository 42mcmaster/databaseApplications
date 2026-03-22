# Python Worksheet 04: While Loops
## Independent Practice — EV3 Edition

---

## Study Example 1: Simple While Loop with Counter

```python
# Spin a motor 5 times
spin_count = 1
while spin_count <= 5:
    print(f"Spin #{spin_count}")
    spin_count = spin_count + 1

print("Spinning complete!")
```

**Output:**
```
Spin #1
Spin #2
Spin #3
Spin #4
Spin #5
Spinning complete!
```

### Questions:
1. What happens if you remove the line `spin_count = spin_count + 1`?
2. How would you change this to spin 10 times?
3. What if you want to count DOWN instead (5, 4, 3, 2, 1)?

---

## Study Example 2: While True + Break (The EV3 Pattern)

```python
# Simulate robot backing away from a wall
distance = 200  # cm, starting far away
step = 1

print("Robot approaching wall...")
while True:
    if distance <= 15:
        print(f"Too close! ({distance} cm) Stopping!")
        break
    else:
        distance = distance - 20
        print(f"Moving forward... Distance: {distance} cm")

print("Robot safe")
```

**Output:**
```
Robot approaching wall...
Moving forward... Distance: 180 cm
Moving forward... Distance: 160 cm
Moving forward... Distance: 140 cm
Moving forward... Distance: 120 cm
Moving forward... Distance: 100 cm
Moving forward... Distance: 80 cm
Moving forward... Distance: 60 cm
Moving forward... Distance: 40 cm
Moving forward... Distance: 20 cm
Too close! (20 cm) Stopping!
Robot safe
```

### Questions:
1. Why does the loop need `break`? What would happen without it?
2. Change the starting distance to 50 cm. What changes in the output?

---

## Study Example 3: The Sensor Loop (Preview of EV3!)

```python
# Simulate a color sensor reading a line
print("=== Color Sensor Scan ===")

# Real EV3 reads these live; we simulate with a list
color_readings = [0, 0, 2, 2, 2, 0, 0, 5]
index = 0

while True:
    if index >= len(color_readings):
        print("Scan complete!")
        break

    # "Read" the sensor value
    color = color_readings[index]
    index = index + 1

    # React to it (THIS IS THE EV3 PATTERN)
    if color == 0:
        print(f"  Reading {index}: BLACK — off the line!")
    elif color == 2:
        print(f"  Reading {index}: GREEN — on the line, move forward")
    elif color == 5:
        print(f"  Reading {index}: WHITE — wall detected, turn!")
    else:
        print(f"  Reading {index}: Unknown color {color}")

print("Robot mission ended")
```

**Output:**
```
=== Color Sensor Scan ===
  Reading 1: BLACK — off the line!
  Reading 2: BLACK — off the line!
  Reading 3: GREEN — on the line, move forward
  Reading 4: GREEN — on the line, move forward
  Reading 5: GREEN — on the line, move forward
  Reading 6: BLACK — off the line!
  Reading 7: BLACK — off the line!
  Reading 8: WHITE — wall detected, turn!
Scan complete!
Robot mission ended
```

### Questions:
1. What is `index` used for?
2. How is `while True` + `break` used here? When does `break` happen?
3. In a real EV3 robot, what would replace `color_readings`?

---

## Task 1: Countdown Timer (`ws04a_countdown.py`)

Write a program that counts down from 10 to 1, then displays a launch message.

**Requirements:**
- Use a `while` loop with a counter (not a `for` loop)
- Count from 10 down to 1
- Print each number
- After the loop ends, print "LIFTOFF!"

**Expected Output:**
```
10
9
8
7
6
5
4
3
2
1
LIFTOFF!
```

**Hint:** Use `count = 10` and `while count > 0:`, then do `count = count - 1` inside.

**Submit:** `python-worksheets/ws04a_countdown.py`

---

## Task 2: Sensor Simulation (`ws04b_sensor_sim.py`)

Write a program that simulates the EV3 sensor pattern: loop continuously and react to sensor values.

**Requirements:**
- Use this list of simulated ultrasonic distances: `sensor_data = [80, 65, 45, 28, 15, 8]`
- Use `while True` with a counter/index
- For each reading:
  - If distance > 50: print "CLEAR: X cm"
  - If distance 20–50: print "CAUTION: X cm"
  - If distance < 20: print "DANGER: X cm — STOP"
- When you hit a DANGER reading, use `break` to exit the loop
- Print "Mission complete" after the loop

**Expected Output:**
```
CLEAR: 80 cm
CLEAR: 65 cm
CAUTION: 45 cm
CAUTION: 28 cm
DANGER: 15 cm — STOP
Mission complete
```

**Submit:** `python-worksheets/ws04b_sensor_sim.py`

---

## Task 3: Battery Life Simulation (`ws04c_patrol_sim.py`)

Write a program that simulates a robot battery draining during a patrol.

**Requirements:**
- Start with `battery_percent = 100`
- Use `while True` (the robot keeps patrolling)
- Each loop iteration:
  - Print current battery percentage and status
  - Decrease battery by 5%
  - Check if battery is critical:
    - If >= 75: "Full power"
    - If >= 50: "Normal patrol"
    - If >= 25: "Low battery — heading home"
    - If < 25: "CRITICAL — returning to dock NOW!" then `break`

**Expected Output:**
```
Battery: 100% — Full power
Battery: 95% — Full power
Battery: 90% — Full power
Battery: 85% — Full power
Battery: 80% — Full power
Battery: 75% — Normal patrol
Battery: 70% — Normal patrol
Battery: 65% — Normal patrol
Battery: 60% — Normal patrol
Battery: 55% — Normal patrol
Battery: 50% — Normal patrol
Battery: 45% — Low battery — heading home
Battery: 40% — Low battery — heading home
Battery: 35% — Low battery — heading home
Battery: 30% — Low battery — heading home
Battery: 25% — Low battery — heading home
Battery: 20% — CRITICAL — returning to dock NOW!
Robot safely docked
```

**Hint:** After the loop, print "Robot safely docked"

**Submit:** `python-worksheets/ws04c_patrol_sim.py`

---

## Task 4: Interactive Menu Loop (`ws04d_menu_loop.py`)

Write a program with a menu that keeps running until the user quits.

**Requirements:**
- Use `while True` for the menu loop
- Display menu options:
  ```
  === EV3 Control Menu ===
  1: Start motors
  2: Check battery
  3: Run sensor scan
  4: Quit
  Enter choice:
  ```
- Use `input()` to get the user's choice
- For each choice, print a response and loop back
- Only `break` (exit) when user chooses "4" (or "quit")

**Menu Responses (examples):**
- 1 → "Motors started"
- 2 → "Battery at 87%"
- 3 → "Sensor scan: clear"
- 4 → "Shutting down..." then break
- Anything else → "Invalid choice"

**Expected Input/Output (example):**
```
=== EV3 Control Menu ===
1: Start motors
2: Check battery
3: Run sensor scan
4: Quit
Enter choice: 1
Motors started

=== EV3 Control Menu ===
1: Start motors
2: Check battery
3: Run sensor scan
4: Quit
Enter choice: 4
Shutting down...
Goodbye!
```

**Submit:** `python-worksheets/ws04d_menu_loop.py`

---

## Challenge Extension (Optional)

Modify `ws04b_sensor_sim.py` to also count how many "DANGER" readings occurred before stopping, and print that at the end.

Example: "Mission complete. Dangers encountered: 1"

---

## Submission Checklist

- [ ] All four Python files created in `python-worksheets/` folder
- [ ] File names match exactly (ws04a, ws04b, ws04c, ws04d)
- [ ] Code runs without errors
- [ ] Output matches expected output
- [ ] Each loop has a clear exit condition (counter update or `break`)
- [ ] Comments explain the loop structure and exit condition
- [ ] Pushed to GitHub

---

