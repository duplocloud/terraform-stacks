terraform {
  backend "s3" {
    key                  = "simple-tenant"
    workspace_key_prefix = "duplocloud/stacks"
    encrypt              = true
  }
}
