# sso-account-assignment

This module creates following resources.

- `aws_ssoadmin_account_assignment`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.12 |
| <a name="requirement_telemetry"></a> [telemetry](#requirement\_telemetry) | >= 0.2.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.12 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_ssoadmin_account_assignment.groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_account_assignment) | resource |
| [aws_ssoadmin_account_assignment.users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_account_assignment) | resource |
| [aws_identitystore_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/identitystore_group) | data source |
| [aws_identitystore_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/identitystore_user) | data source |
| [aws_ssoadmin_instances.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssoadmin_instances) | data source |
| [aws_ssoadmin_permission_set.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssoadmin_permission_set) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | (Required) The identifier of an AWS account which the assignment willb e created. Typically a 10-12 digit string. | `string` | n/a | yes |
| <a name="input_permission_set_arn"></a> [permission\_set\_arn](#input\_permission\_set\_arn) | (Required) The ARN of the Permission Set that the admin wants to grant the principal access to. | `string` | n/a | yes |
| <a name="input_groups"></a> [groups](#input\_groups) | (Optional) A set of names of Group entities who can access to the Permission Set. | `set(string)` | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | (Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region. | `string` | `null` | no |
| <a name="input_telemetry"></a> [telemetry](#input\_telemetry) | (Optional) A configuration to collect telemetry data for the module. This is used to improve the module and its features. To send pseudonyms instead of identifying values such as the hostname and the Git remote, set `pseudonymization_enabled` to `true`. Pseudonyms are not anonymous; to keep data from being sent, disable its collector. The default configuration enables telemetry collection for machine, network, git, github, github actions, HCP Terraform, terraform, and toolchain. You can disable telemetry collection by setting `enabled` to `false`. `telemetry` block as defined below.<br/>    (Optional) `enabled` - Whether to enable telemetry collection. Default is `true`.<br/>    (Optional) `capture_machine` - Whether to capture machine information. Default is `true`.<br/>    (Optional) `capture_network` - Whether to capture network information. Default is `true`.<br/>    (Optional) `capture_git` - Whether to capture git information. Default is `true`.<br/>    (Optional) `capture_github` - Whether to capture GitHub information. Default is `true`.<br/>    (Optional) `capture_github_actions` - Whether to capture GitHub Actions information. Default is `true`.<br/>    (Optional) `capture_hcp_terraform` - Whether to capture HCP Terraform information. Default is `true`.<br/>    (Optional) `capture_terraform` - Whether to capture Terraform information. Default is `true`.<br/>    (Optional) `capture_toolchain` - Whether to capture toolchain information. Default is `true`.<br/>    (Optional) `pseudonymization_enabled` - Whether to enable pseudonymization of the captured data. Default is `false`. | <pre>object({<br/>    enabled = optional(bool, true)<br/><br/>    capture_machine        = optional(bool, true)<br/>    capture_network        = optional(bool, true)<br/>    capture_git            = optional(bool, true)<br/>    capture_github         = optional(bool, true)<br/>    capture_github_actions = optional(bool, true)<br/>    capture_hcp_terraform  = optional(bool, true)<br/>    capture_terraform      = optional(bool, true)<br/>    capture_toolchain      = optional(bool, true)<br/><br/>    pseudonymization_enabled = optional(bool, false)<br/>  })</pre> | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | (Optional) How long to wait for the account assignment to be created/deleted. | <pre>object({<br/>    create = optional(string, "5m")<br/>    delete = optional(string, "5m")<br/>  })</pre> | `{}` | no |
| <a name="input_users"></a> [users](#input\_users) | (Optional) A set of names of User entities who can access to the Permission Set. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_account_id"></a> [account\_id](#output\_account\_id) | The identifier of an AWS account. |
| <a name="output_group_assignments"></a> [group\_assignments](#output\_group\_assignments) | A set of groups who can access to the Permission Set. |
| <a name="output_identity_store_id"></a> [identity\_store\_id](#output\_identity\_store\_id) | The ID of SSO Identity Store. |
| <a name="output_instance_arn"></a> [instance\_arn](#output\_instance\_arn) | The Amazon Resource Name (ARN) of the SSO Instance. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Account Assignment. |
| <a name="output_permission_set"></a> [permission\_set](#output\_permission\_set) | The Amazon Resource Name (ARN) of the Permission Set |
| <a name="output_region"></a> [region](#output\_region) | The AWS region this module resources resides in. |
| <a name="output_user_assignments"></a> [user\_assignments](#output\_user\_assignments) | A set of users who can access to the Permission Set. |
<!-- END_TF_DOCS -->
