pipeline {
/*environment {
registry = "YourDockerhubAccount/YourRepository"
registryCredential = 'dockerhub_id'
dockerImage = ''
}*/
agent any
stages {

stage('Building our image') {
steps{
script {
//dockerImage = docker.build registry + ":$BUILD_NUMBER"
  echo "i"
}
}
}
stage('Deploy our image') {
steps{
script {
docker.withRegistry( '', registryCredential ) {
dockerImage.push()
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
