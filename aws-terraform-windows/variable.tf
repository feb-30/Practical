variable "accessKey" {}
variable "secretKey" {}
variable "region" {}
variable "instanceUsername" {}
variable "instancePassword" {}
variable "instance_type" {}
variable "privateKey" {}
variable "publickey" {}

variable "vpcNetworkAddress" {}
variable "subnetNetworkAddress" {}

variable "windowsAmi" {
  type = map(string)
  default = {
    eu-west-1 = "ami-0e2afec765bb99e9d"
  }
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