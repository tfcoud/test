#Creating Autoscaing policy Scale up and down

resource "aws_autoscaling_policy" "scaleup" {
  name                   = "autoscaling_policy_scaleup"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.orion_asg.name
  policy_type            = "SimpleScaling"
}

resource "aws_autoscaling_policy" "scaledown" {
  name                   = "autoscaling_policy_scaledown"
  scaling_adjustment     = "-1"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.orion_asg.name
  policy_type            = "SimpleScaling"
}
