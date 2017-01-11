# VARIABLES
# Imported / received variables from the parent module tf file.
variable "environment"          { default = "live" }
variable "AZs"                  { default = "eu-west-1"}
variable "app_subnet_id"        { }
variable "vpc_id"               { }
variable "vpn_gateway"          { default = "7.7.7.73/32" }
variable "main_ssh_key_pair"    { default = "DevSSH"}
variable "ec2_instance_ami"     { default = "ami-8d7439fe" }
variable "cluster_name"         { default = "app" }
variable "instance_type"        { default = "t2.micro"}

variable "min_size"             { default = "0" }
variable "max_size"             { default = "1" }
variable "desired_capacity"     { default = "1" }

variable "docker_app_cpu"             { default = "21" }
variable "docker_app_memory"          { default = "300" }
variable "docker_app_desired_count"   { default = "1"}
variable "docker_app_image_version"   { default = "1.05"}

