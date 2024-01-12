terraform {
  backend "s3" {
    key                  = "service-with-ingress"
    workspace_key_prefix = "duplocloud/stacks"
    encrypt              = true
  }
}
