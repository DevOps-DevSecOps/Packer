// To make Packer read these variables from the environment into the var object,
// set the environment variables to have the same name as the declared
// variables, with the prefix PKR_VAR_.

// There are other ways to [set variables](/packer/docs/templates/hcl_templates/variables#assigning-values-to-build-variables)
// including from a var file or as a command argument.

// export PKR_VAR_aws_access_key=$YOURKEY
variable "aws_access_key" {
  type = string
  // default = "hardcoded_key"
  default = "AKIARO64KQTVUMJKUDMX"
  description = "AWS access key"
  sensitive = true
}

// export PKR_VAR_aws_secret_key=$YOURSECRETKEY
variable "aws_secret_key" {
  type = string
  // default = "hardcoded_secret_key"
  default = "7+r7P+VPCaxDSIAcAU18CJu4038DQcereJor4cAW"
  description = "AWS secret key"
  sensitive = true
}

variable "image_id" {
  type        = string
  description = "The ID of the machine image (AMI) to use for the server."
}

source "amazon-ebs" "basic-example" {
  access_key = var.aws_access_key
  secret_key =  var.aws_secret_key
  region =  "us-west-2"
  source_ami =  var.image_id
  instance_type =  "t2.micro"
  ssh_username =  "ubuntu"
  ami_name =  "packer_AWS {{timestamp}}"
  tags = {
    OS_Version = "Ubuntu"
    Release = "Latest"
  }
}

build {
  sources = [
    "source.amazon-ebs.basic-example"
  ]
}

