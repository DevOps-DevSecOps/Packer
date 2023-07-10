packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variables {
  region = "us-west-2"
  ssh = "root"
  ami = "ami-075826f0c65a2c4b1"
}

source "amazon-ebs" "example" {
  source_ami    = "${var.ami}"
  instance_type = "t2.micro"
  ami_name      = "ami-amazon"
  region        = "${var.region}"
  ssh_username  = "${var.ssh}"

  tags = {
    "Name" = "PACKER-DEMO"
  }
 
  tag {
    key = "name"
    value = "packer_ami"
  }

}

build {
  sources = [ "source.amazon-ebs.example" ]
}


