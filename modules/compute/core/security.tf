resource "aws_security_group" "vpn_sg" {
  name        = "vpn_sg"
  description = "Allow ssh inbound traffic"
  vpc_id      = "${var.vpc_id}"

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
