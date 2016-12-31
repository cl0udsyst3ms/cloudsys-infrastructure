#!/bin/bash

echo "Setting cluster name"
echo ECS_CLUSTER=${docker_cluster_name} >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true   >> /etc/ecs/ecs.config
