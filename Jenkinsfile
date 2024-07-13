pipeline {
    agent any

    tools {
        maven 'Maven'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/GitGuru4DevOps-Venkatesh/sample-java-web-application.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
        stage('Nexus Artifact Upload') {
            steps {
                nexusArtifactUploader(
                    nexusVersion: 'nexus3',
                    protocol: 'http',
                    nexusUrl: '<nexus-url>',
                    groupId: 'com.example',
                    version: '1.0-SNAPSHOT',
                    repository: 'maven-releases',
                    credentialsId: 'nexus-credentials',
                    artifacts: [
                        [artifactId: 'sample-java-web-application', classifier: '', file: 'target/sample-java-web-application.war', type: 'war']
                    ]
                )
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("venkateshdocker1/sample-java-web-application:${env.BUILD_ID}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
                        dockerImage.push("${env.BUILD_ID}")
                        dockerImage.push("latest")
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                kubernetesDeploy(
                    configs: 'k8s/deployment.yaml',
                    kubeconfigId: 'kubeconfig'
                )
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}

