variables {
  region = "us-west-2"
  ssh = "root"
  ami = "ami-075826f0c65a2c4b1"
}

source "amazon-ebs" "example" {
  source_ami    = "${var.ami}"
  instance_type = "t2.micro"
  ami_name      = "ami-amazon"
  region        = "${var.region}"
  ssh_username  = "${var.ssh}"
 
  tag {
    key = "name"
    value = "packer_ami"
  }

}

build {
  name    = "learn-packer-ami"
  sources = [ "source.amazon-ebs.example" ]
}


