variable "vpc_cidr" { }
variable "app_cidr" { default = "7.7.6.0/25,7.7.6.128/25" }
variable "db_cidr"  { default = "7.7.7.128/26,7.7.7.192/26" }
variable "AZs"      { }

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

resource "aws_subnet" "db_subnet" {
    vpc_id     = "${aws_vpc.development_vpc.id}"
    cidr_block = "${element(split(",", var.db_cidr), count.index)}"
    availability_zone = "${element(split(",", var.AZs), count.index)}"
    count             = "${length(split(",", var.db_cidr))}"

    tags {
        Name    = "db-subnet"
        Creator = "terraform"
    }
}

resource "aws_subnet" "app_subnet" {
    vpc_id     = "${aws_vpc.development_vpc.id}"
    cidr_block = "${element(split(",", var.app_cidr), count.index)}"
    availability_zone = "${element(split(",", var.AZs), count.index)}"
    count             = "${length(split(",", var.app_cidr))}"

    tags {
        Name    = "app-subnet"
        Creator = "terraform"
    }
}

# Variables
output "app_subnet_id"  { value = "${join(",", aws_subnet.app_subnet.*.id)}" }
output "dmz_subnet_id"  { value = "${aws_subnet.dmz_subnet.id}" }
output "db_subnet_id"   { value = "${join(",", aws_subnet.db_subnet.*.id)}" }
output "vpc_id"         { value = "${aws_vpc.development_vpc.id}" }
