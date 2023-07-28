module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name                   = var.cluster_name
  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }


  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets


  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = var.default_instance_types

    attach_cluster_primary_security_group = true
  }

  eks_managed_node_groups = {
    green = {
      min_size     = 3
      max_size     = 7
      desired_size = 3

      instance_types = var.instance_types
      capacity_type  = "SPOT"
      labels = {
        Environment = var.environment
        GithubRepo  = var.github_repo_name
      }
    }
  }

  node_security_group_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = null
  }

  tags = local.tags
}