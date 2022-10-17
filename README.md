This is a simple module that creates a simple zonal (zone is configured on provider) kubernetes (GKE) cluster.
You can have 1 zonal GKE control plane per billing account for free, so this is saving some costs.

This module spins up:
* Public & Private GKE Control plane
  * Workload Identity Enabled
* Private GKE node pool
* Compute private subnet
* Compute Nat Router
* Compute Router
* Separate service account for GKE nodes with access to storage (Image pull access)

Simple usage:
```terraform
module "gke" {
  source = "git::https://github.com:Siebjee/terraform-gke?ref=0.1.2"

  project                = "my-project"
  workload_identity_pool = "my-project.svc.id.goog"

  min_master_version = "1.24.5-gke.600"
  master_authorized_networks_config = concat(
    [
      "192.168.0.0/16",
      "172.16.0.0/12",
      "10.0.0.0/8",
    ],
    [
      "123.123.123.123" # Home IP or something
    ]
  )

  additional_permissions = [
    "recaptchaenterprise.assessments.create",
    "recaptchaenterprise.assessments.annotate",
    "recaptchaenterprise.relatedaccountgroupmemberships.list",
    "recaptchaenterprise.relatedaccountgroups.list",
  ]

  cluster_name   = "my-gke"
  pool_size      = 1
  min_node_count = 1
  max_node_count = 3

  machine_type = "e2-small"
}
```
