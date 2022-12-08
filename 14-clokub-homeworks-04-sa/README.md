# Домашнее задание к занятию "14.4 Сервис-аккаунты"

## Задача 1: Работа с сервис-аккаунтами через утилиту kubectl в установленном minikube

Выполните приведённые команды в консоли. Получите вывод команд. Сохраните
задачу 1 как справочный материал.

### Как создать сервис-аккаунт?

```
kubectl create serviceaccount netology
```

### Как просмотреть список сервис-акаунтов?

```
kubectl get serviceaccounts
kubectl get serviceaccount
```

![pic01](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-04-sa/assets/pic01.png)

### Как получить информацию в формате YAML и/или JSON?

```
kubectl get serviceaccount netology -o yaml
kubectl get serviceaccount default -o json
```

![pic02](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-04-sa/assets/pic02.png)

### Как выгрузить сервис-акаунты и сохранить его в файл?

```
kubectl get serviceaccounts -o json > serviceaccounts.json
kubectl get serviceaccount netology -o yaml > netology.yml
```

![pic03](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-04-sa/assets/pic03.png)

### Как удалить сервис-акаунт?

```
kubectl delete serviceaccount netology
```

![pic04](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-04-sa/assets/pic04.png)

### Как загрузить сервис-акаунт из файла?

```
kubectl apply -f netology.yml
```

![pic05](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-04-sa/assets/pic05.png)

## Задача 2 (*): Работа с сервис-акаунтами внутри модуля

Выбрать любимый образ контейнера, подключить сервис-акаунты и проверить
доступность API Kubernetes

```
kubectl run -i --tty fedora --image=fedora --restart=Never -- sh
```

Просмотреть переменные среды

```
env | grep KUBE
```

Получить значения переменных

```
K8S=https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT
SADIR=/var/run/secrets/kubernetes.io/serviceaccount
TOKEN=$(cat $SADIR/token)
CACERT=$SADIR/ca.crt
NAMESPACE=$(cat $SADIR/namespace)
```

![pic06](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-04-sa/assets/pic06.png)

Подключаемся к API

```
curl -H "Authorization: Bearer $TOKEN" --cacert $CACERT $K8S/api/v1/
```

![pic07](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-04-sa/assets/pic07.png)

В случае с minikube может быть другой адрес и порт, который можно взять здесь

```
cat ~/.kube/config
```

или здесь

```
kubectl cluster-info
```

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

В качестве решения прикрепите к ДЗ конфиг файлы для деплоя. Прикрепите скриншоты вывода команды kubectl со списком запущенных объектов каждого типа (pods, deployments, serviceaccounts) или скриншот из самого Kubernetes, что сервисы подняты и работают, а также вывод из CLI.

---