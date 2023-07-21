terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
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

