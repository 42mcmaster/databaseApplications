# Lesson 03 – Guided Walkthrough: Driving with Two Motors
### EV3 MicroPython Robotics

---

## Before You Start

In Lesson 02 you learned how to control a single motor. Now we're combining two motors into a **DriveBase** — a robot that can drive straight and turn. This lesson walks through every single line so you understand what's happening before you start building your own paths.

By the end you will:
- Understand what every line of a DriveBase program does and *why* it's there
- Know how to drive straight, turn, and combine moves into a path
- Use a `for` loop to repeat moves
- Plan and code a short driving program of your own design

**Time:** ~90 minutes
**What you need:** EV3 Brick, 2x Large Motors, driving base build, Mini-USB cable, Computer
**You will not be experimenting blindly.** Read every section before you type anything.

---

## Part 1 – Read the Full Program First

Before touching VS Code, read this program top to bottom. Every single line has a comment explaining it. Your job right now is to **read, not type**.

```python
#!/usr/bin/env pybricks-micropython
# ↑ This line MUST be the first line of every EV3 program you write.
#   It tells the EV3 brick: "this file is a MicroPython program."
#   If you delete it or move it, the program will not run.

# -------------------------------------------------------
# IMPORTS — loading the tools we need
# -------------------------------------------------------

from pybricks.hubs import EV3Brick
# ↑ "from X import Y" means: go to the pybricks library, find the hubs section,
#   and bring in the EV3Brick tool.
#   EV3Brick gives us control of the screen, speaker, and status light.

from pybricks.ev3devices import Motor
# ↑ From the ev3devices section, bring in Motor.
#   We need this because our two wheels are driven by two Motor objects.

from pybricks.parameters import Port
# ↑ From parameters, bring in Port.
#   Port lets us say *which plug* a motor is connected to: Port.B or Port.C.
#   Without this, we can't tell the robot where to look for its motors.

from pybricks.robotics import DriveBase
# ↑ DriveBase is the main tool for this lesson.
#   It takes two motors and combines them into one "robot" object
#   that can drive straight and turn without us doing the math ourselves.

from pybricks.tools import wait
# ↑ wait() pauses the program for a number of milliseconds.
#   1000 ms = 1 second. We use it to add pauses between moves.

# -------------------------------------------------------
# OBJECT CREATION — building the things we'll control
# -------------------------------------------------------

ev3 = EV3Brick()
# ↑ This creates an EV3Brick object and stores it in a variable called ev3.
#   Remember from Lesson 01: an *object* is a variable that represents a real
#   physical thing. ev3.speaker, ev3.screen, ev3.light all work now.

left_motor = Motor(Port.B)
# ↑ This creates a Motor object for the motor plugged into Port B.
#   We store it in a variable called left_motor so the name tells us
#   which side of the robot it controls.
#   Port.B is a constant — it means "the port labeled B on the brick."

right_motor = Motor(Port.C)
# ↑ Same thing, but for Port C, which controls the right wheel.
#   Having separate left_motor and right_motor variables makes the
#   next line easier to understand.

robot = DriveBase(left_motor, right_motor, wheel_diameter=55.5, axle_track=104)
# ↑ This is the most important line in the setup.
#   DriveBase() takes four arguments:
#
#     left_motor    → the motor object for the left wheel
#     right_motor   → the motor object for the right wheel
#     wheel_diameter → the diameter of each wheel in millimeters (55.5 mm)
#     axle_track    → the distance between the two wheels in millimeters (104 mm)
#
#   Why do we need the measurements?
#   When we say robot.straight(500), DriveBase needs to calculate exactly
#   how many times each wheel should rotate to travel 500 mm.
#   It can only do that math if it knows how big the wheels are.
#
#   If your wheel_diameter is wrong, the robot will travel the wrong distance.
#   If your axle_track is wrong, the robot will turn the wrong amount.

# -------------------------------------------------------
# START SIGNAL
# -------------------------------------------------------

ev3.screen.clear()
# ↑ Clears anything left on the screen from a previous run.

ev3.screen.print("Ready!")
# ↑ Displays "Ready!" on the EV3 screen so we know the program started.

ev3.speaker.beep()
# ↑ Plays a short beep. This is a good habit — it confirms the program
#   launched successfully before any movement begins.
```

---

## Checkpoint 1 — Answer Before You Continue

Answer these questions on paper or in your head. If you can't answer them, re-read the section above.

1. What does `from pybricks.robotics import DriveBase` do? Why can't you skip it?
2. Why are there two separate `Motor()` objects instead of just one?
3. What happens to your robot's behavior if you type `wheel_diameter=60` instead of `55.5`?
4. What does `wait(1000)` do? How long does it pause?

---

## Part 2 – Making the Robot Move

Now add movement. Read this section the same way — every line is commented.

```python
# -------------------------------------------------------
# DRIVING STRAIGHT
# -------------------------------------------------------

robot.straight(400)
# ↑ Drives the robot FORWARD 400 millimeters (about 16 inches), then stops.
#   The program WAITS here — the next line does not run until this move is done.
#   This is called a "blocking" command.

wait(500)
# ↑ After the robot stops, pause for 500 ms (half a second) before the next move.
#   This gives the robot a moment to settle so moves don't blur together.

robot.straight(-400)
# ↑ Drives BACKWARD 400 mm. The negative sign reverses the direction.
#   Python rule: negative numbers mean the opposite direction throughout pybricks.

wait(500)

# -------------------------------------------------------
# TURNING
# -------------------------------------------------------

robot.turn(90)
# ↑ Turns the robot RIGHT by 90 degrees in place (a quarter turn).
#   The robot pivots around the center point between its two wheels —
#   one wheel goes forward, the other goes backward.
#   Positive degrees = turn right (clockwise).

wait(500)

robot.turn(-90)
# ↑ Turns the robot LEFT by 90 degrees.
#   Negative degrees = turn left (counterclockwise).
#   After this, the robot is back to its original heading.

wait(500)

robot.turn(360)
# ↑ Spins a full 360-degree rotation in place.
#   After this, the robot faces exactly the same direction it started.
```

**The sign rule — memorize this:**

| Positive value | Negative value |
|---|---|
| `robot.straight(400)` → forward | `robot.straight(-400)` → backward |
| `robot.turn(90)` → right | `robot.turn(-90)` → left |

---

## Checkpoint 2

1. What does `robot.straight(600)` do? How far does it travel?
2. What does `robot.turn(-180)` do?
3. If you wrote `robot.straight(500)` then `robot.turn(90)` then `robot.straight(500)`, what path would the robot trace? Sketch it on paper.
4. What does it mean that `straight()` is a "blocking" command?

---

## Part 3 – Using a Loop to Repeat Moves

A `for` loop lets you repeat a block of code a set number of times. This is extremely useful when a path has a repeating pattern.

Read the square program below. Don't type it yet.

```python
#!/usr/bin/env pybricks-micropython

from pybricks.hubs import EV3Brick
from pybricks.ev3devices import Motor
from pybricks.parameters import Port
from pybricks.robotics import DriveBase
from pybricks.tools import wait

ev3 = EV3Brick()
left_motor  = Motor(Port.B)
right_motor = Motor(Port.C)
robot = DriveBase(left_motor, right_motor, wheel_diameter=55.5, axle_track=104)

ev3.screen.clear()
ev3.screen.print("Square!")
ev3.speaker.beep()

# A square has 4 sides and 4 corners.
# Instead of writing the same two lines 4 times, we use a loop.

for i in range(4):
# ↑ "for i in range(4)" means: repeat the indented block 4 times.
#   i is a variable that counts the loops: 0, 1, 2, 3.
#   range(4) generates the sequence [0, 1, 2, 3] — that's 4 values, 4 loops.
#   We don't use i for anything here — it's just counting for us.

    robot.straight(400)
    # ↑ Drive one side of the square (400 mm).
    #   This line is INDENTED — that means it's inside the loop.
    #   It will run once per loop iteration.

    robot.turn(90)
    # ↑ Turn right 90 degrees to face the next side.
    #   Also inside the loop. After 4 iterations:
    #     - 4 straight moves × 400 mm = 1600 mm total driven
    #     - 4 turns × 90° = 360° total turning = back to start

ev3.speaker.beep(880, 500)
# ↑ NOT indented — this is outside the loop.
#   It runs once, after all 4 iterations are done.

ev3.screen.print("Done!")
# ↑ Also outside the loop. Displays after the square is complete.
```

**The indentation rule:**
Lines indented under `for i in range(4):` are **inside the loop** — they repeat.
Lines at the same level as `for` are **outside the loop** — they run once.

---

## Checkpoint 3

1. How many times does `robot.straight(400)` run in the square program?
2. What is the total distance the robot drives?
3. What is the total degrees turned? Does it end up facing the original direction?
4. If you changed `range(4)` to `range(3)`, what shape would the robot trace?
5. What would happen if you un-indented `robot.turn(90)` so it was outside the loop? Describe the robot's behavior.

---

## Part 4 – Type It and Run It

Now it's your turn. Create a new VS Code project called `guided_drivebase`.

**Type** the square program from Part 3 into `main.py`. Do not copy-paste — typing it forces you to read each line.

Run it with **F5**.

**Observe:**
- Does it drive a clean square and end up where it started?
- Does it face the same direction it started?

If it's slightly off (a little drift, not a perfect square), that's normal — the default `wheel_diameter` and `axle_track` values are estimates. Small errors are expected.

---

## Part 5 – Modify the Program

Now change the code to answer each question below. **Run it each time** before moving to the next one.

### Modification A — Change the size

Change `robot.straight(400)` to `robot.straight(600)`.
What shape does it trace now? How did the loop make this easy — what if you had written it without a loop?

### Modification B — Change the shape

Change the turn angle and loop count to drive an **equilateral triangle** instead of a square.

> Hints: A triangle has 3 sides. The exterior angle of an equilateral triangle is 120°.

### Modification C — Add screen messages

Inside the loop, add a screen print that shows which side number is being driven.

Use this pattern:
```python
ev3.screen.print("Side " + str(i + 1))
```

Why `str(i + 1)` and not just `i`?
- `i` is a number. `ev3.screen.print()` expects a string. `str()` converts a number to a string.
- `i + 1` makes the display show 1, 2, 3, 4 instead of 0, 1, 2, 3 — which reads more naturally.

Run it and confirm the screen shows Side 1 through Side 4 as the robot moves.

### Modification D — Add a sound at the end of each side

Inside the loop, after `robot.turn(90)`, add a beep:
```python
ev3.speaker.beep(440, 200)
```
Run it. You should hear 4 short beeps as the robot completes each corner.

---

## Checkpoint 4

Before moving to the challenge, make sure you can answer all of these:

1. What are the five import lines needed for a DriveBase program, and what does each one provide?
2. What does `wheel_diameter` control in `DriveBase()`?
3. What does a negative value mean in `robot.straight()` and `robot.turn()`?
4. What does `range(4)` produce? How does that connect to how many times the loop runs?
5. Why do we write `str(i + 1)` instead of just `i` when printing to the screen?
6. What's the difference between a line that's indented inside a `for` loop and one that's not?

If any of these trip you up, go back to the section that covers it before continuing.

---

## Part 6 – Your Own Path (The Challenge)

Now you will plan and build a program of your own design. The robot will drive a path that you choose — but you must plan it **on paper first**, before you write a single line of code.

### The Requirements

Your program must include:
- [ ] At least **4 `robot.straight()` calls** (at least one must be backward — negative)
- [ ] At least **3 `robot.turn()` calls** (mix of positive and negative is fine)
- [ ] At least **one `for` loop** (something in the path repeats)
- [ ] At least **3 `ev3.screen.print()` calls** (tell the viewer what's happening)
- [ ] At least **2 beeps** with different frequencies
- [ ] **Comments on every meaningful line** — what is this line doing and why?

### Step 1 – Plan Your Path on Paper

Sketch your path on paper first. Label each segment with a distance in mm and each turn with an angle in degrees. You need to know the exact numbers before you open VS Code.

Use this table to map out your moves in order:

| Step # | Move type | Value | Screen message | Sound? |
|---|---|---|---|---|
| 1 | straight | | | |
| 2 | turn | | | |
| 3 | straight | | | |
| 4 | turn | | | |
| 5 | straight | | | |
| 6 | | | | |
| 7 | | | | |
| 8 | | | | |

**Also answer these before coding:**

Where in your path is the loop? What does it repeat and how many times?

```
Loop description:



```

### Step 2 – Write Pseudocode

Describe your program in plain English, in order. No Python yet — just what happens.

```
Example:
  - Beep to signal start
  - Print "Starting path" on screen
  - Loop 3 times:
      - Drive forward 300 mm
      - Turn right 90 degrees
      - Print "Corner!" on screen
  - Drive backward 200 mm
  - Print "Done!" on screen
  - Beep twice to signal end
```

```
Your pseudocode:




```

### Step 3 – Write the Code

Create a new VS Code project called `my_path`.

Write your program from scratch. Use the square program from Part 3 as your model for the structure — imports, object creation, then your path code.

**Rules:**
- No copy-pasting from Part 3. Type it.
- Comment every meaningful line — what is this line doing?
- Test as you go. Run it after every 3–4 lines you add.

### Step 4 – Reflect

After your program works, answer these:

1. Did the robot travel the path you planned, or did you need to adjust values? What did you change?
2. Where did you put your loop? What does it repeat?
3. What is one thing about how DriveBase works that you understand now that you didn't before this lesson?

---

## Lesson Summary

| Code | What it does |
|---|---|
| `from pybricks.robotics import DriveBase` | Loads the DriveBase tool |
| `left_motor = Motor(Port.B)` | Creates a motor object for Port B |
| `robot = DriveBase(left_motor, right_motor, wheel_diameter=55.5, axle_track=104)` | Creates the robot drivetrain |
| `robot.straight(mm)` | Drives forward (positive) or backward (negative) a set distance |
| `robot.turn(degrees)` | Turns right (positive) or left (negative) in place |
| `for i in range(n):` | Repeats the indented block n times |
| `str(value)` | Converts a number to a string so it can be printed |
| `ev3.screen.print("text")` | Displays text on the EV3 screen |
| `ev3.speaker.beep(freq, ms)` | Plays a beep at a given pitch and duration |
| `wait(ms)` | Pauses the program (1000 ms = 1 second) |

---

## Checklist – Before You Move On

- [ ] I can explain what every import line does
- [ ] I understand why `wheel_diameter` and `axle_track` matter
- [ ] I know the sign rule: positive = forward/right, negative = backward/left
- [ ] I know the difference between code inside a loop and code outside it
- [ ] I drove a square, a triangle, and at least one other shape
- [ ] I completed the planned path challenge with a loop, screen messages, and comments
- [ ] I can answer all Checkpoint questions

---

*Next up → **Lesson 04: Ultrasonic Sensor** — your robot gets its first sensor and starts reacting to the world.*
