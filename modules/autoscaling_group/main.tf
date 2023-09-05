resource "aws_launch_template" "launch_template" {
  name_prefix            = "${var.name_prefix}-launch-template"
  image_id               = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  user_data              = base64encode(var.user_data)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity           = var.desired_capacity
  max_size                   = var.max_size
  min_size                   = var.min_size
  vpc_zone_identifier        = var.private_subnet_ids
  target_group_arns          = var.target_group_arns
  health_check_type          = "EC2"  # Change health check type to EC2
  health_check_grace_period  = 300    # Set health check grace period to 300 seconds (5 minutes)

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-asg-instance"
    propagate_at_launch = true
  }

  // Add the following lifecycle configuration to prevent instance replacement on health check failure
  lifecycle {
    ignore_changes = [
      health_check_grace_period,
      min_size,
      max_size,
      desired_capacity
    ]
  }
}


resource "aws_autoscaling_policy" "cpu_scaling_policy" {
  name                   = "${var.name_prefix}-cpu-scaling-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value            = 90
  }
}
