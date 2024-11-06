resource "aws_security_group" "avila-cli-public-instance-sg" {
  vpc_id      = var.vpc.id
  name        = "avila-cli-public-instance-sg"
  description = "Security group for avila-cli-public-instance"

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls" {
  security_group_id = aws_security_group.avila-cli-public-instance-sg.id
  cidr_ipv4         = var.vpc.cidr_block
 
  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.avila-cli-public-instance-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
}

resource "aws_security_group" "avila-cli-private-instance-sg" {
  vpc_id      = var.vpc.id
  name        = "avila-cli-private-instance-sg"
  description = "Security group for avila-cli-private-instance"

  tags = {
    Name = "allow_outbound"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound" {
  security_group_id = aws_security_group.avila-cli-private-instance-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
}
