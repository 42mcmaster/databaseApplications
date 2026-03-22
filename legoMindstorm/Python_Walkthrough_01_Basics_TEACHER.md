# Python Walkthrough 01: Basics
## Teacher Notes — What You'll Type Live in VS Code

**Goal:** Students watch you type and run Python code that controls EV3 robots (in theme). They see print(), variables, math, and f-strings in action.

**Setup:** Open VS Code terminal, have Python ready. Type each code block slowly—pause to let students catch up.

---

## SECTION 1: print() — Getting Output on Screen

### What to Say:
"Python's `print()` function is how we tell the robot to show us information. Let's start simple."

### Code Block 1.1: Single Argument
```python
print("EV3 Robot Started")
```
**Type it, press Enter, show output.**

> **Teacher note:** This is the absolute first thing students should see. Keep it boring and confident.

### Code Block 1.2: Multiple Arguments (comma-separated)
```python
print("Motor A speed:", 75)
print("Wheel diameter:", 5.6, "cm")
```

> **Teacher note:** Show that `print()` can take multiple things separated by commas. Each item gets printed with spaces between them.

**Pause and ask:** "What do you think happens if we remove the commas? Try it."
*(Let a student type:)* `print("Motor A speed" 75)` — it breaks. This is a common mistake.

---

## SECTION 2: Variables — Storing Values

### What to Say:
"Instead of typing the same number over and over, we can save it in a variable. Think of it like labeling a box with robot data."

### Code Block 2.1: Create and Use Variables (int and float)
```python
robot_name = "Dash"
motor_speed = 75
wheel_diameter = 5.6
distance_cm = 120.5

print(robot_name)
print(motor_speed)
print(wheel_diameter)
print(distance_cm)
```

> **Teacher note:** Emphasize:
> - Variable names should describe what they hold (not just `x` or `a`)
> - Numbers without quotes are integers or floats (EV3 motor speeds, distances)
> - Strings (names, labels) NEED quotes

### Code Block 2.2: Boolean Variables
```python
motor_running = True
sensor_ready = False

print(motor_running)
print(sensor_ready)
```

> **Teacher note:** `True` and `False` are capitalized in Python. They're used for on/off, yes/no decisions (especially important for robot sensor checks).

**Pause and ask:** "When might we use `True` or `False` in a robot program?"
*(Accept answers: "Is the motor running? Is the touch sensor pressed?")*

### Code Block 2.3: Mixing Types
```python
robot_name = "Echo"
motor_a_speed = 80
battery_low = False

print(robot_name)
print(motor_a_speed)
print(battery_low)
```

---

## SECTION 3: Math Operators

### What to Say:
"Robots do math to calculate distances, speeds, times. Let's see how Python does it."

### Code Block 3.1: Basic Operations
```python
# EV3 wheel rotation
rotations = 2.5
wheel_diameter = 5.6
circumference = 3.14159 * wheel_diameter
distance_per_rotation = circumference
total_distance = rotations * distance_per_rotation

print("Distance traveled:", total_distance, "cm")
```

> **Teacher note:** Show that `*` is multiplication, `/` is division. Point out the comment `#` — it's ignored by Python but helps us understand the code.

### Code Block 3.2: Division and Integer Division
```python
total_time_seconds = 45
laps = 3
seconds_per_lap = total_time_seconds / laps
print("Seconds per lap:", seconds_per_lap)

remainder_seconds = total_time_seconds % laps
print("Leftover seconds:", remainder_seconds)
```

> **Teacher note:**
> - `/` gives you a decimal (floating-point division)
> - `//` gives you a whole number only (integer division)
> - `%` gives you the remainder (modulo)

### Code Block 3.3: Order of Operations
```python
speed_a = 60
speed_b = 80
battery_percent = 85
avg_speed = (speed_a + speed_b) / 2
print("Average speed:", avg_speed)

power = speed_a * 2 + speed_b
print("Combined power:", power)
```

> **Teacher note:** Parentheses matter! Show what happens without them. Python follows standard math order: multiply/divide before add/subtract.

---

## SECTION 4: f-strings — Pretty Output

### What to Say:
"Now we're going to make our robot's output look professional. f-strings let us plug variables right into text."

### Code Block 4.1: f-string Basics
```python
robot_name = "Zippy"
motor_speed = 75
distance = 120.5

print(f"Robot {robot_name} is moving at speed {motor_speed}")
print(f"Distance to travel: {distance} cm")
```

> **Teacher note:** The `f` at the start makes it a special string. Anything in `{curly braces}` gets replaced with the variable's value.

### Code Block 4.2: Decimal Places in f-strings
```python
wheel_diameter = 5.6
circumference = 3.14159 * wheel_diameter

# Default: lots of decimals
print(f"Circumference: {circumference}")

# Limit to 2 decimal places
print(f"Circumference: {circumference:.2f}")
```

> **Teacher note:** The `:.2f` means "show 2 decimal places" (f = float). This is especially useful for sensor readings that might have many decimals.

### Code Block 4.3: Comparison — Comma Print vs f-string
```python
motor = "Motor A"
speed = 85

# Old way (still works)
print(motor, "speed:", speed)

# New way (cleaner)
print(f"{motor} speed: {speed}")
```

> **Teacher note:** Both work. f-strings are just neater and more readable as code gets complex.

---

## SECTION 5: str() — Converting Numbers to Strings

### What to Say:
"Sometimes you need to turn a number into text. That's where `str()` comes in."

### Code Block 5.1: Why str() Matters
```python
motor_speed = 75
robot_name = "Dash"

# This works—f-string handles it
print(f"{robot_name}'s speed is {motor_speed}")

# But if you need to concatenate strings with +, you need str()
message = robot_name + " speed: " + str(motor_speed)
print(message)
```

> **Teacher note:** `+` for strings means "join them together" (concatenation), not addition. If you try `"speed: " + 75`, Python crashes. You must convert 75 to a string first with `str(75)`.

### Code Block 5.2: Common Mistake
```python
# WRONG — don't do this:
# print("Speed: " + 75)  # ERROR!

# RIGHT — convert the number:
speed = 75
print("Speed: " + str(speed))
```

> **Teacher note:** Show them the error message if they forget str(). Read it out loud: "TypeError: can only concatenate str (not 'int') to str". It's telling you "you're trying to add text to a number—doesn't work."

---

## SECTION 6: Putting It All Together — A Robot Status Report

### What to Say:
"Let's write a small program that a robot might print when it powers on."

```python
# Robot Status Report
robot_name = "Echo"
battery_percent = 92
motor_a_speed = 80
motor_b_speed = 65
motors_active = True
wheel_diameter = 5.6
distance_goal_cm = 500

# Calculate average speed
avg_speed = (motor_a_speed + motor_b_speed) / 2

# Generate report
print("=" * 50)
print(f"Robot: {robot_name}")
print(f"Battery: {battery_percent}%")
print(f"Motor A: {motor_a_speed} rpm | Motor B: {motor_b_speed} rpm")
print(f"Average speed: {avg_speed:.1f} rpm")
print(f"Wheel diameter: {wheel_diameter} cm")
print(f"Distance goal: {distance_goal_cm} cm")
print(f"Motors active: {motors_active}")
print("=" * 50)
```

> **Teacher note:**
> - `"=" * 50` repeats the `=` character 50 times. Nice visual effect.
> - This combines everything: variables, math, f-strings with formatting.
> - Point out the comments—they're for humans, not Python.

**Run it, show the output. Ask:** "What would you change to match your robot's specs?"

---

## COMMON MISTAKES TO WATCH FOR

| Mistake | Example | Problem | Fix |
|---------|---------|---------|-----|
| Forgetting quotes on strings | `robot_name = Dash` | Python thinks "Dash" is a variable name | `robot_name = "Dash"` |
| Mixing + with different types | `"Speed: " + 75` | Can't add text + number | `"Speed: " + str(75)` |
| Wrong variable name | `print(speed)` but defined `motor_speed` | Variable doesn't exist | Use correct name or define it |
| Forgetting `f` in f-string | `print("{speed}")` | Prints `{speed}` literally | `print(f"{speed}")` |
| Capitalization in booleans | `print(true)` | Python doesn't recognize "true" | `print(True)` (capital T and F) |

---

## QUESTIONS STUDENTS MIGHT ASK

**Q: Can I use a number as a variable name?**
A: No. Variable names must start with a letter or underscore. `motor1_speed` is okay, but `1_motor_speed` is not.

**Q: Can I change a variable after I create it?**
A: Yes! That's the whole point. `speed = 75` then later `speed = 90` completely replaces the first value.

**Q: Do I need to use f-strings?**
A: No, but they're cleaner. You can use comma-style print or concatenation with `+` and `str()`, but f-strings are modern and easier to read.

**Q: Why does the error say "TypeError"?**
A: It's telling you the type (kind) of data is wrong for what you're trying to do.

---

## NEXT STEPS
- Have students open their own Python files and type these examples
- Let them modify variable values and re-run
- Encourage them to break code intentionally (and fix it) to understand errors
