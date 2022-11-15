#!/bin/bash

scp -i "id_rsa" /var/lib/jenkins/workspace/Dev8200/docker-compose-prod.yaml \
ec2-user@172.31.24.68:/home/ec2-user/

ssh ec2-user@test docker-compose up
ssh ec2-user@test docker compose down
ssh ec2-user@test sleep 15
ssh ec2-user@test docker rmi(name of image)
ssh ec2-user@test system docker prune --volumes
