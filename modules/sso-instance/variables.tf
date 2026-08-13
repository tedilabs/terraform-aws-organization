variable "region" {
  description = "(Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region."
  type        = string
  default     = null
  nullable    = true
}

variable "name" {
  description = "(Required) The name you want to assign to this Identity Center (SSO) Instance."
  type        = string
  nullable    = false
}

variable "access_control_attributes" {
  description = "(Optional) A map of attributes for access control are used in permission policies that determine who in an identity source can access your AWS resources."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "additional_regions" {
  description = "(Optional) A set of additional AWS Regions to add to the IAM Identity Center instance."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "trusted_token_issuers" {
  description = <<EOF
  (Optional) A list of IAM Identity Center Trusted Token Issuers. `trusted_token_issuers` block as defined below.
    (Required) `name` - The trusted token issuer name.
    (Required) `oidc_jwt` - OIDC JWT configuration.
      (Required) `claim_attribute_path` - The path of the source attribute in the JWT from the trusted token issuer.
      (Required) `identity_store_attribute_path` - The path of the destination attribute in a JWT from IAM Identity Center. The attribute mapped by this JMESPath expression is compared against the attribute mapped by `claim_attribute_path` when a trusted token issuer token is exchanged for an IAM Identity Center token.
      (Required) `issuer_url` - The URL that IAM Identity Center uses for OpenID Discovery. OpenID Discovery is used to obtain the information required to verify the tokens that the trusted token issuer generates.
      (Optional) `jwks_retrieval_option` - The method that the trusted token issuer can use to retrieve the JSON Web Key Set used to verify a JWT. Valid values are `OPEN_ID_DISCOVERY`. Defaults to `OPEN_ID_DISCOVERY`.
    (Optional) `tags` - A map of tags to add to the trusted token issuer.
  EOF
  type = list(object({
    name = string
    oidc_jwt = object({
      claim_attribute_path          = string
      identity_store_attribute_path = string
      issuer_url                    = string
      jwks_retrieval_option         = optional(string, "OPEN_ID_DISCOVERY")
    })
    tags = optional(map(string), {})
  }))
  default  = []
  nullable = false
}

variable "tags" {
  description = "(Optional) A map of tags to add to all resources."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "module_tags_enabled" {
  description = "(Optional) Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
  nullable    = false
}


###################################################
# Resource Group
###################################################

variable "resource_group" {
  description = <<EOF
  (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.
    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.
    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.
    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`.
  EOF
  type = object({
    enabled     = optional(bool, true)
    name        = optional(string, "")
    description = optional(string, "Managed by Terraform.")
  })
  default  = {}
  nullable = false
}
