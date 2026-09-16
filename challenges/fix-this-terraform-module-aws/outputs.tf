output "value" {
  value = {
    account_id = var.aws_account_id
    role_arn   = aws_iam_role.service_identity.arn
  }
}
