resource "duplocloud_infrastructure" "current" {
  infra_name        = local.infra_name
  cloud             = 0 // AWS
  region            = var.region
  azcount           = var.azcount
  enable_k8_cluster = true
  address_prefix    = var.cidr
  subnet_cidr       = 22
  enable_ecs_cluster = false
  enable_container_insights = false
}

resource "duplocloud_infrastructure_setting" "current" {
  infra_name = duplocloud_infrastructure.current.infra_name
  setting {
    key   = "EnableAwsAlbIngress"
    value = "true"
  }
  setting {
    key   = "EnableClusterAutoscaler"
    value = "true"
  }
}