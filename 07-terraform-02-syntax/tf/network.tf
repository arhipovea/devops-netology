resource "yandex_vpc_network" "netology-network-1" {
  name = "from-netology-terraform-network"
}

resource "yandex_vpc_subnet" "netology-subnet-1" {
  name = "from-netology-terraform-subnet"
  zone = var.yc_zone
  network_id = yandex_vpc_network.netology-network-1.id
  v4_cidr_blocks = ["10.2.0.0/16"]
}