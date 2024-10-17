Got it! Here’s the full **README.md** ready for direct copy-pasting into your GitHub repository:

---

# Dockerized Node.js Application with CI/CD Using Jenkins  

This project demonstrates how to create a simple Node.js web application, containerize it using Docker, and automate its deployment with a Jenkins CI/CD pipeline to an EC2 instance.

---

## Table of Contents  
- [Project Overview](#project-overview)  
- [Technologies Used](#technologies-used)  
- [Prerequisites](#prerequisites)  
- [Project Setup](#project-setup)  
  - [Step 1: Clone the Repository](#step-1-clone-the-repository)  
  - [Step 2: Build Docker Image](#step-2-build-docker-image)  
  - [Step 3: Run the Application Locally](#step-3-run-the-application-locally)  
- [Jenkins CI/CD Pipeline](#jenkins-cicd-pipeline)  
- [EC2 Deployment](#ec2-deployment)  
- [Future Enhancements](#future-enhancements)  
- [Contributing](#contributing)  
- [Contact](#contact)  

---

## Project Overview  
This project focuses on:  
1. Building a simple **Node.js web server**.  
2. **Containerizing** the application using Docker.  
3. Automating the **CI/CD workflow** with Jenkins.  
4. Deploying the container to an **EC2 instance** using SSH.

The application listens on port 3000 and responds with:  
`Hello, DevOps World from Node.js!`

---

## Technologies Used  
- **Node.js**: Application backend.  
- **Express.js**: Framework for building the web server.  
- **Docker**: Containerization platform.  
- **Jenkins**: CI/CD automation tool.  
- **EC2 (AWS)**: Cloud instance for deployment.  
- **GitHub**: Version control and repository hosting.  

---

## Prerequisites  
- Docker installed on your machine.  
- Jenkins server with the **Docker** and **SSH Agent** plugins.  
- GitHub repository for source code management.  
- AWS EC2 instance with Docker installed.  
- SSH key added to Jenkins and EC2 for remote access.  
- Docker Hub account for pushing images.  

---

## Project Setup  

### Step 1: Clone the Repository  
```bash
git clone https://github.com/KasthuDhiva/docker-node-app.git
cd docker-node-app
```

### Step 2: Build Docker Image  
To build the Docker image locally, run the following command:  
```bash
docker build -t docker-node-app:latest .
```
This command uses the **Dockerfile** in the root directory to create a new Docker image named `docker-node-app:latest`.

---

### Step 3: Run the Application Locally  
Run the following command to start the application inside a Docker container:  
```bash
docker run -d -p 3000:3000 docker-node-app:latest
```
You can access the application at:  
`http://localhost:3000`

---

## Jenkins CI/CD Pipeline  
This project uses **Jenkins** to automate the build, push, and deployment process. Below is the **Jenkinsfile** used:

```groovy
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
```

---

## EC2 Deployment  
The final stage of the Jenkins pipeline deploys the Docker container to an **AWS EC2 instance**.  

### EC2 Setup  
SSH into your EC2 instance and install Docker:  
```bash
sudo yum update -y
sudo yum install docker -y
sudo service docker start
```

### SSH Configuration  
- Add your SSH key to Jenkins with the credentials ID **`ec2-ssh-key`**.

### Docker Hub Credentials  
- Store your Docker Hub credentials in Jenkins under the ID **`dockerhub-credentials`**.

### Pipeline Execution  
Once the pipeline executes successfully, Jenkins will:  
1. Clone the repository.  
2. Build the Docker image.  
3. Push the image to Docker Hub.  
4. Deploy the image to the EC2 instance.

You can access the running application at:  
`http://<EC2-IP>:3000`

---

## Future Enhancements  
- **Kubernetes**: Use Kubernetes for container orchestration.  
- **CI/CD with GitHub Actions**: Add support for GitHub Actions or GitLab CI.  
- **Testing**: Integrate unit tests and automated testing pipelines.  
- **Nginx**: Use Nginx as a reverse proxy for enhanced scalability.  
- **Security**: Implement role-based access control (RBAC) for Jenkins pipelines.

---

## Contributing  
I welcome contributions! Please fork the repository and submit a pull request.

---

## Contact  
For any questions or issues, please reach out:  
**Kasthuri** - [GitHub](https://github.com/KasthuDhiva)
