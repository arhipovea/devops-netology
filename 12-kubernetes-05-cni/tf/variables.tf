variable "yc_token" {
  type = string
  description = "Yandex Cloud OAuth token"
}

variable "yc_cloud_id" {
  type = string
  description = "Yandex Cloud ID"
  default = "b1gdn3k0lg5v8o3qnp4j"
}

variable "yc_folder_id" {
  type = string
  description = "Yandex Cloud Folder ID"
  default = "b1g68ge17ldu86fka0mt"
}

variable "ubuntu_family" {
  type = string
  description = "Ubuntu family"
  default = "ubuntu-2204-lts"
}

variable "instance_count" {
  default = 3
}
