# Output for the VPC ID
output "main_vpc" {
  value = aws_vpc.avila-cli-vpc
}

# Output for the public subnets IDs
output "public_subnets" {
  value = [aws_subnet.avila-cli-vpc-subnet-public-01, aws_subnet.avila-cli-vpc-subnet-public-02]
}

# Output for the private subnets IDs
output "private_subnets" {
  value = [aws_subnet.avila-cli-vpc-subnet-private-01, aws_subnet.avila-cli-vpc-subnet-private-02]
}
