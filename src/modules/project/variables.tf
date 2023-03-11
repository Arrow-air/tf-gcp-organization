#------------------------------------------------------------------------------------------------------------------------
#
# Generic variables
#
#------------------------------------------------------------------------------------------------------------------------
variable "prefix" {
  description = "Company naming prefix, ensures uniqueness of project ids"
  type        = string
}
variable "pod" {
  description = "Arrow Pod name"
  type        = string
}

variable "region" {
  description = "Arrow region for which the resources are created (e.g. global, us, eu, asia)."
  type        = string
}

#------------------------------------------------------------------------------------------------------------------------
#
# Project variables
#
#------------------------------------------------------------------------------------------------------------------------

variable "projects" {
  type = list(object({
    environment = string
    project     = string

    cicd_project_id      = string
    gcp_billing_account  = string
    gcp_folder_id        = optional(string, null)
    can_delete           = optional(bool, false)
    shared_vpc_host      = optional(bool, false)
    shared_vpc_service   = optional(string, null)
    roles                = optional(map(list(map(string))), {})
    services             = optional(list(string), [])
    owner_token_creators = optional(map(string), {})
    labels               = optional(map(string), {})
    state_bucket_roles   = optional(map(map(string)), {})
    audit_log_config     = optional(map(map(map(map(string)))), {})
  }))
  description = "List of projects to be created"
}

variable "default_services" {
  type = list(string)

  default = [
    "compute.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "secretmanager.googleapis.com",
    "cloudkms.googleapis.com",
    "monitoring.googleapis.com"
  ]
}
