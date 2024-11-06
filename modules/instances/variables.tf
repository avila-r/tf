variable "vpc" {
  type = object({
    id                  = string
    cidr_block          = string
    ipv6_cidr_block     = string
    main_route_table_id = string
    tags                = map(string)
    tags_all            = map(string)
  })
}

variable "public_subnets" {
  type = list(object({
    id         = string
    vpc_id     = string
    cidr_block = string
  }))
}

variable "private_subnets" {
  type = list(object({
    id         = string
    vpc_id     = string
    cidr_block = string
  }))
}
