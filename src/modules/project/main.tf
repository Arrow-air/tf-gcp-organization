locals {
  prefix = var.prefix
  pod    = var.pod
  region = var.region

  projects = { for settings in var.projects : replace(format("%s-%s-%s-%s-%s", local.prefix, local.pod, local.region, settings.environment, settings.project), " ", "-") => merge(
    settings,
    {
      services           = distinct(concat(var.default_services, settings.services))
      gcp_project_name   = format("%s %s %s %s", title(local.pod), upper(local.region), settings.environment, title(settings.project))
      state_bucket_roles = { for role, members in settings.state_bucket_roles : role => [for member, type in members : format("%s:%s", type, member)] }
      labels = merge(settings.labels, {
        "pod"         = substr(replace(lower(local.pod), "/[^\\p{Ll}\\p{Lo}\\p{N}_-]+/", "_"), 0, 63)
        "region"      = substr(replace(lower(local.region), "/[^\\p{Ll}\\p{Lo}\\p{N}_-]+/", "_"), 0, 63)
        "environment" = substr(replace(lower(settings.environment), "/[^\\p{Ll}\\p{Lo}\\p{N}_-]+/", "_"), 0, 63)
        "project"     = substr(replace(lower(settings.project), "/[^\\p{Ll}\\p{Lo}\\p{N}_-]+/", "_"), 0, 63)
        "creator"     = "terraform"
      })
    })
  }

  project_services = flatten([for project, data in google_project.map :
    [
      for service in local.projects[project].services : { "${project}|${service}" = { service = service, project = data.project_id } }
    ]
  ])

  project_audit_configs = flatten([for project, data in google_project.map :
    [
      for service, settings in local.projects[project].audit_log_config : { "${project}|${service}" = { service = service, project = data.project_id, audit_log_config = settings } }
    ]
  ])
}

# ==========================================
# Project creation
# ==========================================
resource "google_project" "map" {
  for_each = local.projects

  project_id      = each.key
  name            = each.value.gcp_project_name
  folder_id       = each.value.gcp_folder_id
  billing_account = each.value.gcp_billing_account

  labels = each.value.labels

  auto_create_network = false
}

# Also enable project services
resource "google_project_service" "map" {
  for_each = { for service in local.project_services : keys(service)[0] => values(service)[0] }

  project = each.value.project
  service = each.value.service
}

# ==========================================
# Audit config
# ==========================================
resource "google_project_iam_audit_config" "map" {
  for_each = { for service in local.project_audit_configs : keys(service)[0] => values(service)[0] }

  project = each.value.project
  service = each.value.service

  dynamic "audit_log_config" {
    for_each = each.value.audit_log_config
    iterator = config

    content {
      log_type         = config.key
      exempted_members = [for member, type in try(config.value.exempted_members, {}) : format("%s:%s", type, member)]
    }
  }
}

# ==========================================
# Project lien
# ==========================================
resource "google_resource_manager_lien" "lien" {
  for_each = { for project, settings in local.projects : project => settings if settings.can_delete == false }

  parent       = "projects/${google_project.map[each.key].number}"
  restrictions = ["resourcemanager.projects.delete"]
  origin       = "Arrow Air - project module"
  reason       = "Arrow Air - protect projects from delete"
}

# ==========================================
# Create SA to manage the new project in
# CICD runners account
# ==========================================

resource "google_service_account" "map" {
  for_each = google_project.map

  account_id   = format("tf-%s", replace(each.value.project_id, format("%s-", local.prefix), ""))
  display_name = format("Terraform Deployer: %s", each.value.name)
  description  = "Service Account to allow terraform deployments from CICD runners into the specified project."
  project      = local.projects[each.key].cicd_project_id
}

# Bind token_creators from tf-projects repo to IAM role
# to be capable of temporary SA tokens creation
# We use iam_binding so we can be authoritive on the serviceAccountTokenCreator role
resource "google_service_account_iam_binding" "map" {
  for_each = google_service_account.map

  service_account_id = each.value.name
  role               = "roles/iam.serviceAccountTokenCreator"
  members            = [for member, type in try(local.projects[each.key].owner_token_creators, {}) : format("%s:%s", type, member)]
}

# ==========================================
# Create Storage bucket for Terraform state
# ==========================================

resource "google_storage_bucket" "terraform_state" {
  for_each = local.projects

  project       = each.value.cicd_project_id
  name          = format("%s-tfstate", each.key)
  location      = local.region == "global" ? "EU" : upper(each.value.region)
  storage_class = "MULTI_REGIONAL"

  uniform_bucket_level_access = true
  default_event_based_hold    = false
  requester_pays              = false

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      num_newer_versions = "7"
      age                = "7"
    }
    action {
      type = "Delete"
    }
  }

  labels = each.value.labels
}

data "google_iam_policy" "map" {
  for_each = google_storage_bucket.terraform_state

  dynamic "binding" {
    for_each = merge(
      {
        # Make sure at least the terraform SA created for this project is allowed to write to the terraform state bucket
        "roles/storage.admin" = [format("serviceAccount:%s", google_service_account.map[each.key].email)]
      },
      { for role, members in try(local.projects[each.key], { state_bucket_roles = {} }).state_bucket_roles : role =>
        # Make sure at least the terraform SA created for this project is allowed to write to the terraform state bucket
        (role == "roles/storage.admin" ? distinct(concat([format("serviceAccount:%s", google_service_account.map[each.key].email)], members)) : members)
        if can(local.projects[each.key])
      }
    )

    content {
      role    = binding.key
      members = binding.value
    }
  }

  depends_on = [
    google_storage_bucket.terraform_state,
    google_service_account.map
  ]
}

resource "google_storage_bucket_iam_policy" "map" {
  for_each = data.google_iam_policy.map

  bucket      = google_storage_bucket.terraform_state[each.key].self_link
  policy_data = each.value.policy_data

  depends_on = [
    google_storage_bucket.terraform_state,
    google_service_account.map
  ]
}

# ==========================================
# Enable Shared VPC Host or Service project
# ==========================================
resource "google_compute_shared_vpc_host_project" "host" {
  for_each = { for project, settings in local.projects : project => settings if settings.shared_vpc_host == true }
  project  = google_project.map[each.key].project_id
}

resource "google_compute_shared_vpc_service_project" "service" {
  for_each        = { for project, settings in local.projects : project => settings if settings.shared_vpc_service != null }
  service_project = google_project.map[each.key].project_id
  host_project    = each.value.shared_vpc_service
}
