#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Lookup for most recent amzn ami
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
data "aws_ami" "amzn_ami_lookup" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }

  filter {
    name = "owner-id"
    values = ["137112412989"]
  }
}
