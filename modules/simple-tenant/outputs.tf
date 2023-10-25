output "tenant_name" {
  value       = duplocloud_tenant.current.account_name
  description = "The tenant name"
}
output "tenant_id" {
  value       = duplocloud_tenant.current.tenant_id
  description = "The tenant ID"
}
output "region" {
  value       = data.duplocloud_infrastructure.current.region
  description = "The duplo plan region."
}
output "infra_name" {
  value       = data.duplocloud_infrastructure.current.infra_name
  description = "The duplo infra name."
}
output "vpc_id" {
  value       = data.duplocloud_infrastructure.current.vpc_id
  description = "The VPC or VNet ID."
}
