variable "cognito_domain" {}

variable "name" {}

variable "elasticsearch_domain_name" {}

variable "elasticsearch_version" {
  default = "7.9"
}

variable "elasticsearch_instance" {
  default = "t2.small.elasticsearch"
}

variable "elasticsearch_instance_count" {
  default = 1
}

variable "elasticsearch_disk_size" {
  default = 35
}

variable "account_id" {}

variable "region" {}

variable "sns_topic_arn" {}

variable "cognito_user_pool_id"{
}

variable "cognito_identity_pool_id" {}


variable "cognito_auth_arn" {}