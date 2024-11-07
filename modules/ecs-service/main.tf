resource "aws_ecs_service" "ECS_Service" {
  name                               = var.service_name
  launch_type                        = var.launch_type
  platform_version                   = var.platform_version
  cluster                            = var.cluster_id
  task_definition                    = var.task_definition_arn
  scheduling_strategy                = var.scheduling_strategy
  desired_count                      = var.desired_count
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_maximum_percent

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  network_configuration {
    assign_public_ip = var.assign_public_ip
    security_groups  = var.security_groups
    subnets          = var.subnets
  }
}

