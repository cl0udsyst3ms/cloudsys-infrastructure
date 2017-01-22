#!/bin/bash

echo "Setting cluster name"
echo ECS_CLUSTER=${docker_cluster_name} >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true   >> /etc/ecs/ecs.config
echo test
cat <<EOT >> /etc/moja-liga/api/default.json 
{
   "server": {
       "host": "localhost",
       "port": 9999
   },
   "db": {
       "type": "postgres",
       "port": 5432,
       "host": "db-3288347112.cmwuvjr8mnqq.eu-west-1.rds.amazonaws.com",
       "user": "${kong_username}",
       "pass": "${kong_password}",
       "db": "moja_liga"
   },
   "db_options": {
       "maxConcurrentQueries": 100,
       "sync": { "force": true }
   }
}
EOT
