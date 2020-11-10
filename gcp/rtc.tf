module "rtc" {
  source = "git@github.com:hd-rk/tf.git//modules/rtc?ref=b6cb5fbae0b80102b10336a42db5caaeea14ba13"

  deployment_name = var.deployment_name
}