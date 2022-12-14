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
  description = "Yandex Cloud AZ"
  default = "ru-central1-a"
}

variable "yc_lamp_image_id" {
  type = string
  description = "Yandex Cloud LAMP Image ID"
  default = "fd827b91d99psvq5fjit"
}

variable "yc_service_account" {
  type = string
  description = "Yandex Service account"
  default = "ajeb90sha8f7ucfkkgtt"
}

variable "yc_iam_access_key" {
  type = string
  description = "Yandex IAM Access Key"
}

variable "yc_iam_secret_key" {
  type = string
  description = "Yandex IAM Secret Key"
}
