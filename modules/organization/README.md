# organization

This module creates following resources.

- `aws_organizations_organization`
- `aws_organizations_policy_attachment` (optional)
- `aws_ram_sharing_with_organization` (optional)
- `aws_servicecatalog_organizations_access` (optional)
- `aws_servicequotas_template_association` (optional)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.30.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.12.0 |
| <a name="module_service_linked_role"></a> [service\_linked\_role](#module\_service\_linked\_role) | tedilabs/account/aws//modules/iam-service-linked-role | ~> 0.33.0 |

## Resources

| Name | Type |
|------|------|
| [aws_organizations_organization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization) | resource |
| [aws_organizations_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_ram_sharing_with_organization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_sharing_with_organization) | resource |
| [aws_servicecatalog_organizations_access.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/servicecatalog_organizations_access) | resource |
| [aws_servicequotas_template_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/servicequotas_template_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Organization. | `string` | n/a | yes |
| <a name="input_all_features_enabled"></a> [all\_features\_enabled](#input\_all\_features\_enabled) | (Optional) Whether to create AWS Organization with all features or only consolidated billing feature. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_enabled_policy_types"></a> [enabled\_policy\_types](#input\_enabled\_policy\_types) | (Optional) A set of Organizations Policy types to enable in the Organization Root. Organization must enable all features. Valid values are `AISERVICES_OPT_OUT_POLICY`, `BACKUP_POLICY`, `BEDROCK_POLICY`, `CHATBOT_POLICY`, `DECLARATIVE_POLICY_EC2`, `INSPECTOR_POLICY`, `NETWORK_SECURITY_DIRECTOR_POLICY`, `RESOURCE_CONTROL_POLICY`, `SECURITYHUB_POLICY`, `SERVICE_CONTROL_POLICY`, `S3_POLICY`, `TAG_POLICY`, `UPGRADE_ROLLOUT_POLICY`. | `set(string)` | `[]` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | (Optional) List of IDs of the policies to be attached to the Organization. | `list(string)` | `[]` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.<br/>    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.<br/>    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.<br/>    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`. | <pre>object({<br/>    enabled     = optional(bool, true)<br/>    name        = optional(string, "")<br/>    description = optional(string, "Managed by Terraform.")<br/>  })</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_trusted_access_enabled_service_principals"></a> [trusted\_access\_enabled\_service\_principals](#input\_trusted\_access\_enabled\_service\_principals) | (Optional) List of AWS service principal names for which you want to enable integration with the organization. This is typically in the form of a URL, such as service-abbreviation.amazonaws.com. Organization must `all_featrues_enabled` set to true. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_accounts"></a> [accounts](#output\_accounts) | The accounts for the Organization. |
| <a name="output_all_features_enabled"></a> [all\_features\_enabled](#output\_all\_features\_enabled) | Whether AWS Organization was configured with all features or only consolidated billing feature. |
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) of the Organization. |
| <a name="output_enabled_policy_types"></a> [enabled\_policy\_types](#output\_enabled\_policy\_types) | A set of Organizations Policy types enabled in the Organization Root. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Organization. |
| <a name="output_master_account"></a> [master\_account](#output\_master\_account) | The master account for the Organization. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Organization. |
| <a name="output_non_master_accounts"></a> [non\_master\_accounts](#output\_non\_master\_accounts) | The non-master accounts for the Organization. |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | The resource group created to manage resources in this module. |
| <a name="output_root"></a> [root](#output\_root) | The root information of the Organization. |
| <a name="output_trusted_access_enabled_service_principals"></a> [trusted\_access\_enabled\_service\_principals](#output\_trusted\_access\_enabled\_service\_principals) | List of AWS service principal names which is integrated with the organization. |
<!-- END_TF_DOCS -->
