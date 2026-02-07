module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "5.19.0"

    
    cidr = "10.0.0.0/16"
    azs = ["eu-west-1a", "eu-west-1b"]
    public_subnets = ["10.0.101.0/24","10.0.102.0/24"]

    enable_dns_support = true
    enable_dns_hostnames =  true
    enable_vpn_gateway = true

    tags = {
        name = "alfonso-vpc"
    }
}

module "terraform_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "https reglas"
  description = "Sg para alfonso"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [local.my_ip_cidr]

  ingress_rules = [
    "ssh-tcp",
    "https-443-tcp"
  ]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["https-443-tcp"]
}


