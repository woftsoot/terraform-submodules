provider "aws" {
  region = var.aws_region
}

#~~~~~~~~~~~
#VPC Resource
#~~~~~~~~~~~

resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "Primary VPC"
  }
}

#~~~~~~~~~~~
#Subnet Resources
#2 Pub, 2 Priv
#~~~~~~~~~~~
resource "aws_subnet" "public_subnet_a" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_a_cidr
  availability_zone = var.sub_a_region

  tags = {
    Name = "Public Subnet A"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_b_cidr
  availability_zone = var.sub_b_region

  tags = {
    Name = "Public Subnet B"
  }
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.private_subnet_a_cidr
  availability_zone = var.sub_a_region

  tags = {
    Name = "Private Subnet A"
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.private_subnet_b_cidr
  availability_zone = var.sub_b_region

  tags = {
    Name = "Private Subnet B"
  }
}

#~~~~~~~~~~~
#VPC IGW
#~~~~~~~~~~~

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main"
  }
}

#~~~~~~~~~~~
#EIP
#~~~~~~~~~~~

resource "aws_eip" "pub_sub_a_nat_eip" {
  vpc = false
  depends_on = [aws_internet_gateway.vpc_igw]
}

resource "aws_eip" "pub_sub_b_nat_eip" {
  vpc = false
  depends_on = [aws_internet_gateway.vpc_igw]
}

#~~~~~~~~~~~
#Public Subnet NAT Gateways
#~~~~~~~~~~~

resource "aws_nat_gateway" "pub_sub_a_nat_gateway" {
  allocation_id = aws_eip.pub_sub_a_nat_eip.id
  subnet_id = aws_subnet.public_subnet_a.id

  depends_on = [aws_internet_gateway.vpc_igw]

  tags = {
    Name = "Public Subnet A NAT"
  }
}

resource "aws_nat_gateway" "pub_sub_b_nat_gateway" {
  allocation_id = aws_eip.pub_sub_b_nat_eip.id
  subnet_id = aws_subnet.public_subnet_b.id

  depends_on = [aws_internet_gateway.vpc_igw]

  tags = {
    Name = "Public Subnet B NAT"
  }
}

#~~~~~~~~~~
#VPC Main Route Table and Associations
#~~~~~~~~~~

resource "aws_route" "igw_route" {
  route_table_id = aws_vpc.main_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.vpc_igw.id
}

#~~~~~~~~~~
#Priv-Pub Routing Tables and Associations (A)
#~~~~~~~~~~

resource "aws_route_table" "priv_pub_table_a" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route" "priv_pub_route_a" {
  route_table_id = aws_route_table.priv_pub_table_a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.pub_sub_a_nat_gateway.id
}

resource "aws_route_table_association" "subnet_table_a" {
  subnet_id = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.priv_pub_table_a.id
}

#~~~~~~~~~~
#Priv-Pub Routing Tables and Associations (B)
#~~~~~~~~~~

resource "aws_route_table" "priv_pub_table_b" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route" "priv_pub_route_b" {
  route_table_id = aws_route_table.priv_pub_table_b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.pub_sub_b_nat_gateway.id
}

resource "aws_route_table_association" "subnet_table_b" {
  subnet_id = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.priv_pub_table_b.id
}
