pipeline {
    agent any

    environment {
        REMOTE_HOST = 'localhost'
        DOCKER_IMAGE = 'my-app:latest'
        NOMBRE = 'midocker'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from GitHub...'
                git url: 'https://github.com/josebailon/b1.git', branch: 'main'
            }
        }

        stage('Build') {
            steps {
                echo 'Building the project with Maven inside Docker...'
                script {
                    docker.image('maven:3.8.3-openjdk-17').inside {
                        sh 'mvn clean package'
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    docker.build(env.DOCKER_IMAGE)
                }
            }
        }

        stage('Deploy to Remote Server') {
            steps {
                echo 'Deploying Docker container to remote server..'
                echo REMOTE_HOST
                echo 'Antes'
                echo 'REMOTE_SSH_CREDENTIALS_ID'
                echo env.DOCKER_IMAGE
                sshagent(['REMOTE_SSH_CREDENTIALS_ID']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@${REMOTE_HOST} '
                        docker rm -f ${env.NOMBRE}
                        docker run -d --name ${env.NOMBRE} -p 80:8080 ${env.DOCKER_IMAGE}
                    '
                    """
                }
                echo 'despued'
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed'
        }
    }
}
