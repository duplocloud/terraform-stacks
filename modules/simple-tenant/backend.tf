terraform {
  backend "s3" {
    key                  = "duplocloud/stacks"
    workspace_key_prefix = "simple-tenant"
    encrypt              = true
  }
}
