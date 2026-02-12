output "name" {
  description = "The name of the Organizational Unit."
  value       = aws_organizations_organizational_unit.this.name
}

output "id" {
  description = "The ID of the Organizational Unit."
  value       = aws_organizations_organizational_unit.this.id
}

output "arn" {
  description = "The Amazon Resource Name (ARN) of the Organizational Unit."
  value       = aws_organizations_organizational_unit.this.arn
}

output "parent_id" {
  description = "The ID of the parent Organizational Unit."
  value       = aws_organizations_organizational_unit.this.parent_id
}

output "accounts" {
  description = "The accounts for the Organizational Unit."
  value       = aws_organizations_organizational_unit.this.accounts
}

output "policies" {
  description = "A set of policy IDs attached to the Organization Unit."
  value       = values(aws_organizations_policy_attachment.this)[*].policy_id
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
#     for k, v in aws_organizations_organizational_unit.this :
#     k => v
#     if !contains(["id", "arn", "accounts", "name", "parent_id", "tags", "tags_all"], k)
#   }
# }
