# AWS EC2 Security Group Terraform Module
# Security Group for Public Bastion Host

module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"

   name = "${local.name}-public-bastion-sg"
   description = "Security Group with SSH port open for all internet inbound and also all traffic allowed outbound"
   vpc_id = module.vpc.vpc_id

   # Ingress rules and CIDR blocks
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]

  # Egress Rule - all
  egress_rules       = ["all-all"]
  tags = local.common_tags
}
