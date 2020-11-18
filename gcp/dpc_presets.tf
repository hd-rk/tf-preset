locals {
  dpc_presets = {
    development = {
      druid = {
        properties = {
          "dataproc:dataproc.monitoring.stackdriver.enable" = true
          "capacity-scheduler:yarn.scheduler.capacity.maximum-am-resource-percent" = "0.9"
          "mapred:mapreduce.map.speculative" = "false"
          "mapred:mapreduce.reduce.speculative" = "false"
          "spark:spark.eventLog.enabled" = "false"
        }
        init_actions = []
        master_config = {
          ha = false
          machine_type = "n1-standard-8"
          disk_config = {
            boot_disk_type = "pd-standard"
            boot_disk_size_gb = 50
            num_local_ssds = 0
          }
        }
        worker_config = {
          num_instances = 0
          machine_type = "n1-standard-8"
          disk_config = {
            boot_disk_type = "pd-standard"
            boot_disk_size_gb = 100
            num_local_ssds = 0
          }
        }
      }
    }
    staging = {
      druid = {
        properties = {
          "dataproc:dataproc.monitoring.stackdriver.enable" = "true"
          "mapred:mapreduce.map.speculative" = "false"
          "mapred:mapreduce.reduce.speculative" = "false"
          "spark:spark.eventLog.enabled" = "true"
          "spark:spark.history.fs.cleaner.enabled" = "true"
        }
        init_actions = []
        master_config = {
          ha = false
          machine_type = "n1-standard-4"
          disk_config = {
            boot_disk_type = "pd-standard"
            boot_disk_size_gb = 100
            num_local_ssds = 0
          }
        }
        worker_config = {
          num_instances = 2
          machine_type = "n1-standard-8"
          disk_config = {
            boot_disk_type = "pd-standard"
            boot_disk_size_gb = 600
            num_local_ssds = 0
          }
        }
      }
    }
  }
}