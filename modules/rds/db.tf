# VARIABLES
###########

variable "environment"                  { default = "live" }
variable "vpc_id"                       { }
variable "rds_instance_type"            { default = "db.t2.micro"}
variable "rds_user"                     { default = "vault_user"}
variable "rds_password"                 { default = "vault_password"}
variable "rds_storage_size"             { default = "5" }
variable "db_subnet_id"                 { }

# RESOURCES
###########

resource "random_id" "random" {
  byte_length = 4
}

resource "aws_db_subnet_group" "default" {
    name       = "main"
    subnet_ids = ["${split(",", var.db_subnet_id)}"]
    tags {
        Name   = "DB_Subnet_Group-${var.environment}"
    }
}

data "vault_generic_secret" "postgres-pass" {
  path = "secret/postgres"
}

resource "aws_db_instance" "db" {
  vpc_security_group_ids = ["${aws_security_group.db_sg.id}"]
  allocated_storage      = "${var.rds_storage_size}"
  multi_az               = "false"
  availability_zone      = "eu-west-1c"
  engine                 = "postgres"
  engine_version         = "9.5.2"
  instance_class         = "${var.rds_instance_type}"
  storage_type           = "gp2"
  name                   = "moja_liga"
  identifier             = "db-${random_id.random.dec}"
  username               = "${data.vault_generic_secret.postgres-pass.data["db_user"]}"
  password               = "${data.vault_generic_secret.postgres-pass.data["db_pass"]}"
  db_subnet_group_name   = "${aws_db_subnet_group.default.id}"
  parameter_group_name   = "default.postgres9.5"
  auto_minor_version_upgrade = "false"
  copy_tags_to_snapshot  = "true"

  tags {
    Name        = "RDS.${var.environment}.home.co.uk"
    Environment = "${var.environment}"
    Role        = "database"
    Creator     = "terraform"
  }
}

output vault_data { value = "${data.vault_generic_secret.postgres-pass.data}" } 
