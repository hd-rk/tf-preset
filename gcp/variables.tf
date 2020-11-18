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

variable "logstash" {
  type = object({
    host = string
    port = string
  })
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

variable "dpc_druid_image_version" {
  type = string
  default = "1.3.44-debian9"
}

variable "dpc_druid_properties" {
  type = map(string)
  default = null
}

variable "dpc_druid_init_actions" {
  type = set(string)
  default = null
}

variable "dpc_druid_master_config" {
  type = object({
    ha = bool
    machine_type = string
    disk_config = object({
      boot_disk_type = string
      boot_disk_size_gb = number
      num_local_ssds = number
    })
  })
  default = null
}

variable "dpc_druid_worker_config" {
  type = object({
    num_instances = number
    machine_type = string
    disk_config = object({
      boot_disk_type = string
      boot_disk_size_gb = number
      num_local_ssds = number
    })
  })
  default = null
}

variable "dpc_druid_num_preemptible_workers" {
  type = number
  default = 0
}

variable "dpc_druid_labels" {
  type = map(string)
  default = {
    "application" = "druid"
  }
}
