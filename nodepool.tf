resource "google_container_node_pool" "primary" {
  provider           = google-beta
  name               = "${var.cluster_name}-pool"
  cluster            = google_container_cluster.primary.name
  initial_node_count = var.pool_size

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  management {
    auto_upgrade = "true"
    auto_repair  = "true"
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 1
  }

  node_config {
    preemptible  = true
    machine_type = var.machine_type
    disk_size_gb = "30"

    service_account = google_service_account.node.email

    metadata = {
      disable-legacy-endpoints = "true"
    }

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      cluster = var.cluster_name
    }

    tags = [var.cluster_name]
  }
}
