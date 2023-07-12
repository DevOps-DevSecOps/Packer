// To make Packer read these variables from the environment into the var object,
// set the environment variables to have the same name as the declared
// variables, with the prefix PKR_VAR_.

// There are other ways to [set variables](/packer/docs/templates/hcl_templates/variables#assigning-values-to-build-variables), including from a var
// file or as a command argument.

// export PKR_VAR_aws_access_key=$YOURKEY
variable "aws_access_key" {
  type = string
  // default = "hardcoded_key" // Not recommended !
  default = "AKIARO64KQTVUMJKUDMX" // Not recommended !
}

// export PKR_VAR_aws_secret_key=$YOURSECRETKEY
variable "aws_secret_key" {
  type = string
  // default = "hardcoded_secret_key" // Not recommended !
  default = "7+r7P+VPCaxDSIAcAU18CJu4038DQcereJor4cAW" // Not recommended !
}

source "amazon-ebs" "basic-example" {
  access_key = var.aws_access_key
  secret_key =  var.aws_secret_key
  region      = "us-west-1"
  ami_name = "example"
  instance_type    = "t2.micro"
  ssh_username     = "ubuntu"
  source_ami = "ami-09ce47f0125c337ef"
}

build {
  sources = [
    "source.amazon-ebs.basic-example"
  ]
}


