provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_instance" "simple-dev-instance" {
  count = "${var.simple_ec2_count}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.instance_az}"
  ami = "${data.aws_ami.amzn_ami_lookup.id}"
  vpc_security_group_ids = ["${aws_security_group.remote-access.id}"]
  associate_public_ip_address = "${var.public_ip_boolean}"
  subnet_id = "${var.subnet_id}"
  key_name = "${aws_key_pair.simple-key-pair.key_name}"
  iam_instance_profile = "${var.iam_profile}"

  tags {
    Name = "${element(var.instance_function_name, count.index)}"
  }
}

resource "aws_key_pair" "simple-key-pair" {
  key_name = "${var.pub-ssh-name}"
  public_key = "${file("${var.pub-ssh-file}")}"
}

#~~~~~~~~~~~~~~~~~~~~~
#Security group setup
#~~~~~~~~~~~~~~~~~~~~~

resource "aws_security_group" "remote-access" {
  name = "remote-access-sg"
  vpc_id = "${var.vpc_id}"
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
