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