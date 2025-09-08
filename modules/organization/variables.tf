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
  description = "(Optional) A set of Organizations Policy types to enable in the Organization Root. Organization must enable all features. Valid values are `AISERVICES_OPT_OUT_POLICY`, `BACKUP_POLICY`, `CHATBOT_POLICY`, `DECLARATIVE_POLICY_EC2`, `RESOURCE_CONTROL_POLICY`, `SECURITYHUB_POLICY`, `SERVICE_CONTROL_POLICY`, `TAG_POLICY`."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition = alltrue([
      for policy_type in var.enabled_policy_types :
      contains([
        "AISERVICES_OPT_OUT_POLICY",
        "BACKUP_POLICY",
        "CHATBOT_POLICY",
        "DECLARATIVE_POLICY_EC2",
        "RESOURCE_CONTROL_POLICY",
        "SECURITYHUB_POLICY",
        "SERVICE_CONTROL_POLICY",
        "TAG_POLICY"
      ], policy_type)
    ])
    error_message = "Valid values for `enabled_policy_types` are `AISERVICES_OPT_OUT_POLICY`, `BACKUP_POLICY`, `CHATBOT_POLICY`, `DECLARATIVE_POLICY_EC2`, `RESOURCE_CONTROL_POLICY`, `SECURITYHUB_POLICY`, `SERVICE_CONTROL_POLICY`, `TAG_POLICY`."
  }
}

variable "policies" {
  description = "(Optional) List of IDs of the policies to be attached to the Organization."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "module_tags_enabled" {
  description = "(Optional) Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
  nullable    = false
}
