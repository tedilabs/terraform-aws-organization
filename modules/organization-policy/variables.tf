variable "name" {
  description = "(Required) The name of the Organization Policy."
  type        = string
  nullable    = false
}

variable "description" {
  description = "(Optional) The description of the Organization Policy. Defaults to `Managed by Terraform.`."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "skip_destroy" {
  description = "(Optional) Whether to skip destroy of the Organization Policy. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "type" {
  description = "(Required) The type of the Organization Policy. Valid values are `AISERVICES_OPT_OUT_POLICY`, `BACKUP_POLICY`, `CHATBOT_POLICY`, `DECLARATIVE_POLICY_EC2`, `RESOURCE_CONTROL_POLICY`, `SECURITYHUB_POLICY`, `SERVICE_CONTROL_POLICY`, `TAG_POLICY`."
  type        = string
  nullable    = false

  validation {
    condition = contains([
      "AISERVICES_OPT_OUT_POLICY",
      "BACKUP_POLICY",
      "CHATBOT_POLICY",
      "DECLARATIVE_POLICY_EC2",
      "RESOURCE_CONTROL_POLICY",
      "SECURITYHUB_POLICY",
      "SERVICE_CONTROL_POLICY",
      "TAG_POLICY"
    ], var.type)
    error_message = "Valid values for `type` are `AISERVICES_OPT_OUT_POLICY`, `BACKUP_POLICY`, `CHATBOT_POLICY`, `DECLARATIVE_POLICY_EC2`, `RESOURCE_CONTROL_POLICY`, `SECURITYHUB_POLICY`, `SERVICE_CONTROL_POLICY`, `TAG_POLICY`."
  }
}

variable "policies" {
  description = <<EOF
  (Required) A list of policy configurations to be combined into a single organization policy. Each policy can be either inline JSON content or a predefined template. Each item of `policies` as defined below.
    (Required) `type` - The type of the policy. Valid values are `INLINE`, `TEMPLATE`.
    (Optional) `content` - The policy content in JSON format. Required if `type` is `INLINE`.
    (Optional) `template` - A configuration for predefined policy template. Required if `type` is `TEMPLATE`. `template` as defined below.
      (Required) `name` - The name of the predefined policy template.
      (Optional) `parameters` - A map of key-value pairs to customize the policy template.
  EOF
  type        = any
  nullable    = false

  validation {
    condition     = can(length(var.policies))
    error_message = "The `policies` variable must be a list."
  }
  validation {
    condition = alltrue([
      for policy in var.policies :
      can(policy.type)
    ])
    error_message = "Each policy in `policies` must have a `type` field."
  }
  validation {
    condition = alltrue([
      for policy in var.policies :
      contains(["INLINE", "TEMPLATE"], policy.type)
    ])
    error_message = "Valid values for `type` in each policy are `INLINE`, `TEMPLATE`."
  }
  validation {
    condition = alltrue([
      for policy in var.policies :
      policy.type != "INLINE" || can(policy.content)
    ])
    error_message = "Each policy with `type` = `INLINE` must have a `content` field."
  }
  validation {
    condition = alltrue([
      for policy in var.policies :
      policy.type != "TEMPLATE" || can(policy.template)
    ])
    error_message = "Each policy with `type` = `TEMPLATE` must have a `template` field."
  }
  validation {
    condition = alltrue([
      for policy in var.policies :
      policy.type != "TEMPLATE" || can(policy.template.name)
    ])
    error_message = "Each policy with `type` = `TEMPLATE` must have a `template.name` field."
  }
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
