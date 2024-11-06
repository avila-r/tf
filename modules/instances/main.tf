resource "aws_key_pair" "avila-cli-kp" {
  key_name   = "avila-cli-kp"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDO68CFBf7GhpFaBaEZISIiLjrsi62i+qSQ0mxJSvYFbtUHBvPCT2HX2yy8rc/QmOrECtPTuG4FLtFokaaAa4aIZlG1K3Ocv5jpjHBOfdZVNmyREGGRkSSTOtNYjy9cyLP8XqPUsaLgqYXb40LRMvvM97nIRCoWbpbJVRepvhX1kZIVmmqSADCyUF8F8/dsSc4HCiJ/Szx8V52rPNC7abzbC6RCjTJci7JZHopnYORjgzpzYaMFh7glKJ/KnsOGOykIHpmMwIN+/lFlR48roAgzPCF06q4B9TLAiKjZXmH3N0LhEMBY/IjbWCxKowX5EuE1sXM5S/bzqFUzXwQ+17mtppvJNn4Hx85xFJxOcwz3im0Jl8q1fx5nTeCW1x18U6wy/8o2woq++LXK8NQcRyjwg4+P/Ngb9D8VRMLSr+V/CmE+aK82pHUyDQA4NKgi4Ep9qEF9Bp+4hmeGZozyGeNlu6tB3MSWBE37MhxsbdI9gx9472FOLaZdU0PTt4eY7/7H4rq90t2r/rmigUJyKR4q457sc2YU7LyNYTSafSbSso6NMgBIWUXd2nTDhk1EiOLWBZykiqYLtkKef5n7jNYH4LoLHKYKPxd7PFNAuSQQtHt5A7cv91ILodVNXTrRtbYsHHfW5LrQ1o1JvI8M2zKRN2PgKjwrQiXo7LlduxIB/Q== avila.dev@outlook.com"
}

# EC2 instance with a public IP in the public subnet
resource "aws_instance" "avila-cli-public-instance" {
  count         = length(var.public_subnets)
  ami           = "ami-06b21ccaeff8cd686"
  instance_type = "t2.micro"

  key_name = aws_key_pair.avila-cli-kp.key_name

  vpc_security_group_ids = [
    aws_security_group.avila-cli-public-instance-sg.id
  ]

  subnet_id                   = var.public_subnets[count.index].id
  associate_public_ip_address = true # Assign a public IP

  tags = {
    Name = "avila-cli-public-instance-0${count.index + 1}"
  }
}

# EC2 instance without a public IP in the private subnet
resource "aws_instance" "avila-cli-private-instance" {
  count         = length(var.private_subnets)
  ami           = "ami-06b21ccaeff8cd686"
  instance_type = "t2.micro"

  vpc_security_group_ids = [
    aws_security_group.avila-cli-private-instance-sg.id
  ]

  subnet_id                   = var.private_subnets[count.index].id
  associate_public_ip_address = false # No public IP assigned

  tags = {
    Name = "avila-cli-private-instance-0${count.index + 1}"
  }
}
