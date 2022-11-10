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
                        dockerImagetag = docker.build registry + ":$BUILD_NUMBER"
                        dockerImageLatest = docker.build registry + ":latest"
                    }
                }
            }
        }
        stage('test') {
            steps{
                sh '''
                docker-compose up -d
                HTTP_STATUS=`curl -o /dev/null -s -w "%{http_code}\n" http://localhost:5000/` 
		               if [ $HTTP_STATUS -eq 200 ];
		               then
		      		        echo "TEST: SUCCES"
		               else
				            echo "TEST: FAIL"
				            exit 1
		               fi
                docker-compose down       
                '''
         
         
            }
         
       
        }
        stage('Deploy our image') {
            steps{
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImagetag.push()
                        dockerImageLatest.push()
                    }
                }
            }
        }
        stage('Cleaning up') {
            steps{
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
    }
}
