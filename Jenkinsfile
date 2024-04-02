pipeline {
    agent any 
    environment {
        SONAR_SCANNER_HOME = '/opt/sonar-scanner' // Corrected path
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
        }
        stage('Sonar Analysis') {
            environment {
                SONAR_LOGIN = credentials('sonar-token') // Injecting the SonarQube token
            }
            steps {
                script {
                    // Running SonarQube Scanner after Maven build
                    withSonarQubeEnv(credentialsId: 'sonarqube') {
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
