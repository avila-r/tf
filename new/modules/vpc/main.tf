resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.254.254.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "new-vpc"
  }
}

resource "aws_subnet" "my_subnet_private_01" {
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.254.254.0/28"
}

resource "aws_subnet" "my_subnet_private_02" {
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.254.254.16/28"
}

resource "aws_subnet" "my_subnet_public_01" {
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.254.254.128/28"
}

resource "aws_subnet" "my_subnet_public_02" {
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.254.254.144/28"
}
