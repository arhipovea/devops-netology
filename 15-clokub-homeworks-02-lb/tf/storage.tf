resource "yandex_storage_bucket" "s3" {
  access_key = var.yc_iam_access_key
  secret_key = var.yc_iam_secret_key
  bucket     = "netology-arkhipovea-15"
 }

resource "yandex_storage_object" "web-img" {
  access_key = var.yc_iam_access_key
  secret_key = var.yc_iam_secret_key
  bucket = "netology-arkhipovea-15"
  key    = "kali.png"
  source = "../assets/kali.png"
  acl = "public-read"
  depends_on = [yandex_storage_bucket.s3]
}
