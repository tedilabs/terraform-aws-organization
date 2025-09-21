variable "region" {
  description = "(Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region."
  type        = string
  default     = null
  nullable    = true
}

variable "account_id" {
  description = "(Required) The identifier of an AWS account which the assignment willb e created. Typically a 10-12 digit string."
  type        = string
  nullable    = false
}

variable "permission_set_arn" {
  description = "(Required) The ARN of the Permission Set that the admin wants to grant the principal access to."
  type        = string
  nullable    = false
}

variable "groups" {
  description = "(Optional) A set of names of Group entities who can access to the Permission Set."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "users" {
  description = "(Optional) A set of names of User entities who can access to the Permission Set."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "timeouts" {
  description = "(Optional) How long to wait for the account assignment to be created/deleted."
  type = object({
    create = optional(string, "5m")
    delete = optional(string, "5m")
  })
  default  = {}
  nullable = false
}
