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
    value = "PACKER-1"
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
  source_ami    = "ami-03f798e167993591d"
  ssh_username = "root"
  tags = {
    "Name" = "PACKER-3"
  }
}

source "amazon-ebs" "fourth-example" {
  ami_name      = "packer_4"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami    = "ami-093ad7b55b7ed7b75"
  ssh_username = "root"
  tags = {
    Name = "PACKER-4"
  }
}

build {
  sources = [
    "source.amazon-ebs.first-example",
    "source.amazon-ebs.second-example",
  ]
}

build {
  name    = "Packer-Examples-1"
  sources = ["source.amazon-ebs.third-example"]
}

build {
  name    = "Packer-Examples-2"
  sources = [ "source.amazon-ebs.fourth-example" ]
}

