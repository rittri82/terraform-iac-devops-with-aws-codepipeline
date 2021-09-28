# Get DNS information from AWS Route53
data "aws_route53_zone" "mydomain" {
  name         = "businessappsite.link"
}

# Output MyDomain Zone ID

output "mydomain_zoneid" {
  description = "The Hosted Zone id of the desired Hosted Zone"
  value = data.aws_route53_zone.mydomain.zone_id
}

# Output MyDomain Name

output "mydomain_name" {
  description = "The Hosted Zone name of the desired Hosted Zone"
  value = data.aws_route53_zone.mydomain.name
}