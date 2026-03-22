# Lesson 05 – Color Sensor: Your Robot Sees Color and Light
### EV3 MicroPython Robotics

---

## What You'll Learn
By the end of this lesson you will:
- Understand the three modes of the color sensor (color, reflected light, ambient light)
- Know the Python commands to read color and light values
- Combine sensor input with driving to make the robot react to surfaces and colors
- Design and build your own color-sensor-based robot program

**Time:** ~60 minutes
**What you need:** EV3 Brick, 2x Large Motors, Color Sensor, driving base build, Mini-USB cable, Computer, colored paper or tape for testing

---

## Background – What Is the Color Sensor?

The color sensor shines a light and measures what comes back. It has three modes:

**Color mode** — Detects one of 7 colors: Black, Blue, Green, Yellow, Red, White, Brown (plus "No Color" if it can't tell). Works best 1–2 cm from the surface.

**Reflected light mode** — Measures how much light bounces back from a surface. Returns a number from 0 (very dark) to 100 (very bright). Great for detecting lines on the floor.

**Ambient light mode** — Measures how much light is in the room (without shining its own light). Returns 0–100.

```
Color Sensor
   ↓ shines light down
   ═══════════════
   dark surface  →  low reflected value (10-20)
   light surface →  high reflected value (70-90)
```

---

## Part 1 – Setup and First Reading

Plug the color sensor into **Port 3** on your EV3 brick. Mount it on the bottom front of your driving base, pointing **down** at the floor, about 1–2 cm above the surface.

Create a new project called `color_test`. Type this code:

```python
#!/usr/bin/env pybricks-micropython

from pybricks.hubs import EV3Brick
from pybricks.ev3devices import Motor, ColorSensor
from pybricks.parameters import Port, Color
from pybricks.tools import wait

ev3 = EV3Brick()

# Create the color sensor object on Port 3.
color_sensor = ColorSensor(Port.S3)

ev3.speaker.beep()
ev3.screen.clear()

# Read color and light 10 times, once per second.
for i in range(10):
    color = color_sensor.color()
    light = color_sensor.reflection()

    ev3.screen.print("C:" + str(color) + " L:" + str(light))
    wait(1000)
```

Run it and move the robot over different surfaces — dark table, white paper, colored paper. Watch how the values change.

**New commands introduced:**

| Command | What it does |
|---|---|
| `ColorSensor(Port.S3)` | Creates a color sensor object on Port 3 |
| `color_sensor.color()` | Returns the detected color (e.g., `Color.BLACK`, `Color.WHITE`) |
| `color_sensor.reflection()` | Returns reflected light intensity (0 = dark, 100 = bright) |
| `color_sensor.ambient()` | Returns ambient light level (0 = dark, 100 = bright) |

**Color values you can check against:**
`Color.BLACK`, `Color.BLUE`, `Color.GREEN`, `Color.YELLOW`, `Color.RED`, `Color.WHITE`, `Color.BROWN`, `None` (no color detected)

---

## Part 2 – Reacting to Color and Light

Here's an example that drives forward and stops when it sees a dark line (like black tape on a light floor):

```python
#!/usr/bin/env pybricks-micropython

from pybricks.hubs import EV3Brick
from pybricks.ev3devices import Motor, ColorSensor
from pybricks.parameters import Port, Color
from pybricks.robotics import DriveBase
from pybricks.tools import wait

ev3 = EV3Brick()
left_motor  = Motor(Port.B)
right_motor = Motor(Port.C)
robot = DriveBase(left_motor, right_motor, wheel_diameter=55.5, axle_track=104)

color_sensor = ColorSensor(Port.S3)

ev3.speaker.beep()

# Drive forward until the sensor sees a dark surface.
while True:
    light = color_sensor.reflection()

    if light < 20:
        robot.stop()
        ev3.speaker.beep(880, 300)
        break
    else:
        robot.drive(100, 0)

    wait(10)

ev3.screen.print("Dark line found!")
ev3.screen.print("Light: " + str(light))
```

Here's an example that reacts to **specific colors**:

```python
# Inside a while loop:
color = color_sensor.color()

if color == Color.RED:
    robot.stop()
    ev3.speaker.beep(440, 500)
    ev3.screen.print("RED - Stop!")

elif color == Color.GREEN:
    robot.drive(200, 0)
    ev3.screen.print("GREEN - Go!")

elif color == Color.BLUE:
    robot.turn(90)
    ev3.screen.print("BLUE - Turn!")
```

**Same core pattern as Lesson 04:**
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

Design a robot that uses the **color sensor** and **two motors** to accomplish a goal that **you choose**.

### The Rules

1. Your robot must use the **color sensor** to make decisions (color mode, reflection mode, or both)
2. Your robot must use the **DriveBase** (two motors) to move
3. You must use a **`while` loop** with sensor readings inside it
4. You decide what the robot's **goal** is — be creative

### Some Ideas to Get You Started

Pick one of these or come up with your own:
- **Line follower** — follows the edge of a black line on a white surface using reflected light values
- **Color sorter** — drives over colored zones and does a different action for each color (beep, turn, spin, stop)
- **Edge detector** — drives on a table and turns around before going over the edge (dark surface = table, no reflection = edge)
- **Stoplight robot** — drives until it sees red (stop), waits for green (go), turns on yellow
- **Light seeker / light avoider** — uses ambient mode to drive toward or away from a flashlight
- **Patrol bot** — drives back and forth between two colored tape lines

### Your Planning Checklist

Before you write code, answer these on paper:

**1. What is your robot's goal?** (one sentence)

**2. Which sensor mode will you use?** (color, reflection, or both)

**3. What should the robot do for each sensor reading you care about?**

**4. Pseudocode** — write your logic in plain English:
```
Example (line follower):
  - Loop forever:
      - Read reflected light
      - If light > 50 (on white):
          - Steer slightly left
      - Else (on black):
          - Steer slightly right
```

### Write Your Code

Create a new project. Write your program from scratch. Comment every meaningful line.

**Requirements:**
- [ ] Uses `ColorSensor` to read color or light
- [ ] Uses `DriveBase` to move
- [ ] Has a `while` loop with sensor readings
- [ ] Has at least one `if/else` decision based on the sensor
- [ ] Has comments explaining the logic
- [ ] Displays something useful on the EV3 screen

### Test and Iterate

The color sensor can be finicky — distance from the surface, ambient lighting, and surface texture all matter. Experiment with your threshold values. Test on the actual surface you'll be demoing on.

---

## What to Turn In

1. **Post your code** to GitHub as `legoMs05.py`
2. **Demo the robot** to the teacher — show it working
3. **Explain your goal** — what were you trying to make the robot do, and how does the sensor data drive the decisions?

---

## Quick Reference

| Command | What it does |
|---|---|
| `ColorSensor(Port.S3)` | Creates sensor object on Port 3 |
| `sensor.color()` | Returns detected color (e.g., `Color.RED`) |
| `sensor.reflection()` | Returns reflected light (0–100) |
| `sensor.ambient()` | Returns ambient light (0–100) |
| `Color.BLACK`, `Color.RED`, etc. | Color constants for comparison |
| `robot.drive(speed, turn_rate)` | Drive continuously (doesn't block) |
| `robot.stop()` | Stop the robot |

---

*You now have five lessons of EV3 skills: setup, single motors, DriveBase driving, ultrasonic sensing, and color sensing. Keep building.*
