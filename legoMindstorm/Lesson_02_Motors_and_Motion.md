# Lesson 02 – Motors & Motion
### EV3 MicroPython Robotics

---

## What You'll Learn
By the end of this lesson you will:
- Connect a motor to the EV3 and control it with code
- Understand the difference between `run()`, `run_time()`, `run_angle()`, and `run_target()`
- Use a `for` loop to repeat motor actions
- Read button input from the EV3 brick

**Time:** ~45 minutes
**What you need:** EV3 Brick, 1x Large Motor, Mini-USB cable, Computer with VS Code

---

## Background – Motors and Ports

Your EV3 brick has **four output ports** labeled **A, B, C, D** on the top. Motors plug into these ports. In code, we tell Python which port a motor is connected to so it knows where to send commands.

```
EV3 Brick (top view)
 ┌──────────────────────┐
 │  [A]  [B]  [C]  [D]  │  ← Motor ports
 │                       │
 │       EV3 Brick       │
 └──────────────────────┘
```

For this lesson, plug your **Large Motor** into **Port B**.

---

## Part 1 – Your First Motor Program

Create a new project called `motors`. Replace everything in `main.py` with this:

```python
#!/usr/bin/env pybricks-micropython

from pybricks.hubs import EV3Brick
from pybricks.ev3devices import Motor
from pybricks.parameters import Port
from pybricks.tools import wait

# Create the brick and motor objects.
ev3 = EV3Brick()
motor = Motor(Port.B)

# Signal that we're ready.
ev3.speaker.beep()

# Spin the motor at 360 degrees per second for 2 seconds.
motor.run_time(360, 2000)

ev3.screen.print("Done!")
```

Run it with **F5**. The motor should spin for 2 seconds and stop.

---

## Part 2 – Motor Commands

There are four main ways to make a motor move. Each one is useful in different situations.

### `motor.run_time(speed, time)`

Runs the motor at a given speed for a set amount of time, then stops.

```python
# Spin at 360 deg/s for 3 seconds.
motor.run_time(360, 3000)

# Spin backward at 180 deg/s for 1.5 seconds.
motor.run_time(-180, 1500)
```

- **speed** is in degrees per second. 360 = one full rotation per second.
- **time** is in milliseconds. 1000 ms = 1 second.
- Negative speed = opposite direction.
- This command **blocks** — the program waits here until the time is up.

---

### `motor.run_angle(speed, angle)`

Runs the motor a specific number of degrees, then stops.

```python
# Rotate exactly 360 degrees (one full turn).
motor.run_angle(360, 360)

# Rotate 90 degrees (a quarter turn).
motor.run_angle(360, 90)

# Rotate backward 180 degrees.
motor.run_angle(360, -180)
```

- **speed** is how fast (degrees per second).
- **angle** is how far (degrees of rotation). Negative = opposite direction.
- Also blocks until the move is complete.

---

### `motor.run_target(speed, target_angle)`

Rotates the motor to a specific position (absolute angle), like the hands of a clock.

```python
# Go to the 90-degree position.
motor.run_target(360, 90)
wait(1000)

# Go to the 270-degree position.
motor.run_target(360, 270)
wait(1000)

# Go back to 0 (starting position).
motor.run_target(360, 0)
```

- **target_angle** is a position, not a distance. Calling `run_target(360, 90)` twice in a row does nothing the second time — the motor is already at 90.
- This is different from `run_angle()`, where each call moves the motor *further* by the given amount.

---

### `motor.run(speed)`

Starts the motor and **keeps it running** until you call `motor.stop()`. Unlike the other commands, this one does not block — the next line of code runs immediately.

```python
# Start spinning.
motor.run(360)

# The motor is running while we do other things.
wait(3000)

# Stop the motor.
motor.stop()
```

This is useful when you want the motor to run while checking buttons or sensors — which is exactly what we'll do next.

---

## Part 3 – Using a Loop

A `for` loop repeats a block of code. This is useful when you want the motor to do something multiple times.

```python
#!/usr/bin/env pybricks-micropython

from pybricks.hubs import EV3Brick
from pybricks.ev3devices import Motor
from pybricks.parameters import Port
from pybricks.tools import wait

ev3 = EV3Brick()
motor = Motor(Port.B)

ev3.speaker.beep()

# Spin forward and backward 3 times.
for i in range(3):
    ev3.screen.print("Lap " + str(i + 1))
    motor.run_angle(360, 360)     # Forward one full turn
    wait(300)
    motor.run_angle(360, -360)    # Backward one full turn
    wait(300)

ev3.screen.print("Done!")
ev3.speaker.beep(880, 300)
```

Remember:
- `range(3)` runs the loop 3 times (i = 0, 1, 2).
- `str(i + 1)` converts the number to a string and shifts it so the display shows 1, 2, 3.
- Lines **indented** under `for` are inside the loop. Lines at the same level as `for` run once after the loop finishes.

---

## Part 4 – Button Control (Stretch)

The EV3 brick has physical buttons you can read in code. This lets you build simple interactive programs.

```python
#!/usr/bin/env pybricks-micropython

from pybricks.hubs import EV3Brick
from pybricks.ev3devices import Motor
from pybricks.parameters import Port, Button
from pybricks.tools import wait

ev3 = EV3Brick()
motor = Motor(Port.B)

ev3.screen.clear()
ev3.screen.print("Right = Forward")
ev3.screen.print("Left  = Backward")
ev3.screen.print("Center = Quit")
ev3.speaker.beep()

while True:
    pressed = ev3.buttons.pressed()

    if Button.CENTER in pressed:
        break

    elif Button.RIGHT in pressed:
        motor.run(360)

    elif Button.LEFT in pressed:
        motor.run(-360)

    else:
        motor.stop()

    wait(10)

ev3.screen.print("Stopped.")
motor.stop()
```

**Key ideas:**
- `while True:` creates a loop that runs forever — until `break` is called.
- `ev3.buttons.pressed()` returns a list of which buttons are currently held down.
- `motor.run()` is used here instead of `run_time()` because we want the motor to keep running as long as the button is held. `run_time()` would block and prevent us from checking buttons.
- `wait(10)` gives the brick a tiny pause each loop so it doesn't overwork itself.

---

## Challenges

Try these on your own. Each one builds on what you've learned.

### Challenge 1 – Back and Forth

Make the motor spin **forward 720 degrees**, pause for 1 second, then spin **backward 720 degrees**. Repeat this **4 times** using a `for` loop. Print the repetition number to the screen each time.

### Challenge 2 – Speed Ramp

Make the motor run at **increasing speeds**: 100, 200, 300, 400, 500 degrees per second. For each speed, run the motor for 1 second, then pause for half a second. Print the current speed to the screen.

> Hint: You can loop over a list of values: `for speed in [100, 200, 300, 400, 500]:`

### Challenge 3 – Absolute Positions

Use `run_target()` to move the motor to these positions in order: **0 → 90 → 180 → 270 → 360 → 0**. Add a 1-second pause between each move. What happens when you go from 360 back to 0?

### Challenge 4 – Button Control (Stretch)

If you haven't already typed in the button-control program from Part 4, do it now. Then modify it: make the **Up button** run the motor faster (720 deg/s) and the **Down button** run it slower (180 deg/s). The right/left buttons should still control direction at the normal speed.

---

## Quick Reference

| Command | What it does |
|---|---|
| `Motor(Port.B)` | Creates a motor object for Port B |
| `motor.run_time(speed, ms)` | Runs for a set time, then stops (blocks) |
| `motor.run_angle(speed, degrees)` | Runs a set distance, then stops (blocks) |
| `motor.run_target(speed, target)` | Rotates to an absolute position (blocks) |
| `motor.run(speed)` | Starts running — does NOT stop on its own |
| `motor.stop()` | Stops the motor |
| `ev3.buttons.pressed()` | Returns list of currently pressed buttons |
| `while True:` / `break` | Loop forever / exit the loop |

---

## Checklist – Before You Move On

- [ ] I can create a Motor object and connect it to a port
- [ ] I understand the difference between `run_time()`, `run_angle()`, `run_target()`, and `run()`
- [ ] I know that negative speed or angle means the opposite direction
- [ ] I used a `for` loop to repeat motor actions
- [ ] I completed at least Challenges 1 and 2
- [ ] I understand why `run()` is used instead of `run_time()` when checking buttons

---

*Next up → **Lesson 03: Driving with Two Motors** — you'll combine two motors into a DriveBase and make the robot drive paths.*
