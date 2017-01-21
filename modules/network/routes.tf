variable "dmz_subnet_id"  { }

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.development_vpc.id}"

    tags {
        Name    = "internet_gateway"
        Creator = "terraform"
    }
}

resource "aws_route_table" "dmz_rt" {
    vpc_id = "${aws_vpc.development_vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }

    tags {
        Name    = "dmz_rt"
        Creator = "terraform"
    }
}
    #count             = "${length(split(",", var.dmz_cidr))}"

resource "aws_route_table_association" "dm_rt_2_igw" {
    subnet_id      = "${element(split(",", var.dmz_subnet_id), count.index)}"
    route_table_id = "${aws_route_table.dmz_rt.id}"
    count          =  "${length(split(",", var.dmz_cidr))}"
}

