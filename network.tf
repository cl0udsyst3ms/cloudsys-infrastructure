provider "aws" {
        region = "${var.aws_region}"
}

module "network" {
  source = "modules/network"

  vpc_cidr        = "${var.vpc_cidr}"
  vpn_instance_id = "${module.core.vpn_instance_id}" 
  vpn_NIC_id      = "${module.core.vpn_NIC_id}" 
}

