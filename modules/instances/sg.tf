resource "aws_security_group" "avila-cli-public-instance-sg" {
  vpc_id      = var.vpc_id
  name        = "http-access"
  description = "HTTP access for avila-cli-public-instance"

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
}