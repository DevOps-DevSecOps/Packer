packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "example" {
  access_key    = "YOUR_AWS_ACCESS_KEY"
  secret_key    = "YOUR_AWS_SECRET_KEY"
  region        = "us-west-2"
  source_ami    = "ami-12345678"
  instance_type = "t2.micro"
  ssh_username  = "ubuntu"
}

build {
  name    = "example-ami"
  sources = ["source.amazon-ebs.example"]

  provisioner "shell" {
    inline = [
      "echo 'Hello, World!' > /tmp/hello.txt"
    ]
  }
}
