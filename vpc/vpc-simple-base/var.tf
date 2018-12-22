#~~~~~~~~~~~~
#Var Blocks
#~~~~~~~~~~~~

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "simple_sub_region" {
  default = "us-east-1a"
}

variable "simple_sub_cidr" {
  default = "10.0.1.0/24"
}

variable "aws_region" {
  default = "us-east-1"
}
