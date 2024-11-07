provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source         = "/home/lakshminarayanakt/terraform-ecs/modules/vpc"
  vpc_cidr       = "10.0.0.0/16"
  subnet1_cidr   = "10.0.1.0/24"
  subnet2_cidr   = "10.0.2.0/24"
  az1            = "us-east-1a"
  az2            = "us-east-1b"
  vpc_name       = "dev-vpc"
  environment    = "dev"

}

module "security_groups" {
  source = "/home/lakshminarayanakt/terraform-ecs/modules/security-group"
  vpc_id = module.vpc.vpc_id  # Assuming you have an output for vpc_id in your VPC module
  alb_sg_name = "dev-alb-security-group"  # Replace with your desired name
  ecs_sg_name = "dev-ecs-security-group"  # Replace with your desired name
}

module "ecs_task_definition" {
  source             = "/home/lakshminarayanakt/terraform-ecs/modules/ecs-task-definition"
  family             = "hq-sourcing-backend-td"
  execution_role_arn = "arn:aws:iam::992382425693:role/ecsTaskExecutionRole"  # Replace with the actual execution role ARN
  task_role_arn      = "arn:aws:iam::992382425693:role/ecsTaskExecutionRole"  # Replace with the actual task role ARN
  cpu                = 1024
  memory             = 3072

  container_definitions = [
    {
      name      = "hq-sourcing-backend-container"
      image     = "992382425693.dkr.ecr.us-east-1.amazonaws.com/hq-sourcing-backend:latest"
      cpu       = 1024
      memory    = 3072
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/hq-sourcing-backend-logs"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ]
}
module "ecs_cluster" {
 
 source = "/home/lakshminarayanakt/terraform-ecs/modules/ecs-cluster"
 cluster_name = "development-apps"
}

module "targetgroup" {
  source            = "/home/lakshminarayanakt/terraform-ecs/modules/target-group"
  target_group_name = "dev-backend-tg"
  port              = 80
  protocol          = "HTTP"
  target_type       = "ip"
  vpc_id            = module.vpc.vpc_id
}

module "loadbalancer" {
  source              = "/home/lakshminarayanakt/terraform-ecs/modules/loadbalancer"
  load_balancer_name  = "development-lb"
  security_groups     = [module.security_groups.alb_security_group_id]
  subnets             = [module.vpc.subnet1_id, module.vpc.subnet2_id] # Reference your VPC module
  certificate_arn     = "arn:aws:acm:us-east-1:788209399382:certificate/87907670-864f-433e-a5e6-81ac61b9ac55"
  target_group_arn    = module.targetgroup.target_group_arn
}

module "ecs_service" {
  source              = "/home/lakshminarayanakt/terraform-ecs/modules/ecs-service"
  service_name        = "dev-backend-service"
  launch_type         = "FARGATE"
  platform_version    = "LATEST"
  cluster_id          = module.ecs_cluster.cluster_id
  task_definition_arn = module.ecs_task_definition.task_definition_arn
  scheduling_strategy = "REPLICA"
  desired_count       = 2
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  target_group_arn    = module.targetgroup.target_group_arn
  container_name      = "hq-sourcing-backend-container"
  container_port      = 80
  assign_public_ip    = true
  security_groups     = [module.security_groups.ecs_security_group_id]
  subnets             = [module.vpc.subnet1_id, module.vpc.subnet2_id]
}

# main.tf

module "ecs_autoscaling" {
  source             = "/home/lakshminarayanakt/terraform-ecs/modules//auto-scaling-group"
  
  # Pass the missing arguments
  cluster_id         = module.ecs_cluster.cluster_id
  task_definition_arn = module.ecs_task_definition.task_definition_arn
  container_port     = 80  # Example, adjust based on your setup
  target_group_arn   = module.targetgroup.target_group_arn
  security_groups    = [module.security_groups.ecs_security_group_id]
  service_name       = module.ecs_service.service_id
  container_name     = "hq-sourcing-backend-container"  # Example, adjust as needed
  subnets            = [module.vpc.subnet1_id, module.vpc.subnet2_id]  # Example, replace with actual subnets

  # Auto-scaling configuration
  min_capacity       = 1
  max_capacity       = 5
  cpu_policy_name    = "CPU Scaling Policy"
  cpu_target_value   = 70
  scale_in_cooldown  = 300
  scale_out_cooldown = 300
  disable_scale_in   = false
}

