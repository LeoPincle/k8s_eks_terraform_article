terraform {
  backend "s3" {
    bucket = "k8s-eks-project"
    region = "us-east-1"
    key = "eks/terraform.tfstate"
  }
}