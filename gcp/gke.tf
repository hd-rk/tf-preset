locals {
  gke_preset_conf = local.preset_map[var.preset]["gke"]
  gke_custom_conf = {
    regional = var.gke_regional
    max_pods_per_node = var.gke_max_pods_per_node
    pod_secondary_range_name = var.gke_pod_secondary_range_name
    svc_secondary_range_name = var.gke_svc_secondary_range_name
    node_pools = var.gke_node_pools
  }
  gke_merged_conf = merge(gke_preset_conf, gke_custom_conf)
}

module "gke" {
  source = "git@github.com:hd-rk/tf.git//modules/gke?ref=69ba67a467ef8c09b3b61af43612eeab74a19626"

  deployment_name = var.deployment_name
  project = var.project
  region = var.region
  zone = var.zone
  network = var.network
  subnet = var.subnet
  enable_monitoring = local.enable_monitoring

  regional = local.gke_merged_conf["regional"]
  private = var.gke_private
  max_pods_per_node = local.gke_merged_conf["max_pods_per_node"]
  pod_secondary_range_name = local.gke_merged_conf["pod_secondary_range_name"]
  svc_secondary_range_name = local.gke_merged_conf["svc_secondary_range_name"]
  node_pools = local.gke_merged_conf["node_pools"]
  master_auth_networks = var.gke_master_auth_networks
  oauth_scopes = var.gke_oauth_scopes
  node_management = var.gke_node_management
}
