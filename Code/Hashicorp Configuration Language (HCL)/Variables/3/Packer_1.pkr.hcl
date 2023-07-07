packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "${var.ami}"
  instance_type = "${var.instance_type}"
  region        = "us-west-2"
  source_ami    = "ami-0e21f10bcf3ea0940"
  ssh_username = "ubuntu"
}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
}

variable "ami" {
  type = list
}

variable "instance_type" {
  default = ["t2.micro", "t2.small"]
}
