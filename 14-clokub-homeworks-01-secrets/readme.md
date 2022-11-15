# Домашнее задание к занятию "14.1 Создание и использование секретов"

## Задача 1: Работа с секретами через утилиту kubectl в установленном minikube

Выполните приведённые ниже команды в консоли, получите вывод команд. Сохраните
задачу 1 как справочный материал.

### Как создать секрет?

```
openssl genrsa -out cert.key 4096
openssl req -x509 -new -key cert.key -days 3650 -out cert.crt \
-subj '/C=RU/ST=Moscow/L=Moscow/CN=server.local'
kubectl create secret tls domain-cert --cert=certs/cert.crt --key=certs/cert.key
```

---

![pic01](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-01-secrets/assets/pic01.png)

---

### Как просмотреть список секретов?

```
kubectl get secrets
kubectl get secret
```

---

![pic02](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-01-secrets/assets/pic02.png)

---

### Как просмотреть секрет?

```
kubectl get secret domain-cert
kubectl describe secret domain-cert
```

---

![pic03](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-01-secrets/assets/pic03.png)

---

### Как получить информацию в формате YAML и/или JSON?

```
kubectl get secret domain-cert -o yaml
```

---

![pic04](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-01-secrets/assets/pic04.png)

---

```
kubectl get secret domain-cert -o json
```

---

![pic05](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-01-secrets/assets/pic05.png)

---

### Как выгрузить секрет и сохранить его в файл?

```
kubectl get secrets -o json > secrets.json
```

---

![pic06](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-01-secrets/assets/pic06.png)

---

```
kubectl get secret domain-cert -o yaml > domain-cert.yml
```

---

![pic07](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-01-secrets/assets/pic07.png)

---

### Как удалить секрет?

```
kubectl delete secret domain-cert
```

---

![pic08](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-01-secrets/assets/pic08.png)

---

### Как загрузить секрет из файла?

```
kubectl apply -f domain-cert.yml
```

---

![pic09](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-01-secrets/assets/pic09.png)

---

## Задача 2 (*): Работа с секретами внутри модуля

Выберите любимый образ контейнера, подключите секреты и проверьте их доступность
как в виде переменных окружения, так и в виде примонтированного тома.

---

[manifests](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-01-secrets/app/stage)

![pic10](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-01-secrets/assets/pic10.png)

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

В качестве решения прикрепите к ДЗ конфиг файлы для деплоя. Прикрепите скриншоты вывода команды kubectl со списком запущенных объектов каждого типа (deployments, pods, secrets) или скриншот из самого Kubernetes, что сервисы подняты и работают, а также вывод из CLI.

---