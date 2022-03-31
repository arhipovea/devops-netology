provider "yandex" {
  token     = IAM_TOKEN
  cloud_id  = "b1gdn3k0lg5v8o3qnp4j"
  folder_id = "b1g68ge17ldu86fka0mt"
  zone      = "ru-central1-a"
    
  data "ami" "ubuntu-linux" {
curl -H "Authorization: Bearer ${IAM_TOKEN}" "https://compute.api.cloud.yandex.net/compute/v1/images?folderId=standard-images&pageSize=1000" > output.json
}
}
