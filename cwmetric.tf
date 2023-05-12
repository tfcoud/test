#Creating Cloud Watch alarm metrics for both autoscaling policies

resource "aws_cloudwatch_metric_alarm" "cwmetric_scaleup" {
  alarm_name                = "cloudwatch_metric_scaleup"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors ec2 cpu utilization to add more ec2 insatnces"
  insufficient_data_actions = []
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.orion_asg.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scaleup.arn]
}

resource "aws_cloudwatch_metric_alarm" "cwmetric_scaledown" {
  alarm_name                = "cloudwatch_metric_scaledown"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 10
  alarm_description         = "This metric monitors ec2 cpu utilization to delete ec2 insatnces"
  insufficient_data_actions = []
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.orion_asg.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scaledown.arn]
}
