data "amazon-ami" "example" {
    filters = {
        virtualization-type = "hvm"
        name = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
        root-device-type = "ebs"
    }
    owners = ["099720109477"]
    most_recent = true
}

locals {
  source_ami_id = data.amazon-ami.example.id
  source_ami_name = data.amazon-ami.example.name
}

source "amazon-ebs" "basic-example" {
  region = "us-west-2"
  ssh_username = "ubuntu"
  ami_name = "packer-ami"
  instance_type = "t2.medium"
  source_ami = local.source_ami_id
  tags = {
    Name = "PACKER"
  }
}

build {
  name    = "Packer-Examples"
  sources = [
    "source.amazon-ebs.basic-example"
  ]
}


