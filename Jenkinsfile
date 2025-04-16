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
                // Build Docker image with Bash
                sh '''
                    #!/bin/bash
                    docker build -t my-app-image:latest .
                '''
            }
        }

        stage('Push Docker Image') {
            steps {
                // Use stored DockerHub password and push the image
                withCredentials([string(credentialsId: 'dockerhub-password', variable: 'DOCKER_HUB_PASSWORD')]) {
                    sh '''
                        #!/bin/bash
                        echo "$DOCKER_HUB_PASSWORD" | docker login -u bebhavi08 --password-stdin
                        docker push my-app-image:latest
                        docker logout
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

