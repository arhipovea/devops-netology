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

variable "yc_zone" {
  type = string
  description = "Yandex Cloud zone"
  default = "ru-central1-a"
}

variable "ubuntu_family" {
  type = string
  description = "Ubuntu family"
  default = "ubuntu-2004-lts"
}

variable "ubuntu_id" {
  type = string
  description = "Ubuntu latest id"
  default = data.yandex_compute_image.latest_ubuntu.id
}