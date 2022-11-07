
# Домашнее задание к занятию "13.4 инструменты для упрощения написания конфигурационных файлов. Helm и Jsonnet"
В работе часто приходится применять системы автоматической генерации конфигураций. Для изучения нюансов использования разных инструментов нужно попробовать упаковать приложение каждым из них.

## Задание 1: подготовить helm чарт для приложения
Необходимо упаковать приложение в чарт для деплоя в разные окружения. Требования:
* каждый компонент приложения деплоится отдельным deployment’ом/statefulset’ом;
* в переменных чарта измените образ приложения для изменения версии.

[**charts**](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-04-helm/helm)

## Задание 2: запустить 2 версии в разных неймспейсах
Подготовив чарт, необходимо его проверить. Попробуйте запустить несколько копий приложения:
* одну версию в namespace=app1;
* вторую версию в том же неймспейсе;
* третью версию в namespace=app2.

![pic01](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-04-helm/assets/pic01.png)
![pic02](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-04-helm/assets/pic02.png)
![pic03](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-04-helm/assets/pic03.png)
![pic04](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-04-helm/assets/pic04.png)
![pic05](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-04-helm/assets/pic05.png)
![pic06](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-04-helm/assets/pic06.png)
![pic07](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-04-helm/assets/pic07.png)
![pic08](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-04-helm/assets/pic08.png)
![pic09](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-04-helm/assets/pic09.png)


## Задание 3 (*): повторить упаковку на jsonnet
Для изучения другого инструмента стоит попробовать повторить опыт упаковки из задания 1, только теперь с помощью инструмента jsonnet.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---