pipeline {
    agent any

    stages {
        stage('1. Checkout Code') {
            steps {
                // This command pulls the source code from your GitHub repo
                git 'https://github.com/chinmaydasarwar13-alt/devops-assignment.git'
            }
        }
        stage('2. Build Docker Image') {
            steps {
                // Builds the Docker image using the Dockerfile in the repo
                sh 'docker build -t my-node-app:latest .'
            }
        }
        stage('3. Run Docker Container') {
            steps {
                // Stops and removes any old container with the same name to avoid conflicts
                sh 'docker stop my-app-container || true'
                sh 'docker rm my-app-container || true'

                // Runs the new container
                sh 'docker run -d --name my-app-container -p 3000:3000 my-node-app:latest'
            }
        }
    }
    post {
        always {
            echo 'Pipeline finished.'
            // Clean up old docker images to save space
            sh 'docker image prune -f'
        }
    }
}