terraform {
  backend "s3" {
    key                  = "simple-infra"
    workspace_key_prefix = "duplocloud/infra"
    encrypt              = true
  }
}
