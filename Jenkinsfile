pipeline {
    agent any 
    environment {
        SONAR_SCANNER_HOME = '/opt/sonar-scanner' // Corrected path
        SONAR_PROJECT_KEY = 'jenkins'
    }
    tools {
        maven 'maven'
        // If SonarQube Scanner is not configured as a tool in Jenkins, remove the 'tools' block for 'sonarqube'
    }
    stages {
        stage('Build the code') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Sonar Analysis') {
            steps {
                script {
                    // Running SonarQube Scanner after Maven build
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                        sh """
                        ${SONAR_SCANNER_HOME}/bin/sonar-scanner \
                        -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                        -Dsonar.sources=src \
                        -Dsonar.host.url=${SONAR_SERVER_URL} \
                        -Dsonar.login=${SONAR_LOGIN}
                        """
                    }
                }
            }
        }
    }
}
