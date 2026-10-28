# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  vpc_id      = aws_vpc.main_vpc.id
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for App Servers
resource "aws_security_group" "app_sg" {
  name        = "app-server-sg"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Application Load Balancer
resource "aws_lb" "app_alb" {
  name               = "ecommerce-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public_subnets[*].id
}

# Target Group
resource "aws_lb_target_group" "app_tg" {
  name     = "ecommerce-app-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id
}

# Launch Template for ASG
resource "aws_launch_template" "app_lt" {
  name_prefix   = "app-server-"
  image_id      = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 (ap-south-1)
  instance_type = "t3.micro"
  
  network_interfaces {
    security_groups = [aws_security_group.app_sg.id]
  }
  
  user_data = base64encode(<<-EOF
              #!/bin/bash
              echo "Starting Web Server..."
              EOF
  )
}

# Auto Scaling Group
resource "aws_autoscaling_group" "app_asg" {
  vpc_zone_identifier = aws_subnet.private_app_subnets[*].id
  target_group_arns   = [aws_lb_target_group.app_tg.arn]
  min_size            = 2
  max_size            = 6
  desired_capacity    = 2

  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }
  }
