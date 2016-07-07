variable "vpc_cidr" { }

resource "aws_vpc" "development-vpc" {
  cidr_block = "${var.vpc_cidr}"

  tags {
    Name = "development-vpc"
  }
}

resource "aws_subnet" "main" {
    vpc_id = "${aws_vpc.development-vpc.id}"
    cidr_block = "7.7.7.0/25"

    tags {
        Name = "Main"
    }
}

output "main_subnet_id" { value = "${aws_subnet.main.id}" }
