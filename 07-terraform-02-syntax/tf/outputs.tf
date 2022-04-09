output "ubuntu_last_id" {
  description = "ID of Ubuntu"
  value = "${data.yandex_compute_image.latest_ubuntu.id}"
}

output "folder_name" {
  description = "Folder name"
  value = "${data.yandex_resourcemanager_folder.my_folder.name}"
}

output "region" {
  description = "Region"
  value = var.yc_zone
}

output "subnet" {
  description = "Subnet ID"
  value = yandex_vpc_subnet.netology-subnet-1.id
}

output "intIP" {
  description = "Internal IP address"
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}

output "extIP" {
  description = "External IP address"
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}

