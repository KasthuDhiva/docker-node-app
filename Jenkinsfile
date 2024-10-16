pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/KasthuDhiva/docker-node-app.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("kasthurir/docker-node-app:latest")
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
                        docker.image("kasthurir/docker-node-app:latest").push("latest")
                    }
                }
            }
        }
        stage('Deploy to EC2') {
            steps {
                sshagent(['ec2-ssh-key']) {
                    sh 'ssh -o StrictHostKeyChecking=no ec2-user@54.81.213.184 sudo docker pull kasthurir/docker-node-app:latest'
                    sh 'ssh -o StrictHostKeyChecking=no ec2-user@54.81.213.184 sudo docker run -d -p 3000:3000 kasthurir/docker-node-app:latest'
                }
            }
        }
    }
}
