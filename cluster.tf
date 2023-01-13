resource "google_container_cluster" "primary" {
  provider           = google-beta
  name               = var.cluster_name
  min_master_version = var.min_master_version
  network            = google_compute_network.gke-network.self_link
  subnetwork         = google_compute_subnetwork.gke-subnet.self_link

  initial_node_count       = 1
  remove_default_node_pool = true

  datapath_provider = var.datapath_provider

  release_channel {
    channel = var.release_channel
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.master_authorized_networks_config
      content {
        cidr_block = cidr_blocks.value
      }
    }
  }

  workload_identity_config {
    workload_pool = var.workload_identity_pool
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "00:00"
    }
  }

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-pods"
    services_secondary_range_name = "gke-services"
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}
