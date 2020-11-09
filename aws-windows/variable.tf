variable "accessKey" {
  default = "AKIAJC52CCCJTM46NDBA"
}

variable "secretKey" {
  default = "pg27p+owdivuCC7jNw2DSisKaDUqpjLC4QTcCUcc"
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
  default = "test"
}

variable "publickey" {
  default = "test.pub"
}

variable "instanceUsername" {
  default = "Terraform"
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