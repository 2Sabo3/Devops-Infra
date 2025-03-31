resource "aws_ecs_cluster" "ecs-cluster" {
    name = "terraform-cluster"
}

resource "aws_ecs_cluster_capacity_providers" "fargate" {
    cluster_name = aws_ecs_cluster.ecs-cluster.name

    capacity_providers = [ "FARGATE" ]

    default_capacity_provider_strategy {
      base = 1
      weight = 100
      capacity_provider = "FARGATE"
    }
}

resource "aws_ecs_service" "ecs_service" {
  name = "backend"
  cluster = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.tkdf.arn
  desired_count = 1
  launch_type = "FARGATE"
  network_configuration {
    subnets = aws_subnet.privatesubnet[*].id
    assign_public_ip = true
  }

}

resource "aws_ecs_task_definition" "tkdf" {
  family = "backend"
  requires_compatibilities = [ "FARGATE" ]
  network_mode = "awsvpc"
  cpu = 512
  memory = 1024
  execution_role_arn = "arn:aws:iam::637423269050:role/ecsTaskExecutionRole"
  container_definitions = jsonencode([
    {
        name      = "backend"
        image = "637423269050.dkr.ecr.us-east-1.amazonaws.com/backend_api:latest"
        cpu = 512
        memory = 1024
        essential = true
        portMappings = [
            {
                containerPort = 8080
                hostPort = 8080
            }
        ]
    }
  ])
}