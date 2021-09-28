# Launch configuration Outputs
output "launch_template_id" {
  description = "The ID of the launch template"
  value       = aws_launch_template.my_launch_template.id
}

output "launch_template_latest_version" {
  description = "Launch Template Latest Version"
  value       = aws_launch_template.my_launch_template.latest_version
}

# Autoscaling Outpus
output "autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = aws_autoscaling_group.my_asg.id
}

output "autoscaling_group_name" {
  description = "The autoscaling group name"
  value       =  aws_autoscaling_group.my_asg.name
}

output "autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = aws_autoscaling_group.my_asg.arn
}

