# 🚀 DevOps CI/CD Pipeline Project with Jenkins, Maven, Docker, and DockerHub

This project demonstrates a complete CI/CD pipeline using **Jenkins**, **Maven**, **Docker**, and **DockerHub**. It automatically builds a Java application, creates a Docker image, and pushes the image to DockerHub.

---

## 📌 Project Structure

my-app/ ├── Dockerfile ├── Jenkinsfile ├── pom.xml └── src/ └── main/ └── java/ └── HelloWorld.java


---

## 🛠️ Tools & Technologies

- **Java**
- **Maven**
- **Docker**
- **Jenkins**
- **GitHub**
- **DockerHub**

---

## 📋 Workflow Overview

1. **Developer** commits code to **GitHub**.
2. **Jenkins** triggers the pipeline via webhook or polling.
3. Jenkins:
   - Clones the repository.
   - Builds the project using **Maven**.
   - Creates a **Docker image**.
   - Pushes the image to **DockerHub**.

---

## 📜 Jenkinsfile Overview

The pipeline is defined using a declarative `Jenkinsfile` located in the project’s root directory.

### Jenkinsfile Sample

```groovy
pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'dockerhub-creds'
        IMAGE_NAME = 'yourdockerhubusername/my-app'
    }

    stages {
        stage('Clone Code') {
            steps {
                git 'https://github.com/yourusername/your-repo.git'
            }
        }

        stage('Build Maven Project') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', "${DOCKER_HUB_CREDENTIALS}") {
                        docker.image("${IMAGE_NAME}").push('latest')
                    }
                }
            }
        }
    }
}
