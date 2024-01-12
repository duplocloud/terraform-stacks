resource "duplocloud_duplo_service" "current" {
  tenant_id                            = local.tenant_id
  name                                 = var.name
  lb_synced_deployment                 = false
  is_daemonset                         = false
  agent_platform                       = 7
  cloud                                = 0
  cloud_creds_from_k8s_service_account = true
  any_host_allowed                     = false
  other_docker_config = jsonencode({
    "ImagePullPolicy" : "Always",
  })
  docker_image = "nginx:latest"
  timeouts {
    create = "20m"
    update = "20m"
    delete = "20m"
  }
  replicas = 1

}

resource "duplocloud_duplo_service_lbconfigs" "current" {
  tenant_id                   = duplocloud_duplo_service.current.tenant_id
  replication_controller_name = duplocloud_duplo_service.current.name
  lbconfigs {
    lb_type                  = 3 # K8S Service
    port                     = 80
    protocol                 = "tcp"
    external_port            = 80
    health_check_url         = "/status"
    is_native                = false
    set_ingress_health_check = true # for "alb.ingress.kubernetes.io/healthcheck-path": "/status",
  }
  # Workaround for AWS:  Even after the ALB is available, there is some short duration where a V2 WAF cannot be attached.
  provisioner "local-exec" {
    command = "sleep 30"
  }
}
resource "time_sleep" "current" {
  depends_on = [duplocloud_duplo_service.current]

  create_duration = "30s"
}

resource "duplocloud_k8_ingress" "current" {
  depends_on         = [time_sleep.current]
  tenant_id          = duplocloud_duplo_service.current.tenant_id
  name               = var.name
  ingress_class_name = "alb"
  lbconfig {
    is_internal     = true
    dns_prefix      = "ingress-${local.tenant_name}"
    certificate_arn = local.cert_arn
    https_port      = 443
    http_port       = 80
  }

  rule {
    path         = "/"
    path_type    = "Prefix"
    service_name = duplocloud_duplo_service.current.name
    port         = 80
  }
  annotations = {
    "kubernetes.io/ingress.class"      = "alb",      # already above
    "alb.ingress.kubernetes.io/scheme" = "internet-facing", # internal | internet-facing 
    #  make sure putting proper security groups when it is internet-facing
    "alb.ingress.kubernetes.io/security-groups"              = local.security_groups,
    "alb.ingress.kubernetes.io/subnets"                      = local.internal_subnets,
    "alb.ingress.kubernetes.io/load-balancer-name"           = local.tenant_name,
    "alb.ingress.kubernetes.io/group.name"                   = local.tenant_name,
    "alb.ingress.kubernetes.io/certificate-arn"              = local.cert_arn,
    "alb.ingress.kubernetes.io/target-type"                  = "ip",    # instance | ip
    "alb.ingress.kubernetes.io/backend-protocol"             = "HTTP", # HTTP|HTTPS 
    "alb.ingress.kubernetes.io/listen-ports"                 = "[{\"HTTP\": 80}], {\"HTTPS\": 443}]",
    "alb.ingress.kubernetes.io/ssl-redirect"                 = "443",
    "alb.ingress.kubernetes.io/healthcheck-path"             = "/",
    "alb.ingress.kubernetes.io/healthcheck-interval-seconds" = "15",
    "alb.ingress.kubernetes.io/healthy-threshold-count"      = "2",
    "alb.ingress.kubernetes.io/unhealthy-threshold-count"    = "2",
    "alb.ingress.kubernetes.io/healthcheck-timeout-seconds"  = "5",
    "alb.ingress.kubernetes.io/target-group-attributes"      = "deregistration_delay.timeout_seconds=30",
    # put bucket name and prefix for it when access true
    "alb.ingress.kubernetes.io/load-balancer-attributes" = "access_logs.s3.enabled=false,access_logs.s3.bucket=my-access-log-bucket,access_logs.s3.prefix=xyz,idle_timeout.timeout_seconds=120,routing.http.drop_invalid_header_fields.enabled=false",
    # consider(if using) these when internet-facing and these are default values
    # "alb.ingress.kubernetes.io/shield-advanced-protection" = "",   # true|false
    # "alb.ingress.kubernetes.io/auth-type" = "none",                # "none|oidc|cognito"
    # "alb.ingress.kubernetes.io/auth-scope" = "openid"              # string
    # "alb.ingress.kubernetes.io/wafv2-acl-arn" = "",                # string
    # "alb.ingress.kubernetes.io/waf-acl-id" = "",                   # string
  }
  provisioner "local-exec" {
    command = "sleep 30"
  }
}