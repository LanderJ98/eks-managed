terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "azurerm" {
    resource_group_name  = "RG-TF-STATE"
    storage_account_name = "azjltfstate"
    container_name       = "terraform"
    key                  = "eks_managed/terraform.tfstate"
  }
}

provider "aws" {
  region = "eu-west-2"
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
      command     = "aws"
    }
  }
}