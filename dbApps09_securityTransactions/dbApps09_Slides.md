---
marp: true
theme: default
class: invert
paginate: true
---

# Security & Transactions

Database Applications Development (145085)
Medina County Career Center

---
<!-- _header: "Sub-Lesson 09a — SQL Injection" -->

## What is SQL Injection?

A technique where an attacker inserts malicious SQL code into a query.

**Vulnerable Code Example:**
```python
userInput = "Robert"
query = "SELECT * FROM users WHERE name = '" + userInput + "'"
# Result: SELECT * FROM users WHERE name = 'Robert'
```

**Attack Example:**
```python
userInput = "' OR '1'='1"
query = "SELECT * FROM users WHERE name = '" + userInput + "'"
# Result: SELECT * FROM users WHERE name = '' OR '1'='1'
# This returns ALL rows!
```

---

## The Damage from SQL Injection

- Unauthorized data access (reading private records)
- Data deletion or corruption
- Bypassing authentication (login without password)
- Modifying database structure
- Data exfiltration and breaches

**Bottom Line:** SQL injection is a critical vulnerability. Prevention is essential.

---

## The Fix: Parameterized Queries

Use **placeholders** instead of string concatenation.

**Unsafe (String Concatenation):**
```python
userInput = "Robert"
query = "SELECT * FROM users WHERE name = '" + userInput + "'"
cursor.execute(query)
```

**Safe (Parameterized Query):**
```python
userInput = "Robert"
query = "SELECT * FROM users WHERE name = ?"
cursor.execute(query, (userInput,))
# Even if userInput = "' OR '1'='1", it's treated as a literal string
```

The database treats the parameter as **data**, not SQL code.

---
<!-- _header: "Sub-Lesson 09b — Transactions" -->

## What is a Transaction?

A **transaction** is a group of SQL operations that must all succeed or all fail together.

Think of it as an all-or-nothing deal.

**Real-World Example: Bank Transfer**
- Debit $100 from Account A
- Credit $100 to Account B

If the debit succeeds but the credit fails, money disappears. Use a transaction to prevent this.

**In SQL:**
```sql
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT;
```

---

## BEGIN, COMMIT, ROLLBACK

**BEGIN** — Start a transaction. All subsequent operations are grouped.

**COMMIT** — Save all changes. The transaction succeeds.

**ROLLBACK** — Undo all changes. The transaction fails.

**Example:**
```sql
BEGIN;
DELETE FROM logs WHERE timestamp < '2023-01-01';
COMMIT;  -- Changes are permanent

-- OR

BEGIN;
INSERT INTO audit (action) VALUES ('admin login');
ROLLBACK;  -- Changes are undone, nothing is inserted
```

---

## ACID Properties

**A — Atomicity:** All operations succeed or all fail. No partial updates.

**C — Consistency:** The database moves from one valid state to another. Rules are enforced.

**I — Isolation:** Transactions don't interfere with each other. One transaction's changes don't affect another until committed.

**D — Durability:** Once committed, data is permanent, even if the system crashes.

---

## Data Protection Laws

**HIPAA (Health Insurance Portability & Accountability Act)**
- Protects health information
- Applies to healthcare organizations and their vendors
- Your responsibility: encrypt data, control access, audit activity

**FERPA (Family Educational Rights & Privacy Act)**
- Protects student education records
- Applies to schools and educational institutions
- Your responsibility: restrict access, don't share without consent

**As a developer:** Know what data your database holds and who can access it.

---

## Best Practices Summary

1. **Always use parameterized queries** — no string concatenation in SQL
2. **Use transactions for multi-step operations** — ensures consistency
3. **Apply principle of least privilege** — users get only the access they need
4. **Encrypt sensitive data** — especially PII (personally identifiable information)
5. **Log and audit database activity** — track who accessed what and when
6. **Keep software updated** — patches close security holes

---

## Key Takeaways

- SQL injection is a serious threat — use parameterized queries
- Transactions guarantee consistency in multi-step operations
- BEGIN, COMMIT, ROLLBACK control transaction flow
- ACID ensures data integrity and reliability
- HIPAA and FERPA are real-world privacy regulations
- Security is a shared responsibility — developers must build safely
