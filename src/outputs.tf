output "projects" {
  value     = module.project
  sensitive = true
}

output "automation" {
  value = module.automation
}

output "workload_identity_pool" {
  value = google_iam_workload_identity_pool.map
}
