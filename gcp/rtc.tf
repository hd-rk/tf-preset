module "rtc" {
  source = "git@github.com:hd-rk/tf.git//modules/rtc?ref=49e72cee41ded3ecd23a46281d3b0605176193cd"

  deployment_name = var.deployment_name
}