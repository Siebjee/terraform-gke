resource "google_compute_subnetwork" "gke-subnet" {
  name                     = "${var.cluster_name}-subnet"
  ip_cidr_range            = var.gke_subnet
  region                   = "europe-west4"
  private_ip_google_access = true
  network                  = google_compute_network.gke-network.self_link

  secondary_ip_range {
    range_name    = "gke-services"
    ip_cidr_range = var.gke_subnet_services
  }
  secondary_ip_range {
    range_name    = "gke-pods"
    ip_cidr_range = var.gke_subnet_pods
  }
}

resource "google_compute_network" "gke-network" {
  name                    = "${var.cluster_name}-network"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
}
