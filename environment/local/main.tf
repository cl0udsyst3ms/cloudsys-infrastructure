variable "aws_region" {  default = "us-west-2" }
variable "vpc_cidr"   { }


provider "aws" {
	region = "${var.aws_region}"
}

module "vpc" {
  source = "../../modules/network"

  vpc_cidr = "${var.vpc_cidr}"
  
}
