output "cloudsql_database_instance_id" {
  description = "The unique ID of the CloudSQL database instance."
  value       = google_sql_database_instance.grafana_db_instance.id
}

output "cloudsql_database_instance_connection_name" {
  description = "The connection name of the CloudSQL database instance."
  value       = google_sql_database_instance.grafana_db_instance.connection_name
}

output "grafana_db_name" {
  description = "The name of the Grafana database."
  value       = google_sql_database.grafana_db.name
}

output "grafana_db_user_name" {
  description = "The name of the Grafana database user."
  value       = google_sql_user.grafana_db_user.name
}

output "grafana_db_user_password" {
  description = "The password of the Grafana database user."
  value       = google_sql_user.grafana_db_user.password
  sensitive   = true
}

output "service_account_email" {
  description = "The e-mail address of the service account used by the Grafana Cloud Run service."
  value       = google_service_account.grafana_service_account.email
}

output "cloud_run_service_url" {
  description = "URL of the deployed Cloud Run service."
  value       = google_cloud_run_service.grafana_service.status[0]["url"]
}
