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

  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, length(var.availability_zones), count.index)

  tags = {
    Name = "example-public-subnet-0${(count.index + 1)}"
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.main.id
  availability_zone = var.availability_zones[count.index]

  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, length(var.availability_zones), count.index + length(var.availability_zones))

  tags = {
    Name = "example-private-subnet-0${(count.index + 1)}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${aws_vpc.main.tags["Name"]}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${aws_vpc.main.tags["Name"]}-public-route-table"
  }
}

resource "aws_route_table_association" "publics" {
  count = length(aws_subnet.public_subnets)

  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_subnets[count.index].id
}

resource "aws_security_group" "instances" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "instances-security-group"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "alb" {
  name = "allow-http-80-sg"

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "allow-http-80-sg"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "instances_inbounds" {
  type = "ingress"

  // To
  security_group_id = aws_security_group.instances.id
  // From
  source_security_group_id = aws_security_group.alb.id

  count = length(var.forwarded_ports)

  protocol  = "tcp"
  to_port   = var.forwarded_ports[count.index]
  from_port = var.forwarded_ports[count.index]
}

resource "aws_security_group_rule" "alb_outbound" {
  type = "egress"

  // From
  security_group_id = aws_security_group.alb.id
  // To
  source_security_group_id = aws_security_group.instances.id

  protocol  = "-1"
  from_port = 0
  to_port   = 0
}

resource "aws_key_pair" "main" {
  key_name   = "example-key-pair"
  public_key = file("example-key.pub")
}

resource "aws_lb" "instances" {
  subnets         = aws_subnet.public_subnets[*].id
  security_groups = [aws_security_group.alb.id]

  name               = "${aws_vpc.main.tags["Name"]}-load-balancer"
  load_balancer_type = "application"
  internal           = false
}

resource "aws_lb_target_group" "http" {
  name     = "${aws_vpc.main.tags["Name"]}-alb-target-group"
  vpc_id   = aws_vpc.main.id
  protocol = "HTTP"
  port     = 80
}

resource "aws_lb_target_group_attachment" "instances" {
  count            = length(aws_instance.vm)
  target_id        = aws_instance.vm[count.index].id
  target_group_arn = aws_lb_target_group.http.arn
  port             = 80
}
