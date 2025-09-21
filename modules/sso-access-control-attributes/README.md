# sso-access-control-attributes

This module creates following resources.

- `aws_ssoadmin_instance_access_control_attributes`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssoadmin_instance_access_control_attributes.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_instance_access_control_attributes) | resource |
| [aws_ssoadmin_instances.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssoadmin_instances) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | (Optional) A map of attributes for access control are used in permission policies that determine who in an identity source can access your AWS resources. | `map(string)` | `{}` | no |
| <a name="input_region"></a> [region](#input\_region) | (Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_attributes"></a> [attributes](#output\_attributes) | A map of attributes for access control are used in permission policies that determine who in an identity source can access your AWS resources. |
| <a name="output_instance_arn"></a> [instance\_arn](#output\_instance\_arn) | The Amazon Resource Name (ARN) of the SSO Instance. |
| <a name="output_region"></a> [region](#output\_region) | The AWS region this module resources resides in. |
| <a name="output_status"></a> [status](#output\_status) | The status of ID of the Instance Access Control Attribute `instance_arn`. |
<!-- END_TF_DOCS -->
