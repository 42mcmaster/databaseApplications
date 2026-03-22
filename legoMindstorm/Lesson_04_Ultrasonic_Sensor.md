# Lesson 04 – Ultrasonic Sensor: Your Robot's Eyes
### EV3 MicroPython Robotics

---

## What You'll Learn
By the end of this lesson you will:
- Understand how the ultrasonic sensor measures distance
- Know the Python commands to read the sensor
- Combine sensor input with driving to make the robot **react** to its environment
- Design and build your own sensor-based robot program

**Time:** ~60 minutes
**What you need:** EV3 Brick, 2x Large Motors, Ultrasonic Sensor, driving base build, Mini-USB cable, Computer

---

## Background – What Is the Ultrasonic Sensor?

The ultrasonic sensor works like a bat's sonar. It sends out a high-frequency sound pulse and measures how long it takes to bounce back. From that, it calculates the **distance to the nearest object** in front of it.

```
Ultrasonic Sensor          Object
   )))  →  →  →  →  →      |
   (((  ←  ←  ←  ←  ←      |
                            |
   "That object is 35 cm away."
```

**Key facts:**
- Measures distance from **0 to 255 cm** (about 8 feet)
- Returns the distance in **millimeters** by default
- Plugs into one of the **sensor ports** on the bottom of the EV3 brick (Ports 1, 2, 3, or 4)
- Works best when pointed directly at a flat surface

---

## Part 1 – Setup and First Reading

Plug the ultrasonic sensor into **Port 4** on your EV3 brick. Mount it on the front of your driving base so it faces forward.

Create a new project called `ultrasonic_test`. Type this code:

```python
#!/usr/bin/env pybricks-micropython

from pybricks.hubs import EV3Brick
from pybricks.ev3devices import Motor, UltrasonicSensor
from pybricks.parameters import Port
from pybricks.tools import wait

ev3 = EV3Brick()

# Create the ultrasonic sensor object on Port 4.
obstacle_sensor = UltrasonicSensor(Port.S4)

ev3.speaker.beep()
ev3.screen.clear()

# Read the distance 10 times, once per second.
for i in range(10):
    distance = obstacle_sensor.distance()
    ev3.screen.print("Dist: " + str(distance) + " mm")
    wait(1000)
```

Run it, then move your hand closer and farther from the sensor while it runs. Watch the numbers change on the EV3 screen.

**New commands introduced:**

| Command | What it does |
|---|---|
| `UltrasonicSensor(Port.S4)` | Creates a sensor object on Port 4 (sensor ports use `S1`–`S4`) |
| `obstacle_sensor.distance()` | Returns the distance to the nearest object in mm |

---

## Part 2 – Reacting to Distance

Now let's make the robot **do something** based on what the sensor reads. This is where `while True` and `if/else` come together with `robot.drive()`.

Read this example carefully:

```python
#!/usr/bin/env pybricks-micropython

from pybricks.hubs import EV3Brick
from pybricks.ev3devices import Motor, UltrasonicSensor
from pybricks.parameters import Port
from pybricks.robotics import DriveBase
from pybricks.tools import wait

ev3 = EV3Brick()
left_motor  = Motor(Port.B)
right_motor = Motor(Port.C)
robot = DriveBase(left_motor, right_motor, wheel_diameter=55.5, axle_track=104)

obstacle_sensor = UltrasonicSensor(Port.S4)

ev3.speaker.beep()

# Drive forward until something is closer than 200 mm (about 8 inches).
while True:
    distance = obstacle_sensor.distance()

    if distance < 200:
        robot.stop()
        ev3.speaker.beep(880, 200)
        break
    else:
        robot.drive(150, 0)

    wait(10)

ev3.screen.print("Object detected!")
ev3.screen.print("Dist: " + str(distance) + " mm")
```

**What's happening:**
- `while True:` — loop runs forever until we `break`
- Each loop: read the sensor, decide what to do
- `robot.drive(150, 0)` — drive forward at 150 mm/s, no turning (remember from Lesson 03: `drive()` doesn't block, so we can keep checking the sensor)
- `if distance < 200:` — if something is within 200 mm, stop and break out of the loop
- `wait(10)` — tiny pause so we don't overload the brick

**This is the core pattern for sensor-based programs:**
```
while True:
    read sensor
    if condition:
        react
    else:
        keep going
    wait(10)
```

You'll use this pattern in every sensor lesson from now on.

---

## Part 3 – Your Project

Now it's your turn. You're going to design a robot that uses the **ultrasonic sensor** and **two motors** to accomplish a goal that **you choose**.

### The Rules

1. Your robot must use the **ultrasonic sensor** to make decisions
2. Your robot must use the **DriveBase** (two motors) to move
3. You must use a **`while` loop** with sensor readings inside it
4. You decide what the robot's **goal** is — be creative

### Some Ideas to Get You Started

Pick one of these or come up with your own:
- **Guardian robot** — drives forward and backward on patrol, turns around when it detects a wall
- **Shy robot** — backs away when something gets too close
- **Parking assistant** — drives forward slowly and beeps faster as it gets closer to an object (like a car's parking sensor)
- **Explorer** — drives forward, and when it hits a wall, turns a random amount and keeps going
- **Distance alarm** — sits still, but sounds an alarm and flashes the light when something enters its zone
- **Follow the leader** — tries to stay a fixed distance behind your hand as you move it

### Your Planning Checklist

Before you write code, answer these on paper:

**1. What is your robot's goal?** (one sentence)

**2. What should the robot do when the sensor reads a SHORT distance?** (object is close)

**3. What should the robot do when the sensor reads a LONG distance?** (nothing nearby)

**4. What distance threshold(s) will you use?** (e.g., 200 mm, 500 mm — you may need more than one)

**5. Pseudocode** — write your logic in plain English:
```
Example:
  - Start driving forward
  - Loop forever:
      - Read the sensor
      - If distance < 150 mm:
          - Stop, beep, turn right 90 degrees
      - Else:
          - Keep driving forward
```

### Write Your Code

Create a new project. Write your program from scratch. Comment every meaningful line.

**Requirements:**
- [ ] Uses `UltrasonicSensor` to read distance
- [ ] Uses `DriveBase` to move
- [ ] Has a `while` loop with sensor readings
- [ ] Has at least one `if/else` decision based on the sensor
- [ ] Has comments explaining the logic
- [ ] Displays something useful on the EV3 screen (distance, status, etc.)

### Test and Iterate

Your first version probably won't work perfectly. That's expected. Adjust your threshold values, speeds, and turn angles until the behavior matches your goal.

---

## What to Turn In

1. **Post your code** to GitHub as `legoMs04.py`
2. **Demo the robot** to the teacher — show it working
3. **Explain your goal** — what were you trying to make the robot do, and how does the sensor data drive the decisions?

---

## Quick Reference

| Command | What it does |
|---|---|
| `UltrasonicSensor(Port.S4)` | Creates sensor object on Port 4 |
| `sensor.distance()` | Returns distance to nearest object in mm (0–2550) |
| `robot.drive(speed, turn_rate)` | Drive continuously (doesn't block) |
| `robot.stop()` | Stop the robot |
| `while True:` / `break` | Loop forever / exit the loop |
| `if` / `elif` / `else` | Make decisions based on sensor data |

---

*Next up → **Lesson 05: Color Sensor** — your robot learns to see color and light.*
