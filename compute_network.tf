resource "google_compute_subnetwork" "gke-subnet" {
  name                     = "${var.cluster_name}-subnet"
  ip_cidr_range            = "10.10.0.0/16"
  region                   = "europe-west4"
  private_ip_google_access = true
  network                  = google_compute_network.gke-network.self_link

  secondary_ip_range {
    range_name    = "gke-services"
    ip_cidr_range = "10.11.0.0/20"
  }
  secondary_ip_range {
    range_name    = "gke-pods"
    ip_cidr_range = "10.12.0.0/20"
  }
}

resource "google_compute_network" "gke-network" {
  name                    = "${var.cluster_name}-network"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
}
