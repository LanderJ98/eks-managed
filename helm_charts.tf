# # Ingress controller
# module "nginx_controller" {
#   source           = "./modules/terraform-helm-release"
#   release_name     = var.nginx_release_name
#   repository       = var.nginx_repository
#   chart_name       = var.nginx_chart_name
#   namespace        = var.nginx_namespace
#   create_namespace = var.nginx_create_namespace
#   set = [
#     {
#       name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
#       value = "nlb"
#       type  = "string"
#     },
#     {
#       name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/do-loadbalancer-enable-proxy-protocol"
#       value = "true"
#     },
#     {
#       name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/do-loadbalancer-tls-passthrough"
#       value = "true"
#     }
#   ]
#   depends_on = [
#     module.eks.eks_managed_node_groups
#   ]
# }

# # External DNS to handle R53 records
# module "external_dns_deployment" {
#   source           = "./modules/terraform-helm-release"
#   release_name     = var.external_dns_release_name
#   repository       = var.external_dns_repository
#   chart_name       = var.external_dns_chart_name
#   namespace        = var.external_dns_namespace
#   create_namespace = var.external_dns_create_namespace
#   set = [
#     {
#       name  = "rbac.apiVersion"
#       value = "v1"
#       type  = "string"
#     },
#     {
#       name  = "serviceAccount.name"
#       value = var.external_dns_sa_name
#       type  = "string"
#     },
#     {
#       name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
#       value = module.external_dns_eks_role.iam_role_arn
#       type  = "string"
#     },
#     {
#       name  = "txtOwnerId"
#       value = module.eks.cluster_name
#       type  = "string"
#     },
#     {
#       name  = "logLevel"
#       value = "debug"
#       type  = "string"
#     }
#   ]
#   depends_on = [
#     module.eks.eks_managed_node_groups
#   ]
# }

# # Cert manager to handle certificates
# module "cert_manager" {
#   source           = "./modules/terraform-helm-release"
#   release_name     = var.cert_manager_release_name
#   repository       = var.cert_manager_repository
#   chart_name       = var.cert_manager_chart_name
#   namespace        = var.cert_manager_namespace
#   create_namespace = var.cert_manager_create_namespace

#   set = [
#     {
#       name  = "installCRDs"
#       value = "true"
#     }
#   ]
#   depends_on = [
#     module.eks.eks_managed_node_groups
#   ]
# }