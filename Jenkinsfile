pipeline {
    agent {
        kubernetes {
            label 'kaniko-agent'
            defaultContainer 'kaniko'
            yaml """
apiVersion: v1
kind: Pod
spec:
  serviceAccountName: jenkins
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:latest
    command:
      - cat
    tty: true
"""
        }
    }
    environment {
        AWS_REGION = "us-east-1"
        AWS_ACCOUNT_ID = "913524928876"
        ECR_REPOSITORY = "jenkins-test-repo"
        IMAGE_TAG = "latest"
    }
    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/joshua1787/jenkins-test-pipeline.git'
            }
        }
        stage('Build and Push Image with Kaniko') {
            steps {
                sh """
                /kaniko/executor \
                  --dockerfile=Dockerfile \
                  --context=./ \
                  --destination=\${AWS_ACCOUNT_ID}.dkr.ecr.\${AWS_REGION}.amazonaws.com/\${ECR_REPOSITORY}:\${IMAGE_TAG} \
                  --insecure \
                  --skip-tls-verify
                """
            }
        }
    }
}
