resource "google_compute_global_address" "grafana_db_instance_peering_address" {
  name          = "grafana-db-peering"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = data.google_compute_network.grafana_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = data.google_compute_network.grafana_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.grafana_db_instance_peering_address.name]
}

resource "random_id" "grafana_db_instance_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "grafana_db_instance" {
  name                = "${var.database_instance_name}-${random_id.grafana_db_instance_name_suffix.hex}"
  region              = var.region
  database_version    = "POSTGRES_12"
  deletion_protection = false

  settings {
    tier      = var.database_machine_type
    disk_type = var.database_disk_type
    # No disk_size as we are using disk_autoresize.
    disk_autoresize = true
    ip_configuration {
      ipv4_enabled    = false
      private_network = data.google_compute_network.grafana_network.id
    }
  }

  depends_on = [google_service_networking_connection.private_vpc_connection]
}

resource "google_sql_database" "grafana_db" {
  name     = "grafana"
  instance = google_sql_database_instance.grafana_db_instance.name
}

resource "random_password" "grafana_db_user_password" {
  length           = 16
  special          = true
  override_special = "_%@#;"
}

resource "google_sql_user" "grafana_db_user" {
  name     = "grafana"
  password = random_password.grafana_db_user_password.result
  instance = google_sql_database_instance.grafana_db_instance.name
}
