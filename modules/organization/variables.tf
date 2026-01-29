variable "name" {
  description = "(Required) The name of the Organization."
  type        = string
  nullable    = false
}

variable "all_features_enabled" {
  description = "(Optional) Whether to create AWS Organization with all features or only consolidated billing feature. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}

variable "trusted_access_enabled_service_principals" {
  description = "(Optional) List of AWS service principal names for which you want to enable integration with the organization. This is typically in the form of a URL, such as service-abbreviation.amazonaws.com. Organization must `all_featrues_enabled` set to true."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "enabled_policy_types" {
  description = "(Optional) A set of Organizations Policy types to enable in the Organization Root. Organization must enable all features. Valid values are `AISERVICES_OPT_OUT_POLICY`, `BACKUP_POLICY`, `BEDROCK_POLICY`, `CHATBOT_POLICY`, `DECLARATIVE_POLICY_EC2`, `INSPECTOR_POLICY`, `NETWORK_SECURITY_DIRECTOR_POLICY`, `RESOURCE_CONTROL_POLICY`, `SECURITYHUB_POLICY`, `SERVICE_CONTROL_POLICY`, `S3_POLICY`, `TAG_POLICY`, `UPGRADE_ROLLOUT_POLICY`."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition = alltrue([
      for policy_type in var.enabled_policy_types :
      contains([
        "AISERVICES_OPT_OUT_POLICY",
        "BACKUP_POLICY",
        "BEDROCK_POLICY",
        "CHATBOT_POLICY",
        "DECLARATIVE_POLICY_EC2",
        "INSPECTOR_POLICY",
        "NETWORK_SECURITY_DIRECTOR_POLICY",
        "RESOURCE_CONTROL_POLICY",
        "SECURITYHUB_POLICY",
        "SERVICE_CONTROL_POLICY",
        "S3_POLICY",
        "TAG_POLICY",
        "UPGRADE_ROLLOUT_POLICY",
      ], policy_type)
    ])
    error_message = "Valid values for `enabled_policy_types` are `AISERVICES_OPT_OUT_POLICY`, `BACKUP_POLICY`, `BEDROCK_POLICY`, `CHATBOT_POLICY`, `DECLARATIVE_POLICY_EC2`, `INSPECTOR_POLICY`, `NETWORK_SECURITY_DIRECTOR_POLICY`, `RESOURCE_CONTROL_POLICY`, `SECURITYHUB_POLICY`, `SERVICE_CONTROL_POLICY`, `S3_POLICY`, `TAG_POLICY`, `UPGRADE_ROLLOUT_POLICY`."
  }
}

variable "policies" {
  description = "(Optional) List of IDs of the policies to be attached to the Organization."
  type        = list(string)
  default     = []
  nullable    = false
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
