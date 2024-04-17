output "name" {
  description = "The name of this account."
  value       = aws_organizations_account.this.name
}

output "email" {
  description = "The email address of this account."
  value       = aws_organizations_account.this.email
}

output "id" {
  description = "The ID of this AWS account."
  value       = aws_organizations_account.this.id
}

output "arn" {
  description = "The Amazon Resource Name (ARN) of this account."
  value       = aws_organizations_account.this.arn
}

output "govcloud_account_id" {
  description = "The ID for a GovCloud account created with the account."
  value       = aws_organizations_account.this.govcloud_id
}

output "status" {
  description = "The status of the account in the organization."
  value       = aws_organizations_account.this.status
}

output "parent_id" {
  description = "The ID of the parent Organizational Unit."
  value       = aws_organizations_account.this.parent_id
}

output "iam_user_access_to_billing_allowed" {
  description = "Whether accessing account billing information by IAM User is allowed."
  value       = var.iam_user_access_to_billing_allowed
}

output "preconfigured_administrator_role_name" {
  description = "The name of an IAM role that allow users in the master account to assume as administrator."
  value       = aws_organizations_account.this.role_name
}

output "delegated_services" {
  description = "A list of service principals of the AWS service which the member account is a delegated administrator."
  value       = var.delegated_services
}

output "created_by" {
  description = "The method how this account joined to the organization."
  value       = aws_organizations_account.this.joined_method
}

output "created_at" {
  description = "The datetime which this account joined to the organization."
  value       = aws_organizations_account.this.joined_timestamp
}

# output "debug" {
#   value = {
#     for k, v in aws_organizations_account.this :
#     k => v
#     if !contains(["id", "arn", "name", "parent_id", "tags", "tags_all", "close_on_deletion", "joined_timestamp", "joined_method", "role_name", "email", "status", "iam_user_access_to_billing", "govcloud_id"], k)
#   }
# }
