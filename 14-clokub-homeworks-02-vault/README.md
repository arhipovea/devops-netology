# Домашнее задание к занятию "14.2 Синхронизация секретов с внешними сервисами. Vault"

## Задача 1: Работа с модулем Vault

Запустить модуль Vault конфигураций через утилиту kubectl в установленном minikube

```
kubectl apply -f 14.2/vault-pod.yml
```

Получить значение внутреннего IP пода

```
kubectl get pod 14.2-netology-vault -o json | jq -c '.status.podIPs'
```

Примечание: jq - утилита для работы с JSON в командной строке

---

![pic01](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-02-vault/assets/pic01.png)

---

Запустить второй модуль для использования в качестве клиента

```
kubectl run -i --tty fedora --image=fedora --restart=Never -- sh
```

Установить дополнительные пакеты

```
dnf -y install pip
pip install hvac
```

Запустить интепретатор Python и выполнить следующий код, предварительно
поменяв IP и токен

```
import hvac
client = hvac.Client(
    url='http://10.10.133.71:8200',
    token='aiphohTaa0eeHei'
)
client.is_authenticated()

# Пишем секрет
client.secrets.kv.v2.create_or_update_secret(
    path='hvac',
    secret=dict(netology='Big secret!!!'),
)

# Читаем секрет
client.secrets.kv.v2.read_secret_version(
    path='hvac',
)
```

---

![pic02](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-02-vault/assets/pic02.png)

![pic03](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-02-vault/assets/pic03.png)

---

## Задача 2 (*): Работа с секретами внутри модуля

* На основе образа fedora создать модуль;
* Создать секрет, в котором будет указан токен;
* Подключить секрет к модулю;
* Запустить модуль и проверить доступность сервиса Vault.

---

Создал Dockerfile и "приложение", запушил на dockerhub, создал Deployment манифест.

[Deployment manifest](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-02-vault/manifests)

[Application](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-02-vault/app)

![pic04](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-02-vault/assets/pic04.png)

![pic05](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-02-vault/assets/pic05.png)

![pic06](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-02-vault/assets/pic06.png)
