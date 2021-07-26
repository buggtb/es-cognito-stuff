resource "aws_cognito_user_pool" "users" {
  name                     = local.user_pool_name
  admin_create_user_config {
    allow_admin_create_user_only = true
  }

  auto_verified_attributes = ["email"]
  mfa_configuration = "OFF"
  username_attributes = ["email"]

  user_pool_add_ons {
    advanced_security_mode = "OFF"
  }

  password_policy {
    minimum_length = 8
    require_lowercase = true
    require_numbers = true
    require_symbols = true
    require_uppercase = true
    temporary_password_validity_days = 90
  }
}

resource "aws_cognito_identity_provider" "google" {
  count = var.enable_google ? 1 : 0
  user_pool_id  = aws_cognito_user_pool.users.id
  provider_name = "Google"
  provider_type = "Google"

  provider_details = {
    authorize_scopes              = "profile email openid"
    client_id                     = local.client_id
    client_secret                 = local.client_secret
    token_url                     = "https://www.googleapis.com/oauth2/v4/token"
    token_request_method          = "POST"
    oidc_issuer                   = "https://accounts.google.com"
    authorize_url                 = "https://accounts.google.com/o/oauth2/v2/auth"
    attributes_url                = "https://people.googleapis.com/v1/people/me?personFields="
    attributes_url_add_attributes = "true"
  }

  attribute_mapping = {
    email    = "email"
    username = "sub"
  }
}

resource "aws_cognito_user_pool_client" "cognito" {
  name                                 = "client"
  user_pool_id                         = aws_cognito_user_pool.users.id
  supported_identity_providers         = var.enable_google ? ["COGNITO", "Google"] : ["COGNITO"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  callback_urls                        = local.client_callback_urls
  logout_urls                          = []
  read_attributes                      = []
  write_attributes                     = []
  explicit_auth_flows                  = []
  generate_secret                      = true

  depends_on = [aws_cognito_identity_provider.google]
}

resource "aws_cognito_user_pool_domain" "custom" {
  domain          = local.custom_domain
  user_pool_id    = aws_cognito_user_pool.users.id
}

resource "aws_cognito_identity_pool" "identity_pool" {
  identity_pool_name               = "${var.name}_identity_pool"
  allow_unauthenticated_identities = true

  cognito_identity_providers {
    client_id       = aws_cognito_user_pool_client.cognito.id
    provider_name   = aws_cognito_user_pool.users.endpoint
  }

  lifecycle {ignore_changes = [cognito_identity_providers]}
}