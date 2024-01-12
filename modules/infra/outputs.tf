output "infra_name" {
  value = local.infra_name
}
output "cluster_name" {
  value = "duploinfra-${local.infra_name}"
}
output "region" {
  value = var.region
}
output "vpn_cidr" {
  value       = "${local.vpn_ip}/32"
  description = "The CIDR of the VPN"
}
output "domain" {
  description = "The domain name"
  value       = var.domain
}
output "eks_version" {
  description = "The EKS version"
  value       = duplocloud_infrastructure.current.all_settings[index(duplocloud_infrastructure.current.all_settings.*.key, "K8sVersion")]["value"]
}
