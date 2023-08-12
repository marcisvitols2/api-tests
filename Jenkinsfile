pipeline {
    agent any

    triggers{
        pollSCM('*/1 * * * *')
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
                sh "docker build -t marcisvitols/api-tests-base:latest . -f Dockerfile.base"
                sh "docker login -u marcisvitols -p marcis1995"
                sh "docker push marcisvitols/api-tests-base:latest"
            }
        }

        stage('docker-build-test-runner') {
            steps {
                echo 'Building runner image for api-tests'
                sh "docker build -t marcisvitols/api-tests-runner:latest . -f Dockerfile.runner"
                sh "docker login -u marcisvitols -p marcis1995"
                sh "docker push marcisvitols/api-tests-runner:latest"

            }
        }
    }
}
