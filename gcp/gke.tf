locals {
  gke_preset_conf = local.gke_presets[var.preset]
  gke_custom_conf = {
    regional = var.gke_regional
    max_pods_per_node = var.gke_max_pods_per_node
    pod_secondary_range_name = var.gke_pod_secondary_range_name
    svc_secondary_range_name = var.gke_svc_secondary_range_name
    node_pools = var.gke_node_pools
  }
  gke_conf = {for k,v in local.gke_preset_conf: k => local.gke_custom_conf[k] == null ? v : local.gke_custom_conf[k] }

  # gke_regional = var.gke_regional != null ? var.gke_regional : local.gke_preset_conf["regional"]
  # gke_max_pods_per_node = var.gke_max_pods_per_node != null ? var.gke_max_pods_per_node : local.gke_preset_conf["max_pods_per_node"]
  # gke_pod_secondary_range_name = var.gke_pod_secondary_range_name != null ? var.gke_pod_secondary_range_name : local.gke_preset_conf["pod_secondary_range_name"]
  # gke_svc_secondary_range_name = var.gke_svc_secondary_range_name != null ? var.gke_svc_secondary_range_name : local.gke_preset_conf["svc_secondary_range_name"]
  # gke_node_pools = var.gke_node_pools != null ? var.gke_node_pools : local.gke_preset_conf["node_pools"]
}

module "gke" {
  source = "git@github.com:hd-rk/tf.git//modules/gke?ref=49e72cee41ded3ecd23a46281d3b0605176193cd"

  deployment_name = var.deployment_name
  project = var.project
  region = var.region
  zone = var.zone
  network = var.network
  subnet = var.subnet
  enable_monitoring = local.enable_monitoring
  deployment_config_name = module.rtc.name

  regional = local.gke_conf["regional"]
  private = var.gke_private
  max_pods_per_node = local.gke_conf["max_pods_per_node"]
  pod_secondary_range_name = local.gke_conf["pod_secondary_range_name"]
  svc_secondary_range_name = local.gke_conf["svc_secondary_range_name"]
  node_pools = local.gke_conf["node_pools"]
  master_auth_networks = var.gke_master_auth_networks
  oauth_scopes = var.gke_oauth_scopes
  node_management = var.gke_node_management
}
