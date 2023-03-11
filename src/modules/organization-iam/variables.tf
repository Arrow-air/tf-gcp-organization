variable "org_id" {
  type        = string
  description = "Organization ID to apply org_roles to"
  sensitive   = true
}

variable "custom_org_roles" {
  description = "Map of custom roles to be created on the organization level"
  type = map(object({
    title       = string
    description = string
    permissions = list(string)
  }))
  default = {}
}
