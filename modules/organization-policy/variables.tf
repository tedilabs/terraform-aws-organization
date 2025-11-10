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

variable "content" {
  description = "(Required) The policy content to add to the new policy. This is a JSON formatted string."
  type        = string
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
