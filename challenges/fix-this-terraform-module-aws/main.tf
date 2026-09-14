# CODE CHALLENGE: Use Terraform and AWS provider documentation and your experience to fix the following Terraform module.
# You can use web search, AWS documentation, and Terraform commands to help you fix the module.
#
# Note: The default workspace is considered production, and any other workspace is considered non-production.
#
# AWS has no direct equivalent to a Google Cloud project or API enablement. Use the current AWS account as
# the project boundary, and use a-project as the common project name/tag.
#
# This module should meet the requirements in ../04 fix-terraform-module-aws.md.

locals {
  env = terraform.workspace == "prod" ? "p" : "np"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "a-s3-bucket-${local.env}"

  tags = {
    Name        = "a-project-${local.env}"
    Project     = "a-project"
    AccountID   = var.aws_account_id
    Environment = local.env
  }
}

resource "aws_sns_topic" "topic" {
  name = "a-sns-topic-${local.env}"

  tags = {
    Name        = "a-project-${local.env}"
    Project     = "a-project"
    AccountID   = var.aws_account_id
    Environment = local.env
  }
}

resource "aws_iam_role" "service_identity" {
  name = "a-service-identity-${local.env}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = {
    Name        = "a-project-${local.env}"
    Project     = "a-project"
    Environment = local.env
  }
}

resource "aws_iam_role_policy_attachment" "permissions" {
  role       = aws_iam_role.service_identity.name
  policy_arn = each.value

  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  ])
}
