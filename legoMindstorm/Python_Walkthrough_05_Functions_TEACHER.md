# Python Walkthrough 05: Functions — TEACHER NOTES
**Topic:** Functions as reusable code blocks. Parameters, return values, and building complex functions.

---

## **Section 1: Why Functions? The Repetition Problem**

### The Problem: Copy-Paste Code

When you find yourself writing the same code over and over, **functions** are the answer.

**Scenario:** Your EV3 robot needs to "beep and report" its status three times during a mission. Without functions:

```python
print("Motor A speed: 75%")
print("Distance traveled: 120 cm")
print("---")

print("Motor A speed: 75%")
print("Distance traveled: 120 cm")
print("---")

print("Motor A speed: 75%")
print("Distance traveled: 120 cm")
print("---")
```

> **Teacher note:** Ask students: *"How many times did we type those two lines? What if the robot's status report needs to change? Do we have to fix it in three places?"*

### The Solution: Write Once, Use Many Times

```python
def report_status():
    print("Motor A speed: 75%")
    print("Distance traveled: 120 cm")
    print("---")

report_status()
report_status()
report_status()
```

Same output, **cleaner code**. And if you need to change the report? Edit the function once.

> **Teacher note:** Emphasize: *"A function is just a named block of code. We write it once, call it as many times as we want."*

---

## **Section 2: `def` and Parameters — Writing Your First Function**

### Basic Function: No Parameters

```python
def greet_robot():
    print("Hello, EV3 robot!")
    print("Ready to roll!")

greet_robot()
```

**Output:**
```
Hello, EV3 robot!
Ready to roll!
```

> **Teacher note:** Point out the syntax:
> - `def` = "define a function"
> - `greet_robot()` = function name (lowercase, underscores)
> - `:` at the end
> - **Indentation** — everything inside the function must indent 4 spaces
> - **Calling** — `greet_robot()` with parentheses runs it

---

### Function with One Parameter

Parameters let functions accept **input**.

```python
def set_motor_speed(speed):
    print(f"Setting motor speed to {speed}%")

set_motor_speed(50)
set_motor_speed(100)
set_motor_speed(25)
```

**Output:**
```
Setting motor speed to 50%
Setting motor speed to 100%
Setting motor speed to 25%
```

**What's happening:**
- `speed` is a **parameter** — a variable that the function receives
- When we call `set_motor_speed(50)`, `speed` becomes `50` inside the function
- Each call can pass a different value

> **Teacher note:** Reinforce the difference:
> - **Parameter** = the variable name in the `def` line (e.g., `speed`)
> - **Argument** = the actual value we pass when calling (e.g., `50`)

---

### Function with Multiple Parameters

```python
def drive_robot(speed, distance):
    print(f"Driving at {speed}% speed")
    print(f"Distance: {distance} cm")

drive_robot(75, 100)
drive_robot(50, 200)
```

**Output:**
```
Driving at 75% speed
Distance: 100 cm
Driving at 50% speed
Distance: 200 cm
```

> **Teacher note:** Show that parameters are separated by commas. The **order matters** — first argument goes to first parameter, etc.

---

## **Section 3: `return` — Functions That Give Back Values**

### Calculating Inside a Function

Sometimes we don't just want to print; we want a function to **calculate and return a result**.

```python
def calculate_travel_time(distance, speed):
    time = distance / speed
    return time

time_needed = calculate_travel_time(100, 50)
print(f"Time needed: {time_needed} seconds")
```

**Output:**
```
Time needed: 2.0 seconds
```

**What's happening:**
- The function **calculates** `time`
- `return` sends that value **back out** to where the function was called
- We can **store** the returned value in a variable (`time_needed`)
- Then use it

---

### Function with Print AND Return

```python
def battery_check(voltage):
    if voltage > 8:
        status = "GOOD"
    else:
        status = "LOW"
    print(f"Battery voltage: {voltage}V — Status: {status}")
    return status

result = battery_check(9)
result = battery_check(7)
```

**Output:**
```
Battery voltage: 9V — Status: GOOD
Battery voltage: 7V — Status: LOW
```

> **Teacher note:** Point out: *"A function can do two things: print something AND return a value. The return value is separate from what it prints."*

---

## **Section 4: Function with a For Loop Inside**

### Repeating Actions Inside a Function

What if we want a function to **do something multiple times**?

```python
def spin_motor(times, speed):
    for i in range(times):
        print(f"Spin {i+1}: Motor at {speed}%")

spin_motor(3, 80)
```

**Output:**
```
Spin 1: Motor at 80%
Spin 2: Motor at 80%
Spin 3: Motor at 80%
```

**Indentation is CRITICAL:**
- The `for` loop is **indented** inside the function
- Everything in the loop is **doubly indented**

---

### Accumulating Values in a Loop (Inside a Function)

```python
def total_distance_traveled(num_trips, distance_per_trip):
    total = 0
    for i in range(num_trips):
        total = total + distance_per_trip
        print(f"Trip {i+1}: {distance_per_trip} cm")
    return total

result = total_distance_traveled(5, 50)
print(f"Total: {result} cm")
```

**Output:**
```
Trip 1: 50 cm
Trip 2: 50 cm
Trip 3: 50 cm
Trip 4: 50 cm
Trip 5: 50 cm
Total: 250 cm
```

> **Teacher note:** This is the **accumulator pattern** inside a function:
> 1. Start with `total = 0`
> 2. In the loop, add to it each time
> 3. After the loop (still inside the function), `return total`

---

## **Section 5: Function with If/Else Inside**

### Decision-Making Inside a Function

```python
def check_sensor_reading(sensor_value):
    if sensor_value > 50:
        response = "OBSTACLE DETECTED"
    else:
        response = "PATH CLEAR"
    print(f"Sensor reading: {sensor_value} — {response}")
    return response

check_sensor_reading(60)
check_sensor_reading(30)
```

**Output:**
```
Sensor reading: 60 — OBSTACLE DETECTED
Sensor reading: 30 — PATH CLEAR
```

---

### Multiple Conditions

```python
def analyze_motor_load(load_percent):
    if load_percent > 80:
        status = "OVERLOAD"
    elif load_percent > 50:
        status = "HEAVY"
    else:
        status = "NORMAL"
    return status

print(analyze_motor_load(90))
print(analyze_motor_load(65))
print(analyze_motor_load(25))
```

**Output:**
```
OVERLOAD
HEAVY
NORMAL
```

> **Teacher note:** Remind students: `return` **exits** the function immediately. Whichever branch sets the variable first, that's the one that returns.

---

## **Section 6: Putting It Together — Loop AND If/Else**

### The Sensor Patrol Pattern

This is what real EV3 programs look like: **scan sensors in a loop, make decisions based on readings**.

```python
def patrol_robot(num_scans, threshold):
    for scan in range(num_scans):
        sensor = 40 + scan * 15  # Simulated sensor reading

        if sensor > threshold:
            print(f"Scan {scan+1}: {sensor} — STOP! Obstacle!")
            break  # Exit the loop early
        else:
            print(f"Scan {scan+1}: {sensor} — Path clear, moving...")

    print("Patrol complete")

patrol_robot(5, 60)
```

**Output:**
```
Scan 1: 40 — Path clear, moving...
Scan 2: 55 — Path clear, moving...
Scan 3: 70 — STOP! Obstacle!
Patrol complete
```

> **Teacher note:** This combines EVERYTHING:
> - Function definition with parameters
> - A `for` loop inside it
> - An `if/else` decision inside the loop
> - A `break` statement to exit early
> - This IS the pattern for real EV3 sensor programs

---

## **Section 7: Calling Functions from Loops**

### Reusing a Function Multiple Times in a Loop

```python
def make_beep(pitch):
    print(f"BEEP! (pitch: {pitch}Hz)")

for i in range(4):
    make_beep(1000 + (i * 100))
```

**Output:**
```
BEEP! (pitch: 1000Hz)
BEEP! (pitch: 1100Hz)
BEEP! (pitch: 1200Hz)
BEEP! (pitch: 1300Hz)
```

---

## **Common Student Mistakes & Fixes**

| Mistake | Code | Error | Fix |
|---------|------|-------|-----|
| Forgetting `return` | `def get_speed(): speed = 75` | `None` returned | Add `return speed` |
| Calling without parentheses | `greet_robot` | Function not called | Use `greet_robot()` |
| Wrong indentation | Function body not indented | `IndentationError` | Indent 4 spaces inside `def` |
| Parameter name mismatch | `def drive(x):` then use `speed` in body | `NameError` | Use the exact parameter name |
| Forgetting colon | `def report()` | `SyntaxError` | Add `:` after parentheses |
| Breaking scope | `def test(): x = 5` then print `x` outside | `NameError` | Variables inside functions are local |

> **Teacher note:** The **indentation** and **colon** are the two most common gotchas. Have students check these first if something doesn't work.

---

## **Teaching Tips**

1. **Start small:** Begin with no parameters, then add one parameter, then two. Don't overwhelm.
2. **Always show the output:** Even simple functions should show what prints and what returns.
3. **Use the EV3 narrative:** "The robot needs to check its battery status" — makes functions feel real.
4. **Emphasize reusability:** The whole point is avoiding copy-paste. Show the before/after.
5. **Demo the break:** Show how `break` exits a loop early when a condition is met — this is how robots "stop on obstacle."
6. **Practice parameter order:** Many students mix up which argument goes to which parameter. Use 2-3 examples.

---

## **Review Questions for Students**

1. What's the difference between a parameter and an argument?
2. When you call a function, what does `return` do?
3. Can you have a loop inside a function? Can you have an if/else inside a loop inside a function?
4. Write a function that takes a number and returns that number doubled.
5. What happens if you forget the colon after the function name?
6. How do you call a function with two parameters?

