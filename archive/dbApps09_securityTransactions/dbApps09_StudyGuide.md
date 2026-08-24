# dbApps09 Study Guide: Security & Transactions

**Course:** Database Applications Development (145085)
**Instructor:** Ryan McMaster
**Medina County Career Center**

---

## Vocabulary

### Core Security Terms
1. **SQL Injection** — An attack where malicious SQL code is inserted into a query through user input
2. **Injection Attack** — A broader category of attack where malicious code is inserted into an application
3. **String Concatenation** — Building a query by joining strings together (unsafe method)
4. **Parameterized Query** — A query with placeholders (?) instead of concatenated values (safe method)
5. **Placeholder** — A symbol (like ?) that represents a parameter value in a parameterized query
6. **Sanitize** — To clean or validate user input to remove potentially harmful content
7. **Data Breach** — Unauthorized access to or disclosure of confidential data

### Transaction Terms
8. **Transaction** — A group of SQL operations that succeed or fail together
9. **BEGIN** — SQL keyword that starts a transaction
10. **COMMIT** — SQL keyword that saves all changes in a transaction permanently
11. **ROLLBACK** — SQL keyword that undoes all changes in a transaction

### ACID Properties
12. **ACID** — A set of properties (Atomicity, Consistency, Isolation, Durability) that guarantee reliable database transactions
13. **Atomicity** — All operations in a transaction succeed or all fail (all-or-nothing)
14. **Consistency** — A transaction moves the database from one valid state to another
15. **Isolation** — Transactions don't interfere with each other during execution
16. **Durability** — Once a transaction is committed, changes are permanent

### Privacy & Compliance
17. **HIPAA** — Health Insurance Portability & Accountability Act; protects health information
18. **FERPA** — Family Educational Rights & Privacy Act; protects student education records
19. **Principle of Least Privilege** — Users should have only the minimum access needed to perform their job

---

## SQL Injection Quick Reference

### Vulnerable Code (String Concatenation)
```python
# UNSAFE - DON'T DO THIS
username = input("Enter username: ")
query = "SELECT * FROM users WHERE username = '" + username + "'"
cursor.execute(query)
```

**Attack Example:**
```
User enters: ' OR '1'='1
Query becomes: SELECT * FROM users WHERE username = '' OR '1'='1'
Result: Returns ALL users (authentication bypassed!)
```

### Safe Code (Parameterized Query)
```python
# SAFE - DO THIS
username = input("Enter username: ")
query = "SELECT * FROM users WHERE username = ?"
cursor.execute(query, (username,))
```

**Attack Protection:**
```
User enters: ' OR '1'='1
Treated as: A literal string value (not SQL code)
Result: No rows match literally (' OR '1'='1' is the username), query safe
```

**Key Difference:** Parameterized queries tell the database "this is DATA, not CODE."

---

## Transaction Quick Reference

### Basic Syntax
```sql
BEGIN;
-- SQL statements here
COMMIT;   -- To save
-- OR
ROLLBACK; -- To undo
```

### Bank Transfer Example (All-or-Nothing)
```sql
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 100 WHERE account_id = 2;
COMMIT;  -- Both succeed together
-- If second UPDATE fails, ROLLBACK is automatic in some databases
```

### Why Transactions Matter
Without a transaction, the first UPDATE could succeed and the second fail, leaving money "missing" in the system. Transactions prevent this inconsistency.

---

## ACID Properties Explained

### A — Atomicity
**Definition:** All operations in a transaction succeed or all fail together. No partial updates.

**Real-World Analogy:** A light switch is atomic — it's either ON or OFF, never halfway.

**Example:** A bank transfer (debit + credit) is atomic. You can't have the debit without the credit.

---

### C — Consistency
**Definition:** A transaction moves the database from one valid state to another. Business rules are enforced.

**Real-World Analogy:** A balanced checkbook. Every transaction leaves the accounts in a valid state.

**Example:** If a rule says "every user must have an email," the database won't accept a user without one.

---

### I — Isolation
**Definition:** Transactions don't interfere with each other. Changes from one transaction aren't visible to another until committed.

**Real-World Analogy:** Two people drawing from the same bank account don't see each other's pending transactions until they're finalized.

**Example:** User A reads the balance as $1000. User B deducts $200. User A still sees $1000 until User B commits. Then User A sees $800.

---

### D — Durability
**Definition:** Once a transaction is committed, the changes are permanent, even if the system crashes immediately after.

**Real-World Analogy:** A signed contract is durable — it remains valid even if the building burns down.

**Example:** After COMMIT, data is written to disk and safe. A power failure won't undo it.

---

## Data Protection Awareness

### HIPAA (Health Insurance Portability & Accountability Act)
- **Applies to:** Healthcare providers, health plans, healthcare clearinghouses, and their business associates
- **Protects:** Patient health information and medical records
- **Developer Responsibility:**
  - Encrypt patient data in transit and at rest
  - Limit database access to authorized personnel only
  - Log and audit who accesses patient records
  - Report breaches within required timeframes
- **Violation Penalties:** Fines up to $1.5M per year per violation type

### FERPA (Family Educational Rights & Privacy Act)
- **Applies to:** Schools and educational institutions that receive federal funding
- **Protects:** Student education records (grades, attendance, test scores, personal information)
- **Developer Responsibility:**
  - Restrict access to student records to authorized staff
  - Don't share student data without parental/student consent
  - Allow parents and students to access their own records
  - Log access to sensitive student information
- **Violation Penalties:** Loss of federal funding

### Why Developers Must Care
- You likely work with protected data (healthcare, education, finance)
- A security breach can expose thousands of people's private information
- Legal liability falls on your organization and potentially on you
- Privacy regulations are increasingly strict (GDPR in Europe, CCPA in California, etc.)

---

## Best Practices Checklist

- [ ] Always use parameterized queries (never string concatenation)
- [ ] Use transactions for multi-step operations that must succeed together
- [ ] Apply principle of least privilege (minimal database permissions)
- [ ] Encrypt sensitive data (PII, passwords, medical records)
- [ ] Log database access and audit trails
- [ ] Keep software and databases updated with security patches
- [ ] Validate and sanitize user input
- [ ] Use strong, unique passwords for database accounts
- [ ] Never hardcode passwords in code
- [ ] Test for SQL injection vulnerabilities before deployment

---

## ODE Competencies Covered

This lesson addresses the following Ohio Department of Education competencies:

- **Use appropriate parameterized query techniques** to prevent SQL injection attacks
- **Implement transaction control** using BEGIN, COMMIT, and ROLLBACK
- **Understand ACID properties** and their role in data integrity
- **Demonstrate awareness** of data protection regulations (HIPAA, FERPA)
- **Apply security best practices** in database application development
- **Recognize the impact** of security vulnerabilities on organizations and individuals

---

## Quick Review Questions

1. What is the key difference between string concatenation and parameterized queries?
2. Why is SQL injection dangerous?
3. What does a parameterized query placeholder (?) do?
4. What does ROLLBACK do in a transaction?
5. Which ACID property ensures changes are permanent after COMMIT?
6. What does HIPAA protect?
7. What does FERPA protect?
8. Give an example of a situation where a transaction is necessary.
9. What does the principle of least privilege mean?
10. Why should developers care about HIPAA and FERPA?
