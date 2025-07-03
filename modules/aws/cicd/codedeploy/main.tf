# CodeDeploy Application 생성
resource "aws_codedeploy_app" "codedeploy_app" {
  for_each = var.codedeploy_app

  compute_platform = each.value.compute_platform # Compute 플랫폼 지정 (ECS, Lambda, Server)
  name             = each.value.name             # CodeDeploy Application명

  tags = merge(var.tags, {
    Name = "${each.value.name}-${each.value.env}"
  })
}

# CodeDeploy Application 배포 그룹 생성
resource "aws_codedeploy_deployment_group" "codedeploy_deployment_group" {
  for_each = var.codedeploy_deployment_group

  app_name               = aws_codedeploy_app.codedeploy_app[each.value.app_name].name # CodeDeploy Application명 지정
  deployment_group_name  = "${each.value.deployment_group_name}-${each.value.env}"     # 배포 그룹명
  deployment_config_name = each.value.deployment_config_name                           # 배포 그룹 방식 (CodeDeployDefault.ECSAllAtOnce)
  service_role_arn       = var.service_role_arn

  # 배포 실패 시 자동 롤백 설정
  auto_rollback_configuration {
    enabled = each.value.auto_rollback_configuration.enabled
    events  = [each.value.auto_rollback_configuration.events]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout    = each.value.blue_green_deployment_config.deployment_ready_option.action_on_timeout
      wait_time_in_minutes = each.value.blue_green_deployment_config.deployment_ready_option.wait_time_in_minutes
    }

    terminate_blue_instances_on_deployment_success {
      action                           = each.value.blue_green_deployment_config.terminate_blue_instances_on_deployment_success.action
      termination_wait_time_in_minutes = each.value.blue_green_deployment_config.terminate_blue_instances_on_deployment_success.termination_wait_time_in_minutes
    }
  }

  deployment_style {
    deployment_type   = each.value.deployment_style.deployment_type
    deployment_option = each.value.deployment_style.deployment_option
  }

  ecs_service {
    cluster_name = "${each.value.ecs_service.cluster_name}-${each.value.env}"
    service_name = "${each.value.ecs_service.service_name}-${each.value.env}"
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [var.alb_listener_arn[each.value.load_balancer_info.target_group_pair_info.prod_traffic_route.listener_arns]]
      }

      test_traffic_route {
        listener_arns = [var.alb_listener_arn[each.value.load_balancer_info.target_group_pair_info.test_traffic_route.listener_arns]]
      }

      dynamic "target_group" {
        for_each = each.value.load_balancer_info.target_group_pair_info.target_group
        content {
          name = "${target_group.value.name}-${each.value.env}"
        }
      }
    }
  }

  tags = merge(var.tags, {
    Name = "${each.value.deployment_group_name}-${each.value.env}"
  })
}

# CodeDeploy Application의 배포 구성 생성
resource "aws_codedeploy_deployment_config" "codedeploy_deployment_config" {
  for_each = var.codedeploy_deployment_config

  deployment_config_name = each.value.deployment_config_name
  compute_platform       = each.value.compute_platform

  traffic_routing_config {
    type = each.value.traffic_routing_config.type

    time_based_canary {
      interval   = each.value.traffic_routing_config.time_based_canary.interval
      percentage = each.value.traffic_routing_config.time_based_canary.percentage
    }
  }
}
