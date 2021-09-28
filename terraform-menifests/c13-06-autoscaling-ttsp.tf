###### Target Tracking Scaling Policies ######
# Define Autoscaling Policies and Associate them to Autoscaling Group

## TTS - Scaling Policy-1: Based on CPU Utilization of EC2 Instances
resource "aws_autoscaling_policy" "avg_cpu_policy" {
  name                           = "${local.name}-avg-cpu-policy"
  policy_type                  = "TargetTrackingScaling"
  autoscaling_group_name =  aws_autoscaling_group.my_asg.id
  estimated_instance_warmup = 180
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}

## TTS - Scaling Policy-2: Based on ALB Target Requests - how many requests hit the autoscaling grp before it scales
resource "aws_autoscaling_policy" "alb_target_requests_policy" {
  name                           = "${local.name}-alb-target-requests-policy"
  policy_type                  = "TargetTrackingScaling"
  autoscaling_group_name =  aws_autoscaling_group.my_asg.id
  estimated_instance_warmup = 180
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label = "${module.alb.lb_arn_suffix}/${module.alb.target_group_arn_suffixes[0]}"
    }
    target_value = 10.0
  }
}


