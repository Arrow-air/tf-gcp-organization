locals {
  # Prepend "organizations/1234/" before roles/my_role
  org_roles = { for role, members in var.org_roles : (length(regexall("^org", role)) > 0 ? role : format("organizations/%s/%s", var.org_id, role)) =>
    {
      members = [for member, type in members : format("%s:%s", type, member)]
    }
  }

  roles = { for role, members in merge(var.default_roles, var.roles) : role =>
    {
      members = [for member, type in merge(lookup(var.default_roles, role, {}), members) : format("%s:%s", type, member)]
    }
  }
}

resource "google_project_iam_binding" "map" {
  for_each = local.roles

  project = var.gcp_project
  role    = each.key
  members = each.value.members
}

resource "google_organization_iam_binding" "binding" {
  for_each = local.org_roles

  org_id  = var.org_id
  role    = each.key
  members = each.value.members
}

