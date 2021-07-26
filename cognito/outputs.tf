output "client_id" {
  value = aws_cognito_user_pool_client.cognito.id
}

output "user_pool_arn" {
  value = aws_cognito_user_pool.users.arn
}

output "cloudfront_distribution_arn" {
  value = aws_cognito_user_pool_domain.custom.cloudfront_distribution_arn
}

output "user_pool_id" {
  value = aws_cognito_user_pool.users.id
}

output "identity_pool_id" {
  value = aws_cognito_identity_pool.identity_pool.id
}

output "app_client_id" {
  value = aws_cognito_user_pool_client.cognito.id
}

output "auth_arn" {
  value = aws_iam_role.authenticated.arn
}