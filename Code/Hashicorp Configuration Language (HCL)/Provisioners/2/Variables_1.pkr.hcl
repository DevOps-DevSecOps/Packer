variable "ssh_user" {}

variable "region" { }

variable "ami" {
}

variable "type" {
  type = string
}

variable "boolean" {
  type = bool
  default = true
}

variable "owners" {
  type = list(string)
  default = ["099720109477"]
}

