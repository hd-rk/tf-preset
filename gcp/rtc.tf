module "rtc" {
  source = "git@github.com:hd-rk/tf.git//modules/rtc?ref=450b5f3b1f79d48a8e7181533a28e750df9800cd"

  deployment_name = var.deployment_name
}