provider "yandex" {
  token = var.yc_token
  cloud_id = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone = "ru-central1-a"
}

#========= Data ===============================================

data "yandex_compute_image" "latest_ubuntu" {
  family = var.ubuntu_family
  folder_id = "standard-images"
}


#========= Instance ===============================================
resource "yandex_compute_instance" "vm" {
  count = var.instance_count
  name = "node-${count.index + 1}"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "${data.yandex_compute_image.latest_ubuntu.id}"
      size = 20
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

