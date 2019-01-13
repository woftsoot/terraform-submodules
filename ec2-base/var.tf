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
  description = "WARNING: SET TO 0.0.0.0/0. CHANGE BEFORE USE OR EXPLICITLY CHANGE IN MODULE CALL. Allows remote ssh access to appropriate host."
  default = "0.0.0.0/0"
}

variable "subnet_id" {
  description = "Subnet ID to build in"
}

variable "vpc_id" {
  description = "VPC ID to build in"
}

variable "pub-ssh-name" {
  description = "AWS Pub Key Name"
  default = ""
}

variable "pub-ssh-file" {
  description = "Public key file path"
  default = ""
}

variable "priv-ssh-file" {
  description = "Private key file path for provisioner"
  default = ""
}

variable "provisioner_source" {
  description = "Source artifact directory"
  default = ""
}

variable "provisioner_destination" {
  description = "Destination artifact directory"
  default = ""
}

variable "iam_profile" {
  description = "iam role to pass to ec2 instance"
  default = ""
}

variable "simple_ec2_count" {
  description = "Count of ec2 instances to spin up"
  default = 1
}

variable "instance_function_name" {
  description = "List of instance functions for naming purposes"
  default = []
}