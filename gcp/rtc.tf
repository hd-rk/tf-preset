module "rtc" {
  source = "git@github.com:hd-rk/tf.git//modules/rtc?ref=c7e8686daae49711d93e311a4b36ff93a3e88705"

  deployment_name = var.deployment_name
}