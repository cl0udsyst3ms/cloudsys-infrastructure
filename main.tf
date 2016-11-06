variable "aws_region" {  default = "eu-west-1" }
variable "vpc_cidr"   { }


provider "aws" {
	region = "${var.aws_region}"
}

module "network" {
  source = "modules/network"

  vpc_cidr       = "${var.vpc_cidr}"
}
module "compute" {
  source = "modules/compute"

  main_subnet_id = "${module.network.main_subnet_id}" 
}