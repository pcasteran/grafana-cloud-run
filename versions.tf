terraform {
  required_version = ">= 0.14.3"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.51.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0.0"
    }

    grafana = {
      source  = "grafana/grafana"
      version = "~> 1.7.0"
    }
  }
}
