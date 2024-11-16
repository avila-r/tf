terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "r.avila-sa1-terraform-remote-states"
    key    = "example/terraform.tfstate"
    region = "sa-east-1"
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
