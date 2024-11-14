resource "aws_instance" "public_instances" {
  count = length(data.aws_subnet.public_subnets)

  ami           = "ami-06b21ccaeff8cd686"
  instance_type = "t2.micro"

  tags = {
    Name = "new-instance-${count.index + 1}"
  }
}

resource "aws_instance" "private_instances" {
  count = length(data.aws_subnet.private_subnets)

  ami           = "ami-06b21ccaeff8cd686"
  instance_type = "t2.micro"

  tags = {
    Name = "new-instance-pvt-${count.index + 1}"
  }
}
