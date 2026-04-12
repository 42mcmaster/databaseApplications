# Поясна записка: Проект Капстоун

## SQL Швидка довідка

### SELECT — читання даних

```sql
-- Все від усіх
SELECT * FROM users;

-- Конкретні колонки
SELECT id, name, email FROM users;

-- З умовою
SELECT * FROM users WHERE age > 18;

-- З сортуванням
SELECT * FROM users ORDER BY age DESC;

-- З обмеженням
SELECT * FROM products LIMIT 5;
```

### Агреговані функції

```sql
-- Підрахунок рядків
SELECT COUNT(*) FROM users;

-- Підрахунок окремих значень
SELECT COUNT(DISTINCT city) FROM users;

-- Сума
SELECT SUM(salary) FROM employees;

-- Середнє
SELECT AVG(price) FROM products;

-- Максимум і мінімум
SELECT MAX(salary), MIN(salary) FROM employees;
```

### GROUP BY — групування результатів

```sql
-- Кількість користувачів за містом
SELECT city, COUNT(*) as count FROM users GROUP BY city;

-- Середня ціна товарів за категорією
SELECT category, AVG(price) as avg_price FROM products GROUP BY category;

-- З фільтром групи
SELECT department, AVG(salary) FROM employees GROUP BY department HAVING AVG(salary) > 50000;
```

### JOIN — з'єднання таблиць

```sql
-- INNER JOIN (тільки збіги)
SELECT users.name, orders.total
FROM users
INNER JOIN orders ON users.id = orders.user_id;

-- LEFT JOIN (усе з лівої таблиці + збіги)
SELECT users.name, COUNT(orders.id) as order_count
FROM users
LEFT JOIN orders ON users.id = orders.user_id
GROUP BY users.id;

-- Три таблиці
SELECT books.title, authors.name, genres.name
FROM books
JOIN authors ON books.author_id = authors.id
JOIN genres ON books.genre_id = genres.id;
```

### INSERT — вставка даних

```sql
-- Один рядок
INSERT INTO users (name, email, age)
VALUES ('Іван', 'ivan@example.com', 25);

-- Кілька рядків
INSERT INTO users VALUES
  (1, 'Марія', 'maria@example.com', 30),
  (2, 'Петро', 'petro@example.com', 28);

-- З запиту
INSERT INTO archive_users SELECT * FROM users WHERE inactive = 1;
```

### UPDATE — оновлення даних

```sql
-- Змінити окремий рядок
UPDATE users SET age = 26 WHERE id = 1;

-- Змінити кілька колонок
UPDATE users SET age = 31, status = 'active' WHERE id = 2;

-- З умовою
UPDATE products SET price = price * 1.1 WHERE category = 'electronics';
```

### DELETE — видалення даних

```sql
-- Видалити конкретний рядок
DELETE FROM users WHERE id = 1;

-- Видалити за умовою
DELETE FROM orders WHERE created_at < '2024-01-01';

-- УВАГА: Видалити ВСЕ (без WHERE)
DELETE FROM users;  -- Видалить усіх користувачів!
```

### CREATE TABLE — створення таблиці

```sql
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT UNIQUE,
  age INTEGER,
  created_at DATE DEFAULT CURRENT_DATE
);

CREATE TABLE orders (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  total REAL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

### Транзакції

```sql
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT;

-- Або скасувати:
BEGIN;
DELETE FROM sensitive_data WHERE user_id = 123;
ROLLBACK;  -- Скасувати видалення
```

### Параметризовані запити (в Python)

```python
# Небезпечно
query = "SELECT * FROM users WHERE id = " + str(user_id)

# Безпечно
query = "SELECT * FROM users WHERE id = ?"
cursor.execute(query, (user_id,))
```

---

## Python-SQLite Швидка довідка

### Основне налаштування

```python
import sqlite3

# Підключитись до БД (створить, якщо не існує)
conn = sqlite3.connect('database.db')
cursor = conn.cursor()

# Виконати запит
cursor.execute("SELECT * FROM users")

# Отримати результати
rows = cursor.fetchall()  # Усі рядки
row = cursor.fetchone()   # Один рядок
```

### Вставка та фіксація

```python
# Вставити дані
cursor.execute(
    "INSERT INTO users (name, email) VALUES (?, ?)",
    ('Іван', 'ivan@example.com')
)

# Зберегти (COMMIT)
conn.commit()

# Скасувати (ROLLBACK)
conn.rollback()
```

### Завантаження результатів

```python
cursor.execute("SELECT * FROM users")

# Усі рядки як список кортежів
all_rows = cursor.fetchall()
for row in all_rows:
    print(row)

# Один рядок
single_row = cursor.fetchone()

# Обхід з курсором
for row in cursor.execute("SELECT * FROM products"):
    print(row[0], row[1])  # Перша і друга колонка
```

### Закриття БД

```python
cursor.close()
conn.close()
```

---

## Нотація ER-діаграми

### Сутності та зв'язки

```
┌──────────────┐
│    Users     │
├──────────────┤
│ id (PK)      │
│ name         │
│ email        │
└──────────────┘
       │
       │ 1:N (один до багатьох)
       │
┌──────────────┐
│    Orders    │
├──────────────┤
│ id (PK)      │
│ user_id (FK) │─────→ Users.id
│ total        │
└──────────────┘
```

**Умовні позначення:**
- `(PK)` — Primary Key (первинний ключ)
- `(FK)` — Foreign Key (зовнішній ключ)
- `1:N` — один до багатьох
- `N:N` — багато до багатьох

---

## Поширені помилки

1. ❌ **Забути PRIMARY KEY**
   - Результат: дублікати, немає зв'язків
   - ✓ Додайте `id INTEGER PRIMARY KEY`

2. ❌ **Конкатенація в запитах**
   - Результат: SQL-ін'єкція, небезпечність
   - ✓ Використовуйте параметризовані запити (?)

3. ❌ **Забути FOREIGN KEY**
   - Результат: дані можуть бути несумісні
   - ✓ Додайте `FOREIGN KEY (...) REFERENCES ...`

4. ❌ **Забути COMMIT**
   - Результат: дані не збережуться
   - ✓ Завжди викличте `conn.commit()`

5. ❌ **DELETE без WHERE**
   - Результат: видалення УСІХ рядків
   - ✓ Завжди вказуйте умову або будьте дуже обережні

6. ❌ **Неправильне імя колонки в JOIN**
   - Результат: помилка або неправильні результати
   - ✓ Завжди перевіряйте імена таблиць і колонок

---

## Контрольний список проекту

### Фаза 1: Дизайн
- [ ] Вибрана тема
- [ ] Визначені 2+ сутності
- [ ] Визначені атрибути для кожної сутності
- [ ] Позначені зв'язки (1:N або N:N)
- [ ] Намальована ER-діаграма
- [ ] Написані CREATE TABLE команди

### Фаза 2: Побудова
- [ ] БД створена
- [ ] Таблиці створені
- [ ] Вставлено 15+ рядків даних
- [ ] Перевірено, що дані виглядають правильно

### Фаза 3: Запити
- [ ] Написано 8+ запитів
- [ ] Запити включають SELECT, WHERE, GROUP BY, JOIN
- [ ] Запити тестовані і дають результати

### Фаза 4: Полірування
- [ ] Написаний словник даних (таблиця колонок)
- [ ] Використовуються параметризовані запити
- [ ] Додані транзакції (де потрібні)
- [ ] Підготовлено представлення (4-5 слайдів або 10 хвилин)

---

## Питання для повторення

1. **Яка різниця між INNER JOIN та LEFT JOIN?**
   INNER JOIN повертає лише рядки, які мають збіги в обох таблицях. LEFT JOIN повертає все з лівої таблиці та збіги з правої (NULL якщо нема збігу).

2. **Коли використовується GROUP BY?**
   GROUP BY групує рядки за значенням однієї або кількох колонок, щоб підрахувати або агрегувати дані (COUNT, SUM, AVG).

3. **Що таке PRIMARY KEY і FOREIGN KEY?**
   PRIMARY KEY однозначно ідентифікує рядок. FOREIGN KEY посилається на PRIMARY KEY іншої таблиці для створення зв'язків.

4. **Як забезпечити безпеку запитів в Python?**
   Використовуйте параметризовані запити з `?` замість конкатенації строк.

5. **Коли потрібна транзакція (BEGIN/COMMIT)?**
   Коли кілька операцій мають виконуватись разом і всі повинні успішні (або скасовані разом).

6. **Що таке словник даних?**
   Таблиця, яка описує кожну колонку БД: тип, обмеження, опис.
