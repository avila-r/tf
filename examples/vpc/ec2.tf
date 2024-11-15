data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
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

locals {
  available_type_in_az = { for az, details in data.aws_ec2_instance_type_offering.available_types : az => details.instance_type }
}

resource "aws_instance" "name" {
  count                       = length(aws_subnet.public_subnets)
  subnet_id                   = aws_subnet.public_subnets[count.index].id
  associate_public_ip_address = true

  ami = data.aws_ami.amazon_linux_2.id

  instance_type = local.available_type_in_az[aws_subnet.public_subnets[count.index].availability_zone]

  tags = {
    Name = "example-public-instance-0${count.index + 1}"
  }
}
