pipeline {
    agent any

    triggers{
        pollSCM('*/1 * * * *')
    }

    environment{
        DOCKER_PASSWORD = credentials('docker-password')
        DOCKER_USERNAME = credentials('docker-username')
    }
    stages {
        stage('docker build-test-base') {
            when{
                anyOf{
                    changeset 'Gemfile'
                    changeset 'Dockerfile.base'
                    changeset "Jenkinsfile"
                }
            }
            steps {
                buildDockerImage("marcisvitols/api-tests-base:latest", "Dockerfile.base")
        
            }
        }

        stage('docker-build-test-runner') {
            steps {
                buildDockerImage("marcisvitols/api-tests-runner:latest", "Dockerfile.runner")
                
            }
        }
    }
}

def buildDockerImage(String tag, String dockerfile){
    echo "Building ${tag} image for api-tests base ${dockerfile}"
    sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
    sh "docker build -t ${tag} . -f ${dockerfile}"
    sh "docker push ${tag}"
}
