provider "aws" {
  region = "${var.aws_region}"
#  shared_credentials_file = "~/.aws/credentials"
#  profile = "cloudsys"
}

provider "vault" {
  address = "http://7.7.7.73:8200" 
  token   = "345a512b-6bc5-eb2c-f196-c779d81c83d0"
  skip_tls_verify = "true"
}

module "network" {
  source = "modules/network"

  vpc_cidr        = "${var.vpc_cidr}"
  AZs             = "${var.AZs}"
}

