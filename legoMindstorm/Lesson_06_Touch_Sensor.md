# Lesson 06 – Touch Sensor: Your Robot's Sense of Touch
### EV3 MicroPython Robotics

---

## What You'll Learn
By the end of this lesson you will:
- Understand how the touch sensor detects pressed, released, and bumped
- Know the Python commands to read the sensor
- Use touch input to start, stop, or trigger robot actions
- Design and build your own touch-driven robot program

**Time:** ~60 minutes
**What you need:** EV3 Brick, 2x Large Motors, Touch Sensor, driving base build, Mini-USB cable, Computer

---

## Background – What Is the Touch Sensor?

The touch sensor is the simplest sensor in the kit. It has a red button on the front, and it reports one of two things: is the button being pushed right now, or not?

```
Touch Sensor
   ┌───────┐
   │   ●   │  ← red button
   └───────┘
   pressed  = True
   released = False
```

**Key facts:**
- Reports either **True** (pressed) or **False** (not pressed) — that's it
- A **bump** means pressed then released
- Plugs into any sensor port (S1–S4)
- Perfect for starting programs, stopping programs, or counting events

---

## Part 1 – Setup and First Reading

Plug the touch sensor into **Port 1** on your EV3 brick. Mount it somewhere on your robot where you can reach it easily — the front bumper is a good spot if you want the robot to detect collisions.

Create a new project called `touch_test`. Type this code:

```python
#!/usr/bin/env pybricks-micropython

from pybricks.hubs import EV3Brick
from pybricks.ev3devices import TouchSensor
from pybricks.parameters import Port
from pybricks.tools import wait

ev3 = EV3Brick()

# Create the touch sensor object on Port 1.
bumper = TouchSensor(Port.S1)

ev3.speaker.beep()
ev3.screen.clear()

# Read the sensor 20 times, twice a second.
for i in range(20):
    if bumper.pressed():
        ev3.screen.print("PRESSED")
    else:
        ev3.screen.print("released")
    wait(500)
```

Run it, then press and release the button while it runs. Watch the screen change.

**New commands introduced:**

| Command | What it does |
|---|---|
| `TouchSensor(Port.S1)` | Creates a touch sensor object on Port 1 |
| `bumper.pressed()` | Returns `True` if pressed, `False` if not |

---

## Part 2 – Reacting to Touch

Now let's make the robot do something when the button is pressed. Here's an example that waits for a press before driving off — the touch sensor becomes a "go" button.

```python
#!/usr/bin/env pybricks-micropython

from pybricks.hubs import EV3Brick
from pybricks.ev3devices import Motor, TouchSensor
from pybricks.parameters import Port
from pybricks.robotics import DriveBase
from pybricks.tools import wait

ev3 = EV3Brick()
left_motor  = Motor(Port.B)
right_motor = Motor(Port.C)
robot = DriveBase(left_motor, right_motor, wheel_diameter=55.5, axle_track=104)

bumper = TouchSensor(Port.S1)

ev3.screen.print("Press to start")

# Wait until the button is pressed.
while not bumper.pressed():
    wait(10)

ev3.speaker.beep()
robot.straight(300)   # drive forward 300 mm
robot.stop()
```

Here's a second example — a front bumper that drives forward until it hits something:

```python
# Drive forward until the touch sensor is pressed.
while True:
    if bumper.pressed():
        robot.stop()
        ev3.speaker.beep(880, 300)
        break
    else:
        robot.drive(150, 0)
    wait(10)

ev3.screen.print("Bumped!")
```

**Same core sensor pattern:**
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

Design a robot that uses the **touch sensor** and **two motors** to accomplish a goal that **you choose**.

### The Rules

1. Your robot must use the **touch sensor** to make decisions
2. Your robot must use the **DriveBase** (two motors) to move
3. You must use a **`while` loop** with sensor readings inside it
4. You decide what the robot's **goal** is — be creative

### Some Ideas to Get You Started

- **Bumper bot** — drives forward until it hits a wall, then backs up and turns
- **Press-to-start** — sits still, and only drives once the button is pressed
- **Counting bot** — counts button presses on the screen until you press 10 times, then beeps
- **Kill switch** — drives in a pattern (circle, square, figure-8) until the button is pressed, then stops
- **Two-press dance** — first press = spin, second press = drive forward, third press = stop

### Your Planning Checklist

Before you write code, answer these on paper:

**1. What is your robot's goal?** (one sentence)

**2. What should happen when the button is PRESSED?**

**3. What should happen when the button is NOT pressed?**

**4. Pseudocode** — write your logic in plain English:
```
Example (bumper bot):
  - Loop forever:
      - If the button is pressed:
          - Stop, back up, turn 90 degrees
      - Else:
          - Keep driving forward
```

### Write Your Code

Create a new project. Write your program from scratch. Comment every meaningful line.

**Requirements:**
- [ ] Uses `TouchSensor` to read the button
- [ ] Uses `DriveBase` to move
- [ ] Has a `while` loop with sensor readings
- [ ] Has at least one `if/else` decision based on the sensor
- [ ] Has comments explaining the logic
- [ ] Displays something useful on the EV3 screen

### Test and Iterate

Mount the sensor firmly so it doesn't wiggle off during a run. If you're building a bumper, make sure the button actually gets pushed when the robot hits something — you may need to build a small lever arm in front of it.

---

## What to Turn In

1. **Post your code** to GitHub as `legoMs06.py`
2. **Demo the robot** to the teacher — show it working
3. **Explain your goal** — what were you trying to make the robot do, and how does the touch sensor drive the decisions?

---

## Quick Reference

| Command | What it does |
|---|---|
| `TouchSensor(Port.S1)` | Creates sensor object on Port 1 |
| `sensor.pressed()` | Returns `True` if pressed, `False` if not |
| `robot.drive(speed, turn_rate)` | Drive continuously (doesn't block) |
| `robot.straight(distance_mm)` | Drive straight a set distance |
| `robot.stop()` | Stop the robot |
| `while True:` / `break` | Loop forever / exit the loop |

---

*Next up → **Lesson 07: Gyro Sensor** — your robot learns to measure its own turning.*
