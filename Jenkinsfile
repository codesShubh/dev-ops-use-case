pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('shubham-docker')
        DOCKER_IMAGE = 'codes3shubh/nodejs-app'
    }

    stages {
        stage('Clone repository') {
            steps {
                // Pull code from GitHub
                git branch: 'master', url: 'https://github.com/codesShubh/dev-ops-use-case.git'
            }
        }

        stage('Build Docker image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Push Docker image') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    docker.withRegistry('https://registry.hub.docker.com', 'shubham-docker') {
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_NUMBER}").push()
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_NUMBER}").push('latest')
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up local images
            script {
                docker.image("${DOCKER_IMAGE}:${env.BUILD_NUMBER}").remove()
                docker.image("${DOCKER_IMAGE}:latest").remove()
            }
        }
    }
}
