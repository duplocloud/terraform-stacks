resource "duplocloud_tenant" "data" {
  account_name       = local.tenant_name
  plan_id            = var.infra_name
  timeouts {}
}

resource "duplocloud_tenant_config" "tenant-config" {
  tenant_id = duplocloud_tenant.data.tenant_id
  setting {
    key   = "delete_protection"
    value = "true"
  }
  setting { # mgmt
    key   = "enable_host_other_tenants"
    value = "true"
  }
}