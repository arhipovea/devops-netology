# Домашнее задание к занятию "12.4 Развертывание кластера на собственных серверах, лекция 2"
Новые проекты пошли стабильным потоком. Каждый проект требует себе несколько кластеров: под тесты и продуктив. Делать все руками — не вариант, поэтому стоит автоматизировать подготовку новых кластеров.

## Задание 1: Подготовить инвентарь kubespray
Новые тестовые кластеры требуют типичных простых настроек. Нужно подготовить инвентарь и проверить его работу. Требования к инвентарю:
* подготовка работы кластера из 5 нод: 1 мастер и 4 рабочие ноды;
* в качестве CRI — containerd;
* запуск etcd производить на мастере.

---

Развернул кластер k8s с помощью kubespray в облаке YC на 5 ВМ(3 control plane, на них же etcd. В качестве worker nodes указал все ВМ). Добавил доступы на этот кластер на локальный компьютер в контексты. 

![pic01](https://github.com/arhipovea/devops-netology/blob/main/12-kubernetes-04-install-part-2/assets/01.png)

![pic02](https://github.com/arhipovea/devops-netology/blob/main/12-kubernetes-04-install-part-2/assets/02.png)

![pic03](https://github.com/arhipovea/devops-netology/blob/main/12-kubernetes-04-install-part-2/assets/03.png)

Изменения в inventory:

[hosts](https://github.com/arhipovea/devops-netology/tree/main/12-kubernetes-04-install-part-2/inventory/netology/hosts.yaml)

Изменения в общих настройках кластера:

![pic04](https://github.com/arhipovea/devops-netology/blob/main/12-kubernetes-04-install-part-2/assets/04.png)

![pic05](https://github.com/arhipovea/devops-netology/blob/main/12-kubernetes-04-install-part-2/assets/05.png)

Так же добавил некоторые аддоны.

## Задание 2 (*): подготовить и проверить инвентарь для кластера в AWS
Часть новых проектов хотят запускать на мощностях AWS. Требования похожи:
* разворачивать 5 нод: 1 мастер и 4 рабочие ноды;
* работать должны на минимально допустимых EC2 — t3.small.

---

AWS недоступен, развернул с помощью terraform в YC

[tf](https://github.com/arhipovea/devops-netology/tree/main/12-kubernetes-04-install-part-2/tf)