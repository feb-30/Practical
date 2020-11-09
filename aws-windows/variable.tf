variable "accessKey" {
  default = ""
}

variable "secretKey" {
  default = ""
}

variable "region" {
  default = "eu-west-1"
}

variable "windowsAmi" {
  type = map(string)
  default = {
    eu-west-1 = "ami-0e2afec765bb99e9d"
  }
}

variable "privateKey" {
  default = "ssh/test"
}

variable "publickey" {
  default = "ssh/test.pub"
}

variable "instanceUsername" {
  default = "terraformuser"
}

variable "instancePassword" {
  default = "Password@123"
}


variable "ports" {
  type = map(list(string))
  default = {
    "443"  = ["0.0.0.0/0"]
    "5985" = ["0.0.0.0/0"]
    "5986" = ["0.0.0.0/0"]
    "3389" = ["0.0.0.0/0"]
  }
}


variable "instance_type" {
  default = "t2.micro"
}