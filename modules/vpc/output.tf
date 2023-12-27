output "vpc_id" {
  value = module.k8s-vpc.vpc_id
}

output "private_subnets" {
  value = module.k8s-vpc.private_subnets 
}