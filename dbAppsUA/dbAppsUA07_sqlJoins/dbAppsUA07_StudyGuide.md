# SQL JOINs — Навчальний Посібник

**Одиниця 4, Урок 2: Розуміння Взаємозв'язків Між Даними**

Розробка Додатків з Базами Даних (145085)
Medina County Career Center
Інструктор: Ryan McMaster

---

## 1. Словник Термінів

Важливі терміни для розуміння JOINs та реляційних баз даних:

| Термін | Визначення |
|---|---|
| **JOIN** | Операція SQL, яка поєднує рядки з двох або більше таблиць на основі пов'язаного стовпця. |
| **INNER JOIN** | Повертає тільки рядки, які мають збіги в обох таблицях. |
| **LEFT JOIN** | Повертає всі рядки з лівої таблиці плюс відповідні рядки з правої таблиці. Невідповідні рядки справа показують NULL. |
| **ON clause** | Визначає умови, які визначають, як таблиці зіставляються під час JOIN. Приклад: `ON table1.id = table2.id` |
| **Table alias** | Скорочена назва, надана таблиці за допомогою ключового слова AS, що робить запити більш читабельними. Приклад: `FROM users AS u` |
| **Matching rows** | Рядки з двох таблиць, які мають однакове значення у умові JOIN. |
| **Non-matching rows** | Рядки, які не знаходять партнера в іншій таблиці; обробляються по-різному INNER JOIN (виключені) vs LEFT JOIN (включені з NULL). |
| **NULL** | Заповнювач, що представляє "без значення" або "невідомо". З'являється у LEFT JOINs, коли рядок з лівої таблиці не має збігу у правій таблиці. |
| **Foreign key** | Стовпець в одній таблиці, який посилається на первинний ключ іншої таблиці, встановлюючи взаємозв'язок між таблицями. |
| **Primary key** | Унікальний ідентифікатор для кожного рядка в таблиці; часто використовується як якір у умовах JOIN. |
| **ON condition** | Логічний вираз, який визначає, які рядки зіставляються у JOIN. Часто порівнює зовнішній ключ з первинним ключем. |
| **Пустой** | Місце або відсутність информації. |

---

## 2. Словник Даних IMDb

**База Даних:** `imdb_class.db`

### Таблиця: title_basics
Основна інформація про назви (фільми, телесеріали тощо).

| Стовпець | Тип Даних | Опис |
|---|---|---|
| `tconst` | TEXT (PK) | Унікальний ідентифікатор для назви (стандартний формат IMDb: "tt" + 7-10 цифр). |
| `titleType` | TEXT | Тип назви (movie, tvSeries, short тощо). |
| `primaryTitle` | TEXT | Назва, яка використовується IMDb для відображення. |
| `originalTitle` | TEXT | Оригінальна назва в рідній мові. |
| `isAdult` | INTEGER | Логічне значення: 0 = не дорослий контент, 1 = дорослий контент. |
| `startYear` | INTEGER | Рік випуску (або початку для телесеріалів). Null якщо невідомо. |
| `endYear` | INTEGER | Рік закінчення для телесеріалів. Null для фільмів або поточних серіалів. |
| `runtimeMinutes` | INTEGER | Тривалість у хвилинах. Null якщо невідомо. |
| `genres` | TEXT | Список жанрів, розділених комами, до 3 жанрів (drama, comedy, action тощо). |

**Кількість Рядків:** 57,198

---

### Таблиця: title_ratings
Агреговані рейтинги та кількість голосів для назв.

| Стовпець | Тип Даних | Опис |
|---|---|---|
| `tconst` | TEXT (PK, FK) | Зовнішній ключ до `title_basics(tconst)`. Унікальний ідентифікатор для назви. |
| `averageRating` | REAL | Зважене середнє рейтингів користувачів (0.0 до 10.0). |
| `numVotes` | INTEGER | Кількість рейтингів користувачів, які сприяють середньому. |

**Кількість Рядків:** 57,198
**Взаємозв'язок:** Один-до-одного з `title_basics`. Кожна назва має рівно один запис рейтингу.

---

### Таблиця: name_basics
Інформація про людей (актори, режисери, сценаристи тощо).

| Стовпець | Тип Даних | Опис |
|---|---|---|
| `nconst` | TEXT (PK) | Унікальний ідентифікатор для людини (стандартний формат IMDb: "nm" + 7-10 цифр). |
| `primaryName` | TEXT | Ім'я, яке використовується IMDb для відображення. |
| `birthYear` | INTEGER | Рік народження. Null якщо невідомо. |
| `deathYear` | INTEGER | Рік смерті. Null якщо все ще живий. |
| `primaryProfession` | TEXT | Список професій, розділених комами, до 3 професій (actor, director, writer тощо). |
| `knownForTitles` | TEXT | Список назв, розділених комами, до 4 назв (значення tconst). |

**Кількість Рядків:** 400,017

---

### Таблиця: title_principals
Кредити для людей, залучених до назв (актори, режисери, сценаристи, продюсери тощо).

| Стовпець | Тип Даних | Опис |
|---|---|---|
| `tconst` | TEXT (FK) | Зовнішній ключ до `title_basics(tconst)`. Визначає назву. |
| `ordering` | INTEGER | Порядок появи/важливості для назви (1, 2, 3, ...). |
| `nconst` | TEXT (FK) | Зовнішній ключ до `name_basics(nconst)`. Визначає людину. |
| `category` | TEXT | Категорія ролі (actor, actress, director, writer, producer, composer, cinematographer тощо). |
| `job` | TEXT | Специфічна робота (наприклад, "Director," "Screenplay," "Original Music Composer"). Часто null. |
| `characters` | TEXT | JSON-форматований список імен персонажів (для акторів). |

**Кількість Рядків:** 1,084,764
**Взаємозв'язок:** Багато-до-багатьох між `title_basics` та `name_basics`. Назва має багато кредитів; людина з'являється у багатьох назвах.

---

## 3. Словник Даних NBA

**База Даних:** `nba_5seasons.db`

### Таблиця: teams
Інформація про команди NBA.

| Стовпець | Тип Даних | Опис |
|---|---|---|
| `team_id` | INTEGER (PK) | Унікальний ідентифікатор для команди. |
| `full_name` | TEXT | Повна назва команди (наприклад, "Los Angeles Lakers"). |
| `abbreviation` | TEXT | Трилітерний код команди (наприклад, "LAL"). |
| `nickname` | TEXT | Прізвисько команди (наприклад, "Lakers"). |
| `city` | TEXT | Домашнє місто. |
| `state` | TEXT | Домашня держава. |
| `year_founded` | INTEGER | Рік заснування команди у NBA. |

**Кількість Рядків:** 30

---

### Таблиця: players
Інформація про гравців NBA.

| Стовпець | Тип Даних | Опис |
|---|---|---|
| `player_id` | INTEGER (PK) | Унікальний ідентифікатор для гравця. |
| `full_name` | TEXT | Повне ім'я гравця. |

**Кількість Рядків:** 997

---

### Таблиця: team_game_stats
Статистика команди гра за грою.

| Стовпець | Тип Даних | Опис |
|---|---|---|
| `season` | INTEGER | Сезон NBA (наприклад, 2014 для сезону 2014-15). |
| `game_id` | INTEGER | Унікальний ідентифікатор для гри. |
| `team_id` | INTEGER (FK) | Зовнішній ключ до `teams(team_id)`. |
| `game_date` | TEXT | Дата гри (YYYY-MM-DD). |
| `matchup` | TEXT | Інформація про суперника (наприклад, "LAL vs. GSW"). |
| `wl` | TEXT | Результат гри: "W" для перемоги, "L" для поразки. |
| `pts` | INTEGER | Очки, набрані командою. |
| `fgm`, `fga` | INTEGER | Штрафні кидки виконані та спробовані. |
| `fg3m`, `fg3a` | INTEGER | Троквартирні кидки виконані та спробовані. |
| `ftm`, `fta` | INTEGER | Штрафні кидки виконані та спробовані. |
| `reb` | INTEGER | Усього підбірань. |
| `ast` | INTEGER | Передачі. |

**Кількість Рядків:** 10,842
**Взаємозв'язок:** Багато-до-одного з `teams`. Кілька ігор на команду за сезон.

---

### Таблиця: player_season_stats
Статистика гравця на рівні сезону.

| Стовпець | Тип Даних | Опис |
|---|---|---|
| `season` | INTEGER | Сезон NBA (наприклад, 2014 для сезону 2014-15). |
| `player_id` | INTEGER (FK) | Зовнішній ключ до `players(player_id)`. |
| `team_id` | INTEGER (FK) | Зовнішній ключ до `teams(team_id)`. |
| `gp` | INTEGER | Ігри грав. |
| `min` | REAL | Середнє хвилин грав за гру. |
| `pts` | REAL | Середнє очки за гру. |
| `reb` | REAL | Середнє підбірань за гру. |
| `ast` | REAL | Середнє передач за гру. |
| `fg_pct` | REAL | Процент штрафних кидків (0.0 до 1.0). |
| `fg3_pct` | REAL | Трокилерний процент (0.0 до 1.0). |
| `ft_pct` | REAL | Процент штрафних кидків (0.0 до 1.0). |

**Кількість Рядків:** 2,791
**Взаємозв'язок:** Багато-до-багатьох між `players` та `teams`. Гравці переходять між командами; команди мають багато гравців.

---

## 4. Синтаксис JOIN Швидкого Посилання

### INNER JOIN

Повертає тільки рядки, які збігаються в **обох** таблицях.

**Синтаксис:**
```sql
SELECT [columns]
FROM table1 AS alias1
INNER JOIN table2 AS alias2
  ON alias1.key = alias2.key;
```

**Приклад (IMDb):**
```sql
SELECT tb.primaryTitle, tb.startYear, tr.averageRating, tr.numVotes
FROM title_basics AS tb
INNER JOIN title_ratings AS tr ON tb.tconst = tr.tconst
WHERE tr.averageRating > 8.0
ORDER BY tr.averageRating DESC LIMIT 10;
```

---

### LEFT JOIN

Повертає всі рядки з лівої таблиці, плюс відповідні рядки з правої таблиці. Невідповідні рядки показують NULL.

**Синтаксис:**
```sql
SELECT [columns]
FROM table1 AS alias1
LEFT JOIN table2 AS alias2
  ON alias1.key = alias2.key;
```

**Приклад (IMDb):**
```sql
SELECT tb.primaryTitle, tb.startYear, tr.averageRating
FROM title_basics AS tb
LEFT JOIN title_ratings AS tr ON tb.tconst = tr.tconst
WHERE tb.startYear IS NOT NULL
ORDER BY tb.startYear DESC LIMIT 20;
```

---

## 5. Звичайні Моделі JOIN

### JOIN + WHERE Пункт

Фільтруйте результати після з'єднання:

```sql
SELECT tb.primaryTitle, nb.primaryName, tr.averageRating
FROM title_basics AS tb
INNER JOIN title_principals AS tp ON tb.tconst = tp.tconst
INNER JOIN name_basics AS nb ON tp.nconst = nb.nconst
INNER JOIN title_ratings AS tr ON tb.tconst = tr.tconst
WHERE tp.category = 'director' AND tr.averageRating > 7.5;
```

**Порядок виконання:** JOINs відбуваються першими, потім WHERE фільтрує результати.

---

### JOIN + GROUP BY

Агрегуйте дані після з'єднання:

```sql
SELECT nb.primaryName, COUNT(*) AS movie_count, AVG(tr.averageRating) AS avg_rating
FROM name_basics AS nb
INNER JOIN title_principals AS tp ON nb.nconst = tp.nconst
INNER JOIN title_ratings AS tr ON tp.tconst = tr.tconst
WHERE tp.category = 'actor'
GROUP BY nb.nconst, nb.primaryName
HAVING COUNT(*) >= 5
ORDER BY avg_rating DESC;
```

**Порядок виконання:** JOINs → WHERE → GROUP BY → HAVING → ORDER BY.

---

**Наступні Кроки:**
1. Перегляньте синтаксис, наведений вище.
2. Працюйте через живі приклади з вашим інструктором (07a, 07b, 07c).
3. Виконайте завдання DIY у dbApps07d.
4. Вивчіть цей посібник перед Тестом Одиниці 4.
