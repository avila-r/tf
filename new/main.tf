provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "instances" {
  depends_on = [module.vpc]

  source = "./modules/instances"

  vpc_id              = module.vpc.my_vpc_id
  public_subnets_ids  = module.vpc.public_subnets_ids
  private_subnets_ids = module.vpc.private_subnets_ids
}
