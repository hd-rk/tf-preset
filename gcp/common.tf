locals {
  common_presets = {
    development = {
      enable_monitoring = false
    }
    staging = {
      enable_monitoring = true
    }
  }
  enable_monitoring = var.enable_monitoring != null ? var.enable_monitoring : local.common_presets[var.preset]["enable_monitoring"]
}