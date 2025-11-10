output "id" {
  description = "The ID of the Organization Policy."
  value       = aws_organizations_policy.this.id
}

output "arn" {
  description = "The Amazon Resource Name (ARN) of the Organization Policy."
  value       = aws_organizations_policy.this.arn
}

output "name" {
  description = "The name of the Organization Policy."
  value       = aws_organizations_policy.this.name
}

output "description" {
  description = "The description of the Organization Policy."
  value       = aws_organizations_policy.this.description
}

output "type" {
  description = "The type of the Organization Policy."
  value       = aws_organizations_policy.this.type
}

# output "content" {
#   description = "The content of the Organization Policy."
#   value       = aws_organizations_policy.this.content
# }

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
#     for k, v in aws_organizations_policy.this :
#     k => v
#     if !contains(["id", "arn", "name", "description", "type", "tags", "tags_all"], k)
#   }
# }
