# Debug and Fix Terraform Module — AWS

Use Terraform and AWS provider documentation, plus your experience, to fix the [fix-this-terraform-module-aws](./fix-this-terraform-module-aws/) Terraform module contained in this repo. You can use web search, AWS documentation, and Terraform commands to help you fix the module.

Note: The default workspace is considered production, and any other workspace is considered non-production.

AWS does not have a direct equivalent to a Google Cloud project or API enablement. In this challenge, use the current AWS account as the project boundary, expose its account ID, and create the requested AWS services directly. Use `a-project` as the common project name/tag for resources.

## Module Requirements

This module should meet the following requirements:

- Have variables for `region` (string) and `aws_account_id` (string), with values:
  - `region` = `"us-east-1"`
  - `aws_account_id` = `"123456789012"`
- Set a local definition for `env` to switch between `p` and `np` based on the Terraform workspace name
- Use the provided `aws_account_id` value to identify the AWS account boundary and tag resources with project name `a-project`
- Create an S3 bucket named `a-s3-bucket`, including the environment suffix when appropriate, in the provided region
- Create an SNS topic named `a-sns-topic`, including the environment suffix when appropriate
- Create an IAM role representing the module's service identity
- Attach permissions equivalent to publishing to the SNS topic and managing objects in the S3 bucket
- Have explicit or implicit dependencies between related resources where needed
- Have outputs for the AWS account ID, IAM role ARN, S3 bucket name, and SNS topic ARN
- Have appropriate Terraform and AWS provider version configurations for a Terraform module
- The `region` and `aws_account_id` variables must not prompt for input. Use Terraform mechanisms to set their values before running Terraform commands
- When Terraform runs in the default workspace, name resources with the production environment suffix. Non-default workspaces must use the non-production suffix

## Bonus Points

- Add a resource that ensures the S3 bucket name is globally unique and randomized
- Use least-privilege IAM policies scoped to the created S3 bucket and SNS topic instead of broad AWS-managed policies

## Validation

After fixing the module, use Terraform CLI commands to validate the changes.

1. Validate
2. Plan to see what resources will be created
3. Create a new workspace and switch to it from the default workspace
4. Plan to see what resources will be created and check resource differences from the default workspace
