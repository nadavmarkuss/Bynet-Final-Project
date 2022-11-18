#!/bin/bash
if [ "$#" -ne 1  ] ; then
    echo "Please insert only 1 argument" >&2
    exit 1
fi


MachineName=$1
echo "deploying to ${MachineName} machine..."

scp -i ~/.ssh/id_rsa /var/lib/jenkins/workspace/Dev8200/docker-compose-prod.yaml \
ec2-user@172.31.24.68:/home/ec2-user/

#scp -i ~/.ssh/id_rsa /var/lib/jenkins/workspace/Dev8200/docker-compose-prod.yaml \
#ec2-user@prod:/home/ec2-user/


docker-compose rm -f

ssh  -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no ec2-user@${MachineName} << EOF
  docker-compose -f docker-compose-prod.yaml down
  if [[ -n $(docker ps -a -q) ]]; then
    docker rm -f $(docker ps -a -q)
  fi
  docker-compose -f docker-compose-prod.yaml up -d
  sleep 15
EOF
  
