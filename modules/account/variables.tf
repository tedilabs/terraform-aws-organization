variable "name" {
  description = "(Required) A friendly name for the member account."
  type        = string
  nullable    = false
}

variable "email" {
  description = "(Required) The email address of the owner to assign to the new member account. This email address must not already be associated with another AWS account."
  type        = string
  nullable    = false
}

variable "parent_id" {
  description = "(Optional) Parent Organizational Unit ID or Root ID for the account. Defaults to the Organization default Root ID."
  type        = string
  default     = null
  nullable    = true
}

variable "close_on_delete" {
  description = "(Optional) Whether to close the account on deletion. It will only remove from the organization if true. This is not supported for GovCloud accounts. Defaults to `false`."
  default     = false
  type        = bool
  nullable    = false
}

variable "iam_user_access_to_billing_allowed" {
  description = "(Optional) If true, the new account enables IAM users to access account billing information if they have the required permissions. If false, then only the root user of the new account can access account billing information. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "preconfigured_administrator_role_name" {
  description = "(Optional) The name of an IAM role that Organizations automatically preconfigures in the new member account. This role trusts the master account, allowing users in the master account to assume the role, as permitted by the master account administrator. The role has administrator permissions in the new member account. Defaults to `OrganizationAccountAccessRole`."
  type        = string
  default     = "OrganizationAccountAccessRole"
  nullable    = false
}

variable "delegated_services" {
  description = "(Optional) A list of service principals of the AWS service for which you want to make the member account a delegated administrator."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition = alltrue([
      for service in var.delegated_services :
      !contains([
        "macie.amazonaws.com",
        "inspector2.amazonaws.com",
      ], service)
    ])
    error_message = "The following service principals provide delegated administrator functionality on a per-region basis: `inspector2.amazonaws.com`, `macie.amazonaws.com`."
  }
}

variable "policies" {
  description = "(Optional) List of IDs of the policies to be attached to the Account."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "additional_regions" {
  description = "(Optional) A map of additional regions to enable for the account. Each key should be a region name and the value should be `true` to enable the region or `false` to disable it. By default, all regions are disabled."
  type        = map(bool)
  default     = {}
  nullable    = false

  validation {
    condition = alltrue([
      for region in keys(var.additional_regions) :
      contains([
        "af-south-1",
        "ap-east-1",
        "ap-east-2",
        "ap-south-2",
        "ap-southeast-3",
        "ap-southeast-4",
        "ap-southeast-5",
        "ap-southeast-6",
        "ap-southeast-7",
        "ca-west-1",
        "eu-south-1",
        "eu-south-2",
        "eu-central-2",
        "me-south-1",
        "me-central-1",
        "mx-central-1",
        "il-central-1",
      ], region)
    ])
    error_message = "Available regions for `additional_regions` are `af-south-1`, `ap-east-1`, `ap-east-2`, `ap-south-2`, `ap-southeast-3`, `ap-southeast-4`, `ap-southeast-5`, `ap-southeast-6`, `ap-southeast-7`, `ca-west-1`, `eu-south-1`, `eu-south-2`, `eu-central-2`, `me-south-1`, `me-central-1`, `mx-central-1`, `il-central-1`."
  }
}

variable "primary_contact" {
  description = <<EOF
  (Optional) The configuration of the primary contact for the AWS Account. `primary_contact` as defined below.
    (Required) `name` - The full name of the primary contact address.
    (Optional) `company_name` - The name of the company associated with the primary contact information, if any.
    (Required) `country_code` - The ISO-3166 two-letter country code for the primary contact address.
    (Optional) `state` - The state or region of the primary contact address. This field is required in selected countries.
    (Required) `city` - The city of the primary contact address.
    (Optional) `district` - The district or county of the primary contact address, if any.
    (Required) `address_line_1` - The first line of the primary contact address.
    (Optional) `address_line_2` - The second line of the primary contact address, if any.
    (Optional) `address_line_3` - The third line of the primary contact address, if any.
    (Required) `postal_code` - The postal code of the primary contact address.
    (Required) `phone` - The phone number of the primary contact information. The number will be validated and, in some countries, checked for activation.
    (Optional) `website_url` -  The URL of the website associated with the primary contact information, if any.
  EOF
  type = object({
    name           = string
    company_name   = optional(string, "")
    country_code   = string
    state          = optional(string, "")
    city           = string
    district       = optional(string, "")
    address_line_1 = string
    address_line_2 = optional(string, "")
    address_line_3 = optional(string, "")
    postal_code    = string
    phone          = string
    website_url    = optional(string, "")
  })
  nullable = true
  default  = null
}

variable "billing_contact" {
  description = <<EOF
  (Optional) The configuration of the billing contact for the AWS Account. `billing_contact` as defined below.
    (Required) `name` - The name of the billing contact.
    (Optional) `title` - The tile of the billing contact. Defaults to `Billing Manager`.
    (Required) `email` - The email address of the billing contact.
    (Required) `phone` - The phone number of the billing contact.
  EOF
  type = object({
    name  = string
    title = optional(string, "Billing Manager")
    email = string
    phone = string
  })
  nullable = true
  default  = null
}

variable "operation_contact" {
  description = <<EOF
  (Optional) The configuration of the operation contact for the AWS Account. `operation_contact` as defined below.
    (Required) `name` - The name of the operation contact.
    (Optional) `title` - The tile of the operation contact. Defaults to `Operation Manager`.
    (Required) `email` - The email address of the operation contact.
    (Required) `phone` - The phone number of the operation contact.
  EOF
  type = object({
    name  = string
    title = optional(string, "Operation Manager")
    email = string
    phone = string
  })
  nullable = true
  default  = null
}

variable "security_contact" {
  description = <<EOF
  (Optional) The configuration of the security contact for the AWS Account. `security_contact` as defined below.
    (Required) `name` - The name of the security contact.
    (Optional) `title` - The tile of the security contact. Defaults to `Security Manager`.
    (Required) `email` - The email address of the security contact.
    (Required) `phone` - The phone number of the security contact.
  EOF
  type = object({
    name  = string
    title = optional(string, "Security Manager")
    email = string
    phone = string
  })
  nullable = true
  default  = null
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
