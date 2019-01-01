variable "priv-ssh-file" {
  description = "Private key file path for provisioner"
  default = ""
}

variable "file_provisioner_source" {
  description = "Source artifact directory"
  default = ""
}

variable "file_provisioner_destination" {
  description = "Destination artifact directory"
  default = ""
}

variable "provisioner_target" {
  description = "Target of file provisioner null resource"
  default = ""
}

variable "file_provisioner_enable" {
  description = "bool enables file provisioner"
  default = 0
}

variable "remote_exec_provisioner_enable" {
  description = "bool enables file provisioner"
  default = 0
}

variable "remote_exec_scripts" {
  description = "Scripts to execute with remote-exec provisioner"
  default = [""]
}
