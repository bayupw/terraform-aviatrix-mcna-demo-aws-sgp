variable "aws_syd_supernet" {
  type    = string
  default = "10.1.0.0/16"
}

variable "aws_sgp_supernet" {
  type    = string
  default = "10.2.0.0/16"
}

variable "gcp_sgp_supernet" {
  type    = string
  default = "10.3.0.0/16"
}

variable "aws_account" {
  type    = string
  default = "aws-account"
}

variable "gcp_account" {
  type    = string
  default = "gcp-account"
}

variable "instance_username" {
  type    = string
  default = "ec2-user"
}

variable "instance_password" {
  type    = string
  default = "Aviatrix123#"
}