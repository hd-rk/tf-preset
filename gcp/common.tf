locals {
  enable_monitoring = var.enable_monitoring != null ? var.enable_monitoring : local.preset_map[var.preset]["enable_monitoring"]
}