## Create Scheduled Actions

## Create Scheduled Action-1: Increase capacity during business hours (9am-7pm)
resource "aws_autoscaling_schedule" "increase_capacity_9am" {
  scheduled_action_name  = "increase-capacity-9am"
  min_size                 = 2
  max_size                = 10
  desired_capacity    = 5
  start_time               = "2021-12-11T09:00:00Z"
  recurrence              = "00 9 * * *"
  autoscaling_group_name =  aws_autoscaling_group.my_asg.id
}

## Create Scheduled Action-2: Decrease capacity during non-business hours (9pm-7am)
resource "aws_autoscaling_schedule" "decrease_capacity_9pm" {
  scheduled_action_name  = "decrease-capacity-9pm"
  min_size                 = 2
  max_size                = 10
  desired_capacity    = 2
  start_time               = "2021-12-12T21:00:00Z"
  recurrence              = "00 21 * * *"
  autoscaling_group_name =  aws_autoscaling_group.my_asg.id
}