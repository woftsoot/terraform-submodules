provider "aws" {
  region = "us-east-1"
}

#~~~~~~~~~~~
#VPC Resource
#~~~~~~~~~~~

resource "aws_vpc" "main_vpc" {
  cidr_block = "${var.vpc_cidr}"
}

#~~~~~~~~~~~
#Subnet Resources
#2 Pub, 2 Priv
#~~~~~~~~~~~
resource "aws_subnet" "public_subnet_a" {
  vpc_id = "${aws_vpc.main_vpc.id}"
  cidr_block = "${var.public_subnet_a_cidr}"
  availability_zone = "${var.sub_a_region}"
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id = "${aws_vpc.main_vpc.id}"
  cidr_block = "${var.public_subnet_b_cidr}"
  availability_zone = "${var.sub_b_region}"
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id = "${aws_vpc.main_vpc.id}"
  cidr_block = "${var.private_subnet_a_cidr}"
  availability_zone = "${var.sub_a_region}"
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id = "${aws_vpc.main_vpc.id}"
  cidr_block = "${var.private_subnet_b_cidr}"
  availability_zone = "${var.sub_b_region}"
}

#~~~~~~~~~~~
#VPC IGW
#~~~~~~~~~~~

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  tags = {
    Name = "main"
  }
}

#~~~~~~~~~~
#VPC Route Table and Associations
#~~~~~~~~~~

resource "aws_route" "igw_route" {
  route_table_id = "${aws_vpc.main_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.vpc_igw.id}"
}
