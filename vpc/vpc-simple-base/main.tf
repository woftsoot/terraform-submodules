provider "aws" {
  region = "${var.aws_region}"
}

#~~~~~~~~~~~
#VPC Resource
#~~~~~~~~~~~

resource "aws_vpc" "simple_vpc" {
  cidr_block = "${var.vpc_cidr}"

  tags {
    Name = "Simple VPC"
  }
}

#~~~~~~~~~~~
#Subnet Resources
#2 Pub, 2 Priv
#~~~~~~~~~~~
resource "aws_subnet" "simple_sub" {
  vpc_id = "${aws_vpc.simple_vpc.id}"
  cidr_block = "${var.simple_sub_cidr}"
  availability_zone = "${var.simple_sub_region}"

  tags {
    Name = "Simple Subnet"
  }
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

#~~~~~~~~~~~
#EIP
#~~~~~~~~~~~

resource "aws_eip" "simple_nat_eip" {
  vpc = true
  depends_on = ["aws_internet_gateway.simple_igw"]
}

#~~~~~~~~~~~
#NAT Gateway
#~~~~~~~~~~~

resource "aws_nat_gateway" "simple_nat_gateway" {
  allocation_id = "${aws_eip.simple_nat_eip.id}"
  subnet_id = "${aws_subnet.simple_sub.id}"

  depends_on = ["aws_internet_gateway.simple_igw"]

  tags = {
    Name = "Simple Gateway NAT"
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
