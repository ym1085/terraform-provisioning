locals {
  project_name = var.project_name
  env          = var.env
  az_count     = length(var.availability_zones)

  task_definition_container_flat = {
    for key, values in var.ecs_task_definitions : key => [
      for container in values.containers : {
        name   = "${container.name}-${container.env}"
        image  = "${container.image}-${container.env}:${container.version}"
        cpu    = container.cpu
        memory = container.memory

        portMappings = container.port != 0 ? [{
          containerPort = container.port
          hostPort      = container.port
          protocol      = container.protocol
        }] : []

        environment = [
          for env_key, env_value in container.env_variables : {
            name  = env_key
            value = env_value
          }
        ]

        mount_points = container.mount_points

        healthCheck = {
          command  = ["CMD-SHELL", container.health_check.command]
          interval = container.health_check.interval
          timeout  = container.health_check.timeout
          retries  = container.health_check.retries
        }
      }
    ]
  }
}
