terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "sa-east-1"

  default_tags {
    tags = {
      "owner"      = "r. ávila"
      "managed-by" = "terraform"
    }
  }
}

module "network" {
  source = "./network"
}
