data "yandex_compute_image" "latest_ubuntu" {
  family = var.ubuntu_family
  folder_id = "standard-images"
}

resource "yandex_compute_instance" "vm-1" {
  name = "netology-vm-1"
  platform_id = "standart-v1"
  zone = var.yc_zone

  resources {
      cores = 2
      memory = 2
  }

  boot_disk {
      initialize_params {
          image_id = var.ubuntu_id
      }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat = true
  }

  metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "from-terraform-network"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name = "from-terraform-subnet"
  zone = var.yc_zone
  network_id = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["10.2.0.0/16"]
}

