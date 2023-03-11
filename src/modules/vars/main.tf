data "google_active_folder" "folder" {
  display_name = format("%s %s", title(var.pod), upper(var.region))
  parent       = format("organizations/%s", var.org_id)
}

locals {
  regions = {
    "services-global" = {
      default_roles = {
        "roles/viewer" = {
          "group-devops@arrowair.com" = "group"
        }
      }
      projects = [
        {
          gcp_billing_account = var.gcp_billing_account
          environment         = "all"
          project             = "org"
          gcp_folder_id       = data.google_active_folder.folder.name
          cicd_project_id     = format("%s-%s-%s-all-org", var.prefix, var.pod, var.region)
          owner_token_creators = {
            "group-devops@arrowair.com" = "group"
          }
        }
      ]
    }
  }

  merged = local.regions[format("%s-%s", var.pod, var.region)]
}
