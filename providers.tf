provider "google" {
  project = var.project
  region  = var.region
}

provider "random" {
}

provider "grafana" {
  url  = google_cloud_run_service.grafana_service.status[0]["url"]
  auth = "admin:${var.grafana_admin_password}"
}
