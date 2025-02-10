terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.86.0"
    }
    spacelift = {
      source = "spacelift-io/spacelift"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # Adjust your region
}

resource "aws_ecs_cluster" "example" {
  name = "dashath"
}

resource "aws_ecs_task_definition" "example" {
  family                   = "example-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = "arn:aws:iam::992382549591:role/dashathECS1"  # Replace with your ECS execution role ARN

  container_definitions = jsonencode([{
    name      = "example-container"
    image     = "nginx:latest"  # Replace with your container image
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
  }])
}

resource "aws_lb_target_group" "example" {
  name     = "Dashathzuplonwaf"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-03a8dcf645971c427"  # Replace with your VPC ID
  target_type = "ip"  # Ensure this is set to 'ip' for Fargate

  health_check {
    path = "/"
    port = "traffic-port"
    protocol = "HTTP"
  }
}

resource "aws_ecs_service" "example" {
  name            = "example-service"
  cluster         = aws_ecs_cluster.example.id
  task_definition = aws_ecs_task_definition.example.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = ["subnet-0151691d92d049529"]  # Replace with your subnet IDs
    security_groups = ["sg-01a941b17c0f0895e"]  # Replace with your security group ID
    assign_public_ip = true
  }
  # Ensure the GitHub App has proper access to the repository.
}
