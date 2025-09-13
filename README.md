Prerequisites
You'll need two things installed to run this:

Git
Docker Desktop

How to Run It
1. Clone the Repo
First, get a local copy of the project files.

git clone https://github.com/chinmaydasarwar13-alt/devops-assignment.git
cd devops-assignment

2. Build the Jenkins Image
The official Jenkins image doesn't include the Docker CLI. This step builds a custom image that does, using the Dockerfile.jenkins recipe included here.

docker build -t my-custom-jenkins -f Dockerfile.jenkins .

3. Start the Jenkins Container
This command starts the Jenkins server in the background using the custom image you just built.

docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v /var/run/docker.sock:/var/run/docker.sock -v jenkins_home:/var/jenkins_home my-custom-jenkins

5. Initial Jenkins Setup
You only have to do this once. It involves unlocking Jenkins, installing plugins, and creating the pipeline job.

Get the Admin Password: Jenkins generates an initial password for security. Run this to find it:

docker logs jenkins
Complete the Setup Wizard: Go to http://localhost:8080. Paste the password, create your admin user, and select 'Install suggested plugins'.

Install the Docker Pipeline Plugin: After setup, go to Manage Jenkins > Plugins > Available. Search for and install Docker Pipeline.

Create the Pipeline Job:

On the dashboard, click "New Item".

Name it node-app-pipeline, select "Pipeline", and click OK.

Scroll down to the "Pipeline" section.

Change the Definition to "Pipeline script from SCM".

Select "Git" for the SCM.

Use this for the Repository URL: https://github.com/chinmaydasarwar13-alt/devops-assignment.git.

Ensure the Branch Specifier is */main.

Click Save.

Run the Build: Click "Build Now". This will execute the Jenkinsfile script, which builds the app's Docker image and starts the container.

5. Start the Nginx Proxy
The Jenkins pipeline starts the app container, but Nginx acts as the front door. This command starts the Nginx container and connects it to the app.

docker run -d --name my-nginx-proxy -p 80:80 -v ${PWD}/nginx.conf:/etc/nginx/nginx.conf nginx

6. Access the App
The entire stack is now running. You can access the application at:
http://localhost/myapp/

Cleaning Up
To stop and remove all the containers created by this project, run:

docker stop jenkins my-app-container my-nginx-proxy
docker rm jenkins my-app-container my-nginx-proxy
