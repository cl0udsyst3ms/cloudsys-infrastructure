provider "aws" {
        region = "${var.aws_region}"
}

module "network" {
  source = "modules/network"

  vpc_cidr       = "${var.vpc_cidr}"
}

