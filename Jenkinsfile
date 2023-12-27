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
 script{
   if(params.Action == 'Destroy EKS cluster'){
        stages{
            stage('Terraform init'){
                steps{
                    script{
                        sh "terraform init"
                    }
                }
            }
            stage('Destroy'){
                steps{
                    script{
                        sh 'terraform destroy --auto-aprove'
                    }
                }
            }
        }
    }
    
    elseif(params.Action == 'Create EKS cluster'){
        stages {
            stage('Terraform init'){
                    steps{
                        script
                        {
                            sh "terraform init"
                        }
                    }
                }
            stage('Plan'){
                    steps{
                        script{
                            sh 'terraform plan -out tfplan'
                            sh 'terraform show -no-color tfplan > tfplan.txt'
                        }
                        }
                }

            stage('Apply'){
                    steps{
                        script{
                            sh 'terraform apply -input=false tfplan'
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
 }   
 

}