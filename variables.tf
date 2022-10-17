variable "project" {
  type = string
}

variable "cluster_name" {
  type    = string
  default = "my-cluster"
}

variable "min_master_version" {
  type    = string
  default = "1.20.11-gke.1300"
}

variable "release_channel" {
  type    = string
  default = "RAPID"
}

variable "workload_identity_pool" {
  type    = string
  default = "project-name.svc.id.goog"
}

variable "pool_size" {
  type    = number
  default = 2
}

variable "master_authorized_networks_config" {
  type    = list(any)
  default = []
}

variable "machine_type" {
  type    = string
  default = "n1-standard-2"
}

variable "min_node_count" {
  type    = number
  default = 1
}

variable "max_node_count" {
  type    = number
  default = 1
}

variable "additional_permissions" {
  default = []
}

variable "master_ipv4_cidr_block" {
  description = "Private cluster master cidr"
  type        = string
  default     = "10.13.37.0/28"
}

variable "gke_subnet" {
  description = "Private subnet for GKE"
  type        = string
  default     = "10.10.0.0/16"
}

variable "gke_subnet_services" {
  description = "Private subnet for GKE services, must be part of var.get_subnet"
  type        = string
  default     = "10.11.0.0/20"
}

variable "gke_subnet_pods" {
  description = "Private subnet for GKE pods, must be part of var.get_subnet"
  type        = string
  default     = "10.12.0.0/20"
}
