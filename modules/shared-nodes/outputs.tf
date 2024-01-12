output "cert_arn" {
  description = "The ARN of the certificate"
  value = local.cert_arn
}
output "domain" {
  description = "The domain name"
  value       = local.domain
}
output "tenant_id" {
  value       = local.tenant_id
  description = "The tenant ID of the shared tenant."
}