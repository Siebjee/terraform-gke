resource "google_service_account" "node" {
  account_id   = "gke-node"
  display_name = "GKE Node Service Account"
}

resource "google_project_iam_binding" "node" {
  project = var.project
  role    = google_project_iam_custom_role.node.name
  members = [
    "serviceAccount:${google_service_account.node.email}"
  ]
}

resource "google_project_iam_custom_role" "node" {
  role_id     = "kubernetes"
  title       = "kubernetes node role"
  description = "The kubernetes node role"
  permissions = concat(
    [
      "artifactregistry.repositories.downloadArtifacts",
      "artifactregistry.repositories.get",
      "artifactregistry.repositories.list",
      "compute.networks.get",
      "compute.networks.list",
      "storage.objects.get",
      "storage.objects.list",
      "storage.objects.create",
      "storage.objects.delete",
    ],
    var.additional_permissions
  )
}
