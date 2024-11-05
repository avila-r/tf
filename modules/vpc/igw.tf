resource "aws_internet_gateway" "avila-cli-vpc-igw" {
  vpc_id = aws_vpc.avila-cli-vpc.id

  tags = {
    Name = "avila-cli-vpc-igw"
  }
}

resource "aws_route_table" "avila-cli-vpc-pub-rtb" {
  vpc_id = aws_vpc.avila-cli-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.avila-cli-vpc-igw.id
  }

  tags = {
    Name = "avila-cli-vpc-pub-rtb"
  }
}

resource "aws_route_table_association" "pub-rtb-assc-01" {
  route_table_id = aws_route_table.avila-cli-vpc-pub-rtb.id
  subnet_id      = aws_subnet.avila-cli-vpc-subnet-public-01.id
}

resource "aws_route_table_association" "pub-rtb-assc-02" {
  route_table_id = aws_route_table.avila-cli-vpc-pub-rtb.id
  subnet_id      = aws_subnet.avila-cli-vpc-subnet-public-02.id
}
