# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { 
        "info" : "Sample JSON output from our service\t",
        "elements" :
        [
            { 
                "name" : "first",
                "type" : "server",
                "ip" : 7175 
            },
            { 
                "name" : "second",
                "type" : "proxy",
                "ip" : "71.78.22.43"
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
#!/usr/bin/env python3
import socket
import time
import json
import yaml


services = {"drive.google.com": "0.0.0.0",
            "mail.google.com": "0.0.0.0",
            "google.com": "0.0.0.0"}
services_list = []
for s in services.items():
    services_list.append({s[0]: s[1]})
with open("ip.json", "w") as js:
    json.dump(services, js)
with open("ip.yml", "w") as yml:
    yaml.dump(services_list, yml)

try:
    while True:
        for service in services:
            time.sleep(0.5)
            try:
                ip = socket.gethostbyname(service)
            except OSError as e:
                print(f"\033[31m[EXCEPTION] {e}")
                continue

            if services[service] == ip:
                print("\033[0m", service, "-", ip)
            else:
                print(f"\033[31m[ERROR]\033[0m {service} IP mismatch: {services[service]} {ip}")
                services_list.remove({service: services[service]})
                
                services[service] = ip
                
                with open("ip.json", "w") as js:
                    json.dump(services, js) 
                
                services_list.append({service: ip})
                with open("ip.yml", "w") as yml:
                    yaml.dump(services_list, yml, default_flow_style=False)    
except KeyboardInterrupt:
    print("Keyboard Interrupt Extension")
```

### Вывод скрипта при запуске при тестировании:
```
zica@mizica:~/devops/devops-netology/04_03$ ./02_monitor2.sh 
[ERROR] drive.google.com IP mismatch: 0.0.0.0 74.125.131.194
[ERROR] mail.google.com IP mismatch: 0.0.0.0 209.85.233.19
[ERROR] google.com IP mismatch: 0.0.0.0 64.233.164.113
 drive.google.com - 74.125.131.194
 mail.google.com - 209.85.233.19
[ERROR] google.com IP mismatch: 64.233.164.113 64.233.164.138
 drive.google.com - 74.125.131.194
 mail.google.com - 209.85.233.19
^CKeyboard Interrupt Extension
```

### json-файл(ы), который(е) записал ваш скрипт:
```json
{"drive.google.com": "74.125.131.194", "mail.google.com": "209.85.233.19", "google.com": "64.233.164.138"}
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
- drive.google.com: 74.125.131.194
- mail.google.com: 209.85.233.19
- google.com: 64.233.164.138
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так как команды в нашей компании никак не могут прийти к единому мнению о том, какой формат разметки данных использовать: JSON или YAML, нам нужно реализовать парсер из одного формата в другой. Он должен уметь:
   * Принимать на вход имя файла
   * Проверять формат исходного файла. Если файл не json или yml - скрипт должен остановить свою работу
   * Распознавать какой формат данных в файле. Считается, что файлы *.json и *.yml могут быть перепутаны
   * Перекодировать данные из исходного формата во второй доступный (из JSON в YAML, из YAML в JSON)
   * При обнаружении ошибки в исходном файле - указать в стандартном выводе строку с ошибкой синтаксиса и её номер
   * Полученный файл должен иметь имя исходного файла, разница в наименовании обеспечивается разницей расширения файлов

### Ваш скрипт:
```python
#!/usr/bin/env python3
import json
import yaml
import sys
import pathlib


def load_config(config_file):
    with open(config_file, "r") as f:
        config = f.read()

    config_dict = dict()
    valid_json = True
    valid_yaml = True

    try:
        config_dict = json.loads(config)
    except:
        valid_json = False
    
    try:
        config_dict = yaml.safe_load(config)
    except:
        valid_yaml = False
    
    if valid_json:
        return "json", config_dict
    elif valid_yaml:
        return "yaml", config_dict
    raise SystemError("Its not JSON or YAML.")
        

def get_path():
    if len(sys.argv) < 2:
        raise FileNotFoundError("You need to provide filename.")
    else:
        return sys.argv[1]

def get_filename(path):
    p = pathlib.Path(path)
    return p.stem

path = get_path()
filename = get_filename(path)

file_type, config_dict = load_config(path)

if file_type == "json":
    with open(f"{filename}.yaml", "w") as f:
        yaml.dump(config_dict, f)
else:
    with open(f"{filename}.json", "w") as f:
        json.dump(config_dict, f)
```

### Пример работы скрипта:
zica@mizica:~/devops/devops-netology/04_03$ ./03_converter.sh config

Как сделать пункт "При обнаружении ошибки в исходном файле - указать в стандартном выводе строку с ошибкой синтаксиса и её номер" даже идей нет. 