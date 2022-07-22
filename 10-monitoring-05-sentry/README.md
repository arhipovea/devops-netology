# Домашнее задание к занятию "10.05. Sentry"

## Задание 1

Так как self-hosted Sentry довольно требовательная к ресурсам система, мы будем использовать Free cloud аккаунт.

Free cloud account имеет следующие ограничения:
- 5 000 errors
- 10 000 transactions
- 1 GB attachments

Для подключения Free cloud account:
- зайдите на sentry.io
- нажжмите "Try for free"
- используйте авторизацию через ваш github-account
- далее следуйте инструкциям

Для выполнения задания - пришлите скриншот меню Projects.

![pic01](https://github.com/arhipovea/devops-netology/blob/main/10-monitoring-05-sentry/assets/pic01.png)
![pic02](https://github.com/arhipovea/devops-netology/blob/main/10-monitoring-05-sentry/assets/pic02.png)

## Задание 2

Создайте python проект и нажмите `Generate sample event` для генерации тестового события.

Изучите информацию, представленную в событии.

Перейдите в список событий проекта, выберите созданное вами и нажмите `Resolved`.

Для выполнения задание предоставьте скриншот `Stack trace` из этого события и список событий проекта, 
после нажатия `Resolved`.

![pic04](https://github.com/arhipovea/devops-netology/blob/main/10-monitoring-05-sentry/assets/pic04.png)

## Задание 3

Перейдите в создание правил алёртинга.

Выберите проект и создайте дефолтное правило алёртинга, без настройки полей.

Снова сгенерируйте событие `Generate sample event`.

Если всё было выполнено правильно - через некоторое время, вам на почту, привязанную к github аккаунту придёт
оповещение о произошедшем событии.

Если сообщение не пришло - проверьте настройки аккаунта Sentry (например привязанную почту), что у вас не было 
`sample issue` до того как вы его сгенерировали и то, что правило алёртинга выставлено по дефолту (во всех полях all).
Также проверьте проект в котором вы создаёте событие, возможно алёрт привязан к другому.

Для выполнения задания - пришлите скриншот тела сообщения из оповещения на почте.

Дополнительно поэкспериментируйте с правилами алёртинга. 
Выбирайте разные условия отправки и создавайте sample events. 

![pic03](https://github.com/arhipovea/devops-netology/blob/main/10-monitoring-05-sentry/assets/pic03.png)

## Задание повышенной сложности

Создайте проект на ЯП python или GO (небольшой, буквально 10-20 строк), подключите к нему sentry SDK и отправьте несколько тестовых событий.
Поэкспериментируйте с различными передаваемыми параметрами, но помните об ограничениях free учетной записи cloud Sentry.

Для выполнения задания пришлите скриншот меню issues вашего проекта и 
пример кода подключения sentry sdk/отсылки событий.

[code](https://github.com/arhipovea/devops-netology/blob/main/10-monitoring-05-sentry/main.py)

```python
from flask import Flask
import sentry_sdk
import logging
import sys


app = Flask(__name__)

sentry_sdk.init(
    dsn=sys.argv[1],
    traces_sample_rate=1.0
)

@app.route("/<string:mode>")
def index(mode):
    if mode == "error": 
        logging.error("Error for sentry", extra=dict(rc=777))
    elif mode == "exception":
        logging.exception("Exception for sentry")
    
    try:
        zero = 1 / 0
    except ZeroDivisionError:
        logging.exception("ZeroDivisionError")
    
    return f"Mode is {mode}"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8888)
```

![pic04](https://github.com/arhipovea/devops-netology/blob/main/10-monitoring-05-sentry/assets/pic04.png)

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
