terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.10.0"
    }
  }
}

provider "google" {}

# Create a random ID to append to the project name
resource "random_id" "id" {
  byte_length = 2
}

# Create a new project
resource "google_project" "project" {
  name            = var.name
  project_id      = "${var.name}-${random_id.id.hex}"
  billing_account = var.billing_account_id
}

# Enable the required APIs
resource "google_project_service" "apis" {
  for_each = toset([
    "compute.googleapis.com",
    "container.googleapis.com",
    "krmapihosting.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
    "anthos.googleapis.com",
    "gkehub.googleapis.com",
    "cloudaicompanion.googleapis.com"
  ])
  project = google_project.project.project_id
  service = each.key
}
