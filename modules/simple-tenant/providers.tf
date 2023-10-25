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


