variable "gcp_project" {
  type = string
}

variable "roles" {
  description = "List of roles to be assigned to the listed members of given type."
  type = map(object({
    members = map(string)
    condition = optional(object({
      expression  = string
      title       = string
      description = optional(string, null)
    }))
  }))
}

variable "org_roles" {
  description = "List of organization roles to be assigned to the listed members of given type."
  type = map(object({
    members = map(string)
    condition = optional(object({
      expression  = string
      title       = string
      description = optional(string, null)
    }))
  }))

  default = {}
}

variable "default_roles" {
  type = map(object({
    members = map(string)
    condition = optional(object({
      expression  = string
      title       = string
      description = optional(string, null)
    }))
  }))

  default = {}
}

variable "org_id" {
  type        = string
  description = "Organization ID to apply org_roles to"
  sensitive   = true
}
