pipeline {
    agent any 
    
    // Define environment variables
    environment {
        // Sonarqube related variables
        SONAR_SCANNER_HOME = '/opt/sonar-scanner'
        SONAR_PROJECT_KEY = 'jenkins'
        // Harbor registry related variables
        HARBOR_URL = 'new-harbor2.duckdns.org/'
        HARBOR_REPOSITORY = 'projects'
        HARBOR_CREDENTIALS = credentials('harbor')
        // Docker related variables
        DOCKER_IMAGE = 'java' // Adjust according to your Docker image name
        DOCKER_IMAGE_TAG = 'demo' // Adjust according to your Docker image tag
    }
    
    // Define tools used in the pipeline
    tools {
        maven 'maven'
    }
    
    // Define stages of the pipeline
    stages {
        stage('Build the code') {
            steps {
                sh 'mvn clean package'
            }
            post {
                success {
                    slackSend color: '#36A64F', message: "Build Success - ${env.JOB_NAME} - ${env.BUILD_NUMBER}"
                }
                failure {
                    slackSend color: '#FF0000', message: "Build failed! - ${env.JOB_NAME} - ${env.BUILD_NUMBER}"
                }
            }
        }
        
        stage('Sonar Analysis') {
            steps {
                // Running SonarQube Scanner after Maven build
                withSonarQubeEnv(credentialsId: 'sonarqube', installationName:'sonarqube') {
                    sh """
                    ${SONAR_SCANNER_HOME}/bin/sonar-scanner \
                    -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                    -Dsonar.sources=src \
                    -Dsonar.host.url=${SONAR_SERVER_URL} \
                    -Dsonar.login=${SONAR_LOGIN}
                    """
                }
            }
            post {
                success {
                    slackSend color: '#36A64F', message: "Sonar-scan success - ${env.JOB_NAME} - ${env.BUILD_NUMBER}"
                }
                failure {
                    slackSend color: '#FF0000', message: "Sonar-scan failed! - ${env.JOB_NAME} - ${env.BUILD_NUMBER}"
                }
            }
        }
        
        stage('Docker build & push to harbor registry') {
            steps {
                script {
                    // Build Docker image
                    sh "docker build -t ${DOCKER_IMAGE} ."
                    // Login to Harbor registry
                    sh "docker login ${HARBOR_URL} -u ${HARBOR_USERNAME} -p ${HARBOR_PASSWORD}"
                    // Tag Docker image
                    sh "docker tag ${DOCKER_IMAGE}:${DOCKER_IMAGE_TAG} ${HARBOR_URL}/${HARBOR_REPOSITORY}/${DOCKER_IMAGE}:${DOCKER_IMAGE_TAG}"
                    // Push Docker image to Harbor registry
                    sh "docker push ${HARBOR_URL}/${HARBOR_REPOSITORY}/${DOCKER_IMAGE}:${DOCKER_IMAGE_TAG}"
                }
            }
            post {
                success {
                    slackSend color: '#36A64F', message: "Docker image successfully pushed to harbor registry - ${HARBOR_URL}/${HARBOR_REPOSITORY}/${DOCKER_IMAGE}:${DOCKER_IMAGE_TAG}"
                }
                failure {
                    slackSend color: '#FF0000', message: "Docker image build failed! - ${HARBOR_URL}/${HARBOR_REPOSITORY}/${DOCKER_IMAGE}:${DOCKER_IMAGE_TAG}"
                }
            }
        }
    }
}
