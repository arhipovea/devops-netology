# ================ Networks ==============================================
resource "yandex_vpc_network" "netology-vpc" {
  name = "netology-vpc"
}

resource "yandex_vpc_route_table" "private-routing-table" {
  name       = "private-routing-table"
  network_id = yandex_vpc_network.netology-vpc.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254"
  }
}

resource "yandex_vpc_subnet" "public-subnet" {
  name           = "public-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.netology-vpc.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "private-subnet" {
  name           = "private-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.netology-vpc.id
  v4_cidr_blocks = ["192.168.20.0/24"]
  route_table_id = yandex_vpc_route_table.private-routing-table.id
}
