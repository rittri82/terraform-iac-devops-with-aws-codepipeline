#  Autoscaling Group Resource

resource "aws_autoscaling_group" "my_asg" {
  name_prefix = "${local.name}-"
  #desired_capacity = 2
  desired_capacity = 3
  max_size = 10
  #min_size = 2
  min_size = 3
  vpc_zone_identifier = module.vpc.private_subnets
  target_group_arns = module.alb.target_group_arns
  health_check_type = "EC2"
  launch_template {
    id = aws_launch_template.my_launch_template.id
    version = aws_launch_template.my_launch_template.latest_version
  }

  # Instance Refresh
instance_refresh {
    strategy = "Rolling"
    preferences {
      # instance_warmup = 300 # Default value is 300 and this is same as "health check grace period" arg if need to change default then only define else leave it
      min_healthy_percentage = 50
    }
    triggers = ["desired_capacity"]  # we can add more aruguments from ASG if required. If any change occur to desired capacity then autoscaling will spin up new instances and terminate the old ones
  }
  tag {
    key                 = "Owners"
    value               = "Web-Team"
    propagate_at_launch = true
  }
}