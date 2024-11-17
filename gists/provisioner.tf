resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_security_group"
  }
}

resource "aws_key_pair" "gist-key-pair" {
  key_name   = "gist-key-pair"
  public_key = file("gist-key-pair.pub")
}

resource "aws_instance" "gist" {
  ami                         = "ami-0f16d0d3ac759edfa"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.gist-key-pair.key_name
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("gist-key-pair")
  }

  provisioner "remote-exec" {
    inline = [
      "echo public_ip: ${self.public_ip} >> /tmp/network_info.txt"
    ]
  }

  provisioner "file" {
    source      = "gist-key-pair.pub"
    destination = "/tmp/key.pub"
  }

  provisioner "file" {
    source      = "gist-key-pair"
    destination = "/tmp/key"
  }

  tags = {
    Name = "gist-vm"
  }
}
