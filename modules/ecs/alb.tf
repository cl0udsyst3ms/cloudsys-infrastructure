/* ALB for the docker_app */
resource "aws_alb" "docker_alb" {
  name               = "docker-alb-${var.environment}"
  internal           = true
  security_groups    = ["${aws_security_group.ecs_sg.id}"]
  subnets            = ["${split(",", var.app_subnet_id)}"]

  tags {
    Name        = "docker-alb"
    Environment = "${var.environment}"
    Role        = "ecs_docker"
    Creator     = "terraform"
  }
}

resource "aws_alb_target_group" "docker_app_tg" {
  name     = "docker-app-alb-tg-${var.environment}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    path = "/api-docs"
  }

}

resource "aws_alb_listener" "docker_listener" {
   load_balancer_arn = "${aws_alb.docker_alb.arn}"
   port = "80"
   protocol = "HTTP"

   default_action {
     target_group_arn = "${aws_alb_target_group.docker_app_tg.arn}"
     type = "forward"
   }
}

resource "aws_alb_listener_rule" "docker_app_listener_rule" {
  listener_arn = "${aws_alb_listener.docker_listener.arn}"
  priority = 100

  action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.docker_app_tg.arn}"
  }

  condition {
    field = "path-pattern"
    values = ["/v1/docker_app/*"]
  }
}

