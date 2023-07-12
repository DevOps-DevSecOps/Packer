packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.6"
      source = "github.com/hashicorp/amazon"
    }
  }
}

variable "aws_access_key" {
  type = string
}

// export PKR_VAR_aws_secret_key=$YOURSECRETKEY
variable "aws_secret_key" {
  type = string
}

data "amazon-ami" "example" {
  filters = {
    virtualization-type = "hvm"
    name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    root-device-type    = "ebs"
  }
  owners      = ["099720109477"]
  most_recent = true

  # Access Configuration
  region      = "us-west-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

source "amazon-ebs" "basic-example" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "us-west-2"
  source_ami = data.amazon-ami.example.id
  instance_type    = "t2.micro"
  ami_name         = "packer"
  ssh_username     = "ubuntu"
  tags = {
    Name = "Packer-DataSource"
  }
}

build {
  sources = [
    "source.amazon-ebs.basic-example"
  ]

  provisioner "shell" {
    inline = ["echo Test > /tmp/test.txt"]
  }
}

