# account

This module creates following resources.

- `aws_organizations_account`
- `aws_organizations_policy_attachment` (optional)
- `aws_organizations_delegated_administrator` (optional)
- `aws_fms_admin_account` (optional)
- `aws_guardduty_organization_admin_account` (optional)
- `aws_securityhub_organization_admin_account` (optional)
- `aws_vpc_ipam_organization_admin_account` (optional)
- `aws_account_primary_contact` (optional)
- `aws_account_alternate_contact` (optional)
- `aws_account_region` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.45.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.10.0 |

## Resources

| Name | Type |
|------|------|
| [aws_account_alternate_contact.billing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_alternate_contact) | resource |
| [aws_account_alternate_contact.operation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_alternate_contact) | resource |
| [aws_account_alternate_contact.security](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_alternate_contact) | resource |
| [aws_account_primary_contact.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_primary_contact) | resource |
| [aws_account_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_region) | resource |
| [aws_auditmanager_organization_admin_account_registration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/auditmanager_organization_admin_account_registration) | resource |
| [aws_detective_organization_admin_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/detective_organization_admin_account) | resource |
| [aws_fms_admin_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fms_admin_account) | resource |
| [aws_guardduty_organization_admin_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_organization_admin_account) | resource |
| [aws_organizations_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |
| [aws_organizations_delegated_administrator.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_delegated_administrator) | resource |
| [aws_organizations_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_securityhub_organization_admin_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_organization_admin_account) | resource |
| [aws_vpc_ipam_organization_admin_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_organization_admin_account) | resource |
| [aws_organizations_organization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_email"></a> [email](#input\_email) | (Required) The email address of the owner to assign to the new member account. This email address must not already be associated with another AWS account. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) A friendly name for the member account. | `string` | n/a | yes |
| <a name="input_additional_regions"></a> [additional\_regions](#input\_additional\_regions) | (Optional) A set of regions to enable in the account. | `set(string)` | `[]` | no |
| <a name="input_billing_contact"></a> [billing\_contact](#input\_billing\_contact) | (Optional) The configuration of the billing contact for the AWS Account. `billing_contact` as defined below.<br>    (Required) `name` - The name of the billing contact.<br>    (Optional) `title` - The tile of the billing contact. Defaults to `Billing Manager`.<br>    (Required) `email` - The email address of the billing contact.<br>    (Required) `phone` - The phone number of the billing contact. | <pre>object({<br>    name  = string<br>    title = optional(string, "Billing Manager")<br>    email = string<br>    phone = string<br>  })</pre> | `null` | no |
| <a name="input_close_on_delete"></a> [close\_on\_delete](#input\_close\_on\_delete) | (Optional) Whether to close the account on deletion. It will only remove from the organization if true. This is not supported for GovCloud accounts. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_delegated_services"></a> [delegated\_services](#input\_delegated\_services) | (Optional) A list of service principals of the AWS service for which you want to make the member account a delegated administrator. | `set(string)` | `[]` | no |
| <a name="input_iam_user_access_to_billing_allowed"></a> [iam\_user\_access\_to\_billing\_allowed](#input\_iam\_user\_access\_to\_billing\_allowed) | (Optional) If true, the new account enables IAM users to access account billing information if they have the required permissions. If false, then only the root user of the new account can access account billing information. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_operation_contact"></a> [operation\_contact](#input\_operation\_contact) | (Optional) The configuration of the operation contact for the AWS Account. `operation_contact` as defined below.<br>    (Required) `name` - The name of the operation contact.<br>    (Optional) `title` - The tile of the operation contact. Defaults to `Operation Manager`.<br>    (Required) `email` - The email address of the operation contact.<br>    (Required) `phone` - The phone number of the operation contact. | <pre>object({<br>    name  = string<br>    title = optional(string, "Operation Manager")<br>    email = string<br>    phone = string<br>  })</pre> | `null` | no |
| <a name="input_parent_id"></a> [parent\_id](#input\_parent\_id) | (Optional) Parent Organizational Unit ID or Root ID for the account. Defaults to the Organization default Root ID. | `string` | `null` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | (Optional) List of IDs of the policies to be attached to the Account. | `list(string)` | `[]` | no |
| <a name="input_preconfigured_administrator_role_name"></a> [preconfigured\_administrator\_role\_name](#input\_preconfigured\_administrator\_role\_name) | (Optional) The name of an IAM role that Organizations automatically preconfigures in the new member account. This role trusts the master account, allowing users in the master account to assume the role, as permitted by the master account administrator. The role has administrator permissions in the new member account. Defaults to `OrganizationAccountAccessRole`. | `string` | `"OrganizationAccountAccessRole"` | no |
| <a name="input_primary_contact"></a> [primary\_contact](#input\_primary\_contact) | (Optional) The configuration of the primary contact for the AWS Account. `primary_contact` as defined below.<br>    (Required) `name` - The full name of the primary contact address.<br>    (Optional) `company_name` - The name of the company associated with the primary contact information, if any.<br>    (Required) `country_code` - The ISO-3166 two-letter country code for the primary contact address.<br>    (Optional) `state` - The state or region of the primary contact address. This field is required in selected countries.<br>    (Required) `city` - The city of the primary contact address.<br>    (Optional) `district` - The district or county of the primary contact address, if any.<br>    (Required) `address_line_1` - The first line of the primary contact address.<br>    (Optional) `address_line_2` - The second line of the primary contact address, if any.<br>    (Optional) `address_line_3` - The third line of the primary contact address, if any.<br>    (Required) `postal_code` - The postal code of the primary contact address.<br>    (Required) `phone` - The phone number of the primary contact information. The number will be validated and, in some countries, checked for activation.<br>    (Optional) `website_url` -  The URL of the website associated with the primary contact information, if any. | <pre>object({<br>    name           = string<br>    company_name   = optional(string, "")<br>    country_code   = string<br>    state          = optional(string, "")<br>    city           = string<br>    district       = optional(string, "")<br>    address_line_1 = string<br>    address_line_2 = optional(string, "")<br>    address_line_3 = optional(string, "")<br>    postal_code    = string<br>    phone          = string<br>    website_url    = optional(string, "")<br>  })</pre> | `null` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_security_contact"></a> [security\_contact](#input\_security\_contact) | (Optional) The configuration of the security contact for the AWS Account. `security_contact` as defined below.<br>    (Required) `name` - The name of the security contact.<br>    (Optional) `title` - The tile of the security contact. Defaults to `Security Manager`.<br>    (Required) `email` - The email address of the security contact.<br>    (Required) `phone` - The phone number of the security contact. | <pre>object({<br>    name  = string<br>    title = optional(string, "Security Manager")<br>    email = string<br>    phone = string<br>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_regions"></a> [additional\_regions](#output\_additional\_regions) | A set of additional regions enabled in the account. |
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) of this account. |
| <a name="output_billing_contact"></a> [billing\_contact](#output\_billing\_contact) | The billing contact attached to an AWS Account. |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | The datetime which this account joined to the organization. |
| <a name="output_created_by"></a> [created\_by](#output\_created\_by) | The method how this account joined to the organization. |
| <a name="output_delegated_services"></a> [delegated\_services](#output\_delegated\_services) | A list of service principals of the AWS service which the member account is a delegated administrator. |
| <a name="output_email"></a> [email](#output\_email) | The email address of this account. |
| <a name="output_govcloud_account_id"></a> [govcloud\_account\_id](#output\_govcloud\_account\_id) | The ID for a GovCloud account created with the account. |
| <a name="output_iam_user_access_to_billing_allowed"></a> [iam\_user\_access\_to\_billing\_allowed](#output\_iam\_user\_access\_to\_billing\_allowed) | Whether accessing account billing information by IAM User is allowed. |
| <a name="output_id"></a> [id](#output\_id) | The ID of this AWS account. |
| <a name="output_name"></a> [name](#output\_name) | The name of this account. |
| <a name="output_operation_contact"></a> [operation\_contact](#output\_operation\_contact) | The operation contact attached to an AWS Account. |
| <a name="output_parent_id"></a> [parent\_id](#output\_parent\_id) | The ID of the parent Organizational Unit. |
| <a name="output_preconfigured_administrator_role_name"></a> [preconfigured\_administrator\_role\_name](#output\_preconfigured\_administrator\_role\_name) | The name of an IAM role that allow users in the master account to assume as administrator. |
| <a name="output_primary_contact"></a> [primary\_contact](#output\_primary\_contact) | The primary contact attached to an AWS Account. |
| <a name="output_security_contact"></a> [security\_contact](#output\_security\_contact) | The security contact attached to an AWS Account. |
| <a name="output_status"></a> [status](#output\_status) | The status of the account in the organization. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
