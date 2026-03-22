# Python Walkthrough 02: For Loops
## Teacher Notes — What You'll Type Live in VS Code

**Goal:** Students watch you type for loops and see how Python repeats code. All examples are EV3-themed (motor spins, sensor readings, countdowns).

**Setup:** Open VS Code terminal. Type each block slowly. Point out indentation constantly.

---

## SECTION 1: range() — The Basics

### What to Say:
"A for loop tells Python to repeat something over and over. We'll use `range()` to control how many times."

### Code Block 1.1: range(n) — Count from 0 to n-1
```python
print("Motor A spinning:")
for i in range(5):
    print(f"Spin {i}")
print("Done!")
```

**Type it, press Enter, show output.**

```
Motor A spinning:
Spin 0
Spin 1
Spin 2
Spin 3
Spin 4
Done!
```

> **Teacher note:**
> - `range(5)` means "give me 0, 1, 2, 3, 4" — exactly 5 numbers, starting from 0
> - The indented lines inside the loop repeat 5 times
> - Lines outside the loop (like "Done!") run once, after the loop finishes
> - Indentation is **critical**—Python uses it to know what's inside vs outside the loop

**Pause and ask:** "Why does it print 0 through 4, not 1 through 5?"
*(Explanation: In programming, we often count from 0. This takes practice to get used to.)*

### Code Block 1.2: Common Mistake — No Indentation
```python
# WRONG — don't do this:
for i in range(3):
print(f"Rotation {i}")

# RIGHT — indent the print:
for i in range(3):
    print(f"Rotation {i}")
```

> **Teacher note:** Show them the error when indentation is missing. Read the error message aloud. This is the #1 for-loop mistake.

---

## SECTION 2: range(start, stop) and range(start, stop, step)

### What to Say:
"Sometimes we don't want to count from 0. We can tell `range()` where to start and stop."

### Code Block 2.1: range(start, stop)
```python
print("Motor speed ramp-up:")
for speed in range(30, 91, 10):
    print(f"Speed: {speed}")
```

**Run it, show output:**
```
Motor speed ramp-up:
Speed: 30
Speed: 40
Speed: 50
Speed: 60
Speed: 70
Speed: 80
Speed: 90
```

> **Teacher note:**
> - `range(30, 91, 10)` means "start at 30, go up to (but not including) 91, by steps of 10"
> - Notice it stops at 90, not 91. The stop number is always exclusive (not included)
> - The third number is "step"—how much to add each time

**Pause and ask:** "What would happen if I wrote `range(30, 90, 10)` instead?"
*(It would stop at 80, not 90. Still stops before the stop number.)*

### Code Block 2.2: Counting Backwards with range()
```python
print("Countdown to launch:")
for seconds in range(10, 0, -1):
    print(f"{seconds}...")
print("BLAST OFF!")
```

**Run it:**
```
Countdown to launch:
10...
9...
8...
7...
6...
5...
4...
3...
2...
1...
BLAST OFF!
```

> **Teacher note:**
> - Negative step (`-1`) makes it count backwards
> - Note: `range(10, 0, -1)` stops at 1 (doesn't include 0). If you want 0, use `range(10, -1, -1)`
> - This is perfect for robot countdowns before launch!

---

## SECTION 3: Loop Variable (i, sensor, speed, etc.)

### What to Say:
"The variable in a for loop (`i` or `speed` or whatever you call it) gets a new value each time through the loop."

### Code Block 3.1: Using the Loop Variable
```python
print("EV3 motor power test:")
for power in range(20, 101, 20):
    print(f"Testing power level {power}%")
    print(f"  -> Motor draws {power * 1.2:.1f} watts")
print("Test complete!")
```

**Run it:**
```
EV3 motor power test:
Testing power level 20%
  -> Motor draws 24.0 watts
Testing power level 40%
  -> Motor draws 48.0 watts
Testing power level 60%
  -> Motor draws 72.0 watts
Testing power level 80%
  -> Motor draws 96.0 watts
Testing power level 100%
  -> Motor draws 120.0 watts
Test complete!
```

> **Teacher note:**
> - The variable `power` changes each loop iteration
> - You can do math with the loop variable (multiply by 1.2)
> - You can use the variable multiple times in the loop body

### Code Block 3.2: Ignoring the Loop Variable (just repeat)
```python
print("Reading sensor 5 times:")
for _ in range(5):
    print("Distance sensor: 45 cm")
```

**Run it:**
```
Reading sensor 5 times:
Distance sensor: 45 cm
Distance sensor: 45 cm
Distance sensor: 45 cm
Distance sensor: 45 cm
Distance sensor: 45 cm
```

> **Teacher note:** When you don't need the loop variable's value, use `_` (underscore). It's a Python convention that means "I don't care about this variable."

---

## SECTION 4: Accumulator Pattern — Running Total

### What to Say:
"Sometimes we need to add things up as we loop. This is called an accumulator. Watch carefully—it's a pattern you'll use a lot."

### Code Block 4.1: Sum All Numbers
```python
total = 0
for i in range(1, 6):
    total = total + i
    print(f"Added {i}, total is now {total}")
print(f"Final total: {total}")
```

**Run it:**
```
Added 1, total is now 1
Added 2, total is now 3
Added 3, total is now 6
Added 4, total is now 10
Added 5, total is now 15
Final total: 15
```

> **Teacher note:**
> - Start with `total = 0` BEFORE the loop
> - Inside the loop: `total = total + i` updates the total each time
> - After the loop: print the final result
> - This is the **accumulator pattern**—very important

**Pause and ask:** "What would happen if we started with `total = 1` instead of `0`?"
*(Final total would be 16.)*

### Code Block 4.2: Accumulator with EV3 Context
```python
print("Robot distance traveled:")
total_distance = 0
for rotation in range(1, 6):
    distance_per_rotation = 17.6  # cm (wheel circumference)
    total_distance = total_distance + distance_per_rotation
    print(f"Rotation {rotation}: {total_distance:.1f} cm total")
```

**Run it:**
```
Robot distance traveled:
Rotation 1: 17.6 cm total
Rotation 2: 35.2 cm total
Rotation 3: 52.8 cm total
Rotation 4: 70.4 cm total
Rotation 5: 88.0 cm total
```

> **Teacher note:** This shows a real robot scenario—tracking total distance as the wheel spins multiple times.

### Code Block 4.3: Shorthand — += Operator
```python
total = 0
for i in range(1, 6):
    total += i  # This is the same as: total = total + i
print(f"Sum: {total}")
```

> **Teacher note:** `+=` is shorthand. `total += i` means "add i to total." You can also use `-=`, `*=`, `/=`.

---

## SECTION 5: Looping Over a List

### What to Say:
"Loops don't always use `range()`. We can loop over a list of items instead."

### Code Block 5.1: Loop Over a List
```python
sensors = ["Distance", "Touch", "Color", "Gyro"]

print("Available sensors:")
for sensor in sensors:
    print(f"  - {sensor}")
```

**Run it:**
```
Available sensors:
  - Distance
  - Touch
  - Color
  - Gyro
```

> **Teacher note:**
> - A list is created with square brackets `[]`
> - Each item is separated by commas
> - The loop variable `sensor` gets each item, one at a time
> - No `range()` needed—Python knows the list has 4 items, so it loops 4 times

### Code Block 5.2: Motor Speed Settings (List + Accumulator)
```python
speed_settings = [30, 50, 75, 100]
total_power = 0

print("Motor speed tests:")
for speed in speed_settings:
    power = speed * 1.2
    total_power = total_power + power
    print(f"Speed {speed}: {power:.1f} watts")

print(f"Total power across all tests: {total_power:.1f} watts")
```

**Run it:**
```
Motor speed tests:
Speed 30: 36.0 watts
Speed 50: 60.0 watts
Speed 75: 90.0 watts
Speed 100: 120.0 watts
Total power across all tests: 306.0 watts
```

> **Teacher note:** This shows the power of combining lists + loops + accumulators.

---

## SECTION 6: Nested Loops — Loop Inside a Loop

### What to Say:
"Sometimes you need a loop inside a loop. This repeats code in a grid pattern."

### Code Block 6.1: Nested Loop Example
```python
print("Motor A & B combinations:")
for speed_a in range(50, 101, 25):
    for speed_b in range(50, 101, 25):
        print(f"Motor A: {speed_a}, Motor B: {speed_b}")
```

**Run it:**
```
Motor A & B combinations:
Motor A: 50, Motor B: 50
Motor A: 50, Motor B: 75
Motor A: 50, Motor B: 100
Motor A: 75, Motor B: 50
Motor A: 75, Motor B: 75
Motor A: 75, Motor B: 100
Motor A: 100, Motor B: 50
Motor A: 100, Motor B: 75
Motor A: 100, Motor B: 100
```

> **Teacher note:**
> - The inner loop (speed_b) runs completely for each iteration of the outer loop (speed_a)
> - Indentation shows which loop "owns" each line
> - This is powerful but can be confusing—only use it when you really need a grid pattern

---

## COMMON MISTAKES TO WATCH FOR

| Mistake | Example | Problem | Fix |
|---------|---------|---------|-----|
| No indentation | `for i in range(5):\nprint(i)` (no indent) | Python doesn't know what's in the loop | Indent the print line by 4 spaces |
| Off-by-one | `for i in range(5):` prints 5-9 | Confusion about range(n) = 0 to n-1 | `range(5)` gives 0, 1, 2, 3, 4 |
| Range doesn't include stop | `range(1, 10)` only goes to 9 | Forgot stop number is exclusive | It's correct—stop is always excluded |
| Updating loop var inside loop | `for i in range(5):\n    i = i + 1` | Doesn't change the loop | Loop variable is controlled by range(), not by you |
| Forgetting colon | `for i in range(5)` (no `:`) | Syntax error | Put a colon at the end of the for line |
| Wrong indentation amount | Mixing tabs and spaces | Python gets confused | Use 4 spaces consistently (not tabs) |

---

## QUESTIONS STUDENTS MIGHT ASK

**Q: Why does `range(5)` give 0, 1, 2, 3, 4 instead of 1, 2, 3, 4, 5?**
A: Programming languages often count from 0. It takes practice! Use `range(1, 6)` if you really want 1 through 5.

**Q: Can I use a different variable name instead of `i`?**
A: Absolutely! Use names that make sense: `for speed in speeds:` or `for sensor in sensors:`. Only use `i` if you're doing math on the variable.

**Q: What happens if I loop 0 times?**
A: `range(0)` gives nothing, so the loop doesn't run at all. The code after the loop runs immediately.

**Q: Can I have a loop inside a loop inside a loop?**
A: Yes, but it gets confusing fast. Keep it simple when possible.

**Q: Why does `total = total + i` seem backwards?**
A: It's not backward—it's an assignment. `total = total + i` means "take the old total, add i to it, and store the result back in total." It's called an accumulator.

---

## NEXT STEPS
- Have students type these examples themselves
- Let them modify the range values and see what happens
- Encourage them to write loops that do robot-themed things (distance, speed, sensors)
