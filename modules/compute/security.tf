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
      cidr_blocks = ["2.123.18.177/32"]
  }
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_internal" {
  name = "allow_me"
  description = "Allow ssh inbound traffic"
  vpc_id = "${var.vpc_id}"
  ingress {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      security_groups = ["${aws_security_group.allow_admin_sg.id}"]
  }

  tags {
    Name = "allow_internal_ssh_traffic"
  }
}
