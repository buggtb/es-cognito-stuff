
resource "aws_elasticsearch_domain" "es" {
  domain_name           = var.elasticsearch_domain_name
  elasticsearch_version = var.elasticsearch_version

  cluster_config {
    instance_type  = var.elasticsearch_instance
  }

  ebs_options {
    ebs_enabled = true
    volume_type = "gp2"
    volume_size = 35
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  access_policies = data.aws_iam_policy_document.es_access_policy.json

  cognito_options {
    enabled = true
    user_pool_id = var.cognito_user_pool_id
    identity_pool_id = var.cognito_identity_pool_id
    role_arn = aws_iam_role.cognito_es_role.arn
  }

  encrypt_at_rest {
    enabled = true
  }

  node_to_node_encryption {
    enabled = true
  }

  domain_endpoint_options {
    enforce_https = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  advanced_security_options {
    enabled = var.advanced_security_enabled
    master_user_options {
      master_user_arn = var.iam_master_arn
    }
  }


  depends_on = [aws_iam_service_linked_role.es, aws_iam_role_policy_attachment.cognito_es_attach]
}
