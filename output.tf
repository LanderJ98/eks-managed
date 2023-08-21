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

# output "nginx_chart_name" {
#   value = module.nginx_controller.chart_name
# }

# output "nginx_chart_namespace" {
#   value = module.nginx_controller.namespace
# }

# output "external_dns_chart_name" {
#   value = module.external_dns_deployment.chart_name
# }

# output "external_dns_namespace" {
#   value = module.external_dns_deployment.namespace
# }

# output "cert_manager_chart_name" {
#   value = module.cert_manager.chart_name
# }

# output "cert_manager_namespace" {
#   value = module.cert_manager.namespace
# }

output "nameservers" {
  value = module.zone.route53_zone_name_servers
}