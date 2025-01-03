terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "instances" {
  source = "./modules/instances"

  vpc             = module.vpc.main_vpc
  public_subnets  = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets
}
