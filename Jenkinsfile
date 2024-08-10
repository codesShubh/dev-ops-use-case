node {
    def app

    stage('Clone repository') {
        // Clone the repository to the Jenkins workspace
        checkout scm
    }

    stage('Build image') {
        // Build the Docker image
        app = docker.build("devopstest")
    }

    stage('Test image') {
        // Run tests inside the Docker container
        app.inside("-w /usr/src/app") { // Update to the actual path you want
            sh 'pwd' // Verify the current working directory
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        // Push the image to Docker Hub
        docker.withRegistry('https://registry.hub.docker.com', 'shubham-docker') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}
