variable "cidr" {
  type    = string
  default = "10.221.0.0/16"
}
variable "region" {
  default = "us-west-2"
  type    = string
}
variable "azcount" {
  default = 2
  type    = number
}
variable "domain" {
  type    = string
  default = "test.salesdemo-apps.duplocloud.net"
}
