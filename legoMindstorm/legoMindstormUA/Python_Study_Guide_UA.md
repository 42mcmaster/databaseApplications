# Посібник з вивчення Python: Усі 5 тем (Шпаргалка)
**Тримайте це на столі під час кодування!**

---

## **Розділ 1: Основи**

### Друк і Змінні
```python
print("Hello, EV3!")           # Вивести на консоль
name = "Robot"                 # Створити змінну
age = 5                        # Змінні зберігають значення
print(name, age)               # Вивести кілька речей
```

### Типи змінних

| Тип | Приклад | Використання |
|------|---------|-----|
| `int` | `speed = 75` | Цілі числа |
| `float` | `voltage = 8.5` | Десяткові числа |
| `str` | `name = "Motor A"` | Текст, завжди в лапках |
| `bool` | `is_moving = True` | Тільки True або False |

### Математичні операції

| Оператор | Приклад | Результат |
|----------|---------|--------|
| `+` | `10 + 5` | 15 |
| `-` | `10 - 5` | 5 |
| `*` | `10 * 5` | 50 |
| `/` | `10 / 5` | 2.0 (завжди float) |
| `//` | `10 // 3` | 3 (ціле ділення) |
| `%` | `10 % 3` | 1 (залишок) |
| `**` | `2 ** 3` | 8 (степінь) |

### F-Strings (Форматування рядків)
```python
speed = 75
distance = 100
print(f"Speed: {speed}%, Distance: {distance} cm")
# Вивід: Speed: 75%, Distance: 100 cm
```

### str() — Конвертація в рядок
```python
num = 42
text = str(num)       # Конвертувати число в рядок
print(text)           # "42"
print(type(text))     # <class 'str'>
```

---

## **Розділ 2: Цикли For**

### range() — Три версії

```python
for i in range(5):              # 0, 1, 2, 3, 4
    print(i)

for i in range(2, 7):           # 2, 3, 4, 5, 6
    print(i)

for i in range(0, 10, 2):       # 0, 2, 4, 6, 8 (лічити з кроком 2)
    print(i)
```

### Базова структура циклу
```python
for i in range(3):
    print(f"Loop iteration {i}")
# Вивід: 0, 1, 2
```

### Паттерн акумулятора (Додавання значень)
```python
total = 0                    # Почати з 0
for i in range(5):
    total = total + 10       # Додати 10 кожного разу
print(f"Total: {total}")     # Total: 50
```

### Цикл по списку
```python
motors = ["A", "B", "C"]
for motor in motors:
    print(f"Motor {motor}")
# Вивід: Motor A, Motor B, Motor C
```

---

## **Розділ 3: If/Else**

### Оператори порівняння

| Оператор | Значення | Приклад |
|----------|---------|---------|
| `==` | Дорівнює | `speed == 75` |
| `!=` | Не дорівнює | `speed != 0` |
| `>` | Більше ніж | `distance > 100` |
| `<` | Менше ніж | `distance < 50` |
| `>=` | Більше або дорівнює | `voltage >= 8` |
| `<=` | Менше або дорівнює | `voltage <= 12` |

### If/Elif/Else
```python
sensor = 60

if sensor > 80:
    print("OBSTACLE!")
elif sensor > 50:
    print("CAUTION")
else:
    print("CLEAR")
```

### Логічні оператори

| Оператор | Значення | Приклад |
|----------|---------|---------|
| `and` | Обидва мають бути істинними | `speed > 50 and speed < 100` |
| `or` | Принаймні один істинний | `sensor > 80 or battery < 8` |
| `not` | Протилежність | `not is_moving` |

### If всередині циклу
```python
for i in range(5):
    if i % 2 == 0:           # Якщо парне
        print(f"{i} is even")
    else:
        print(f"{i} is odd")
```

---

## **Розділ 4: Цикли While**

### Умова While
```python
count = 0
while count < 5:
    print(f"Count: {count}")
    count = count + 1        # Необхідно змінити умову!
# Вивід: 0, 1, 2, 3, 4
```

### While True + Break
```python
while True:                  # Цикл до нескінченності...
    sensor = 65
    if sensor > 80:
        print("Obstacle! Breaking out.")
        break                # ...доки не буде виконано break
    else:
        print("Path clear")
        break                # Завжди виконує break (лише одна ітерація тут)
```

### Паттерн датчика EV3
```python
while True:
    sensor_reading = 50      # Отримати значення датчика (на справжньому EV3 це приходить з датчика)

    if sensor_reading > 70:
        print("STOP!")
        break
    else:
        print("Drive forward")
```

---

## **Розділ 5: Функції**

### Синтаксис Def
```python
def function_name(parameter1, parameter2):
    print("Inside function")
    return some_value

function_name(arg1, arg2)    # Викликати функцію
```

### Функція з параметрами
```python
def set_speed(motor, speed):
    print(f"Motor {motor}: {speed}%")

set_speed("A", 75)           # Аргументи заповнюють параметри
```

### Функція з поверненням
```python
def double_it(num):
    result = num * 2
    return result            # Повернути значення назовні

answer = double_it(21)       # Зберегти повернене значення
print(answer)                # 42
```

### Функція з циклом всередині
```python
def repeat_beep(times):
    for i in range(times):
        print(f"BEEP {i+1}")

repeat_beep(3)
```

### Функція з циклом + поверненням
```python
def sum_numbers(count):
    total = 0
    for i in range(count):
        total = total + (i + 1)
    return total             # Повернути після закінчення циклу

result = sum_numbers(5)      # Має бути 15 (1+2+3+4+5)
```

### Функція з If/Else всередині
```python
def check_status(value, threshold):
    if value > threshold:
        status = "OK"
    else:
        status = "ALARM"
    return status

print(check_status(85, 80))  # OK
print(check_status(70, 80))  # ALARM
```

### Функція з циклом + If/Else
```python
def patrol(num_scans, threshold):
    for i in range(num_scans):
        sensor = 30 + (i * 20)

        if sensor > threshold:
            print(f"Scan {i+1}: STOP! Reading {sensor}")
            break
        else:
            print(f"Scan {i+1}: Clear, reading {sensor}")

patrol(4, 60)
```

---

## **Розділ 6: Поширені помилки**

| Помилка | Неправильно | Правильно | Причина |
|-------|-------|-------|--------|
| Відсутня `:` | `if x > 5` | `if x > 5:` | Python потребує двокрапку |
| Неправильне відступлення | `for i in range(3):`<br/>`print(i)` | `for i in range(3):`<br/>`    print(i)` | Тіло має бути з відступом 4 пробіли |
| `=` проти `==` | `if x = 5:` | `if x == 5:` | `=` - це присвоєння, `==` - це порівняння |
| Забув `()` при виклику | `my_func` | `my_func()` | Необхідно використовувати дужки для виклику |
| Забув `return` | `def double(x):`<br/>`    result = x * 2` | `def double(x):`<br/>`    result = x * 2`<br/>`    return result` | Функція повертає `None` без `return` |
| Неправильна назва параметра | `def drive(spd):`<br/>`    print(speed)` | `def drive(speed):`<br/>`    print(speed)` | Необхідно використовувати точну назву параметра |
| Off-by-one у циклі | `for i in range(5): print(i)` → 0,1,2,3,4 | Використовувати `i+1` для друку 1,2,3,4,5 | `range(5)` починається з 0 |

---

## **Розділ 7: Повний паттерн датчика EV3**

**Це те, що ви будете використовувати в кожній програмі EV3:**

```python
def robot_patrol(num_checks, obstacle_threshold):
    """
    Їхати та перевіряти датчик доки не буде знайдено перешкоду або не закінчиться перевірки.
    """
    for attempt in range(num_checks):
        # Отримати показання датчика (на справжньому EV3 використовувати ev3.sensor...)
        sensor_value = 45 + (attempt * 10)

        # Перевірити, чи виявлена перешкода
        if sensor_value > obstacle_threshold:
            print(f"Attempt {attempt+1}: OBSTACLE DETECTED ({sensor_value})")
            print("ROBOT STOPPING!")
            break
        else:
            print(f"Attempt {attempt+1}: Path clear ({sensor_value}), moving forward")

    print("Patrol complete")

# Викликати
robot_patrol(5, 70)
```

**Розбір паттерну:**
1. **Визначення функції** з параметрами для гнучкості
2. **Цикл for** для повторення перевірок датчика
3. **If/else** для прийняття рішення на основі датчика
4. **Break** для зупинення, коли знайдена перешкода
5. **Друк** на кожному кроці для звіту про статус
6. Все всередині функції, щоб ви могли переносити код

---

## **Швидкий довідник: Коли використовувати що**

| Потреба | Використовувати | Приклад |
|------|-----|---------|
| Повторити код 3 рази | `for` цикл з `range(3)` | Перевірити датчик 3 рази |
| Повторити поки умова істинна | `while` цикл | Продовжувати їхати поки шлях вільний |
| Вибрати між варіантами | `if/elif/else` | Різні дії на основі датчика |
| Переносити блок коду | `def` функція | Звіт про мотор, перевірка перешкоди |
| Обчислити значення | `return` у функції | Відстань з часу та швидкості |
| Комбінувати все | Цикл + if/else у функції | Поведінка робота-патруля |

---

## **Оператори друку для відлагодження**

Коли ваш код не працює, додайте оператори `print()`:

```python
def my_function(x):
    print(f"Received x = {x}")      # Перевірити параметр
    result = x * 2
    print(f"Calculated result = {result}")  # Перевірити значення
    return result

my_function(10)
```

Вивід розповідає вам, чи мають змінні правильні значення в правильний час!
