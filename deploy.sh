#!/bin/bash

scp -i "id_rsa" /home/ec2-user/my-hello-world-app/docker-compose-prod.yaml \
ec2-user@172.31.24.68:/home/ec2-user/

