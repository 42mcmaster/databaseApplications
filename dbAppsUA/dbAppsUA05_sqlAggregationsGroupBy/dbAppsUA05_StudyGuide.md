# dbApps05 Посібник для навчання: SQL агрегації, GROUP BY та Excel

**Курс:** Розробка застосувань баз даних (145085)
**Урок:** 05 — SQL агрегації, GROUP BY та інтеграція Excel
**Датасет:** nba_5seasons.db

---

## Цілі навчання

Після завершення цього уроку ви зможете:

1. Використовувати агрегуючі функції: COUNT, SUM, AVG, MIN, MAX, ROUND
2. Використовувати GROUP BY для обчислення агрегатів за категоріями
3. Використовувати AS для створення читабельних псевдонімів колонок
4. Пояснити різницю між WHERE та HAVING
5. Комбінувати всі речення SQL у правильному порядку
6. Експортувати результати запиту SQL в файл Excel за допомогою pandas

---

## Ключові терміни

| Термін | Визначення |
|--------|-----------|
| **Агрегуюча функція** | Функція, яка обчислює одне значення з багатьох рядків (COUNT, AVG та ін.) |
| **COUNT(*)** | Лічильник кількості рядків |
| **SUM(column)** | Додавання всіх значень у колонці |
| **AVG(column)** | Обчислення середнього значення (середнього арифметичного) колонки |
| **MAX(column)** | Повертає найбільше значення |
| **MIN(column)** | Повертає найменше значення |
| **ROUND(value, n)** | Округляє число до n знаків після коми |
| **GROUP BY** | Розділяє дані на групи і обчислює агрегати для кожної групи |
| **AS** | Створює псевдонім (прізвисько) для колонки у результатах |
| **HAVING** | Фільтрує групи після GROUP BY (можна використовувати агрегуючі функції) |
| **WHERE vs HAVING** | WHERE фільтрує окремі рядки перед групуванням; HAVING фільтрує групи після |
| **.to_excel()** | Метод pandas, який зберігає DataFrame в файл .xlsx |

---

## Концепція огляду

### Агрегуючі функції

Агрегуючі функції складають багато рядків в одне значення резюме. COUNT(*) лічить всі рядки. SUM, AVG, MIN та MAX працюють на числових колонках. ROUND() округляє будь-яке значення до вказаної кількості знаків після коми. Без GROUP BY агрегати повертають один рядок для всієї таблиці.

### GROUP BY

GROUP BY вказує SQL розділити дані на групи на основі значень колонки, потім обчислити агрегат для кожної групи окремо. `GROUP BY season` дає один рядок за сезон. `GROUP BY team_id` дає один рядок за команду. Можете групувати за кількома колонками: `GROUP BY team_id, season` дає один рядок за кожну комбінацію команда-сезон.

### Псевдоніми колонок (AS)

AS перейменовує колонку у виході. Без нього обчислені колонки мають неприємні імена типу `ROUND(AVG(pts), 1)`. З AS ви отримуєте чисті імена типу `avgPoints`. Псевдоніми роблять результати легшими для читання та особливо важливі при експорті в Excel.

### HAVING vs WHERE

WHERE фільтрує окремі рядки перед будь-яким групуванням — він не може використовувати агрегуючі функції. HAVING фільтрує після GROUP BY — він працює на узагальнених результатах і МОЖЕ використовувати агрегати. Приклад: `WHERE season = '2023-24'` фільтрує до однієї гри сезону. `HAVING AVG(pts) > 110` зберігає лише групи, де середнє перевищує 110.

### Повний порядок речень

SQL вимагає речень у цьому порядку: `SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY → LIMIT`. Вам не потрібні всі речення, але ті, які ви використовуєте, повинні дотримуватися цього порядку.

### SQL в Excel

pandas може зберегти будь-який DataFrame в Excel за допомогою `.to_excel("filename.xlsx", index=False)`. Робочий процес такий: запустити SQL → отримати DataFrame → зберегти в Excel → за потребою додати форматування.

---

## NBA база даних — Словник даних

### teams (30 рядків)
| Колонка | Тип | Опис |
|---------|-----|------|
| team_id | INTEGER | Унікальний ідентифікатор команди |
| full_name | TEXT | Повна назва команди (наприклад, "Los Angeles Lakers") |
| abbreviation | TEXT | 3-літерний код (наприклад, "LAL") |
| nickname | TEXT | Прізвисько команди (наприклад, "Lakers") |
| city | TEXT | Назва міста |
| state | TEXT | Назва штату |
| year_founded | INTEGER | Рік заснування команди |

### players (997 рядків)
| Колонка | Тип | Опис |
|---------|-----|------|
| player_id | INTEGER | Унікальний ідентифікатор гравця |
| full_name | TEXT | Повне ім'я гравця |

### team_game_stats (10,842 рядків)
| Колонка | Тип | Опис |
|---------|-----|------|
| season | TEXT | Сезон (наприклад, "2023-24") |
| game_id | TEXT | Унікальний ідентифікатор гри |
| team_id | INTEGER | Команда, яка грала |
| game_date | TEXT | Дата гри |
| matchup | TEXT | Хто грав з кимось (наприклад, "LAL vs. BOS") |
| wl | TEXT | Перемога або програш ("W" або "L") |
| pts | INTEGER | Набрані очки |
| fgm | INTEGER | Влучені з гри |
| fga | INTEGER | Спроб з гри |
| fg3m | INTEGER | Влучені трьохточкові |
| fg3a | INTEGER | Спроб трьохточкових |
| ftm | INTEGER | Влучені штрафні кидки |
| fta | INTEGER | Спроб штрафних кидків |
| oreb | INTEGER | Атакуючі підбори |
| dreb | INTEGER | Захисні підбори |
| reb | INTEGER | Всього підборів |
| ast | INTEGER | Передачі |
| stl | INTEGER | Перехопити |
| blk | INTEGER | Блокування |
| tov | INTEGER | Втрати м'яча |
| plus_minus | INTEGER | Різниця очок під час перебування на майданчику |

### player_season_stats (2,791 рядків)
| Колонка | Тип | Опис |
|---------|-----|------|
| season | TEXT | Сезон |
| player_id | INTEGER | Ідентифікатор гравця |
| team_id | INTEGER | Ідентифікатор команди |
| gp | INTEGER | Ігор зіграно |
| min | REAL | Хвилин на гру |
| pts | REAL | Очок на гру |
| reb | REAL | Підборів на гру |
| ast | REAL | Передач на гру |
| stl | REAL | Перехопи на гру |
| blk | REAL | Блокування на гру |
| tov | REAL | Втрати на гру |
| fg_pct | REAL | Відсоток влучення з гри |
| fg3_pct | REAL | Відсоток трьохточкових |
| ft_pct | REAL | Відсоток штрафних кидків |

---

## SQL Швидка довідка

### Агрегуючі функції
```sql
SELECT COUNT(*) FROM team_game_stats
SELECT AVG(pts) FROM player_season_stats
SELECT SUM(pts) FROM team_game_stats
SELECT MAX(pts) FROM team_game_stats
SELECT MIN(pts) FROM team_game_stats
SELECT ROUND(AVG(pts), 1) FROM player_season_stats
```

### GROUP BY
```sql
SELECT season, ROUND(AVG(pts), 1) AS avgPoints
FROM player_season_stats
GROUP BY season

SELECT team_id, COUNT(*) AS totalGames, SUM(CASE WHEN wl='W' THEN 1 ELSE 0 END) AS wins
FROM team_game_stats
GROUP BY team_id
```

### HAVING
```sql
SELECT team_id, AVG(pts) AS avgPts
FROM team_game_stats
GROUP BY team_id
HAVING AVG(pts) > 110
```

### Повний шаблон
```sql
SELECT column, AGG(column) AS alias
FROM table
WHERE condition
GROUP BY column
HAVING AGG(column) > value
ORDER BY alias DESC
LIMIT 10
```

### Експорт Excel
```python
result = pd.read_sql("SELECT ...", conn)
result.to_excel("output.xlsx", index=False)
```
