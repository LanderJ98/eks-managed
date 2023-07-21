output "subnet_ids" {
    value = module.vpc_eks.subnet_ids
}

output "cluster_id" {
    value = module.eks_cluster.cluster_id
}

output "cluster_arn" {
    value = module.eks_cluster.cluster_arn
}

output "cluster_certificate_authority_data" {
    value = module.eks_cluster.cluster_certificate_authority_data
}

output "cluster_endpoint" {
    value = module.eks_cluster.cluster_endpoint
}