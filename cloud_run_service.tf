resource "google_service_account" "grafana_service_account" {
  account_id   = "grafana"
  display_name = "Grafana service account"
  description  = "Service account used by Grafana to connect to Cloud Monitoring"
}

resource "google_project_iam_member" "grafana_monitoring_viewer" {
  member = "serviceAccount:${google_service_account.grafana_service_account.email}"
  role   = "roles/monitoring.viewer"
}

resource "google_cloud_run_service" "grafana_service" {
  name                       = var.cloud_run_service_name
  location                   = var.region
  autogenerate_revision_name = true

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"        = var.cloud_run_max_instances
        "run.googleapis.com/vpc-access-connector" = var.serverless_vpc_access_connector_name
        "run.googleapis.com/vpc-access-egress"    = "private-ranges-only"
      }
    }
    spec {
      service_account_name = google_service_account.grafana_service_account.email
      containers {
        image = var.cloud_run_service_docker_image
        resources {
          limits = {
            cpu : var.cloud_run_service_cpu_limit
            memory : var.cloud_run_service_memory_limit
          }
        }
        env {
          name  = "GF_SERVER_HTTP_PORT"
          value = 8080
        }
        env {
          name  = "GF_DATABASE_TYPE"
          value = "postgres"
        }
        env {
          name  = "GF_DATABASE_HOST"
          value = google_sql_database_instance.grafana_db_instance.private_ip_address
        }
        env {
          name  = "GF_DATABASE_NAME"
          value = google_sql_database.grafana_db.name
        }
        env {
          name  = "GF_DATABASE_USER"
          value = google_sql_user.grafana_db_user.name
        }
        env {
          name  = "GF_DATABASE_PASSWORD"
          value = google_sql_user.grafana_db_user.password
        }
        env {
          name  = "GF_SECURITY_ADMIN_PASSWORD"
          value = var.grafana_admin_password
        }
      }
    }
  }
}

data "google_iam_policy" "grafana_service_iam_policy" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "grafana_service_iam_policy" {
  service     = google_cloud_run_service.grafana_service.name
  location    = google_cloud_run_service.grafana_service.location
  policy_data = data.google_iam_policy.grafana_service_iam_policy.policy_data
}
