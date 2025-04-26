pipeline {
  agent {
    kubernetes {
      label 'kaniko-agent'
      defaultContainer 'kaniko'
      yaml ''
    }
  }
  environment {
    AWS_REGION = 'us-east-1'
    ECR_REGISTRY = '913524928876.dkr.ecr.us-east-1.amazonaws.com'
    ECR_REPO_NAME = 'jenkins-test-repo'
    IMAGE_TAG = 'latest'
  }
  stages {
    stage('Clone Repo') {
      steps {
        git 'https://github.com/joshua1787/jenkins-test-pipeline.git'
      }
    }
    stage('Build and Push with Kaniko') {
      steps {
        sh '''
          /kaniko/executor \
            --context `pwd` \
            --dockerfile `pwd`/Dockerfile \
            --destination=${ECR_REGISTRY}/${ECR_REPO_NAME}:${IMAGE_TAG} \
            --insecure \
            --skip-tls-verify \
            --cache=false
        '''
      }
    }
  }
}
