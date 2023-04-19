locals {
  org_roles = { for role, settings in var.org_roles : (length(regexall("^(roles|organizations)/", role)) > 0 ? replace(role, nonsensitive(var.org_id), "") : format("roles/%s", role)) =>
    merge(settings,
      {
        role    = (length(regexall("^(roles|organizations)/", role)) > 0 ? role : format("roles/%s", role))
        members = [for member, type in settings.members : format("%s:%s", type, member)]
      }
    )
  }

  roles = { for role, settings in var.roles : (length(regexall("^roles/", role)) > 0 ? role : format("roles/%s", role)) =>
    merge(settings,
      {
        role    = (length(regexall("^roles/", role)) > 0 ? role : format("roles/%s", role))
        members = [for member, type in merge(try(var.default_roles.members, {}), settings.members) : format("%s:%s", type, member)]
      }
    )
  }
}

resource "google_project_iam_binding" "map" {
  for_each = local.roles

  project = var.gcp_project
  role    = each.value.role
  members = each.value.members
  dynamic "condition" {
    for_each = each.value.condition != null ? [each.value.condition] : []
    content {
      expression  = condition.value.expression
      title       = condition.value.title
      description = try(condition.value.description, null)
    }
  }
}

resource "google_organization_iam_binding" "binding" {
  for_each = local.org_roles

  org_id  = var.org_id
  role    = each.value.role
  members = each.value.members
  dynamic "condition" {
    for_each = each.value.condition != null ? [each.value.condition] : []
    content {
      expression  = condition.value.expression
      title       = condition.value.title
      description = try(condition.value.description, null)
    }
  }
}

