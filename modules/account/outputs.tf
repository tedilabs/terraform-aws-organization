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
  value       = local.delegated_service_names
}

output "created_by" {
  description = "The method how this account joined to the organization."
  value       = aws_organizations_account.this.joined_method
}

output "created_at" {
  description = "The datetime which this account joined to the organization."
  value       = aws_organizations_account.this.joined_timestamp
}

output "additional_regions" {
  description = "A set of additional regions enabled in the account."
  value = toset([
    for region, enabled in var.additional_regions :
    region
    if enabled
  ])
}

output "primary_contact" {
  description = "The primary contact attached to an AWS Account."
  value = try({
    name           = aws_account_primary_contact.this[0].full_name
    company_name   = aws_account_primary_contact.this[0].company_name
    country_code   = aws_account_primary_contact.this[0].country_code
    state          = aws_account_primary_contact.this[0].state_or_region
    city           = aws_account_primary_contact.this[0].city
    district       = aws_account_primary_contact.this[0].district_or_county
    address_line_1 = aws_account_primary_contact.this[0].address_line_1
    address_line_2 = aws_account_primary_contact.this[0].address_line_2
    address_line_3 = aws_account_primary_contact.this[0].address_line_3
    postal_code    = aws_account_primary_contact.this[0].postal_code
    phone          = aws_account_primary_contact.this[0].phone_number
    website_url    = aws_account_primary_contact.this[0].website_url
  }, null)
}

output "billing_contact" {
  description = "The billing contact attached to an AWS Account."
  value = try({
    name  = aws_account_alternate_contact.billing[0].name
    title = aws_account_alternate_contact.billing[0].title
    email = aws_account_alternate_contact.billing[0].email_address
    phone = aws_account_alternate_contact.billing[0].phone_number
  }, null)
}

output "operation_contact" {
  description = "The operation contact attached to an AWS Account."
  value = try({
    name  = aws_account_alternate_contact.operation[0].name
    title = aws_account_alternate_contact.operation[0].title
    email = aws_account_alternate_contact.operation[0].email_address
    phone = aws_account_alternate_contact.operation[0].phone_number
  }, null)
}

output "security_contact" {
  description = "The security contact attached to an AWS Account."
  value = try({
    name  = aws_account_alternate_contact.security[0].name
    title = aws_account_alternate_contact.security[0].title
    email = aws_account_alternate_contact.security[0].email_address
    phone = aws_account_alternate_contact.security[0].phone_number
  }, null)
}

output "resource_group" {
  description = "The resource group created to manage resources in this module."
  value = merge(
    {
      enabled = var.resource_group.enabled && var.module_tags_enabled
    },
    (var.resource_group.enabled && var.module_tags_enabled
      ? {
        arn  = module.resource_group[0].arn
        name = module.resource_group[0].name
      }
      : {}
    )
  )
}

# output "debug" {
#   value = {
#     for k, v in aws_organizations_account.this :
#     k => v
#     if !contains(["id", "arn", "name", "parent_id", "tags", "tags_all", "close_on_deletion", "joined_timestamp", "joined_method", "role_name", "email", "status", "iam_user_access_to_billing", "govcloud_id"], k)
#   }
# }
