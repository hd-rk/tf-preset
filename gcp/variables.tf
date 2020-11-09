variable "deployment_name" {}
variable "project" {}
variable "region" {}
variable "zone" {}

variable "network" {}
variable "subnet" {}

variable "preset" {
  type = string
  validation {
    condition = contains(["development","staging"], var.preset)
    error_message = "Preset must be one of 'development', 'staging'."
  }
}

variable "enable_monitoring" {
  type = bool
  default = null
}

variable "gke_regional" {
  type = bool
  default = null
}

variable "gke_max_pods_per_node" {
  type = number
  default = null
}

variable "gke_pod_secondary_range_name" {
  type = string
  default = null
}

variable "gke_svc_secondary_range_name" {
  type = string
  default = null
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
  default = null
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
