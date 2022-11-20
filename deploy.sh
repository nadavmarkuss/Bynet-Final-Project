#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Please insert only 1 argument" >&2
	exit 1
fi

MachineName=$1
echo "deploying to ${MachineName} machine..."

scp -i ~/.ssh/id_rsa /var/lib/jenkins/workspace/Dev8200/docker-compose-prod.yaml \
ec2-user@${MachineName}:/home/ec2-user/

#docker-compose rm -f

ssh  -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no ec2-user@${MachineName} << EOF
  docker-compose -f docker-compose-prod.yaml down
  docker-compose -f docker-compose-prod.yaml up -d
  sleep 10
  docker container ls -a
EOF
  
if [ $MachineName==test ]; then
  	scp -i ~/.ssh/id_rsa /var/lib/jenkins/workspace/Dev8200/test.sh \
	ec2-user@test:/home/ec2-user/
	ssh  -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no ec2-user@test bash -e test.sh
fi	
  	
  	
  	
