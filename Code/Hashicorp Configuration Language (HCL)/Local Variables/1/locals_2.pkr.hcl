packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# Define the common tags for all resources
locals {
  common_tags = {
    Component   = "awesome-app"
    Environment = "production"
  }
}

# Create a resource that blends the common tags with instance-specific tags.
source "amazon-ebs" "server" {
  ami_name = "kops_server"
  source_ami    = "ami-09ba3baaadcff5c02"
  instance_type = "t2.micro"
  ssh_username = "root"

  tags = "${merge(
    local.common_tags,
    {
      "Name" = "awesome-app-server",
      "Role" = "server"
    }
  )}"
}

build {
  sources = ["source.amazon-ebs.server"]
}

