pipeline {
    agent {
        docker {
            image 'docker:24.0.5'
            args '-v /var/run/docker.sock:/var/run/docker.sock -u root'
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
            sh 'docker image prune -f'
        }
    }
}
