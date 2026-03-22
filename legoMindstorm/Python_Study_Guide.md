# Python Study Guide: All 5 Topics (Cheat Sheet)
**Keep this at your desk while coding!**

---

## **Section 1: Basics**

### Print & Variables
```python
print("Hello, EV3!")           # Print to console
name = "Robot"                 # Create a variable
age = 5                        # Variables hold values
print(name, age)               # Print multiple things
```

### Variable Types

| Type | Example | Use |
|------|---------|-----|
| `int` | `speed = 75` | Whole numbers |
| `float` | `voltage = 8.5` | Decimal numbers |
| `str` | `name = "Motor A"` | Text, always in quotes |
| `bool` | `is_moving = True` | True or False only |

### Math Operators

| Operator | Example | Result |
|----------|---------|--------|
| `+` | `10 + 5` | 15 |
| `-` | `10 - 5` | 5 |
| `*` | `10 * 5` | 50 |
| `/` | `10 / 5` | 2.0 (always float) |
| `//` | `10 // 3` | 3 (integer division) |
| `%` | `10 % 3` | 1 (remainder) |
| `**` | `2 ** 3` | 8 (power) |

### F-Strings (String Formatting)
```python
speed = 75
distance = 100
print(f"Speed: {speed}%, Distance: {distance} cm")
# Output: Speed: 75%, Distance: 100 cm
```

### str() — Convert to String
```python
num = 42
text = str(num)       # Convert number to string
print(text)           # "42"
print(type(text))     # <class 'str'>
```

---

## **Section 2: For Loops**

### range() — Three Versions

```python
for i in range(5):              # 0, 1, 2, 3, 4
    print(i)

for i in range(2, 7):           # 2, 3, 4, 5, 6
    print(i)

for i in range(0, 10, 2):       # 0, 2, 4, 6, 8 (count by 2s)
    print(i)
```

### Basic Loop Structure
```python
for i in range(3):
    print(f"Loop iteration {i}")
# Output: 0, 1, 2
```

### Accumulator Pattern (Add Up Values)
```python
total = 0                    # Start with 0
for i in range(5):
    total = total + 10       # Add 10 each time
print(f"Total: {total}")     # Total: 50
```

### Loop Over a List
```python
motors = ["A", "B", "C"]
for motor in motors:
    print(f"Motor {motor}")
# Output: Motor A, Motor B, Motor C
```

---

## **Section 3: If/Else**

### Comparison Operators

| Operator | Meaning | Example |
|----------|---------|---------|
| `==` | Equal to | `speed == 75` |
| `!=` | Not equal | `speed != 0` |
| `>` | Greater than | `distance > 100` |
| `<` | Less than | `distance < 50` |
| `>=` | Greater or equal | `voltage >= 8` |
| `<=` | Less or equal | `voltage <= 12` |

### If/Elif/Else
```python
sensor = 60

if sensor > 80:
    print("OBSTACLE!")
elif sensor > 50:
    print("CAUTION")
else:
    print("CLEAR")
```

### Logical Operators

| Operator | Meaning | Example |
|----------|---------|---------|
| `and` | Both must be true | `speed > 50 and speed < 100` |
| `or` | At least one true | `sensor > 80 or battery < 8` |
| `not` | Opposite | `not is_moving` |

### If Inside a Loop
```python
for i in range(5):
    if i % 2 == 0:           # If even
        print(f"{i} is even")
    else:
        print(f"{i} is odd")
```

---

## **Section 4: While Loops**

### While Condition
```python
count = 0
while count < 5:
    print(f"Count: {count}")
    count = count + 1        # Must change the condition!
# Output: 0, 1, 2, 3, 4
```

### While True + Break
```python
while True:                  # Loop forever...
    sensor = 65
    if sensor > 80:
        print("Obstacle! Breaking out.")
        break                # ...until break is reached
    else:
        print("Path clear")
        break                # Always breaks (just one iteration here)
```

### The EV3 Sensor Pattern
```python
while True:
    sensor_reading = 50      # Get sensor value (in real EV3, this comes from sensor)

    if sensor_reading > 70:
        print("STOP!")
        break
    else:
        print("Drive forward")
```

---

## **Section 5: Functions**

### Def Syntax
```python
def function_name(parameter1, parameter2):
    print("Inside function")
    return some_value

function_name(arg1, arg2)    # Call the function
```

### Function with Parameters
```python
def set_speed(motor, speed):
    print(f"Motor {motor}: {speed}%")

set_speed("A", 75)           # Arguments fill the parameters
```

### Function with Return
```python
def double_it(num):
    result = num * 2
    return result            # Send value back out

answer = double_it(21)       # Store returned value
print(answer)                # 42
```

### Function with Loop Inside
```python
def repeat_beep(times):
    for i in range(times):
        print(f"BEEP {i+1}")

repeat_beep(3)
```

### Function with Loop + Return
```python
def sum_numbers(count):
    total = 0
    for i in range(count):
        total = total + (i + 1)
    return total             # Return after loop ends

result = sum_numbers(5)      # Should be 15 (1+2+3+4+5)
```

### Function with If/Else Inside
```python
def check_status(value, threshold):
    if value > threshold:
        status = "OK"
    else:
        status = "ALARM"
    return status

print(check_status(85, 80))  # OK
print(check_status(70, 80))  # ALARM
```

### Function with Loop + If/Else
```python
def patrol(num_scans, threshold):
    for i in range(num_scans):
        sensor = 30 + (i * 20)

        if sensor > threshold:
            print(f"Scan {i+1}: STOP! Reading {sensor}")
            break
        else:
            print(f"Scan {i+1}: Clear, reading {sensor}")

patrol(4, 60)
```

---

## **Section 6: Common Errors**

| Error | Wrong | Right | Reason |
|-------|-------|-------|--------|
| Missing `:` | `if x > 5` | `if x > 5:` | Python needs colon |
| Bad indent | `for i in range(3):`<br/>`print(i)` | `for i in range(3):`<br/>`    print(i)` | Body must be indented 4 spaces |
| `=` vs `==` | `if x = 5:` | `if x == 5:` | `=` is assignment, `==` is comparison |
| Forgot `()` on call | `my_func` | `my_func()` | Must use parentheses to call |
| Forgot `return` | `def double(x):`<br/>`    result = x * 2` | `def double(x):`<br/>`    result = x * 2`<br/>`    return result` | Function returns `None` without `return` |
| Wrong param name | `def drive(spd):`<br/>`    print(speed)` | `def drive(speed):`<br/>`    print(speed)` | Must use exact parameter name |
| Off-by-one in loop | `for i in range(5): print(i)` → 0,1,2,3,4 | Use `i+1` to print 1,2,3,4,5 | `range(5)` starts at 0 |

---

## **Section 7: The Complete EV3 Sensor Pattern**

**This is what you'll use in every EV3 program:**

```python
def robot_patrol(num_checks, obstacle_threshold):
    """
    Drive and check sensor until obstacle found or checks done.
    """
    for attempt in range(num_checks):
        # Get sensor reading (in real EV3, use ev3.sensor...)
        sensor_value = 45 + (attempt * 10)

        # Check if obstacle detected
        if sensor_value > obstacle_threshold:
            print(f"Attempt {attempt+1}: OBSTACLE DETECTED ({sensor_value})")
            print("ROBOT STOPPING!")
            break
        else:
            print(f"Attempt {attempt+1}: Path clear ({sensor_value}), moving forward")

    print("Patrol complete")

# Call it
robot_patrol(5, 70)
```

**Pattern breakdown:**
1. **Function definition** with parameters for flexibility
2. **For loop** to repeat sensor checks
3. **If/else** to decide what to do based on sensor
4. **Break** to stop when obstacle found
5. **Prints** at each step to report status
6. All inside a function so you can reuse it

---

## **Quick Reference: When to Use What**

| Need | Use | Example |
|------|-----|---------|
| Repeat code 3 times | `for` loop with `range(3)` | Check sensor 3 times |
| Repeat while condition true | `while` loop | Keep driving while path clear |
| Pick between options | `if/elif/else` | Different actions based on sensor |
| Reuse a block of code | `def` function | Motor report, obstacle check |
| Calculate a value | `return` in function | Distance from time and speed |
| Combine everything | Loop + if/else in function | Patrol robot behavior |

---

## **Print Statements for Debugging**

When your code doesn't work, add `print()` statements:

```python
def my_function(x):
    print(f"Received x = {x}")      # Check parameter
    result = x * 2
    print(f"Calculated result = {result}")  # Check value
    return result

my_function(10)
```

Output tells you if variables have the right values at the right time!

