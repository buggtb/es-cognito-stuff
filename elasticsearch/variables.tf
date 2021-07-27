variable "cognito_domain" {}

variable "name" {}

variable "elasticsearch_domain_name" {}

variable "elasticsearch_version" {
  default = "7.10"
}

variable "elasticsearch_instance" {
  default = "t3.medium.elasticsearch"
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

variable "advanced_security_enabled" {
  type = bool
  default = false
}
variable "iam_master_arn" {
  default = ""
}