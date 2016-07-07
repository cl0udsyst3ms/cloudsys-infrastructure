variable "main_subnet_id" { }

resource "aws_instance" "coreOS" {
    ami           = "ami-6666f915"
    instance_type = "t2.micro"
    key_name      = "DevSSH"
    subnet_id     = "${var.main_subnet_id}"
    associate_public_ip_address = "true"
    user_data     = "${file("${path.module}/bin/user_data.sh")}"

    tags {
        Name = "Developer's machine"
    }
}
