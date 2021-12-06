1. Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.

![Bitwarden1](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic1.png)
![Bitwarden2](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic2.png)

3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.

![node1](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic3.png)
![node2](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic4.png)

4. Проверьте на TLS уязвимости произвольный сайт в интернете.

![ssl](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic5.png)

5. Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.


![ssh](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic6.png)

6. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.

![ssh2](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic7.png)

7. Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.

![tcpdump](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic8.png)
![wireshark](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic9.png)

9.  Установите и настройте фаервол ufw на web-сервер из задания 3. Откройте доступ снаружи только к портам 22,80,443

![ufw](https://github.com/arhipovea/devops-netology/blob/main/03_8/pic10.png)