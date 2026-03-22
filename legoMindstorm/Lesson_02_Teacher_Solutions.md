# Lesson 02 – Teacher Solutions
### EV3 MicroPython Robotics — Motors & Motion

---

> **Teacher Note:** Accept any working solution that demonstrates the core concept. The exact code structure may vary — what matters is that the motor behaves correctly and the student can explain why.

---

## Challenge 1 – Back and Forth

**Goal:** Forward 720°, pause, backward 720°. Repeat 4 times with lap number displayed.

```python
#!/usr/bin/env pybricks-micropython

from pybricks.hubs import EV3Brick
from pybricks.ev3devices import Motor
from pybricks.parameters import Port
from pybricks.tools import wait

ev3 = EV3Brick()
motor = Motor(Port.B)
ev3.speaker.beep()

for i in range(4):
    ev3.screen.print("Rep " + str(i + 1))
    motor.run_angle(360, 720)
    wait(1000)
    motor.run_angle(360, -720)
    wait(1000)

ev3.screen.print("Done!")
```

**What to look for:**
- `run_angle()` with negative value for backward
- `for` loop with `range(4)`
- `str(i + 1)` for display

**Common mistake:** Using `run_time()` instead of `run_angle()` — works but doesn't guarantee exactly 720°.

---

## Challenge 2 – Speed Ramp

**Goal:** Run at increasing speeds, 1 second each, with screen output.

```python
#!/usr/bin/env pybricks-micropython

from pybricks.hubs import EV3Brick
from pybricks.ev3devices import Motor
from pybricks.parameters import Port
from pybricks.tools import wait

ev3 = EV3Brick()
motor = Motor(Port.B)
ev3.speaker.beep()

for speed in [100, 200, 300, 400, 500]:
    ev3.screen.print("Speed: " + str(speed))
    motor.run_time(speed, 1000)
    wait(500)

ev3.screen.print("Done!")
```

**What to look for:**
- Looping over a list of values (not `range()`)
- `run_time()` is the right call here — we want each speed for a fixed time
- `str()` used to print the speed value

**Common mistake:** Using `run_angle()` — not wrong, but `run_time()` is more natural for "run for 1 second."

---

## Challenge 3 – Absolute Positions

**Goal:** Move to positions 0 → 90 → 180 → 270 → 360 → 0.

```python
#!/usr/bin/env pybricks-micropython

from pybricks.hubs import EV3Brick
from pybricks.ev3devices import Motor
from pybricks.parameters import Port
from pybricks.tools import wait

ev3 = EV3Brick()
motor = Motor(Port.B)
ev3.speaker.beep()

for target in [0, 90, 180, 270, 360, 0]:
    ev3.screen.print("Pos: " + str(target))
    motor.run_target(360, target)
    wait(1000)

ev3.screen.print("Done!")
```

**What to look for:**
- Understanding that `run_target(360, 0)` after `run_target(360, 360)` causes the motor to spin backward one full turn to return to position 0
- Understanding that `run_target()` goes to a **position**, not a relative distance

**Good discussion question:** What happens if you call `run_target(360, 90)` twice in a row? (Nothing the second time — it's already there.)

---

## Challenge 4 – Button Control (Stretch)

**Goal:** Right/Left for direction, Up for fast, Down for slow, Center to quit.

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
ev3.screen.print("Up = Fast")
ev3.screen.print("Down = Slow")
ev3.screen.print("Center = Quit")
ev3.speaker.beep()

while True:
    pressed = ev3.buttons.pressed()

    if Button.CENTER in pressed:
        break

    elif Button.UP in pressed:
        motor.run(720)

    elif Button.DOWN in pressed:
        motor.run(180)

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

**What to look for:**
- `while True:` loop with `break` on center button
- `ev3.buttons.pressed()` called each iteration inside the loop
- `motor.run()` used (not `run_time` or `run_angle` — those block)
- `motor.stop()` in the `else` branch
- `wait(10)` at the bottom of the loop

**Common mistakes:**
- Using `run_time()` inside the loop — blocks and prevents button checking
- Forgetting `motor.stop()` in the `else` — motor keeps spinning after button release

---

## General Grading Notes

| Challenge | Core concept being assessed |
|---|---|
| 1 | `run_angle()` with negative values, `for` loop |
| 2 | Looping over a list, `run_time()`, string conversion |
| 3 | Understanding absolute vs. relative movement (`run_target()`) |
| 4 | Event-driven logic, `while` loop, button input, `run()` vs blocking commands |
