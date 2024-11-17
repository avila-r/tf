resource "aws_vpc" "main" {
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
    Name = "${aws_vpc.main.tags["Name"]}-public-subnet-0${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.main.id
  availability_zone = var.availability_zones[count.index]

  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 3, count.index + length(var.availability_zones))

  tags = {
    Name = "${aws_vpc.main.tags["Name"]}-private-subnet-0${count.index + 1}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${aws_vpc.main.tags["Name"]}-igw"
  }
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${aws_vpc.main.tags["Name"]}-public-rtb"
  }
}

resource "aws_route_table_association" "public_associations" {
  count          = length(aws_subnet.public_subnets)
  route_table_id = aws_route_table.public_rtb.id
  subnet_id      = aws_subnet.public_subnets[count.index].id
}
