variable "availability_zones" {
  type    = list(string)
  default = ["sa-east-1a", "sa-east-1b", "sa-east-1c"]
}

variable "base_cidr_block" {
  type    = string
  default = "10.254.254.0/24"
}
