pipeline {
    agent any
    environment {
        AWS_REGION = 'us-east-1'
        ECR_REGISTRY = '913524928876.dkr.ecr.us-east-1.amazonaws.com'
        ECR_REPOSITORY = 'jenkins-test-repo'
        IMAGE_TAG = 'latest'
    }
    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/joshua1787/jenkins-test-pipeline.git'
            }
        }

        stage('Build and Push Image with Kaniko') {
            steps {
                script {
                    kubernetesDeploy(
                        configs: '', // no configs
                        kubeconfigId: '', // no kubeconfig needed
                        manifests: [
"""
apiVersion: v1
kind: Pod
metadata:
  name: kaniko-build-${BUILD_NUMBER}
  namespace: jenkins
spec:
  serviceAccountName: kaniko-serviceaccount
  restartPolicy: Never
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:latest
    args:
    - "--dockerfile=Dockerfile"
    - "--context=git://github.com/joshua1787/jenkins-test-pipeline.git#refs/heads/main"
    - "--destination=${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}"
    - "--insecure"
    - "--skip-tls-verify"
    env:
    - name: AWS_ACCESS_KEY_ID
      valueFrom:
        secretKeyRef:
          name: aws-credentials
          key: aws_access_key_id
    - name: AWS_SECRET_ACCESS_KEY
      valueFrom:
        secretKeyRef:
          name: aws-credentials
          key: aws_secret_access_key
"""
                        ]
                    )
                }
            }
        }
    }
}
