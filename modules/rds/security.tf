# SECURITY
##########

# Create Security Group (SG) 
#
resource "aws_security_group" "db_sg" {
   name        = "db_sg"
    description = "SG"
    vpc_id      = "${var.vpc_id}"

   # INBOUND RULES
   ingress {
      from_port   = 5432
      to_port     = 5432
      protocol    = "TCP"
      cidr_blocks = ["1.0.0.0/24"]
   }


  # OUTBOUND RULES
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  # TAGS
  tags {
        Name        = "db_sg"
        Environment = "${var.environment}"
        Role        = "database"
        Creator     = "terraform"
  }

}
