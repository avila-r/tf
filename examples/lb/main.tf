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
      owner      = "r. ávila"
      managed_by = "terraform"
    }
  }
}

resource "aws_instance" "vm" {
  count     = length(aws_subnet.public_subnets)
  subnet_id = aws_subnet.public_subnets[count.index].id

  tags = {
    Name = "example-instance"
  }

  ami = data.aws_ami.amz_2.id
  instance_type = local.available_type_in_az[
    aws_subnet.public_subnets[count.index].availability_zone
  ]

  key_name             = aws_key_pair.main.key_name
  iam_instance_profile = "ssh-support"

  vpc_security_group_ids = [
    aws_security_group.instances.id
  ]

  user_data = file("init.sh")
}
