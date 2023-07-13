variable "name" {
  type     = string
  default  = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
}

variable "owners" {
  type     = list(string)
  default  = ["099720109477"]
}

data "amazon-ami" "example" {
  filters = {
    name =  var.name
    root-device-type    = "ebs"
  }
  most_recent = true
  owners = var.owners
}

source "amazon-ebs" "example" {
  ami_name             = "packer_AWS {{timestamp}}"
  instance_type        = "t2.micro"
  ssh_username         = "ubuntu"
  source_ami           = data.amazon-ami.example.id
}

build {
  sources=["source.amazon-ebs.example"]
}


