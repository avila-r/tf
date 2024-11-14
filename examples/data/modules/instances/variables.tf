variable "vpc_id" {
  type = string
}

variable "public_subnets_ids" {
  type = map(string)
}

variable "private_subnets_ids" {
  type = map(string)
}

data "aws_vpc" "main_vpc" {
  id = var.vpc_id
}

data "aws_subnet" "public_subnets" {
  for_each = var.public_subnets_ids
  id       = each.value
}

data "aws_subnet" "private_subnets" {
  for_each = var.private_subnets_ids
  id       = each.value
}
