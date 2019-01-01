resource "null_resource" "multi-provisioner" {
  count = "${var.file_provisioner_enable}"

  provisioner "file" {
    source = "${var.file_provisioner_source}"
    destination = "${var.file_provisioner_destination}"

    connection {
      host = "${var.provisioner_target}"
      type = "ssh"
      user = "ec2-user"
      private_key = "${file("${var.priv-ssh-file}")}"
    }
  }
}

resource "null_resource" "remote-exec-provisioner" {
  count = "${var.remote_exec_provisioner_enable}"

  provisioner "remote-exec" {

    scripts = ["${var.remote_exec_scripts}"]


    connection {
      host = "${var.provisioner_target}"
      type = "ssh"
      user = "ec2-user"
      private_key = "${file("${var.priv-ssh-file}")}"
    }
  }
}
