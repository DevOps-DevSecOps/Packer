source "amazon-ebs" "basic-example" {
  region = "us-west-2"
  ssh_username = "ubuntu"
  instance_type = "t2.medium"
  source_ami = "ami-0a6bca7f59689b615"
  ami_name = "packer-test-ami"
}

build {
  sources = ["sources.amazon-ebs.basic-example"]

# provisioner "shell" {
#     inline = ["..."]
# }
}

