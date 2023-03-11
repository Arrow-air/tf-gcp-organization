data "google_active_folder" "folder" {
  display_name = format("%s %s", title(var.owner), upper(var.region))
  parent       = format("organizations/%s", var.org_id)
}

locals {
  regions = {
    "services-global" = {
      default_roles = {
        "viewer" = {
          members = {
            "group-devops@arrowair.com" = "group"
          }
        }
      }
      projects = {
        "all-org" = {
          gcp_project_name    = format("Services Global All Org")
          gcp_billing_account = nonsensitive(var.gcp_billing_account)
          gcp_folder_id       = data.google_active_folder.folder.name
          cicd_project_id     = format("%s-%s-%s-all-org", var.prefix, var.owner, var.region)
          environment         = "all"
          project             = "org"
          labels = {
            environment = "all"
            project     = "org"
          }
          deployer_token_creators = {
            "group-devops@arrowair.com" = "group"
          }
          planner_token_creators = {
            "group-services@arrowair.com" = "group"
            "group-devops@arrowair.com"   = "group"
          }
        }
      }
    }
  }

  merged = local.regions[format("%s-%s", var.owner, var.region)]
}
