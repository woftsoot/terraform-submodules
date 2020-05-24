module "vpc" {
  source = "../vpc/vpc-simple-base"
}

module "ec2" {
  source = "../ec2-base"
  vpc_id = module.vpc.simple_vpc_id
  subnet_id = module.vpc.simple_sub_id
}