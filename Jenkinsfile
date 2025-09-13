pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                // Builds the Docker image using the Dockerfile in the repo
                sh 'docker build -t my-node-app:latest .'
            }
        }
        stage('Run Docker Container') {
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
            // Clean up old docker images to save space (using full path)
            sh '/usr/bin/docker image prune -f'
        }
    }
}
