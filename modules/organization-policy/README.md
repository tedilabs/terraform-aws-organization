# organization-policy

This module creates following resources.

- `aws_organizations_policy`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.28.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.12.0 |

## Resources

| Name | Type |
|------|------|
| [aws_organizations_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy) | resource |
| [terraform_data.policy](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [aws_organizations_organization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Organization Policy. | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | (Required) The type of the Organization Policy. Valid values are `AISERVICES_OPT_OUT_POLICY`, `BACKUP_POLICY`, `CHATBOT_POLICY`, `DECLARATIVE_POLICY_EC2`, `RESOURCE_CONTROL_POLICY`, `SECURITYHUB_POLICY`, `SERVICE_CONTROL_POLICY`, `TAG_POLICY`. | `string` | n/a | yes |
| <a name="input_content"></a> [content](#input\_content) | (Optional) The policy content to add to the new policy. This is a JSON formatted string. If you are using `template`, this field will be ignored. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) The description of the Organization Policy. If you are using `template`, defaults to the description defined in the template. | `string` | `""` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.<br/>    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.<br/>    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.<br/>    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`. | <pre>object({<br/>    enabled     = optional(bool, true)<br/>    name        = optional(string, "")<br/>    description = optional(string, "Managed by Terraform.")<br/>  })</pre> | `{}` | no |
| <a name="input_skip_destroy"></a> [skip\_destroy](#input\_skip\_destroy) | (Optional) Whether to skip destroy of the Organization Policy. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_template"></a> [template](#input\_template) | (Optional) A configurations of predefined policy templates. Only one of `content` or `template` can be specified. `template` as defined below.<br/>    (Required) `name` - The name of the predefined policy template.<br/>    (Optional) `parameters` - A map of key-value pairs to customize the policy template. | <pre>object({<br/>    name       = string<br/>    parameters = any<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) of the Organization Policy. |
| <a name="output_description"></a> [description](#output\_description) | The description of the Organization Policy. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Organization Policy. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Organization Policy. |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | The resource group created to manage resources in this module. |
| <a name="output_type"></a> [type](#output\_type) | The type of the Organization Policy. |
<!-- END_TF_DOCS -->
