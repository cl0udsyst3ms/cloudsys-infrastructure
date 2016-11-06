#!/bin/bash

logger "Install ansible"

add-apt-repository -y ppa:ansible/ansible
apt-get install -y ansible
