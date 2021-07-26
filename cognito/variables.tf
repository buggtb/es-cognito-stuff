variable "name" {
}
variable "oauth_client_id" {
}
variable "oauth_client_secret" {
}
variable "client_callback_urls" {
  type = list(string)
  default = ["https://www.sevenbridges.com/"]
}
variable "domain" {
}

variable "enable_google" {
  type = bool
}
locals {
  user_pool_name       = var.name
  client_id            = var.oauth_client_id
  client_secret        = var.oauth_client_secret
  client_callback_urls = var.client_callback_urls
  custom_domain        = var.domain
}
