locals {
  gke_preset_conf = local.preset_map[var.preset]["gke"]
  gke_regional = var.gke_regional != null ? var.gke_regional : local.gke_preset_conf["regional"]
  gke_max_pods_per_node = var.gke_max_pods_per_node != null ? var.gke_max_pods_per_node : local.gke_preset_conf["max_pods_per_node"]
  gke_pod_secondary_range_name = var.gke_pod_secondary_range_name != null ? var.gke_pod_secondary_range_name : local.gke_preset_conf["pod_secondary_range_name"]
  gke_svc_secondary_range_name = var.gke_svc_secondary_range_name != null ? var.gke_svc_secondary_range_name : local.gke_preset_conf["svc_secondary_range_name"]
  gke_node_pools = var.gke_node_pools != null ? var.gke_node_pools : local.gke_preset_conf["node_pools"]
}

module "gke" {
  source = "git@github.com:hd-rk/tf.git//modules/gke?ref=78fc0615750d0bd42d2d536eaa36fe2ab0e566fe"

  deployment_name = var.deployment_name
  project = var.project
  region = var.region
  zone = var.zone
  network = var.network
  subnet = var.subnet
  enable_monitoring = local.enable_monitoring
  deployment_config_id = module.rtc.id

  regional = local.gke_regional
  private = var.gke_private
  max_pods_per_node = local.gke_max_pods_per_node
  pod_secondary_range_name = local.gke_pod_secondary_range_name
  svc_secondary_range_name = local.gke_svc_secondary_range_name
  node_pools = local.gke_node_pools
  master_auth_networks = var.gke_master_auth_networks
  oauth_scopes = var.gke_oauth_scopes
  node_management = var.gke_node_management
}
