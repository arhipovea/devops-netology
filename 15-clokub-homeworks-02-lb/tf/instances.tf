# ================ Instance Group ==============================================

resource "yandex_compute_instance_group" "netelogy-ig" {
  name                = "netology-inastance-group"
  folder_id           = var.yc_folder_id
  service_account_id  = var.yc_service_account
  deletion_protection = false
  
  instance_template {
    platform_id = "standard-v1"
    resources {
      memory = 2
      cores  = 2
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = var.yc_lamp_image_id
        size     = 4
      }
    }
    network_interface {
      network_id = yandex_vpc_network.netology-vpc.id
      subnet_ids = ["${yandex_vpc_subnet.public-subnet.id}"]
      nat        = false
    }

    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
      user-data = file("${path.module}/cloud_config.yaml")
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  health_check {
    interval = 10
    timeout = 2
    healthy_threshold = 3
    unhealthy_threshold = 3
    http_options {
      port = 80
      path = "/index.html"
    }
  }

  allocation_policy {
    zones = [var.yc_zone]
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 2
  }

  load_balancer {
    target_group_name = "netology-tg"
  }
}
