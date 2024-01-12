module "nodegroup" {
  source             = "duplocloud/components/duplocloud//modules/eks-nodes"
  version            = "0.0.12"
  prefix             = "apps-"
  tenant_id          = local.tenant_id
  capacity           = var.asg_capacity
  eks_version        = local.eks_version
  instance_count     = var.asg_instance_count
  min_instance_count = var.asg_min_instance_count
  max_instance_count = var.asg_max_instance_count
  os_disk_size       = var.asg_os_disk_size
  minion_tags = {
    "AllocationTags" = "shared"
  }
}
