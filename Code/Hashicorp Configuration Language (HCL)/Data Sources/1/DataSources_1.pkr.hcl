variable "aws_region"{
  type    = string
  default = "us-west-1"
}

variable "aws_access_key"{
  type = string
}

variable "aws_secret_key"{
  type = string
}

data "amazon-ami" "ubuntu" {

  filters = {
    name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }

  most_recent = true
  owners      = ["099720109477"]

  region      = var.aws_region
  access_key  = var.aws_access_key
  secret_key  = var.aws_secret_key
}

source "amazon-ebs" "example" {
    region           = var.aws_region
    instance_type    = "t2.micro"
    source_ami       = data.amazon-ami.ubuntu.id
    ami_name         = "test-ansible-packer"
    ssh_username     = "ubuntu"
    tags = {
      Name = "Packer-DataSource"
    }
}

build {
    sources = [
        "source.amazon-ebs.example",
    ]

    provisioner "ansible" {
      playbook_file   = "./playbooks/playbook_1.yml"
    }
}

