provider "aws" {
  region = "${var.aws_region}"
}

provider "vault" {
  address = "http://7.7.7.73:8200" 
  token   = "345a512b-6bc5-eb2c-f196-c779d81c83d0"
  skip_tls_verify = "true"
/*
  ca_cert_file = "/home/miszcz/cl0udsys3ms/vault/certs/ca.pem"

  client_auth {
    cert_file = "/home/miszcz/cl0udsys3ms/vault/certs/terraform-client-cert.pem"
    key_file  = "/home/miszcz/cl0udsys3ms/vault/certs/vault-key.pem"
  }
*/
}

module "network" {
  source = "modules/network"

  vpc_cidr        = "${var.vpc_cidr}"
  AZs             = "${var.AZs}"
  vpn_instance_id = "${module.core.vpn_instance_id}" 
  vpn_NIC_id      = "${module.core.vpn_NIC_id}" 
}

