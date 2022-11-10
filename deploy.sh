#!/bin/bash

scp -i "id_rsa" /var/lib/jenkins/workspace/Dev8200/docker-compose-prod.yaml \
ec2-user@172.31.24.68:/home/ec2-user/

