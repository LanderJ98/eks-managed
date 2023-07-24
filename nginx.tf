module "nginx-controller" {
  source           = "./modules/terraform-helm-release"
  release_name     = var.nginx_release_name
  repository       = var.nginx_repository
  chart_name       = var.nginx_chart_name
  namespace        = var.nginx_namespace
  create_namespace = var.nginx_create_namespace
  set = [
    {
      name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
      value = "nlb"
      type = "string"
    }
  ]

}