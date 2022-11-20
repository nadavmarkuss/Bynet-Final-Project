pipeline {
    agent any

    environment {
        registry = "dockerq12121212/app"
        registryCredential = 'dockerhub_id'
        dockerImagetag = ''
        dockerImageLatest=''
    }

    stages {

        stage('Building our image') {
            steps{
                dir("app") {
                    script {
			echo "build has started"
                        dockerImagetag = docker.build registry + ":$BUILD_NUMBER"
                        dockerImageLatest = docker.build registry + ":latest"
                    }
                }
            }
        }
        stage('test') {
            steps{
                sh '''
                docker-compose -f docker-compose-prod.yaml up
		sleep 10
		set -e
                HTTP_STATUS=`curl -o /dev/null -s -w "%{http_code}\n" http://localhost:5000/` 
		               if [ $HTTP_STATUS -eq 200 ];
		               then
		      		        echo "TEST: SUCCES"
		               else
				            echo "TEST: FAIL"
				            exit 1
		               fi
                docker-compose -f docker-compose-prod.yaml down       
                '''
         
         
            }
         
       
        }
        stage('Deploy to dockerhub') {
            steps{
                script {
                   	docker.withRegistry( '', registryCredential ) {
                        dockerImagetag.push()
                        dockerImageLatest.push()
                    }
                }
            }
        }
	  stage("deploy to test"){
		    steps{
			sh "chmod +x ./deploy.sh"
		    	sh'''
			bash deploy.sh test
			'''
		         }
	  }
	  stage("deploy to prod"){
		    steps{
			sh "chmod +x ./deploy.sh"
		    	sh'''
			bash deploy.sh prod
			'''
		         }
	  }
	  
        stage('Cleaning up') {
            steps{
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
    }
}
