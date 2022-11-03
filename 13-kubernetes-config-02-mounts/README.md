# Домашнее задание к занятию "13.3 работа с kubectl"
## Задание 1: проверить работоспособность каждого компонента
Для проверки работы можно использовать 2 способа: port-forward и exec. Используя оба способа, проверьте каждый компонент:
* сделайте запросы к бекенду;
* сделайте запросы к фронту;
* подключитесь к базе данных.

Текущая конфигурация:

![pic01](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-03-kubectl/assets/pic01.png)

**exec**

![pic02](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-03-kubectl/assets/pic02.png)

![pic03](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-03-kubectl/assets/pic03.png)

![pic04](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-03-kubectl/assets/pic04.png)

**port-forward**

![pic05](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-03-kubectl/assets/pic05.png)

![pic06](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-03-kubectl/assets/pic06.png)

![pic07](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-03-kubectl/assets/pic07.png)

## Задание 2: ручное масштабирование

При работе с приложением иногда может потребоваться вручную добавить пару копий. Используя команду kubectl scale, попробуйте увеличить количество бекенда и фронта до 3. Проверьте, на каких нодах оказались копии после каждого действия (kubectl describe, kubectl get pods -o wide). После уменьшите количество копий до 1.

![pic08](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-03-kubectl/assets/pic08.png)

![pic09](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-03-kubectl/assets/pic09.png)

![pic10](https://github.com/arhipovea/devops-netology/blob/main/13-kubernetes-config-03-kubectl/assets/pic10.png)
