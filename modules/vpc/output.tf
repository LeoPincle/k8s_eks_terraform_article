output "vpc_id" {
  value = module.myapp-vpc.vpc_id
}

output "private_subnets" {
  value = module.myapp-vpc.private_subnets 
}