pipeline {
    // Tell Jenkins to run this pipeline inside a Docker container
    agent {
        docker {
            image 'docker:24.0.5' // A specific, stable version of the Docker client image
            args '-v /var/run/docker.sock:/var/run/docker.sock' // Mount the host's Docker socket
        }
    }

    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t my-node-app:latest .'
            }
        }
        stage('Run Docker Container') {
            steps {
                sh 'docker stop my-app-container || true'
                sh 'docker rm my-app-container || true'
                sh 'docker run -d --name my-app-container -p 3000:3000 my-node-app:latest'
            }
        }
    }
    post {
        always {
            echo 'Pipeline finished.'
            // The docker command will now be available in the agent's PATH
            sh 'docker image prune -f'
        }
    }
}
