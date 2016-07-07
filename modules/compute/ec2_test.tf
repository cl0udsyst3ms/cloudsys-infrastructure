variable "main_subnet_id" { }

resource "aws_instance" "web" {
    ami           = "ami-408c7f28"
    instance_type = "t2.micro"
    key_name      = "DevSSH"
    subnet_id     = "${var.main_subnet_id}"

    tags {
        Name = "Developer's machine"
    }
}
