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
                echo 'Building base image for api tests'
                sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                sh "docker build -t marcisvitols/api-tests-base:latest . -f Dockerfile.base"
                sh "docker push marcisvitols/api-tests-base:latest"
            }
        }

        stage('docker-build-test-runner') {
            steps {
                echo 'Building runner image for api-tests'
                sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                sh "docker build -t marcisvitols/api-tests-runner:latest . -f Dockerfile.runner"
                sh "docker push marcisvitols/api-tests-runner:latest"

            }
        }
    }
}
