provider "yandex" {
  token = var.yc_token
  cloud_id = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone = "ru-central1-a"
}


terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "netologybucket"
    region     = "ru-central1"
    key        = "prodution/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

#========= Data ===============================================

data "yandex_compute_image" "latest_ubuntu" {
  family = var.ubuntu_family
  folder_id = "standard-images"
}


#========= Instance ===============================================
resource "yandex_compute_instance" "vm1" {
  name = var.ubuntu_family
  platform_id = var.platform[terraform.workspace]

  # count = terraform.workspace == "prod" ? 2 : 1
  count = var.instance_count[terraform.workspace]

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "${data.yandex_compute_image.latest_ubuntu.id}"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

# resource "yandex_compute_instance" "vm2" {
#   name = var.ubuntu_family
#   platform_id = var.platform[terraform.workspace]

#   chosen = terraform.workspace == "prod" ? 2 : 1
#   for_each = var.instance_count[terraform.workspace]

#   resources {
#     cores  = 2
#     memory = 2
#   }

#   boot_disk {
#     initialize_params {
#       image_id = "${data.yandex_compute_image.latest_ubuntu.id}"
#     }
#   }

#   network_interface {
#     subnet_id = yandex_vpc_subnet.subnet-1.id
#     nat       = true
#   }

#   metadata = {
#     ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
#   }
# }

# ================ Networks ==============================================
resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

