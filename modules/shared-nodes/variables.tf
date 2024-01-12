variable "infra_name" {
  type    = string
  default = "nonprod01"
}
variable "asg_capacity" {
  default = "m5.xlarge"
  type    = string
}
variable "asg_instance_count" {
  default = 1
  type    = number
}
variable "asg_min_instance_count" {
  default = 1
  type    = number
}
variable "asg_max_instance_count" {
  default = 3
  type    = number
}
variable "asg_os_disk_size" {
  default = 120
  type    = number
}
