variable "region" {
  description = "(Optional) The region in which to create the module resources. If not provided, the module resources will be created in the provider's configured region."
  type        = string
  default     = null
  nullable    = true
}

variable "attributes" {
  description = "(Optional) A map of attributes for access control are used in permission policies that determine who in an identity source can access your AWS resources."
  type        = map(string)
  default     = {}
  nullable    = false
}
