variable "org_id" {
  type        = string
  description = "Organization ID to apply org_roles to"
}

variable "prefix" {
  type        = string
  description = "Organization prefix"
  default     = "arw"
}

variable "folder_id" {
  type = map(string)
}

variable "org_role_bindings" {
  type        = map(map(map(map(string))))
  description = "Map of pre-made GCP role bindings applied on the organization level"
  default     = {}
}

variable "custom_org_role_bindings" {
  type        = map(map(map(map(string))))
  description = "Map of custom role bindings applied on the organization level"
  default     = {}
}

variable "folders_role_bindings" {
  type        = map(map(map(map(string))))
  description = "Map of role bindings applied on the folders level"
  default     = {}
}


