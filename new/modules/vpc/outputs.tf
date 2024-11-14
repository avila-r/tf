output "my_vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "public_subnets_ids" {
  value = {
    "subnet1" = aws_subnet.my_subnet_public_01.id,
    "subnet2" = aws_subnet.my_subnet_public_02.id
  }
}

output "private_subnets_ids" {
  value = {
    "subnet1" = aws_subnet.my_subnet_private_01.id,
    "subnet2" = aws_subnet.my_subnet_private_02.id
  }
}
