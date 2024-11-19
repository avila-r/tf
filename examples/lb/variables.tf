variable "availability_zones" {
  type    = list(string)
  default = ["sa-east-1a", "sa-east-1b", "sa-east-1c"]
}

variable "base_cidr_block" {
  type    = string
  default = "10.254.254.0/24"
}

variable "forwarded_ports" {
  type    = list(string)
  default = [443, 80, 22]
}

data "aws_ec2_instance_type_offering" "available_types" {
  for_each = toset(var.availability_zones)

  filter {
    name   = "instance-type"
    values = ["t2.micro", "t3.micro"]
  }

  filter {
    name   = "location"
    values = [each.value]
  }

  location_type = "availability-zone"

  preferred_instance_types = ["t2.micro", "t3.micro"]
}

data "aws_ami" "amz_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-*"]
  }

  owners = ["amazon"]
}
