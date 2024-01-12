locals {
  tenant_name      = terraform.workspace
  tenant_id        = data.duplocloud_tenant.current.id
  internal_subnets = join(",", data.duplocloud_tenant_internal_subnets.current.subnet_ids)
  cert_arn         = data.duplocloud_plan_certificate.current.arn
  plan_id          = data.duplocloud_tenant.current.plan_id
  security_groups  = "${data.aws_security_group.alb.id}, ${data.aws_security_group.tenant.id}, duplo-ExternalELB"
  namespace        = "duploservices-${local.tenant_name}"
  region           = data.duplocloud_tenant_aws_region.current.aws_region
}

data "duplocloud_admin_aws_credentials" "current" {}

data "duplocloud_tenant" "current" {
  name = local.tenant_name
}

data "duplocloud_tenant_aws_region" "current" {
  tenant_id = local.tenant_id
}

data "duplocloud_tenant_internal_subnets" "current" {
  tenant_id = local.tenant_id
}

data "duplocloud_plan_certificate" "current" {
  name    = "salesdemo-apps.duplocloud.net-wildcard"
  plan_id = local.plan_id
}

data "aws_security_group" "alb" {
  name = "${local.namespace}-lb"
}
data "aws_security_group" "tenant" {
  name = local.namespace
}