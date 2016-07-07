variable "aws_region" {
  default = "us-west-2"
}

provider "aws" {
	region = "${var.aws_region}"
}
