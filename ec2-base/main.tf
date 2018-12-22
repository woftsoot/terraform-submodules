provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_instance" "test-instance" {
  instance_type = "${var.instance_type}"
  availability_zone = "${var.instance_az}"
  ami = "${data.aws_ami.amzn_ami_lookup.id}"
  vpc_security_group_ids = ["${aws_security_group.remote-access.id}"]
  associate_public_ip_address = "${var.public_ip_boolean}"
}

#~~~~~~~~~~~~~~~~~~~~~
#Security group setup
#~~~~~~~~~~~~~~~~~~~~~

resource "aws_security_group" "remote-access" {
  name = "remote-access-sg"
//vpc_id = "${aws_vpc.main_vpc.id}"
}

resource "aws_security_group_rule" "ssh_ingress" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["${var.remote_access_ip}"]
  security_group_id = "${aws_security_group.remote-access.id}"
}

resource "aws_security_group_rule" "egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.remote-access.id}"
}
