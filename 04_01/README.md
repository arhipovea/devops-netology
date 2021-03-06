# Домашнее задание к занятию "4.1. Командная оболочка Bash: Практические навыки"

## Обязательная задача 1

Есть скрипт:
```bash
a=1
b=2
c=a+b
d=$a+$b
e=$(($a+$b))
```

Какие значения переменным c,d,e будут присвоены? Почему?

| Переменная  | Значение | Обоснование |
| ------------- | ------------- | ------------- |
| `c`  | a+b  | потому что a+b это просто строка. |
| `d`  | 1+2  | потому что в переменных a и b хранятся строки 1 и 2, поэтому в переменную d значение переменной a, символ + и значение переменной b. |
| `e`  | 3  | потому что мы преобразуем строку 1 и строку 2 в целые числа и выполняем операцию сложения. |

## Обязательная задача 2
На нашем локальном сервере упал сервис и мы написали скрипт, который постоянно проверяет его доступность, записывая дату проверок до тех пор, пока сервис не станет доступным (после чего скрипт должен завершиться). В скрипте допущена ошибка, из-за которой выполнение не может завершиться, при этом место на Жёстком Диске постоянно уменьшается. Что необходимо сделать, чтобы его исправить:
```bash
while ((1==1)
do
	curl https://localhost:4757
	if (($? != 0))
	then
		date >> curl.log
	fi
done
```

### Ваш скрипт:
```bash
#!/usr/bin/env bash

while ((1==1))
do
    curl http://localhost:4757 &> /dev/null
    if (($? != 0))
    then
        date >> curl.log 
        sleep 1
    else
        break
    fi
done
```

## Обязательная задача 3

Необходимо написать скрипт, который проверяет доступность трёх IP: `192.168.0.1`, `173.194.222.113`, `87.250.250.242` по `80` порту и записывает результат в файл `log`. Проверять доступность необходимо пять раз для каждого узла.

### Ваш скрипт:
```bash
#!/usr/bin/env bash

IP=(192.168.0.1 173.194.222.113 87.250.250.242)

for ip in ${IP[@]}
do
    for i in {0..4}
    do
        res=$(curl -Is -m 2 http://$ip -w "%{http_code}" -o /dev/null)
        if (( $? == 0 ))
        then
            echo $(date) [$ip] Server respond: $res >> log
        else
            echo $(date) [$ip] Server is not responding >> log
        fi
        sleep 1
    done
done
```

## Обязательная задача 4
Необходимо дописать скрипт из предыдущего задания так, чтобы он выполнялся до тех пор, пока один из узлов не окажется недоступным. Если любой из узлов недоступен - IP этого узла пишется в файл error, скрипт прерывается.

### Ваш скрипт:
```bash
#!/usr/bin/env bash

IP=(192.168.0.1 173.194.222.113 87.250.250.242)

while ((1==1))
do
    res=$(curl -Is -m 2 http://$ip -w "%{http_code}" -o /dev/null)        
    if (( $? != 0 ))
    then
        echo $(date) [$ip] Server is not responding >> log
        break
    fi
done

for ip in ${IP[@]}
do
    for i in {0..4}
    do
        res=$(curl -Is -m 2 http://$ip -w "%{http_code}" -o /dev/null)
        if (( $? == 0 ))
        then
            echo $(date) [$ip] Server respond: $res >> log
        else
            echo $(date) [$ip] Server is not responding >> log
        fi
        sleep 1
    done
done
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Мы хотим, чтобы у нас были красивые сообщения для коммитов в репозиторий. Для этого нужно написать локальный хук для git, который будет проверять, что сообщение в коммите содержит код текущего задания в квадратных скобках и количество символов в сообщении не превышает 30. Пример сообщения: \[04-script-01-bash\] сломал хук.

### Ваш скрипт:
```bash
#!/usr/bin/env bash

msg=$(cat $1)
len=$(cat $1 | wc -m)

commit_regexp='^\[[0-9]{2}-[A-Za-z]+-[0-9]{2}-[A-Za-z]+\]$'

error_msg="$msg сломал хук"

cond1=$(grep -E "$commit_regexp" "$1")

if [[ ! $cond1 || $len -gt 30 ]]
then
        echo "$error_msg" >&2
        exit 1
fi
echo $1

```