module "external_dns_deployment" {
  source           = "./modules/terraform-helm-release"
  release_name     = var.external_dns_release_name
  repository       = var.external_dns_repository
  chart_name       = var.external_dns_chart_name
  namespace        = var.external_dns_namespace
  create_namespace = var.external_dns_create_namespace
  set = [
    {
      name  = "rbac.apiVersion"
      value = "v1"
      type  = "string"
    },
    {
      name  = "serviceAccount.name"
      value = var.external_dns_sa_name
      type  = "string"
    },
    {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = module.external_dns_eks_role.iam_role_arn
      type  = "string"
    },
    {
      name  = "txtOwnerId"
      value = module.eks.cluster_name
      type  = "string"
    },
    {
      name  = "logLevel"
      value = "debug"
      type  = "string"
    }
  ]
}