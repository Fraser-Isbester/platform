
resource "random_id" "control-plane-cluster" {
  byte_length = 2
  prefix      = "control-plane-cluster-"
}

# Creates the GKE Control plane cluster
resource "google_container_cluster" "control-plane-cluster" {
  name                = random_id.control-plane-cluster.hex
  location            = var.region
  project             = google_project.project.project_id
  enable_autopilot    = true
  deletion_protection = false

  resource_labels = {
    "cluster-type" = "control-plane"
    "managed-by"   = "terraform"
  }

  cost_management_config {
    enabled = true
  }

  monitoring_config {
    enable_components = [
      "SYSTEM_COMPONENTS", "APISERVER", "SCHEDULER",
      "CONTROLLER_MANAGER", "STORAGE", "HPA", "POD",
      "DAEMONSET", "DEPLOYMENT", "STATEFULSET"
    ]
  }
}
