# sso-instance

This module creates following resources.

- `aws_ssoadmin_instance_access_control_attributes`
- `aws_ssoadmin_region` (optional)
- `aws_ssoadmin_trusted_token_issuer` (optional)
- `awscc_sso_instance` (requires import)

> [!NOTE]
> IAM Identity Center allows only one Region add or remove operation at a time for an instance. When changing multiple additional Regions, apply with `-parallelism=1`.

Import the existing IAM Identity Center instance before planning:

```shell
terraform import 'module.<name>.awscc_sso_instance.this' <instance-arn>
```

Trusted Token Issuer:

```hcl
trusted_token_issuers = [
  {
    name = "example"
    oidc_jwt = {
      claim_attribute_path          = "email"
      identity_store_attribute_path = "emails.value"
      issuer_url                    = "https://idp.example.com"
    }
  }
]
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.54 |
| <a name="requirement_awscc"></a> [awscc](#requirement\_awscc) | >= 1.85 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.59.0 |
| <a name="provider_awscc"></a> [awscc](#provider\_awscc) | 1.97.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.12.0 |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_ssoadmin_instance_access_control_attributes.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_instance_access_control_attributes) | resource |
| [aws_ssoadmin_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_region) | resource |
| [aws_ssoadmin_trusted_token_issuer.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_trusted_token_issuer) | resource |
| [awscc_sso_instance.this](https://registry.terraform.io/providers/hashicorp/awscc/latest/docs/resources/sso_instance) | resource |
| [aws_ssoadmin_instances.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssoadmin_instances) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name you want to assign to this Identity Center (SSO) Instance. | `string` | n/a | yes |
| <a name="input_access_control_attributes"></a> [access\_control\_attributes](#input\_access\_control\_attributes) | (Optional) A map of attributes for access control are used in permission policies that determine who in an identity source can access your AWS resources. | `map(string)` | `{}` | no |
| <a name="input_additional_regions"></a> [additional\_regions](#input\_additional\_regions) | (Optional) A set of additional AWS Regions to add to the IAM Identity Center instance. | `set(string)` | `[]` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | (Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region. | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.<br/>    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.<br/>    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.<br/>    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`. | <pre>object({<br/>    enabled     = optional(bool, true)<br/>    name        = optional(string, "")<br/>    description = optional(string, "Managed by Terraform.")<br/>  })</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_trusted_token_issuers"></a> [trusted\_token\_issuers](#input\_trusted\_token\_issuers) | (Optional) A list of IAM Identity Center Trusted Token Issuers. `trusted_token_issuers` block as defined below.<br/>    (Required) `name` - The trusted token issuer name.<br/>    (Required) `oidc_jwt` - OIDC JWT configuration.<br/>      (Required) `claim_attribute_path` - The path of the source attribute in the JWT from the trusted token issuer.<br/>      (Required) `identity_store_attribute_path` - The path of the destination attribute in a JWT from IAM Identity Center. The attribute mapped by this JMESPath expression is compared against the attribute mapped by `claim_attribute_path` when a trusted token issuer token is exchanged for an IAM Identity Center token.<br/>      (Required) `issuer_url` - The URL that IAM Identity Center uses for OpenID Discovery. OpenID Discovery is used to obtain the information required to verify the tokens that the trusted token issuer generates.<br/>      (Optional) `jwks_retrieval_option` - The method that the trusted token issuer can use to retrieve the JSON Web Key Set used to verify a JWT. Valid values are `OPEN_ID_DISCOVERY`. Defaults to `OPEN_ID_DISCOVERY`.<br/>    (Optional) `tags` - A map of tags to add to the trusted token issuer. | <pre>list(object({<br/>    name = string<br/>    oidc_jwt = object({<br/>      claim_attribute_path          = string<br/>      identity_store_attribute_path = string<br/>      issuer_url                    = string<br/>      jwks_retrieval_option         = optional(string, "OPEN_ID_DISCOVERY")<br/>    })<br/>    tags = optional(map(string), {})<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_access_control_attributes"></a> [access\_control\_attributes](#output\_access\_control\_attributes) | A map of attributes for access control are used in permission policies that determine who in an identity source can access your AWS resources. |
| <a name="output_access_control_attributes_status"></a> [access\_control\_attributes\_status](#output\_access\_control\_attributes\_status) | The status of ID of the Instance Access Control Attribute `instance_arn`. |
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) of the SSO Instance. |
| <a name="output_identity_store_id"></a> [identity\_store\_id](#output\_identity\_store\_id) | The identifier of the identity store connected to the SSO Instance. |
| <a name="output_name"></a> [name](#output\_name) | The name of the SSO Instance. |
| <a name="output_owner"></a> [owner](#output\_owner) | The AWS account ID of the owner of the SSO Instance. |
| <a name="output_region"></a> [region](#output\_region) | The AWS region this module resources resides in. |
| <a name="output_resource_group"></a> [resource\_group](#output\_resource\_group) | The resource group created to manage resources in this module. |
| <a name="output_status"></a> [status](#output\_status) | The status of the SSO Instance. |
| <a name="output_trusted_token_issuers"></a> [trusted\_token\_issuers](#output\_trusted\_token\_issuers) | A list of IAM Identity Center Trusted Token Issuers. |
<!-- END_TF_DOCS -->
