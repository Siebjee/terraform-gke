resource "google_compute_router" "vpc_router" {
  name    = "${var.cluster_name}-router"
  region  = google_compute_subnetwork.gke-subnet.region
  network = google_compute_network.gke-network.self_link
}

resource "google_compute_router_nat" "vpc-nat" {
  name                               = "${var.cluster_name}-nat"
  router                             = google_compute_router.vpc_router.name
  region                             = google_compute_router.vpc_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  enable_dynamic_port_allocation = var.enable_dynamic_port_allocation
  min_ports_per_vm               = var.min_ports_per_vm
  max_ports_per_vm               = var.max_ports_per_vm

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
