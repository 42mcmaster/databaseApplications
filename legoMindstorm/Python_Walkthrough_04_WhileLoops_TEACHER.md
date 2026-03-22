# Python Walkthrough 04: While Loops
## EV3 MicroPython Teacher Walkthrough

---

## Section 1: While Loop with a Condition

**Pattern:** Keep looping as long as a condition is true. Stop when false.

```python
# Count up from 1 to 5
count = 1
while count <= 5:
    print(f"Count: {count}")
    count = count + 1

print("Done!")
```

**Output:**
```
Count: 1
Count: 2
Count: 3
Count: 4
Count: 5
Done!
```

> **Teacher note:** The key: `count = count + 1` is crucial. Without it, `count` never changes, and the loop never stops (infinite loop). Live-code this, then deliberately break it to show the infinite loop behavior. Then Ctrl+C to interrupt.

```python
# Countdown to launch
seconds = 5
while seconds > 0:
    print(f"T-minus {seconds} seconds")
    seconds = seconds - 1

print("LIFTOFF!")
```

**Output:**
```
T-minus 5 seconds
T-minus 4 seconds
T-minus 3 seconds
T-minus 2 seconds
T-minus 1 seconds
LIFTOFF!
```

> **Teacher note:** Same pattern, different direction. Emphasize: the variable in the condition MUST change inside the loop, or we get stuck forever.

---

## Section 2: `while True` + `break` — The EV3 Pattern

**Pattern:** Loop forever until you explicitly break out. This is the sensor-checking pattern robots use.

```python
# Simple example: Ask for a password
attempts = 0
while True:
    password = input("Enter password (or 'quit' to exit): ")
    if password == "robot123":
        print("Access granted!")
        break
    elif password == "quit":
        print("Exiting...")
        break
    else:
        attempts = attempts + 1
        print(f"Wrong password. Attempt {attempts}")

print("Program ended")
```

> **Teacher note:** `break` is the way out. When `break` is hit, the loop stops immediately. This is the foundation of every EV3 program: "read sensor, check if I should stop, if not keep looping."

```python
# Simpler example: Press spacebar to stop robot
battery_check = 100
while True:
    print(f"Robot moving... battery at {battery_check}%")
    battery_check = battery_check - 2

    if battery_check <= 0:
        print("Battery dead. Stopping!")
        break

print("Robot stopped")
```

**Output:**
```
Robot moving... battery at 100%
Robot moving... battery at 98%
Robot moving... battery at 96%
... (many lines)
Robot moving... battery at 2%
Battery dead. Stopping!
Robot stopped
```

> **Teacher note:** This simulates what the robot does: keep checking the condition, react when it matters, then stop. In real EV3 code, instead of `battery_check -= 2`, we'd read from actual hardware.

---

## Section 3: While Loop with a Counter

**Pattern:** Manual loop control. Loop a specific number of times with explicit counting.

```python
# Test motor 8 times
test_number = 1
while test_number <= 8:
    print(f"Motor test #{test_number}")
    test_number = test_number + 1

print("All tests complete")
```

**Output:**
```
Motor test #1
Motor test #2
Motor test #3
Motor test #4
Motor test #5
Motor test #6
Motor test #7
Motor test #8
All tests complete
```

> **Teacher note:** This is similar to `for` loops. Show both:
> ```python
> # With for (we know the range beforehand)
> for i in range(1, 9):
>     print(f"Motor test #{i}")
>
> # With while (we control the counter manually)
> test_number = 1
> while test_number <= 8:
>     print(f"Motor test #{test_number}")
>     test_number = test_number + 1
> ```
> Both work. `while` is more flexible—we can change the counter inside conditionals.

---

## Section 4: The Sensor Pattern — `while True` + `if/else` (KEY SECTION)

**This is the core of EV3 programming.** In real robots, sensors run constantly and the code reacts. In Python, we simulate this with a loop.

```python
# Simulate ultrasonic sensor readings (in real EV3, this is live hardware)
# Imagine a robot approaching a wall, and we're reading distance every 10 cm

print("=== Robot Patrol Simulation ===")
sensor_readings = [150, 120, 90, 60, 40, 25, 15, 8]
reading_index = 0

while True:
    # "Read" the sensor (in EV3, this would be: distance = ultrasonic.distance())
    if reading_index >= len(sensor_readings):
        print("Reached end of patrol data")
        break

    distance = sensor_readings[reading_index]
    reading_index = reading_index + 1

    # React to the reading (THIS IS THE KEY PATTERN)
    if distance > 50:
        print(f"{distance} cm: Clear path. Moving forward.")
    elif distance > 20:
        print(f"{distance} cm: Caution. Slowing down.")
    else:
        print(f"{distance} cm: DANGER! Stopping!")
        break

print("Patrol ended")
```

**Output:**
```
=== Robot Patrol Simulation ===
150 cm: Clear path. Moving forward.
120 cm: Clear path. Moving forward.
90 cm: Clear path. Moving forward.
60 cm: Clear path. Moving forward.
40 cm: Caution. Slowing down.
25 cm: Caution. Slowing down.
15 cm: DANGER! Stopping!
Patrol ended
```

---

### Real EV3 Version (what they'll write in Lesson 05)

```python
# This is pseudocode—actual EV3 imports and motor calls would go here
# But the STRUCTURE is identical to the simulation above

while True:
    # Read sensor
    distance = ultrasonic_sensor.distance()

    # Check and react
    if distance < 20:
        motor_left.stop()
        motor_right.stop()
        print("Obstacle! Stopping.")
        break
    elif distance < 40:
        motor_left.on(speed=30)
        motor_right.on(speed=30)
        print("Caution: slowing down")
    else:
        motor_left.on(speed=75)
        motor_right.on(speed=75)
        print("Clear: moving fast")

    # Small delay so we don't overwhelm the sensor
    time.sleep(0.1)
```

> **Teacher note:** Point this out EXPLICITLY. Say: "This is a preview. In Lesson 05, you'll replace `distance = [simulated reading]` with `distance = ultrasonic_sensor.distance()`, but the if/elif/else logic is IDENTICAL. You're learning this now so it feels natural later."

---

## Section 5: Interactive Loop with `input()`

**Pattern:** Keep asking the user until they give the right answer or quit.

```python
# Robot maintenance checklist
motor_status = ""
while motor_status != "ready":
    motor_status = input("Is the left motor ready? (yes/no/quit): ").lower()

    if motor_status == "quit":
        print("Exiting maintenance mode")
        break
    elif motor_status == "yes":
        motor_status = "ready"
        print("Left motor confirmed ready")
    elif motor_status == "no":
        print("Please check the motor and try again")
    else:
        print("I didn't understand. Please answer yes, no, or quit")

print("Maintenance complete")
```

> **Teacher note:** This shows real interactivity. The loop repeats based on user input. Add `.lower()` to make the comparison case-insensitive (so "YES" and "yes" both work).

---

## Section 6: Avoiding Infinite Loops

**What goes wrong:**

```python
# BAD: Infinite loop
count = 1
while count <= 5:
    print(f"Count: {count}")
    # Forgot to increment! count never changes
    # This will print forever

# GOOD: Increment it
count = 1
while count <= 5:
    print(f"Count: {count}")
    count = count + 1
```

**Safeguards:**

```python
# Safeguard 1: Use a counter and a limit
loops = 0
while loops < 100:  # Will never run more than 100 times
    print(f"Loop {loops}")
    loops = loops + 1

# Safeguard 2: Make sure the exit condition is reachable
battery = 50
while battery > 0:
    battery = battery - 10  # Battery WILL eventually be <= 0
    print(f"Battery: {battery}%")

# BAD: Exit condition can never be true
value = 1
while value < 5:
    value = value + 1  # value gets bigger, so value < 5 is eventually false
    print(value)       # This is fine

# But THIS would be bad:
value = 1
while value < 5:
    value = value - 1  # value gets SMALLER, so it will never reach < 5. Bad!
```

> **Teacher note:** Show students how to interrupt an infinite loop with Ctrl+C. Then fix the code. Emphasize: "If you see output that won't stop, Ctrl+C. Then check: does the variable in the condition actually change? Does the loop have an exit?"

---

## Teaching Tips & Common Patterns

| Pattern | When to Use |
|---------|------------|
| `while condition:` | When you know when to stop (e.g., count to 10) |
| `while True: ... break` | When you want to keep checking until something happens (e.g., sensor event) |
| `for i in range(n):` | When you know exactly how many times to loop |

**Live Coding Strategy:**
1. Start with a simple counter: `while count <= 5`.
2. Show the danger: forget the increment, infinite loop, Ctrl+C.
3. Show `while True` + `break` as the alternative.
4. Do the sensor simulation—this is THE core pattern.
5. Show that `while` + `if/else` inside is the structure they'll use in EV3.

---

## Expected Student Questions

**Q: "What's the difference between `while` and `for`?"**
A: `for` is for when you know how many times to loop. `while` is for when you're checking a condition. In robotics, we use `while True` because we keep checking sensors until something tells us to stop.

**Q: "Do I always need `break` in a `while True`?"**
A: No—`while True` only needs `break` if you want to exit. If you never break, the loop goes forever.

**Q: "What does `break` do?"**
A: It immediately exits the loop. Execution jumps to the line after the `while` block.

**Q: "If I use `while`, do I still need `if`?"**
A: They're independent. You can have a `while` without `if`. But the EV3 pattern combines them: while (keep checking), if (react to sensor).

**Q: "What happens if the condition is false from the start?"**
A: The loop never runs. Example: `count = 10; while count < 5: ...` — count is already not less than 5, so the loop is skipped.

---

