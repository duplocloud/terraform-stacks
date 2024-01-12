locals {
  infra_name     = terraform.workspace
  vpn_ip         = data.aws_cloudformation_stack.openvpn.outputs["PrivateIp"]
}
data "duplocloud_admin_aws_credentials" "current" {}
data "aws_cloudformation_stack" "openvpn" {
  name = "duplo-openvpn-v1"
}
