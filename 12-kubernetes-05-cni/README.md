# Домашнее задание к занятию "12.5 Сетевые решения CNI"
После работы с Flannel появилась необходимость обеспечить безопасность для приложения. Для этого лучше всего подойдет Calico.

---

Установил кластер с Flannel

![pic01](https://github.com/arhipovea/devops-netology/blob/main/12-kubernetes-05-cni/assets/01.png)

## Задание 1: установить в кластер CNI плагин Calico
Для проверки других сетевых решений стоит поставить отличный от Flannel плагин — например, Calico. Требования: 
* установка производится через ansible/kubespray;
* после применения следует настроить политику доступа к hello-world извне. Инструкции [kubernetes.io](https://kubernetes.io/docs/concepts/services-networking/network-policies/), [Calico](https://docs.projectcalico.org/about/about-network-policy)

---

Установил Calico с помощью Kubespray

![pic02](https://github.com/arhipovea/devops-netology/blob/main/12-kubernetes-05-cni/assets/02.png)

Развернул Hello-world и проверил доступность

![pic03](https://github.com/arhipovea/devops-netology/blob/main/12-kubernetes-05-cni/assets/03.png)
![pic04](https://github.com/arhipovea/devops-netology/blob/main/12-kubernetes-05-cni/assets/04.png)

Развернул ещё один под для проверки доступности

![pic05](https://github.com/arhipovea/devops-netology/blob/main/12-kubernetes-05-cni/assets/05.png)
![pic06](https://github.com/arhipovea/devops-netology/blob/main/12-kubernetes-05-cni/assets/06.png)

Создал политику по умолчанию, запрещающую всё и проверил доступность

[default](https://github.com/arhipovea/devops-netology/tree/main/12-kubernetes-05-cni/manifests/default_policy.yml)

![pic07](https://github.com/arhipovea/devops-netology/blob/main/12-kubernetes-05-cni/assets/07.png)
![pic08](https://github.com/arhipovea/devops-netology/blob/main/12-kubernetes-05-cni/assets/08.png)

Добавил разверешения для пода Hello-node, чтобы он был доступен с пода Check-node

[hello](https://github.com/arhipovea/devops-netology/tree/main/12-kubernetes-05-cni/manifests/hello_policy.yml)
[check](https://github.com/arhipovea/devops-netology/tree/main/12-kubernetes-05-cni/manifests/check_policy.yml)

![pic09](https://github.com/arhipovea/devops-netology/blob/main/12-kubernetes-05-cni/assets/09.png)

Проверил доступность

![pic10](https://github.com/arhipovea/devops-netology/blob/main/12-kubernetes-05-cni/assets/10.png)

## Задание 2: изучить, что запущено по умолчанию
Самый простой способ — проверить командой calicoctl get <type>. Для проверки стоит получить список нод, ipPool и profile.
Требования: 
* установить утилиту calicoctl;
* получить 3 вышеописанных типа в консоли.

---

Установил calicoctl на локальный компьютер и проверил работу

![pic11](https://github.com/arhipovea/devops-netology/blob/main/12-kubernetes-05-cni/assets/11.png)