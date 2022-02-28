# Домашнее задание к занятию "6.2. SQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

---

![pic1](https://github.com/arhipovea/devops-netology/blob/main/06_02/assets/pic01.png)

## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user  
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше,
- описание таблиц (describe)
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
- список пользователей с правами над таблицами test_db

---

![pic2](https://github.com/arhipovea/devops-netology/blob/main/06_02/assets/pic02.png)
![pic3](https://github.com/arhipovea/devops-netology/blob/main/06_02/assets/pic03.png)
![pic4](https://github.com/arhipovea/devops-netology/blob/main/06_02/assets/pic04.png)
![pic5](https://github.com/arhipovea/devops-netology/blob/main/06_02/assets/pic05.png)


## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.

---

![pic6](https://github.com/arhipovea/devops-netology/blob/main/06_02/assets/pic06.png)
![pic7](https://github.com/arhipovea/devops-netology/blob/main/06_02/assets/pic07.png)
![pic8](https://github.com/arhipovea/devops-netology/blob/main/06_02/assets/pic08.png)

## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
 
Подсказк - используйте директиву `UPDATE`.

---

![pic9](https://github.com/arhipovea/devops-netology/blob/main/06_02/assets/pic09.png)
![pic10](https://github.com/arhipovea/devops-netology/blob/main/06_02/assets/pic10.png)

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.

---

![pic11](https://github.com/arhipovea/devops-netology/blob/main/06_02/assets/pic11.png)

Команда выводит план выполнения запроса для планировщика. Планировщие, это часть СУБД, которая пытается оптимизировать запрос и выполнить его максимально эффективно.

Seq Scan on clients - последовательное чтение данных из таблицы clients

cost - некоторая стоимсоть запроса

0.00 - затраты на получение первой строки 

1.05 - затраты на получение всех строк

rows=3 - примерное количество возвращаемых строк

width=33 - средняя длина в байтах каждой строки

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

---

```console
root@070b30e92c03:/# pg_dump -U postgres -h localhost -W test_db > /backup/test_db.sql
```

Перезапустил новый контейнер

```console
root@90160e49e035:/# createdb -U postgres -h localhost -W -T template0 test_db
Password: 
root@90160e49e035:/# psql -U postgres -h localhost -W test_db < /backup/test_db.sql 
Password: 
```