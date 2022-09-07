output "subnet-1" {
  value = yandex_vpc_subnet.subnet-1.id
}

output "work" {
    value = terraform.workspace
}