locals {
  tenant_name        = terraform.workspace
}

data "duplocloud_infrastructure" "current" {
  infra_name = var.infra_name
}

resource "duplocloud_tenant" "current" {
  account_name   = local.tenant_name
  plan_id        = var.infra_name
  allow_deletion = true
}

resource "duplocloud_tenant_config" "tenant-config" {
  tenant_id = duplocloud_tenant.current.tenant_id
  setting {
    key   = "delete_protection"
    value = "false"
  }
}
