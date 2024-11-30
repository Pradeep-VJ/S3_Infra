pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = '<your-access-key>'
        AWS_SECRET_ACCESS_KEY = '<your-secret-key>'
        AWS_REGION = 'us-east-1'
    }
    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning GitHub Repository...'
                git branch: 'main', credentialsId: 'github-access', url: 'https://github.com/Pradeep-VJ/S3_Infra.git'
            }
        }
        stage('Terraform Init') {
            steps {
                echo 'Initializing Terraform...'
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                echo 'Planning Terraform Deployment...'
                sh 'terraform plan -var="owner=Pradeep_Reddy_B" -var="bucket_name=inbound_astra_files"'
            }
        }
        stage('Terraform Apply') {
            steps {
                echo 'Applying Terraform Plan...'
                sh 'terraform apply -var="owner=Pradeep_Reddy_B" -var="bucket_name=inbound_astra_files" -auto-approve'
            }
        }
    }
    post {
        success {
            echo 'Terraform Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}
