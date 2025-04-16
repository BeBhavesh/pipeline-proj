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
    withCredentials([string(credentialsId: 'dockerhub-password', variable: 'DOCKER_HUB_PASSWORD')]) {
      sh '''
        #!/bin/bash
        echo "$DOCKER_HUB_PASSWORD" | docker login -u bebhavi08 --password-stdin
        docker push my-app-image
      '''
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
