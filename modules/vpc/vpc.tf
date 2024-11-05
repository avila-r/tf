resource "aws_vpc" "avila-cli-vpc" {
  cidr_block       = "10.254.254.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "avila-cli-vpc"
  }
}

# Public [us-east-1a] 
resource "aws_subnet" "avila-cli-vpc-subnet-public-01" {
  vpc_id            = aws_vpc.avila-cli-vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.254.254.128/28"

  tags = {
    Name = "avila-cli-vpc-subnet-public-01"
  }
}

# Public [us-east-1b] 
resource "aws_subnet" "avila-cli-vpc-subnet-public-02" {
  vpc_id            = aws_vpc.avila-cli-vpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.254.254.144/28"

  tags = {
    Name = "avila-cli-vpc-subnet-public-02"
  }
}

# Private [us-east-1a]
resource "aws_subnet" "avila-cli-vpc-subnet-private-01" {
  vpc_id            = aws_vpc.avila-cli-vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.254.254.0/28"

  tags = {
    Name = "avila-cli-vpc-subnet-private-01"
  }
}

# Private [us-east-1b]
resource "aws_subnet" "avila-cli-vpc-subnet-private-02" {
  vpc_id            = aws_vpc.avila-cli-vpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.254.254.16/28"

  tags = {
    Name = "avila-cli-vpc-subnet-private-02"
  }
}
