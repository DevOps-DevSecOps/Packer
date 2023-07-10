variables {
  region = "us-west-2"
}

source "amazon-ebs" "example" {
  source_ami = "ami-075826f0c65a2c4b1"
  instance_type = "t2.micro"
  ami_name      = "ami-amazon"
  region        = "${var.region}"
  ssh_username = "root"
 
  tags = {
    "name" = "packer_ami"
  }

}

build {
  name    = "learn-packer-ami"
  sources = [ "source.amazon-ebs.example" ]
}


