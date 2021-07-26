terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}
provider "aws" {
  region  = var.region
}

module "cognito" {
  source     = "./cognito"
  domain = var.cognito_domain
  name = var.cognito_name
  oauth_client_id = ""
  oauth_client_secret = ""
  enable_google = false
}


module "elasticsearch" {
  source = "./elasticsearch"
  cognito_identity_pool_id = module.cognito.identity_pool_id
  cognito_user_pool_id = module.cognito.user_pool_id
  cognito_auth_arn = module.cognito.auth_arn
  account_id = "227024384036"
  cognito_domain = var.cognito_domain
  elasticsearch_domain_name = var.elasticsearch_domain
  name =  var.elasticsearch_name
  region = var.region
  sns_topic_arn = var.es_sns_arn
}