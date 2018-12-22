#~~~~~~~~~~~~
#Var Blocks
#~~~~~~~~~~~~

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "sub_a_region" {
  default = "us-east-1a"
}

variable "sub_b_region" {
  default = "us-east-1b"
}

variable "private_subnet_a_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_b_cidr" {
  default = "10.0.2.0/24"
}

variable "public_subnet_a_cidr" {
  default = "10.0.11.0/24"
}

variable "public_subnet_b_cidr" {
  default = "10.0.12.0/24"
}

variable "aws_region" {
  default = "us-east-1"
}
