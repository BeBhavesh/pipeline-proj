pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout the project from GitHub
                git url: 'https://github.com/BeBhavesh/pipeline-proj.git', branch: 'main'
            }
        }

        stage('Build Maven Project') {
            steps {
                // Run Maven build
                sh 'mvn clean install'
            }
        }

        stage('Build Docker Image') {
            steps {
                withCredentials([
                    string(credentialsId: 'dockerhub-username', variable: 'DOCKER_HUB_USERNAME')
                ]) {
                    sh '''
                        #!/bin/bash
                        docker build -t $DOCKER_HUB_USERNAME/my-app-image:latest .
                    '''
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([
                    string(credentialsId: 'dockerhub-username', variable: 'DOCKER_HUB_USERNAME'),
                    string(credentialsId: 'dockerhub-password', variable: 'DOCKER_HUB_PASSWORD')
                ]) {
                    sh '''
                        #!/bin/bash
                        echo "$DOCKER_HUB_PASSWORD" | docker login -u "$DOCKER_HUB_USERNAME" --password-stdin
                        docker push $DOCKER_HUB_USERNAME/my-app-image
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed — check the logs.'
        }
    }
}
