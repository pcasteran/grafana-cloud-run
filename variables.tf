#
# Common
#

variable "project" {
  description = "GCP project in which to create the resources."
  type        = string
}

variable "region" {
  description = "GCP region in which to create the resources."
  type        = string
}

#
# Network
#

variable "create_network" {
  description = "Flag indicating whether to create the VPC network (true by default). Set to false if you want to use an existing one."
  type        = bool
  default     = true
}

variable "network_name" {
  description = "Name of the VPC network in which to create the Grafana CloudSQL database instance."
  type        = string
  default     = "grafana-network"
}

variable "create_subnetwork" {
  description = "Flag indicating whether to create the subnetwork (true by default). Set to false if you want to use an existing one."
  type        = bool
  default     = true
}

variable "subnetwork_name" {
  description = "Name of the subnetwork in which to create the Grafana CloudSQL database instance."
  type        = string
  default     = "grafana-subnet"
}

variable "subnetwork_ip_cidr_range" {
  description = "IP range of the subnetwork."
  type        = string
  default     = "10.132.0.0/29"
}

#
# Serverless VPC Access connector
#

variable "create_serverless_vpc_access_connector" {
  description = "Flag indicating whether to create the Serverless VPC Access connector (true by default). Set to false if you want to use an existing one. In that case, note that the connector must be in the same region as the Cloud SQL database instance."
  type        = bool
  default     = true
}

variable "serverless_vpc_access_connector_name" {
  description = "Name of the Serverless VPC Access connector."
  type        = string
  default     = "grafana-vpc-access"
}

variable "serverless_vpc_access_connector_ip_cidr_range" {
  description = "IP range to use for the Serverless VPC Access connector (must be a /28)."
  type        = string
  default     = "10.8.0.0/28"
}

#
# Database
#

variable "database_instance_name" {
  description = "Name of the CloudSQL database instance (a random suffix will be added)."
  type        = string
  default     = "grafana-db"
}

variable "database_machine_type" {
  description = "The machine type to use for the CloudSQL database."
  type        = string
  default     = "db-f1-micro"
}

variable "database_disk_type" {
  description = "The disk type to use for the CloudSQL database."
  type        = string
  default     = "PD_HDD"
}

#
# Service account
#

variable "service_account_name" {
  description = "Name of the service account used by the Grafana Cloud Run service."
  type        = string
  default     = "grafana-sa"
}

#
# Cloud Run service
#

variable "cloud_run_service_name" {
  description = "Name of the Cloud Run service."
  type        = string
  default     = "grafana"
}

variable "cloud_run_service_docker_image" {
  description = "Docker image to use in the Cloud Run service."
  type        = string
  default     = "marketplace.gcr.io/google/grafana6"
}

variable "cloud_run_max_instances" {
  description = "Maximum number of instances for the Cloud Run service."
  type        = number
  default     = 1
}

variable "cloud_run_service_cpu_limit" {
  description = "Number of vCPUs allocated to each container instance of the Cloud Run service."
  type        = string
  default     = "1000m"
}

variable "cloud_run_service_memory_limit" {
  description = "Memory to allocate to each container instance of the Cloud Run service."
  type        = string
  default     = "256Mi"
}

variable "grafana_admin_password" {
  description = "Grafana admin password."
  type        = string
}
