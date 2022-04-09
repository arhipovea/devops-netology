resource "yandex_compute_instance" "vm-1" {
  name = "netology-vm-1"
  platform_id = "standard-v1"
  zone = var.yc_zone

  resources {
      cores = 2
      memory = 2
  }

  boot_disk {
      initialize_params {
          image_id = "${data.yandex_compute_image.latest_ubuntu.id}"
      }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.netology-subnet-1.id
    nat = true
  }

  metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

#--------- data -------------------------------
data "yandex_compute_image" "latest_ubuntu" {
  family = var.ubuntu_family
  folder_id = "standard-images"
}

data "yandex_resourcemanager_folder" "my_folder" {
  folder_id = var.yc_folder_id
}