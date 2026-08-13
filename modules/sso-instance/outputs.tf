output "region" {
  description = "The AWS region this module resources resides in."
  value       = data.aws_ssoadmin_instances.this.region
}

output "arn" {
  description = "The Amazon Resource Name (ARN) of the SSO Instance."
  value       = local.sso_instance_arn
}

output "identity_store_id" {
  description = "The identifier of the identity store connected to the SSO Instance."
  value       = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
}

output "name" {
  description = "The name of the SSO Instance."
  value       = awscc_sso_instance.this.name
}

output "owner" {
  description = "The AWS account ID of the owner of the SSO Instance."
  value       = awscc_sso_instance.this.owner_account_id
}

output "status" {
  description = "The status of the SSO Instance."
  value       = awscc_sso_instance.this.status
}

output "access_control_attributes" {
  description = "A map of attributes for access control are used in permission policies that determine who in an identity source can access your AWS resources."
  value = (length(aws_ssoadmin_instance_access_control_attributes.this[*]) > 0
    ? {
      for attr in aws_ssoadmin_instance_access_control_attributes.this[0].attribute :
      attr.key => tolist(tolist(attr.value)[0].source)[0]
    }
    : {}
  )
}

output "access_control_attributes_status" {
  description = "The status of ID of the Instance Access Control Attribute `instance_arn`."
  value       = one(aws_ssoadmin_instance_access_control_attributes.this[*].status)
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
