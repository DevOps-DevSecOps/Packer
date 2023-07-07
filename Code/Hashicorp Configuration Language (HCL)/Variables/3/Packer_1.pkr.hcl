packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "amazon_AMI"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami    = "${lookup(var.amis, var.region)}"
  ssh_username = "ubuntu"
  tags = {
    name = "Packer_AMI"
  }
}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
}

variable "region" {}
variable "amis" {
  type = map(string)
}
