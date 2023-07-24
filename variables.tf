variable "cluster_name" {
  type        = string
  default     = "test-cluster"
  description = "Name of the cluster"
}

variable "default_instance_types" {
  type        = list(string)
  default     = ["t3.large"]
  description = "The default instance types"
}

variable "instance_types" {
  type        = list(string)
  default     = ["t3.medium"]
  description = "Override instance types"
}

variable "environment" {
  type    = string
  default = "test-lab"
}

variable "github_repo_name" {
  type    = string
  default = "eks-managed"
}

variable "vpc_name" {
  type        = string
  default     = "cluster-vpc"
  description = "VPC Name"
}

variable "cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
}
variable "public_subnets" {
  type    = list(string)
  default = ["10.10.4.0/24", "10.10.5.0/24", "10.10.6.0/24"]
}
variable "intra_subnets" {
  type    = list(string)
  default = ["10.10.7.0/24", "10.10.8.0/24", "10.10.9.0/24"]
}
variable "nginx_release_name" {
  type    = string
  default = "nginx"
}

variable "nginx_namespace" {
  type    = string
  default = "nginx"
}

variable "nginx_chart_name" {
  type    = string
  default = "ingress-nginx"
}

variable "nginx_repository" {
  type    = string
  default = "https://kubernetes.github.io/ingress-nginx"
}

variable "nginx_create_namespace" {
  type    = bool
  default = true
}

variable "external_dns_release_name" {
  type    = string
  default = "external-dns"
}

variable "external_dns_namespace" {
  type    = string
  default = "kube-system"
}

variable "external_dns_chart_name" {
  type    = string
  default = "external-dns"
}

variable "external_dns_repository" {
  type    = string
  default = "https://kubernetes-sigs.github.io/external-dns"
}

variable "external_dns_create_namespace" {
  type    = bool
  default = false
}