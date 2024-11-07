# Create an ECS task definition
resource "aws_ecs_task_definition" "TD" {
  family                   = var.family
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  container_definitions    = jsonencode(var.container_definitions)
}

# Data source to retrieve the ECS task definition details
data "aws_ecs_task_definition" "TD" {
  task_definition = aws_ecs_task_definition.TD.arn
}

