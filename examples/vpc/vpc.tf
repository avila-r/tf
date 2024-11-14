resource "aws_vpc" "main" {
  //             ^^^^^^ any identifier name

  cidr_block = var.base_cidr_block

  tags = {
    Name = "example-vpc"
  }
}

resource "aws_subnet" "public_subnets" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.main.id
  availability_zone = var.availability_zones[count.index]

  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 3, count.index)

  tags = {
    Name = "example-public-subnet-0${(count.index + 1)}"
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.main.id
  availability_zone = var.availability_zones[count.index]

  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 3, count.index + length(var.availability_zones))

  tags = {
    Name = "example-private-subnet-0${(count.index + 1)}"
  }
}
