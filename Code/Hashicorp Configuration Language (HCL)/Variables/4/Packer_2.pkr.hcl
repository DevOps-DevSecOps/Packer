packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.1.5"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "${var.ami}"
  instance_type = "${var.type}"
  region        = "${var.region}"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = "${var.boolean}"
    owners      = "${var.owners}"
  }
  ssh_username = "${var.ssh_user}"
}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
}
