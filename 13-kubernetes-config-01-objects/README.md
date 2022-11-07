# Домашнее задание к занятию "13.1 контейнеры, поды, deployment, statefulset, services, endpoints"
Настроив кластер, подготовьте приложение к запуску в нём. Приложение стандартное: бекенд, фронтенд, база данных. Его можно найти в папке [13-kubernetes-config](13-kubernetes-config).

Упаковал приложения в контейнеры(исправил немного Dockerfile для frontend), разместил их на dockerhub. Развернул и настроил microk8s. 

## Задание 1: подготовить тестовый конфиг для запуска приложения
Для начала следует подготовить запуск приложения в stage окружении с простыми настройками. Требования:
* под содержит в себе 2 контейнера — фронтенд, бекенд;
* регулируется с помощью deployment фронтенд и бекенд;
* база данных — через statefulset.

[manifests](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-01-objects/manifests/stage)

![pic01](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-01-objects/assets/pic01.png)

![pic02](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-01-objects/assets/pic02.png)

![pic03](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-01-objects/assets/pic03.png)

![pic04](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-01-objects/assets/pic04.png)


## Задание 2: подготовить конфиг для production окружения
Следующим шагом будет запуск приложения в production окружении. Требования сложнее:
* каждый компонент (база, бекенд, фронтенд) запускаются в своем поде, регулируются отдельными deployment’ами;
* для связи используются service (у каждого компонента свой);
* в окружении фронта прописан адрес сервиса бекенда;
* в окружении бекенда прописан адрес сервиса базы данных.

[manifests](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-01-objects/manifests/prod)

![pic05](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-01-objects/assets/pic05.png)

![pic06](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-01-objects/assets/pic06.png)

![pic07](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-01-objects/assets/pic07.png)

![pic08](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-01-objects/assets/pic08.png)

## Задание 3 (*): добавить endpoint на внешний ресурс api
Приложению потребовалось внешнее api, и для его использования лучше добавить endpoint в кластер, направленный на это api. Требования:
* добавлен endpoint до внешнего api (например, геокодер).

---
