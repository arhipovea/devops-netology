# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос  | Ответ |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  | TypeError |
| Как получить для переменной `c` значение 12?  | a = '1'  |
| Как получить для переменной `c` значение 3?  | b = 2  |

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
#!/usr/bin/env python3
import os

bash_command = ["cd ~/devops/test_script", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '~/devops/test_script/')
        print(prepare_result)
```

### Вывод скрипта при запуске при тестировании:
```
zica@mizica:~/devops/devops-netology/04_02$ ./02_find_exercise.sh 
~/devops/test_script/1
~/devops/test_script/dir1/6
~/devops/test_script/dir2/9
~/devops/test_script/1
~/devops/test_script/dir3/10
```

### Ваш скрипт (v.2):

Исправлена проблема, что если файл модифицирован, проиндексирован и ещё раз модифицирован, то в выдачу он попадается 2 раза

```python
#!/usr/bin/env python3
import os

def main():
    path = "~/devops/test_script/"
    bash_command = ["cd " + path, "git status -s"]
    result_os = os.popen(' && '.join(bash_command))
    for result in result_os:
        if "M" in result[:2]:
            print(path + result[3:-1])

if __name__ == '__main__':
    main()
```

### Вывод скрипта при запуске при тестировании:
```
zica@mizica:~/devops/devops-netology/04_02$ ./02_find_modified.sh 
~/devops/test_script/1
~/devops/test_script/dir1/6
~/devops/test_script/dir2/9
~/devops/test_script/dir3/10
```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
#!/usr/bin/env python3
import os
import sys


def find_git_modified_files():
    if len(sys.argv) < 2:
        path = "./"
    else:
        path = sys.argv[1]
        if not path.endswith("/"):
            path += "/"
    
    bash_command = ["cd " + path, "git status -s"]
    result_os = os.popen(' && '.join(bash_command))
    
    for result in result_os:
        if "M" in result[:2]:
            print(f"{path}{result[3:-1]}")
```

### Вывод скрипта при запуске при тестировании:
```
zica@mizica:~/devops/devops-netology/04_02$ ./03_find.sh ~/devops/test_script/
/home/zica/devops/test_script/1
/home/zica/devops/test_script/dir1/6
/home/zica/devops/test_script/dir2/9
/home/zica/devops/test_script/dir3/10
```

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
#!/usr/bin/env python3
import socket
import time


def monitor():
    services = {"drive.google.com": "0.0.0.0",
                "mail.google.com": "0.0.0.0",
                "google.com": "0.0.0.0"}
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
                services[service] = ip


if __name__ == '__main__':
    monitor()
```

### Вывод скрипта при запуске при тестировании:
```
zica@mizica:~/devops/devops-netology/04_02$ ./04_monitor.sh 
[ERROR] drive.google.com IP mismatch: 0.0.0.0 64.233.164.194
[ERROR] mail.google.com IP mismatch: 0.0.0.0 142.251.1.18
[ERROR] google.com IP mismatch: 0.0.0.0 142.251.1.138
 drive.google.com - 64.233.164.194
 mail.google.com - 142.251.1.18
[ERROR] google.com IP mismatch: 142.251.1.138 64.233.161.113
 drive.google.com - 64.233.164.194
 mail.google.com - 142.251.1.18
[ERROR] google.com IP mismatch: 64.233.161.113 64.233.161.101
 drive.google.com - 64.233.164.194
 mail.google.com - 142.251.1.18
 google.com - 64.233.161.101
 drive.google.com - 64.233.164.194
 mail.google.com - 142.251.1.18
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так получилось, что мы очень часто вносим правки в конфигурацию своей системы прямо на сервере. Но так как вся наша команда разработки держит файлы конфигурации в github и пользуется gitflow, то нам приходится каждый раз переносить архив с нашими изменениями с сервера на наш локальный компьютер, формировать новую ветку, коммитить в неё изменения, создавать pull request (PR) и только после выполнения Merge мы наконец можем официально подтвердить, что новая конфигурация применена. Мы хотим максимально автоматизировать всю цепочку действий. Для этого нам нужно написать скрипт, который будет в директории с локальным репозиторием обращаться по API к github, создавать PR для вливания текущей выбранной ветки в master с сообщением, которое мы вписываем в первый параметр при обращении к py-файлу (сообщение не может быть пустым). При желании, можно добавить к указанному функционалу создание новой ветки, commit и push в неё изменений конфигурации. С директорией локального репозитория можно делать всё, что угодно. Также, принимаем во внимание, что Merge Conflict у нас отсутствуют и их точно не будет при push, как в свою ветку, так и при слиянии в master. Важно получить конечный результат с созданным PR, в котором применяются наши изменения. 

### Ваш скрипт:
```python
#!/usr/bin/env python3

import argparse
import os
import shutil
import stat
import sys
import uuid

import requests
from git import Repo
from requests.auth import HTTPDigestAuth


def copytree(src, dst, symlinks=False, ignore=None):
    if not os.path.exists(dst):
        os.makedirs(dst)
        shutil.copystat(src, dst)
    lst = os.listdir(src)
    if ignore:
        excl = ignore(src, lst)
        lst = [x for x in lst if x not in excl]
    for item in lst:
        s = os.path.join(src, item)
        d = os.path.join(dst, item)
        if symlinks and os.path.islink(s):
            if os.path.lexists(d):
                os.remove(d)
            os.symlink(os.readlink(s), d)
            try:
                st = os.lstat(s)
                mode = stat.S_IMODE(st.st_mode)
                os.lchmod(d, mode)
            except:
                pass  # lchmod not available
        elif os.path.isdir(s):
            copytree(s, d, symlinks, ignore)
        else:
            shutil.copy2(s, d)


def argv_parser():
    prs = argparse.ArgumentParser()
    prs.add_argument("-m", "--message", default="Admin fix")
    prs.add_argument("-s", "--source", default="src")
    prs.add_argument("-d", "--destination", default="dst")
    prs.add_argument("-r", "--repo", default="work")
    prs.add_argument("--master", default="main")

    return prs


parser = argv_parser()
ns = parser.parse_args(sys.argv[1:])

username = "arhipovea"
token = "token"
repo_path = ns.destination
repo_name = ns.repo
src_path = ns.source
remote_url = f"git@github.com:{username}/{repo_name}.git"
remote_branch = ns.master
new_branch = f"{username}_{uuid.uuid4().hex[:8]}"
commit_message = ns.message

# Local git
if os.path.exists(repo_path):
    repo = Repo(repo_path)
else:
    repo = Repo.clone_from(remote_url, repo_path, branch=remote_branch)

git = repo.git
git.checkout("HEAD", b=new_branch)
copytree(src_path, repo_path)
if repo.is_dirty(untracked_files=True):
    print("Repo is dirty")
    git.add("--all")
    git.commit(m=commit_message)
    git.push("--set-upstream", "origin", new_branch)

# Remote api pull request
url = f"https://api.github.com/repos/{username}/{repo_name}/pulls"
headers = {"Accept": "application/vnd.github.v3+json"}
payload = {"head": f"{new_branch}", "base": f"{remote_branch}"}
auth = HTTPDigestAuth(username, token)
requests.post(url, headers=headers, data=payload, auth=auth)

# shutil.rmtree(repo_path)

```

### Вывод скрипта при запуске при тестировании:
```
zica@mizica:~/devops/devops-netology/04_02$ ./05_dop.sh -m "Testing" -s "src" -d "dst" -r "master"
Repo is dirty
```