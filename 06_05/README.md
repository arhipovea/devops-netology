# Домашнее задание к занятию "6.5. Elasticsearch"

## Задача 1

В этом задании вы потренируетесь в:
- установке elasticsearch
- первоначальном конфигурировании elastcisearch
- запуске elasticsearch в docker

Используя докер образ [centos:7](https://hub.docker.com/_/centos) как базовый и 
[документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для elasticsearch
- соберите docker-образ и сделайте `push` в ваш docker.io репозиторий
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины

Требования к `elasticsearch.yml`:
- данные `path` должны сохраняться в `/var/lib`
- имя ноды должно быть `netology_test`

В ответе приведите:

```bash
ea@sv-msc-dev-01:~/es$ cat config/elasticsearch.yml
cluster.name: netology_test
network.host: 0.0.0.0
transport.host: localhost
xpack.security.enabled: false
path.data: /var/lib/data
```

- текст Dockerfile манифеста

```dockerfile
FROM centos:7

ENV ES_PKG_NAME="elasticsearch-8.1.0" ES_HOME="/elasticsearch"

RUN echo "vm.max_map_count=262144" >> /etc/sysctl.conf

RUN \
    rpmkeys --import file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    yum -y update && \
    yum install -y wget perl-Digest-SHA && \
    yum clean all

RUN yum install -y java-1.8.0-openjdk-headless

RUN \
    cd / && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/$ES_PKG_NAME-linux-x86_64.tar.gz && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/$ES_PKG_NAME-linux-x86_64.tar.gz.sha512 && \
    shasum -a 512 -c $ES_PKG_NAME-linux-x86_64.tar.gz.sha512 && \
    rm $ES_PKG_NAME-linux-x86_64.tar.gz.sha512 && \
    tar xvzf $ES_PKG_NAME-linux-x86_64.tar.gz && \
    rm -f $ES_PKG_NAME-linux-x86_64.tar.gz && \
    mv /$ES_PKG_NAME /elasticsearch

RUN groupadd -g 1000 elasticsearch && useradd elasticsearch -u 1000 -g 1000 && \
    chown -R elasticsearch:elasticsearch $ES_HOME

ADD --chown=elasticsearch:elasticsearch config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

RUN mkdir /var/lib/data && chown -R elasticsearch:elasticsearch /var/lib/data

WORKDIR $ES_HOME

USER elasticsearch

CMD ["/elasticsearch/bin/elasticsearch"]

EXPOSE 9200

EXPOSE 9300
```

- ссылку на образ в репозитории dockerhub

[dockerhub](https://hub.docker.com/repository/docker/zicaentu/netology-elasticsearch)

- ответ `elasticsearch` на запрос пути `/` в json виде

```bash
ea@sv-msc-dev-01:~/es$ curl -X GET 'http://localhost:9200/'
```
```json
{
  "name" : "f5d19e45b717",
  "cluster_name" : "netology_test",
  "cluster_uuid" : "JBknUVshQbWenI7MafGoiA",
  "version" : {
    "number" : "8.1.0",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "3700f7679f7d95e36da0b43762189bab189bc53a",
    "build_date" : "2022-03-03T14:20:00.690422633Z",
    "build_snapshot" : false,
    "lucene_version" : "9.0.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
```

Подсказки:
- возможно вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum
- при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml
- при некоторых проблемах вам поможет docker директива ulimit
- elasticsearch в логах обычно описывает проблему и пути ее решения

Далее мы будем работать с данным экземпляром elasticsearch.

## Задача 2

В этом задании вы научитесь:
- создавать и удалять индексы
- изучать состояние кластера
- обосновывать причину деградации доступности данных

Ознакомтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) 
и добавьте в `elasticsearch` 3 индекса, в соответствии со таблицей:

| Имя | Количество реплик | Количество шард |
|-----|-------------------|-----------------|
| ind-1| 0 | 1 |
| ind-2 | 1 | 2 |
| ind-3 | 2 | 4 |

Получите список индексов и их статусов, используя API и **приведите в ответе** на задание.

Получите состояние кластера `elasticsearch`, используя API.

![pic01](https://github.com/arhipovea/devops-netology/blob/main/06_05/assets/pic01.png)

Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

---

Потому что первичный шард и реплика не могут находиться на одной ноде.

---

Удалите все индексы.

```bash
ea@sv-msc-dev-01:~/es$ curl -X DELETE 'http://localhost:9200/ind-1'
{"acknowledged":true}
ea@sv-msc-dev-01:~/es$ curl -X DELETE 'http://localhost:9200/ind-2'
{"acknowledged":true}
ea@sv-msc-dev-01:~/es$ curl -X DELETE 'http://localhost:9200/ind-3'
{"acknowledged":true}
```

## Задача 3

В данном задании вы научитесь:
- создавать бэкапы данных
- восстанавливать индексы из бэкапов

Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`.

![pic02](https://github.com/arhipovea/devops-netology/blob/main/06_05/assets/pic02.png)

Используя API [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) 
данную директорию как `snapshot repository` c именем `netology_backup`.

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

```bash
ea@sv-msc-dev-01:~/es$ cat config/elasticsearch.yml
cluster.name: netology_test
network.host: 0.0.0.0
transport.host: localhost
xpack.security.enabled: false
path.data: /var/lib/data
path.repo: /elasticsearch/snapshots
ea@sv-msc-dev-01:~/es$ curl -H 'Content-Type: application/json' -X PUT      -d '{
         "type": "fs",
        "settings": {
        "location": "/elasticsearch/snapshots"
        }
        }'     'http://localhost:9200/_snapshot/netology_backup'
{"acknowledged":true}
ea@sv-msc-dev-01:~/es$
```

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.

```bash
ea@sv-msc-dev-01:~/es$ curl -H 'Content-Type: application/json' -X PUT \
    -d '{
        "settings": {
        "number_of_shards": 1,
        "number_of_replicas": 0
        }
    }' \
    'http://localhost:9200/test'
ea@sv-msc-dev-01:~/es$ curl "localhost:9200/_cat/indices"
green open test v4wzbpc1RkmA5sym6tfoEQ 1 0 0 0 225b 225b
```

[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) 
состояния кластера `elasticsearch`.

**Приведите в ответе** список файлов в директории со `snapshot`ами.

```bash
ea@sv-msc-dev-01:~/es$ curl -X PUT "localhost:9200/_snapshot/netology_backup/%3Ctest_snapshot_%7Bnow%2Fd%7D%3E?wait_for_completion=true"
{"snapshot":{"snapshot":"test_snapshot_2022.03.10","uuid":"zG4vN9dhTzm38oVGGyuxWQ","repository":"netology_backup","version_id":8010099,"version":"8.1.0","indices":[".geoip_databases","test"],"data_streams":[],"include_global_state":true,"state":"SUCCESS","start_time":"2022-03-10T18:33:42.202Z","start_time_in_millis":1646937222202,"end_time":"2022-03-10T18:33:43.402Z","end_time_in_millis":1646937223402,"duration_in_millis":1200,"failures":[],"shards":{"total":2,"failed":0,"successful":2},"feature_states":[{"feature_name":"geoip","indices":[".geoip_databases"]}]}}
```

![pic03](https://github.com/arhipovea/devops-netology/blob/main/06_05/assets/pic03.png)

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

```bash
ea@sv-msc-dev-01:~/es$ curl -X DELETE "localhost:9200/test"
{"acknowledged":true}
ea@sv-msc-dev-01:~/es$ curl -H 'Content-Type: application/json' -X PUT     -d '{
        "settings": {
        "number_of_shards": 1,
        "number_of_replicas": 0
        }
    }'     'http://localhost:9200/test-2'
{"acknowledged":true,"shards_acknowledged":true,"index":"test-2"}
ea@sv-msc-dev-01:~/es$ curl "localhost:9200/_cat/indices"
green open test-2 p-czqT0bQv6sivDyjl1r9A 1 0 0 0 225b 225b
```
[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `elasticsearch` из `snapshot`, созданного ранее. 

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.

```bash
ea@sv-msc-dev-01:~/es$ curl -X GET "localhost:9200/_snapshot/netology_backup/*?verbose=false" | jq
{
  "snapshots": [
    {
      "snapshot": "test_snapshot_2022.03.10",
      "uuid": "zG4vN9dhTzm38oVGGyuxWQ",
      "repository": "netology_backup",
      "indices": [
        ".geoip_databases",
        "test"
      ],
      "data_streams": [],
      "state": "SUCCESS"
    }
  ],
  "total": 1,
  "remaining": 0
}
ea@sv-msc-dev-01:~/es$ curl -H 'Content-Type: application/json' -X POST     -d '{
        "indices": "*",
        "include_global_state": true
        }'     'http://localhost:9200/_snapshot/netology_backup/test_snapshot_2022.03.10/_restore'
{"accepted":true}
```

![pic04](https://github.com/arhipovea/devops-netology/blob/main/06_05/assets/pic04.png)
