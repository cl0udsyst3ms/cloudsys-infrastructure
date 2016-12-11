resource "aws_instance" "core_server" {
    ami           = "ami-3e713f4d"
    count         = 1
    instance_type = "t2.micro"
    key_name      = "DevSSH"
    subnet_id     = "${var.dmz_subnet_id}"
    vpc_security_group_ids      = ["${aws_security_group.vpn_sg.id}"]
    associate_public_ip_address = "true"
    user_data                   = "${data.template_file.core_user_data.rendered}"

    tags {
        Name    = "core.home.co.uk"
        Creator = "terraform"
        Role    = "Cron server & VPN endpoint"
    }
}

data "template_file" "core_user_data" {
    template = "${file("${path.module}/bin/user_data_core.sh")}"
}
