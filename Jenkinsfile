pipeline {
    agent any
    parameters{
        choice(name: 'Action', choices: ['Create EKS cluster', 'Destroy EKS cluster'], description: 'Select the action to perform')
    }
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    
    stages {
        stage('Terraform init'){
                steps{
                    sh "terraform init"
                }
            }
            stage('Plan'){
                steps{
                        sh 'terraform plan -out tfplan'
                        sh 'terraform show -no-color tfplan > tfplan.txt'
                    }
            }

            stage('Apply / Destroy'){
                steps{
                    script{
                        if (params.Action == 'Create EKS cluster'){
                            sh 'terraform apply -input=false tfplan'
                        }
                        else if(params.Action == 'Destroy EKS cluster'){
                            sh 'terraform destroy --auto-aprove'
                        }
                        else{
                            error "Invalid action selected. Please choose either 'Create EKS cluster' or 'Destroy EKS cluster'."
                        }
                    }
                }
            }
        stage("Deploy EKS") {
            steps {
                script {
                    dir('kubernetes') {
                        sh "aws eks update-kubeconfig --name eks-cluster"
                        sh "kubectl apply -f nginx-deployment.yaml"
                        sh "kubectl apply -f nginx-service.yaml"
                    }
                }
            }
        }
    }
}