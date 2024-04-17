output "name" {
  description = "The name of the Organization."
  value       = var.name
}

output "id" {
  description = "The ID of the Organization."
  value       = aws_organizations_organization.this.id
}

output "arn" {
  description = "The Amazon Resource Name (ARN) of the Organization."
  value       = aws_organizations_organization.this.arn
}

output "all_features_enabled" {
  description = "Whether AWS Organization was configured with all features or only consolidated billing feature."
  value       = var.all_features_enabled
}

output "enabled_policy_types" {
  description = "A set of Organizations Policy types enabled in the Organization Root."
  value       = aws_organizations_organization.this.enabled_policy_types
}

output "trusted_access_enabled_service_principals" {
  description = "List of AWS service principal names which is integrated with the organization."
  value       = var.trusted_access_enabled_service_principals
}

output "accounts" {
  description = "The accounts for the Organization."
  value       = aws_organizations_organization.this.accounts
}

output "master_account" {
  description = "The master account for the Organization."
  value = {
    id    = aws_organizations_organization.this.master_account_id
    arn   = aws_organizations_organization.this.master_account_arn
    email = aws_organizations_organization.this.master_account_email
  }
}

output "non_master_accounts" {
  description = "The non-master accounts for the Organization."
  value       = aws_organizations_organization.this.non_master_accounts
}

output "root" {
  description = "The root information of the Organization."
  value = {
    id   = aws_organizations_organization.this.roots[0].id
    arn  = aws_organizations_organization.this.roots[0].arn
    name = aws_organizations_organization.this.roots[0].name
  }
}

# output "debug" {
#   value = {
#     for k, v in aws_organizations_organization.this :
#     k => v
#     if !contains(["id", "arn", "accounts", "master_account_id", "master_account_arn", "master_account_email", "non_master_accounts", "roots", "aws_service_access_principals", "enabled_policy_types", "feature_set"], k)
#   }
# }
