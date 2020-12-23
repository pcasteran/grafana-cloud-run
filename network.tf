resource "google_compute_network" "grafana_network" {
  count = var.create_network ? 1 : 0

  name                    = var.network_name
  description             = "VPC used by the Grafana CloudSQL database"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

data "google_compute_network" "grafana_network" {
  name       = var.network_name
  depends_on = [google_compute_network.grafana_network]
}

resource "google_compute_subnetwork" "grafana_subnetwork" {
  count = var.create_subnetwork ? 1 : 0

  name                     = var.subnetwork_name
  description              = "Subnetwork used by the Grafana CloudSQL database"
  region                   = var.region
  network                  = data.google_compute_network.grafana_network.id
  ip_cidr_range            = var.subnetwork_ip_cidr_range
  private_ip_google_access = true
}

data "google_compute_subnetwork" "grafana_subnetwork" {
  name       = var.subnetwork_name
  depends_on = [google_compute_subnetwork.grafana_subnetwork]
}

resource "google_vpc_access_connector" "grafana_vpc_access" {
  count = var.create_serverless_vpc_access_connector ? 1 : 0

  name          = var.serverless_vpc_access_connector_name
  region        = var.region
  ip_cidr_range = var.serverless_vpc_access_connector_ip_cidr_range
  network       = data.google_compute_network.grafana_network.name
}
