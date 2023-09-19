resource "aws_launch_template" "this" {
  name          = "my-launch-template"
  image_id      = var.image_id
  instance_type = "t2.micro"
  iam_instance_profile {
    name = var.profile_name
  }
  vpc_security_group_ids = var.sg_ids
  user_data = base64encode(<<EOF
              !/bin/bash
              cd /home/ubuntu/NewsWave
              nohup python3 -m streamlit run App.py
              EOF
  )

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 10
      volume_type = "gp2"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Cloud-clan-EC2"
    }
  }
}

# Create the ASG
resource "aws_autoscaling_group" "this" {
  name = "my-asg"
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
  target_group_arns   = var.target_arn
  min_size            = 1
  max_size            = 3
  desired_capacity    = 1
  vpc_zone_identifier = var.vpc_subnet_ids

  tag {
    key                 = "Name"
    value               = "Cloud-clan-EC2"
    propagate_at_launch = true
  }
}