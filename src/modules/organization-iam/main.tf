locals {
  custom_org_roles = var.custom_org_roles
}

# Create custom roles
resource "google_organization_iam_custom_role" "map" {
  for_each = local.custom_org_roles

  org_id      = var.org_id
  role_id     = each.key
  title       = each.value.title
  description = each.value.description
  permissions = each.value.permissions
}
