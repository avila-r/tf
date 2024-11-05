variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(object({
    id                    = string
    vpc_id                = string
    cidr_block            = string
  }))
}

variable "private_subnets" {
  type = list(object({
    id                    = string
    vpc_id                = string
    cidr_block            = string
  }))
}
