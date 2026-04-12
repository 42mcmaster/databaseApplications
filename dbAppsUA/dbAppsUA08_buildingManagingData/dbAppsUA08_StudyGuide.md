# dbApps08 Навчальний посібник: Будування та управління даними

**Курс:** Розробка застосунків баз даних (145085)
**Викладач:** Ryan McMaster | Мединський центр кар'єри

---

## Словник

| Термін | Визначення |
|--------|-----------|
| **CREATE TABLE** | Команда SQL для визначення нової таблиці зі стовпцями та типами даних |
| **INSERT INTO** | Команда SQL для додавання нового рядка даних до таблиці |
| **VALUES** | Умова в INSERT, яка вказує дані для кожного стовпця |
| **UPDATE** | Команда SQL для зміни існуючих даних в таблиці |
| **SET** | Умова в UPDATE, яка вказує, які стовпці змінювати |
| **DELETE FROM** | Команда SQL для видалення рядків з таблиці |
| **WHERE clause** | Умова, яка вказує, які рядки змінювати в UPDATE, DELETE або SELECT |
| **Data type** | Вказівка того, якого типу дані зберігаються в стовпці |
| **INTEGER** | Тип даних SQLite для цілих чисел |
| **TEXT** | Тип даних SQLite для текстових рядків |
| **REAL** | Тип даних SQLite для чисел з крапкою (десяткові) |
| **BLOB** | Тип даних SQLite для двійкових об'єктів (зображення, файли) |
| **NULL** | Тип даних SQLite для пустих або невідомих значень |
| **Constraint** | Правило, яке забезпечується на рівні бази даних для підтримання цілісності даних |
| **PRIMARY KEY** | Обмеження, яке однозначно ідентифікує кожний рядок |
| **FOREIGN KEY** | Обмеження, яке посилається на PRIMARY KEY в іншій таблиці |
| **Referential integrity** | Правило, що значення FOREIGN KEY повинні існувати в посиланій таблиці |
| **Test-first approach** | Найкращої практика: перевіріть вашу WHERE умову SELECT перед запуском UPDATE/DELETE |

---

## Типи даних SQLite — довідка

| Тип | Призначення | Приклади |
|------|-----------|----------|
| **INTEGER** | Цілі числа | 42, -100, 2024 |
| **TEXT** | Текстові рядки | 'Alice', 'New York', 'alice@example.com' |
| **REAL** | Числа з крапкою | 3.14, 99.99, 0.5 |
| **BLOB** | Двійкові дані | Файли зображень, PDF файли, зашифровані дані |
| **NULL** | Пусто/невідомо | Не надано, невідоме значення |

**Примітка:** SQLite гнучкий і намагатиметься конвертувати типи, але найкращою практикою є відповідність вашим даним правильному типу.

---

## Довідка синтаксису SQL

### CREATE TABLE
```sql
CREATE TABLE table_name (
  column_name  DATA_TYPE  [constraints],
  column_name  DATA_TYPE  [constraints]
);
```

**Приклад:**
```sql
CREATE TABLE students (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  gpa REAL,
  enrollment_date TEXT DEFAULT CURRENT_DATE
);
```

### INSERT INTO
```sql
INSERT INTO table_name (column1, column2, column3)
VALUES (value1, value2, value3);
```

**Приклади:**
```sql
INSERT INTO students (id, name, gpa)
VALUES (1, 'Alice Smith', 3.85);

INSERT INTO students (id, name)
VALUES (2, 'Bob Johnson');  -- gpa буде NULL
```

### UPDATE
```sql
UPDATE table_name
SET column1 = value1, column2 = value2
WHERE condition;
```

**Приклад:**
```sql
UPDATE students
SET gpa = 3.90
WHERE name = 'Alice Smith';
```

**НЕБЕЗПЕКА — пропущена WHERE (впливає НА ВСІ рядки):**
```sql
-- НЕПРАВИЛЬНО: оновлює GPA кожного студента!
UPDATE students SET gpa = 4.0;
```

### DELETE
```sql
DELETE FROM table_name
WHERE condition;
```

**Приклад:**
```sql
DELETE FROM students
WHERE id = 5;
```

**НЕБЕЗПЕКА — пропущена WHERE (видаляє ВСІ рядки):**
```sql
-- НЕПРАВИЛЬНО: видаляє всіх студентів!
DELETE FROM students;
```

---

## Довідка обмежень

### NOT NULL та UNIQUE

**NOT NULL — мета:** Забезпечує, що стовпець завжди має значення

```sql
CREATE TABLE employees (
  id INTEGER NOT NULL,
  name TEXT NOT NULL,
  email TEXT
);
```

**Що це запобігає:** Додавання рядка без імені або id

---

**UNIQUE — мета:** Запобігає дублюванню значень в стовпці

```sql
CREATE TABLE users (
  id INTEGER,
  email TEXT UNIQUE
);
```

**Що це запобігає:** Двом користувачам мати одну адресу e-mail

---

### DEFAULT та CHECK

**DEFAULT — мета:** Автоматично заповнює значення, якщо воно не задане

```sql
CREATE TABLE posts (
  id INTEGER,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP,
  status TEXT DEFAULT 'draft'
);
```

**Приклад:**
```sql
INSERT INTO posts (id) VALUES (1);
-- created_at автоматично встановлюється на поточний час
-- status автоматично встановлюється на 'draft'
```

---

**CHECK — мета:** Перевіряє, що значення відповідають умові

```sql
CREATE TABLE products (
  id INTEGER,
  name TEXT,
  price REAL CHECK (price > 0)
);
```

**Що це запобігає:** Додаванню продукту з ціною = 0 або від'ємною ціною

**Інші приклади CHECK:**
```sql
CREATE TABLE employees (
  age INTEGER CHECK (age >= 18),
  salary REAL CHECK (salary > 0)
);
```

---

### PRIMARY KEY
**Мета:** Однозначно ідентифікує кожний рядок (NOT NULL + UNIQUE разом)

```sql
CREATE TABLE courses (
  course_id INTEGER PRIMARY KEY,
  title TEXT NOT NULL
);
```

**Що це запобігає:** Двом курсам мати один і той ж course_id, або NULL course_id

---

### FOREIGN KEY
**Мета:** Посилається на PRIMARY KEY в іншій таблиці (референціальна цілісність)

```sql
CREATE TABLE students (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE enrollments (
  id INTEGER PRIMARY KEY,
  student_id INTEGER REFERENCES students(id),
  course_id INTEGER REFERENCES courses(course_id)
);
```

**Що це запобігає:** Створенню запису про реєстрацію для неіснуючого student_id

---

## Правила безпеки: підхід тестування спочатку

### Для операцій UPDATE

**Крок 1: напишіть вашу WHERE умову**
```sql
WHERE gpa < 2.0
```

**Крок 2: перевірте її спочатку за допомогою SELECT**
```sql
SELECT * FROM students WHERE gpa < 2.0;
```

Подивіться на результати. Це рядки, які ви хочете змінити? Якщо так, продовжуйте.

**Крок 3: скопіюйте WHERE в UPDATE**
```sql
UPDATE students
SET status = 'probation'
WHERE gpa < 2.0;
```

---

### Для операцій DELETE

**Крок 1: напишіть вашу WHERE умову**
```sql
WHERE enrollment_year < 2020
```

**Крок 2: перевірте її спочатку за допомогою SELECT**
```sql
SELECT * FROM students WHERE enrollment_year < 2020;
```

Подивіться на результати. Це рядки, які ви хочете видалити? Якщо так, продовжуйте.

**Крок 3: запустіть DELETE з такою ж WHERE**
```sql
DELETE FROM students
WHERE enrollment_year < 2020;
```

---

## Чому обмеження важливі

### Проблема: Погані дані на вході, погані дані на виході (GIGO)

Без обмежень:
- Будь-хто може додати неповні дані (пусті імена, дати тощо)
- Можуть бути створені дублікати записів
- Невалідні значення можуть зберігатися (від'ємні ціни, неможливі вікові дані)
- Можуть існувати сирітські записи (реєстрація студентів, які не існують)

### Рішення: обмеження встановлюють правила на рівні бази даних
- NOT NULL: Запобігає неповним записам
- UNIQUE: Запобігає дублюванню
- CHECK: Запобігає невалідним значенням
- FOREIGN KEY: Запобігає сирітським записам
- DEFAULT: Забезпечує розумні значення за замовчуванням

**Результат:** Надійні, послідовні, надійні дані.

---

## Наступні кроки

- **Підурок 08d:** Завдання DIY + Gimkit (перевірте ваші знання)
- Практикуйте створення таблиць з різними обмеженнями
- Практикуйте підхід тестування спочатку з UPDATE та DELETE
- Розвивайте впевненість перед переходом до більш складних запитів
