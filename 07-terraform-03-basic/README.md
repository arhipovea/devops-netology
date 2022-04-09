# Домашнее задание к занятию "7.3. Основы и принцип работы Терраформ"

## Задача 1. Создадим бэкэнд в S3 (необязательно, но крайне желательно).

1. Создайте s3 бакет, iam роль и пользователя от которого будет работать терраформ. Можно создать отдельного пользователя,
а можно использовать созданного в рамках предыдущего задания, просто добавьте ему необходимы права, как описано 
[здесь](https://www.terraform.io/docs/backends/types/s3.html).
2. Зарегистрируйте бэкэнд в терраформ проекте как описано по ссылке выше. 

---

![pic01](https://github.com/arhipovea/devops-netology/blob/main/07-terraform-03-basic/assets/pic01.png)

![pic02](https://github.com/arhipovea/devops-netology/blob/main/07-terraform-03-basic/assets/pic02.png)

## Задача 2. Инициализируем проект и создаем воркспейсы. 

1. Выполните `terraform init`:
    * если был создан бэкэнд в S3, то терраформ создат файл стейтов в S3 и запись в таблице 
dynamodb.
    * иначе будет создан локальный файл со стейтами.  
2. Создайте два воркспейса `stage` и `prod`.
3. В уже созданный `aws_instance` добавьте зависимость типа инстанса от вокспейса, что бы в разных ворскспейсах 
использовались разные `instance_type`.
4. Добавим `count`. Для `stage` должен создаться один экземпляр `ec2`, а для `prod` два. 
5. Создайте рядом еще один `aws_instance`, но теперь определите их количество при помощи `for_each`, а не `count`.
6. Что бы при изменении типа инстанса не возникло ситуации, когда не будет ни одного инстанса добавьте параметр
жизненного цикла `create_before_destroy = true` в один из рессурсов `aws_instance`.
7. При желании поэкспериментируйте с другими параметрами и рессурсами.

В виде результата работы пришлите:
* Вывод команды `terraform workspace list`.
* Вывод команды `terraform plan` для воркспейса `prod`.  

---

![pic03](https://github.com/arhipovea/devops-netology/blob/main/07-terraform-03-basic/assets/pic03.png)

```code
zica@mizica:~/devops-netology/07-terraform-03-basic/tf$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.vm1[0] will be created
  + resource "yandex_compute_instance" "vm1" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCXXW1GgthHtaHXhDiTXnpVQ6JoK+3XgRyN4+Yf+OFsztX0K+hgiuUE2GZngiV7FA2lpl0wwuQp9MEXPQd90S1xS9x52RgHJxdo712fuiRUt/i0/pXgr+reeGvCZFpglxVVWSMIow6osSqeh0Fp7MAL+iDSAsaFwAmHMCkoKerSqKjMvf3P45jXEBta1Iv8Z7XpF95xy/S4DFeAQvrQ+FFc6JGRLv3fuAeVoiVeATSICcBfygr57M0UtQB/qA1m41uBQ+VlEOEpkgUzUep5U90d4R+FYJgJ8Zi+dMuKjTuYPeS/O7dTnpK/opzf+E22WjxMBUxA8/qJf7JAvDlbs8YU/vctsgDTM3omkp5QaP1JYxqL8L/OilfcgDXCKK7bPaJJzqKvrR1fg17yc0ljZC3r2XHcHMqQyor4AFGfiAbNz9X3WMEYK+61rFMXy/xRkM7+9F2DaudRHu1x18JLbBb4qm/tseNtJ8uGGKmzZJr0ajZUwBZs/v6HCAlBYmIiO8s= zica@mizica
            EOT
        }
      + name                      = "ubuntu-2004-lts"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd879gb88170to70d38a"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + placement_group_id = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.vm1[1] will be created
  + resource "yandex_compute_instance" "vm1" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCXXW1GgthHtaHXhDiTXnpVQ6JoK+3XgRyN4+Yf+OFsztX0K+hgiuUE2GZngiV7FA2lpl0wwuQp9MEXPQd90S1xS9x52RgHJxdo712fuiRUt/i0/pXgr+reeGvCZFpglxVVWSMIow6osSqeh0Fp7MAL+iDSAsaFwAmHMCkoKerSqKjMvf3P45jXEBta1Iv8Z7XpF95xy/S4DFeAQvrQ+FFc6JGRLv3fuAeVoiVeATSICcBfygr57M0UtQB/qA1m41uBQ+VlEOEpkgUzUep5U90d4R+FYJgJ8Zi+dMuKjTuYPeS/O7dTnpK/opzf+E22WjxMBUxA8/qJf7JAvDlbs8YU/vctsgDTM3omkp5QaP1JYxqL8L/OilfcgDXCKK7bPaJJzqKvrR1fg17yc0ljZC3r2XHcHMqQyor4AFGfiAbNz9X3WMEYK+61rFMXy/xRkM7+9F2DaudRHu1x18JLbBb4qm/tseNtJ8uGGKmzZJr0ajZUwBZs/v6HCAlBYmIiO8s= zica@mizica
            EOT
        }
      + name                      = "ubuntu-2004-lts"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd879gb88170to70d38a"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + placement_group_id = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_vpc_network.network-1 will be created
  + resource "yandex_vpc_network" "network-1" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "network1"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.subnet-1 will be created
  + resource "yandex_vpc_subnet" "subnet-1" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet1"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.10.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 4 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + subnet-1 = (known after apply)
  + work     = "prod"

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```