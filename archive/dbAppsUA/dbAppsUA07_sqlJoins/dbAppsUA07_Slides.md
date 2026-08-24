---
marp: true
theme: default
class: invert
paginate: true
---

# SQL JOINs
## Поєднання Даних Між Таблицями

**Розробка Додатків з Базами Даних**
Програмна Інженерія | Медина County Career Center

---

## Короткий Огляд

На Уроці 06 ми навчилися **нормалізації** — розділення однієї великої таблиці на кілька чистих таблиць.

Це чудово для зберігання даних. Але тепер виникає проблема:

> "Якщо мої дані розкидані на кілька таблиць, як я їх повернути разом, коли вони мені потрібні?"

**Відповідь:** JOINs (з'єднання).

---

## Проблема, яку Вирішують JOINs

Уявіть, що у вас є дві невеликі таблиці:

**Студенти**
```
| student_id | name    | dept_id |
|------------|---------|---------|
| 1          | Arnold  | D1      |
| 2          | Lebron  | D2      |
| 3          | Kobe    | D1      |
```

**Кафедри**
```
| dept_id | dept_name      |
|---------|----------------|
| D1      | Інженерія      |
| D2      | Мистецтво      |
```

Якщо запитати *"Хто навчається в Інженерії?"* — жодна таблиця сама по собі не може на це відповісти.
Вам потрібні фрагменти з **обох** таблиць.

---

## Що Робить JOIN (Простою Мовою)

JOIN говорить SQL:

> "Узми рядки з Таблиці А і **приклей** до них рядки з Таблиці B, шукаючи спільний стовпець."

Спільний стовпець майже завжди це **Зовнішній Ключ** (Foreign Key), який вказує на **Первинний Ключ** — саме такі зв'язки ми будували під час нормалізації.

---

## INNER JOIN — Типовий Варіант

**INNER JOIN** = повернути тільки рядки, які мають збіг у **обох** таблицях.

```sql
SELECT s.name, d.dept_name
FROM students AS s
INNER JOIN departments AS d
  ON s.dept_id = d.dept_id;
```

**Результат:**
```
| name   | dept_name      |
|--------|----------------|
| Arnold | Інженерія      |
| Lebron | Мистецтво      |
| Kobe   | Інженерія      |
```

Кожен студент мав відповідну кафедру, тому всі студенти з'являються у результаті.

---

## Що Таке Псевдоніми Таблиць?

```sql
FROM students AS s
INNER JOIN departments AS d ON s.dept_id = d.dept_id;
```

`s` та `d` — це **короткі прізвиська** для таблиць. Вони економлять друкування і роблять очевидним, звідки взявся кожен стовпець.

Без псевдонімів:
```sql
FROM students
INNER JOIN departments ON students.dept_id = departments.dept_id;
```

Все ще працює! Просто більше писати. Більшість професіоналів використовують псевдоніми.

---

## LEFT JOIN — Зберегти Всіх

**LEFT JOIN** = зберегти **ВСІ** рядки з ЛІВОЇ таблиці, навіть якщо немає збігу справа. Відсутня інформація справа стає `NULL`.

```sql
SELECT s.name, d.dept_name
FROM students AS s
LEFT JOIN departments AS d
  ON s.dept_id = d.dept_id;
```

**Результат:**
```
| name   | dept_name      |
|--------|----------------|
| Arnold | Інженерія      |
| Lebron | Мистецтво      |
| Kobe   | NULL           |   ← збережений, навіть без збігу
```

---

## INNER vs LEFT — Картина

```
     INNER JOIN                    LEFT JOIN
   (тільки перетин)        (все ліворуч + перетин)

     Students  Depts           Students  Depts
       ┌─┐     ┌─┐                ┌─┐     ┌─┐
       │ │ ∩  │ │                 │ │  ⊃ │ │
       └─┘     └─┘                └─┘     └─┘
   зберегти    показати          збережте ВСІ
   тільки      збіги             студентів
```

> **INNER JOIN:** "Показуй мені тільки рядки, які збігаються в обох місцях."
> **LEFT JOIN:** "Показуй мені всіх зліва, навіть якщо вони не збігаються."

---

## Який JOIN Вибрати?

Запитайте себе: **"Чи хочу я зберегти рядки, які не мають збігу?"**

| Я хочу знайти... | Використовуй |
|---|---|
| Студентів, які мають кафедру | INNER JOIN |
| ВСІх студентів, навіть без кафедри | LEFT JOIN |
| Фільми тільки з рейтингами | INNER JOIN |
| ВСІ фільми, показуючи рейтинг, якщо він є | LEFT JOIN |
| Клієнтів, які реально замовили | INNER JOIN |
| ВСІх клієнтів, включаючи тих, хто ніколи не замовляв | LEFT JOIN |

Золоте правило: **INNER за замовчуванням. Перейди на LEFT, коли "навіть без збігу" має значення.**

---

## Тепер Справжня Річ: JOINs у IMDb

IMDb розділяє інформацію про фільми на кілька таблиць (як ми нормалізували на уроці 06!).

- **title_basics** — tconst, primaryTitle, startYear, genres
- **title_ratings** — tconst, averageRating, numVotes

`tconst` — це спільний ключ.

Щоб побачити назви з їхніми рейтингами, ми маємо їх з'єднати.

---

## Приклад INNER JOIN для IMDb + LEFT JOIN

**INNER JOIN** — Топ 10 найвищі рейтинги з 2010 року (ті, що мають рейтинг):

```sql
SELECT tb.primaryTitle, tb.startYear, tr.averageRating
FROM title_basics AS tb
INNER JOIN title_ratings AS tr ON tb.tconst = tr.tconst
WHERE tb.startYear >= 2010
ORDER BY tr.averageRating DESC LIMIT 10;
```

**LEFT JOIN** — ВСІ фільми 2024 року, показуючи рейтинг, якщо він є:

```sql
SELECT tb.primaryTitle, tr.averageRating
FROM title_basics AS tb
LEFT JOIN title_ratings AS tr ON tb.tconst = tr.tconst
WHERE tb.startYear = 2024;
```

---

## З'єднання Більше Ніж Двох Таблиць

Ви можете ланцюжком з'єднати дані з 3, 4, навіть 5 таблиць.

Почніть з простої ментальної картини: **працівники → кафедри → будівлі**

```sql
SELECT e.name, d.dept_name, b.building_name
FROM employees AS e
INNER JOIN departments AS d ON e.dept_id = d.dept_id
INNER JOIN buildings AS b ON d.building_id = b.building_id;
```

Кожен JOIN додає ще одну таблицю, з'єднану спільним ключем.

---

## З'єднання Кількох Таблиць у IMDb

Знайти режисерів та фільми, які вони зняли:

```sql
SELECT nb.primaryName, tb.primaryTitle, tr.averageRating
FROM title_basics AS tb
INNER JOIN title_ratings AS tr ON tb.tconst = tr.tconst
INNER JOIN title_principals AS tp ON tb.tconst = tp.tconst
INNER JOIN name_basics AS nb ON tp.nconst = nb.nconst
WHERE tp.category = 'director' AND tr.averageRating > 8.0
ORDER BY tr.averageRating DESC;
```

---

## JOINs + GROUP BY = Аналітика

Після з'єднання даних ви можете їх агрегувати.

**Знайти топ 10 режисерів за середнім рейтингом (мінімум 5 фільмів):**

```sql
SELECT nb.primaryName,
       AVG(tr.averageRating) AS avg_rating,
       COUNT(*) AS total_films
FROM name_basics AS nb
INNER JOIN title_principals AS tp ON nb.nconst = tp.nconst
INNER JOIN title_basics AS tb ON tp.tconst = tb.tconst
INNER JOIN title_ratings AS tr ON tb.tconst = tr.tconst
WHERE tp.category = 'director'
GROUP BY nb.primaryName
HAVING COUNT(*) >= 5
ORDER BY avg_rating DESC LIMIT 10;
```

JOINs приносять дані разом. GROUP BY перетворює їх у висновки.

---

## Цілий Рецепт

1. **Визначте, які таблиці містять стовпці, які вам потрібні.**
2. **Знайдіть спільний ключ** між ними (зазвичай FK → PK зв'язок).
3. **Почніть з основної таблиці** у `FROM`.
4. **Додайте INNER JOIN** для кожної додаткової таблиці — або використайте LEFT JOIN, якщо вам потрібні рядки без збігу.
5. **Використовуйте псевдоніми** для читабельності запиту.
6. **Додайте WHERE / GROUP BY / ORDER BY** як звичайно.

---

## Ключові Висновки

- JOINs повертають дані, які нормалізація розділила.
- **INNER JOIN** = тільки відповідні рядки. Швидкий варіант за замовчуванням.
- **LEFT JOIN** = всі рядки з лівої таблиці; NULLs де нема збігу.
- **Псевдоніми** роблять запити читабельними.
- Ви можете ланцюжком з'єднати дані з 3+ таблиць.
- JOINs чудово працюють з GROUP BY для аналітики.

---

## Синтаксис на Один Погляд

```sql
SELECT [columns]
FROM   table1 AS a
INNER JOIN table2 AS b ON a.key = b.key
LEFT  JOIN table3 AS c ON b.key = c.key
WHERE  [conditions]
GROUP BY [columns]
ORDER BY [columns];
```

**Далі:** Практика у пройденному матеріалі, потім завдання та DIY.
