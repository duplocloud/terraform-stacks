terraform {
  backend "s3" {
    workspace_key_prefix = "simple-shared-tenant"
    key                  = "duplocloud/shared-tenant"
    encrypt              = true
  }
}
