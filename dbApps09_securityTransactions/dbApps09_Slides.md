---
marp: true
theme: default
class: invert
paginate: true
---

# Security & Transactions
## Keeping data safe and consistent

**Database Applications Development**
Software Engineering | Medina County Career Center

---

## Quick Recap

In the last lessons we learned to **read, write, update, and delete** data.

Today we answer two new questions:

1. **How do we keep bad guys from messing with our database?**
2. **How do we keep our own code from half-messing it up when something fails mid-operation?**

Welcome to **Security** and **Transactions**.

---

## Part 1: SQL Injection

First, the bad guys.

Imagine a simple login page. The user types their name into a box, and your code builds a SQL query around it.

What could possibly go wrong?

*(A lot.)*

---

## A Normal Login — Looks Fine

```python
username = "Arnold"
query = "SELECT * FROM users WHERE name = '" + username + "'"
# Becomes:
# SELECT * FROM users WHERE name = 'Arnold'
```

Totally normal. The query looks up Arnold's user record.

Now watch what happens when the user is sneaky…

---

## SQL Injection — The Attack

```python
username = "' OR '1'='1"
query = "SELECT * FROM users WHERE name = '" + username + "'"
# Becomes:
# SELECT * FROM users WHERE name = '' OR '1'='1'
```

The attacker didn't type a name — they typed **SQL**.

`'1'='1'` is always true, so the query returns **every user** in the table. Login bypassed.

This is **SQL injection**. The attacker "injected" SQL code through a text box.

---

## Why It's Scary

Once someone can inject SQL, they can:

- Read data they shouldn't see (private records, passwords)
- Delete or modify tables
- Bypass login screens entirely
- Dump your whole database to a file

SQL injection has been the cause of some of the biggest data breaches in history. It's still one of the most common attacks on the internet.

---

## The Fix: Parameterized Queries

Instead of gluing user input into a SQL string, use a **placeholder** (`?`) and pass the value separately.

```python
username = "Arnold"
query = "SELECT * FROM users WHERE name = ?"
cursor.execute(query, (username,))
```

The database treats the parameter as **data**, never as SQL code. Even if the user types `' OR '1'='1`, it's just a weird string, not code.

---

## Unsafe vs Safe — Side by Side

❌ **Unsafe** (string concatenation):
```python
query = "SELECT * FROM users WHERE name = '" + username + "'"
cursor.execute(query)
```

✅ **Safe** (parameterized):
```python
query = "SELECT * FROM users WHERE name = ?"
cursor.execute(query, (username,))
```

**Rule:** If you ever find yourself using `+` to glue user input into a SQL string, stop. Use `?` instead.

---

## The Golden Rule

> **"Never trust user input. Always parameterize."**

This is the #1 rule of database security. It's that simple, and that important.

---

## Part 2: Transactions

Now let's talk about the OTHER kind of data disaster — the one where nobody's attacking you, but something still goes wrong halfway through.

---

## The Classic Example: Bank Transfer

You want to move $100 from Arnold's account to Lebron's.

That's actually TWO operations:

```sql
UPDATE accounts SET balance = balance - 100 WHERE name = 'Arnold';
UPDATE accounts SET balance = balance + 100 WHERE name = 'Lebron';
```

What if the first one succeeds… and then the power goes out before the second one runs?

**Arnold lost $100. Lebron never got it. It just vanished.** 😱

---

## What a Transaction Does

A **transaction** is a group of SQL operations that must **all succeed or all fail**. No in-between.

It's an **all-or-nothing deal**.

```sql
BEGIN;
  UPDATE accounts SET balance = balance - 100 WHERE name = 'Arnold';
  UPDATE accounts SET balance = balance + 100 WHERE name = 'Lebron';
COMMIT;
```

If anything fails between `BEGIN` and `COMMIT`, the database undoes **everything**. Nothing is half-done.

---

## The Three Commands

| Command | What it does |
|---------|--------------|
| **BEGIN** | "Start a transaction — I'm about to do multiple things that must stay together." |
| **COMMIT** | "All good. Save everything I just did." |
| **ROLLBACK** | "Something went wrong. Undo everything I just did." |

---

## ROLLBACK — The Undo Button

```sql
BEGIN;
  DELETE FROM students WHERE grade_level = 12;  -- oops, wrong table
ROLLBACK;  -- phew, undo that
```

Between BEGIN and COMMIT, nothing is permanent yet. You can always change your mind.

Once you COMMIT, though, it's done. No more undo.

---

## When Should You Use a Transaction?

Any time your task requires **more than one change** that all have to happen together.

Examples:
- Bank transfer (debit + credit)
- Placing an order (create order + add order lines + reduce stock)
- Enrolling a student (add enrollment + charge tuition + send confirmation)
- Deleting a user (delete user + delete their posts + delete their messages)

If any single step fails, you want ALL of them rolled back.

---

## ACID — Why Transactions Are Trustworthy

Databases promise four properties, nicknamed **ACID**:

| Letter | Meaning | Plain English |
|--------|---------|---------------|
| **A** | Atomicity | All steps happen, or none do. |
| **C** | Consistency | The database always follows its own rules. |
| **I** | Isolation | Transactions don't mess with each other mid-flight. |
| **D** | Durability | Once committed, it survives a crash. |

You don't have to memorize the letters — just understand that transactions are how databases deliver on these promises.

---

## Part 3: Real-World Data Laws

Writing secure code isn't just a technical job — it's a legal one.

Two laws you should recognize by name:

---

## HIPAA — Health Data

**Health Insurance Portability and Accountability Act**

- Protects medical records and health information
- Applies to hospitals, clinics, insurance companies, and their software vendors
- Requires encryption, access control, and audit logs

If you ever build software that touches health data, HIPAA applies. Violations are expensive.

---

## FERPA — Student Data

**Family Educational Rights and Privacy Act**

- Protects student education records (grades, attendance, disciplinary records)
- Applies to schools and anybody working for schools
- Records can't be shared without consent (with specific exceptions)

Yes — it applies to this school. Yes — it applies to any student-facing app you build someday.

---

## Your Responsibility as a Developer

Whether it's HIPAA, FERPA, or your company's own policy:

1. **Know what data you store.** Is any of it sensitive?
2. **Control who can access it.** Not every user needs every column.
3. **Encrypt it** where required.
4. **Log access** so you can tell who looked at what.
5. **Don't leak it** through sloppy code (hi, SQL injection).

Good developers think about security BEFORE something goes wrong.

---

## Best Practices — The Short List

1. **Parameterize every query.** No string concatenation. Ever.
2. **Use transactions** for anything that takes multiple steps.
3. **Least privilege** — give users only the access they need.
4. **Encrypt sensitive data** — especially personal info.
5. **Log database activity** — who did what, when.
6. **Keep software updated** — patches close known holes.

---

## Key Takeaways

- **SQL injection** is real and common. Parameterized queries stop it.
- **Transactions** guarantee that multi-step work is all-or-nothing.
- `BEGIN`, `COMMIT`, `ROLLBACK` are the three commands you need.
- **ACID** is the promise: Atomicity, Consistency, Isolation, Durability.
- **HIPAA** protects health data; **FERPA** protects student data.
- Security is a habit, not a feature. Build it in from day one.

**Next up:** Walkthrough, then tasks, then DIY.
