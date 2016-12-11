variable "vpc_cidr" { }

resource "aws_vpc" "development_vpc" {
    cidr_block = "${var.vpc_cidr}"

    tags {
        Name    = "development-vpc"
        Creator = "terraform"
    }
}

resource "aws_subnet" "dmz_subnet" {
    vpc_id     = "${aws_vpc.development_vpc.id}"
    cidr_block = "7.7.7.0/25"

    tags {
        Name    = "dmz-subnet"
        Creator = "terraform"
    }
}

resource "aws_subnet" "app_subnet" {
    vpc_id     = "${aws_vpc.development_vpc.id}"
    cidr_block = "7.7.7.128/25"

    tags {
        Name    = "app-subnet"
        Creator = "terraform"
    }
}

# Variables
output "app_subnet_id"  { value = "${aws_subnet.app_subnet.id}" }
output "dmz_subnet_id"  { value = "${aws_subnet.dmz_subnet.id}" }
output "vpc_id"         { value = "${aws_vpc.development_vpc.id}" }
