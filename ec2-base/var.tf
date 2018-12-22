variable "aws_region" {
  default = "us-east-1"
}

variable "public_ip_boolean" {
  description = "Boolean attach public IP or not"
  default = false
}

variable "instance_az" {
  description = "AZ where you want to build the instance"
  default = "us-east-1a"
}

variable "instance_type" {
  description = "Type of instance to spin up"
  default = "t2.micro"
}

variable "remote_access_ip" {
  description = "WARNING: SET TO 0.0.0.0/0. CHANGE BEFORE USE. Allows remote ssh access to appropriate host."
  default = "0.0.0.0/0"
}
