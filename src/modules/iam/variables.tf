variable "gcp_project" {
  type = string
}

variable "roles" {
  type        = map(map(string))
  description = "List of roles to be assigned to the listed members of given type."
}

variable "default_roles" {
  type = map(map(string))

  default = {}
}

variable "org_roles" {
  type        = map(map(string))
  description = "List of organization roles to be assigned to the listed members of given type."
  default     = {}
}

variable "org_id" {
  type        = string
  description = "Organization ID to apply org_roles to"
}
