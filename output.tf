output "subnet_ids" {
  value = module.vpc.public_subnets
}

output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_arn" {
  value = module.eks.cluster_arn
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "nginx_chart_name" {
  value = module.nginx_controller.chart_name
}

output "nginx_chart_namespace" {
  value = module.nginx_controller.namespace
}

output "external_dns_role_arn" {
  value = module.external_dns_eks_role.iam_role_arn
}

output "external_dns_chart_name" {
  value = module.external_dns_deployment.chart_name
}

output "external_dns_namespace" {
  value = module.external_dns_deployment.namespace
}