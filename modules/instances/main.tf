# EC2 instance with a public IP in the public subnet
resource "aws_instance" "avila-cli-public-instance" {
  ami           = "ami-06b21ccaeff8cd686"
  instance_type = "t2.micro"

  vpc_security_group_ids = [
    aws_security_group.avila-cli-public-instance-sg.id
  ]

  subnet_id                   = var.public_subnets[0].id
  associate_public_ip_address = true # Assign a public IP

  tags = {
    Name = "avila-cli-public-instance"
  }
}

# EC2 instance without a public IP in the private subnet
resource "aws_instance" "avila-cli-private-instance" {
  ami           = "ami-06b21ccaeff8cd686"
  instance_type = "t2.micro"

  vpc_security_group_ids = [
    aws_security_group.avila-cli-private-instance-sg.id
  ]

  subnet_id                   = var.private_subnets[0].id
  associate_public_ip_address = false # No public IP assigned

  tags = {
    Name = "avila-cli-private-instance"
  }
}
