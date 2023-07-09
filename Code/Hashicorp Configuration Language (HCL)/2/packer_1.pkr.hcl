packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "first-example" {
  ami_name      = "packer_1"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
  tag {
    key = "Name" 
    value = "PACKER-DEMO"
  }
}

source "amazon-ebs" "second-example" {
  ami_name      = "packer_2"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

source "amazon-ebs" "third-example" {
  ami_name      = "packer_3"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
  tags = {
    "Name" = "PACKER-DEMO"
  }
}

build {
  name = "my_build"
  sources = [
    "source.amazon-ebs.first-example",
  ]
  source "source.amazon-ebs.second-example" {
    // setting the name field allows you to rename the source only for this
    // build section. To match this builder, you need to use
    // second-example-local-name, not second-example
    name = "second-example-local-name"
  }

  provisioner "shell-local" {
    only   = ["amazon-ebs.first-example"]
    inline = ["echo I will only run for the first example source"]
  }

  provisioner "shell-local" {
    except = ["amazon-ebs.second-example-local-name"]
    inline = ["echo I will never run for the second example source"]
  }
}

build {
  sources = [
    "source.amazon-ebs.third-example",
  ]
}

# this file will result in Packer creating three builds named:
#  my_build.amazon-ebs.first-example
#  my_build.amazon-ebs.second-example
#  amazon-ebs.third-example

