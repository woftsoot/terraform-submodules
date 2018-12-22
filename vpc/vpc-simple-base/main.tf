provider "aws" {
  region = "${var.aws_region}"
}

#~~~~~~~~~~~
#VPC Resource
#~~~~~~~~~~~

resource "aws_vpc" "simple_vpc" {
  cidr_block = "${var.vpc_cidr}"
}

#~~~~~~~~~~~
#Subnet Resources
#2 Pub, 2 Priv
#~~~~~~~~~~~
resource "aws_subnet" "simple_sub" {
  vpc_id = "${aws_vpc.simple_vpc.id}"
  cidr_block = "${var.simple_sub_cidr}"
  availability_zone = "${var.simple_sub_region}"
}

#~~~~~~~~~~~
#VPC IGW
#~~~~~~~~~~~

resource "aws_internet_gateway" "simple_igw" {
  vpc_id = "${aws_vpc.simple_vpc.id}"

  tags = {
    Name = "simple-igw"
  }
}

#~~~~~~~~~~
#VPC Route Table and Associations
#~~~~~~~~~~

resource "aws_route" "igw_route" {
  route_table_id = "${aws_vpc.simple_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.simple_igw.id}"
}
