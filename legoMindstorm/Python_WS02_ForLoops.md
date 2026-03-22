# Python Worksheet 02: For Loops
## range(), Repetition, and Accumulators

**Name:** ________________
**Date:** ________________
**Period:** ________________

---

## PART 1: BASIC FOR LOOPS AND range()

### Example 1.1: Looping with range(n)
Study this code:
```python
print("Motor A spins:")
for i in range(5):
    print(f"Rotation {i + 1}")
print("Motor stopped!")
```

**Expected Output:**
```
Motor A spins:
Rotation 1
Rotation 2
Rotation 3
Rotation 4
Rotation 5
Motor stopped!
```

**Questions:**
1. How many times does the loop run?

   _______________________________________________

2. Why does the code use `i + 1` instead of just `i`?

   _______________________________________________

3. What line only prints once, and why?

   _______________________________________________

---

### Example 1.2: range(start, stop, step)
Study this code:
```python
print("Speed ramp-up test:")
for speed in range(20, 101, 20):
    print(f"Testing motor at {speed}% power")
print("Test complete!")
```

**Expected Output:**
```
Speed ramp-up test:
Testing motor at 20% power
Testing motor at 40% power
Testing motor at 60% power
Testing motor at 80% power
Testing motor at 100% power
Test complete!
```

**Questions:**
1. What does the third number (20) do in `range(20, 101, 20)`?

   _______________________________________________

2. Why does it print 20, 40, 60, 80, 100 but NOT 120?

   _______________________________________________

3. Rewrite this loop to print speeds from 50 down to 10 (step of -10):

   _______________________________________________

---

## PART 2: ACCUMULATORS AND RUNNING TOTALS

### Example 2.1: Sum with Accumulator
Study this code:
```python
total_distance = 0
wheel_circumference = 17.6  # cm

print("Distance after each rotation:")
for rotation in range(1, 6):
    total_distance = total_distance + wheel_circumference
    print(f"Rotation {rotation}: {total_distance:.1f} cm")
```

**Expected Output:**
```
Distance after each rotation:
Rotation 1: 17.6 cm
Rotation 2: 35.2 cm
Rotation 3: 52.8 cm
Rotation 4: 70.4 cm
Rotation 5: 88.0 cm
```

**Questions:**
1. Why do we set `total_distance = 0` before the loop?

   _______________________________________________

2. What does the line `total_distance = total_distance + wheel_circumference` do?

   _______________________________________________

3. If we ran this loop 10 times instead of 5, what would the final total be?

   _______________________________________________

---

### Example 2.2: Using += (Shorthand)
Study this code:
```python
power_used = 0

print("Battery drain per motor test:")
for test_num in range(1, 4):
    power_used += 25  # Same as: power_used = power_used + 25
    print(f"Test {test_num}: {power_used}% battery used")
```

**Expected Output:**
```
Battery drain per motor test:
Test 1: 25% battery used
Test 2: 50% battery used
Test 3: 75% battery used
```

**Questions:**
1. What does `+=` do?

   _______________________________________________

2. Rewrite the line `power_used += 25` using a regular `=` assignment:

   _______________________________________________

---

## PART 3: LOOPING OVER LISTS

### Example 3.1: For Loop with a List
Study this code:
```python
robot_names = ["Dash", "Echo", "Zippy", "Scout"]

print("Robot fleet status:")
for name in robot_names:
    print(f"  {name} is ready")
```

**Expected Output:**
```
Robot fleet status:
  Dash is ready
  Echo is ready
  Zippy is ready
  Scout is ready
```

**Questions:**
1. What does the square brackets `[]` create?

   _______________________________________________

2. How many times does the loop run?

   _______________________________________________

3. What does the variable `name` represent each time through the loop?

   _______________________________________________

---

## TASKS — Write and Test Your Code

**Task 2.1: Countdown Timer**

Write a Python program that prints a countdown from 10 to 1, then "LAUNCH!". Use a `for` loop with `range()`.

**File to submit:** `ws02a_countdown.py`

**Expected output:**
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
LAUNCH!
```

---

**Task 2.2: Speed Ramp and Distance Calculation**

Write a Python program that:
1. Uses a loop to test 5 different motor speeds: 30, 50, 70, 90, 100
2. For each speed, calculate and print the power draw (multiply speed by 1.2)
3. Use an **accumulator** to track the total power across all tests
4. After the loop, print the total power used

**File to submit:** `ws02b_speed_ramp.py`

**Expected output (example):**
```
Speed Test Results:
Speed 30 -> 36.0 watts
Speed 50 -> 60.0 watts
Speed 70 -> 84.0 watts
Speed 90 -> 108.0 watts
Speed 100 -> 120.0 watts
Total power consumed: 408.0 watts
```

---

**Task 2.3: Sensor Reading Loop**

Write a Python program that:
1. Creates a list of sensor types: `["Distance", "Touch", "Color", "Gyro", "Ultrasonic"]`
2. Loops through the list and prints "Checking [sensor]..."
3. Uses an **accumulator** to count how many sensors were checked
4. After the loop, prints the total number of sensors

**File to submit:** `ws02c_sensor_loop.py`

**Hints:**
- Create the list before the loop starts
- Use an accumulator to count (start at 0, add 1 each iteration)
- You can use `count += 1` or `count = count + 1`

**Expected output (example):**
```
Checking Distance sensor...
Checking Touch sensor...
Checking Color sensor...
Checking Gyro sensor...
Checking Ultrasonic sensor...
Total sensors checked: 5
```

---

## SUBMISSION INSTRUCTIONS

1. **Create a folder** in your GitHub repo:
   ```
   python-worksheets/ws02_forloops/
   ```

2. **Save your three Python files** in that folder:
   - `ws02a_countdown.py`
   - `ws02b_speed_ramp.py`
   - `ws02c_sensor_loop.py`

3. **Test each file** in VS Code terminal:
   ```bash
   python ws02a_countdown.py
   python ws02b_speed_ramp.py
   python ws02c_sensor_loop.py
   ```

4. **Push to GitHub:**
   ```bash
   git add python-worksheets/ws02_forloops/
   git commit -m "Worksheet 02: For Loops - range, accumulators, lists"
   git push
   ```

5. **Show Mr. M** the working code before you move on.

---

## COMPLETION CHECKLIST

- [ ] I created 3 Python files
- [ ] All files run without errors
- [ ] I used at least one `for` loop in each file
- [ ] I used `range()` with start, stop, and/or step values
- [ ] I used an accumulator pattern in at least one task
- [ ] I used f-strings for output
- [ ] I tested each file in the terminal
- [ ] I pushed to GitHub
- [ ] I showed Mr. M the output

---

## EXTRA CHALLENGE (Optional)

**Challenge 1:** Write a program that uses a nested loop (loop inside a loop) to test all combinations of two motor speeds. Print a grid showing each combination.

**Challenge 2:** Modify Task 2.2 to calculate the **average** power used across all tests, not just the total.

**Challenge 3:** Create a robot status check: loop through a list of robot names, and for each robot print a status message. Use an accumulator to track how many robots are ready.

---

**Due Date:** ________________

**Grading Rubric:**
- Code runs without errors: 2 pts
- For loops and range() used correctly: 2 pts
- Accumulator pattern (if required): 2 pts
- Output is clear and robot-themed: 2 pts
- f-strings used: 1 pt
- Submitted to GitHub: 1 pt
