# AWS EC2 Security Group Terraform Module
# Security Group for Private EC2 Instances

module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"

   name = "${local.name}-private-sg"
   description = "Security Group with SSH & HTTP port open for entire VPC and also all traffic allowed outbound"
   vpc_id = module.vpc.vpc_id

   # Ingress rules and CIDR blocks
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules       = ["ssh-tcp", "http-80-tcp", "http-8080-tcp"]

  # Egress Rule - all
  egress_rules       = ["all-all"]
  tags = local.common_tags
}

