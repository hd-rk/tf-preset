variable "deployment_name" {}
variable "project" {}
variable "region" {}
variable "zone" {}

variable "network" {}
variable "subnet" {}

variable "enable_monitoring" {
  type = bool
  default = false
}

variable "gke_regional" {
  type = bool
  default = false
}

variable "gke_max_pods_per_node" {
  type = number
  default = 110
}

variable "gke_pod_secondary_range_name" {
  type = string
  default = ""
}

variable "gke_svc_secondary_range_name" {
  type = string
  default = ""
}

variable "gke_master_auth_networks" {
  type = string
  default = "all:0.0.0.0/0"
}

variable "gke_oauth_scopes" {
  type = set(string)
  default = [
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/devstorage.read_write",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring",
    "https://www.googleapis.com/auth/pubsub",
    "https://www.googleapis.com/auth/cloud-platform"
  ]
}

variable "gke_private" {
  type = object({
    enabled = bool
    master_private_endpoint = bool
    master_range_cidr = string
  })
  default = {
    enabled = false
    master_private_endpoint = false
    master_range_cidr = ""
  }
}

variable "gke_node_pools" {
  type = list(object({
    name = string
    node_count = number
    machine_type = string
    labels = map(string)
    tags = list(string)
  }))
  default = [
    {
      name = "mlisa-pool"
      node_count = 1
      machine_type = "n1-standard-16"
      labels = {
        application = "mlisa"
      }
      tags = []
    }
  ]
}

variable "gke_node_management" {
  type = object({
    auto_repair = bool
    auto_upgrade = bool
  })
  default = {
    auto_repair = false
    auto_upgrade = false
  }
}
