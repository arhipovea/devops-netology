# Домашнее задание к занятию "14.3 Карты конфигураций"

## Задача 1: Работа с картами конфигураций через утилиту kubectl в установленном minikube

Выполните приведённые команды в консоли. Получите вывод команд. Сохраните
задачу 1 как справочный материал.

### Как создать карту конфигураций?

```
kubectl create configmap nginx-config --from-file=nginx.conf
kubectl create configmap domain --from-literal=name=netology.ru
```

---

![pic01](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-03-configmap/assets/pic01.png)

---

### Как просмотреть список карт конфигураций?

```
kubectl get configmaps
kubectl get configmap
```

---

![pic02](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-03-configmap/assets/pic02.png)

---

### Как просмотреть карту конфигурации?

```
kubectl get configmap nginx-config
kubectl describe configmap domain
```

---

![pic03](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-03-configmap/assets/pic03.png)

---

### Как получить информацию в формате YAML и/или JSON?

```
kubectl get configmap nginx-config -o yaml
kubectl get configmap domain -o json
```

---

![pic04](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-03-configmap/assets/pic04.png)

---

### Как выгрузить карту конфигурации и сохранить его в файл?

```
kubectl get configmaps -o json > configmaps.json
kubectl get configmap nginx-config -o yaml > nginx-config.yml
```

---

![pic05](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-03-configmap/assets/pic05.png)
![pic06](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-03-configmap/assets/pic06.png)

---

### Как удалить карту конфигурации?

```
kubectl delete configmap nginx-config
```

---

![pic07](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-03-configmap/assets/pic07.png)
![pic08](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-03-configmap/assets/pic08.png)

---

### Как загрузить карту конфигурации из файла?

```
kubectl apply -f nginx-config.yml
```

---

![pic09](https://github.com/arhipovea/devops-netology/blob/main/14-clokub-homeworks-03-configmap/assets/pic09.png)

---

## Задача 2 (*): Работа с картами конфигураций внутри модуля

Выбрать любимый образ контейнера, подключить карты конфигураций и проверить
их доступность как в виде переменных окружения, так и в виде примонтированного
тома

---