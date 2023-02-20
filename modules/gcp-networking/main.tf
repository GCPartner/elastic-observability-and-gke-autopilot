resource "google_compute_network" "gpc_network" {
  name                    = format("%s-network", var.cluster_name)
  project                 = var.gcp_project_id
  auto_create_subnetworks = false
  mtu                     = 1500
}

resource "google_compute_subnetwork" "k8s" {
  name          = format("%s-subnet", var.cluster_name)
  project       = var.gcp_project_id
  region        = var.gcp_region
  network       = google_compute_network.gpc_network.id
  ip_cidr_range = "10.123.128.0/18"
  secondary_ip_range {
    range_name    = format("%s-pod-range", var.cluster_name)
    ip_cidr_range = "10.124.0.0/14"
  }
  secondary_ip_range {
    range_name    = format("%s-service-range", var.cluster_name)
    ip_cidr_range = "10.123.240.0/20"
  }
}

#resource "google_compute_router" "cloud_router" {
#  name    = format("%s-router", var.cluster_name)
#  project = var.gcp_project_id
#  region  = var.gcp_region
#  network = google_compute_network.gpc_network.name
#}
