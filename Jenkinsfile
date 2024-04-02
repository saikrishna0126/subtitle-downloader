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
        stage('Sonar Analysis') {
            steps {
                script {
                     withSonarQubeEnv(credentialsId: 'sonar-token') {
                          sh """
                             ${SONAR_SCANNER_HOME}/bin/sonar-scanner \
                             -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                             -Dsonar.sources=src \
                             -Dsonar.host.url=${env.SONAR_SERVER_URL} \
                             -Dsonar.login=${env.SONAR_LOGIN}
                           """
                     }

                }
            }
        }
    }
