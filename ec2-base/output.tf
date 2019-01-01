output "ec2_public_ip" {
  value = "${aws_instance.simple-dev-instance.public_ip}"
}

output "simple_ec2_id" {
  value = "${aws_instance.simple-dev-instance.id}"
}
