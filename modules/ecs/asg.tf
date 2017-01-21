#
# Launch configuration used by autoscaling group
#

resource "aws_launch_configuration" "docker_lc" {
  image_id             = "${var.ec2_instance_ami}"
  instance_type        = "${var.instance_type}"
  key_name             = "${var.main_ssh_key_pair}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs_iam_profile.id}"
  security_groups      = ["${aws_security_group.ecs_sg.id}"]
  user_data            = "${data.template_file.ecs_s3_exec.rendered}"
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "ecs_s3_exec" {
  template = "${file("${path.module}/bin/s3_exec.sh")}"

  vars {
    environment = "${var.environment}"
  }
}

data "vault_generic_secret" "postgres-pass" {
  path = "secret/postgres"
}

data "template_file" "docker_user_data" {
  template = "${file("${path.module}/bin/common_settings_user_data.sh")}"

  vars {
    docker_cluster_name = "${aws_ecs_cluster.docker_cluster.name}"
    kong_password       = "${data.vault_generic_secret.postgres-pass.data["kong_password"]}"
    environment         = "${var.environment}"
  }
}

resource "aws_s3_bucket_object" "common_settings_script_object_alb" {
    bucket  = "ligatest-user-data-scripts"
    key     = "${var.environment}/ecs/common_settings_user_data.sh"
    content = "${data.template_file.docker_user_data.rendered}"
    acl     = "bucket-owner-full-control"
}

resource "aws_autoscaling_group" "ecs" {
  name                 = "docker_asg_${var.environment}"
  launch_configuration = "${aws_launch_configuration.docker_lc.name}"
  vpc_zone_identifier  = ["${var.dmz_subnet_id}"]

  min_size             = "${var.min_size}"
  max_size             = "${var.max_size}"
  desired_capacity     = "${var.desired_capacity}"

  lifecycle {
    create_before_destroy = true
  }

 tag {
    key                     = "Name"
    value                   = "ecs.${var.environment}.co.uk"
    propagate_at_launch     = true
  }

  tag {
    key                     = "Environment"
    value                   = "${var.environment}"
    propagate_at_launch     = true
  }

  tag {
    key                     = "Role"
    value                   = "ecs_docker"
    propagate_at_launch     = true
  }

  tag {
    key                     = "Creator"
    value                   = "terraform"
    propagate_at_launch     = true
  }
}

resource "random_id" "hashi" {
  byte_length = 8
}

# ECS service cluster
resource "aws_ecs_cluster" "docker_cluster" {
  name = "${var.cluster_name}-${random_id.hashi.b64}"
  lifecycle {
    create_before_destroy = true
  }
}

# vim: set ts=2:
