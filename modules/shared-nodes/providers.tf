terraform {
  required_version = ">= 1.0.0"
  required_providers {
    duplocloud = {
      source  = "duplocloud/duplocloud"
      version = ">= 0.10.0"
    }
  }
}
provider "duplocloud" {}
provider "aws" {
  region     = local.region
  access_key = data.duplocloud_admin_aws_credentials.current.access_key_id
  secret_key = data.duplocloud_admin_aws_credentials.current.secret_access_key
  token      = data.duplocloud_admin_aws_credentials.current.session_token
}

