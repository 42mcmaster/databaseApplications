# Unit 5 Exam Prep — Video Guide

Watch each video, then answer its questions in the Google Form. Use the key terms below as you watch. You can have this page open while you take the form.

## Contents

- [How to use this guide](#how-to-use-this-guide)
- [Video 1 — SQL Injection](#video-1--sql-injection)
- [Video 2 — Cross-site Scripting (XSS)](#video-2--cross-site-scripting-xss)

---

## How to use this guide

1. Read the **key terms** for the video first.
2. Watch the video. Listen for those terms.
3. Read **Connect it to your database** to see how it links to what you've built.
4. Answer that video's questions in the Google Form.

---

## Video 1 — SQL Injection

**Watch:** [SQL Injection — Professor Messer](https://www.youtube.com/watch?v=qFUOLkEk8AQ)

**Form questions:** 1–8

### Key terms

| Term | What it means |
|---|---|
| **SQL injection** | An attacker types their own SQL into an input box, like a login or search field, and the app runs it as part of its query. |
| **Input validation** | The app checks what a user typed before using it. Missing or weak input validation is what makes SQL injection possible. |
| **Authentication** | Proving who you are, usually with a username and password. SQL injection can get around it. |
| **`' OR '1'='1`** | The classic injection. It makes the `WHERE` clause true for every row, so the database returns everything. |
| **`--`** | Starts a comment in SQL. Attackers add it to the end of an injection so the rest of the real query is ignored. |
| **WebGoat** | A practice app built on purpose to have security holes, so people can learn attacks safely. |
| **Other injection types** | HTML, XML, and LDAP can be injected the same way SQL can. |

### What happens in the video

The app has this query, with the user's typed name dropped into the blank:

```sql
SELECT * FROM users WHERE name = '________';
```

A normal user types `professor`:

```sql
SELECT * FROM users WHERE name = 'professor';
-- returns one row: professor's
```

An attacker types `' OR '1'='1` instead:

```sql
SELECT * FROM users WHERE name = '' OR '1'='1';
-- '1'='1' is always true, so this returns EVERY row
```

In the WebGoat demo, one injected line showed every employee's name, department, salary, and login info.

### Connect it to your database

- In Unit 2 you used `OR` in a `WHERE` clause. Here, an attacker sneaks an `OR` into **your** `WHERE` clause.
- In Unit 4b, an `UPDATE` with no `WHERE` changed every row. A SQL injection does the same thing on purpose: it makes the `WHERE` match every row.
- If the attacker can read every row, they can often change or delete every row too.

---

## Video 2 — Cross-site Scripting (XSS)

**Watch:** [Cross-site Scripting — Professor Messer](https://www.youtube.com/watch?v=PKgw0CLZIhE)

**Form questions:** 9–16

### Key terms

| Term | What it means |
|---|---|
| **Cross-site scripting (XSS)** | An attacker gets a malicious script to run in a victim's browser while they use a site they trust. It's called XSS because CSS was already taken by Cascading Style Sheets. |
| **JavaScript** | The scripting language most XSS attacks use. Almost every browser has it turned on. |
| **Session ID / cookie** | The site's proof that you're logged in. If an attacker steals it, they get the same access you have. |
| **Non-persistent (reflected) XSS** | The attacker sends the victim a link with a script in it, by email or text. The victim clicks it, and the script runs once. |
| **Persistent (stored) XSS** | The attacker posts the script on a site, like social media. It's stored there and runs for **everyone** who views that page. |
| **Token** | A login pass a site gives you. Tokens should expire. |
| **Patch** | An update from the maker that fixes a security hole. |

### What happens in the video

- **Shopping cart demo:** the credit card field didn't check for scripts. A short JavaScript pasted into that field showed the user's session ID. A real attacker would send it to themselves secretly instead.
- **Subaru (2017):** a researcher found that Subaru's website login token **never expired** and let you control a car. The site also had an XSS hole, so an attacker could steal a token with a link and use it forever. Subaru fixed it after the researcher reported it.

### How to protect against it

| Who | What to do |
|---|---|
| Users | Don't click links you don't trust. Type the site's address yourself. |
| Users | Keep your browser and apps updated (patched). |
| Users | Disabling or limiting JavaScript helps a little, but breaks some sites. |
| Developers | **Check every input** so users can't add their own script. |

### Connect it to your database

- SQL injection and XSS have the **same fix on the developer side: input validation.** Never trust what a user types.
- In Unit 4, your `CHECK` rules were a kind of input validation inside the database. They refused bad data before it was saved.
