# Terraform AWS Application Load Balancer (ALB)

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "6.0.0"
  
  name = "${local.name}-alb"

  load_balancer_type = "application"

  vpc_id             = module.vpc.vpc_id
 /* subnets            = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1]
  ]
  */
  subnets = module.vpc.public_subnets        # We can also define subnets easily this way
  security_groups    = [module.loadbalancer_sg.security_group_id ]

# Define Listeners
# HTTP Listener - HTTP to HTTPS Redirect
 http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

# Define Target Groups

  target_groups = [
    # APP1 Target Group - TG Index = 0
    {
      name_prefix          = "app1-"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"

      /*# APP1 Target Information - Registered Targets - commented for auto-scalling

      targets = {
        my_app1_vm1 = {
          target_id = module.ec2_private_app1.id[0]
          port      = 80
        },
        my_app1_vm2 = {
          target_id = module.ec2_private_app1.id[1]
          port      = 80
        }
      }*/
      tags = local.common_tags  # APP1 Target Group tags
    }
  ]

  # HTTPS Listener
   https_listeners = [
     # HTTPS Listener Index = 0 for HTTPS 443
    {
       port               = 443
       protocol           = "HTTPS"
       certificate_arn    = module.acm.acm_certificate_arn
       action_type = "fixed-response"
       fixed_response = {
        content_type = "text/plain"
        status_code  = 200
        message_body = "Fixed Static Response - For Root Context" 
      }
    }
   ]

   # HTTPS Listener Rules
   https_listener_rules = [
     # Rule-1:  /app1* should go to App1 EC2 Instances  
    {
      https_listener_index = 0
      priority = 1
      actions = [
        {
          type = "forward"
          target_group_index = 0
        }
      ]
      conditions = [{
        path_patterns = ["/*"]
      }]
    }
  ]
  tags = local.common_tags # ALB Tags
}
