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
  source_ami    = "${var.amis}"
  ssh_username = "ubuntu"
}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
}

variable "amis" {
  type = map(string)
  default = {
    "us-east-1" = "ami-b374d5a5"
    "us-west-2" = "ami-0e21f10bcf3ea0940"
  }
}
