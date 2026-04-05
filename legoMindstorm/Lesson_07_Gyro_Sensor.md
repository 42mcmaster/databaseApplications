# Lesson 07 – Gyro Sensor: Your Robot Knows Which Way It's Facing
### EV3 MicroPython Robotics

---

## What You'll Learn
By the end of this lesson you will:
- Understand how the gyro sensor measures rotation
- Know the Python commands to read and reset the gyro
- Use the gyro to make precise turns
- Design and build your own gyro-driven robot program

**Time:** ~60 minutes
**What you need:** EV3 Brick, 2x Large Motors, Gyro Sensor, driving base build, Mini-USB cable, Computer

---

## Background – What Is the Gyro Sensor?

The gyro sensor measures **rotation** — how much the robot is turning and how fast. It doesn't care about distance or light or touch. It only cares about twisting.

```
Gyro Sensor (top view)
       ↑ 0°
       │
  -90° ─┼─ +90°
       │
      180°
```

**Key facts:**
- Measures the **total angle** the robot has rotated, in degrees
- Also measures the **rate of rotation** in degrees per second
- Clockwise turns are positive, counter-clockwise turns are negative
- Plugs into any sensor port (S1–S4)
- **Drift warning:** the sensor must be held completely still when the robot is first powered on. If you move it during startup, the readings will slowly creep even when the robot is still. Always reset the angle before a turn you care about.

---

## Part 1 – Setup and First Reading

Plug the gyro sensor into **Port 2** on your EV3 brick. Mount it flat on top of your driving base so the arrows on the sensor point up (not sideways). **Hold the robot completely still** while you plug it in and start the program — this prevents drift.

Create a new project called `gyro_test`. Type this code:

```python
#!/usr/bin/env pybricks-micropython

from pybricks.hubs import EV3Brick
from pybricks.ev3devices import GyroSensor
from pybricks.parameters import Port
from pybricks.tools import wait

ev3 = EV3Brick()

# Create the gyro sensor object on Port 2.
gyro = GyroSensor(Port.S2)

# Reset the angle to 0 before we start reading.
gyro.reset_angle(0)

ev3.speaker.beep()
ev3.screen.clear()

# Read the angle 20 times, twice a second.
for i in range(20):
    angle = gyro.angle()
    ev3.screen.print("Angle: " + str(angle))
    wait(500)
```

Run it, then pick up the robot and slowly rotate it left and right. Watch the angle change — turning right adds to the number, turning left subtracts.

**New commands introduced:**

| Command | What it does |
|---|---|
| `GyroSensor(Port.S2)` | Creates a gyro sensor object on Port 2 |
| `gyro.reset_angle(0)` | Sets the current angle to 0 (use before every measured turn) |
| `gyro.angle()` | Returns the total rotation in degrees (positive = right, negative = left) |
| `gyro.speed()` | Returns the current rate of rotation in degrees per second |

---

## Part 2 – Reacting to Rotation

The gyro is perfect for making **precise turns**. Here's an example that turns the robot exactly 90 degrees to the right, no matter how fast it's spinning:

```python
#!/usr/bin/env pybricks-micropython

from pybricks.hubs import EV3Brick
from pybricks.ev3devices import Motor, GyroSensor
from pybricks.parameters import Port
from pybricks.robotics import DriveBase
from pybricks.tools import wait

ev3 = EV3Brick()
left_motor  = Motor(Port.B)
right_motor = Motor(Port.C)
robot = DriveBase(left_motor, right_motor, wheel_diameter=55.5, axle_track=104)

gyro = GyroSensor(Port.S2)
gyro.reset_angle(0)   # start fresh

ev3.speaker.beep()

# Spin in place until we've turned 90 degrees to the right.
while True:
    if gyro.angle() >= 90:
        robot.stop()
        break
    else:
        robot.drive(0, 60)   # speed 0, turn rate 60 deg/s
    wait(10)

ev3.screen.print("Turned 90 degrees")
ev3.screen.print("Final: " + str(gyro.angle()))
```

Here's a second example — drive forward while checking that the robot hasn't drifted off course. If it turns more than 5 degrees either way, stop:

```python
gyro.reset_angle(0)

while True:
    angle = gyro.angle()

    if angle > 5 or angle < -5:
        robot.stop()
        ev3.speaker.beep(880, 300)
        break
    else:
        robot.drive(150, 0)
    wait(10)

ev3.screen.print("Off course!")
ev3.screen.print("Angle: " + str(angle))
```

**Same core sensor pattern as the other lessons:**
```
while True:
    read sensor
    if condition:
        react
    else:
        keep going
    wait(10)
```

---

## Part 3 – Your Project

Design a robot that uses the **gyro sensor** and **two motors** to accomplish a goal that **you choose**.

### The Rules

1. Your robot must use the **gyro sensor** to make decisions
2. Your robot must use the **DriveBase** (two motors) to move
3. You must use a **`while` loop** with sensor readings inside it
4. Your program must **reset the gyro angle** before the first measured turn
5. You decide what the robot's **goal** is — be creative

### Some Ideas to Get You Started

- **Square driver** — drive forward a set distance, turn exactly 90 degrees, repeat four times to trace a square
- **Triangle or pentagon driver** — same idea but with different turn angles
- **Compass bot** — face a direction, then always come back to that heading no matter how you spin it
- **Spin counter** — beep and display the count every time the robot completes a full 360-degree spin
- **Drift detector** — drive straight, and if the angle drifts by more than 5 degrees, auto-correct back to 0
- **Turn-on-command** — drive forward until the angle reaches a target, then stop

### Your Planning Checklist

Before you write code, answer these on paper:

**1. What is your robot's goal?** (one sentence)

**2. What angle(s) do you care about?** (e.g., 90°, 180°, 360°)

**3. When will you reset the gyro to 0?**

**4. What should the robot do when the angle reaches your target?**

**5. Pseudocode** — write your logic in plain English:
```
Example (square driver):
  - Repeat 4 times:
      - Drive forward 30 cm
      - Reset gyro to 0
      - Turn right until gyro reads 90
      - Stop turning
```

### Write Your Code

Create a new project. Write your program from scratch. Comment every meaningful line.

**Requirements:**
- [ ] Uses `GyroSensor` to read rotation
- [ ] Calls `reset_angle(0)` before measured turns
- [ ] Uses `DriveBase` to move
- [ ] Has a `while` loop with sensor readings
- [ ] Has at least one `if/else` decision based on the sensor
- [ ] Has comments explaining the logic
- [ ] Displays something useful on the EV3 screen

### Test and Iterate

The gyro isn't perfect. If the robot turns too fast, it may overshoot your target angle before the code checks again. If it turns too slow, it may stop short. Try different turn rates until the robot hits the target cleanly. And if the readings seem to be creeping, reset the angle more often.

---

## What to Turn In

1. **Post your code** to GitHub as `legoMs07.py`
2. **Demo the robot** to the teacher — show it working
3. **Explain your goal** — what were you trying to make the robot do, and how does the gyro data drive the decisions?

---

## Quick Reference

| Command | What it does |
|---|---|
| `GyroSensor(Port.S2)` | Creates sensor object on Port 2 |
| `gyro.reset_angle(0)` | Resets the current angle to 0 |
| `gyro.angle()` | Returns total rotation in degrees (±) |
| `gyro.speed()` | Returns rate of rotation in deg/s |
| `robot.drive(speed, turn_rate)` | Drive and/or turn continuously |
| `robot.stop()` | Stop the robot |
| `while True:` / `break` | Loop forever / exit the loop |

---

*You now have seven lessons of EV3 skills: setup, single motors, DriveBase driving, ultrasonic sensing, color sensing, touch, and gyro. Keep building.*
