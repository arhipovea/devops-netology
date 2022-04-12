# Домашнее задание к занятию "7.6. Написание собственных провайдеров для Terraform."

## Задача 1. 
Давайте потренируемся читать исходный код AWS провайдера, который можно склонировать от сюда: 
[https://github.com/hashicorp/terraform-provider-aws.git](https://github.com/hashicorp/terraform-provider-aws.git).
Просто найдите нужные ресурсы в исходном коде и ответы на вопросы станут понятны.  


1. Найдите, где перечислены все доступные `resource` и `data_source`, приложите ссылку на эти строки в коде на 
гитхабе.

---
Рассмотрим провайдер для яндекс облака.

[resource](https://github.com/yandex-cloud/terraform-provider-yandex/blob/master/yandex/provider.go#L200)

[data_source](https://github.com/yandex-cloud/terraform-provider-yandex/blob/master/yandex/provider.go#L138)

---

2. Для создания очереди сообщений SQS используется ресурс `aws_sqs_queue` у которого есть параметр `name`. 
    * С каким другим параметром конфликтует `name`? Приложите строчку кода, в которой это указано.

    ```go
    ConflictsWith: \[\]string{"name_prefix"}
    ```

    [link](https://github.com/yandex-cloud/terraform-provider-yandex/blob/master/yandex/resource_yandex_message_queue.go#L53)

    * Какая максимальная длина имени? 

    80 символов

    ```go
	if len(value) > 80 {
		errors = append(errors, fmt.Errorf("%q cannot be longer than 80 characters", k))
	}
    ```

    [link](https://github.com/yandex-cloud/terraform-provider-yandex/blob/master/yandex/resource_yandex_message_queue.go#L462)

    * Какому регулярному выражению должно подчиняться имя? 

    ```go
    if !regexp.MustCompile(`^[0-9A-Za-z-_]+(\.fifo)?$`).MatchString(value) {
		errors = append(errors, fmt.Errorf("Only alphanumeric characters and hyphens allowed in %q", k))
	}
    ```

    [link](https://github.com/yandex-cloud/terraform-provider-yandex/blob/master/yandex/resource_yandex_message_queue.go#L466)

## Задача 2. (Не обязательно) 
В рамках вебинара и презентации мы разобрали как создать свой собственный провайдер на примере кофемашины. 
Также вот официальная документация о создании провайдера: 
[https://learn.hashicorp.com/collections/terraform/providers](https://learn.hashicorp.com/collections/terraform/providers).

1. Проделайте все шаги создания провайдера.
2. В виде результата приложение ссылку на исходный код.
3. Попробуйте скомпилировать провайдер, если получится то приложите снимок экрана с командой и результатом компиляции.   

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---