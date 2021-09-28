# DNS Name Input Variable
variable "dns_name" {
  description = "DNS Name to support multiple environments"
  type = string
}
# DNS Registration
resource "aws_route53_record" "apps_dns" {
  zone_id = data.aws_route53_zone.mydomain.zone_id  # Zone ID of hosted zone
  name    = var.dns_name   
  type    = "A"
  alias {                                                                              
    name                   = module.alb.lb_dns_name   # ALB DNS Name
    zone_id                = module.alb.lb_zone_id       # ALB Zone ID  
    evaluate_target_health = true
  }
  
}