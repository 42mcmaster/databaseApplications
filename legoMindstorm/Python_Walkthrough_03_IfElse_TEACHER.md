# Python Walkthrough 03: If/Else Statements
## EV3 MicroPython Teacher Walkthrough

---

## Section 1: Comparison Operators

**The Foundation:** Before we can make decisions, we need to compare values.

```python
# Equality and inequality
motor_speed = 50
print(motor_speed == 50)      # True
print(motor_speed == 75)      # False
print(motor_speed != 50)      # False
print(motor_speed != 75)      # True

# Greater than / Less than
sensor_distance = 20
print(sensor_distance > 15)   # True
print(sensor_distance < 25)   # True
print(sensor_distance >= 20)  # True
print(sensor_distance <= 19)  # False

# Real EV3 example: battery level check
battery_level = 72
print(battery_level > 50)     # True — battery is good
print(battery_level < 25)     # False — battery is not critically low
```

> **Teacher note:** Emphasize the difference between `=` (assignment) and `==` (comparison). This is THE most common mistake. Show the error: `if motor_speed = 50:` will crash.

---

## Section 2: Basic `if` Statement

**Pattern:** Check a condition, do something if it's true.

```python
# Simple if
motor_speed = 50
if motor_speed > 0:
    print("Motor is moving forward")

# Indentation matters!
wheel_diameter = 55  # mm
if wheel_diameter == 55:
    print("This is the standard EV3 wheel")
    print("Circumference is about 172.7 mm")

# Example: Check sensor reading
ultrasonic_distance = 18  # cm
if ultrasonic_distance < 20:
    print("Object detected! Too close!")
```

> **Teacher note:** Indentation is NOT optional—it's how Python knows what code is "inside" the if block. Use 4 spaces (or 1 tab). Live-code this, showing what happens when indentation is wrong.

> **Common mistake:** Students forget the colon `:` at the end of the `if` line. Show the syntax error. Point out: `if` and `else` always end with a colon.

---

## Section 3: `if/else` Statement

**Pattern:** Two branches. Do one thing if true, something else if false.

```python
# Basic if/else
motor_speed = 75
if motor_speed > 50:
    print("Motor running fast")
else:
    print("Motor running slow or stopped")

# Real scenario: Check wheel type
wheel_diameter = 43  # mm
if wheel_diameter == 55:
    print("Standard EV3 wheel detected")
else:
    print("Different wheel size detected")

# Sensor decision: Should the robot move?
distance_to_obstacle = 35  # cm
if distance_to_obstacle < 20:
    print("STOP! Obstacle too close")
    print("Reverse and turn")
else:
    print("Path is clear")
    print("Continue forward")
```

> **Teacher note:** Emphasize: `if` checks a condition, `else` is the fallback. Exactly one of the two blocks runs. Ask: "What if distance_to_obstacle was exactly 20? Let's check—20 < 20 is False, so else runs."

---

## Section 4: `if/elif/else` — Multiple Branches

**Pattern:** Multiple conditions to check in order. First true one wins.

```python
# Categorizing motor speeds
motor_speed = 35
if motor_speed == 0:
    print("Motor is stopped")
elif motor_speed < 50:
    print("Motor moving slowly")
elif motor_speed < 75:
    print("Motor moving at medium speed")
else:
    print("Motor moving fast")

# Real EV3 example: Color sensor interpretation
detected_color_value = 3  # 0=black, 1=blue, 2=green, 3=yellow, 4=red, 5=white
if detected_color_value == 0:
    print("Black detected — we're off the mat!")
elif detected_color_value == 1:
    print("Blue detected — playing area")
elif detected_color_value == 2:
    print("Green detected — playing area")
elif detected_color_value == 3:
    print("Yellow detected — line marker")
elif detected_color_value == 4:
    print("Red detected — danger zone")
else:
    print("White detected — wall or obstacle")

# Battery status example
battery_percent = 45
if battery_percent >= 80:
    print("Battery excellent — ready for long mission")
elif battery_percent >= 50:
    print("Battery good — proceed normally")
elif battery_percent >= 25:
    print("Battery low — head back to charging station")
else:
    print("Battery critical — STOP immediately")
```

> **Teacher note:** Key point: Python evaluates these in order and stops at the first True. If the first `if` is true, the rest are skipped. Ask students: "If motor_speed is 35, which print runs?" (Answer: the `elif motor_speed < 50` one.)

---

## Section 5: Combining Conditions with `and`, `or`, `not`

**Pattern:** Make complex decisions.

```python
# AND: Both conditions must be true
motor_speed = 60
battery_percent = 30
if motor_speed > 0 and battery_percent > 20:
    print("Motor can run — battery sufficient")

# Both false = skip
if motor_speed > 0 and battery_percent > 50:
    print("Motor running AND battery excellent")
else:
    print("Something is low")

# OR: At least one must be true
wheel_size = 43
is_custom_robot = True
if wheel_size == 55 or wheel_size == 43 or is_custom_robot:
    print("This is a known configuration")

# Real scenario: Is the robot stuck?
left_motor_speed = 0
right_motor_speed = 0
ultrasonic_distance = 5
if left_motor_speed == 0 and right_motor_speed == 0 and ultrasonic_distance < 10:
    print("Robot is stopped and stuck against obstacle!")

# NOT: Flip the boolean
sensor_reading = 150  # cm
if not (sensor_reading > 200):
    print("Object is closer than 200 cm (probably true)")

# Cleaner way to write the same thing:
if sensor_reading <= 200:
    print("Object is closer than 200 cm")
```

> **Teacher note:** `and` and `or` are easier to understand than `not`. Start with those. Explain: AND is strict (both must be true), OR is lenient (at least one). Show truth tables if time.

---

## Section 6: `if` Inside a For Loop

**Pattern:** Loop through data, make decisions on each item.

```python
# Simulate ultrasonic sensor readings from a patrol
sensor_readings = [45, 38, 22, 19, 40, 35]  # distances in cm
print("Patrol log — checking for obstacles:")
for distance in sensor_readings:
    if distance < 25:
        print(f"  Alert! {distance} cm — OBSTACLE DETECTED")
    else:
        print(f"  {distance} cm — clear")

# Count obstacles
sensor_data = [40, 50, 15, 60, 18, 30, 25]
obstacle_count = 0
for reading in sensor_data:
    if reading < 20:
        print(f"Obstacle at {reading} cm")
        obstacle_count = obstacle_count + 1

print(f"Total obstacles found: {obstacle_count}")

# Simulate motor performance test
motor_speeds = [30, 55, 75, 100, 120]
target_speed = 75
print("Testing motor speeds:")
for speed in motor_speeds:
    if speed == target_speed:
        print(f"  {speed} rpm — TARGET ACHIEVED!")
    elif speed < target_speed:
        print(f"  {speed} rpm — too slow")
    else:
        print(f"  {speed} rpm — too fast")
```

> **Teacher note:** This is where they start to see the pattern structure they'll use in EV3 programs. A loop with if/else inside is the core control flow. In EV3, the loop will be `while True:` and the sensor reading will be real hardware, but the logic is identical.

---

## Teaching Tips & Common Mistakes

| Mistake | Wrong | Right |
|---------|-------|-------|
| Assignment vs Comparison | `if motor_speed = 50:` | `if motor_speed == 50:` |
| Missing colon | `if distance < 20` | `if distance < 20:` |
| Indentation | Code at wrong level | Consistent 4-space indent |
| Logic error | `if x == 5 and 10:` | `if x == 5 and y == 10:` |
| Forgetting parentheses in complex logic | `if a and b or c:` | `if (a and b) or c:` (if unclear) |

**Live Coding Strategy:**
1. Start with simple comparisons and print them.
2. Build to basic `if`, then `if/else`.
3. Show the common `=` vs `==` mistake; explain the error message.
4. Use EV3 values (motor speeds 0–100, distances 5–300 cm) so context is real.
5. Do the if-in-a-for-loop example last—it's the capstone.

---

## Expected Student Questions

**Q: "Can I use `if` without `else`?"**
A: Yes! Absolutely. `else` is optional. You use `else` only if you need an alternative action.

**Q: "What's the difference between `elif` and `else if`?"**
A: Python uses `elif` (short for "else if"). Other languages write it as two words.

**Q: "Can I have more than one line in an if block?"**
A: Yes! All indented lines are part of the block. Just keep the indentation consistent.

**Q: "What happens if none of the conditions are true?"**
A: If there's no `else`, nothing happens. If there's an `else`, that block runs.

---

