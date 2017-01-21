variable "vpn_instance_id"    { }
variable "vpn_NIC_id"         { }

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

resource "aws_route_table_association" "dm_rt_2_igw" {
    subnet_id      = "${aws_subnet.dmz_subnet.id}"
    route_table_id = "${aws_route_table.dmz_rt.id}"
}
