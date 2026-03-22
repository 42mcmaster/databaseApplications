# Lesson 03 – Answer Key (Teacher Copy)
### EV3 MicroPython Robotics — Guided Walkthrough: Driving with Two Motors

---

> **Teacher Note:** These are reference answers. For conceptual questions, accept any answer that demonstrates the core understanding — students don't need to match the exact wording. The most common wrong answers are noted under each question to help you spot where students are confused.

---

## Checkpoint 1 — Imports and Setup

**1. What does `from pybricks.robotics import DriveBase` do? Why can't you skip it?**

It loads the DriveBase tool from the pybricks library. Without it, Python doesn't know what `DriveBase` is and will crash with a NameError when the robot tries to create the `robot` object.

*Common wrong answer:* "It turns on the robot." — Push back on this. The robot is already on. This line loads a software tool.

---

**2. Why are there two separate `Motor()` objects instead of just one?**

Because there are two physical motors — one on each wheel — each plugged into a different port. Each `Motor()` object connects to a specific port. DriveBase needs both of them separately so it can control each wheel independently.

*Common wrong answer:* "Because the robot has two wheels." — Partially right, but make sure they understand it's about which port each motor is on, not just that there are two.

---

**3. What happens to your robot's behavior if you type `wheel_diameter=60` instead of `55.5`?**

The robot will travel farther than commanded. DriveBase uses the diameter to calculate how many wheel rotations equal a given distance. A larger diameter means it thinks each rotation covers more ground, so it stops early. `robot.straight(1000)` would actually travel more than 1000 mm.

*Common wrong answer:* "Nothing, it's just a setting." — No. Have them try it and measure.

---

**4. What does `wait(1000)` do? How long does it pause?**

It pauses the program for 1000 milliseconds — which is exactly 1 second. The robot does nothing during that time.

---

## Checkpoint 2 — Straight and Turn Commands

**1. What does `robot.straight(600)` do? How far does it travel?**

Drives the robot forward 600 millimeters (about 60 cm, or roughly 2 feet). The program waits until the move is finished before continuing.

---

**2. What does `robot.turn(-180)` do?**

Turns the robot left 180 degrees — a half spin in place, ending up facing the opposite direction.

---

**3. Sketch of `robot.straight(500)` → `robot.turn(90)` → `robot.straight(500)`**

The robot drives forward 500 mm, turns right 90°, then drives forward another 500 mm. The path looks like an L-shape (or the corner of a square).

```
         ←500mm→
         |
    500  |
     mm  |
         └────────
         start
```

*Accept any sketch that shows two perpendicular segments with a right-angle corner.*

---

**4. What does it mean that `straight()` is a "blocking" command?**

It means the program stops and waits at that line until the move is completely finished. The next line of code does not run while the robot is still moving. The command "blocks" the rest of the program until it's done.

*Common wrong answer:* "It blocks the robot from going backward." — Incorrect framing. Blocking is about program flow, not robot direction.

---

## Checkpoint 3 — Loops

**1. How many times does `robot.straight(400)` run in the square program?**

4 times — once per iteration of `for i in range(4)`.

---

**2. What is the total distance the robot drives?**

4 × 400 mm = **1600 mm** (1.6 meters).

---

**3. What is the total degrees turned? Does the robot end up facing the original direction?**

4 × 90° = **360°** total. Yes — 360° is a full rotation, so the robot ends up facing exactly the same direction it started.

---

**4. If you changed `range(4)` to `range(3)`, what shape would the robot trace?**

A triangle — 3 sides, 3 turns. Each turn is still 90°, but 3 × 90° = 270°, not 360°, so if the turn angle stays at 90° the shape won't close perfectly. If they want a proper triangle they'd need `range(3)` and `robot.turn(120)`.

*Accept either answer — "a triangle shape" or the more precise explanation about the angles. Good opportunity for a follow-up discussion.*

---

**5. What would happen if `robot.turn(90)` was outside the loop?**

The loop would run 4 straight moves in a row (all 1600 mm in one direction), and then the single turn would happen once at the end. The robot would drive straight out and then turn — definitely not a square.

---

## Checkpoint 4 — Before the Challenge

**1. Import table**

| Import line | What it provides |
|---|---|
| `from pybricks.hubs import EV3Brick` | Control of the brick's screen, speaker, and status light |
| `from pybricks.ev3devices import Motor` | The Motor class for connecting to physical motors |
| `from pybricks.parameters import Port` | Constants like Port.B and Port.C that identify which port a motor uses |
| `from pybricks.robotics import DriveBase` | The DriveBase class that controls two-wheeled driving |
| `from pybricks.tools import wait` | The `wait()` function for pausing the program |

---

**2. What does `wheel_diameter` control in `DriveBase()`?**

It tells DriveBase how big the wheels are (in mm). DriveBase uses this to calculate how many rotations each wheel needs to travel a requested distance. Wrong value = wrong distance traveled.

---

**3. Negative values:**

`robot.straight(-400)` → drives **backward** 400 mm

`robot.turn(-90)` → turns **left** 90 degrees

---

**4. What does `range(4)` produce?**

It produces the sequence `[0, 1, 2, 3]` — four values. The loop runs once for each value in the sequence, so it runs **4 times**.

*Common wrong answer:* "It produces 1, 2, 3, 4." — Close, but off by one. range(4) starts at 0. This matters when students try to print loop counters.

---

**5. Why `str(i + 1)` instead of just `i`?**

Two reasons: `i` is an integer, and `ev3.screen.print()` needs a string — `str()` handles the conversion. And `i` starts at 0, so `i + 1` makes the display show 1, 2, 3, 4 instead of 0, 1, 2, 3, which reads more naturally to a human watching the screen.

---

**6. Indented vs. not indented:**

Lines **indented** under the `for` statement are inside the loop and run once per iteration. Lines **at the same indentation level as `for`** are outside the loop and run once after all iterations are done. Indentation is how Python decides what's part of the loop — there are no curly braces like in other languages.

---

## Part 6 – Challenge

Student paths will vary. When reviewing, check for:

- [ ] At least one `robot.straight()` with a **negative** value (backward)
- [ ] At least one **loop** (`for i in range(n):`) with something meaningful inside it
- [ ] `str()` used correctly when printing numbers to the screen
- [ ] At least 3 `ev3.screen.print()` calls that describe what's happening
- [ ] Two beeps at different frequencies (`ev3.speaker.beep(freq, ms)`)
- [ ] Comments on every meaningful line — not just "# drive" but "# drive forward to the edge of the table"
- [ ] Planning doc filled out **before** the code was written — ask them to show you the paper sketch

**Reflection Q3** is the most useful one to read. If a student writes something vague like "I understand it better now," ask them to be specific. The goal is that they can articulate at least one concrete thing: what `wheel_diameter` does, how blocking commands work, how the loop eliminates repeated code, etc.
