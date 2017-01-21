/* ECS IAM role and policies */

resource "aws_iam_role" "ecs_iam_role" {
    name = "ecs_iam_role_${var.environment}"
    path = "/"
    assume_role_policy = "${file("${path.module}/policies/ecs-role.json")}"
}

/*
 * EC2 container instance role & policy
 */
resource "aws_iam_role_policy" "ecs_instance_role_policy" {
  name     = "ecs_instance_role_policy"
  policy   = "${file("${path.module}/policies/ecs-instance-role-policy.json")}"
  role     = "${aws_iam_role.ecs_iam_role.id}"
}

/* Create IAM Instance Profile
 * IAM profile to be used in auto-scaling launch configuration.
 */
resource "aws_iam_instance_profile" "ecs_iam_profile" {
  name  = "ecs_instance_profile_${var.environment}"
  path  = "/"
  roles = ["${aws_iam_role.ecs_iam_role.name}"]
}

/* ECS service scheduler role */
resource "aws_iam_role_policy" "ecs_service_role_policy" {
  name     = "ecs_service_role_policy"
  policy   = "${file("${path.module}/policies/ecs-service-role-policy.json")}"
  role     = "${aws_iam_role.ecs_iam_role.id}"
}

resource "aws_iam_role_policy_attachment" "attach_ecs_read_only_to_ecs_role" {
    role = "${aws_iam_role.ecs_iam_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "attach_S3_read_only_to_ecs_role" {
    role = "${aws_iam_role.ecs_iam_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

/*
 * Create Security Group (SG) for the ECS to use.
 */
resource "aws_security_group" "ecs_sg" {
    name        = "ecs_sg"
    description = "SG"
    vpc_id      = "${var.vpc_id}"

    # INBOUND RULES
    ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "TCP"
      cidr_blocks = ["${var.vpn_gateway}"]
    }

    ingress {
      from_port   = 32768
      to_port     = 60999
      protocol    = "TCP"
      #security_groups = ["${aws_security_group.ecs_sg.id}"]
      self        = true
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
      Name        = "ecs_sg"
      Environment = "${var.environment}"
      Role        = "ecs_docker"
      Creator     = "terraform"
    }
}



