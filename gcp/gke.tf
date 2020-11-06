module "gke" {
  source = "git@github.com:hd-rk/tf.git//modules/gke?ref=main"

  deployment_name = var.deployment_name
  project = var.project
  region = var.region
  zone = var.zone
  network = var.network
  subnet = var.subnet
  enable_monitoring = var.enable_monitoring

  regional = var.gke_regional
  private = var.gke_private
  max_pods_per_node = var.gke_max_pods_per_node
  pod_secondary_range_name = var.gke_pod_secondary_range_name
  svc_secondary_range_name = var.gke_svc_secondary_range_name
  node_pools = var.gke_node_pools
  master_auth_networks = var.gke_master_auth_networks
  oauth_scopes = var.gke_oauth_scopes
  node_management = var.gke_node_management
}
