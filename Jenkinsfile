pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                // All args must be named
                git url: 'https://github.com/BeBhavesh/pipeline-proj.git', branch: 'main'
            }
        }

        stage('Build Maven Project') {
            steps {
                sh 'mvn clean install'
            }
        }

        
        stage('Build Docker Image') {
            steps {
                sh '''
      #!/bin/bash
      docker build -t my-app-image .
    '''
  }
}


        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                      echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                      docker push your-image-name:${env.BUILD_NUMBER}
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed — check the logs.'
        }
    }
}
