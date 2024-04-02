pipeline {
    agent any 
    environment {
        SONAR_SCANNER_HOME = '/opt/sonar-scanner'
        SONAR_PROJECT_KEY = 'jenkins'
    }
    tools {
        maven 'maven'
    }
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
                    slackSend color: '#FF0000', message: "Sonar-san failed! - ${env.JOB_NAME} - ${env.BUILD_NUMBER}"
                }
            }
        }
    }
}
