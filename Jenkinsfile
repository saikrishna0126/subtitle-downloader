pipeline {
    agent any 
    environment {
        SONAR_SCANNER_HOME = '/opt/sonar-scanner' // Corrected path
        SONAR_PROJECT_KEY = 'jenkins'
    }
    tools {
        maven 'maven'
        sonarqube 'sonarqube'
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
                    withSonarQubeEnv(credentialsId: 'sonarqube', installationName: 'sonarqube') {
                        sh """
                        ${SONAR_SCANNER_HOME}/bin/sonar-scanner \
                         // mvn clean verify sonar:sonar \
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
