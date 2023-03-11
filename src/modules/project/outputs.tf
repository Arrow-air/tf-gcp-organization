output "project_map" {
  value = { for project, data in google_project.map : project =>
    {
      project            = data
      tfstate_bucket     = google_storage_bucket.terraform_state[project]
      tf_service_account = google_service_account.map[project]
    }
  }
}
