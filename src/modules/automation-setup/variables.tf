#------------------------------------------------------------------------------------------------------------------------
#
# Generic variables
#
#------------------------------------------------------------------------------------------------------------------------
variable "prefix" {
  description = "Company naming prefix, ensures uniqueness of project ids"
  type        = string
}

variable "owner" {
  description = "Arrow owner (pod) name"
  type        = string
}

variable "region" {
  description = "Arrow region for which the resources are created (e.g. global, us, eu, asia)."
  type        = string
}

variable "environment" {
  description = "Arrow environment for which the resources are created (e.g. dev, tst, dmo, stg, prd, all)."
  type        = string
}

variable "project" {
  description = "Arrow project name"
  type        = string
}

variable "repo_name" {
  description = "Arrow GitHub repository name. Used to provide access through workload identity"
  type        = string
}


variable "cicd_project_id" {
  description = "CICD GCP Project ID"
  type        = string
}

variable "workload_identity_pool_name" {
  description = "The name of the workload identity to be used for GitHub SA assignment"
  type        = string
}

variable "deployer_token_creators" {
  description = "Map of entities which should be allowed to generate tokens for the Terraform SA"
  type        = map(string)
  default     = {}
}

variable "planner_token_creators" {
  description = "Map of entities which should be allowed to generate tokens for the Terraform Planner SA"
  type        = map(string)
  default     = {}
}

variable "state_bucket_roles" {
  description = "Optional map of additional roles to be provided to members"
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
