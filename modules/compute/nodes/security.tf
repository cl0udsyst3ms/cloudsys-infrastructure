resource "aws_security_group" "test_sg" {
  description = "empty"
  vpc_id = "${var.vpc_id}"
  ingress {
      from_port = 1200
      to_port   = 1200
      protocol  = "tcp"
      cidr_blocks = ["1.1.1.1/32"]
  }
}

resource "aws_security_group" "allow_admin_sg" {
  name = "allow_admin"
  description = "Allow ssh inbound traffic"
  vpc_id = "${var.vpc_id}"

  ingress {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      cidr_blocks = ["10.8.0.0/24", "7.7.6.0/23"]
  }

  egress {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_ssh_traffic"
  }
}
