variable "cognito_domain" {
  default = "sbauthtest"
}

variable "cognito_name" {
  default = "cognito"
}

variable "elasticsearch_name" {
  default = "sbelastic"
}

variable "elasticsearch_domain" {
  default = "sblogging"
}

variable "region" {
  default = "us-west-2"
}

variable "es_sns_arn" {
  default = "arn:aws:sns:us-west-2:891431133728:test"
}

variable "iam_master_arn" {
  default = "arn:aws:iam::227024384036:user/bugg"
}

variable "account_id" {
  default = "227024384036"
}
