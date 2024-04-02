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
        }
        stage('Sonar Analysis') {
            steps {
                script {
                    // Running SonarQube Scanner after Maven build
                    withSonarQubeEnv(credentialsId: 'sonarqube') {
                        sh '''
                        ${SONAR_SCANNER_HOME}/bin/sonar-scanner \
                        -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                        -Dsonar.sources=src \
                        -Dsonar.host.url=${SONAR_SERVER_URL}
                        -Dsonar.login=${SONAR_LOGIN}
                        '''
                    }
                }
            }
        }
    }
}
