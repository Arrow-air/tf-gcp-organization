locals {
  workspace_split = split("-", terraform.workspace)
  owner           = local.workspace_split[0]
  region          = local.workspace_split[1]

  prefix              = "arw"
  org_id              = var.gcp_org_id
  gcp_billing_account = var.gcp_billing_account
  repo_name           = "tf-gcp-organization"

  projects      = module.vars.merged.projects
  default_roles = module.vars.merged.default_roles
  permissions   = module.vars.permissions
}

module "vars" {
  source = "./modules/vars"

  prefix              = local.prefix
  owner               = local.owner
  region              = local.region
  org_id              = local.org_id
  gcp_billing_account = local.gcp_billing_account

  depends_on = [google_folder.owner_region]
}

################################################
#
# Create org folder and projects
#
################################################

resource "google_folder" "owner_region" {
  display_name = format("%s %s", title(local.owner), upper(local.region))
  parent       = format("organizations/%s", local.org_id)
}

module "project" {
  source  = "owlot/project/google"
  version = "~> 0.1.1"

  prefix = format("%s-%s-%s", local.prefix, local.owner, local.region)

  projects = local.projects
  default_labels = {
    "owner"   = local.owner
    "region"  = local.region
    "creator" = "terraform"
  }
}

resource "google_iam_workload_identity_pool" "map" {
  for_each = module.project.project_map

  project                   = each.value.project_id
  workload_identity_pool_id = "automation"
  display_name              = "Automation services"
  description               = "Identity pool for automated tasks"
  disabled                  = false
}

module "automation" {
  for_each = module.project.project_map

  source = "./modules/automation-setup"

  repo_name = local.repo_name
  prefix    = local.prefix
  owner     = local.owner
  region    = local.region

  environment             = local.projects[each.key].environment
  project                 = local.projects[each.key].project
  cicd_project_id         = local.projects[each.key].cicd_project_id
  deployer_token_creators = local.projects[each.key].deployer_token_creators
  planner_token_creators  = local.projects[each.key].planner_token_creators
  state_bucket_roles      = lookup(local.projects[each.key], "state_bucket_roles", {})

  workload_identity_pool_name = google_iam_workload_identity_pool.map[each.key].name
}

module "iam" {
  for_each = module.project.project_map

  source = "./modules/iam"

  gcp_project   = each.value.project_id
  org_id        = local.org_id
  default_roles = local.default_roles
  roles = {
    "owner" = {
      members = {
        (module.automation[each.key].tf_account.email) = "serviceAccount"
      }
    }
    "viewer" = {
      members = {
        "group-devops@arrowair.com"                       = "group"
        format("group-%s@arrowair.com", local.owner)      = "group"
        (module.automation[each.key].tf_ro_account.email) = "serviceAccount"
      }
    }
  }

  org_roles = {
    format("organizations/%s/roles/%s%sTFRO", nonsensitive(local.org_id), title(local.owner), title(local.region)) = {
      members = {
        (module.automation[each.key].tf_account.email)    = "serviceAccount"
        (module.automation[each.key].tf_ro_account.email) = "serviceAccount"
      }
    }
    "resourcemanager.folderAdmin" = {
      members = {
        (module.automation[each.key].tf_account.email) = "serviceAccount"
      }
    }
    "iam.organizationRoleAdmin" = {
      members = {
        (module.automation[each.key].tf_account.email) = "serviceAccount"
      }
    }
    "iam.securityAdmin" = {
      members = {
        (module.automation[each.key].tf_account.email) = "serviceAccount"
      },
      condition = {
        title       = "only_specified_org_roles"
        description = "Only allows changes to role bindings with the specified roles"
        expression  = sensitive(format("api.getAttribute('iam.googleapis.com/modifiedGrantsByRole', []).hasOnly(['roles/resourcemanager.folderAdmin', 'roles/iam.organizationRoleAdmin', 'roles/iam.securityAdmin', '%s'])", module.org_roles.custom_roles[format("%s%sTFRO", title(local.owner), title(local.region))].name))
      }
    }
  }

  depends_on = [module.project, module.org_roles]
}

module "org_roles" {
  source = "./modules/organization-iam"

  org_id = local.org_id

  custom_org_roles = {
    format("%s%sTFRO", title(local.owner), title(local.region)) = {
      title       = format("Terraform Planner %s %s %s", title(local.owner), title(local.region), title(var.tf_project))
      description = "Custom role created by terraform from the tf-gcp-organization GitHub project"
      permissions = distinct(concat(
        local.permissions.cloudkms_ro,
        local.permissions.dns_ro,
        local.permissions.iam_ro,
        local.permissions.logging_ro,
        local.permissions.managedidentities_ro,
        local.permissions.monitoring_ro,
        local.permissions.orgpolicy_ro,
        local.permissions.resourcemanager_ro,
        local.permissions.storage_ro,
      ))
    }
  }
}
