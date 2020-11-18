locals {
  dpc_druid_preset_conf = local.dpc_presets[var.preset]["druid"]
  dpc_druid_custom_conf = {
    properties = var.dpc_druid_properties
    master_config = var.dpc_druid_master_config
    worker_config = var.dpc_druid_worker_config
    init_actions = var.dpc_druid_init_actions
  }
  dpc_druid_conf = {for k,v in local.dpc_druid_preset_conf: k => local.dpc_druid_custom_conf[k] == null ? v : local.dpc_druid_custom_conf[k]}
}

module "dpc_druid" {
  source = "git@github.com:hd-rk/tf.git//modules/dpc?ref=5515112104e948e747f76280193442a557d76ca2"

  deployment_name = var.deployment_name
  project = var.project
  region = var.region
  zone = var.zone
  network = var.network
  subnet = var.subnet
  enable_monitoring = local.enable_monitoring
  deployment_config_name = module.rtc.name

  name = "druid"
  image_version = var.dpc_druid_image_version
  properties = local.dpc_druid_conf["properties"]
  init_actions = local.dpc_druid_conf["init_actions"]
  master_config = local.dpc_druid_conf["master_config"]
  worker_config = local.dpc_druid_conf["worker_config"]
  num_preemptible_workers = var.dpc_druid_num_preemptible_workers
  labels = var.dpc_druid_labels
}