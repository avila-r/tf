resource "aws_eip" "avila_cli_vpc_ngw_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "avila-cli-vpc-ngw" {
  #   connectivity_type = "private"
  allocation_id = aws_eip.avila_cli_vpc_ngw_eip.id
  subnet_id     = aws_subnet.avila-cli-vpc-subnet-public-01.id

  tags = {
    Name = "avila-cli-vpc-ngw"
  }

  depends_on = [aws_internet_gateway.avila-cli-vpc-igw]
}

resource "aws_route_table" "avila-cli-vpc-pvt-rtb" {
  vpc_id = aws_vpc.avila-cli-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.avila-cli-vpc-ngw.id
  }

  tags = {
    Name = "avila-cli-vpc-pvt-rtb"
  }
}

resource "aws_route_table_association" "pvt-rtb-assc-01" {
  subnet_id      = aws_subnet.avila-cli-vpc-subnet-private-01.id
  route_table_id = aws_route_table.avila-cli-vpc-pvt-rtb.id
}

resource "aws_route_table_association" "pvt-rtb-assc-02" {
  subnet_id      = aws_subnet.avila-cli-vpc-subnet-private-02.id
  route_table_id = aws_route_table.avila-cli-vpc-pvt-rtb.id
}
