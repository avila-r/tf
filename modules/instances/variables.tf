variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(object)
}

variable "private_subnets" {
  type = list(object)
}
