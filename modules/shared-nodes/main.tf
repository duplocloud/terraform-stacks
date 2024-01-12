locals {
  tenant_name    = terraform.workspace
  tenant_id      = duplocloud_tenant.data.tenant_id
  infra_name     = duplocloud_tenant.data.plan_id
  account_id     = data.duplocloud_aws_account.current.account_id
  namespace      = "duploservices-${local.tenant_name}"
  tfstate_bucket = "duplo-tfstate-${local.account_id}"
  default_region = data.duplocloud_admin_aws_credentials.current.region
  eks_version    = data.terraform_remote_state.infra.outputs["eks_version"]
  region         = data.duplocloud_tenant_aws_region.current.aws_region
}

data "duplocloud_admin_aws_credentials" "current" {
}
data "duplocloud_aws_account" "current" {
}
data "duplocloud_eks_credentials" "current" {
  plan_id = var.infra_name
}
data "aws_eks_cluster" "current" {
  name = "duploinfra-${duplocloud_tenant.data.plan_id}"
}
data "duplocloud_tenant_internal_subnets" "current" {
  tenant_id = local.tenant_id
}
data "duplocloud_infrastructure" "infra" {
  infra_name = var.infra_name
}
# find some security groups
data "aws_security_group" "tenant" {
  name = local.namespace
}
data "aws_security_group" "allhosts" {
  name       = "duplo-allhosts"
}
data "aws_security_group" "alb" {
  name       = "${local.namespace}-alb}"
}

data "duplocloud_tenant_aws_kms_key" "tenant_kms" {
  tenant_id = local.tenant_id
}

data "duplocloud_tenant_aws_region" "current" {
  tenant_id = local.tenant_id
}