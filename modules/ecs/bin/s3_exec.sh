#!/bin/bash

# Setup AWSCLI tool
yum install epel-release -y
yum install python-pip -y
pip-python install awscli
ln -s /usr/local/bin/aws /usr/bin/aws

mkdir -p /var/log/app/

# Call S3 based user_data.sh - main ecs user_data script
logger "Executing S3 user_data script"
aws s3 cp s3://ligatest-user-data-scripts/${environment}/ecs/common_settings_user_data.sh common_settings_user_data_alb.sh
bash -x common_settings_user_data_alb.sh &> /var/log/app/common_settings_user_data_alb.log

