# Lesson 06: Database Design Basics
## Introduction to Database Structures

**Database Applications Development**  
Software Engineering | Medina County Career Center

---

## Part 1: What is a Database?

A database is an organized collection of information designed to make data easy to access, manage, and update. Think of it as a filing system for the digital age.

The fundamental goal is simple: we take raw **data** (individual units of information) and store it in **tables**. From there, we can extract **business intelligence** to make informed decisions. For example, a retail company might track customer purchases to identify buying patterns, or a school might analyze attendance data to improve student outcomes.

### Why Not Just Use Excel?

You might wonder why we need databases at all when spreadsheets like Excel exist. The problem with "flat files" (single spreadsheet files) becomes clear when organizations grow. When multiple people need to access and update data, flat files create serious challenges:

- **Consistency issues**: If five people have copies of the same spreadsheet, which version is correct when they all make changes?
- **Security risks**: It's difficult to control who sees what information when entire files are shared via email or cloud storage
- **Update nightmares**: Changing a customer's address means finding every spreadsheet that contains their information
- **Limited scale**: Excel starts to slow down significantly when you have hundreds of thousands of rows

Databases solve these problems by providing a central, controlled location for data with built-in tools for managing access, updates, and queries.

---

## Part 2: Database Architectures

The way a database system is structured directly impacts its security, reliability, and performance. Database architectures are typically described in "tiers" that represent different layers of the system.

### One-Tier Architecture

In a one-tier system, everything exists on a single machine. The database, the application logic, and the user interface all run on the same computer. Microsoft Access running on your home PC is a perfect example. While this is simple to set up, it creates obvious problems. If that one computer crashes, you lose access to everything. There's also no security layer between users and the raw data.

### Three-Tier Architecture

Most professional database systems use a three-tier architecture:

**Tier 1 - The Presentation Layer**: This is what users actually see and interact with—the forms, buttons, and screens of your application. It might be a website, a mobile app, or desktop software.

**Tier 2 - The Application Server**: This middle layer handles all the business logic and acts as a security checkpoint. When a user requests data, this tier validates the request, checks permissions, and determines whether the request should even reach the database. Think of it as a firewall that "vets" every question before allowing it through.

**Tier 3 - The Database**: This is where the actual data lives. It's isolated from direct user access by the application server layer.

The key benefit is **reliability**. If the presentation layer crashes, the database keeps running. If you need to update your website, the data remains untouched. Each tier can be maintained, updated, or scaled independently without affecting the others.

---

## Part 3: Relational Databases

Relational databases organize information into structured tables where relationships between data are explicitly defined. SQL (Structured Query Language) is the standard language for working with relational databases.

### Key Concepts

**Entities**: Each table represents one distinct type of thing. In a business database, you might have separate tables for Customers, Orders, Products, and Employees. Each table focuses on one entity and contains only information relevant to that entity.

**Primary Keys**: Every table needs a unique identifier for each record. This is the primary key. For a Customers table, you'd use a Customer ID number rather than a name (since multiple customers might share the same name). Primary keys must be unique and can never be empty values.

**Foreign Keys**: This is how tables connect to each other. A foreign key is when you take a primary key from one table and include it as a field in another table to create a link. For example, if your Orders table includes a Customer ID field, that's a foreign key that points back to the Customers table. This allows you to see which customer placed each order without storing the customer's entire information in the Orders table.

### Benefits of Relational Design

The relational model provides high **consistency** because data is stored in one place and referenced everywhere else. If a customer's address changes, you update it once in the Customers table, and that change is reflected everywhere the customer is referenced.

Security is also enhanced. You can encrypt specific tables, restrict access to sensitive columns, and control exactly what information each user can view or modify. Try doing that with a spreadsheet!

---

## Part 4: Beyond Relational Databases: NoSQL, Cloud, and Scalability

While relational databases remain the industry standard for many applications, non-relational (NoSQL) databases have emerged to address specific challenges that relational systems struggle with.

### Non-Relational Database Types

Non-relational databases break free from the rigid table structure to offer more flexibility:

**Key-Value Stores**: The simplest NoSQL model. A key-value store saves data as pairs where a unique key directly points to a value, allowing extremely fast lookups when you know the key. <br>
Example: a username can be the key, and the user’s settings or login info is the value, so the app can retrieve it instantly without searching through tables.

**Document Stores**: In a document store, data is organized into collections of documents.
Each document is a self-contained record made up of key–value pairs (often written in JSON format).

Unlike relational databases, document stores do not require a fixed schema. That means not every document has to have the same fields. One document might include extra information, while another might leave some fields out.

This flexibility is useful when data varies from item to item or changes over time, and a rigid table structure would be limiting.

### Cloud Databases (DBaaS)

Database-as-a-Service represents a major shift in how organizations manage data infrastructure. Instead of buying servers and hiring database administrators to maintain them, companies use cloud-hosted databases managed by third-party providers.

The provider handles security patches, backups, software updates, and hardware maintenance. This allows your development team to focus on building applications rather than managing infrastructure. Services like AWS RDS, Google Cloud SQL, and Azure SQL Database are examples of DBaaS platforms.

### Why Scalability Matters

One major advantage of NoSQL databases is horizontal scalability. Traditional relational databases scale "vertically"—you need to buy bigger, more powerful servers to handle more data. NoSQL databases scale "horizontally"—you add more servers to distribute the load. This makes it much easier and cheaper to handle massive amounts of data.

