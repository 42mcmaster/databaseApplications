# Unit 3 Makeup — Database Design Basics

Read each part, then answer the [Unit 3 Makeup Google Form](https://docs.google.com/forms/d/e/1FAIpQLSeurHa5VANt8bSZ-ljRs_CM9eoruAmzaWQngVnTryIVjUQ-6Q/viewform). Every answer is on this page. You can keep this page open while you take the form.


## Contents

- [Part 1: Redundancy and anomalies](#part-1-redundancy-and-anomalies)
- [Part 2: Keys](#part-2-keys)
- [Part 3: Relationships](#part-3-relationships)
- [Part 4: Normalization](#part-4-normalization)
- [Part 5: Types of databases](#part-5-types-of-databases)

---

## Part 1: Redundancy and anomalies

**Redundancy** means the same fact is stored in many places. Here is a school schedule kept in one table:

| student | course | teacher | room |
|---|---|---|---|
| Ava | Web Design | Mr. Grant | 214 |
| Liam | Web Design | Mr. Grant | 214 |
| Noah | Web Design | Mr. Grant | 214 |
| Emma | Art I | Mr. Kerr | 301 |

"Mr. Grant is in Room 214" is stored three times. That repeating causes three problems, called **anomalies**:

- **Update anomaly:** Mr. Grant moves to Room 220. Three rows must change. If one is missed, the table disagrees with itself.
- **Insert anomaly:** A new teacher is hired but has no students yet. There is no way to add her without a student row.
- **Delete anomaly:** Emma drops Art I. Deleting her row also erases the only record that Mr. Kerr teaches in Room 301.

The fix is to move each fact into its own table, so it is stored only once. That process is called **normalization**.

---

## Part 2: Keys

A **primary key** is the column that uniquely identifies each row. No two rows can have the same primary key.

| Kind of key | What it means | Example |
|---|---|---|
| Natural key | A real-world value that already exists | A state abbreviation: OH, MI, PA |
| Surrogate key | A made-up ID number | `student_id` = 10452 |
| Composite key | A primary key made of two or more columns | `student_id` + `club_id` together |
| Foreign key | A column that points to the primary key of another table | `games.team_id` points to `teams.team_id` |

**Referential integrity** is the rule that a foreign key must point to a row that really exists. If someone tries to add a game for team 99 and there is no team 99, the database rejects it.

---

## Part 3: Relationships

Tables connect to each other in three ways:

| Relationship | Meaning | Example |
|---|---|---|
| One-to-one | Each item matches exactly one other item | A person and their Social Security number |
| One-to-many | One item matches many others | One customer has many orders |
| Many-to-many | Many items match many others | Students take many courses; courses have many students |

A relational database cannot store many-to-many directly. You add a **junction table** in the middle. For students and courses, an `Enrollments` table holds `student_id` and `course_id`. Each row means "this student is in this course."

---

## Part 4: Normalization

Normalization is done in steps called **normal forms**. The golden rule: every column depends on **the key, the whole key, and nothing but the key**.

### First normal form (1NF): one value per cell

| student | clubs |
|---|---|
| Ava | Chess, Robotics |

The `clubs` cell holds two values. That breaks 1NF. The fix is one row per club: Ava / Chess and Ava / Robotics.

### Second normal form (2NF): the whole key

A `Memberships` table has the composite key `student_id` + `club_id`. It also has `club_advisor`. The advisor depends only on the club, not on the student. A column that depends on only *part* of a composite key is a **partial dependency**. The fix is to move `club_advisor` into a `Clubs` table.

### Third normal form (3NF): nothing but the key

A `Students` table has `student_id`, `grade_level`, and `lunch_period`. Lunch period is set by grade level, not by the student. A column that depends on another non-key column is a **transitive dependency**. The fix is to move `lunch_period` into a `GradeLevels` table.

### Denormalization

**Denormalization** means putting repeated data back on purpose, usually to make reading faster because fewer joins are needed.

---

## Part 5: Types of databases

Relational databases (tables, keys, joins) are only one type. Pick the type that fits the job.

| Type | How it stores data | Good for | Example product |
|---|---|---|---|
| Relational | Tables with rows, columns, and keys | Data that must stay accurate and linked: banks, pharmacies, school grades | PostgreSQL, MySQL |
| Document | Flexible records (like JSON); each record can have different fields | Product catalogs where every category has different details | MongoDB |
| Key-value | A key and its value, kept in memory | Very fast changes: game leaderboards, caching | Redis |
| Graph | Nodes (things) and edges (connections) | Connections between things: "friends of your friends" | Neo4j |
| Full-text search | An index of every word | Searching a large amount of text by any word | Elasticsearch |
| Wide-column | Huge tables spread across many servers | Massive streams of incoming data, like sensor readings | Cassandra |
