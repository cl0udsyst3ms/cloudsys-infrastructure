#!/bin/bash

echo "Setting cluster name"
echo ECS_CLUSTER=${docker_cluster_name} >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE=true   >> /etc/ecs/ecs.config

echo "{
   "server": {
       "host": "localhost",
       "port": 9999
   },
   "db": {
       "type": "postgres",
       "port": 5432,
       "host": "db-3288347112.cmwuvjr8mnqq.eu-west-1.rds.amazonaws.com",
       "user": "kong",
       "pass": "<see_vault>",
       "db": "moja_liga"
   },
   "db_options": {
       "maxConcurrentQueries": 100,
       "sync": { "force": true }
   }
}
" > /etc/moja-liga/api/default.json
