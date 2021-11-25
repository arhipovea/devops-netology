1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP


![show ip route](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic1.png)
![show bgp](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic2.png)

2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

![dummy](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic3.png)
![route](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic4.png)

3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.

![tcp ports](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic5.png)

	80 - http, веб сервер nginx
	53 - dns, служба systemd-resolve
	22 - ssh, служба sshd

4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

![udp ports](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic6.png)

	53 - dns, служба systemd-resolve
	68 - dhcp, служба systemd-network

5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.

![Home network](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic7.png)

6. * Установите Nginx, настройте в режиме балансировщика TCP или UDP.

![Balancer](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic8.png)
![Node1](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic9.png)
![Node2](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic10.png)
![Node3](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic11.png)
![Master Host](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic12.png)

7. * Установите bird2, настройте динамический протокол маршрутизации RIP.

![R1](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic13.png)
![R1 bird conf](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic14.png)
![R2](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic15.png)

8. * Установите Netbox, создайте несколько IP префиксов, используя curl проверьте работу API.

![Netbox](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic16.png)
![IP Prefix](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic17.png)
![API](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic18.png)
