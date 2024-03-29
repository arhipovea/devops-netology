# Домашнее задание к занятию "13.2 разделы и монтирование"
Приложение запущено и работает, но время от времени появляется необходимость передавать между бекендами данные. А сам бекенд генерирует статику для фронта. Нужно оптимизировать это.
Для настройки NFS сервера можно воспользоваться следующей инструкцией (производить под пользователем на сервере, у которого есть доступ до kubectl):
* установить helm: curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
* добавить репозиторий чартов: helm repo add stable https://charts.helm.sh/stable && helm repo update
* установить nfs-server через helm: helm install nfs-server stable/nfs-server-provisioner

![pic05](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-02-mounts/assets/pic00.png)

## Задание 1: подключить для тестового конфига общую папку
В stage окружении часто возникает необходимость отдавать статику бекенда сразу фронтом. Проще всего сделать это через общую папку. Требования:
* в поде подключена общая папка между контейнерами (например, /static);
* после записи чего-либо в контейнере с беком файлы можно получить из контейнера с фронтом.

[manifests](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-02-mounts/manifests/stage)

![pic01](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-02-mounts/assets/pic01.png)


## Задание 2: подключить общую папку для прода
Поработав на stage, доработки нужно отправить на прод. В продуктиве у нас контейнеры крутятся в разных подах, поэтому потребуется PV и связь через PVC. Сам PV должен быть связан с NFS сервером. Требования:
* все бекенды подключаются к одному PV в режиме ReadWriteMany;
* фронтенды тоже подключаются к этому же PV с таким же режимом;
* файлы, созданные бекендом, должны быть доступны фронту.


[manifests](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-02-mounts/manifests/prod)

![pic02](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-02-mounts/assets/pic02.png)

![pic03](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-02-mounts/assets/pic03.png)

