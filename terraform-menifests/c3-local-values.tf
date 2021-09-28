# Define local values in Terraform

locals {
  owners = var.business_division
  environment = var.environment
  name = "${ var.business_division}-${var.environment}"
  # name = "${local.owners}-${local.environment}"  (we can also use this expression to fetch the same thing as above "name")
  common_tags = {
      owners = local.owners
      environment = local.environment
  }

  asg_tags = [
    {
      key                 = "Project"
      value              = "megasecret"
      propagate_at_launch = true
    },
    {
      key                 = "foo"
      value               = ""
      propagate_at_launch = true
    },
  ]
}