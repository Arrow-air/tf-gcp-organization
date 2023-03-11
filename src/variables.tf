variable "tf_project" {
  type = string
}
variable "gcp_billing_account" {
  type      = string
  sensitive = true
}
variable "gcp_org_id" {
  type      = number
  sensitive = true
}
