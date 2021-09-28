# Security Group for Public Load Balancer

module "loadbalancer_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"

   name = "${local.name}-loadbalancer-sg"
   description = "Security Group with HTTP port open for all internet inbound and also all traffic allowed outbound"
   vpc_id = module.vpc.vpc_id

   # Ingress rules and CIDR blocks
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp" ]

  # Egress Rule - all
  egress_rules       = ["all-all"]
  tags = local.common_tags
}