module "rtc" {
  source = "git@github.com:hd-rk/tf.git//modules/rtc?ref=78fc0615750d0bd42d2d536eaa36fe2ab0e566fe"

  deployment_name = var.deployment_name
}