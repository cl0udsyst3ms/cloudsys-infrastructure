/**
 * Container and task definitions for running the Recommender
 */

resource "aws_ecs_service" "docker_app" {
  name            = "docker_app"
  cluster         = "${aws_ecs_cluster.docker_cluster.id}"
  task_definition = "${aws_ecs_task_definition.docker_app_task.arn}"
  desired_count   = "${var.docker_app_desired_count}"
  iam_role        = "${aws_iam_role.ecs_iam_role.arn}"

  deployment_minimum_healthy_percent = "50"
  deployment_maximum_percent         = "100"

  depends_on = ["aws_iam_role_policy.ecs_service_role_policy"]

  load_balancer {
    target_group_arn = "${aws_alb_target_group.docker_app_tg.arn}"
    container_name = "docker_app"
    container_port = 9999
  }
}

resource "aws_ecs_task_definition" "docker_app_task" {
  family                = "docker_app"
  container_definitions = "${data.template_file.docker_app_task_template.rendered}"

  volume {
      name = "liga_app_config"
      host_path = "/etc/moja-liga/api"
  }
}

data "template_file" "docker_app_task_template" {
  template = "${file("${path.module}/task-definitions/docker_app.json")}"

  vars {
    docker_container_image = "sirk79/mojaligaapi:1.1"
    cpu                    = "${var.docker_app_cpu}"
    memory                 = "${var.docker_app_memory}"
    environment            = "${var.environment}"
  }
}
