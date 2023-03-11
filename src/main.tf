locals {
  workspace_split = split("-", terraform.workspace)
  pod             = local.workspace_split[0]
  region          = local.workspace_split[1]

  prefix              = "arw"
  org_id              = var.gcp_org_id
  gcp_billing_account = var.gcp_billing_account

  projects      = module.vars.merged.projects
  default_roles = module.vars.merged.default_roles
}

resource "google_folder" "pod_region" {
  display_name = format("%s %s", title(local.pod), upper(local.region))
  parent       = format("organizations/%s", local.org_id)
}

module "vars" {
  source = "./modules/vars"

  prefix              = local.prefix
  pod                 = local.pod
  region              = local.region
  org_id              = local.org_id
  gcp_billing_account = local.gcp_billing_account

  depends_on = [google_folder.pod_region]
}

################################################
#
# Create org folder and projects
#
################################################

module "project" {
  source = "./modules/project"
  #version = "~> 1.0.0"

  pod    = local.pod
  region = local.region
  prefix = local.prefix

  projects = local.projects
}

module "iam" {
  for_each = module.project.project_map

  source = "./modules/iam"

  gcp_project   = each.value.project.project_id
  org_id        = local.org_id
  default_roles = local.default_roles
  roles = {
    "roles/owner" = {
      (each.value.tf_service_account.email) = "serviceAccount"
    }
  }

  depends_on = [module.project]
}
