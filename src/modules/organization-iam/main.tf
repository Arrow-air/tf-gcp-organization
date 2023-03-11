locals {
  folders_role_bindings    = var.folders_role_bindings
  org_role_bindings        = var.org_role_bindings
  custom_org_role_bindings = var.custom_org_role_bindings

  # create a role mapping for folder level
  folder_role_map = try(flatten([for region, roles in local.folders_role_bindings.regions :
    [for role, members in roles :
      {
        role_name = format("%s-%s-%s", prefix, region, role)
        folder    = lookup(var.folder_id, region)
        role      = role
        members   = [for member, type in members : format("%s:%s", type, member)]
      }
    ]
  ]), {})

  # create a role mapping for org level
  custom_org_role_map = try(flatten([for org, roles in local.custom_org_role_bindings.org :
    [for role, members in roles :
      {
        role_name = format("custom-org-%s-%s", org, role)
        role      = format("organizations/%s/%s", var.org_id, role)
        members   = [for member, type in members : format("%s:%s", type, member)]
      }
    ]
  ]), {})

  org_role_map = try(flatten([for org, roles in local.org_role_bindings.org :
    [for role, members in roles :
      {
        role_name = format("org-%s-%s", org, role)
        role      = role
        members   = [for member, type in members : format("%s:%s", type, member)]
      }
    ]
  ]), {})
}

# Regional folder level roles
resource "google_folder_iam_binding" "folder" {
  for_each = local.folder_role_map != {} ? { for role in local.folder_role_map : role.role_name => role } : {}

  folder  = each.value.folder
  role    = each.value.role
  members = each.value.members
}

# Handles custom FT roles
resource "google_organization_iam_binding" "custom_roles" {
  for_each = local.custom_org_role_map != {} ? { for role in local.custom_org_role_map : role.role_name => role } : {}

  org_id  = var.org_id
  role    = each.value.role
  members = each.value.members
}

# Handles GCP pre-made roles
resource "google_organization_iam_binding" "premade_roles" {
  for_each = local.org_role_map != {} ? { for role in local.org_role_map : role.role_name => role } : {}

  org_id  = var.org_id
  role    = each.value.role
  members = each.value.members
}


